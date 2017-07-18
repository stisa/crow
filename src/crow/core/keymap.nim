# http://www.glfw.org/docs/latest/group__keys.html
import tables
type KeyCode* = enum
  kUNKNOWN          
  kSPACE            
  kAPOSTROPHE         # '  
  kCOMMA              # , 
  kMINUS              # -  
  kPERIOD             # .  
  kSLASH              # /  
  k0                
  k1                
  k2                
  k3                
  k4                
  k5                
  k6                
  k7                
  k8                
  k9                
  kSEMICOLON          # ;
  kEQUAL              #
  kA                
  kB                
  kC                
  kD                
  kE                
  kF                
  kG                
  kH                
  kI                
  kJ                
  kK                
  kL                
  kM                
  kN                
  kO                
  kP                
  kQ                
  kR                
  kS                
  kT                
  kU                
  kV                
  kW                
  kX                
  kY                
  kZ                
  kLEFT_BRACKET       # [
  kBACKSLASH          # \
  kRIGHT_BRACKET      # ]
  kGRAVE_ACCENT       # `
  kWORLD_1           # non-US #1
  kWORLD_2           # non-US #2

  kESCAPE            
  kENTER             
  kTAB               
  kBACKSPACE         
  kINSERT            
  kDELETE            
  kRIGHT             
  kLEFT              
  kDOWN              
  kUP                
  kPAGE_UP           
  kPAGE_DOWN         
  kHOME              
  kEND               
  kCAPS_LOCK         
  kSCROLL_LOCK       
  kNUM_LOCK          
  kPRINT_SCREEN      
  kPAUSE             
  kF1                
  kF2                
  kF3                
  kF4                
  kF5                
  kF6                
  kF7                
  kF8                
  kF9                
  kF10               
  kF11               
  kF12               
  kF13               
  kF14               
  kF15               
  kF16               
  kF17               
  kF18               
  kF19               
  kF20               
  kF21               
  kF22               
  kF23               
  kF24               
  kF25               
  kKP_0              
  kKP_1              
  kKP_2              
  kKP_3              
  kKP_4              
  kKP_5              
  kKP_6              
  kKP_7              
  kKP_8              
  kKP_9              
  kKP_DECIMAL        
  kKP_DIVIDE         
  kKP_MULTIPLY       
  kKP_SUBTRACT       
  kKP_ADD            
  kKP_ENTER          
  kKP_EQUAL          
  kLEFT_SHIFT        
  kLEFT_CONTROL      
  kLEFT_ALT          
  kLEFT_SUPER        
  kRIGHT_SHIFT       
  kRIGHT_CONTROL     
  kRIGHT_ALT         
  kRIGHT_SUPER       
  kMENU   
                          
when defined js:
  const js_scan_codes* = {
    0: kUNKNOWN,          
    32: kSPACE,            
    52: kAPOSTROPHE,         # '  
    44 : kCOMMA,              # , 
    45: kMINUS,              # -  
    46: kPERIOD,             # .  
    47: kSLASH,              # /  
    48: k0,                
    49: k1,                
    50: k2,                
    51: k3,                
    52: k4,                
    53: k5,                
    54: k6,                
    55: k7,                
    56: k8,                
    57: k9,                
    59: kSEMICOLON,          # ;
    61: kEQUAL,              #=  
    65: kA,                
    66: kB,                
    67: kC,                
    68: kD,                
    69: kE,                
    70: kF,                
    71: kG,                
    72: kH,                
    73: kI,                
    74: kJ,                
    75: kK,                
    76: kL,                
    77: kM,                
    78: kN,                
    79: kO,                
    80: kP,                
    81: kQ,                
    82: kR,                
    83: kS,                
    84: kT,                
    85: kU,                
    86: kV,                
    87: kW,                
    88: kX,                
    89: kY,                
    90: kZ,                
    91: kLEFT_BRACKET,       # [
    92: kBACKSLASH,          # \
    93: kRIGHT_BRACKET,      # ]
    96: kGRAVE_ACCENT,       # `
    161: kWORLD_1,           # non-US #1
    162: kWORLD_2,           # non-US #2
    27: kESCAPE,            
    13: kENTER,             
    9: kTAB,               
    8: kBACKSPACE,         
    260: kINSERT,            
    46: kDELETE,            
    39: kRIGHT,             
    37: kLEFT,              
    40: kDOWN,              
    38: kUP,                
    33: kPAGE_UP,           
    34: kPAGE_DOWN,         
    36: kHOME,              
    35: kEND,               
    20: kCAPS_LOCK,         
    145: kSCROLL_LOCK,       
    144: kNUM_LOCK,          
    44: kPRINT_SCREEN,      
    19: kPAUSE,             
    112: kF1,                
    113: kF2,                
    114: kF3,                
    115: kF4,                
    116: kF5,                
    117: kF6,                
    118: kF7,                
    119: kF8,                
    120: kF9,                
    121: kF10,               
    122: kF11,               
    123: kF12,               
    96: kKP_0,              
    97: kKP_1,              
    98: kKP_2,              
    99: kKP_3,              
    100: kKP_4,              
    101: kKP_5,              
    102: kKP_6,              
    103: kKP_7,              
    104: kKP_8,              
    105: kKP_9,              
    110: kKP_DECIMAL,        
    111: kKP_DIVIDE,         
    106: kKP_MULTIPLY,       
    109: kKP_SUBTRACT,       
    107: kKP_ADD,  
    16 : kLEFT_SHIFT ,       
    17 : kLEFT_CONTROL ,
    18 : kLEFT_ALT                       
  }.toTable

  proc toKC*(k:int):KeyCode = js_scan_codes[k]

