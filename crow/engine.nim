import windows,events,colors,renderer
import gl except Renderer
when defined js:
  from webgl import WebglRenderingContext,Canvas
  import dom except Window
  export addEventListener
export draw
export events

type Engine* = object
  window*: Window
  renderer*: Renderer
  evloop*: EventEmitter

proc initEngine*():Engine =
  result.window = initwindow()
  result.renderer = initrenderer(result.window.ctx)
  result.evloop = initEventEmitter()

proc canvas*(en:Engine):Canvas{.inline} = en.window.ctx.canvas

converter toCtx*(e:Engine) : WebglRenderingContext = e.window.ctx

converter toRend*(e: Engine) : Renderer = e.renderer

converter toBatch*(e: Engine): Batcher = e.renderer.b

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

#[template onresize*(en:var Engine,body:untyped)=
  proc ors(e:EventArgs)=
    body
  
  proc resizeev(e:dom.Event) =
    en.evloop.emit("resize", EventArgs(kind:evResize,))
  
  document.addEventlistener("resize",resizeev,true)

  en.evloop.on("resize",ors)]#

template onclick*(en:var Engine,body:untyped){.dirty}=
  import dom
  from webgl import getboundingclientrect
  proc ock(e:EventArgs)=
    body
#[ TODO: this  ] 
function getMousePos(canvas, evt) {
    var rect = canvas.getBoundingClientRect();
    return {
        x: (evt.clientX - rect.left) / (rect.right - rect.left) * canvas.width,
        y: (evt.clientY - rect.top) / (rect.bottom - rect.top) * canvas.height
    };
}]#

  proc clickev (e:dom.Event) =
    let brect = en.canvas.getboundingclientrect()
    en.evloop.emit("click", EventArgs(
      kind:evClick,
      button:e.button,
      pos:(
        (e.clientX.float-brect.left),
        (e.clientY.float-brect.top)
        )
      )
    )
  
  en.canvas.addEventlistener("click",clickev,true)

  en.evloop.on("click",ock)

template setupFpsCounter*(onID:string = "body"){.dirty}=
  import dom
  from math import round
  var fps_time = 0.0
  var fps_frames = 0
  proc appendFpsCounter*(toID:string="body") =
    var fel = document.createElement("P")
    fel.innerHTML = "FPS Counter"
    #proc setAttribute*(n: Node, name, value: cstring)
    fel.setAttribute("ID","_fpsCounter_")
    fel.setAttribute("STYLE","position:relative;top:-2em;left:1em;border:0.1em solid black; max-width:5em;text-align:right;background-color:ghostwhite; z-index:10;")
    if toID=="body":
      document.body.appendChild(fel)
    else:
      let parent = document.getElementById(toID)
      
      #echo "appending to ",toid

      parent.appendChild(fel)

  appendFpsCounter(onID)

  proc updateFpsCounter*(dt : float) =

    var dom_counter = dom.document.getElementById("_fpsCounter_")
  
    fps_time+=dt
    inc fps_frames

    if(fps_time>1000):
      var fps=1000 * fps_frames.float/fps_time
      dom_counter.innerHTML = $round(fps) & " FPS"
      fps_time = 0.0
      fps_frames = 0

proc `+=`*(lf: var tuple[x:float,y:float],rg:tuple[x:float,y:float])=
  lf[0]+=rg[0]
  lf[1]+=rg[1]

template batch*(en:Engine,body:untyped):typed =
  batch en.renderer.b:
    body

proc draw*(en:var Engine) = en.draw(en.renderer.b)

proc add*(en:var Engine,d:auto) = en.renderer.b.add(d)

from primitives import Polygon,Rect,Circle

proc polygonlist*(en:var Engine): var seq[Polygon] = en.renderer.b.p

proc rectlist*(en:var Engine): var seq[Rect] = en.renderer.b.r

proc circlelist*(en:var Engine): var seq[Circle] = en.renderer.b.c

when isMainModule and defined(js):
  import primitives
  var en = initEngine()
  
  var p = polygon(100,100,filled=true)

  onclick en:
    p.pos = e.pos

  batch en:
   p

  update en:
    en.draw()
