when defined js:
  import webgl except flush
elif not defined android:
  import opengl

when defined js:
  type ShaderKind* = enum
    skNone,
    skFragment = seFragment_Shader,
    skVertex = seVertex_Shader
else:
  type ShaderKind* = enum
    skNone, # FIXME: uninitialized warning
    skFragment = GL_FRAGMENT_SHADER,
    skVertex = GL_VERTEX_SHADER

when defined js:
  type BufferKind* = enum
    bkNone,
    bkArray = beARRAY_BUFFER,
    bkElement = beElement_ARRAY_BUFFER    
else:
  type BufferKind* = enum
    bkNone, # FIXME: uninitialized warning
    bkArray = GL_ARRAY_BUFFER
    bkElement = GL_ELEMENT_ARRAY_BUFFER    

when defined js:
  type DrawMode* = enum
    dmNone,
    dmStatic = beStaticDraw,
    dmDynamic = beDynamicDraw
else:
  type DrawMode* = enum
    dmNone,
    dmStatic = GL_STATIC_DRAW,
    dmDynamic = GL_DYNAMIC_DRAW

when defined js:
  type DataKind* = enum
    dkNone
    dkByte = dtBYTE   
    dkUByte = dtUNSIGNED_BYTE
    dkShort = dtSHORT   
    dkUShort = dtUNSIGNED_SHORT
    dkInt = dtINT
    dkUInt = dtUNSIGNED_INT
    dkFloat = dtFLOAT
else:
  type DataKind* = enum
    dkNone
    dkByte = cGL_BYTE   
    dkUByte = GL_UNSIGNED_BYTE
    dkShort = cGL_SHORT   
    dkUShort = GL_UNSIGNED_SHORT
    dkInt = cGL_INT
    dkUInt = GL_UNSIGNED_INT
    dkFloat = cGL_FLOAT

when defined js:
  type PrimitiveKind* = enum    
    pkPoints = pmPoints
    pkLines = pmLines
    pkLineLoop = pmLineLoop
    pkLineStrip = pmLineStrip 
    pkTriangles = pmTriangles
    pkTriangleStrip = pmTriangleStrip
    pkTriangleFan = pmTriangleFan
else:
  type PrimitiveKind* = enum  
    pkPoints = GL_POINTS
    pkLines = GL_LINES
    pkLineLoop = GL_LINE_LOOP
    pkLineStrip = GL_LINE_STRIP 
    pkTriangles = GL_TRIANGLES
    pkTriangleStrip = GL_TRIANGLE_STRIP
    pkTriangleFan = GL_TRIANGLE_FAN
type
  Shader* = object
    source: string
    kind : ShaderKind
    when defined js:
      s: WebglShader
    elif not defined android:
      s:GLuint
    else:
      discard

  Program* = object
    vertex, fragment: Shader
    when defined js:
      p: WebglProgram
    elif not defined android:
      p: GLuint
    else:
      discard
  
  Buffer* = object
    when defined js:
      b:WebglBuffer
    else:
      b:GLuint

when defined js:
  type UniformLocation* = WebglUniformLocation
else:
  type UniformLocation* = GLint

when defined js:
  type AttribLocation* = uint
else:
  type AttribLocation* = GLuint

when defined js:
  type ContextGL* = WebglRenderingContext # shorthand
elif not defined android:
  type ContextGL* = object

type Color = concept c
  c.r is float or c.r is float32
  c.g is float or c.g is float32
  c.b is float or c.b is float32
  c.a is float or c.a is float32

when defined js:
  proc toJSA*(v:openarray[float32]) :Float32Array {.importcpp: "new Float32Array(#)".} # might be a lie
  proc toJSA*(v:openarray[float]) :Float32Array {.importcpp: "new Float32Array(#)".} # might be a lie
  proc toJSA*(v:openarray[uint16]) :Uint16Array {.importcpp: "new Uint16Array(#)".} # might be a lie
  proc toJSA*(v:openarray[int32]) :Int32Array {.importcpp: "new Uint16Array(#)".} # might be a lie
  proc toJSA*(v:openarray[int]) :Int32Array {.importcpp: "new Int32Array(#)".} # might be a lie


