/* Generated by the Nim Compiler v0.16.0 */
/*   (c) 2017 Andreas Rumpf */

var framePtr = null;
var excHandler = 0;
var lastJSError = null;
if (typeof Int8Array === 'undefined') Int8Array = Array;
if (typeof Int16Array === 'undefined') Int16Array = Array;
if (typeof Int32Array === 'undefined') Int32Array = Array;
if (typeof Uint8Array === 'undefined') Uint8Array = Array;
if (typeof Uint16Array === 'undefined') Uint16Array = Array;
if (typeof Uint32Array === 'undefined') Uint32Array = Array;
if (typeof Float32Array === 'undefined') Float32Array = Array;
if (typeof Float64Array === 'undefined') Float64Array = Array;
var NTI51068 = {size: 0,kind: 24,base: null,node: null,finalizer: null};
var NTI3446 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3448 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3444 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3452 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI51039 = {size: 0,kind: 24,base: null,node: null,finalizer: null};
var NTI51036 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI51024 = {size: 0,kind: 25,base: null,node: null,finalizer: null};
var NTI51023 = {size: 0,kind: 24,base: null,node: null,finalizer: null};
var NTI51010 = {size: 0, kind: 18, base: null, node: null, finalizer: null};
var NTI51436 = {size: 0,kind: 24,base: null,node: null,finalizer: null};
var NTI3438 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI104 = {size: 0,kind: 31,base: null,node: null,finalizer: null};
var NTI12409 = {size: 0, kind: 18, base: null, node: null, finalizer: null};
var NTI3408 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI138 = {size: 0,kind: 28,base: null,node: null,finalizer: null};
var NTI140 = {size: 0,kind: 29,base: null,node: null,finalizer: null};
var NTI3483 = {size: 0,kind: 22,base: null,node: null,finalizer: null};
var NTI3424 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3436 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NTI3440 = {size: 0, kind: 17, base: null, node: null, finalizer: null};
var NNI3440 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3440.node = NNI3440;
var NNI3436 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3436.node = NNI3436;
NTI3483.base = NTI3424;
var NNI3424 = {kind: 2, len: 4, offset: 0, typ: null, name: null, sons: [{kind: 1, offset: "parent", len: 0, typ: NTI3483, name: "parent", sons: null}, 
{kind: 1, offset: "name", len: 0, typ: NTI140, name: "name", sons: null}, 
{kind: 1, offset: "message", len: 0, typ: NTI138, name: "msg", sons: null}, 
{kind: 1, offset: "trace", len: 0, typ: NTI138, name: "trace", sons: null}]};
NTI3424.node = NNI3424;
var NNI3408 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3408.node = NNI3408;
NTI3424.base = NTI3408;
NTI3436.base = NTI3424;
NTI3440.base = NTI3436;
var NNI12409 = {kind: 2, len: 2, offset: 0, typ: null, name: null, sons: [{kind: 1, offset: "Field0", len: 0, typ: NTI140, name: "Field0", sons: null}, 
{kind: 1, offset: "Field1", len: 0, typ: NTI104, name: "Field1", sons: null}]};
NTI12409.node = NNI12409;
var NNI3438 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3438.node = NNI3438;
NTI3438.base = NTI3436;
NTI51023.base = NTI51024;
var NNI51010 = {kind: 2, len: 2, offset: 0, typ: null, name: null, sons: [{kind: 1, offset: "Field0", len: 0, typ: NTI138, name: "Field0", sons: null}, 
{kind: 1, offset: "Field1", len: 0, typ: NTI51023, name: "Field1", sons: null}]};
NTI51010.node = NNI51010;
NTI51436.base = NTI51010;
NTI51039.base = NTI51010;
var NNI51036 = {kind: 1, offset: "s", len: 0, typ: NTI51039, name: "s", sons: null};
NTI51036.node = NNI51036;
var NNI3452 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3452.node = NNI3452;
NTI3452.base = NTI3424;
var NNI3444 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3444.node = NNI3444;
NTI3444.base = NTI3424;
var NNI3448 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3448.node = NNI3448;
var NNI3446 = {kind: 2, len: 0, offset: 0, typ: null, name: null, sons: []};
NTI3446.node = NNI3446;
NTI3446.base = NTI3424;
NTI3448.base = NTI3446;
NTI51068.base = NTI51024;
function makeNimstrLit(c_13403) {

    var ln = c_13403.length;
    var result = new Array(ln + 1);
    var i = 0;
    for (; i < ln; ++i) {
      result[i] = c_13403.charCodeAt(i);
    }
    result[i] = 0; // terminating zero
    return result;
    }
