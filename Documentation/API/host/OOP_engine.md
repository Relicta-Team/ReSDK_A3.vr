# main.sqf

## testobj

Type: Variable

Description: 


Initial value:
```sqf
new(TestGameClass)
```
File: [host\OOP_engine\main.sqf at line 9](../../../Src/host/OOP_engine/main.sqf#L9)
# oop_attributes.sqf

## newAttribute(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
_oop_attr_last_name = 'name'; oop_attr_##name = { params ['_thisClass',["_attributeParams",[]]];
```
File: [host\OOP_engine\oop_attributes.sqf at line 11](../../../Src/host/OOP_engine/oop_attributes.sqf#L11)
## thisClass

Type: constant

Description: 


Replaced value:
```sqf
_thisClass
```
File: [host\OOP_engine\oop_attributes.sqf at line 13](../../../Src/host/OOP_engine/oop_attributes.sqf#L13)
## thisParams

Type: constant

Description: 


Replaced value:
```sqf
_attributeParams
```
File: [host\OOP_engine\oop_attributes.sqf at line 14](../../../Src/host/OOP_engine/oop_attributes.sqf#L14)
## hasParams

Type: constant

Description: 


Replaced value:
```sqf
not_equals(thisParams,[])
```
File: [host\OOP_engine\oop_attributes.sqf at line 15](../../../Src/host/OOP_engine/oop_attributes.sqf#L15)
## getClassName

Type: constant

Description: 


Replaced value:
```sqf
(thisClass getVariable 'classname')
```
File: [host\OOP_engine\oop_attributes.sqf at line 16](../../../Src/host/OOP_engine/oop_attributes.sqf#L16)
## getMemeber(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(thisClass getVariable 'name')
```
File: [host\OOP_engine\oop_attributes.sqf at line 17](../../../Src/host/OOP_engine/oop_attributes.sqf#L17)
## getMemberReflect(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
(thisClass getVariable (name))
```
File: [host\OOP_engine\oop_attributes.sqf at line 18](../../../Src/host/OOP_engine/oop_attributes.sqf#L18)
## hasMember(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
!isNull(getMemeber(name))
```
File: [host\OOP_engine\oop_attributes.sqf at line 19](../../../Src/host/OOP_engine/oop_attributes.sqf#L19)
## setMember(name,value)

Type: constant

Description: 
- Param: name
- Param: value

Replaced value:
```sqf
thisClass setVariable ['name',value]
```
File: [host\OOP_engine\oop_attributes.sqf at line 20](../../../Src/host/OOP_engine/oop_attributes.sqf#L20)
## setMemberReflect(name,value)

Type: constant

Description: 
- Param: name
- Param: value

Replaced value:
```sqf
thisClass setVariable [name,value]
```
File: [host\OOP_engine\oop_attributes.sqf at line 21](../../../Src/host/OOP_engine/oop_attributes.sqf#L21)
## endAttribute

Type: constant

Description: 


Replaced value:
```sqf
}; ["(OOP) Attribute '" + _oop_attr_last_name + "' loaded."] call logInfo;
```
File: [host\OOP_engine\oop_attributes.sqf at line 22](../../../Src/host/OOP_engine/oop_attributes.sqf#L22)
## rolesystem_internal_net_idx

Type: Variable

Description: 


Initial value:
```sqf
0 //internal var
```
File: [host\OOP_engine\oop_attributes.sqf at line 69](../../../Src/host/OOP_engine/oop_attributes.sqf#L69)
## name

Type: function

Description: 
- Param: _thisClass
- Param: _attributeParams (optional, default [])

File: [host\OOP_engine\oop_attributes.sqf at line 11](../../../Src/host/OOP_engine/oop_attributes.sqf#L11)
# oop_init.sqf

## NULLCLASS

Type: constant

Description: inheritance


Replaced value:
```sqf
"<NAN_CLASS>"
```
File: [host\OOP_engine\oop_init.sqf at line 12](../../../Src/host/OOP_engine/oop_init.sqf#L12)
## EXIT_IF_ERROR(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
if (_iserror || server_isLocked) exitWith {error(mes); [mes] call logCritical}
```
File: [host\OOP_engine\oop_init.sqf at line 13](../../../Src/host/OOP_engine/oop_init.sqf#L13)
## shell_init(__name__system,__value__system)

Type: constant

Description: 
- Param: __name__system
- Param: __value__system

Replaced value:
```sqf
format["_thisobj setvariable ['%1',%2]; ",__name__system,__value__system]
```
File: [host\OOP_engine\oop_init.sqf at line 14](../../../Src/host/OOP_engine/oop_init.sqf#L14)
## logoop(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
"debug_console" callExtension ("[OOP]:    " + (mes) + "#0111"); ["(OOP_init)	%1",mes] call logInfo
```
File: [host\OOP_engine\oop_init.sqf at line 15](../../../Src/host/OOP_engine/oop_init.sqf#L15)
## logoop(mes)

Type: constant

> Exists if **__VM_VALIDATE** defined

Description: 
- Param: mes

Replaced value:
```sqf
diag_log format["[OOP_init]: %1",mes]
```
File: [host\OOP_engine\oop_init.sqf at line 18](../../../Src/host/OOP_engine/oop_init.sqf#L18)
## EXIT_IF_ERROR(mes)

Type: constant

> Exists if **__VM_VALIDATE** defined

Description: 
- Param: mes

Replaced value:
```sqf
if (_iserror || server_isLocked) exitWith { diag_log format["[OOP_init]: [Critical]: %1",mes]; exitcode__ -10000; };
```
File: [host\OOP_engine\oop_init.sqf at line 19](../../../Src/host/OOP_engine/oop_init.sqf#L19)
## error(mes)

Type: constant

> Exists if **__VM_VALIDATE** defined

Description: 
- Param: mes

Replaced value:
```sqf
diag_log format["[OOP_init]: [Error]: %1",mes];
```
File: [host\OOP_engine\oop_init.sqf at line 20](../../../Src/host/OOP_engine/oop_init.sqf#L20)
## errorformat(mes,fmt)

Type: constant

> Exists if **__VM_VALIDATE** defined

Description: 
- Param: mes
- Param: fmt

Replaced value:
```sqf
diag_log format["[OOP_init]: [Error]: %1",format[mes,fmt]];
```
File: [host\OOP_engine\oop_init.sqf at line 21](../../../Src/host/OOP_engine/oop_init.sqf#L21)
## allocName

Type: constant

Description: 


Replaced value:
```sqf
this setName "%2"
```
File: [host\OOP_engine\oop_init.sqf at line 59](../../../Src/host/OOP_engine/oop_init.sqf#L59)
# oop_logging.sqf

## oop_upd

Type: Variable

Description: 


Initial value:
```sqf
0 // all update methods
```
File: [host\OOP_engine\oop_logging.sqf at line 7](../../../Src/host/OOP_engine/oop_logging.sqf#L7)
## oop_cao

Type: Variable

Description: all update methods


Initial value:
```sqf
0 // count active objects
```
File: [host\OOP_engine\oop_logging.sqf at line 9](../../../Src/host/OOP_engine/oop_logging.sqf#L9)
## oop_cco

Type: Variable

Description: count active objects


Initial value:
```sqf
0 // count created objects
```
File: [host\OOP_engine\oop_logging.sqf at line 10](../../../Src/host/OOP_engine/oop_logging.sqf#L10)
## oop_memuse

Type: Variable

Description: not used in engine


Initial value:
```sqf
0 //bytes
```
File: [host\OOP_engine\oop_logging.sqf at line 13](../../../Src/host/OOP_engine/oop_logging.sqf#L13)
# oop_object.sqf

## basic()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
_mother = TYPE_SUPER_BASE;
```
File: [host\OOP_engine\oop_object.sqf at line 9](../../../Src/host/OOP_engine/oop_object.sqf#L9)
# oop_preinit.sqf

## NULLCLASS

Type: constant

Description: 


Replaced value:
```sqf
"<NAN_CLASS>"
```
File: [host\OOP_engine\oop_preinit.sqf at line 10](../../../Src/host/OOP_engine/oop_preinit.sqf#L10)
## PTR_SIZE

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [host\OOP_engine\oop_preinit.sqf at line 46](../../../Src/host/OOP_engine/oop_preinit.sqf#L46)
## p_table_inheritance

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\OOP_engine\oop_preinit.sqf at line 32](../../../Src/host/OOP_engine/oop_preinit.sqf#L32)
## p_table_allclassnames

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\OOP_engine\oop_preinit.sqf at line 33](../../../Src/host/OOP_engine/oop_preinit.sqf#L33)
## oop_deleteObject

Type: function

Description: for deleting object


File: [host\OOP_engine\oop_preinit.sqf at line 36](../../../Src/host/OOP_engine/oop_preinit.sqf#L36)
## oop_getobjsize

Type: function

Description: Получает размер объекта в байтах


File: [host\OOP_engine\oop_preinit.sqf at line 49](../../../Src/host/OOP_engine/oop_preinit.sqf#L49)
## oop_getTypeSize

Type: function

Description: 


File: [host\OOP_engine\oop_preinit.sqf at line 64](../../../Src/host/OOP_engine/oop_preinit.sqf#L64)
## oop_getTypeSizeFull

Type: function

Description: 


File: [host\OOP_engine\oop_preinit.sqf at line 86](../../../Src/host/OOP_engine/oop_preinit.sqf#L86)
## oop_getSimpleTypeSize

Type: function

Description: 


File: [host\OOP_engine\oop_preinit.sqf at line 108](../../../Src/host/OOP_engine/oop_preinit.sqf#L108)
## oop_getinhlist

Type: function

Description: 
- Param: _typename
- Param: _recurs
- Param: _refarr

File: [host\OOP_engine\oop_preinit.sqf at line 123](../../../Src/host/OOP_engine/oop_preinit.sqf#L123)
## oop_getFieldBaseValue

Type: function

Description: _altMethodNameIfNil - возвращает альтернативный метод геттера по которому будет осуществлён поиск и получение значения
- Param: _type
- Param: _field
- Param: _doCompile (optional, default false)
- Param: _altMethodNameIfNil (optional, default "")

File: [host\OOP_engine\oop_preinit.sqf at line 154](../../../Src/host/OOP_engine/oop_preinit.sqf#L154)
## oop_getData

Type: function

Description: 
- Param: _obj

File: [host\OOP_engine\oop_preinit.sqf at line 176](../../../Src/host/OOP_engine/oop_preinit.sqf#L176)
## oop_injectToMethod

Type: function

Description: 
- Param: _type
- Param: _metname
- Param: _code
- Param: _sect (optional, default "end")
- Param: _overrideChild (optional, default false)

File: [host\OOP_engine\oop_preinit.sqf at line 230](../../../Src/host/OOP_engine/oop_preinit.sqf#L230)
