import ../niwe/[engine,renderer]

var en = initEngine()
  
onclick en:
  echo "clk"
   
update en:
  en.draw(polygon(100,100,filled=true))
