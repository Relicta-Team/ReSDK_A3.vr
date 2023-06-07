# oop_attributes.sqf

## newAttribute(name)

Type: constant
Description: 
- Param: name

Replaced value:
```sqf
_oop_attr_last_name = 'name'; oop_attr_##name = { params ['_thisClass',["_attributeParams",[]]];
```
File: [host\OOP_engine\oop_attributes.sqf at line 11](../../../src/host/OOP_engine/oop_attributes.sqf#L11)
## thisClass

Type: constant
Description: 


Replaced value:
```sqf
_thisClass
```
File: [host\OOP_engine\oop_attributes.sqf at line 13](../../../src/host/OOP_engine/oop_attributes.sqf#L13)
## thisParams

Type: constant
Description: 


Replaced value:
```sqf
_attributeParams
```
File: [host\OOP_engine\oop_attributes.sqf at line 14](../../../src/host/OOP_engine/oop_attributes.sqf#L14)
## hasParams

Type: constant
Description: 


Replaced value:
```sqf
not_equals(thisParams,[])
```
File: [host\OOP_engine\oop_attributes.sqf at line 15](../../../src/host/OOP_engine/oop_attributes.sqf#L15)
## getClassName

Type: constant
Description: 


Replaced value:
```sqf
(thisClass getVariable 'classname')
```
File: [host\OOP_engine\oop_attributes.sqf at line 16](../../../src/host/OOP_engine/oop_attributes.sqf#L16)
## getMemeber(name)

Type: constant
Description: 
- Param: name

Replaced value:
```sqf
(thisClass getVariable 'name')
```
File: [host\OOP_engine\oop_attributes.sqf at line 17](../../../src/host/OOP_engine/oop_attributes.sqf#L17)
## getMemberReflect(name)

Type: constant
Description: 
- Param: name

Replaced value:
```sqf
(thisClass getVariable (name))
```
File: [host\OOP_engine\oop_attributes.sqf at line 18](../../../src/host/OOP_engine/oop_attributes.sqf#L18)
## hasMember(name)

Type: constant
Description: 
- Param: name

Replaced value:
```sqf
!isNull(getMemeber(name))
```
File: [host\OOP_engine\oop_attributes.sqf at line 19](../../../src/host/OOP_engine/oop_attributes.sqf#L19)
## setMember(name,value)

Type: constant
Description: 
- Param: name
- Param: value

Replaced value:
```sqf
thisClass setVariable ['name',value]
```
File: [host\OOP_engine\oop_attributes.sqf at line 20](../../../src/host/OOP_engine/oop_attributes.sqf#L20)
## setMemberReflect(name,value)

Type: constant
Description: 
- Param: name
- Param: value

Replaced value:
```sqf
thisClass setVariable [name,value]
```
File: [host\OOP_engine\oop_attributes.sqf at line 21](../../../src/host/OOP_engine/oop_attributes.sqf#L21)
## endAttribute

Type: constant
Description: 


Replaced value:
```sqf
}; ["(OOP) Attribute '" + _oop_attr_last_name + "' loaded."] call logInfo;
```
File: [host\OOP_engine\oop_attributes.sqf at line 22](../../../src/host/OOP_engine/oop_attributes.sqf#L22)
## ITEM_SIZE_TINY

Type: constant
Description: 5 большие предметы: винтовка,канистра; 6 огромные: складной стул, гранатомёт )


Replaced value:
```sqf
1
```
File: [host\OOP_engine\oop_attributes.sqf at line 197](../../../src/host/OOP_engine/oop_attributes.sqf#L197)
## ITEM_SIZE_SMALL

Type: constant
Description: 


Replaced value:
```sqf
2
```
File: [host\OOP_engine\oop_attributes.sqf at line 198](../../../src/host/OOP_engine/oop_attributes.sqf#L198)
## ITEM_SIZE_MEDIUM

Type: constant
Description: 


Replaced value:
```sqf
3
```
File: [host\OOP_engine\oop_attributes.sqf at line 199](../../../src/host/OOP_engine/oop_attributes.sqf#L199)
## ITEM_SIZE_LARGE

Type: constant
Description: 


Replaced value:
```sqf
4
```
File: [host\OOP_engine\oop_attributes.sqf at line 200](../../../src/host/OOP_engine/oop_attributes.sqf#L200)
## ITEM_SIZE_BIG

Type: constant
Description: 


Replaced value:
```sqf
5
```
File: [host\OOP_engine\oop_attributes.sqf at line 201](../../../src/host/OOP_engine/oop_attributes.sqf#L201)
## ITEM_SIZE_HUGE

Type: constant
Description: 


Replaced value:
```sqf
6
```
File: [host\OOP_engine\oop_attributes.sqf at line 202](../../../src/host/OOP_engine/oop_attributes.sqf#L202)
## name

Type: function
Description: 
- Param: _thisClass
- Param: _attributeParams (optional, default [])

File: [host\OOP_engine\oop_attributes.sqf at line 11](../../../src/host/OOP_engine/oop_attributes.sqf#L11)
# oop_init.sqf

## NULLCLASS

Type: constant
Description: inheritance


Replaced value:
```sqf
"<NAN_CLASS>"
```
File: [host\OOP_engine\oop_init.sqf at line 12](../../../src/host/OOP_engine/oop_init.sqf#L12)
## EXIT_IF_ERROR(mes)

Type: constant
Description: 
- Param: mes

Replaced value:
```sqf
if (_iserror || server_isLocked) exitWith {error(mes); [mes] call logCritical}
```
File: [host\OOP_engine\oop_init.sqf at line 13](../../../src/host/OOP_engine/oop_init.sqf#L13)
## shell_init(__name__system,__value__system)

Type: constant
Description: 
- Param: __name__system
- Param: __value__system

Replaced value:
```sqf
format["_thisobj setvariable ['%1',%2]; ",__name__system,__value__system]
```
File: [host\OOP_engine\oop_init.sqf at line 14](../../../src/host/OOP_engine/oop_init.sqf#L14)
## logoop(mes)

Type: constant
Description: 
- Param: mes

Replaced value:
```sqf
"debug_console" callExtension ("[OOP]:    " + (mes) + "#0111"); ["(OOP_init)	%1",mes] call logInfo
```
File: [host\OOP_engine\oop_init.sqf at line 15](../../../src/host/OOP_engine/oop_init.sqf#L15)
## logoop(mes)

Type: constant
> Exists if **_SQFVM** defined
Description: 
- Param: mes

Replaced value:
```sqf
diag_log format["[OOP_init]: %1",mes]
```
File: [host\OOP_engine\oop_init.sqf at line 18](../../../src/host/OOP_engine/oop_init.sqf#L18)
## allocName

Type: constant
Description: 


Replaced value:
```sqf
this setName "%2"
```
File: [host\OOP_engine\oop_init.sqf at line 56](../../../src/host/OOP_engine/oop_init.sqf#L56)
# oop_object.sqf

## basic()

Type: constant
Description: 
- Param: 

Replaced value:
```sqf
_mother = TYPE_SUPER_BASE;
```
File: [host\OOP_engine\oop_object.sqf at line 9](../../../src/host/OOP_engine/oop_object.sqf#L9)
# oop_preinit.sqf

## NULLCLASS

Type: constant
Description: 


Replaced value:
```sqf
"<NAN_CLASS>"
```
File: [host\OOP_engine\oop_preinit.sqf at line 10](../../../src/host/OOP_engine/oop_preinit.sqf#L10)
## PTR_SIZE

Type: constant
Description: 


Replaced value:
```sqf
8
```
File: [host\OOP_engine\oop_preinit.sqf at line 46](../../../src/host/OOP_engine/oop_preinit.sqf#L46)
## oop_deleteObject

Type: function
Description: for deleting object


File: [host\OOP_engine\oop_preinit.sqf at line 36](../../../src/host/OOP_engine/oop_preinit.sqf#L36)
## oop_getobjsize

Type: function
Description: Получает размер объекта в байтах


File: [host\OOP_engine\oop_preinit.sqf at line 49](../../../src/host/OOP_engine/oop_preinit.sqf#L49)
## oop_getTypeSize

Type: function
Description: 


File: [host\OOP_engine\oop_preinit.sqf at line 64](../../../src/host/OOP_engine/oop_preinit.sqf#L64)
## oop_getTypeSizeFull

Type: function
Description: 


File: [host\OOP_engine\oop_preinit.sqf at line 86](../../../src/host/OOP_engine/oop_preinit.sqf#L86)
## oop_getSimpleTypeSize

Type: function
Description: 


File: [host\OOP_engine\oop_preinit.sqf at line 108](../../../src/host/OOP_engine/oop_preinit.sqf#L108)
## oop_getinhlist

Type: function
Description: 
- Param: _typename
- Param: _recurs
- Param: _refarr

File: [host\OOP_engine\oop_preinit.sqf at line 123](../../../src/host/OOP_engine/oop_preinit.sqf#L123)
## oop_getFieldBaseValue

Type: function
Description: _altMethodNameIfNil - возвращает альтернативный метод геттера по которому будет осуществлён поиск и получение значения
- Param: _type
- Param: _field
- Param: _doCompile (optional, default false)
- Param: _altMethodNameIfNil (optional, default "")

File: [host\OOP_engine\oop_preinit.sqf at line 154](../../../src/host/OOP_engine/oop_preinit.sqf#L154)
## oop_getData

Type: function
Description: 
- Param: _obj

File: [host\OOP_engine\oop_preinit.sqf at line 176](../../../src/host/OOP_engine/oop_preinit.sqf#L176)
## oop_injectToMethod

Type: function
Description: 
- Param: _type
- Param: _metname
- Param: _code
- Param: _sect (optional, default "end")
- Param: _overrideChild (optional, default false)

File: [host\OOP_engine\oop_preinit.sqf at line 230](../../../src/host/OOP_engine/oop_preinit.sqf#L230)
