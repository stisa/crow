# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
when defined js :
  from webgl import WebGlRenderingContext,Canvas,getContextwebgl,requestAnimationFrame
elif defined useGLFW:
  from opengl import loadExtensions
  from glfw import nil
else:
  from opengl import loadExtensions
  from sdl2 import nil

import ngl, event,keymap

type Window* = object
  ctx*: ContextGL
  width*,height*:int  
  when defined js:
    view*: Canvas
  elif defined useGLFW:
    view*:glfw.Window
  else:
    view*: sdl2.WindowPtr
  eventLoop*: EventEmitter

when defined js:
  import dom
  proc initDefaultEvents(w:Window) =
    proc keyev(e:dom.Event) =
      w.eventLoop.emit("keyEv", EventArgs(kind:evKey,key:e.keycode.toKC()))
    document.addEventlistener("keypress",keyev,true)
  
  proc initWindow*(name:string = "crow-canvas", w = 640, h:int = 480):Window =
    var canvas = document.getElementById(name) # TODO: personalize?
    if canvas.isNil:
      canvas = document.createElement("CANVAS")
      canvas.setAttribute("ID",name)
      #canvas.setAttribute("STYLE","border: 1em solid black; width:90%; height:90%;")
      document.body.appendChild(canvas)
    
    canvas.setAttribute("WIDTH",$w)
    canvas.setAttribute("HEIGHT",$h)
    
    result.ctx = canvas.Canvas.getContextwebgl()
    result.view = canvas.Canvas
    result.width = result.view.clientwidth
    result.height = result.view.clientheight
    result.ctx.viewport(0,0,result.ctx.canvas.width,result.ctx.canvas.height)
    result.eventLoop = initEventEmitter()
    result.initDefaultEvents()
  
  proc destroyWindow*(s:Window) =
    s.view.parentNode.removeChild(s.view)
  
  template loop*(s:Window,body:untyped):untyped =
    from times import epochTime
    #var oldtime = times.epochTime()
    proc innerframedraw(now:float=0)=
      #if times.epochTime() - oldTime > 1/60:
      body
      #  oldTime = times.epochTime()
      requestAnimationFrame(innerframedraw)
    innerframedraw()

elif defined useGLFW:
  proc initDefaultEvents(w:Window) =
    proc keyCb(o: glfw.Window, key: glfw.Key, scanCode: int32, action: glfw.KeyAction,
        modKeys: set[glfw.ModifierKey]){.closure.} =
      if action == glfw.kaDown:
        w.eventLoop.emit("keyEv", EventArgs(kind:evKey,key:key.int.toKC()))
    w.view.keyCb = keyCb

  proc initWindow*(name:string="crow-canvas", w = 640, h:int = 480):Window =
    glfw.initialize()
    result.view = glfw.newOpenglWindow((w.int32,h.int32))
    (result.width,result.height) = glfw.size(result.view)
    loadExtensions()
    
    result.ctx.viewport(0,0,result.width,result.height)
    result.eventLoop = initEventEmitter()
    result.initDefaultEvents()

  proc destroyWindow*(s:Window) =
    glfw.destroy(s.view)
    glfw.terminate()
  
  export glfw.swapBuffers
  template loop*(s:Window,body:untyped):untyped =
    # TODO: FIXME
    from times import epochTime
    bind glfw.swapBuffers
    #var oldTime = times.epochTime()
    while not glfw.shouldClose(s.view):
      #if times.epochTime() - oldTime > 1/60:
      body
        #oldTime = times.epochTime()
      glfw.swapBuffers(s.view)
      glfw.pollEvents()
    s.destroyWindow()
else:
  proc checkDefaultEvents*(w:Window, e: var sdl2.Event) = 
    if e.kind == sdl2.KeyDown:
      var kbEvent = cast[sdl2.KeyboardEventPtr](addr(e))
      w.eventLoop.emit("keyEv", EventArgs(kind:evKey,key:kbEvent.keysym.sym.int.toKC()))

  proc initWindow*(name:string="crow-canvas", w = 640, h:int = 480):Window =
    sdl2.init(sdl2.INIT_EVERYTHING)
    result.view = sdl2.createWindow(name.cstring, 100, 100, w.cint, h.cint, sdl2.SDL_WINDOW_OPENGL or sdl2.SDL_WINDOW_RESIZABLE)
    (result.width,result.height) = (w,h)
    doAssert 0 == sdl2.glSetAttribute(sdl2.SDL_GL_DOUBLEBUFFER,1)
    doAssert 0 == sdl2.glSetAttribute(sdl2.SDL_GL_DEPTH_SIZE,24)

    discard sdl2.glcreateContext(result.view)
    doAssert 0 == sdl2.glSetSwapInterval(1)
    
    loadExtensions()
    
    result.ctx.viewport(0,0,result.width,result.height)
    result.eventLoop = initEventEmitter()
    
  proc destroyWindow*(s:Window) =
    sdl2.destroyWindow(s.view)
  
  template loop*(s:Window,body:untyped):untyped =
    from times import nil
    from sdl2 import nil
    var
      evt = sdl2.defaultEvent
      runGame = true
      now = times.epochTime()
      frameTime = 0'u32
    while runGame:
      while sdl2.pollEvent(evt).bool:
        if evt.kind == sdl2.QuitEvent:
          runGame = false
          break
        else:
          s.checkDefaultEvents(evt)
      #render
      body
      #limit
      frameTime = (times.epochTime()-now).uint32*1000 # in ms
      now = times.epochTime()
      if frameTime<18'u32:
        sdl2.delay(18'u32-frameTime)
      sdl2.glSwapWindow(s.view)
    s.destroyWindow()