const VecSize  {.intdefine.} : int = 4

proc viewport*(gl:ContextGL,x=0,y=0, w,h:int) =
  when defined js:
    webgl.viewport(gl, x,y, w,h)
  else:
    glViewport(x.GLint,y.GLint,w.GLsizei,h.GLsizei)

proc aspectRatio*(gl:ContextGL):float =
  ## Returns the viewport aspect ratio ( width / height )
  when defined js:
    result = gl.drawingBufferWidth/gl.drawingBufferHeight

proc clearColor*(gl:ContextGL, r,g,b,a:float) =
  ## Set clear color
  when defined js:
    webgl.clearColor(gl, r, g, b, a)
  elif not defined android:
    glClearColor(r, g, b, a)
proc clearColor*(gl:ContextGL, c:Color) = gl.clearColor(c.r,c.g,c.b,c.a)

proc clear*(gl:ContextGL, color=true,depth:bool=false) =
  when defined js:
    if color and depth:
      webgl.clear(gl, ord(bbColor) or ord(bbDepth))
    elif color:
      webgl.clear(gl,bbColor)
    elif depth:
      webgl.clear(gl,bbDepth)
  else:
    if color and depth:
      glclear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)
    elif color:
      glclear(GL_COLOR_BUFFER_BIT)
    elif depth:
      glclear(GL_DEPTH_BUFFER_BIT)

proc createShader*(gl:ContextGL, kind:ShaderKind, src:string):Shader =
  ## Init and compile a shader
  result.kind = kind
  result.source = src
  when defined js:
    result.s = webgl.createShader(gl, kind.ShaderEnum)
    webgl.shaderSource(gl, result.s,src)
    webgl.compileShader(gl, result.s)
    if not webgl.getStatus(gl, result.s): doassert(false,$webgl.getShaderInfoLog(gl, result.s))
  
  elif not defined android:
  
    result.s  = glCreateShader(GLenum(kind))
    glShaderSource(result.s, 1, [src].allocCStringArray, nil)
    glCompileShader(result.s)

    var status: GLint

    glGetShaderiv(result.s, GL_COMPILE_STATUS, addr status)

    if status == GL_FALSE.int:
      var logLength: GLint
      glGetShaderiv(result.s, GL_INFO_LOG_LENGTH, addr logLength)

      var errorLog: cstring = cast[cstring](alloc(logLength))
      glGetShaderInfoLog(result.s, logLength, addr logLength, errorLog)
      echo(errorLog)

proc createProgram*(gl:ContextGL, useIt:bool=false ,vertex_src:string, fragment_src:string):Program =
  ## Init, compile and link a program.
  ## If `useIt` is true, also sets the program as current
  let 
    vs = gl.createShader(skVertex, vertex_src) # vmsrc)
    fs = gl.createShader(skFragment, fragment_src) # fsrc)
  result.vertex = vs
  result.fragment = fs

  when defined js:
    var program = webgl.createProgram(gl)
    webgl.attachShader(gl,program, vs.s)
    webgl.attachShader(gl,program, fs.s)
    webgl.linkProgram(gl,program)
    if not webgl.getStatus(gl,program): 
      doassert(false, $webgl.getProgramInfoLog(gl,program))
    if useIt: webgl.useProgram(gl,program)
  elif not defined android:
    var program = glCreateProgram()
    glAttachShader(program, vs.s)
    glAttachShader(program, fs.s)
    # mmh glBindFragDataLocation(program, 0, "outColor")
    glLinkProgram(program)
    var status: GLint
    glGetProgramiv(program, GL_LINK_STATUS, addr status)
    if status == GL_FALSE.int:
      var logLength: GLint
      glGetProgramiv(program, GL_INFO_LOG_LENGTH, addr logLength)
      var errorLog: cstring = cast[cstring](alloc(logLength))
      glGetProgramInfoLog(program, logLength, addr logLength, errorLog)
      echo(errorLog)
    if useit:
      glUseProgram(program)
  
  result.p = program

