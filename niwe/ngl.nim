import webgl

type ShaderKind = enum
  Fragment, Vertex

type Shader = object
  source: string
  s: WebglShader
  kind : ShaderKind
    
type Program = object
  p: WebglProgram
  vertex, fragment: Shader
  colors: seq[WebglUniformLocation]
  attributes: seq[uint] # a list of attribute location

type GL = WebglRenderingContext # shorthand

type Color = tuple[r,g,b,a:float]

const
  Black* :Color = (r:0.0,g:0.0,b:0.0,a:1.0)
  Blue* : Color = (r:0.0,g:0.0,b:1.0,a:1.0)
  Red* : Color = (r:1.0,g:0.0,b:0.0,a:1.0)
  Green* : Color = (r:0.0,g:1.0,b:0.0,a:1.0)
  White* : Color = (r:1.0,g:1.0,b:1.0,a:1.0)

const vsrc = r"""
attribute vec2 aPosition
uniform vec2 uResolution

void main() {
  # convert the position from pixels to 0.0 to 1.0
  vec2 zeroToOne = aPosition / uResolution
  # convert from 0->1 to 0->2
  vec2 zeroToTwo = zeroToOne * 2.0
  # convert from 0->2 to -1->+1 (clipspace)
  vec2 clipSpace = zeroToTwo - 1.0
  gl_Position = vec4(clipSpace, 0, 1)
}
"""

const vmsrc = r"""
attribute vec4 aPosition;
uniform mat4 uMatrix;
void main() {
  gl_Position = uMatrix*aPosition;
}
"""

const fsrc = r"""
#ifdef GL_ES
  precision highp float;
#endif

uniform vec4 uColor;
void main() {
  gl_FragColor = uColor;
}
"""

import sequtils, math
import private/matrix,private/vector

export webgl.requestAnimationFrame

const VECSIZE :int = 4

converter extractProgram(program: Program): WebglProgram = program.p
converter extractShader(sh:Shader): WebglShader = sh.s

converter toF32A(m:Matrix):Float32Array = {.emit: "`result` = new Float32Array(`m`);\n".}

proc aspectRatio(gl:GL):float =
  ## Returns the viewport aspect ratio ( width / height )
  result = gl.drawingBufferWidth/gl.drawingBufferHeight

proc clearWith(gl:GL, color:Color) =
  ## Clear the context with color `color`
  gl.clearColor(color.r, color.g, color.b, color.a)
  gl.clear(COLOR_BUFFER_BIT)

proc shader(gl:GL, typ:ShaderType, src:string):Shader =
  ## Init and compile a shader
  if typ == Vertex:
    result.s = gl.createShader(Vertex_Shader)
  elif typ == Fragment:
    result.s = gl.createShader(Fragment_Shader)
  else: log "Unknown Shader Type"
  gl.shaderSource(result.s,src)
  gl.compileShader(result.s)
  if not gl.getStatus(result.s): log gl.getShaderInfoLog(result.s)
  result.kind = typ
  result.source = src

proc program(gl:GL, useIt:bool=false ,vertex_src:string=vsrc, fragment_src:string=fsrc):Program =
  ## Init, compile and link a program.
  ## If `useIt` is true, also sets the program as current
  var program = gl.createProgram()
  let vs = gl.shader(Vertex, vmsrc)
  let fs = gl.shader(Fragment, fsrc)
  gl.attachShader(program, vs.s)
  gl.attachShader(program, fs.s)
  gl.linkProgram(program)

  result.vertex = vs
  result.fragment = fs

  if not gl.getStatus(program): 
    log gl.getProgramInfoLog(program)
    return
  if useIt: gl.useProgram(program)
  result.p= program

proc bindVertices(gl:GL, vertices:seq[float], drawMode:GLenum=StaticDraw) =
  ## Bind vertices to the context
  ## drawMode must be one of : # TODO: check this
  ## STATIC_DRAW: Contents of the buffer are likely to be used often and not change often. Contents are written to the buffer, but not read.
  ## DYNAMIC_DRAW: Contents of the buffer are likely to be used often and change often. Contents are written to the buffer, but not read.
  ## STREAM_DRAW: Contents of the buffer are likely to not be used often. Contents are written to the buffer, but not read.
  gl.bindBuffer(ARRAY_BUFFER, gl.createBuffer())
  gl.bufferData(ARRAY_BUFFER, vertices, drawMode)