elif defined useGLFW:
  const glfw_scan_codes* = {
    0: kUNKNOWN,          
    32: kSPACE,            
    39: kAPOSTROPHE,         # '  
    44: kCOMMA,              # , 
    45: kMINUS,              # -  
    46: kPERIOD,             # .  
    47: kSLASH,              # /  
    48: k0,                
    49: k1,                
    50: k2,                
    51: k3,                
    52: k4,                
    53: k5,                
    54: k6,                
    55: k7,                
    56: k8,                
    57: k9,                
    59: kSEMICOLON,          # ;
    61: kEQUAL,              #=  
    65: kA,                
    66: kB,                
    67: kC,                
    68: kD,                
    69: kE,                
    70: kF,                
    71: kG,                
    72: kH,                
    73: kI,                
    74: kJ,                
    75: kK,                
    76: kL,                
    77: kM,                
    78: kN,                
    79: kO,                
    80: kP,                
    81: kQ,                
    82: kR,                
    83: kS,                
    84: kT,                
    85: kU,                
    86: kV,                
    87: kW,                
    88: kX,                
    89: kY,                
    90: kZ,                
    91: kLEFT_BRACKET,       # [
    92: kBACKSLASH,          # \
    93: kRIGHT_BRACKET,      # ]
    96: kGRAVE_ACCENT,       # `
    161: kWORLD_1,           # non-US #1
    162: kWORLD_2,           # non-US #2
    256: kESCAPE,            
    257: kENTER,             
    258: kTAB,               
    259: kBACKSPACE,         
    260: kINSERT,            
    261: kDELETE,            
    262: kRIGHT,             
    263: kLEFT,              
    264: kDOWN,              
    265: kUP,                
    266: kPAGE_UP,           
    267: kPAGE_DOWN,         
    268: kHOME,              
    269: kEND,               
    280: kCAPS_LOCK,         
    281: kSCROLL_LOCK,       
    282: kNUM_LOCK,          
    283: kPRINT_SCREEN,      
    284: kPAUSE,             
    290: kF1,                
    291: kF2,                
    292: kF3,                
    293: kF4,                
    294: kF5,                
    295: kF6,                
    296: kF7,                
    297: kF8,                
    298: kF9,                
    299: kF10,               
    300: kF11,               
    301: kF12,               
    302: kF13,               
    303: kF14,               
    304: kF15,               
    305: kF16,               
    306: kF17,               
    307: kF18,               
    308: kF19,               
    309: kF20,               
    310: kF21,               
    311: kF22,               
    312: kF23,               
    313: kF24,               
    314: kF25,               
    320: kKP_0,              
    321: kKP_1,              
    322: kKP_2,              
    323: kKP_3,              
    324: kKP_4,              
    325: kKP_5,              
    326: kKP_6,              
    327: kKP_7,              
    328: kKP_8,              
    329: kKP_9,              
    330: kKP_DECIMAL,        
    331: kKP_DIVIDE,         
    332: kKP_MULTIPLY,       
    333: kKP_SUBTRACT,       
    334: kKP_ADD,            
    335: kKP_ENTER,          
    336: kKP_EQUAL,          
    340: kLEFT_SHIFT,        
    341: kLEFT_CONTROL,      
    342: kLEFT_ALT,          
    343: kLEFT_SUPER,        
    344: kRIGHT_SHIFT,       
    345: kRIGHT_CONTROL,     
    346: kRIGHT_ALT,         
    347: kRIGHT_SUPER,       
    348: kMENU }.toTable

  proc toKC*(k:int):KeyCode = glfw_scan_codes[k]