proc createBuffer*(gl:ContextGL):Buffer =
  when defined js:
    result.b = webgl.createBuffer(gl)
  else:
    glGenBuffers(1,addr result.b)

proc bindBuffer*(gl:ContextGL,kind:BufferKind, buffer:Buffer) =
  when defined js:
    webgl.bindBuffer(gl, kind.BufferEnum,buffer.b)
  else:
    glBindBuffer(GLenum(kind),buffer.b)

proc bufferData*(gl:ContextGL, kind:BufferKind, data:openArray[SomeNumber],usage:DrawMode) =
  when defined js:
    webgl.bufferData(gl, BufferEnum(kind), data.toJSA,BufferEnum(usage))
  else:
    glBufferData(GLenum(kind), sizeof(data[0])*data.len, unsafeAddr data, GLenum(usage))

proc bindVertices*(gl:ContextGL, vertices:openarray[float], drawMode:DrawMode=dmStatic) =
  ## Bind vertices to the context
  ## drawMode must be one of : # TODO: check this
  ## STATIC_DRAW: Contents of the buffer are likely to be used often and not change often. Contents are written to the buffer, but not read.
  ## DYNAMIC_DRAW: Contents of the buffer are likely to be used often and change often. Contents are written to the buffer, but not read.
  ## STREAM_DRAW: Contents of the buffer are likely to not be used often. Contents are written to the buffer, but not read.
  gl.bindBuffer(bkArray, gl.createBuffer())
  gl.bufferData(bkArray, vertices, drawMode)

proc getUniformLocation*(gl: ContextGL, program: Program, name: string): UniformLocation =  
  when defined js:
    webgl.getUniformLocation(gl, program.p, name.cstring)
  else:
    glGetUniformLocation(program.p, name.cstring)

proc uniform4fv*(gl:ContextGL, loc:UniformLocation, val:openarray[float|float32]) =
  when defined js:
    webgl.uniform4fv(gl, loc,val.toJSA)
  else:
    glUniform4fv(GLInt(loc), GLSizei(1), cast[ptr GLfloat](unsafeAddr(val)))

proc uniformMatrix4fv*(gl:ContextGL, loc:UniformLocation,transp:bool, val:openarray[float|float32]) =
  when defined js:
    webgl.uniformMatrix4fv(gl, loc,transp,val.toJSA)
  else:
    glUniformMatrix4fv(GLInt(loc), 1, transp , cast[ptr GLfloat](unsafeAddr(val[0])))

proc bindColor*(gl:ContextGL,program:Program,colorname:string,color:Color) =
  let uloc = gl.getUniformLocation(program, colorname)
  gl.uniform4fv(uloc, @[color.r,color.g,color.b,color.a])

proc getAttribLocation*(gl: ContextGL, program: Program, name: string): AttribLocation =  
  when defined js:
    webgl.getAttribLocation(gl, program.p, name.cstring)
  else:
    let unchckresult = glGetAttribLocation(program.p, name.cstring)
    doassert(unchckresult>=0, "getAttribLocation:" & $name & "not found")
    result = unchckresult.GLuint

proc enableVertexAttribArray*(gl: ContextGL, attr: AttribLocation) =  
  when defined js:
    webgl.enableVertexAttribArray(gl,attr)
  else:
    glEnableVertexAttribArray(attr)

proc vertexAttribPointer*(gl:ContextGL,index:AttribLocation, size:int, typ: DataKind,
  normalized: bool, stride: int, offset: int64) =
  when defined js:
    webgl.vertexAttribPointer(gl, index, size, typ.DataType, normalized, stride, offset)
  else:
    glVertexAttribPointer(index, size.GLint, typ.GLenum, normalized.GLboolean, 
      stride.GLSizei, cast[pointer](offset))

