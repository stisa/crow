# Package
version       = "0.1.2"
author        = "stisa"
description   = "Toy game lib"
license       = "MIT"

# Deps
requires: "nim >= 0.14.0"
requires: "webgl"
requires: "opengl"
requires: "nim-glfw"
requires: "sdl2"

srcDir = "src"

import ospaths
task examples, "Build examples":
  mkdir "docs"/"examples"
  exec("exampler") # custom utility to generate example pages
  withdir "examples":
    for file in listfiles("."):
      if splitfile(file).ext == ".nim":
        echo ".."/"docs"/"examples"/file.changefileext("js") & " " & file
        exec "nim js -o:" & ".."/"docs"/"examples"/file.changefileext("js") & " " & file
  echo "DONE - Look inside /docs/examples, possibly serve it to a browser."

task docs, "Builds documentation":
  mkDir("docs"/"crow")
  mkDir("docs"/"crow"/"graphic")
  withdir "src":
    exec "nim doc2 --verbosity:0 --hints:off -o:"& ".."/"docs"/"crow.html  crow.nim"
    for file in listfiles("crow"):
      if splitfile(file).ext == ".nim":
        echo ".."/"docs" / "crow" / file.changefileext("html") & " " & file
        exec "nim doc2 --verbosity:0 --hints:off -o:" & ".." / "docs" / file.changefileext("html") & " " & file
    for file in listfiles("crow"/"graphic"):
      if splitfile(file).ext == ".nim":
        echo ".."/"docs" / "crow" / file.changefileext("html") & " " & file
        exec "nim doc2 --verbosity:0 --hints:off -o:" & ".." / "docs" / file.changefileext("html") & " " & file
    
    echo "DONE - Look inside /docs, possibly serve it to a browser."