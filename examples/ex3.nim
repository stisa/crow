import crow/[window,ngl]
import crow/graphic/[drawing, primitives]

import times, random

var surface = initWindow()

const vertCode =  """
attribute vec4 aPosition;
void main() {
  gl_Position = aPosition;
}
"""

const fragCode = """
#ifdef GL_ES
  precision highp float;
#endif

uniform vec4 uColor;
void main() {
  gl_FragColor = uColor;
}

"""
var shaderProgram = surface.ctx.createProgram(true,vertCode,fragCode)

# Set clear color
surface.ctx.clearColor(0.5, 0.5, 0.5, 1)


var 
  p = polygon(sides=5, radius=1.0) # A pentagon outline
  b = surface.ctx.createBuffer()
  renderer = p.initRenderable(surface.ctx,b, shaderProgram, "uColor", "aPosition")
  oldTime = times.epochTime()

loop surface:
  surface.ctx.clear()
  if times.epochTime()-oldTime>1.0:
    p.radius = random(1.0)
    oldTime = times.epochTime()
  echo "hi"
  renderer.draw()