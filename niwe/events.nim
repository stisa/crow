import queues
export queues.len, queues.pop
type Event* = object
  kind* : string
  charc* : char
  key : int
  mods : int

proc event(kind:cstring,charc:char,key,mods:int):Event=
  result.kind = cast[string](kind)
  result.charc = charc
  result.key = key
  result.mods = mods

proc `$`*(e:Event):string = e.kind & ", key: " & $ e.key & ", mods: " & $e.mods

var evQ* : Queue[Event] = initQueue[Event]() 

when defined js:
  import dom

  proc keydown(e:dom.Event) =
    log $e.`type`
    case e.keycode:
    of 87: 
      log "w"
      evQ.add(event(e.`type`,'w',e.keycode,0))
    of 65:
      log "a"
      evQ.add(event(e.`type`,'a',e.keycode,0))
    of 83:
      log "s"
      evQ.add(event(e.`type`,'s',e.keycode,0))
    of 68:
      log "d"
      evQ.add(event(e.`type`,'d',e.keycode,0))
    of 82:
      log "r"
      evQ.add(event(e.`type`,'r',e.keycode,0))
    else: log("unhandled key" & $e.keycode)
  document.addEventlistener("keydown",keydown,true)