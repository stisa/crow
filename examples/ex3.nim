import ../niwe/[engine,primitives,colors]

var en = initEngine()

var p = polygon(100,100,
                boundingcircleradius=30,
                filled=true)

var p2 = polygon(300,300,
                 color=Green,
                 boundingcircleradius=30,
                 filled=true)
setupFpsCounter()

var clockwise = true
onclick en:
  clockwise = if clockwise:false else: true
   
update en:
  if clockwise:
    p.rot += 30*dt/1000
    p2.rot -= 30*dt/1000
  else:
    p.rot -= 30*dt/1000
    p2.rot += 30*dt/1000
  en.draw(p)
  en.draw(p2)
  updatefpscounter(dt)
