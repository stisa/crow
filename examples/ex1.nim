import crow/[window,ngl]

import crow/graphic/utils

import times

var surface = initWindow()

surface.ctx.clearColor(randomColor())
var startTime = epochTime()

loop surface:
  # Clear with random color once a second
  echo "looping"
  if epochTime() - startTime > 1.0:
    surface.ctx.clearColor(randomColor())
    surface.ctx.clear()
    startTime = epochTime()