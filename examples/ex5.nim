import ../niwe/[engine,primitives,colors]
import random
var en = initEngine()

randomize()

for i in 0..100:
  en.add(polygon(random(400.0),random(400.0),
                 boundingcircleradius=random(60.0),
                 filled=true,
                 color=randomRGB()))

setupFpsCounter("output")

var clockwise = true
onclick en:
  clockwise = if clockwise:false else: true
   
update en:
  if clockwise:
    for p in en.p.mitems :  p.rot += 30*dt/1000
  else:
    for p in en.p.mitems :  p.rot -= 30*dt/1000
 
  en.draw()
  updatefpscounter(dt)