else:
  import sdl2
  const sdl_scan_codes* = {
    0: kUNKNOWN,          
    K_Space.int : kSPACE,            
    K_QUOTE.int: kAPOSTROPHE,         # '  
    K_COMMA.int: kCOMMA,              # , 
    K_MINUS.int: kMINUS,              # -  
    K_PERIOD.int: kPERIOD,             # .  
    K_SLASH.int: kSLASH,              # /  
    K_0.int: k0,                
    K_1.int: k1,                
    K_2.int: k2,                
    K_3.int: k3,                
    K_4.int: k4,                
    K_5.int: k5,                
    K_6.int: k6,                
    K_7.int: k7,                
    K_8.int: k8,                
    K_9.int: k9,                
    K_SEMICOLON.int: kSEMICOLON,          # ;
    K_EQUALS.int: kEQUAL,              #=  
    K_A.int: kA,                
    K_B.int: kB,                
    K_C.int: kC,                
    K_D.int: kD,                
    K_E.int: kE,                
    K_F.int: kF,                
    K_G.int: kG,                
    K_H.int: kH,                
    K_I.int: kI,                
    K_J.int: kJ,                
    K_K.int: kK,                
    K_L.int: kL,                
    K_M.int: kM,                
    K_N.int: kN,                
    K_O.int: kO,                
    K_P.int: kP,                
    K_Q.int: kQ,                
    K_R.int: kR,                
    K_S.int: kS,                
    K_T.int: kT,                
    K_U.int: kU,                
    K_V.int: kV,                
    K_W.int: kW,                
    K_X.int: kX,                
    K_Y.int: kY,                
    K_Z.int: kZ,                
    K_LEFT_BRACKET.int: kLEFT_BRACKET,       # [
    K_BACKSLASH.int: kBACKSLASH,          # \
    K_RIGHT_BRACKET.int: kRIGHT_BRACKET,      # ]
    K_BACKQUOTE.int: kGRAVE_ACCENT,       # `
    K_ESCAPE.int: kESCAPE,            
    K_RETURN.int: kENTER,             
    K_TAB.int: kTAB,               
    K_BACKSPACE.int: kBACKSPACE,         
    K_INSERT.int: kINSERT,            
    K_DELETE.int: kDELETE,            
    K_RIGHT.int: kRIGHT,             
    K_LEFT.int: kLEFT,              
    K_DOWN.int: kDOWN,              
    K_UP.int: kUP,                
    K_PAGE_UP.int: kPAGE_UP,           
    K_PAGE_DOWN.int: kPAGE_DOWN,         
    K_HOME.int: kHOME,              
    K_END.int: kEND,               
    K_CAPS_LOCK.int: kCAPS_LOCK,         
    K_SCROLL_LOCK.int: kSCROLL_LOCK,       
    K_NUMLOCKCLEAR.int: kNUM_LOCK,          
    K_PRINT_SCREEN.int: kPRINT_SCREEN,      
    K_PAUSE.int: kPAUSE,             
    K_F1.int: kF1,                
    K_F2.int: kF2,                
    K_F3.int: kF3,                
    K_F4.int: kF4,                
    K_F5.int: kF5,                
    K_F6.int: kF6,                
    K_F7.int: kF7,                
    K_F8.int: kF8,                
    K_F9.int: kF9,                
    K_F10.int: kF10,               
    K_F11.int: kF11,               
    K_F12.int: kF12,               
    K_F13.int: kF13,               
    K_F14.int: kF14,               
    K_F15.int: kF15,               
    K_F16.int: kF16,               
    K_F17.int: kF17,               
    K_F18.int: kF18,               
    K_F19.int: kF19,               
    K_F20.int: kF20,               
    K_F21.int: kF21,               
    K_F22.int: kF22,               
    K_F23.int: kF23,               
    K_F24.int: kF24,      
    K_KP_0.int: kKP_0,              
    K_KP_1.int: kKP_1,              
    K_KP_2.int: kKP_2,              
    K_KP_3.int: kKP_3,              
    K_KP_4.int: kKP_4,              
    K_KP_5.int: kKP_5,              
    K_KP_6.int: kKP_6,              
    K_KP_7.int: kKP_7,              
    K_KP_8.int: kKP_8,              
    K_KP_9.int: kKP_9,              
    K_KP_DECIMAL.int: kKP_DECIMAL,        
    K_KP_DIVIDE.int: kKP_DIVIDE,         
    K_KP_MULTIPLY.int: kKP_MULTIPLY,       
    K_KP_MINUS.int: kKP_SUBTRACT,       
    K_KP_PLUS.int: kKP_ADD,            
    K_KP_ENTER.int: kKP_ENTER,          
    K_KP_EQUALS.int: kKP_EQUAL,          
    K_LSHIFT.int: kLEFT_SHIFT,        
    K_LCTRL.int: kLEFT_CONTROL,      
    K_LALT.int: kLEFT_ALT,          
    K_LGUI.int: kLEFT_SUPER,        
    K_RSHIFT.int: kRIGHT_SHIFT,       
    K_RCTRL.int: kRIGHT_CONTROL,     
    K_RALT.int: kRIGHT_ALT,         
    K_RGUI.int: kRIGHT_SUPER,       
    K_MENU.int: kMENU }.toTable

  proc toKC*(k:int):KeyCode = sdl_scan_codes[k]

