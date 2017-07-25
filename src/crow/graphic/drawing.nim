import ../ngl, colors, primitives

type Renderable = object
  ctx: ContextGL
  buff: Buffer
  p: Program
  colorUniformName:string
  attribName:string
  drawMode:DrawMode
  primitive: ptr Primitive

proc drawTriangles*(gl:ContextGL,buff:Buffer,p:Program,vertices:seq[float], 
  color:Color = colRed, colorUniform:string,attribName:string,drawMode:DrawMode=dmStatic) =
  ## Draw triangles
  gl.uploadVertices(buff,vertices,drawMode)
  let numvertices = vertices.len div 4 # 4 is hardcoded for now, it means each vertices has x,y,z,scale
  gl.bindColor(p, colorUniform, color)
  gl.enableAttribute(p, attribName)
  gl.drawArrays(pkTRIANGLES, 0, numvertices)
  ngl.flush(gl)

proc drawTriangleFan*(gl:ContextGL,buff:Buffer,p:Program,vertices:seq[float], 
  color:Color = colRed, colorUniform:string, attribName:string, drawMode:DrawMode=dmStatic) =
  ## Draw a fan of triangles
  gl.uploadVertices(buff,vertices,drawMode)
  let numvertices = vertices.len div 4 # 4 is hardcoded for now, it means each vertices has x,y,z,scale
  gl.bindColor(p, colorUniform, color)
  gl.enableAttribute(p, attribName)
  gl.drawArrays(pkTRIANGLE_FAN, 0, numvertices)
  gl.flush()

proc drawLineLoop*(gl:ContextGL,buff:Buffer,p:Program,vertices:seq[float], 
  color:Color = colRed, colorUniform:string, attribName:string, drawMode:DrawMode=dmStatic) =
  ## Draw a closed loop of lines
  gl.uploadVertices(buff,vertices,drawMode)
  let numvertices = vertices.len div 4 # 4 is hardcoded for now, it means each vertices has x,y,z,scale
  gl.bindColor(p, colorUniform, color)
  gl.enableAttribute(p, attribName)
  gl.drawArrays(pkLineLoop, 0, numvertices)
  gl.flush()

proc initRenderable*(prim: var Primitive, gl:ContextGL,buff:Buffer,p:Program, 
  colorUniform:string,attribName:string,drawMode:DrawMode=dmStatic):Renderable =
  result.ctx = gl
  result.buff = buff
  result.p = p
  result.colorUniformName = colorUniform
  result.attribName = attribName
  result.drawMode = drawMode
  result.primitive = addr prim

proc draw*(r:Renderable) =
  if r.primitive.filled:
    r.ctx.drawTriangleFan(r.buff,r.p,r.primitive.verts,
      r.primitive.color,r.colorUniformName,r.attribName,r.drawMode)
  else:
    r.ctx.drawLineLoop(r.buff,r.p,r.primitive.verts,
      r.primitive.color,r.colorUniformName,r.attribName,r.drawMode)
