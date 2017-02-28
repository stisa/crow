import ./niwe/events
import ./niwe/windows
import glad/gl
type
  Color* = tuple[r,g,b,a:float]
  ShaderType = enum
    Vertex, Fragment
  Program {.exportc.}= object
    program: Gluint
  #  colors: seq[WebglUniformLocation]
    attributes: seq[uint] # a list of attribute location

const vmsrc = r"""
attribute vec4 aPosition;
uniform mat4 uMatrix;
void main() {
  gl_Position = uMatrix*aPosition;
}
"""

const fsrc = r"""
#ifdef GL_ES
  precision highp float;
#endif

uniform vec4 uColor;
void main() {
  gl_FragColor = uColor;
}
"""

const vs = r"""attribute vec4 vPosition;      
void main() {      
  gl_Position = vPosition;      
}"""                                 

const fs = r"""
precision mediump float;      
void main() {      
  gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);      
}"""  

proc initShader(typ:ShaderType, src:string):GLuint =
  ## Init and compile a shader
  if typ == Vertex:
    result = glcreateShader(GLVertex_Shader)
  elif typ == Fragment:
    result = glcreateShader(GLFragment_Shader)
  else: echo "Unknown Shader Type"
  glshaderSource(result,1,src,nil)
  glcompileShader(result)
  #TODO: port getStatus if not gl.getStatus(result): log gl.getShaderInfoLog(result)

proc initProgram(useIt:bool=false ,vertex_src:string=vmsrc, fragment_src:string=fsrc):Program =
  ## Init, compile and link a program.
  ## If `useIt` is true, also sets the program as current
  var program = glcreateProgram()
  let vs = initShader(Vertex, vmsrc)
  let fs = initShader(Fragment, fsrc)
  glattachShader(program, vs)
  glattachShader(program, fs)
  gllinkProgram(program)

  #TODO
  #if not gl.getStatus(program): 
  #  log gl.getProgramInfoLog(program)
  #  return
  if useIt: gluseProgram(program)
  result.program = program

proc enableAttribute(program:Program,attribname:string,itemSize:int=4) =
  ## Enable the attribute `attribname` with `itemsize`
  let aloc :GLuint= 0
  var vVerices : array[9,GLfloat] = [
    0.0,  0.5, 0.0,                           
    -0.5, -0.5, 0.0,                          
    0.5, -0.5,  0.0
  ] 
  glBindAttribLocation(program.program,aloc, attribname)
  glenableVertexAttribArray(aloc)
  glvertexAttribPointer(aloc, itemSize, cGL_FLOAT, false, 0, cast[pointer](addr vVerices))
import glfw/wrapper
discard gladLoadGL(getProcAddress)  
var progr = initProgram(true,vs,fs)
progr.enableAttribute("vPosition")

var vVerices : array[9,GLfloat] = [
    0.0,  0.5, 0.0,                           
    -0.5, -0.5, 0.0,                          
    0.5, -0.5,  0.0
  ] 
  
glViewport(0, 0, window.width,window.height)

glClear(GL_COLOR_BUFFER_BIT)

while not window.ctx.shouldClose:
  glDrawArrays(GL_TRIANGLES, 0, 3)
  swapBufs(window.ctx)
  pollEvents() # avoid window close