proc bindColor(gl:GL,program:Program,colorname:string,color:Color=Black) =
  let uloc = gl.getUniformLocation(program, colorname)
  gl.uniform4fv(uloc, @[color.r,color.g,color.b,color.a])

proc enableAttribute(gl:GL,program:Program,attribname:string,itemSize:int=VECSIZE) =
  ## Enable the attribute `attribname` with `itemsize`
  let aloc = gl.getAttribLocation(program, attribname)
  gl.enableVertexAttribArray(aloc)
  gl.vertexAttribPointer(aloc, itemSize, FLOAT, false, 0, 0)

type Engine* = object
  context:GL
  aspect*:float
  program: Program
  width*:int
  height*:int
  projMat: Matrix
  buff : WebGLBuffer
  # shaders: seq[WebGlShader]

proc initEngine*(id:string,clear:Color=White):Engine =
  result.context = getContextFromId("canvas")
  result.program = result.context.initProgram(true)
  result.aspect = result.context.aspectRatio
  result.context.clearWith(clear)
  result.width = result.context.drawingBufferWidth
  result.height = result.context.drawingBufferHeight
  result.projMat = projection(result.width.float,result.height.float)
  result.buff = result.context.createBuffer()

proc uploadVertices(eng:Engine, vertices:seq[float], drawMode:GLenum=StaticDraw) =
  ## Bind vertices to the context
  ## drawMode must be one of : # TODO: check this
  ## STATIC_DRAW: Contents of the buffer are likely to be used often and not change often. Contents are written to the buffer, but not read.
  ## DYNAMIC_DRAW: Contents of the buffer are likely to be used often and change often. Contents are written to the buffer, but not read.
  ## STREAM_DRAW: Contents of the buffer are likely to not be used often. Contents are written to the buffer, but not read.
  eng.context.bindBuffer(ARRAY_BUFFER, eng.buff)
  eng.context.bufferData(ARRAY_BUFFER, vertices, drawMode)
  eng.context.bindBuffer(ARRAY_BUFFER, eng.buff)


