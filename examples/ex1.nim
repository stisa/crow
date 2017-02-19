# Click to change color

import ../niwe/events,../niwe/windows,random

var evloop = initEvents()

var gl = initWindow()

gl.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
gl.ctx.clear(ColorBufferBit)

proc handleMouseEvent(e: EventArgs) =
  gl.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
  gl.ctx.clear(ColorBufferBit)

evloop.on("mouseEv", handleMouseEvent)
