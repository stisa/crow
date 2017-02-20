import windows,events,colors,renderer,gl
from dom import document,Event,addeventlistener
from webgl import WebglRenderingContext
export addEventListener,on

type Engine* = object
  window*: Window
  renderer*: Renderer
  evloop*: EventEmitter

proc initEngine*():Engine =
  result.window = initwindow()
  result.renderer = initrenderer(result.window.ctx)
  result.evloop = initEventEmitter()

converter toCtx*(e:Engine) : WebglRenderingContext = e.window.ctx

converter toRend*(e:Engine) : Renderer = e.renderer

#converter toEvL(e: var Engine) : EventEmitter = e.evloop

template update*(en:var Engine,body:untyped):untyped =
  ## Computes body each frame, the variable dt is exported and can be used.
  ## The timestep is NOT fixed (currently, will be in the future.)
  var last_t = 0.0
  var dt {.inject.} = 0.0 # inject allows using the dt symbol in the block, basically a limited {.dirty.}

  proc upd(e:EventArgs )=
    body
  
  en.evloop.on("update",upd)

  proc innerframedraw(now:float=0)=
    dt = now-last_t
    last_t = now
    en.evloop.emit("update",EventArgs(dt:dt))
    requestAnimationFrame(innerframedraw)
  innerframedraw()
  
template onclick*(en:var Engine,body:untyped)=
  proc ock(e:EventArgs)=
    body
  
  proc mouseev(e:dom.Event) =
    en.evloop.emit("mouseEv", EventArgs(kind:evMouse,button:0))
  
  document.addEventlistener("click",mouseev,true)

  en.evloop.on("mouseEv",ock)

proc `+=`*(lf: var tuple[x:float,y:float],rg:tuple[x:float,y:float])=
  lf[0]+=rg[0]
  lf[1]+=rg[1]

when isMainModule and defined(js):
  var en = initEngine()
  
  onclick en:
    echo "clk"
   
  update en:
    en.draw(polygon(100,100,filled=true))
