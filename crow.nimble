# Package
version       = "0.1.1"
author        = "stisa"
description   = "Toy game engine"
license       = "MIT"

# Deps
requires: "nim >= 0.14.0"
requires: "webgl"
requires: "snail"


task exampler:
  exec("../exampler/exampler")
  withdir "docs/examples":
    exec("nim js -o:ex1.js ex1.nim")
    exec("nim js -o:ex2.js ex2.nim")
