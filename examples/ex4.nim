import ../crow/[engine,primitives]

var en = initEngine()

var p = polygon(100,100,filled=true)
  
onclick en:
  p.pos = e.pos
update en:
  en.draw(p)
