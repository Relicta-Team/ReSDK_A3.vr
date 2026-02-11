# init.sqf

## rve_const_libs

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\RVEngine\init.sqf at line 15](../../../Src/host/RVEngine/init.sqf#L15)
## rve_loaded

Type: Variable

Description: 


Initial value:
```sqf
(call (uiNamespace getVariable ["INTERCEPT_BOOT_DONE",...
```
File: [host\RVEngine\init.sqf at line 95](../../../Src/host/RVEngine/init.sqf#L95)
## rve_invoker_ok

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\RVEngine\init.sqf at line 65](../../../Src/host/RVEngine/init.sqf#L65)
## rve_log

Type: function

Description: 
- Param: _message

File: [host\RVEngine\init.sqf at line 24](../../../Src/host/RVEngine/init.sqf#L24)
## rve_getVersion

Type: function

Description: 


File: [host\RVEngine\init.sqf at line 32](../../../Src/host/RVEngine/init.sqf#L32)
## rve_hasHostDll

Type: function

Description: 


File: [host\RVEngine\init.sqf at line 36](../../../Src/host/RVEngine/init.sqf#L36)
## rve_event

Type: function

Description: 


File: [host\RVEngine\init.sqf at line 47](../../../Src/host/RVEngine/init.sqf#L47)
## rve_signal

Type: function

Description: 


File: [host\RVEngine\init.sqf at line 57](../../../Src/host/RVEngine/init.sqf#L57)
## rve_signalRet

Type: function

Description: 


File: [host\RVEngine\init.sqf at line 59](../../../Src/host/RVEngine/init.sqf#L59)
## rve_exportOpList

Type: function

Description: 


File: [host\RVEngine\init.sqf at line 67](../../../Src/host/RVEngine/init.sqf#L67)
## rve_callWrapper

Type: function

Description: 
- Param: _args
- Param: _code

File: [host\RVEngine\init.sqf at line 72](../../../Src/host/RVEngine/init.sqf#L72)
## rve_isNilWrapper

Type: function

Description: 
- Param: _args
- Param: _code

File: [host\RVEngine\init.sqf at line 79](../../../Src/host/RVEngine/init.sqf#L79)
# libmanager.sqf

## rve_internal_libmap

Type: Variable

Description: 


Initial value:
```sqf
createhashmap
```
File: [host\RVEngine\libmanager.sqf at line 6](../../../Src/host/RVEngine/libmanager.sqf#L6)
## rve_loadlib

Type: function

Description: 
- Param: _libName

File: [host\RVEngine\libmanager.sqf at line 8](../../../Src/host/RVEngine/libmanager.sqf#L8)
## rve_unloadlib

Type: function

Description: 
- Param: _libName

File: [host\RVEngine\libmanager.sqf at line 21](../../../Src/host/RVEngine/libmanager.sqf#L21)
## rve_getloadedlibs

Type: function

Description: 


File: [host\RVEngine\libmanager.sqf at line 33](../../../Src/host/RVEngine/libmanager.sqf#L33)
## rve_hasloadedlib

Type: function

Description: 


File: [host\RVEngine\libmanager.sqf at line 37](../../../Src/host/RVEngine/libmanager.sqf#L37)
## rve_unloadall

Type: function

Description: 


File: [host\RVEngine\libmanager.sqf at line 41](../../../Src/host/RVEngine/libmanager.sqf#L41)
## rve_debug_reloadlibs

Type: function

> Exists if **EDITOR** defined

Description: 


File: [host\RVEngine\libmanager.sqf at line 48](../../../Src/host/RVEngine/libmanager.sqf#L48)
# native_func.sqf

## rve_nativeFunc

Type: function

Description: 
- Param: _module
- Param: _fname
- Param: _condString (optional, default "rve_loaded")

File: [host\RVEngine\native_func.sqf at line 10](../../../Src/host/RVEngine/native_func.sqf#L10)
# RVEngine.hpp

## RVENGINE_ISREADY

Type: constant

Description: 


Replaced value:
```sqf
(rve_loaded)
```
File: [host\RVEngine\RVEngine.hpp at line 6](../../../Src/host/RVEngine/RVEngine.hpp#L6)
## RVENGINE_INTERNAL_TOSTRING__(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
#x
```
File: [host\RVEngine\RVEngine.hpp at line 8](../../../Src/host/RVEngine/RVEngine.hpp#L8)
## RVENGINE_REGISTER_NFUNC(module__,fname__)

Type: constant

Description: 
- Param: module__
- Param: fname__

Replaced value:
```sqf
[module__, RVENGINE_INTERNAL_TOSTRING__(fname__)] call rve_nativeFunc; \
[format["RVEngine: registered function %1 from %2",RVENGINE_INTERNAL_TOSTRING__(fname__),module__]] call rve_log;
```
File: [host\RVEngine\RVEngine.hpp at line 16](../../../Src/host/RVEngine/RVEngine.hpp#L16)
## RVENGINE_BEGIN_MODULE(module__)

Type: constant

Description: 
- Param: module__

Replaced value:
```sqf
_rve_condition__ = nil; _rve_mod__ = module__; _rve_regfunc__ = { [_rve_mod__, _x select 0, _x select 1] call rve_nativeFunc}; _rve_fncnames__ = [];
```
File: [host\RVEngine\RVEngine.hpp at line 32](../../../Src/host/RVEngine/RVEngine.hpp#L32)
## RVENGINE_DECL_NFUNC(fname__)

Type: constant

Description: 
- Param: fname__

Replaced value:
```sqf
_rve_fncnames__ pushBack [RVENGINE_INTERNAL_TOSTRING__(fname__),_rve_condition__];
```
File: [host\RVEngine\RVEngine.hpp at line 34](../../../Src/host/RVEngine/RVEngine.hpp#L34)
## RVENGINE_SET_WRAPPER_CONDITION(cond__)

Type: constant

Description: 
- Param: cond__

Replaced value:
```sqf
_rve_condition__ = RVENGINE_INTERNAL_TOSTRING__(cond__);
```
File: [host\RVEngine\RVEngine.hpp at line 36](../../../Src/host/RVEngine/RVEngine.hpp#L36)
## RVENGINE_END_MODULE

Type: constant

Description: 


Replaced value:
```sqf
_rve_regfunc__ foreach _rve_fncnames__; [format["RVEngine: registered %1 functions from %2",count _rve_fncnames__,_rve_mod__]] call rve_log;
```
File: [host\RVEngine\RVEngine.hpp at line 38](../../../Src/host/RVEngine/RVEngine.hpp#L38)
