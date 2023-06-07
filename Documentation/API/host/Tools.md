# MoveToTargetDebugger.sqf

## ACT_WALK

Type: constant

Description: 


Replaced value:
```sqf
"SlowF"
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 9](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L9)
## ACT_STOP

Type: constant

Description: 


Replaced value:
```sqf
"Stop"
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 10](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L10)
## mttd_start

Type: function

Description: 
- Param: _newposition

File: [host\Tools\MoveToTargetDebugger.sqf at line 13](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L13)
## mttd_doact

Type: function

Description: 


File: [host\Tools\MoveToTargetDebugger.sqf at line 70](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L70)
## mttd_ray

Type: function

Description: 
- Param: _beg
- Param: _end

File: [host\Tools\MoveToTargetDebugger.sqf at line 79](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L79)
# EditorDebug_datahandler.sqf

## editorDebug_init

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 8](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L8)
## editorDebug_onUpdate

Type: function

Description: 
- Param: _w
- Param: _nameT
- Param: _deleg_retObj
- Param: _defpos
- Param: _deleg_setText

File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 24](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L24)
## editorDebug_handler_gameObject_valueToText

Type: function

Description: 
- Param: _varname
- Param: _varval

File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 59](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L59)
## editorDebug_handler_gameObject

Type: function

Description: обработчик игрового объекта


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 114](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L114)
## editorDebug_handler_common

Type: function

Description: общий обработчик данных


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 126](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L126)
# EditorDebug_visual.sqf

## editorDebug_createVisual

Type: function

Description: 
- Param: _catName

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 32](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L32)
## editorDebug_scrollActiveTab

Type: function

Description: 
- Param: _val

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 63](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L63)
## editorDebug_handleKeyPress

Type: function

Description: 
- Param: _str
- Param: _isShift

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 75](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L75)
# EntryPoint.sqf

## relicta_debug_main

Type: function

Description: функция, вызываемая при подключении первого персонажа в игру
- Param: _mob
- Param: _role

File: [host\Tools\EditorWorkspaceDebug\EntryPoint.sqf at line 22](../../../Src/host/Tools/EditorWorkspaceDebug/EntryPoint.sqf#L22)
## relicta_debug_compileMain

Type: function

Description: когда все модули загружены но режим ещё не установлен


File: [host\Tools\EditorWorkspaceDebug\EntryPoint.sqf at line 36](../../../Src/host/Tools/EditorWorkspaceDebug/EntryPoint.sqf#L36)
# InternalImpl.sqf

## DEEP_DEBUG_MODE

Type: constant

Description: режим глубокой отладки. При изменении нужно перезапустить симуляцию.


Replaced value:
```sqf

```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 11](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L11)
## TAB__

Type: constant

Description: 


Replaced value:
```sqf
(toString [9])
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 75](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L75)
## relicta_debug_internal_postCompileProcess

Type: function

> Exists if **DEEP_DEBUG_MODE** defined

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 23](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L23)
## relicta_debug_internal_invokeEntryPoint

Type: function

Description: 
- Param: _usr
- Param: _role

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 43](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L43)
## relicta_debug_clearUserInventory

Type: function

Description: 
- Param: _usr

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 50](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L50)
## messageBox

Type: function

Description: 
- Param: _d

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 66](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L66)
## relicta_debug_onPostErrorHandle

Type: function

Description: 
- Param: _errorMsg
- Param: _file
- Param: _line
- Param: _stack
- Param: _offset

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 77](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L77)
## relicta_debug_internal_handleError

Type: function

Description: 
- Param: _errorMsg
- Param: _file
- Param: _line
- Param: _stack
- Param: _offset

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 85](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L85)
## relicta_debug_internal_serializeStackTrace

Type: function

Description: 
- Param: _fn
- Param: _line
- Param: _scope
- Param: _varmap

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 128](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L128)
## relicta_debug_setlasterror

Type: function

Description: used on halt system call
- Param: _name

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 164](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L164)
## relicta_debug_internal_testErrorInternal

Type: function

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 169](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L169)
## relicta_debug_internal_testError

Type: function

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 176](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L176)
# IconGenerator.sqf

## main_ExitIfError()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
\
if (iconGen_internal_isError) exitWith { \
	error("Process icon generator aborted"); \
}
```
File: [host\Tools\IconGenerator\IconGenerator.sqf at line 35](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L35)
## iconGenerator_start

Type: function

Description: 


File: [host\Tools\IconGenerator\IconGenerator.sqf at line 40](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L40)
## iconGen_internal_findTypeByModel_alg2

Type: function

Description: 
- Param: _model

File: [host\Tools\IconGenerator\IconGenerator.sqf at line 88](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L88)
## iconGen_internal_findTypeByModel

Type: function

Description: 
- Param: _model

File: [host\Tools\IconGenerator\IconGenerator.sqf at line 105](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L105)
## iconGen_internal_makeIconCtors

Type: function

Description: 
- Param: _classes

File: [host\Tools\IconGenerator\IconGenerator.sqf at line 122](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L122)
## iconGen_internal_isValidConfig

Type: function

Description: 


File: [host\Tools\IconGenerator\IconGenerator.sqf at line 129](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L129)
## iconGen_internal_generateTypeTable

Type: function

Description: 


File: [host\Tools\IconGenerator\IconGenerator.sqf at line 133](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L133)
# IconMaker.sqf

## fcall(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
call icomaker_##name
```
File: [host\Tools\IconGenerator\IconMaker.sqf at line 7](../../../Src/host/Tools/IconGenerator/IconMaker.sqf#L7)
## fdef(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
icomaker_##name
```
File: [host\Tools\IconGenerator\IconMaker.sqf at line 8](../../../Src/host/Tools/IconGenerator/IconMaker.sqf#L8)
# SDK_init.sqf

## sdk_init

Type: function

Description: 


File: [host\Tools\SDK\SDK_init.sqf at line 19](../../../Src/host/Tools/SDK/SDK_init.sqf#L19)
## sdk_internal_loadSDKConfig

Type: function

Description: 
- Param: _pathFull

File: [host\Tools\SDK\SDK_init.sqf at line 37](../../../Src/host/Tools/SDK/SDK_init.sqf#L37)
## sdk_getSystemFlags

Type: function

Description: system flags is simple flaglist for bool check


File: [host\Tools\SDK\SDK_init.sqf at line 53](../../../Src/host/Tools/SDK/SDK_init.sqf#L53)
## sdk_hasSystemFlag

Type: function

Description: 


File: [host\Tools\SDK\SDK_init.sqf at line 57](../../../Src/host/Tools/SDK/SDK_init.sqf#L57)
## sdk_getSDKPropertyMap

Type: function

Description: sdk property list is simple getter some values from editor


File: [host\Tools\SDK\SDK_init.sqf at line 62](../../../Src/host/Tools/SDK/SDK_init.sqf#L62)
## sdk_getPropertyValue

Type: function

Description: 
- Param: _key
- Param: _def

File: [host\Tools\SDK\SDK_init.sqf at line 66](../../../Src/host/Tools/SDK/SDK_init.sqf#L66)
