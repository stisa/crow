import colors
from math import cos,sin,Pi

type Primitive* = object of Rootobj# Todo: concepts?
  color: Color
  pos: tuple[x,y:float]
  scale: float
  rot: float 
  origin*: tuple[x,y:float]
  centered*: bool
  filled*: bool
  verts*: seq[float]
  dirty*:bool

type Rect* = object of Primitive
  ## A rectangle. For filled rectangles see box.
  size*: tuple[w,h:float]

type Circle* = object of Primitive
  ## A circle.
  r: float

type Polygon* = object of Primitive
  ## A polygon. ``radius`` is the radius of the bounding circle.  
  ## If ``filled`` is true, then the polygon is filled (duh).
  sides: int
  r:float

type Primitives* = Rect|Circle|Polygon

proc setupVertices(pol:var Polygon)=
  let Vecsize = 4 # FIXME
  if pol.filled:
    # each line has x,y x1,y1
    # the last one is the first
    pol.verts = newSeq[float](
                  2*VECSIZE+pol.sides*VECSIZE)
    # Set the center
    pol.verts[3] = 1/pol.scale

    #Set outer vertices
    for i in countup(4,pol.verts.len-1,4) :
      pol.verts[i] = pol.r*
                cos( i.float*Pi/(pol.sides.float*2))   # x
      pol.verts[i+1] = pol.r*
                sin( i.float*Pi/(pol.sides.float*2)) # y
      pol.verts[i+2] = 0 # z
      pol.verts[i+3] = 1/pol.scale # w
    
  else:
    pol.verts = newSeq[float](pol.sides*VECSIZE) # each line has x,y x1,y1, the last one is the first
    
    #Set outer vertices
    for i in countup(0,pol.verts.len-1,4) :
      pol.verts[i] = pol.r*cos( i.float*Pi/(2*pol.sides.float))   # x
      pol.verts[i+1] = pol.r*sin( i.float*Pi/(2*pol.sides.float)) # y
      pol.verts[i+2] = 0 # z
      pol.verts[i+3] = 1/pol.scale # w

proc setupVertices(c: var Circle) =
  let 
    VECSIZE = 4
    roughness = 32
  
  if c.filled:
    c.verts = newSeq[float](VECSIZE+roughness*VECSIZE*2)
    # Set the center
    c.verts[3] = 1/c.scale
    #Set outer vertices
    for i in countup(4,c.verts.len-1,4) :
      c.verts[i] = c.r*cos( (i/4)*2*Pi/roughness.float)   # x
      c.verts[i+1] = c.r*sin( (i/4)*2*Pi/roughness.float) # y
      c.verts[i+2] = 0 # TODO:z
      c.verts[i+3] = 1/c.scale # w
  else:
    c.verts = newSeq[float](roughness*VECSIZE) # each line has x,y x1,y1, the last one is the first

    #Set outer vertices
    for i in countup(0,c.verts.len-1,4) :
      c.verts[i] = c.r*cos( i.float*Pi/(2*roughness.float))   # x
      c.verts[i+1] = c.r*sin( i.float*Pi/(2*roughness.float)) # y
      c.verts[i+2] = 0 # z
      c.verts[i+3] = 1/c.scale # w

proc setupVertices(r: var Rect) =
  let VecSize = 4
  if r.filled:
    r.verts = newSeq[float](5*VecSize)
    r.verts[0] = -r.size.w/2
    r.verts[1] = -r.size.h/2
    r.verts[3] = 1.0

    r.verts[4] = -r.size.w/2
    r.verts[5] = r.size.h/2
    r.verts[7] = 1.0
    
    r.verts[8] = r.size.w/2
    r.verts[9] = r.size.h/2
    r.verts[11] = 1.0
    
    r.verts[12] = r.size.w/2
    r.verts[13] = r.size.h/2
    r.verts[15] = 1.0
    
    r.verts[16] = r.size.w/2
    r.verts[17] = -r.size.h/2
    r.verts[19] = 1.0
  else:
    r.verts = newSeq[float](4*VecSize)
    r.verts[0] = -r.size.w/2
    r.verts[1] = -r.size.h/2
    r.verts[3] = 1.0

    r.verts[4] = -r.size.w/2
    r.verts[5] = r.size.h/2
    r.verts[7] = 1.0
    
    r.verts[8] = r.size.w/2
    r.verts[9] = r.size.h/2
    r.verts[11] = 1.0
    
    r.verts[12] = r.size.w/2
    r.verts[13] = -r.size.h/2
    r.verts[15] = 1.0

proc rect*(
    x,y:float=0.0,
    w,h:float=10.0,
    color:Color=colRed,
    centered:bool=true
  ):Rect =
  result.color = color
  result.pos = (x,y)
  result.size=(w,h)
  #result.origin = (-w/2,-h/2) # default to centered for consistency
  result.scale = 1.0
  result.centered =  centered
  result.dirty = true
  result.setupVertices

proc box*(x,y:float=0.0,w,h:float=10.0,color:Color=colRed,centered:bool=true):Rect =
  result.color = color
  result.pos = (x,y)
  #result.origin = (-w/2,-h/2)
  result.size=(w,h)
  result.scale = 1.0
  result.centered = centered
  result.filled = true
  result.dirty = true
  result.setupVertices

proc circle*(x,y:float=0.0,r:float=10.0,color:Color=colRed):Circle =
  result.color = color
  result.pos = (x,y)
  result.r = r
  result.scale = 1.0
  result.dirty = true
  result.setupVertices

proc disk*(x,y:float=0.0,r:float=10.0,color:Color=colRed):Circle =
  result.color = color
  result.pos = (x,y)
  result.r = r
  result.scale = 1.0
  result.filled = true
  result.dirty = true
  result.setupVertices

proc polygon* (
    x,y:float=0.0,
    sides:int=3,
    radius:float=10.0,
    filled:bool=false,
    color:Color=colRed
  ) : Polygon =
  
  doassert(sides>=3)
  result.color = color
  result.pos = (x,y)
  result.sides = sides
  result.r = radius
  result.filled = filled
  result.scale = 1.0
  result.dirty = true
  result.setupvertices

proc `rot=`*(r:var Primitive,rot:float) = 
  r.rot = rot
  r.dirty = true
proc rot*(r: Primitive): float = r.rot

proc `color=`*(r:var Primitive,col:Color) = 
  r.color = col
  r.dirty = true
proc color*(r:Primitive|ptr Primitive):Color = r.color

proc `pos=`*(r:var Primitive,pos:tuple[x,y:float]) = 
  r.pos = pos
  r.dirty = true
proc pos*(r: Primitive): tuple[x,y:float] = r.pos

proc `scale=`*(p:var Primitive,scale:float)=
  p.scale = scale
  p.dirty = true
proc scale*(p:Primitive):float = p.scale

proc `sides=`*(p:var Polygon,news:Natural)=
  doassert(news>=3)
  p.sides = news
  p.setupvertices
proc sides*(p:Polygon):Natural = p.sides

proc `radius=`*(p:var Polygon,bcr:float)=
  p.r = bcr
  p.setupvertices
  p.dirty = true
proc `radius=`*(p:var Circle,bcr:float)=
  p.r = bcr
  p.setupvertices
  p.dirty = true

proc radius*(p:Polygon|Circle): float = p.r