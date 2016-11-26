import math,random

type Vector* = tuple[x,y,z:float]

proc `==`*(a,b:Vector):bool = a.x == b.x and a.y == b.y and a.z == b.z

#  toArray: function(n) {
#    return [this.x, this.y, this.z].slice(0, n || 3);
#  },

proc vector*(vc:openarray[float]):Vector = (x:vc[0], y:vc[1], z:vc[2])
proc vector*(x,y,z:float):Vector = (x:x, y:y, z:z)

proc negative*(a:Vector):Vector = ( -a.x,-a.y,-a.z )

proc negaive*(a: var Vector ) =
  a.x *= -1
  a.y *= -1
  a.z *= -1

proc add*(a:Vector, b: float): Vector =
  if (b == 0.0 ) : return a
  else:
    result.x = a.x + b
    result.y = a.y + b
    result.z = a.z + b

proc add*(a,b:Vector) : Vector =
  if (b.x == 0 and b.y == 0 and b.z == 0): return a
  if (a.x == 0 and a.y == 0 and a.z == 0): return b
  else:
    result.x = a.x + b.x
    result.y = a.y + b.y 
    result.z = a.z + b.z

proc subtract*(a:Vector, b: float): Vector =
  if (b == 0.0 ) : return a
  else:
    result.x = a.x - b
    result.y = a.y - b
    result.z = a.z - b

proc subtract*(a,b:Vector) : Vector =
  if (b.x == 0 and b.y == 0 and b.z == 0): return a
  if (a.x == 0 and a.y == 0 and a.z == 0): return b

  result.x = a.x - b.x
  result.y = a.y - b.y 
  result.z = a.z - b.z


proc multiply*(a,b:Vector):Vector {.inline.}=   
  if (b.x == 0 and b.y == 0 and b.z == 0): return 
  if (a.x == 0 and a.y == 0 and a.z == 0): return

  if (b.x == 1 and b.y == 1 and b.z == 1): return a 
  if (a.x == 1 and a.y == 1 and a.z == 1): return b
  
  result.x = a.x * b.x
  result.y = a.y * b.y
  result.z = a.z * b.z 
proc multiply*(a:Vector,b:float):Vector =
  
  if (a.x == 0 and a.y == 0 and a.z == 0): return
  
  if ( b == 0 ): return
  elif ( b == 1 ): return a

  result.x = a.x * b
  result.y = a.y * b
  result.z = a.z * b

proc divide*(a,b:Vector):Vector = 
  
  #TODO:
  #if (b.x == 0 or b.y == 0 or b.z == 0): return divbyzero
  
  if (a.x == 0 and a.y == 0 and a.z == 0): return 

  if (b.x == 1 and b.y == 1 and b.z == 1): return a 
  if (a.x == 1 and a.y == 1 and a.z == 1): return b

  result.x = a.x / b.x
  result.y = a.y / b.y
  result.z = a.z / b.z 


proc divide*(a:Vector,b:float):Vector =
  
  if (a.x == 0 and a.y == 0 and a.z == 0): return
  
  #TODO
  #if ( b == 0 ): return divbyzero
  
  if ( b == 1 ): return a

  result.x = a.x * b
  result.y = a.y * b
  result.z = a.z * b

proc dot*(a,b:Vector):float = 
  
  if (b.x == 0 and b.y == 0 and b.z == 0): return 
  if (a.x == 0 and a.y == 0 and a.z == 0): return
  
  result = a.x * b.x + a.y * b.y + a.z * b.z 

proc cross*(a,b:Vector):Vector =
  
  if (b.x == 0 and b.y == 0 and b.z == 0): return 
  if (a.x == 0 and a.y == 0 and a.z == 0): return

  result.x = a.y * b.z - a.z * b.y;
  result.y = a.z * b.x - a.x * b.z;
  result.z = a.x * b.y - a.y * b.x;

proc length*(a:Vector):float = math.sqrt(a.dot(a))

proc unit*(a:Vector):Vector = 
  let length = a.length()
  result.x = a.x / length
  result.y = a.y / length
  result.z = a.z / length
  
proc fromAngles*(theta,phi:float):Vector =
  let
    tr = theta.degtorad
    pr = phi.degtorad

  result = ( math.cos(tr)*math.cos(pr), math.sin(pr), math.sin(tr)*math.cos(pr) )

proc randomDirection*():Vector =
  randomize()

  result = fromAngles(random(1.0)*math.PI*2, math.arcsin( random(1.0)*2-1) )

proc min*(a, b:Vector) : Vector = vector( min(a.x, b.x), min(a.y, b.y), min(a.z, b.z) )
proc max*(a, b:Vector) : Vector = vector( max(a.x, b.x), max(a.y, b.y), max(a.z, b.z) )
proc min*(a:Vector):float = min(a.x,a.y,a.z)
proc max*(a:Vector):float = max(a.x,a.y,a.z)


proc lerp*(a, b:Vector, fraction:float) : Vector = ( b.subtract(a) ).multiply(fraction).add(a)

proc toAngles*(v:Vector):tuple[theta,phi:float] = ( theta: arctan2(v.z, v.x), phi: arcsin(v.y / v.length()) )
 
proc angleTo*(a,b:Vector) :float = arccos( a.dot(b) / ( a.length() * b.length() ) )

proc angleBetween*(a,b:Vector):float = a.angleTo(b)
