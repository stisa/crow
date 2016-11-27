# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height

type Window* [Context] = object
  ctx*: Context
  width*,height*:int

when defined js:
  import webgl,dom

  let canvas = document.getElementById("niwe-canvas").Canvas # TODO: personalize?
  # if undefined, TODO: append a canvas
  var window* = Window[WebglRenderingContext](ctx:getContextWebgl(canvas),width: canvas.width,height:canvas.height)
elif not defined android: #TODO: divide js | mobile(android,ios) | native(win,linux,macos)
  import os, glfw
  
  export glfw

  glfw.init()
  var window* = Window[Win](ctx:newGlWin(dim=(640,480)),width:640,height:480)
  addQuitProc( proc(){.noconv}=
    window.ctx.destroy()
    glfw.terminate()
  )

  #while not window.ctx.shouldClose:discard # avoid window close