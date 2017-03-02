import colors
from math import cos,sin,Pi

type Renderable* = object of Rootobj# Todo: concepts?
  color*: Color
  pos*: tuple[x,y:float]
  scale*: float
  rot*: float 
  origin*: tuple[x,y:float]
  centered*: bool
  filled*: bool
  verts*: seq[float]

type Rect* = object of Renderable
  ## A rectangle. For filled rectangles see box.
  size*: tuple[w,h:float]

type Circle* = object of Renderable
  ## A circle.
  radius*: float

type Polygon* = object of Renderable
  ## A polygon. ``bcradius`` is the radius of the bounding circle.  
  ## If ``filled`` is true, then the polygon is filled (duh).
  sides*: int
  bcradius*:float

type Renderables* = Rect|Circle|Polygon

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
      pol.verts[i] = pol.bcradius*
                 cos( i.float*Pi/(pol.sides.float*2))   # x
      pol.verts[i+1] = pol.bcradius*
                   sin( i.float*Pi/(pol.sides.float*2)) # y
      pol.verts[i+2] = 0 # z
      pol.verts[i+3] = 1/pol.scale # w
    
  else:
    pol.verts = newSeq[float](pol.sides*VECSIZE) # each line has x,y x1,y1, the last one is the first
    
    #Set outer vertices
    for i in countup(0,pol.verts.len-1,4) :
      pol.verts[i] = pol.bcradius*cos( i.float*Pi/(2*pol.sides.float))   # x
      pol.verts[i+1] = pol.bcradius*sin( i.float*Pi/(2*pol.sides.float)) # y
      pol.verts[i+2] = 0 # z
      pol.verts[i+3] = 1/pol.scale # w

proc `sides=`*(p:var Polygon,news:Natural)=
  doassert(news>=3)
  p.sides = news
  p.setupvertices
proc `bcradius=`*(p:var Polygon,bcr:float)=
  p.bcradius = bcr
  p.setupvertices
proc `scale=`*(p:var Polygon,scale:float)=
  p.scale = scale
  p.setupvertices

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

proc box*(x,y:float=0.0,w,h:float=10.0,color:Color=Red,centered:bool=true):Rect =
  result.color = color
  result.pos = (x,y)
  #result.origin = (-w/2,-h/2)
  result.size=(w,h)
  result.scale = 1.0
  result.centered = centered
  result.filled = true

proc circle*(x,y:float=0.0,r:float=10.0,color:Color=Red):Circle =
  result.color = color
  result.pos = (x,y)
  result.radius = r
  result.scale = 1.0

proc disk*(x,y:float=0.0,r:float=10.0,color:Color=Red):Circle =
  result.color = color
  result.pos = (x,y)
  result.radius = r
  result.scale = 1.0
  result.filled = true

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
  result.setupvertices