proc enableAttribute*(gl:ContextGL,program:Program,attribname:string,itemSize:int=VECSIZE) =
  ## Enable the attribute `attribname` with `itemsize`
  let aloc = gl.getAttribLocation(program, attribname)
  gl.enableVertexAttribArray(aloc)
  gl.vertexAttribPointer(aloc, itemSize, dkFloat, false, 0, 0)

proc uploadVertices*(gl:ContextGL, buff:Buffer, vertices:seq[float], drawMode:DrawMode=dmStatic) =
  ## Bind vertices to the context
  ## drawMode must be one of : # TODO: check this
  ## STATIC_DRAW: Contents of the buffer are likely to be used often and not change often. Contents are written to the buffer, but not read.
  ## DYNAMIC_DRAW: Contents of the buffer are likely to be used often and change often. Contents are written to the buffer, but not read.
  ## STREAM_DRAW: Contents of the buffer are likely to not be used often. Contents are written to the buffer, but not read.
  gl.bindBuffer(bkArray, buff)
  gl.bufferData(bkArray, vertices, drawMode)
  gl.bindBuffer(bkArray, buff)

proc drawArrays*(gl:ContextGL, mode:PrimitiveKind, first:int, count:int) =
  when defined js:
    webgl.drawArrays(gl, mode.PrimitiveMode,first,count)
  else:
    glDrawArrays(mode.GLenum, first.GLint, count.GLsizei)

proc drawElements*(gl:ContextGL, mode:PrimitiveKind, count:int, kind:DataKind,offset: int64) =
  doAssert( kind in {dkUByte, dkUShort, dkUInt} )
  when defined js:
    webgl.drawElements(gl, mode.PrimitiveMode,count, kind.DataType, offset)
  else:
    glDrawElements(mode.GLenum, count.GLsizei, kind.GLenum, cast[pointer](offset))

proc flush*(gl:ContextGL) =
  when defined js:
    webgl.flush(gl)
  else:
    glFlush()

proc drawTriangles*(gl:ContextGL,buff:Buffer,p:Program,vertices:seq[float], color:Color,drawMode:DrawMode=dmStatic) =
  ## Draw triangles
  gl.uploadVertices(buff,vertices,drawMode)
  let numvertices = vertices.len div 4 # 4 is hardcoded for now, it means each vertices has x,y,z,scale
  gl.bindColor(p, "uColor", color)
  gl.enableAttribute(p, "aPosition")
  gl.drawArrays(pkTRIANGLES, 0, numvertices)
  ngl.flush(gl)

proc drawTriangleFan*(gl:ContextGL,buff:Buffer,p:Program,vertices:seq[float], color:Color,drawMode:DrawMode=dmStatic) =
  ## Draw a fan of triangles
  gl.uploadVertices(buff,vertices,drawMode)
  let numvertices = vertices.len div 4 # 4 is hardcoded for now, it means each vertices has x,y,z,scale
  gl.bindColor(p, "uColor", color)
  gl.enableAttribute(p, "aPosition")
  gl.drawArrays(pkTRIANGLE_FAN, 0, numvertices)
  gl.flush()

proc drawLineLoop*(gl:ContextGL,buff:Buffer,p:Program,vertices:seq[float], color:Color,drawMode:DrawMode=dmStatic) =
  ## Draw a closed loop of lines
  gl.uploadVertices(buff,vertices,drawMode)
  let numvertices = vertices.len div 4 # 4 is hardcoded for now, it means each vertices has x,y,z,scale
  gl.bindColor(p, "uColor", color)
  gl.enableAttribute(p, "aPosition")
  gl.drawArrays(pkLineLoop, 0, numvertices)
  gl.flush()
