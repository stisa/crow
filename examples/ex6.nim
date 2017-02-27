import ../niwe/[engine,primitives,colors]
import random
var en = initEngine()

randomize()

var squarew = en.window.width div 20
var squareh = en.window.height div 20

for j in 0..squarew:
  for i in 0..squareh:
    en.add(box(j.float*squarew.float,i.float*squareh.float,
                squarew.float-1,squareh.float-1,
                color=randomRGB()))

setupFpsCounter("output")

var down = false
onclick en:
  down = if down:false else: true
   
update en:
  if down:
    for p in en.rectlist.mitems :  p.pos.y += 30*dt/1000
 
  en.draw()
  updatefpscounter(dt)
