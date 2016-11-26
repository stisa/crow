
import math
import vector
from strutils import formatFloat,FloatFormatMode

type Matrix* = array[16,float]

proc `[]`*(m:Matrix,i,j:Natural):float= m[i*4+j]
proc `[]=`*(m:var Matrix,i,j:Natural,val:float)= m[i*4+j] = val
proc `$`*(m: Matrix): string =
  result = "["
  for i in 0..<4:
    for j in 0..<4:
      let fstring = if m[i,j]>=0: '+'&formatFloat(m[i,j],ffDecimal,2) 
                    else: formatFloat(m[i,j],ffDecimal,2)
      if(j==3) and (i!=3): result.add(fstring&"|\n|")
      elif(j==3) and (i==3): result.add(fstring&"]\n")
      else:
        result.add(fstring & ", ")

proc matrix*(data: openarray[float]=[1.0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1] ) : Matrix  = 
  for i,v in data : result[i] = v 

# TODO: distinguish point and vector
proc transformPoint*(m:Matrix, v:Vector) : Vector =
  result = vector( 
    m[0] * v.x + m[1] * v.y + m[2] * v.z + m[3],
    m[4] * v.x + m[5] * v.y + m[6] * v.z + m[7],
    m[8] * v.x + m[9] * v.y + m[10] * v.z + m[11]
  )
  
  result = result.divide(m[12] * v.x + m[13] * v.y + m[14] * v.z + m[15]);

proc transformVector*(m:Matrix, v:Vector) : Vector =
  result = vector( m[0] * v.x + m[1] * v.y + m[2] * v.z,
      m[4] * v.x + m[5] * v.y + m[6] * v.z,
      m[8] * v.x + m[9] * v.y + m[10] * v.z )

proc inverse* (m:Matrix):Matrix = 
 
  result[0] = m[5]*m[10]*m[15] - m[5]*m[14]*m[11] - m[6]*m[9]*m[15] + m[6]*m[13]*m[11] + m[7]*m[9]*m[14] - m[7]*m[13]*m[10];
  result[1] = -m[1]*m[10]*m[15] + m[1]*m[14]*m[11] + m[2]*m[9]*m[15] - m[2]*m[13]*m[11] - m[3]*m[9]*m[14] + m[3]*m[13]*m[10];
  result[2] = m[1]*m[6]*m[15] - m[1]*m[14]*m[7] - m[2]*m[5]*m[15] + m[2]*m[13]*m[7] + m[3]*m[5]*m[14] - m[3]*m[13]*m[6];
  result[3] = -m[1]*m[6]*m[11] + m[1]*m[10]*m[7] + m[2]*m[5]*m[11] - m[2]*m[9]*m[7] - m[3]*m[5]*m[10] + m[3]*m[9]*m[6];

  result[4] = -m[4]*m[10]*m[15] + m[4]*m[14]*m[11] + m[6]*m[8]*m[15] - m[6]*m[12]*m[11] - m[7]*m[8]*m[14] + m[7]*m[12]*m[10];
  result[5] = m[0]*m[10]*m[15] - m[0]*m[14]*m[11] - m[2]*m[8]*m[15] + m[2]*m[12]*m[11] + m[3]*m[8]*m[14] - m[3]*m[12]*m[10];
  result[6] = -m[0]*m[6]*m[15] + m[0]*m[14]*m[7] + m[2]*m[4]*m[15] - m[2]*m[12]*m[7] - m[3]*m[4]*m[14] + m[3]*m[12]*m[6];
  result[7] = m[0]*m[6]*m[11] - m[0]*m[10]*m[7] - m[2]*m[4]*m[11] + m[2]*m[8]*m[7] + m[3]*m[4]*m[10] - m[3]*m[8]*m[6];

  result[8] = m[4]*m[9]*m[15] - m[4]*m[13]*m[11] - m[5]*m[8]*m[15] + m[5]*m[12]*m[11] + m[7]*m[8]*m[13] - m[7]*m[12]*m[9];
  result[9] = -m[0]*m[9]*m[15] + m[0]*m[13]*m[11] + m[1]*m[8]*m[15] - m[1]*m[12]*m[11] - m[3]*m[8]*m[13] + m[3]*m[12]*m[9];
  result[10] = m[0]*m[5]*m[15] - m[0]*m[13]*m[7] - m[1]*m[4]*m[15] + m[1]*m[12]*m[7] + m[3]*m[4]*m[13] - m[3]*m[12]*m[5];
  result[11] = -m[0]*m[5]*m[11] + m[0]*m[9]*m[7] + m[1]*m[4]*m[11] - m[1]*m[8]*m[7] - m[3]*m[4]*m[9] + m[3]*m[8]*m[5];

  result[12] = -m[4]*m[9]*m[14] + m[4]*m[13]*m[10] + m[5]*m[8]*m[14] - m[5]*m[12]*m[10] - m[6]*m[8]*m[13] + m[6]*m[12]*m[9];
  result[13] = m[0]*m[9]*m[14] - m[0]*m[13]*m[10] - m[1]*m[8]*m[14] + m[1]*m[12]*m[10] + m[2]*m[8]*m[13] - m[2]*m[12]*m[9];
  result[14] = -m[0]*m[5]*m[14] + m[0]*m[13]*m[6] + m[1]*m[4]*m[14] - m[1]*m[12]*m[6] - m[2]*m[4]*m[13] + m[2]*m[12]*m[5];
  result[15] = m[0]*m[5]*m[10] - m[0]*m[9]*m[6] - m[1]*m[4]*m[10] + m[1]*m[8]*m[6] + m[2]*m[4]*m[9] - m[2]*m[8]*m[5];

  let det = m[0]*result[0] + m[1]*result[4] + m[2]*result[8] + m[3]*result[12];
  for v in result.mitems : v /= det 

