import crow/[window,ngl]

import crow/graphic/utils

import times

var surface = initWindow()

surface.ctx.clearColor(randomColor())

loop surface:
  surface.ctx.clear()