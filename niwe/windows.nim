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
  proc initWindow*():Window =
    let canvas = document.getElementById("niwe-canvas").Canvas # TODO: personalize?
  # if undefined, TODO: append a canvas
    result.ctx = getContextWebgl(canvas)
    result.width = canvas.width
    result.height = canvas.height
    {.emit:"console.log(`result`.width,`result`.height);"}
