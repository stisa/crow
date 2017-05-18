# Click to change color

import ../crow/[events,windows,gl],random
var evloop = initEvents()

var w = initWindow()

w.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
w.ctx.clear(bbColor)

proc handleMouseEvent(e: EventArgs) =
  w.ctx.clearcolor(
    random(1.0),random(1.0),random(1.0),1.0
  )
  w.ctx.clear(bbColor)

evloop.on("click", handleMouseEvent)
