import ../niwe/[events,windows,gl,renderer,colors]
from webgl import resize
var evq = initEvents()
var w = initWindow()
var en = initRenderer(w.ctx)

var speed = (0.0,0.0)
var accel = (2.0,2.0)

var
  p = polygon(100,100,5,10,filled=true,color=Green)
  r = rect(200,200)
  c = circle(50,50)
  d = disk(150,150)
  b = box(250,250)

evq.on("mouseEv", 
  proc (e:EventArgs)=
  speed += accel)
evq.on("update", 
  proc (e:EventArgs)=
  p.pos += speed)

frame:
  evq.emit("update",EventArgs(dt:dt))
  en.context.canvas.resize()
  en.context.viewport(0, 0, en.context.drawingBufferWidth, en.context.drawingBufferHeight)
  en.draw(b)
  en.draw(c)
  en.draw(d)
  en.draw(p)
  en.draw(r)

