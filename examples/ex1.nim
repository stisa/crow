import ../src/crow/core/[window,ngl]

var surface = initWindow()

var vertices = [
  -0.5'f32,0.5,0.0,
  -0.5,-0.5,0.0,
  0.5,-0.5,0.0, 
]

var indices = [0'u16,1,2]

# Create an empty buffer object to store vertex buffer
var vertex_buffer = surface.ctx.createBuffer()

# Bind appropriate array buffer to it
surface.ctx.bindBuffer(bkArray, vertex_buffer)

# Pass the vertex data to the buffer
surface.ctx.bufferData(bkArray, vertices, dmStatic)

# Unbind the buffer
#surface.ctx.bindBuffer(bkArray, nil)

# Create an empty buffer object to store Index buffer
var Index_Buffer = surface.ctx.createBuffer()

# Bind appropriate array buffer to it
surface.ctx.bindBuffer(bkElement, Index_Buffer)

# Pass the vertex data to the buffer
surface.ctx.bufferData(bkElement, indices, dmStatic)

# Vertex shader source code
var vertCode = "#version 100\n" & 
  "attribute vec3 coordinates;"&
  "void main(void) {" &
  " gl_Position = vec4(coordinates, 1.0);" &
  "}"
  
#fragment shader source code
var fragCode ="void main(void){" &
  "gl_FragColor = vec4(0.0, 0.0, 0.0, 1);" &
  "}"
  

var shaderProgram = surface.ctx.createProgram(true,vertCode,fragCode)

# Bind vertex buffer object
surface.ctx.bindBuffer(bkArray, vertex_buffer)

# Bind index buffer object
surface.ctx.bindBuffer(bkElement, Index_Buffer)

# Get the attribute location
var coord = surface.ctx.getAttribLocation(shaderProgram, "coordinates")

# Point an attribute to the currently bound VBO
surface.ctx.vertexAttribPointer(coord, 3, dkFloat, false, 0, 0) 

# Enable the attribute
surface.ctx.enableVertexAttribArray(coord)

# Clear the canvas
surface.ctx.clearColor(0.5, 0.5, 0.5, 1)

loop surface:
  # Clear the color buffer bit
  surface.ctx.clear()

  # Draw the triangle
  surface.ctx.drawElements(pkTriangles, indices.len, dkUShort,0)