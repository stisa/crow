# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
when defined js :
  from webgl import WebGlRenderingContext,Canvas,getContextwebgl,requestAnimationFrame
elif not defined android:
  from opengl import loadExtensions
  from glfw import nil

import ngl, event,keymap

type Window* = object
  ctx*: ContextGL
  width*,height*:int  
  when defined js:
    view*: Canvas
  elif not defined android:
    view*:glfw.Window
  eventLoop: EventEmitter

when defined js:
  import dom
  proc initDefaultEvents*(w:Window) =
    proc keyev(e:dom.Event) =
      w.eventLoop.emit("keyEv", EventArgs(kind:evKey,key:e.keycode.toJSKC()))
      echo "ha"
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
    #from times import epochTime
    #var oldtime = times.epochTime()
    proc innerframedraw(now:float=0)=
      #if times.epochTime() - oldTime > 1/60:
      body
      #  oldTime = times.epochTime()
    requestAnimationFrame(innerframedraw)

elif not defined android:
  proc initDefaultEvents*(w:Window) =
    proc keyCb(o: glfw.Window, key: glfw.Key, scanCode: int32, action: glfw.KeyAction,
        modKeys: set[glfw.ModifierKey]){.closure.} =
      if action == glfw.kaDown:
        w.eventLoop.emit("keyEv", EventArgs(kind:evKey,key:key.int.toGLFWKC()))
        echo "ha"
    
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
    from times import epochTime
    bind glfw.swapBuffers
    var oldTime = times.epochTime()
    #glfw.swapBuffers(s.view)
    while not glfw.shouldClose(s.view):
      if times.epochTime() - oldTime > 1/60:
        body
        glfw.swapBuffers(s.view)
        oldTime = times.epochTime()
      glfw.pollEvents()
    s.destroyWindow()

