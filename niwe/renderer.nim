import gl, snail/[matrix,graphic]

from math import cos,sin,Pi

from webgl import WebglBuffer,Canvas,resize,Glenum,StaticDraw # TODO: move these out to gl, abstract 'em all

const VECSIZE = 4

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

proc uploadVertices(eng:Renderer, vertices:seq[float], drawMode:GLenum=StaticDraw){.inline} =
  ## Bind vertices to the context
  eng.context.uploadvertices(eng.buff,vertices,drawmode)

proc drawTriangles(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw triangles
  eng.context.drawtriangles(eng.buff,eng.program,vertices,color,drawmode)
  
proc drawTriangleFan(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw a fan of triangles
  eng.context.drawtrianglefan(eng.buff,eng.program,vertices,color,drawmode)

proc drawLineLoop(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:GLenum=StaticDraw) =
  ## Draw a closed loop of lines
  eng.context.drawlineloop(eng.buff,eng.program,vertices,color,drawmode)

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

proc rect*(
    x,y:float=0.0,
    w,h:float=10.0,
    color:Color=Red,
    centered:bool=true
  ):Rect =
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

  let uMatLoc = eng.context.getUniformLocation(eng.program, uniform)

  let mat = translation(
             rend.pos.x,rend.pos.y)*
            translation(
             rend.origin.x,rend.origin.y)*
            translation(-w/2,-h/2)*
            scaling(w/2,h/2)
  eng.context.uniformMatrix4fv(uMatLoc,false,mat)

proc draw*(eng:Renderer, rect:Rect)=
  eng.setMatrixUnif(rect,"uMatrix")
  if rect.centered:
    let hw = rect.size.w/2
    let hh = rect.size.h/2
    eng.drawLineloop(
      @[
        -hw, -hh , 0.0, 1.0/rect.scale,
        hw, -hh, 0.0, 1.0/rect.scale,
        hw, hh, 0.0, 1.0/rect.scale,
        -hw, hh, 0.0, 1.0/rect.scale,
      ],
    rect.color)
  else:
    eng.drawlineloop(
      @[
        0.0, 0.0 , 0.0, 1.0/rect.scale,
        rect.size.w, 0, 0.0, 1.0/rect.scale,
        rect.size.w, rect.size.h, 0.0, 1.0/rect.scale,
        0.0, rect.size.h, 0.0, 1.0/rect.scale,
      ],
    rect.color)

proc draw*(eng:Renderer, rect:Box)=
  
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

proc draw*(eng:Renderer, circle:Disk, roughness:int=32) =
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


proc draw*(eng:Renderer, circle:Circle, roughness:int=32) =
  eng.setMatrixUnif(circle,"uMatrix")

  var verts = newSeq[float](roughness*VECSIZE) # each line has x,y x1,y1, the last one is the first
  
  #Set outer vertices
  for i in countup(0,verts.len-1,4) :
    verts[i] = circle.radius*cos( i.float*Pi/(2*roughness.float))   # x
    verts[i+1] = circle.radius*sin( i.float*Pi/(2*roughness.float)) # y
    verts[i+2] = 0 # z
    verts[i+3] = 1/circle.scale # w
  
  eng.drawLineLoop( verts, circle.color)

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
  
proc `+=`*(lf: var tuple[x:float,y:float],rg:tuple[x:float,y:float])=
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
 
  var p = polygon(100,100,5,10,filled=true,color=Green)
  var r = rect(200,200)
  var c = circle(50,50)
  var d = disk(150,150)
  var b = box(250,250)
  evq.on("mouseEv", 
    proc (e:EventArgs)=
      speed += accel)
  evq.on("update", 
    proc (e:EventArgs)=
      p.pos += speed)

  frame:
    evq.emit("update",EventArgs(dt:dt))
    en.context.canvas.resize()
    en.context.viewport(0, 0, en.context.drawingBufferWidth, en.context.drawingBufferHeight)
    en.draw(b)
    en.draw(c)
    en.draw(d)
    en.draw(p)
    en.draw(r)
