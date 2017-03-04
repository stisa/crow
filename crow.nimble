# Package
version       = "0.1.1"
author        = "stisa"
description   = "Toy game engine"
license       = "MIT"

# Deps
requires: "nim >= 0.14.0"
requires: "webgl"
requires: "snail"

import ospaths

task exampler, "Builds examples":
  exec("exampler")
  withdir "examples":
    for file in listfiles("."):
      if splitfile(file).ext == ".nim":
        exec "nim js -o:../docs/examples/"&file.changefileext("js")&" "&file