function SetConstr() {

      var result = {};
      for (var i = 0; i < arguments.length; ++i) {
        var x = arguments[i];
        if (typeof(x) == "object") {
          for (var j = x[0]; j <= x[1]; ++j) {
            result[j] = true;
          }
        } else {
          result[x] = true;
        }
      }
      return result;
    }
function nimCopy(dest_18618, src_18619, ti_18620) {

var result_19029 = null;
switch (ti_18620.kind) {
case 21: case 22: case 23: case 5: if (!(isfatpointer_18601(ti_18620))) {
result_19029 = src_18619;
}
else {
result_19029 = [src_18619[0], src_18619[1]];}


break;
case 19:       if (dest_18618 === null || dest_18618 === undefined) {
        dest_18618 = {};
      }
      else {
        for (var key in dest_18618) { delete dest_18618[key]; }
      }
      for (var key in src_18619) { dest_18618[key] = src_18619[key]; }
      result_19029 = dest_18618;
    
break;
case 18: case 17: if (!((ti_18620.base == null))) {
result_19029 = nimCopy(dest_18618, src_18619, ti_18620.base);
}
else {
if ((ti_18620.kind == 17)) {
result_19029 = (dest_18618 === null || dest_18618 === undefined) ? {m_type: ti_18620} : dest_18618;}
else {
result_19029 = (dest_18618 === null || dest_18618 === undefined) ? {} : dest_18618;}
}
nimCopyAux(result_19029, src_18619, ti_18620.node);

break;
case 24: case 4: case 27: case 16:       if (src_18619 === null) {
        result_19029 = null;
      }
      else {
        if (dest_18618 === null || dest_18618 === undefined) {
          dest_18618 = new Array(src_18619.length);
        }
        else {
          dest_18618.length = src_18619.length;
        }
        result_19029 = dest_18618;
        for (var i = 0; i < src_18619.length; ++i) {
          result_19029[i] = nimCopy(result_19029[i], src_18619[i], ti_18620.base);
        }
      }
    
break;
case 28:       if (src_18619 !== null) {
        result_19029 = src_18619.slice(0);
      }
    
break;
default: 
result_19029 = src_18619;
break;
}
return result_19029;
}
function eqStrings(a_16003, b_16004) {

    if (a_16003 == b_16004) return true;
    if ((!a_16003) || (!b_16004)) return false;
    var alen = a_16003.length;
    if (alen != b_16004.length) return false;
    for (var i = 0; i < alen; ++i)
      if (a_16003[i] != b_16004[i]) return false;
    return true;
  }
function arrayConstr(len_19203, value_19204, typ_19205) {

      var result = new Array(len_19203);
      for (var i = 0; i < len_19203; ++i) result[i] = nimCopy(null, value_19204, typ_19205);
      return result;
    }
function cstrToNimstr(c_13603) {

  var ln = c_13603.length;
  var result = new Array(ln);
  var r = 0;
  for (var i = 0; i < ln; ++i) {
    var ch = c_13603.charCodeAt(i);

    if (ch < 128) {
      result[r] = ch;
    }
    else if((ch > 127) && (ch < 2048)) {
      result[r] = (ch >> 6) | 192;
      ++r;
      result[r] = (ch & 63) | 128;
    }
    else {
      result[r] = (ch >> 12) | 224;
      ++r;
      result[r] = ((ch >> 6) & 63) | 128;
      ++r;
      result[r] = (ch & 63) | 128;
    }
    ++r;
  }
  result[r] = 0; // terminating zero
  return result;
  }
function toJSStr(s_13803) {

    var len = s_13803.length-1;
    var asciiPart = new Array(len);
    var fcc = String.fromCharCode;
    var nonAsciiPart = null;
    var nonAsciiOffset = 0;
    for (var i = 0; i < len; ++i) {
      if (nonAsciiPart !== null) {
        var offset = (i - nonAsciiOffset) * 2;
        var code = s_13803[i].toString(16);
        if (code.length == 1) {
          code = "0"+code;
        }
        nonAsciiPart[offset] = "%";
        nonAsciiPart[offset + 1] = code;
      }
      else if (s_13803[i] < 128)
        asciiPart[i] = fcc(s_13803[i]);
      else {
        asciiPart.length = i;
        nonAsciiOffset = i;
        nonAsciiPart = new Array((len - i) * 2);
        --i;
      }
    }
    asciiPart = asciiPart.join("");
    return (nonAsciiPart === null) ?
        asciiPart : asciiPart + decodeURIComponent(nonAsciiPart.join(""));
  }
