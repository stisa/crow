#
#
#            Nim's Runtime Library
#        (c) Copyright 2011 Alexander Mitchell-Robinson
#
#    See the file "copying.txt", included in this
#    distribution, for details about the copyright.
#

## :Author: Alexander Mitchell-Robinson (Amrykid)
##
## This module implements an event system that is not dependent on external
## graphical toolkits. It was originally called ``NimEE`` because
## it was inspired by Python's PyEE module. There are two ways you can use
## events: one is a python-inspired way; the other is more of a C-style way.
##
## .. code-block:: Nim
##    var ee = initEventEmitter()
##    var genericargs: EventArgs
##    proc handleevent(e: EventArgs) =
##        echo("Handled!")
##
##    # Python way
##    ee.on("EventName", handleevent)
##    ee.emit("EventName", genericargs)
##
##    # C/Java way
##    # Declare a type
##    type
##        SomeObject = object of RootObj
##            SomeEvent: EventHandler
##    var myobj: SomeObject
##    myobj.SomeEvent = initEventHandler("SomeEvent")
##    myobj.SomeEvent.addHandler(handleevent)
##    ee.emit(myobj.SomeEvent, genericargs)

import keymap

type EvKind* = enum
  evKey
  evClick
  evMouse
  evUpdate

type
  EventArgs* = object
    case kind*:EvKind:
    of evKey:
      key*:keymap.KeyCode
      mods*:int
    of evClick,evMouse:
      button*:int
      kmods*:int
      pos*: tuple[x,y:float]
    of evUpdate:
      dt*:float
    else: discard

  EventHandler* = tuple[name: string, handlers: seq[proc(e: EventArgs) {.closure.}]] ## An eventhandler for an event.

type
  EventEmitter* = ref object ## An object that fires events and holds event handlers for an object.
    s: seq[EventHandler]
  EventError* = object of ValueError

{.deprecated: [TEventArgs: EventArgs, TEventHandler: EventHandler,
  TEventEmitter: EventEmitter, EInvalidEvent: EventError].}

proc initEventHandler*(name: string): EventHandler =
  ## Initializes an EventHandler with the specified name and returns it.
  result.handlers = @[]
  result.name = name

proc addHandler*(handler: var EventHandler, fn: proc(e: EventArgs) {.closure.}) =
  ## Adds the callback to the specified event handler.
  handler.handlers.add(fn)

proc removeHandler*(handler: var EventHandler, fn: proc(e: EventArgs) {.closure.}) =
  ## Removes the callback from the specified event handler.
  for i in countup(0, len(handler.handlers)-1):
    if fn == handler.handlers[i]:
      handler.handlers.del(i)
      break

proc containsHandler*(handler: var EventHandler, fn: proc(e: EventArgs) {.closure.}): bool =
  ## Checks if a callback is registered to this event handler.
  return handler.handlers.contains(fn)


proc clearHandlers*(handler: var EventHandler) =
  ## Clears all of the callbacks from the event handler.
  setLen(handler.handlers, 0)

proc getEventHandler(emitter: EventEmitter, event: string): int =
  for k in 0..high(emitter.s):
    if emitter.s[k].name == event: return k
  return -1

proc on*(emitter: EventEmitter, event: string, fn: proc(e: EventArgs) {.closure.}) =
  ## Assigns a event handler with the specified callback. If the event
  ## doesn't exist, it will be created.
  var i = getEventHandler(emitter, event)
  if i < 0:
    var eh = initEventHandler(event)
    addHandler(eh, fn)
    emitter.s.add(eh)
  else:
    addHandler(emitter.s[i], fn)

proc emit*(emitter: EventEmitter, eventhandler: var EventHandler,
           args: EventArgs) =
  ## Fires an event handler with specified event arguments.
  for fn in items(eventhandler.handlers): fn(args)

proc emit*(emitter: EventEmitter, event: string, args: EventArgs) =
  ## Fires an event handler with specified event arguments.
  var i = getEventHandler(emitter, event)
  if i >= 0:
    emit(emitter, emitter.s[i], args)

proc initEventEmitter*(): EventEmitter =
  ## Creates and returns a new EventEmitter.
  result = new EventEmitter
  result.s = @[]

# Define and export the event loop

when defined js:
  import dom

#var evloop* = initEventEmitter()

#[ example hook event ]
# proc handleKeyEvent(e: EventArgs) =
#  when defined js:
#    log("handle :".cstring,$e.key)
#  else:
#    echo("Handled!")
#    echo $e.key

#evloop.on("keyEv", handleKeyEvent)
##########################à
when defined js:
  # TODO: this needs work, maybe move template in engine to here?
  proc initEvents*(w:Window):EventEmitter =
    result = initEventEmitter()
    proc keyev(e:dom.Event) =
      result.emit("keyEv", EventArgs(kind:evKey,key:e.keycode.toJSKC()))
  
    document.addEventlistener("keypress",keyev,true)
  
    proc mouseev(e:dom.Event) =
      result.emit("click", EventArgs(kind:evMouse,button:0))
  
    document.addEventlistener("click",mouseev,true)

else: 
  proc initEvents*(w:Window):EventEmitter =
    var emv = initEventEmitter()
    proc keyCb(o: Window, key: Key, scanCode: int32, action: KeyAction,
        modKeys: set[ModifierKey]){.closure.} =
      emv.emit("keyEv", EventArgs(kind:evKey,key:key.int.toGLFWKC())) 
    
    w.view.keyCb = keyCb
    result = emv


#


#    echo("Key: ", key, " (scan code: ", scanCode, "): ", action)

#   if action != kaUp:
#    if key == keyEscape:
#     o.shouldClose = true
]#