proc drawTriangles(eng:Engine,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw triangles
  eng.uploadVertices(vertices,drawMode)
  let numvertices = vertices.len div VECSIZE # 2 is hardcoded for now, it means each vertices has x,y
  eng.context.bindColor(eng.program, "uColor", color)
  #eng.context.setShaderRatio(eng.program, "uResolution")       
  eng.context.enableAttribute(eng.program, "aPosition")
  eng.context.drawArrays(TRIANGLES, 0, numvertices)
  eng.context.flush()

proc drawTriangleFan(eng:Engine,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw a fan of triangles
  eng.uploadVertices(vertices,drawMode)
  let numvertices = vertices.len div VECSIZE # 2 is hardcoded for now, it means each vertex has x,y
  eng.context.bindColor(eng.program, "uColor", color)
  #eng.context.setShaderRatio(eng.program, "uResolution")       
  eng.context.enableAttribute(eng.program, "aPosition") 
  eng.context.drawArrays(TRIANGLE_FAN, 0, numvertices)
  eng.context.flush()

proc drawLineLoop(eng:Engine,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw a closed loop of lines
  eng.uploadVertices(vertices,drawMode)
  let numvertices = vertices.len div VECSIZE # 2 is hardcoded for now, it means each vertex has x,y
  eng.context.bindColor(eng.program, "uColor", color)
  #eng.context.setShaderRatio(eng.program, "uResolution")       
  eng.context.enableAttribute(eng.program, "aPosition") 
  eng.context.drawArrays(LINE_LOOP, 0, numvertices)
  eng.context.flush()

type Renderable* = object of Rootobj # Todo: concepts?
  color*: Color
  pos*: tuple[x,y:float]
  scale*: float
  rot*: float 
  origin*: tuple[x,y:float]
  centered*: bool

type Rect* = object of Renderable
  ## A rectangle. For filled rectangles see box.
  size*: tuple[w,h:float]

type Box* = object of Renderable
  ## A filled rectangle
  size*: tuple[w,h:float]

type Circle* = object of Renderable
  ## A circle. For filled circles see disk.
  radius*: float

type Disk* = object of Renderable
  ## A filled circle.
  radius*: float

type Polygon* = object of Renderable
  ## A polygon. ``bcradius`` is the radius of the bounding circle.  
  ## If ``filled`` is true, then the polygon is filled (duh).
  sides*: int
  bcradius*:float
  filled*:bool

proc rect*(x,y:float=0.0,w,h:float=10.0,color:Color=Red,centered:bool=true):Rect =
  result.color = color
  result.pos = (x,y)
  result.size=(w,h)
  #result.origin = (-w/2,-h/2) # default to centered for consistency
  result.scale = 1.0
  result.centered =  centered

proc box*(x,y:float=0.0,w,h:float=10.0,color:Color=Red,centered:bool=true):Box =
  result.color = color
  result.pos = (x,y)
  #result.origin = (-w/2,-h/2)
  result.size=(w,h)
  result.scale = 1.0
  result.centered = centered

proc circle*(x,y:float=0.0,r:float=10.0,color:Color=Red):Circle =
  result.color = color
  result.pos = (x,y)
  result.radius = r 
  result.scale = 1.0

proc disk*(x,y:float=0.0,r:float=10.0,color:Color=Red):Disk =
  result.color = color
  result.pos = (x,y)
  result.radius = r 
  result.scale = 1.0

proc polygon*(x,y:float=0.0, sides:int=3,boundingcircleradius:float=10.0,filled:bool=false,color:Color=Red):Polygon=
  assert(sides>=3)
  result.color = color
  result.pos = (x,y)
  result.sides = sides
  result.bcradius = boundingcircleradius
  result.filled = filled
  result.scale = 1.0

proc setMatrixUnif(eng:Engine,rend:Renderable,uniform:string) =
  let mat = rotate(rend.rot)* # rotate
            translate(rend.origin.x,rend.origin.y)* # translate the origin
            translate(rend.pos.x,rend.pos.y)* # translate to position
            eng.projMat # Project in world coords

  let uMatLoc = eng.context.getUniformLocation(eng.program, uniform)

  eng.context.uniformMatrix4fv(uMatLoc,false,mat)


proc draw*(eng:Engine, rect:Box)=
  
  eng.setMatrixUnif(rect,"uMatrix")
  if rect.centered:
    let hw = rect.size.w/2
    let hh = rect.size.h/2
    eng.drawTriangles(
      @[
        -hw, -hh , 0.0, 1.0/rect.scale,
        hw, -hh, 0.0, 1.0/rect.scale,
        -hw, hh, 0.0, 1.0/rect.scale,
        -hw, hh , 0.0, 1.0/rect.scale,
        hw, hh, 0.0, 1.0/rect.scale,
        hw, -hh , 0.0, 1.0/rect.scale
      ],
    rect.color)
  else:
    eng.drawTriangles(
      @[
        0.0, 0.0 , 0.0, 1.0/rect.scale,
        rect.size.w, 0, 0.0, 1.0/rect.scale,
        rect.size.w, rect.size.h, 0.0, 1.0/rect.scale,
        rect.size.w, rect.size.h, 0.0, 1.0/rect.scale,
        0.0, rect.size.h, 0.0, 1.0/rect.scale,
        0.0, 0.0 , 0.0, 1.0/rect.scale
      ],
    rect.color)
proc draw*(eng:Engine, circle:Disk, roughness:int=32) =
  eng.setMatrixUnif(circle,"uMatrix")

  # 2 -> center(x,y), roughness * 4 are the two outer vertex of the trinagle
  var verts = newSeq[float](VECSIZE+roughness*VECSIZE*2)

  # Set the center
  verts[3] = 1/circle.scale
  #Set outer vertices
  for i in countup(4,verts.len-1,4) :
    verts[i] = circle.radius*cos( (i/4)*2*Pi/roughness.float)   # x
    verts[i+1] = circle.radius*sin( (i/4)*2*Pi/roughness.float) # y
    verts[i+2] = 0 # TODO:z
    verts[i+3] = 1/circle.scale # w
  eng.drawTriangleFan( verts, circle.color)


proc draw*(eng:Engine, circle:Circle, roughness:int=32) =
  eng.setMatrixUnif(circle,"uMatrix")

  var verts = newSeq[float](roughness*VECSIZE) # each line has x,y x1,y1, the last one is the first
  
  #Set outer vertices
  for i in countup(0,verts.len-1,4) :
    verts[i] = circle.radius*cos( i.float*Pi/(2*roughness.float))   # x
    verts[i+1] = circle.radius*sin( i.float*Pi/(2*roughness.float)) # y
    verts[i+2] = 0 # z
    verts[i+3] = 1/circle.scale # w
  
  eng.drawLineLoop( verts, circle.color)

proc draw*(eng:Engine, pol:Polygon) =
  eng.setMatrixUnif(pol,"uMatrix")
  
  if pol.filled:
    var verts = newSeq[float](VECSIZE+pol.sides*VECSIZE*2) # each line has x,y x1,y1, the last one is the first
    # Set the center
    verts[3] = 1/pol.scale

    #Set outer vertices
    for i in countup(4,verts.len-1,4) :
      verts[i] = pol.bcradius*cos( i.float*Pi/(2*pol.sides.float))   # x
      verts[i+1] = pol.bcradius*sin( i.float*Pi/(2*pol.sides.float)) # y
      verts[i+2] = 0 # z
      verts[i+3] = 1/pol.scale # w
      #log(verts[i],verts[i+1])
    eng.drawTriangleFan( verts, pol.color)
  else:
    var verts = newSeq[float](pol.sides*VECSIZE) # each line has x,y x1,y1, the last one is the first
    
    #Set outer vertices
    for i in countup(0,verts.len-1,4) :
      verts[i] = pol.bcradius*cos( i.float*Pi/(2*pol.sides.float))   # x
      verts[i+1] = pol.bcradius*sin( i.float*Pi/(2*pol.sides.float)) # y
      verts[i+2] = 0 # z
      verts[i+3] = 1/pol.scale # w
      #log(verts[i],verts[i+1])
    eng.drawLineLoop( verts, pol.color)
    
proc draw*(eng:Engine, rect:Rect)=
  eng.setMatrixUnif(rect,"uMatrix")
  if rect.centered:
    let hw = rect.size.w/2
    let hh = rect.size.h/2
    eng.drawTriangles(
      @[
        -hw, -hh , 0.0, 1.0/rect.scale,
        hw, -hh, 0.0, 1.0/rect.scale,
        -hw, hh, 0.0, 1.0/rect.scale,
        -hw, hh , 0.0, 1.0/rect.scale,
        hw, hh, 0.0, 1.0/rect.scale,
        hw, -hh , 0.0, 1.0/rect.scale
      ],
    rect.color)
  else:
    eng.drawTriangles(
      @[
        0.0, 0.0 , 0.0, 1.0/rect.scale,
        rect.size.w, 0, 0.0, 1.0/rect.scale,
        rect.size.w, rect.size.h, 0.0, 1.0/rect.scale,
        rect.size.w, rect.size.h, 0.0, 1.0/rect.scale,
        0.0, rect.size.h, 0.0, 1.0/rect.scale,
        0.0, 0.0 , 0.0, 1.0/rect.scale
      ],
    rect.color)

template batch*(eng:Engine, body:untyped):untyped =
  # begin a new drawing context with engine ( for now it just erases previous draws )
  eng.context.clearWith(Green)
  body

template frame*(body:untyped):untyped =
  ## Computes body each frame, the variable dt is exported and can be used.
  ## The timestep is NOT fixed (currently, will be in the future.)
  var last_t = 0.0
  var dt {.inject.} = 0.0 # inject allows using the dt symbol in the block, basically a limited {.dirty.}
  proc innerframedraw(now:float=0)=
    dt = now-last_t
    body
    last_t = now
    requestAnimationFrame(innerframedraw)
  innerframedraw()
  
proc `+=`(lf: var tuple[x:float,y:float],rg:tuple[x:float,y:float])=
  lf[0]+=rg[0]
  lf[1]+=rg[1]

when isMainModule and defined(js):
  import etch/events
  #http:#codeincomplete.com/posts/javascript-game-foundations-the-game-loop/
  var en = initEngine("canvas")

  var b = box(-100,0,100,100)
  appendFpsCounter()
  var speed = (0.0,0.0)
  var accel = (2.0,2.0)
  frame:
    updateFpsCounter(dt)
    en.draw(b)
    if evq.len>0:
      case evq.pop().charc:
      of 'w':
        speed+=(0.0,accel[1]*(dt/1000))
      of 'a':
        speed+=(-accel[0]*(dt/1000),0.0)
      of 's':
        speed+=(0.0,-accel[1]*(dt/1000))
      of 'd':
        speed+=(accel[0]*(dt/1000),0.0)
      of 'r':
        b.rot+=200*dt/1000
        speed = (0.0,0.0)
      else: discard
    b.pos+=speed