function raiseException(e_12806, ename_12807) {

e_12806.name = ename_12807;
if ((excHandler == 0)) {
unhandledException(e_12806);
}

e_12806.trace = nimCopy(null, rawwritestacktrace_12628(), NTI138);
throw e_12806;}
function chckIndx(i_19209, a_19210, b_19211) {

var Tmp1;
var result_19212 = 0;
BeforeRet: do {
if (!(a_19210 <= i_19209)) Tmp1 = false; else {Tmp1 = (i_19209 <= b_19211); }if (Tmp1) {
result_19212 = i_19209;
break BeforeRet;
}
else {
raiseIndexError();
}

} while (false); 
return result_19212;
}
function addInt(a_16256, b_16257) {

      var result = a_16256 + b_16257;
      if (result > 2147483647 || result < -2147483648) raiseOverflow();
      return result;
    }
function subInt(a_16403, b_16404) {

      var result = a_16403 - b_16404;
      if (result > 2147483647 || result < -2147483648) raiseOverflow();
      return result;
    }
var nimvm_5887 = false;
var nim_program_result = 0;
var globalraisehook_10414 = [null];
var localraisehook_10419 = [null];
var outofmemhook_10422 = [null];
function isfatpointer_18601(ti_18603) {

var result_18604 = false;
BeforeRet: do {
result_18604 = !((SetConstr(17, 16, 4, 18, 27, 19, 23, 22, 21)[ti_18603.base.kind] != undefined));
break BeforeRet;
} while (false); 
return result_18604;
}
function nimCopyAux(dest_18623, src_18624, n_18626) {

switch (n_18626.kind) {
case 0: 
break;
case 1:       dest_18623[n_18626.offset] = nimCopy(dest_18623[n_18626.offset], src_18624[n_18626.offset], n_18626.typ);
    
break;
case 2: L1: do {
var i_19015 = 0;
var HEX3Atmp_19017 = 0;
HEX3Atmp_19017 = (n_18626.len - 1);
var res_19020 = 0;
L2: do {
L3: while (true) {
if (!(res_19020 <= HEX3Atmp_19017)) break L3;
i_19015 = res_19020;
nimCopyAux(dest_18623, src_18624, n_18626.sons[i_19015]);
res_19020 += 1;
}
} while(false);
} while(false);

break;
case 3:       dest_18623[n_18626.offset] = nimCopy(dest_18623[n_18626.offset], src_18624[n_18626.offset], n_18626.typ);
      for (var i = 0; i < n_18626.sons.length; ++i) {
        nimCopyAux(dest_18623, src_18624, n_18626.sons[i][1]);
      }
    
break;
}
}
function add_10438(x_10441, x_10441_Idx, y_10442) {

        var len = x_10441[0].length-1;
        for (var i = 0; i < y_10442.length; ++i) {
          x_10441[0][len] = y_10442.charCodeAt(i);
          ++len;
        }
        x_10441[0][len] = 0
      }
function auxwritestacktrace_12404(f_12406) {

var Tmp3;
var result_12407 = [null];
var it_12415 = f_12406;
var i_12416 = 0;
var total_12417 = 0;
var tempframes_12421 = arrayConstr(64, {Field0: null, Field1: 0}, NTI12409);
L1: do {
L2: while (true) {
if (!!((it_12415 == null))) Tmp3 = false; else {Tmp3 = (i_12416 <= 63); }if (!Tmp3) break L2;
tempframes_12421[i_12416].Field0 = it_12415.procname;
tempframes_12421[i_12416].Field1 = it_12415.line;
i_12416 += 1;
total_12417 += 1;
it_12415 = it_12415.prev;
}
} while(false);
L4: do {
L5: while (true) {
if (!!((it_12415 == null))) break L5;
total_12417 += 1;
it_12415 = it_12415.prev;
}
} while(false);
result_12407[0] = nimCopy(null, makeNimstrLit(""), NTI138);
if (!((total_12417 == i_12416))) {
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit("(")); } else { result_12407[0] = makeNimstrLit("(");};
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(cstrToNimstr(((total_12417 - i_12416))+"")); } else { result_12407[0] = cstrToNimstr(((total_12417 - i_12416))+"");};
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit(" calls omitted) ...\x0A")); } else { result_12407[0] = makeNimstrLit(" calls omitted) ...\x0A");};
}

L6: do {
var j_12615 = 0;
var HEX3Atmp_12621 = 0;
HEX3Atmp_12621 = (i_12416 - 1);
var res_12624 = HEX3Atmp_12621;
L7: do {
L8: while (true) {
if (!(0 <= res_12624)) break L8;
j_12615 = res_12624;
add_10438(result_12407, 0, tempframes_12421[j_12615].Field0);
if ((0 < tempframes_12421[j_12615].Field1)) {
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit(", line: ")); } else { result_12407[0] = makeNimstrLit(", line: ");};
if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(cstrToNimstr((tempframes_12421[j_12615].Field1)+"")); } else { result_12407[0] = cstrToNimstr((tempframes_12421[j_12615].Field1)+"");};
}

