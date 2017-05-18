
 
type
  Entity* = ref object of Rootobj
    id: string

  Component* = ref object of Rootobj
    id: Natural
    entity: Entity 

proc jenkins_one_at_a_time_hash(key:string):string =
  var hash = 0
  for c in key:
    hash += c.int
    hash += hash shl 10
    hash = hash xor ( hash shr 6)

  hash += hash shl 3;
  hash =  hash xor (hash shr 11)
  hash += hash shl 15;
  return $hash

proc entity(name:string):Entity =
  new result
  result.id = name&"_"&jenkins_one_at_a_time_hash(name)

type Pos = ref object of Component
  x,y:float

proc pos(e:Entity,x,y:float):Pos= 
  result.entity = e
  result.x = x
  result.y = y

proc `entity=`(c: var Component,e : var Entity)=
  c.entity = e

proc add(e : Entity,c: var Component)=
  c.entity = e

var e = entity("one")
e.pos(0.0,0.0)
echo repr e
