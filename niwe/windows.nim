# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
when defined js :
  from webgl import WebGlRenderingContext


type Window* = object
  when defined js:
    ctx*: WebglRenderingContext
  width*,height*:int

when defined js:
  import webgl , dom
  proc initWindow*(w = -1, h:int = -1):Window =
    let canvas = document.getElementById("niwe-canvas").Canvas # TODO: personalize?
    if w != -1 or h != -1:
      canvas.width = w
      canvas.height = h
  # if undefined, TODO: append a canvas
    result.ctx = getContextWebgl(canvas)
    result.width = canvas.clientwidth
    result.height = canvas.clientheight
    {.emit:"console.log(`result`.width,`result`.height);"}
