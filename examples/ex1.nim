# Click to change color

import ../crow/[events,windows],random
from webgl import ColorBufferBit
var evloop = initEvents()

var w = initWindow()

w.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
w.ctx.clear(ColorBufferBit)

proc handleMouseEvent(e: EventArgs) =
  w.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
  w.ctx.clear(ColorBufferBit)

evloop.on("click", handleMouseEvent)
