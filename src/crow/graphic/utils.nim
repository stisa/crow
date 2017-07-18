import colors, random

proc randomColor*():Color = 
  randomize()
  rgb(random(255),random(255),random(255))