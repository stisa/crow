import webgl

type ShaderKind* = enum
  Fragment, Vertex

type Shader* = object
  source: string
  s: WebglShader
  kind : ShaderKind
    
type Program* = object
  p: WebglProgram
  vertex, fragment: Shader
  colors: seq[WebglUniformLocation]
  attributes: seq[uint] # a list of attribute location

type GL* = WebglRenderingContext # shorthand

type Color* = tuple[r,g,b,a:float]

const
  Black* :Color = (r:0.0,g:0.0,b:0.0,a:1.0)
  Blue* : Color = (r:0.0,g:0.0,b:1.0,a:1.0)
  Red* : Color = (r:1.0,g:0.0,b:0.0,a:1.0)
  Green* : Color = (r:0.0,g:1.0,b:0.0,a:1.0)
  White* : Color = (r:1.0,g:1.0,b:1.0,a:1.0)

import sequtils, math
#import private/matrix,private/vector

export webgl.requestAnimationFrame

const VECSIZE :int = 4

converter extractProgram*(program: Program): WebglProgram = program.p
converter extractShader*(sh:Shader): WebglShader = sh.s

#converter toF32A*(m:Matrix):Float32Array = {.emit: "`result` = new Float32Array(`m`);\n".}

proc aspectRatio*(gl:GL):float =
  ## Returns the viewport aspect ratio ( width / height )
  result = gl.drawingBufferWidth/gl.drawingBufferHeight

proc clearWith*(gl:GL, color:Color) =
  ## Clear the context with color `color`
  gl.clearColor(color.r, color.g, color.b, color.a)
  gl.clear(COLOR_BUFFER_BIT)

proc shader*(gl:GL, typ:ShaderKind, src:string):Shader =
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

proc program*(gl:GL, useIt:bool=false ,vertex_src:string, fragment_src:string):Program =
  ## Init, compile and link a program.
  ## If `useIt` is true, also sets the program as current
  var program = gl.createProgram()
  let vs = gl.shader(Vertex, vertex_src) # vmsrc)
  let fs = gl.shader(Fragment, fragment_src) # fsrc)
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

proc bindVertices*(gl:GL, vertices:seq[float], drawMode:GLenum=StaticDraw) =
  ## Bind vertices to the context
  ## drawMode must be one of : # TODO: check this
  ## STATIC_DRAW: Contents of the buffer are likely to be used often and not change often. Contents are written to the buffer, but not read.
  ## DYNAMIC_DRAW: Contents of the buffer are likely to be used often and change often. Contents are written to the buffer, but not read.
  ## STREAM_DRAW: Contents of the buffer are likely to not be used often. Contents are written to the buffer, but not read.
  gl.bindBuffer(ARRAY_BUFFER, gl.createBuffer())
  gl.bufferData(ARRAY_BUFFER, vertices, drawMode)

proc bindColor*(gl:GL,program:Program,colorname:string,color:Color=Black) =
  let uloc = gl.getUniformLocation(program, colorname)
  gl.uniform4fv(uloc, @[color.r,color.g,color.b,color.a])

proc enableAttribute*(gl:GL,program:Program,attribname:string,itemSize:int=VECSIZE) =
  ## Enable the attribute `attribname` with `itemsize`
  let aloc = gl.getAttribLocation(program, attribname)
  gl.enableVertexAttribArray(aloc)
  gl.vertexAttribPointer(aloc, itemSize, FLOAT, false, 0, 0)

when ismainmodule:
  import windows

  let w = initwindow()
  w.ctx.clearwith(Green) 
