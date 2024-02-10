# ReNode_bindingHelpers.sqf

## nodeModule_register(_name)

Type: constant

Description: 
- Param: _name

Replaced value:
```sqf
node_system_group(_name) \
__nodemodule_common_path__ = "undefined."+_name; \
__nodemodule_common_icon__ = ""; \
__nodemodule_common_clrstyle__ = ""; \
__nodemodule_common_renderType__ = ""; \
__nodemodule_common_exectype__ = ""; \
__nodemodule_common_data__ = "";
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 6](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L6)
## nodeModule_setPath(_path)

Type: constant

Description: 
- Param: _path

Replaced value:
```sqf
__nodemodule_common_path__ = _path;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 14](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L14)
## nodeModule_addPath(_path)

Type: constant

Description: 
- Param: _path

Replaced value:
```sqf
__nodemodule_common_path__ = __nodemodule_common_path__ + "." + _path;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 15](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L15)
## nodeModule_popPath(_lvl)

Type: constant

Description: 
- Param: _lvl

Replaced value:
```sqf
__prvd_path_splited = (__nodemodule_common_path__ splitString "."); \
if ((count __prvd_path_splited)-_lvl > 0) then { \
    reverse __prvd_path_splited; \
    for "_i__" from 0 to _lvl do {__prvd_path_splited deleteAt 0}; \
    reverse __prvd_path_splited; \
    __nodemodule_common_path__ = __prvd_path_splited joinString "."; \
};
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 16](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L16)
## nodeModule_setIcon(_icoPath)

Type: constant

Description: 
- Param: _icoPath

Replaced value:
```sqf
__nodemodule_common_icon__ = _icoPath;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 24](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L24)
## nodeModule_setColorStyle(_clr)

Type: constant

Description: 
- Param: _clr

Replaced value:
```sqf
__nodemodule_common_clrstyle__ = _clr;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 25](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L25)
## nodeModule_setRenderType(_rndr)

Type: constant

Description: 
- Param: _rndr

Replaced value:
```sqf
__nodemodule_common_renderType__ = _rndr;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 26](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L26)
## nodeModule_setExecType(_et)

Type: constant

Description: 
- Param: _et

Replaced value:
```sqf
__nodemodule_common_exectype__ = _et;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 27](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L27)
## nodeModule_commonData

Type: constant

Description: 


Replaced value:
```sqf
__nodemodule_common_data__ = 
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 28](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L28)
## reg_binary

Type: constant

Description: 


Replaced value:
```sqf
call _reg_binary_function;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 30](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L30)
## reg_unary

Type: constant

Description: 


Replaced value:
```sqf
call _reg_unary_function;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 31](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L31)
## reg_nular

Type: constant

Description: 


Replaced value:
```sqf
call _reg_nular_function;
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 32](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L32)
## opt

Type: constant

Description: 


