# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height

type Window* [Context] = object
  ctx*: Context
  width*,height*:int

when defined js:
  import webgl , dom
  export webgl
  proc initWindow*():Window[WebglRenderingContext] =
    let canvas = document.getElementById("niwe-canvas").Canvas # TODO: personalize?
  # if undefined, TODO: append a canvas
    result.ctx = getContextWebgl(canvas)
    result.width = canvas.width
    result.height = canvas.height
    {.emit:"console.log(`result`.width,`result`.height);"}
