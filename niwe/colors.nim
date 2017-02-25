import random
type Color* = tuple[r,g,b,a:float]

const
  Black* : Color = (r:0.0,g:0.0,b:0.0,a:1.0)
  Blue* : Color = (r:0.0,g:0.0,b:1.0,a:1.0)
  Red* : Color = (r:1.0,g:0.0,b:0.0,a:1.0)
  Green* : Color = (r:0.0,g:1.0,b:0.0,a:1.0)
  White* : Color = (r:1.0,g:1.0,b:1.0,a:1.0)

proc randomRGB*():Color = (r:random(1.0),g:random(1.0),b:random(1.0),a:1.0)

