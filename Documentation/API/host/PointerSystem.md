# GarbageCollector.sqf

## gc_onUpdate

Type: function

Description: Очистка мусора


File: [host\PointerSystem\GarbageCollector.sqf at line 12](../../../Src/host/PointerSystem/GarbageCollector.sqf#L12)
## gc_collect

Type: function

Description: 


File: [host\PointerSystem\GarbageCollector.sqf at line 28](../../../Src/host/PointerSystem/GarbageCollector.sqf#L28)
# Pointer.sqf

## pointer_getLastPointer

Type: function

Description: 


File: [host\PointerSystem\Pointer.sqf at line 19](../../../Src/host/PointerSystem/Pointer.sqf#L19)
## pointer_create

Type: function

Description: 
- Param: _ref

File: [host\PointerSystem\Pointer.sqf at line 23](../../../Src/host/PointerSystem/Pointer.sqf#L23)
## pointer_del

Type: function

Description: 


File: [host\PointerSystem\Pointer.sqf at line 47](../../../Src/host/PointerSystem/Pointer.sqf#L47)
## pointer_isExists

Type: function

Description: 


File: [host\PointerSystem\Pointer.sqf at line 58](../../../Src/host/PointerSystem/Pointer.sqf#L58)
## pointer_memoryClear

Type: function

Description: Полная очистка и пересоздание объекта


File: [host\PointerSystem\Pointer.sqf at line 73](../../../Src/host/PointerSystem/Pointer.sqf#L73)
# pointers.hpp

## pointer_new(ref)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: create and return pointer
- Param: ref

Replaced value:
```sqf
((ref) call pointer_create)
```
File: [host\PointerSystem\pointers.hpp at line 10](../../../Src/host/PointerSystem/pointers.hpp#L10)
## pointer_delete(ref)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: 
- Param: ref

Replaced value:
```sqf
(ref) call pointer_del
```
File: [host\PointerSystem\pointers.hpp at line 12](../../../Src/host/PointerSystem/pointers.hpp#L12)
## pointer_exists(id)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: 
- Param: id

Replaced value:
```sqf
(id) call pointer_isExists
```
File: [host\PointerSystem\pointers.hpp at line 14](../../../Src/host/PointerSystem/pointers.hpp#L14)
## pointer_get(id)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: 
- Param: id

Replaced value:
```sqf
(pointerList getOrDefault [id,'_nf_'])
```
File: [host\PointerSystem\pointers.hpp at line 16](../../../Src/host/PointerSystem/pointers.hpp#L16)
## pointer_isValidResult(result)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: 
- Param: result

Replaced value:
```sqf
(!(result isEqualTo "_nf_"))
```
File: [host\PointerSystem\pointers.hpp at line 18](../../../Src/host/PointerSystem/pointers.hpp#L18)
## pointer_tryUnpack(_ref,_varName)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: 
- Param: _ref
- Param: _varName

Replaced value:
```sqf
private _varName = (pointerList getVariable [_ref,locationNull])
```
File: [host\PointerSystem\pointers.hpp at line 21](../../../Src/host/PointerSystem/pointers.hpp#L21)
## pointer_tryUnpackLazy(_ref,_varName)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** defined

Description: 
- Param: _ref
- Param: _varName

Replaced value:
```sqf
pointer_tryUnpack(_ref,_varName); if (ISNULL _varName) exitWith {};
```
File: [host\PointerSystem\pointers.hpp at line 21](../../../Src/host/PointerSystem/pointers.hpp#L21)
## pointer_new(ref)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** not defined

Description: create and return pointer
- Param: ref

Replaced value:
```sqf
((ref) call pointer_create)
```
File: [host\PointerSystem\pointers.hpp at line 25](../../../Src/host/PointerSystem/pointers.hpp#L25)
## pointer_delete(ref)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** not defined

Description: 
- Param: ref

Replaced value:
```sqf
(ref) call pointer_del
```
File: [host\PointerSystem\pointers.hpp at line 27](../../../Src/host/PointerSystem/pointers.hpp#L27)
## pointer_exists(id)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** not defined

Description: 
- Param: id

Replaced value:
```sqf
(id) call pointer_isExists
```
File: [host\PointerSystem\pointers.hpp at line 29](../../../Src/host/PointerSystem/pointers.hpp#L29)
## pointer_get(id)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** not defined

Description: 
- Param: id

Replaced value:
```sqf
(pointerList getvariable [id,'_nf_'])
```
File: [host\PointerSystem\pointers.hpp at line 31](../../../Src/host/PointerSystem/pointers.hpp#L31)
## pointer_isValidResult(result)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** not defined

Description: 
- Param: result

Replaced value:
```sqf
(!(result isEqualTo "_nf_"))
```
File: [host\PointerSystem\pointers.hpp at line 33](../../../Src/host/PointerSystem/pointers.hpp#L33)
## pointer_tryUnpackLazy(_ref,_varName)

Type: constant

> Exists if **POINTER_SYSTEM_EXPERIMENTAL** not defined

Description: 
- Param: _ref
- Param: _varName

Replaced value:
```sqf
pointer_tryUnpack(_ref,_varName); if (ISNULL _varName) exitWith {};
```
File: [host\PointerSystem\pointers.hpp at line 36](../../../Src/host/PointerSystem/pointers.hpp#L36)