if (result_12407[0] != null) { result_12407[0] = (result_12407[0].slice(0, -1)).concat(makeNimstrLit("\x0A")); } else { result_12407[0] = makeNimstrLit("\x0A");};
res_12624 -= 1;
}
} while(false);
} while(false);
return result_12407[0];
}
function rawwritestacktrace_12628() {

var result_12630 = null;
if (!((framePtr == null))) {
result_12630 = nimCopy(null, (makeNimstrLit("Traceback (most recent call last)\x0A").slice(0,-1)).concat(auxwritestacktrace_12404(framePtr)), NTI138);
}
else {
result_12630 = nimCopy(null, makeNimstrLit("No stack traceback available\x0A"), NTI138);
}

return result_12630;
}
function unhandledException(e_12654) {

var Tmp1;
var buf_12655 = /**/[makeNimstrLit("")];
if (!!(eqStrings(e_12654.message, null))) Tmp1 = false; else {Tmp1 = !((e_12654.message[0] == 0)); }if (Tmp1) {
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit("Error: unhandled exception: ")); } else { buf_12655[0] = makeNimstrLit("Error: unhandled exception: ");};
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(e_12654.message); } else { buf_12655[0] = e_12654.message;};
}
else {
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit("Error: unhandled exception")); } else { buf_12655[0] = makeNimstrLit("Error: unhandled exception");};
}

if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit(" [")); } else { buf_12655[0] = makeNimstrLit(" [");};
add_10438(buf_12655, 0, e_12654.name);
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(makeNimstrLit("]\x0A")); } else { buf_12655[0] = makeNimstrLit("]\x0A");};
if (buf_12655[0] != null) { buf_12655[0] = (buf_12655[0].slice(0, -1)).concat(rawwritestacktrace_12628()); } else { buf_12655[0] = rawwritestacktrace_12628();};
var cbuf_12801 = toJSStr(buf_12655[0]);
framePtr = null;
  if (typeof(Error) !== "undefined") {
    throw new Error(cbuf_12801);
  }
  else {
    throw cbuf_12801;
  }
  }
