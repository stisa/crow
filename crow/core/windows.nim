# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
when defined js :
  from webgl import WebGlRenderingContext,Canvas,getContextwebgl
elif not defined android:
  import glfw,opengl

import ../gl/gl

type Surface* = object
  ctx*: GL
  width*,height*:int  
  when defined js:
    view*: Canvas
  elif not defined android:
    view*:Window

when defined js:
  import dom
  proc initSurface*(w = -1, h:int = -1):Surface =
    var canvas = document.getElementById("crow-canvas") # TODO: personalize?
    if canvas.isNil:
      canvas = document.createElement("CANVAS")
      canvas.setAttribute("ID","crow-canvas")
      canvas.setAttribute("STYLE","border: 1em solid black; width:90%; height:90%;")
      document.body.appendChild(canvas)
    if w != -1 and h != -1:
      canvas.Canvas.width = w
      canvas.Canvas.height = h
    result.ctx = canvas.Canvas.getContextwebgl()
    result.view = canvas.Canvas
    result.width = canvas.Canvas.clientwidth
    result.height = canvas.Canvas.clientheight

  proc destroySurface*(s:Surface) =
    s.view.parentNode.removeChild(s.view)
  
  proc swap*(s:Surface) = discard

elif not defined android:
  proc initSurface*(w = -1, h:int = -1):Surface =
    glfw.initialize()
    if w != -1 and h != -1:
      result.view = newOpenglWindow((w,h))
    else:
      result.view = newOpenglWindow()
    (result.width,result.height) = result.view.size
    loadExtensions()

  proc destroySurface*(s:Surface) =
    s.view.destroy()
    glfw.terminate()
  proc swap*(s:Surface) = s.view.swapBuffers()
