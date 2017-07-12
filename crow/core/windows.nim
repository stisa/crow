# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
when defined js :
  from webgl import WebGlRenderingContext,Canvas,getContextwebgl
elif not defined android:
  import glfw

import ../gl/gl

type Window* = object
  ctx*: GL
  width*,height*:int  
  when defined js:
    view*: Canvas
  elif not defined android:
    view*:Win

when defined js:
  import dom
  proc initWindow*(w = -1, h:int = -1):Window =
    var canvas = document.getElementById("crow-canvas").Canvas # TODO: personalize?
    if canvas.isNil:
      canvas = document.createElement("CANVAS")
      canvas.setAttribute("ID","crow-canvas")
      document.body.appendChild(canvas)
    if w != -1 or h != -1:
      canvas.width = w
      canvas.height = h
    result.ctx = canvas.getContextwebgl()
    result.view = canvas
    result.width = canvas.clientwidth
    result.height = canvas.clientheight
elif not defined android:
  proc initWindow*(w = -1, h:int = -1):Window =
    result.view = newGlEsWin()
    (result.width,result.height) = result.view.size