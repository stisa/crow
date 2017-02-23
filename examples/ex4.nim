import ../niwe/[engine,primitives]

var en = initEngine()

var p = polygon(100,100,filled=true)
  
onclick en:
  echo "clk"
  p.pos.x += 50
   
update en:
  en.draw(p)
