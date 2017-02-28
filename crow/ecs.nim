
 
type
  Entity* = ref object of Rootobj
    id: Natural
    name: string
    parent : Entity
    components: seq[Component]

  Component* = ref object of Rootobj
    id: Natural
    entity: Entity 

proc hash(str:string):Natural =
    result = 0x67
    for i in 0..<str.len:
      result += str[i].int
      result *= 0x6F

proc entity(name:string):Entity =
  new result
  result.id = hash name
  result.name = name
  result.components = newSeq[Component]()

type Pos = ref object of Component
  x,y:float

proc pos(x,y:float):Pos= new result

proc `entity=`(c: var Component,e : var Entity)=
  c.entity = e
  e.components &= c

proc add(e : var Entity,c: var Component)=
  c.entity = e
  e.components &= c

proc add(e : var Entity,c: Component)=
  c.entity = e
  e.components &= c

var e = entity("one")
e.add(pos(0.0,0.0))
echo repr e