function raiseOverflow() {

var e_13236 = null;
e_13236 = {m_type: NTI3440, parent: null, name: null, message: null, trace: null};
e_13236.message = nimCopy(null, makeNimstrLit("over- or underflow"), NTI138);
raiseException(e_13236, "OverflowError");
}
function raiseDivByZero() {

var e_13252 = null;
e_13252 = {m_type: NTI3438, parent: null, name: null, message: null, trace: null};
e_13252.message = nimCopy(null, makeNimstrLit("division by zero"), NTI138);
raiseException(e_13252, "DivByZeroError");
}
var objectid_42233 = /**/[0];
var state_59605 = /**/[{a0: 1773455756, a1: 4275166512}];
function gettime_62040() {

var result_62413 = null;
var F={procname:"times.getTime",prev:framePtr,filename:"lib/pure/times.nim",line:0};
framePtr = F;
BeforeRet: do {
F.line = 586;
result_62413 = new Date();
break BeforeRet;
} while (false); 
framePtr = F.prev;
return result_62413;
}
var startmilsecs_62448 = /**/[gettime_62040()];
function initeventemitter_51418() {

var result_51420 = {s: null};
var F={procname:"events.initEventEmitter",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
F.line = 123;
result_51420.s = nimCopy(null, [], NTI51436);
framePtr = F.prev;
return result_51420;
}
function raiseIndexError() {

var e_13284 = null;
e_13284 = {m_type: NTI3452, parent: null, name: null, message: null, trace: null};
e_13284.message = nimCopy(null, makeNimstrLit("index out of bounds"), NTI138);
raiseException(e_13284, "IndexError");
}
function geteventhandler_51255(emitter_51258, event_51259) {

var result_51260 = 0;
var F={procname:"events.getEventHandler",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
BeforeRet: do {
L1: do {
F.line = 95;
var k_51270 = 0;
F.line = 1926;
var HEX3Atmp_51272 = 0;
F.line = 95;
HEX3Atmp_51272 = (emitter_51258.s != null ? (emitter_51258.s.length-1) : -1);
F.line = 1908;
var res_51275 = 0;
L2: do {
F.line = 1909;
L3: while (true) {
if (!(res_51275 <= HEX3Atmp_51272)) break L3;
F.line = 1910;
k_51270 = res_51275;
if (eqStrings(emitter_51258.s[chckIndx(k_51270, 0, emitter_51258.s.length)-0].Field0, event_51259)) {
F.line = 96;
result_51260 = k_51270;
break BeforeRet;
}

res_51275 = addInt(res_51275, 1);
}
} while(false);
} while(false);
F.line = 97;
result_51260 = -1;
break BeforeRet;
} while (false); 
framePtr = F.prev;
return result_51260;
}
function sysfatal_21221(message_21227) {

var F={procname:"sysFatal.sysFatal",prev:framePtr,filename:"lib/system.nim",line:0};
framePtr = F;
F.line = 2578;
var e_21229 = null;
e_21229 = {m_type: NTI3444, parent: null, name: null, message: null, trace: null};
F.line = 2580;
e_21229.message = nimCopy(null, message_21227, NTI138);
F.line = 2581;
raiseException(e_21229, "AssertionError");
framePtr = F.prev;
}
function raiseassert_21216(msg_21218) {

var F={procname:"system.raiseAssert",prev:framePtr,filename:"lib/system.nim",line:0};
framePtr = F;
sysfatal_21221(msg_21218);
framePtr = F.prev;
}
function failedassertimpl_21239(msg_21241) {

var F={procname:"system.failedAssertImpl",prev:framePtr,filename:"lib/system.nim",line:0};
framePtr = F;
raiseassert_21216(msg_21241);
framePtr = F.prev;
}
function emit_51302(emitter_51305, eventhandler_51307, args_51308) {

var F={procname:"events.emit",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
L1: do {
F.line = 113;
var fn_51402 = null;
F.line = 3495;
var HEX3Atmp_51404 = null;
F.line = 113;
HEX3Atmp_51404 = eventhandler_51307.Field1;
F.line = 3497;
var i_51407 = 0;
F.line = 3498;
var L_51409 = (HEX3Atmp_51404 != null ? HEX3Atmp_51404.length : 0);
L2: do {
F.line = 3499;
L3: while (true) {
if (!(i_51407 < L_51409)) break L3;
F.line = 3500;
fn_51402 = HEX3Atmp_51404[chckIndx(i_51407, 0, HEX3Atmp_51404.length)-0];
fn_51402(args_51308);
i_51407 = addInt(i_51407, 1);
if (!(((HEX3Atmp_51404 != null ? HEX3Atmp_51404.length : 0) == L_51409))) {
failedassertimpl_21239(makeNimstrLit("len(a) == L seq modified while iterating over it"));
}

}
} while(false);
} while(false);
framePtr = F.prev;
}
function emit_51410(emitter_51413, event_51414, args_51415) {

var F={procname:"events.emit",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
F.line = 117;
var i_51416 = geteventhandler_51255(emitter_51413, event_51414);
if ((0 <= i_51416)) {
emit_51302(emitter_51413, emitter_51413.s[chckIndx(i_51416, 0, emitter_51413.s.length)-0], args_51415);
}

framePtr = F.prev;
}
function hash_42801(x_42803) {

var result_42804 = 0;
var F={procname:"hashes.hash",prev:framePtr,filename:"lib/pure/hashes.nim",line:0};
framePtr = F;
F.line = 109;
result_42804 = x_42803;
framePtr = F.prev;
return result_42804;
}
function isfilled_45465(hcode_45467) {

var result_45468 = false;
var F={procname:"tables.isFilled",prev:framePtr,filename:"lib/pure/collections/tableimpl.nim",line:0};
framePtr = F;
F.line = 18;
result_45468 = !((hcode_45467 == 0));
framePtr = F.prev;
return result_45468;
}
function nexttry_45601(h_45603, maxhash_45604) {

var result_45605 = 0;
var F={procname:"tables.nextTry",prev:framePtr,filename:"lib/pure/collections/tableimpl.nim",line:0};
framePtr = F;
F.line = 28;
result_45605 = (addInt(h_45603, 1) & maxhash_45604);
framePtr = F.prev;
return result_45605;
}
function rawget_49460(t_49465, key_49467, hc_49469, hc_49469_Idx) {

var Tmp3;
var result_49470 = 0;
var F={procname:"rawGet.rawGet",prev:framePtr,filename:"lib/pure/collections/tableimpl.nim",line:0};
framePtr = F;
BeforeRet: do {
F.line = 43;
hc_49469[hc_49469_Idx] = hash_42801(key_49467);
if ((hc_49469[hc_49469_Idx] == 0)) {
F.line = 45;
hc_49469[hc_49469_Idx] = 314159265;
}

F.line = 31;
var h_49472 = (hc_49469[hc_49469_Idx] & (t_49465.data != null ? (t_49465.data.length-1) : -1));
L1: do {
F.line = 32;
L2: while (true) {
if (!isfilled_45465(t_49465.data[chckIndx(h_49472, 0, t_49465.data.length)-0].Field0)) break L2;
if (!(t_49465.data[chckIndx(h_49472, 0, t_49465.data.length)-0].Field0 == hc_49469[hc_49469_Idx])) Tmp3 = false; else {Tmp3 = (t_49465.data[chckIndx(h_49472, 0, t_49465.data.length)-0].Field1 == key_49467); }if (Tmp3) {
F.line = 38;
result_49470 = h_49472;
break BeforeRet;
}

F.line = 39;
h_49472 = nexttry_45601(h_49472, (t_49465.data != null ? (t_49465.data.length-1) : -1));
}
} while(false);
F.line = 75;
result_49470 = subInt(-1, h_49472);
} while (false); 
framePtr = F.prev;
return result_49470;
}
function HEX5BHEX5D_49630(t_49636, key_49638) {

var result_49639 = 0;
var F={procname:"[].[]",prev:framePtr,filename:"lib/pure/collections/tables.nim",line:0};
framePtr = F;
F.line = 146;
var hc_49641 = [0];
F.line = 147;
var index_49643 = rawget_49460(t_49636, key_49638, hc_49641, 0);
if ((0 <= index_49643)) {
F.line = 148;
result_49639 = t_49636.data[chckIndx(index_49643, 0, t_49636.data.length)-0].Field2;
}
else {
F.line = 151;
F.line = 2559;
var e_49803 = null;
e_49803 = {m_type: NTI3448, parent: null, name: null, message: null, trace: null};
F.line = 2561;
e_49803.message = nimCopy(null, (makeNimstrLit("key not found: ").slice(0,-1)).concat(cstrToNimstr((key_49638)+"")), NTI138);
raiseException(e_49803, "KeyError");
}

framePtr = F.prev;
return result_49639;
}
function tojskc_49625(k_49627) {

var result_49628 = 0;
var F={procname:"keymap.toJSKC",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/keymap.nim",line:0};
framePtr = F;
F.line = 231;
result_49628 = HEX5BHEX5D_49630({data: [{Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 260, Field1: 260, Field2: 55}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 8, Field1: 8, Field2: 54}, {Field0: 9, Field1: 9, Field2: 53}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 13, Field1: 13, Field2: 52}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 16, Field1: 16, Field2: 112}, {Field0: 17, Field1: 17, Field2: 113}, {Field0: 18, Field1: 18, Field2: 114}, {Field0: 19, Field1: 19, Field2: 69}, {Field0: 20, Field1: 20, Field2: 65}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 27, Field1: 27, Field2: 51}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 32, Field1: 32, Field2: 1}, {Field0: 33, Field1: 33, Field2: 61}, {Field0: 34, Field1: 34, Field2: 62}, {Field0: 35, Field1: 35, Field2: 64}, {Field0: 36, Field1: 36, Field2: 63}, {Field0: 37, Field1: 37, Field2: 58}, {Field0: 38, Field1: 38, Field2: 60}, {Field0: 39, Field1: 39, Field2: 57}, {Field0: 40, Field1: 40, Field2: 59}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 44, Field1: 44, Field2: 68}, {Field0: 45, Field1: 45, Field2: 4}, {Field0: 46, Field1: 46, Field2: 56}, {Field0: 47, Field1: 47, Field2: 6}, {Field0: 48, Field1: 48, Field2: 7}, {Field0: 49, Field1: 49, Field2: 8}, {Field0: 50, Field1: 50, Field2: 9}, {Field0: 51, Field1: 51, Field2: 10}, {Field0: 52, Field1: 52, Field2: 11}, {Field0: 53, Field1: 53, Field2: 12}, {Field0: 54, Field1: 54, Field2: 13}, {Field0: 55, Field1: 55, Field2: 14}, {Field0: 56, Field1: 56, Field2: 15}, {Field0: 57, Field1: 57, Field2: 16}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 59, Field1: 59, Field2: 17}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 61, Field1: 61, Field2: 18}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 65, Field1: 65, Field2: 19}, {Field0: 66, Field1: 66, Field2: 20}, {Field0: 67, Field1: 67, Field2: 21}, {Field0: 68, Field1: 68, Field2: 22}, {Field0: 69, Field1: 69, Field2: 23}, {Field0: 70, Field1: 70, Field2: 24}, {Field0: 71, Field1: 71, Field2: 25}, {Field0: 72, Field1: 72, Field2: 26}, {Field0: 73, Field1: 73, Field2: 27}, {Field0: 74, Field1: 74, Field2: 28}, {Field0: 75, Field1: 75, Field2: 29}, {Field0: 76, Field1: 76, Field2: 30}, {Field0: 77, Field1: 77, Field2: 31}, {Field0: 78, Field1: 78, Field2: 32}, {Field0: 79, Field1: 79, Field2: 33}, {Field0: 80, Field1: 80, Field2: 34}, {Field0: 81, Field1: 81, Field2: 35}, {Field0: 82, Field1: 82, Field2: 36}, {Field0: 83, Field1: 83, Field2: 37}, {Field0: 84, Field1: 84, Field2: 38}, {Field0: 85, Field1: 85, Field2: 39}, {Field0: 86, Field1: 86, Field2: 40}, {Field0: 87, Field1: 87, Field2: 41}, {Field0: 88, Field1: 88, Field2: 42}, {Field0: 89, Field1: 89, Field2: 43}, {Field0: 90, Field1: 90, Field2: 44}, {Field0: 91, Field1: 91, Field2: 45}, {Field0: 92, Field1: 92, Field2: 46}, {Field0: 93, Field1: 93, Field2: 47}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 96, Field1: 96, Field2: 95}, {Field0: 97, Field1: 97, Field2: 96}, {Field0: 98, Field1: 98, Field2: 97}, {Field0: 99, Field1: 99, Field2: 98}, {Field0: 100, Field1: 100, Field2: 99}, {Field0: 101, Field1: 101, Field2: 100}, {Field0: 102, Field1: 102, Field2: 101}, {Field0: 103, Field1: 103, Field2: 102}, {Field0: 104, Field1: 104, Field2: 103}, {Field0: 105, Field1: 105, Field2: 104}, {Field0: 106, Field1: 106, Field2: 107}, {Field0: 107, Field1: 107, Field2: 109}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 109, Field1: 109, Field2: 108}, {Field0: 110, Field1: 110, Field2: 105}, {Field0: 111, Field1: 111, Field2: 106}, {Field0: 112, Field1: 112, Field2: 70}, {Field0: 113, Field1: 113, Field2: 71}, {Field0: 114, Field1: 114, Field2: 72}, {Field0: 115, Field1: 115, Field2: 73}, {Field0: 116, Field1: 116, Field2: 74}, {Field0: 117, Field1: 117, Field2: 75}, {Field0: 118, Field1: 118, Field2: 76}, {Field0: 119, Field1: 119, Field2: 77}, {Field0: 120, Field1: 120, Field2: 78}, {Field0: 121, Field1: 121, Field2: 79}, {Field0: 122, Field1: 122, Field2: 80}, {Field0: 123, Field1: 123, Field2: 81}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 144, Field1: 144, Field2: 67}, {Field0: 145, Field1: 145, Field2: 66}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 314159265, Field1: 0, Field2: 0}, {Field0: 161, Field1: 161, Field2: 49}, {Field0: 162, Field1: 162, Field2: 50}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}, {Field0: 0, Field1: 0, Field2: 0}], counter: 96}, k_49627);
framePtr = F.prev;
return result_49628;
}
function initevents_53201() {

function keyev_53204(e_53207) {

var F={procname:"initEvents.keyev",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
emit_51410(result_53203[0], makeNimstrLit("keyEv"), {kind: 0, key: tojskc_49625(e_53207.keyCode), mods: 0, button: 0, kmods: 0, pos: {Field0: 0.0, Field1: 0.0}, dt: 0.0});
framePtr = F.prev;
}
var result_53203 = [{s: null}];
var F={procname:"events.initEvents",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
F.line = 147;
nimCopy(result_53203[0], initeventemitter_51418(), NTI51036);
document.addEventListener("keypress", keyev_53204, true);
framePtr = F.prev;
return result_53203[0];
}
var evloop_66001 = /**/[initevents_53201()];
function getcontextwebgl_56122(c_56124) {

var result_56125 = null;
var F={procname:"webgl.getContextWebGL",prev:framePtr,filename:"/data/data/com.termux/files/home/.nimble/pkgs/webgl/webgl.nim",line:0};
framePtr = F;
F.line = 329;
result_56125 = c_56124.getContext('webgl') || c_56124.getContext('experimental-webgl');framePtr = F.prev;
return result_56125;
}
function initwindow_57206(w_57208, h_57209) {

var Tmp1;
var result_57210 = {ctx: null, width: 0, height: 0};
var F={procname:"windows.initWindow",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/windows.nim",line:0};
framePtr = F;
F.line = 18;
var canvas_57211 = document.getElementById("niwe-canvas");
if (!((w_57208 == -1))) Tmp1 = true; else {Tmp1 = !((h_57209 == -1)); }if (Tmp1) {
F.line = 20;
canvas_57211.width = w_57208;
F.line = 21;
canvas_57211.height = h_57209;
}

F.line = 23;
result_57210.ctx = getcontextwebgl_56122(canvas_57211);
F.line = 24;
result_57210.width = canvas_57211.width;
F.line = 25;
result_57210.height = canvas_57211.height;
F.line = 26;
console.log(result_57210.width,result_57210.height);framePtr = F.prev;
return result_57210;
}
var w_66002 = /**/[initwindow_57206(-1, -1)];
function rotl_59802(x_59804, k_59805) {

var result_59806 = 0;
var F={procname:"random.rotl",prev:framePtr,filename:"lib/pure/random.nim",line:0};
framePtr = F;
F.line = 44;
result_59806 = ((x_59804 << k_59805) | ((x_59804 >>> 0) >>> ((64 - k_59805) >>> 0)));
framePtr = F.prev;
return result_59806;
}
function next_59845(s_59848) {

var result_59849 = 0;
var F={procname:"random.next",prev:framePtr,filename:"lib/pure/random.nim",line:0};
framePtr = F;
F.line = 47;
var s0_59850 = s_59848.a0;
F.line = 48;
var s1_59851 = s_59848.a1;
F.line = 49;
result_59849 = ((s0_59850 + s1_59851) >>> 0);
F.line = 50;
s1_59851 = (s1_59851 ^ s0_59850);
F.line = 51;
s_59848.a0 = ((rotl_59802(s0_59850, 55) ^ s1_59851) ^ (s1_59851 << 14));
F.line = 52;
s_59848.a1 = rotl_59802(s1_59851, 36);
framePtr = F.prev;
return result_59849;
}
function random_60327(max_60329) {

var result_60330 = 0.0;
var F={procname:"random.random",prev:framePtr,filename:"lib/pure/random.nim",line:0};
framePtr = F;
F.line = 89;
var x_60332 = next_59845(state_59605[0]);
F.line = 91;
result_60330 = ((x_60332 / 4294967295) * max_60329);
framePtr = F.prev;
return result_60330;
}
w_66002[0].ctx.clearColor(random_60327(1.0000000000000000e+00), random_60327(1.0000000000000000e+00), random_60327(1.0000000000000000e+00), 1.0000000000000000e+00);
w_66002[0].ctx.clear(16384);
function initeventhandler_51049(name_51051) {

var result_51052 = {Field0: null, Field1: null};
var F={procname:"events.initEventHandler",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
F.line = 71;
result_51052.Field1 = nimCopy(null, [], NTI51068);
F.line = 72;
result_51052.Field0 = nimCopy(null, name_51051, NTI138);
framePtr = F.prev;
return result_51052;
}
function addhandler_51069(handler_51072, fn_51076) {

var F={procname:"events.addHandler",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
if (handler_51072.Field1 != null) { handler_51072.Field1.push(fn_51076); } else { handler_51072.Field1 = [fn_51076]; };
framePtr = F.prev;
}
function on_51279(emitter_51282, event_51283, fn_51287) {

var F={procname:"events.on",prev:framePtr,filename:"/data/data/com.termux/files/home/proj/niwe/niwe/events.nim",line:0};
framePtr = F;
F.line = 102;
var i_51288 = geteventhandler_51255(emitter_51282, event_51283);
if ((i_51288 < 0)) {
F.line = 104;
var eh_51289 = /**/[initeventhandler_51049(event_51283)];
addhandler_51069(eh_51289[0], fn_51287);
if (emitter_51282.s != null) { emitter_51282.s.push(eh_51289[0]); } else { emitter_51282.s = [eh_51289[0]]; };
}
else {
addhandler_51069(emitter_51282.s[chckIndx(i_51288, 0, emitter_51282.s.length)-0], fn_51287);
}

framePtr = F.prev;
}
function handlemouseevent_66003(e_66005) {

var F={procname:"ex1.handleMouseEvent",prev:framePtr,filename:"ex1.nim",line:0};
framePtr = F;
w_66002[0].ctx.clearColor(random_60327(1.0000000000000000e+00), random_60327(1.0000000000000000e+00), random_60327(1.0000000000000000e+00), 1.0000000000000000e+00);
w_66002[0].ctx.clear(16384);
framePtr = F.prev;
}
on_51279(evloop_66001[0], makeNimstrLit("mouseEv"), handlemouseevent_66003);
