from math import cos,sin,Pi

import snail/[matrix,graphic]

import ../core/sharedgl, colors, primitives

const VECSIZE = 4

const vmsrc =  """
attribute vec4 aPosition;
uniform mat4 uMatrix;
void main() {
  gl_Position = uMatrix*aPosition;
}
"""

const fsrc = """
#ifdef GL_ES
  precision highp float;
#endif

uniform vec4 uColor;
void main() {
  gl_FragColor = uColor;
}
"""

type Batcher* = object
  r*: seq[Rect]
  c*: seq[Circle]
  p*: seq[Polygon]

proc batcher*():Batcher= 
  Batcher(r: newSeq[Rect](),
          c: newSeq[Circle](),
          p: newSeq[Polygon]())

proc add*[K](b:var Batcher,rend:K)=
  when rend is Rect:
    b.r.add(rend)
  elif rend is Circle:
    b.c.add(rend)
  elif rend is Polygon:
    b.p.add(rend)
  else: echo "unknown render primitive"


type Renderer* = object
  context: ContextGL
  program: Program
  buff : Buffer
  size: tuple[w,h:float]
  # shaders: seq[WebGlShader]
  b*: Batcher

proc initRenderer*(gl:ContextGL,w=640,h=480,clear:Color=White):Renderer =
  result.context = gl
  #result.context.canvas.resize()
  result.program = result.context.createProgram(true,vmsrc,fsrc)
  result.context.clearColor(clear)
  result.context.clear()
  result.buff = result.context.createBuffer()
  #gl.viewport(0, 0, gl.drawingBufferWidth, gl.drawingBufferHeight)
  result.size = (w.float,h.float)
  result.b = batcher() #default batcher 

proc uploadVertices(eng:Renderer, vertices:seq[float], drawMode:DrawMode=dmStatic){.inline} =
  ## Bind vertices to the context
  eng.context.uploadvertices(eng.buff,vertices,drawmode)

proc drawTriangles(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:DrawMode=dmStatic) =
  ## Draw triangles
  eng.context.drawtriangles(eng.buff,eng.program,vertices,color,drawmode)
  
proc drawTriangleFan(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:DrawMode=dmStatic) =
  ## Draw a fan of triangles
  eng.context.drawtrianglefan(eng.buff,eng.program,vertices,color,drawmode)

proc drawLineLoop(eng:Renderer,vertices:seq[float], color:Color=Green,drawMode:DrawMode=dmStatic) =
  ## Draw a closed loop of lines
  eng.context.drawlineloop(eng.buff,eng.program,vertices,color,drawmode)

proc setMatrixUnif(eng:Renderer,rend:Renderable,uniform:string) =
  if not rend.dirty: return

  let uMatLoc = eng.context.getUniformLocation(eng.program, uniform)

  let mat = rotation(rend.rot) * # TODO: a single proc for all 3 ops
            translation(
             rend.pos.x,rend.pos.y)*
            translation(
             rend.origin.x,rend.origin.y)*
            projection(eng.size.w, eng.size.h)
          #  translation(-w/2,-h/2)*
          #  scaling(w/2,-h/2)
  eng.context.uniformMatrix4fv(uMatLoc,false,mat.data[])


proc drawR(eng:Renderer, rect:Rect)=
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

proc drawB(eng:Renderer, rect:Rect)=
  
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


proc drawD(eng:Renderer, circle:Circle, roughness:int=32) =
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


proc drawC(eng:Renderer, circle:Circle, roughness:int=32) =
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
 
    #[
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
    ]#
    eng.drawTriangleFan( pol.verts, pol.color)
    
  else:
    #[
    var verts = newSeq[float](pol.sides*VECSIZE) # each line has x,y x1,y1, the last one is the first
    
    #Set outer vertices
    for i in countup(0,verts.len-1,4) :
      verts[i] = pol.bcradius*cos( i.float*Pi/(2*pol.sides.float))   # x
      verts[i+1] = pol.bcradius*sin( i.float*Pi/(2*pol.sides.float)) # y
      verts[i+2] = 0 # z
      verts[i+3] = 1/pol.scale # w
      #log(verts[i],verts[i+1])
    ]#
    eng.drawLineLoop( pol.verts, pol.color)

proc draw*(r:Renderer, rect:Rect)=
  if rect.filled: r.drawB(rect)
  else: r.drawR(rect)

proc draw*(r:Renderer, circle:Circle, roughness:int=32) =
  if circle.filled: r.drawD(circle,roughness)
  else: r.drawC(circle,roughness)

proc draw*[K:Renderables](r:Renderer,b:varargs[K])=
  for e in b: r.draw(e)

proc draw*(r:Renderer,b:Batcher)=
  for rc in b.r: r.draw(rc) 
  for cr in b.c: r.draw(cr) 
  for pl in b.p: r.draw(pl) 
import macros


macro batch*(b:Batcher, inner:varargs[untyped]):typed =
  ## Adds elements to the batcher
# TODO: error if inner is not renderable
  result = newstmtlist()
  if inner.len == 1:
     for el in inner[0]:
      result.add( newcall("add",b,el) )
  else:
    for el in inner:
      result.add( newcall("add",b,el) )
#[
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
  innerframedraw()]#
  
proc `+=`*(lf: var tuple[x:float,y:float],rg:tuple[x:float,y:float])=
  lf[0]+=rg[0]
  lf[1]+=rg[1]

when isMainModule:# and defined(js):
  import ../core/[events,window]
  #http:#codeincomplete.com/posts/javascript-game-foundations-the-game-loop/
  var w = initSurface()
  #var evq = initEvents(w)
  
  var en = initRenderer(w.ctx)
  #var speed = (0.0,0.0)
  #var accel = (2.0,2.0)
 
  var p = polygon(100,100,5,10,filled=true,color=Green)
  var r = rect(200,200)
  var c = circle(50,50)
  var d = disk(150,150)
  var b = box(250,250)
  var d2 = disk(150,250,color=Green)
  
  batch( en.b,
    p,
    r,
    c,
    d,
    b,
    d2)
#[
  evq.on("mouseEv", 
    proc (e:EventArgs)=
      speed += accel)
  evq.on("update", 
    proc (e:EventArgs)=
      p.pos += speed)
]#
  loop w:
    #evq.emit("update",EventArgs(dt:dt))
    #en.context.canvas.resize()
    #en.context.viewport(0, 0, en.size,.drawingBufferWidth, en.context.drawingBufferHeight)
    en.draw(en.b)
