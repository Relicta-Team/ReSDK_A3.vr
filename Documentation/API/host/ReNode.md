# ReNode.h

## RENODE_MSG_TYPE_LOG

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\ReNode\ReNode.h at line 7](../../../Src/host/ReNode/ReNode.h#L7)
## RENODE_MSG_TYPE_WARNING

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\ReNode\ReNode.h at line 8](../../../Src/host/ReNode/ReNode.h#L8)
## RENODE_MSG_TYPE_ERROR

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\ReNode\ReNode.h at line 9](../../../Src/host/ReNode/ReNode.h#L9)
## RENODE_MSG_TYPE_TRACE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\ReNode\ReNode.h at line 10](../../../Src/host/ReNode/ReNode.h#L10)
## RENODE_MSG_CONSOLE_TYPE_LIST_NODE_BINDING

Type: constant

Description: 


Replaced value:
```sqf
['Лог:RENODE_MSG_TYPE_LOG:', \
    'Предупреждение:RENODE_MSG_TYPE_WARNING:', \
    'Ошибка:RENODE_MSG_TYPE_ERROR:', \
    'Трассировка:RENODE_MSG_TYPE_TRACE:']
```
File: [host\ReNode\ReNode.h at line 12](../../../Src/host/ReNode/ReNode.h#L12)
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
    for "_i__" from 1 to _lvl do {__prvd_path_splited deleteAt 0}; \
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
# ReNode_debugger.sqf

## nbp_sigsend

Type: function

Description: 
- Param: _id
- Param: _gpath

File: [host\ReNode\ReNode_debugger.sqf at line 6](../../../Src/host/ReNode/ReNode_debugger.sqf#L6)
## nbp_sendRet

Type: function

Description: 
- Param: _name
- Param: _data (optional, default [])
- Param: _retAsString (optional, default true)

File: [host\ReNode\ReNode_debugger.sqf at line 14](../../../Src/host/ReNode/ReNode_debugger.sqf#L14)
## nbp_send

Type: function

Description: 
- Param: _name
- Param: _data

File: [host\ReNode\ReNode_debugger.sqf at line 19](../../../Src/host/ReNode/ReNode_debugger.sqf#L19)
## nbp_initDebugger

Type: function

Description: 


File: [host\ReNode\ReNode_debugger.sqf at line 24](../../../Src/host/ReNode/ReNode_debugger.sqf#L24)
## nbp_isEditorConnected

Type: function

Description: 


File: [host\ReNode\ReNode_debugger.sqf at line 32](../../../Src/host/ReNode/ReNode_debugger.sqf#L32)
# ReNode_init.sqf

## nodegen_const_libversion

Type: Variable

Description: текущая версия библиотеки для генерации


Initial value:
```sqf
1
```
File: [host\ReNode\ReNode_init.sqf at line 19](../../../Src/host/ReNode/ReNode_init.sqf#L19)
## nodegen_scriptClassesFolder

Type: Variable

Description: Пути загрузчика скриптов


Initial value:
```sqf
"src\host\ReNode\compiled"
```
File: [host\ReNode\ReNode_init.sqf at line 22](../../../Src/host/ReNode/ReNode_init.sqf#L22)
## nodegen_scriptClassesLoader

Type: Variable

Description: 


Initial value:
```sqf
nodegen_scriptClassesFolder + "\script_list.hpp"
```
File: [host\ReNode\ReNode_init.sqf at line 23](../../../Src/host/ReNode/ReNode_init.sqf#L23)
## nodegen_str_outputJsonData

Type: Variable

Description: 


Initial value:
```sqf
"" //сгенерированный json
```
File: [host\ReNode\ReNode_init.sqf at line 30](../../../Src/host/ReNode/ReNode_init.sqf#L30)
## nodegen_internal_generatedLibPath

Type: Variable

Description: сгенерированный json


Initial value:
```sqf
"" //сюда записывается сгенерированный json файл
```
File: [host\ReNode\ReNode_init.sqf at line 31](../../../Src/host/ReNode/ReNode_init.sqf#L31)
## nodegen_objlibPath

Type: Variable

Description: сюда записывается сгенерированный json файл


Initial value:
```sqf
"ReNode\lib.obj"
```
File: [host\ReNode\ReNode_init.sqf at line 34](../../../Src/host/ReNode/ReNode_init.sqf#L34)
## nodegen_signLibExe

Type: Variable

Description: 


Initial value:
```sqf
"ReNode\ReNode.exe"
```
File: [host\ReNode\ReNode_init.sqf at line 35](../../../Src/host/ReNode/ReNode_init.sqf#L35)
## nodegen_debug_copyobjlibPath

Type: Variable

Description: 


Initial value:
```sqf
"P:\Project\ReNodes\lib.obj"
```
File: [host\ReNode\ReNode_init.sqf at line 36](../../../Src/host/ReNode/ReNode_init.sqf#L36)
## nodegen_debug_copyobjguidPath

Type: Variable

Description: 


Initial value:
```sqf
"P:\Project\ReNodes\lib_guid"
```
File: [host\ReNode\ReNode_init.sqf at line 37](../../../Src/host/ReNode/ReNode_init.sqf#L37)
## nodegen_canUse

Type: Variable

Description: 


Initial value:
```sqf
is3DEN || _genBindRBuilder
```
File: [host\ReNode\ReNode_init.sqf at line 44](../../../Src/host/ReNode/ReNode_init.sqf#L44)
## nodegen_cleanupClassData

Type: function

Description: вызывается перед компиляцией классов


File: [host\ReNode\ReNode_init.sqf at line 47](../../../Src/host/ReNode/ReNode_init.sqf#L47)
## nodegen_addClassMethod

Type: function

Description: регистратор метода
- Param: _ctx

File: [host\ReNode\ReNode_init.sqf at line 52](../../../Src/host/ReNode/ReNode_init.sqf#L52)
## nodegen_addClassField

Type: function

Description: 
- Param: _ctx

File: [host\ReNode\ReNode_init.sqf at line 57](../../../Src/host/ReNode/ReNode_init.sqf#L57)
## nodegen_addClass

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 62](../../../Src/host/ReNode/ReNode_init.sqf#L62)
## nodegen_addFunction

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 69](../../../Src/host/ReNode/ReNode_init.sqf#L69)
## nodegen_addSystemNode

Type: function

Description: 
- Param: _ctx

File: [host\ReNode\ReNode_init.sqf at line 98](../../../Src/host/ReNode/ReNode_init.sqf#L98)
## nodegen_addEnumerator

Type: function

Description: 
- Param: _nodename
- Param: _members
- Param: _pdata (optional, default '')

File: [host\ReNode\ReNode_init.sqf at line 103](../../../Src/host/ReNode/ReNode_init.sqf#L103)
## nodegen_addStruct

Type: function

Description: 
- Param: _nodename
- Param: _members
- Param: _pdata

File: [host\ReNode\ReNode_init.sqf at line 135](../../../Src/host/ReNode/ReNode_init.sqf#L135)
## nodegen_commonAdd

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 153](../../../Src/host/ReNode/ReNode_init.sqf#L153)
## nodegen_commonSysAdd

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 164](../../../Src/host/ReNode/ReNode_init.sqf#L164)
## nodegen_registerFunctions

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 175](../../../Src/host/ReNode/ReNode_init.sqf#L175)
## nodegen_registerMember

Type: function

Description: 
- Param: _t
- Param: _class
- Param: _memname
- Param: _contextList

File: [host\ReNode\ReNode_init.sqf at line 179](../../../Src/host/ReNode/ReNode_init.sqf#L179)
## nodegen_registerClass

Type: function

Description: 
- Param: _t
- Param: _class
- Param: _data

File: [host\ReNode\ReNode_init.sqf at line 184](../../../Src/host/ReNode/ReNode_init.sqf#L184)
## nodegen_generateLib

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 189](../../../Src/host/ReNode/ReNode_init.sqf#L189)
## nodegen_loadClasses

Type: function

Description: 


File: [host\ReNode\ReNode_init.sqf at line 397](../../../Src/host/ReNode/ReNode_init.sqf#L397)
## renode_invokeDelegate

Type: function

Description: call delegate; _fref - vec2: vec2:(object,context), code(params:args,context)


File: [host\ReNode\ReNode_init.sqf at line 427](../../../Src/host/ReNode/ReNode_init.sqf#L427)
## renode_print

Type: function

Description: generic function for print messages into console
- Param: _m
- Param: _ch
- Param: _ft

File: [host\ReNode\ReNode_init.sqf at line 450](../../../Src/host/ReNode/ReNode_init.sqf#L450)
# resdk_graph.h

## __THIS_GRAPH__

Type: constant

Description: 


Replaced value:
```sqf
UNRESOLVED_GRAPH_PATH
```
File: [host\ReNode\compiled\resdk_graph.h at line 17](../../../Src/host/ReNode/compiled/resdk_graph.h#L17)
## __bp_serialize(value__)

Type: constant

Description: 
- Param: value__

Replaced value:
```sqf
#value__
```
File: [host\ReNode\compiled\resdk_graph.h at line 19](../../../Src/host/ReNode/compiled/resdk_graph.h#L19)
## __bp_preser_sig(id__,toid__,graph__)

Type: constant

Description: 
- Param: id__
- Param: toid__
- Param: graph__

Replaced value:
```sqf
__bp_serialize(id__@toid__@graph__)
```
File: [host\ReNode\compiled\resdk_graph.h at line 21](../../../Src/host/ReNode/compiled/resdk_graph.h#L21)
## __bp_send_signal(id__,toid__)

Type: constant

Description: 
- Param: id__
- Param: toid__

Replaced value:
```sqf
__bp_preser_sig(id__,toid__,__THIS_GRAPH__) call nbp_sigsend;
```
File: [host\ReNode\compiled\resdk_graph.h at line 23](../../../Src/host/ReNode/compiled/resdk_graph.h#L23)
## BP_EXEC(id__,toid__)

Type: constant

Description: execution signal
- Param: id__
- Param: toid__

Replaced value:
```sqf
__bp_send_signal(id__,toid__)
```
File: [host\ReNode\compiled\resdk_graph.h at line 26](../../../Src/host/ReNode/compiled/resdk_graph.h#L26)
## BP_PS(id__,toid__)

Type: constant

Description: pure signal
- Param: id__
- Param: toid__

Replaced value:
```sqf
call{ __bp_send_signal(id__,toid__)
```
File: [host\ReNode\compiled\resdk_graph.h at line 29](../../../Src/host/ReNode/compiled/resdk_graph.h#L29)
## BP_PE

Type: constant

Description: 


Replaced value:
```sqf
}
```
File: [host\ReNode\compiled\resdk_graph.h at line 31](../../../Src/host/ReNode/compiled/resdk_graph.h#L31)
## BP_EXEC(id__,toid__)

Type: constant

> Exists if **EDITOR** not defined

Description: execution signal
- Param: id__
- Param: toid__

Replaced value:
```sqf

```
File: [host\ReNode\compiled\resdk_graph.h at line 36](../../../Src/host/ReNode/compiled/resdk_graph.h#L36)
## BP_PS(id__,toid__)

Type: constant

> Exists if **EDITOR** not defined

Description: pure signal
- Param: id__
- Param: toid__

Replaced value:
```sqf

```
File: [host\ReNode\compiled\resdk_graph.h at line 37](../../../Src/host/ReNode/compiled/resdk_graph.h#L37)
## BP_PE

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf

```
File: [host\ReNode\compiled\resdk_graph.h at line 38](../../../Src/host/ReNode/compiled/resdk_graph.h#L38)
## __GLOBAL_MACRO_RESDK_EDITOR__

Type: constant

> Exists if **EDITOR** defined

Description: 


Replaced value:
```sqf
true
```
File: [host\ReNode\compiled\resdk_graph.h at line 44](../../../Src/host/ReNode/compiled/resdk_graph.h#L44)
## __GLOBAL_MACRO_RESDK_EDITOR__

Type: constant

> Exists if **EDITOR** not defined

Description: 


Replaced value:
```sqf
false
```
File: [host\ReNode\compiled\resdk_graph.h at line 46](../../../Src/host/ReNode/compiled/resdk_graph.h#L46)
## __GLOBAL_MACRO_RESDK_RELEASE__

Type: constant

> Exists if **RELEASE** defined

Description: 


Replaced value:
```sqf
true
```
File: [host\ReNode\compiled\resdk_graph.h at line 50](../../../Src/host/ReNode/compiled/resdk_graph.h#L50)
## __GLOBAL_MACRO_RESDK_RELEASE__

Type: constant

> Exists if **RELEASE** not defined

Description: 


Replaced value:
```sqf
false
```
File: [host\ReNode\compiled\resdk_graph.h at line 52](../../../Src/host/ReNode/compiled/resdk_graph.h#L52)
## __GLOBAL_MACRO_RESDK_DEBUG__

Type: constant

> Exists if **DEBUG** defined

Description: 


Replaced value:
```sqf
true
```
File: [host\ReNode\compiled\resdk_graph.h at line 56](../../../Src/host/ReNode/compiled/resdk_graph.h#L56)
## __GLOBAL_MACRO_RESDK_DEBUG__

Type: constant

> Exists if **DEBUG** not defined

Description: 


Replaced value:
```sqf
false
```
File: [host\ReNode\compiled\resdk_graph.h at line 58](../../../Src/host/ReNode/compiled/resdk_graph.h#L58)
