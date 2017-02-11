# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
import ../niwe/events,../niwe/windows,random

var evloop = initEvents()

var gl = initWindow()

proc handleMouseEvent(e: EventArgs) =
  gl.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
  gl.ctx.clear(ColorBufferBit)

evloop.on("mouseEv", handleMouseEvent)