proc transpose*(m:Matrix): Matrix =
  result[0] = m[0]; result[1] = m[4]; result[2] = m[8]; result[3] = m[12];
  result[4] = m[1]; result[5] = m[5]; result[6] = m[9]; result[7] = m[13];
  result[8] = m[2]; result[9] = m[6]; result[10] = m[10]; result[11] = m[14];
  result[12] = m[3]; result[13] = m[7]; result[14] = m[11]; result[15] = m[15];
  
proc multiplication*(a:Matrix,b:Matrix): Matrix =
  result[0] = a[0] * b[0] + a[1] * b[4] + a[2] * b[8] + a[3] * b[12];
  result[1] = a[0] * b[1] + a[1] * b[5] + a[2] * b[9] + a[3] * b[13];
  result[2] = a[0] * b[2] + a[1] * b[6] + a[2] * b[10] + a[3] * b[14];
  result[3] = a[0] * b[3] + a[1] * b[7] + a[2] * b[11] + a[3] * b[15];

  result[4] = a[4] * b[0] + a[5] * b[4] + a[6] * b[8] + a[7] * b[12];
  result[5] = a[4] * b[1] + a[5] * b[5] + a[6] * b[9] + a[7] * b[13];
  result[6] = a[4] * b[2] + a[5] * b[6] + a[6] * b[10] + a[7] * b[14];
  result[7] = a[4] * b[3] + a[5] * b[7] + a[6] * b[11] + a[7] * b[15];

  result[8] = a[8] * b[0] + a[9] * b[4] + a[10] * b[8] + a[11] * b[12];
  result[9] = a[8] * b[1] + a[9] * b[5] + a[10] * b[9] + a[11] * b[13];
  result[10] = a[8] * b[2] + a[9] * b[6] + a[10] * b[10] + a[11] * b[14];
  result[11] = a[8] * b[3] + a[9] * b[7] + a[10] * b[11] + a[11] * b[15];

  result[12] = a[12] * b[0] + a[13] * b[4] + a[14] * b[8] + a[15] * b[12];
  result[13] = a[12] * b[1] + a[13] * b[5] + a[14] * b[9] + a[15] * b[13];
  result[14] = a[12] * b[2] + a[13] * b[6] + a[14] * b[10] + a[15] * b[14];
  result[15] = a[12] * b[3] + a[13] * b[7] + a[14] * b[11] + a[15] * b[15];

proc multiply*(a: var Matrix,b:Matrix) = a = a.multiplication(b)

proc `*`*(a:Matrix,b:Matrix):Matrix {.inline.}= a.multiplication(b)

proc identity*():Matrix {.inline.} = matrix()

proc zeros*():Matrix {.inline.} = return # noop?

proc frustum*(m: var Matrix, ll , r , b ,t ,n ,f : float) =
  m[0] = 2 * n / (r - ll)
  m[1] = 0
  m[2] = (r + ll) / (r - ll)
  m[3] = 0

  m[4] = 0
  m[5] = 2 * n / (t - b)
  m[6] = (t + b) / (t - b)
  m[7] = 0

  m[8] = 0;
  m[9] = 0
  m[10] = -(f + n) / (f - n)
  m[11] = -2 * f * n / (f - n)

  m[12] = 0
  m[13] = 0
  m[14] = -1
  m[15] = 0

proc frustum*(ll , r , b ,t ,n ,f : float):Matrix =
  result[0] = 2 * n / (r - ll)
  result[2] = (r + ll) / (r - ll)
  result[5] = 2 * n / (t - b)
  result[6] = (t + b) / (t - b)
  result[10] = -(f + n) / (f - n)
  result[11] = -2 * f * n / (f - n)
  result[14] = -1
  
