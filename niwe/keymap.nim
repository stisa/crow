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

  proc toJSKC*(k:int):KeyCode = js_scan_codes[k]

else:
  const native_scan_codes* = {
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

  proc toGLFWKC*(k:int):KeyCode = native_scan_codes[k]
  
  
