import ../niwe/[engine,primitives]

var en = initEngine()
  
onclick en:
  echo "clk"
   
update en:
  en.draw(polygon(100,100,filled=true))