proc perspective*(fov, aspect, near, far:float): Matrix =
  let y = math.tan(fov*math.PI / 360) * near
  let x = y*aspect
  result.frustum(-x,x,-y,y,near,far)

# left right bottom top near far
proc ortho*(ll, r, b, t, n, f: float):Matrix =
  result[0] = 2 / (r - ll);
  result[3] = -(r + ll) / (r - ll);
  result[5] = 2 / (t - b);
  result[7] = -(t + b) / (t - b);
  result[10] = -2 / (f - n);
  result[11] = -(f + n) / (f - n);
  result[15] = 1;

proc ortho*(m: var Matrix ,ll, r, b, t, n, f: float) =
  m[0] = 2 / (r - ll);
  m[1] = 0;
  m[2] = 0;
  m[3] = -(r + ll) / (r - ll);

  m[4] = 0;
  m[5] = 2 / (t - b);
  m[6] = 0;
  m[7] = -(t + b) / (t - b);

  m[8] = 0;
  m[9] = 0;
  m[10] = -2 / (f - n);
  m[11] = -(f + n) / (f - n);

  m[12] = 0;
  m[13] = 0;
  m[14] = 0;
  m[15] = 1;

proc projection*(w,h: float):Matrix =
  # Note: This matrix flips the Y axis so that 0 is at the top
  result[0] = (2 / w)
  result[5] = 2 / h
  
  result[10] = 1
  
  result[15] = 1

proc scale*(s: varargs[float] = 1.0):Matrix =
  case s.len:
  of 1: # scale on all axes
    result[0] = s[0]
    result[5] = s[0]
    result[10] = s[0]
    result[15] = 1
  of 2: # scale x and y
    result[0] = s[0]
    result[5] = s[1]
    result[10] = 1
    result[15] = 1
  of 3:
    result[0] = s[0]
    result[5] = s[1]
    result[10] = s[2]
    result[15] = 1
  else:
    discard #TODO: throw log "to many arguments for scMat"

proc translate*(x,y:float=0,z:float=0):Matrix =
  result[0] = 1
  result[5] = 1
  result[10] = 1
  result[15] = 1

  result[12] = x
  result[13] = y
  result[14] = z
  
proc rotation*(a:float = 0, x,y,z: float=0.0): Matrix =
  ## a : rotation in degrees
  ## TODO: allow rotation against x,y,z : coordinates of the points around which we rotate
  if ( a == 0 ): return identity() # basically a noop
  let
    ar = a * math.PI / 180 # a to radians
    c = math.cos(ar)
    s = math.sin(ar)

  # Construct the elements of the rotation matrix
  result[0] = c#xd * xd * t + c
  result[1] = -s#yd * xd * t + zd * s
  result[2] = 0#zd * xd * t - yd * s
  result[3] = 0
  
  result[4] = s#xd * yd * t - zd * s
  result[5] = c#yd * yd * t + c
  result[6] = 0#zd * yd * t + xd * s
  result[7] = 0

  result[8] = 0#xd * zd * t + yd * s 
  result[9] = 0#yd * zd * t - xd * s 
  result[10] = 1#zd * zd * t + c
  result[11] = 0 

  result[12] = 0 
  result[13] = 0
  result[14] = 0 
  result[15] = 1

proc rotate*(a:float = 0): Matrix =
  if ( a == 0 ): return identity() # basically a noop
  let
    ar = degToRad(a)
    c = math.cos(ar)
    s = math.sin(ar)
  result[0] = c
  result[1] = s
  
  result[4] = -s
  result[5] = c
  
  result[10] = 1
  
  result[15] = 1

proc rotate*(m: var Matrix, a:float = 0, x,y,z: float=1.0) = m.multiply( rotation(a,x,y,z) )

 # result[3] = x - c*x - (-s)*y
 # result[7] = y - s*x - c*y



proc lookAt*(ex, ey, ez, cx, cy, cz, ux, uy, uz:float):Matrix =
  
  let
    e = vector(ex, ey, ez)
    c = vector(cx, cy, cz)
    u = vector(ux, uy, uz)
    f = e.subtract(c).unit()
    s = u.cross(f).unit()
    t = f.cross(s).unit()

  result[0] = s.x;
  result[1] = s.y;
  result[2] = s.z;
  result[3] = -s.dot(e);

  result[4] = t.x;
  result[5] = t.y;
  result[6] = t.z;
  result[7] = -t.dot(e);

  result[8] = f.x;
  result[9] = f.y;
  result[10] = f.z;
  result[11] = -f.dot(e);
  result[15] = 1;