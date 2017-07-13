# Obtain a window/canvas and export it
# A window is defined as a object with:
# - a context ( gl , webgl )
# - width
# - height
when defined js :
  from webgl import WebGlRenderingContext,Canvas,getContextwebgl
elif not defined android:
  import glfw,opengl

import sharedgl

type Surface* = object
  ctx*: ContextGL
  width*,height*:int  
  when defined js:
    view*: Canvas
  elif not defined android:
    view*:Window

when defined js:
  import dom
  proc initSurface*(w = 640, h:int = 480):Surface =
    var canvas = document.getElementById("crow-canvas") # TODO: personalize?
    if canvas.isNil:
      canvas = document.createElement("CANVAS")
      canvas.setAttribute("ID","crow-canvas")
      #canvas.setAttribute("STYLE","border: 1em solid black; width:90%; height:90%;")
      document.body.appendChild(canvas)
    
    canvas.setAttribute("WIDTH",$w)
    canvas.setAttribute("HEIGHT",$h)
    
    result.ctx = canvas.Canvas.getContextwebgl()
    result.view = canvas.Canvas
    result.width = result.view.clientwidth
    result.height = result.view.clientheight
    result.ctx.viewport(0,0,result.ctx.canvas.width,result.ctx.canvas.height)

  proc destroySurface*(s:Surface) =
    s.view.parentNode.removeChild(s.view)
  
  proc swap*(s:Surface) = discard

elif not defined android:
  proc initSurface*(w = 640, h:int = 480):Surface =
    glfw.initialize()
    result.view = newOpenglWindow((w,h))
    (result.width,result.height) = result.view.size
    loadExtensions()
    
    result.ctx.viewport(0,0,result.width,result.height)

  proc destroySurface*(s:Surface) =
    s.view.destroy()
    glfw.terminate()
  proc swap*(s:Surface) = s.view.swapBuffers()
