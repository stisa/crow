import colors

type Renderable* = object of Rootobj# Todo: concepts?
  color*: Color
  pos*: tuple[x,y:float]
  scale*: float
  rot*: float 
  origin*: tuple[x,y:float]
  centered*: bool
  filled*: bool

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

