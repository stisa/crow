import webgl except Color,Red,Black
import gl

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
import snail/[matrix,graphic]
 
export webgl.requestAnimationFrame

const VECSIZE :int = 4

converter toF32A(m:Matrix[4,4]):Float32Array = 
  var am = m.data[]
  {.emit: "`result` = new Float32Array(`am`);\n".}

type Renderer* = object
  context:GL
  program: Program
  buff : WebGLBuffer
  # shaders: seq[WebGlShader]

proc initRenderer*(gl:GL,clear:Color=White):Renderer =
  result.context = gl
  result.context.canvas.resize()
  result.program = result.context.program(true,vmsrc,fsrc)
  result.context.clearWith(clear)
  result.buff = result.context.createBuffer()
  gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight)

proc uploadVertices(eng:Renderer, vertices:seq[float], drawMode:GLenum=StaticDraw) =
  ## Bind vertices to the context
  ## drawMode must be one of : # TODO: check this
  ## STATIC_DRAW: Contents of the buffer are likely to be used often and not change often. Contents are written to the buffer, but not read.
  ## DYNAMIC_DRAW: Contents of the buffer are likely to be used often and change often. Contents are written to the buffer, but not read.
  ## STREAM_DRAW: Contents of the buffer are likely to not be used often. Contents are written to the buffer, but not read.
  eng.context.bindBuffer(ARRAY_BUFFER, eng.buff)
  eng.context.bufferData(ARRAY_BUFFER, vertices, drawMode)
  eng.context.bindBuffer(ARRAY_BUFFER, eng.buff)

proc drawTriangles(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw triangles
  eng.uploadVertices(vertices,drawMode)
  let numvertices = vertices.len div VECSIZE # 2 is hardcoded for now, it means each vertices has x,y
  eng.context.bindColor(eng.program, "uColor", color)
  eng.context.enableAttribute(eng.program, "aPosition")
  eng.context.drawArrays(TRIANGLES, 0, numvertices)
  eng.context.flush()

proc drawTriangleFan(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw a fan of triangles
  eng.uploadVertices(vertices,drawMode)
  let numvertices = vertices.len div VECSIZE # 2 is hardcoded for now, it means each vertex has x,y
  eng.context.bindColor(eng.program, "uColor", color)
  eng.context.enableAttribute(eng.program, "aPosition") 
  eng.context.drawArrays(TRIANGLE_FAN, 0, numvertices)
  eng.context.flush()

proc drawLineLoop(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw a closed loop of lines
  eng.uploadVertices(vertices,drawMode)
  let numvertices = vertices.len div VECSIZE # 2 is hardcoded for now, it means each vertex has x,y
  eng.context.bindColor(eng.program, "uColor", color)
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

type Polygon* = object of Renderable
  ## A polygon. ``bcradius`` is the radius of the bounding circle.  
  ## If ``filled`` is true, then the polygon is filled (duh).
  sides*: int
  bcradius*:float
  filled*:bool

proc polygon* (
    x,y:float=0.0,
    sides:int=3,
    boundingcircleradius:float=10.0,
    filled:bool=false,
    color:Color=Red
  ) : Polygon =
  
  doassert(sides>=3)
  result.color = color
  result.pos = (x,y)
  result.sides = sides
  result.bcradius = boundingcircleradius
  result.filled = filled
  result.scale = 1.0

proc setMatrixUnif(eng:Renderer,rend:Renderable,uniform:string) =
  let w = eng.context.drawingbufferwidth
  let h = eng.context.drawingbufferheight

  let projMat = projection(eng.context.drawingbufferwidth.float,eng.context.drawingbufferheight.float)
  let uMatLoc = eng.context.getUniformLocation(eng.program, uniform)

  let mat = translation(
             rend.pos.x,rend.pos.y)*
            translation(
             rend.origin.x,rend.origin.y)*
            translation(-w/2,-h/2)*
            scaling(w/2,h/2)
  eng.context.uniformMatrix4fv(uMatLoc,false,mat)

proc draw*(eng:Renderer, pol:Polygon) =
  eng.setMatrixUnif(pol,"uMatrix")
  
  if pol.filled:
    # each line has x,y x1,y1
    # the last one is the first
    var verts = newSeq[float](
                  2*VECSIZE+pol.sides*VECSIZE)    
    # Set the center
    verts[3] = 1/pol.scale

    #Set outer vertices
    for i in countup(4,verts.len-1,4) :
      verts[i] = pol.bcradius*
                 cos( i.float*Pi/(pol.sides.float*2))   # x
      verts[i+1] = pol.bcradius*
                   sin( i.float*Pi/(pol.sides.float*2)) # y
      verts[i+2] = 0 # z
      verts[i+3] = 1/pol.scale # w
    
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

template batch*(eng:Renderer, body:untyped):untyped =
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
  import events,windows
  #http:#codeincomplete.com/posts/javascript-game-foundations-the-game-loop/
  var evq = initEvents()
  var w = initWindow()
  var en = initRenderer(w.ctx)
  
  var speed = (0.0,0.0)
  var accel = (2.0,2.0)
 
  var b = polygon(100,100,4,100,filled=true)
  evq.on("mouseEv", 
    proc (e:EventArgs)=
      speed += accel)
  evq.on("update", 
    proc (e:EventArgs)=
      b.pos += speed)

  frame:
    evq.emit("update",EventArgs(dt:dt))
    en.context.canvas.resize()
    en.context.viewport(0, 0, en.context.drawingBufferWidth, en.context.drawingBufferHeight)
    en.draw(b)