Replaced value:
```sqf
+ endl + "    opt:"+
```
File: [host\ReNode\ReNode_bindingHelpers.sqf at line 34](../../../Src/host/ReNode/ReNode_bindingHelpers.sqf#L34)
# ReNode_init.sqf

## nodegen_const_libversion

Type: Variable

Description: текущая версия библиотеки для генерации


Initial value:
```sqf
1
```
File: [host\ReNode\ReNode_init.sqf at line 16](../../../Src/host/ReNode/ReNode_init.sqf#L16)
## nodegen_scriptClassesFolder

Type: Variable

Description: Пути загрузчика скриптов


Initial value:
```sqf
"src\host\ReNode\compiled"
```
File: [host\ReNode\ReNode_init.sqf at line 19](../../../Src/host/ReNode/ReNode_init.sqf#L19)
## nodegen_scriptClassesLoader

Type: Variable

Description: 


Initial value:
```sqf
nodegen_scriptClassesFolder + "\script_list.hpp"
```
File: [host\ReNode\ReNode_init.sqf at line 20](../../../Src/host/ReNode/ReNode_init.sqf#L20)
## nodegen_str_outputJsonData

Type: Variable

Description: 


Initial value:
```sqf
"" //сгенерированный json
```
File: [host\ReNode\ReNode_init.sqf at line 27](../../../Src/host/ReNode/ReNode_init.sqf#L27)
## nodegen_internal_generatedLibPath

Type: Variable

Description: сгенерированный json


Initial value:
```sqf
"" //сюда записывается сгенерированный json файл
```
File: [host\ReNode\ReNode_init.sqf at line 28](../../../Src/host/ReNode/ReNode_init.sqf#L28)
## nodegen_objlibPath

Type: Variable

Description: сюда записывается сгенерированный json файл


Initial value:
```sqf
"src\host\ReNode\lib.obj" //!deprecated
```
File: [host\ReNode\ReNode_init.sqf at line 30](../../../Src/host/ReNode/ReNode_init.sqf#L30)
## nodegen_debug_copyobjlibPath

Type: Variable

Description: !deprecated


Initial value:
```sqf
"P:\Project\ReNodes\lib.obj"
```
File: [host\ReNode\ReNode_init.sqf at line 31](../../../Src/host/ReNode/ReNode_init.sqf#L31)
## nodegen_debug_copyobjguidPath

Type: Variable

Description: 


Initial value:
```sqf
"P:\Project\ReNodes\lib_guid"
```
File: [host\ReNode\ReNode_init.sqf at line 32](../../../Src/host/ReNode/ReNode_init.sqf#L32)
## nodegen_cleanupClassData

Type: function

Description: вызывается перед компиляцией классов


File: [host\ReNode\ReNode_init.sqf at line 35](../../../Src/host/ReNode/ReNode_init.sqf#L35)
## nodegen_addClassMethod

Type: function

Description: регистратор метода
- Param: _ctx

File: [host\ReNode\ReNode_init.sqf at line 40](../../../Src/host/ReNode/ReNode_init.sqf#L40)
## nodegen_addClassField

Type: function

Description: 
- Param: _ctx

File: [host\ReNode\ReNode_init.sqf at line 45](../../../Src/host/ReNode/ReNode_init.sqf#L45)
## nodegen_addClass

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 50](../../../Src/host/ReNode/ReNode_init.sqf#L50)
## nodegen_addFunction

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 60](../../../Src/host/ReNode/ReNode_init.sqf#L60)
## nodegen_addSystemNode

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 91](../../../Src/host/ReNode/ReNode_init.sqf#L91)
## nodegen_addEnumerator

Type: function

Description: 
- Param: _nodename
- Param: _members
- Param: _pdata (optional, default '')

File: [host\ReNode\ReNode_init.sqf at line 100](../../../Src/host/ReNode/ReNode_init.sqf#L100)
## nodegen_addStruct

Type: function

Description: 
- Param: _nodename
- Param: _members
- Param: _pdata

File: [host\ReNode\ReNode_init.sqf at line 129](../../../Src/host/ReNode/ReNode_init.sqf#L129)
## nodegen_commonAdd

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 147](../../../Src/host/ReNode/ReNode_init.sqf#L147)
## nodegen_commonSysAdd

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 162](../../../Src/host/ReNode/ReNode_init.sqf#L162)
## nodegen_registerFunctions

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 177](../../../Src/host/ReNode/ReNode_init.sqf#L177)
## nodegen_registerMember

Type: function

Description: 
- Param: _t
- Param: _class
- Param: _memname
- Param: _contextList

File: [host\ReNode\ReNode_init.sqf at line 181](../../../Src/host/ReNode/ReNode_init.sqf#L181)
## nodegen_registerClass

Type: function

Description: 
- Param: _t
- Param: _class
- Param: _data

File: [host\ReNode\ReNode_init.sqf at line 186](../../../Src/host/ReNode/ReNode_init.sqf#L186)
## nodegen_generateLib

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 191](../../../Src/host/ReNode/ReNode_init.sqf#L191)
## nodegen_loadClasses

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 396](../../../Src/host/ReNode/ReNode_init.sqf#L396)
