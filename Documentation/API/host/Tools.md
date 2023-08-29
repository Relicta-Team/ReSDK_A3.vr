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
## mttd_targetpos

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0]
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 73](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L73)
## mttd_curhandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 74](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L74)
## mttd_srcobj

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 75](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L75)
## mttd_arrForward

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 76](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L76)
## mttd_arrDirect

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\Tools\MoveToTargetDebugger.sqf at line 77](../../../Src/host/Tools/MoveToTargetDebugger.sqf#L77)
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
# EditorDebug.sqf

## editorDebug_isEnabled

Type: Variable

Description: 


Initial value:
```sqf
true //global mode
```
File: [host\Tools\EditorDebug\EditorDebug.sqf at line 15](../../../Src/host/Tools/EditorDebug/EditorDebug.sqf#L15)
## editorDebug_handlerUpdate

Type: Variable

Description: global mode


Initial value:
```sqf
-1
```
File: [host\Tools\EditorDebug\EditorDebug.sqf at line 17](../../../Src/host/Tools/EditorDebug/EditorDebug.sqf#L17)
# EditorDebug_datahandler.sqf

## metstart(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf

```
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 39](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L39)
## metprint

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 40](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L40)
## symb__(dat)

Type: constant

Description: 
- Param: dat

Replaced value:
```sqf
###dat
```
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 224](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L224)
## bcol(button)

Type: constant

Description: 
- Param: button

Replaced value:
```sqf
<t color=''symb__(ff0000)''>button</t> 
```
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 225](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L225)
## editorDebug_internal_const_typemapColors

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray[...
```
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 158](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L158)
## editorDebug_init

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 8](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L8)
## editorDebug_onUpdate

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 30](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L30)
## editorDebug_handler_gameObject_valueToText

Type: function

Description: 
- Param: _varname
- Param: _varval
- Param: _dirty (optional, default 0)

File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 80](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L80)
## editorDebug_handler_gameObject

Type: function

Description: обработчик игрового объекта


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 171](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L171)
## editorDebug_handler_common

Type: function

Description: общий обработчик данных


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 223](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L223)
# EditorDebug_shared.sqf

## checkdata(cachevalue)

Type: constant

Description: 
- Param: cachevalue

Replaced value:
```sqf
if !(cachevalue in _cache) exitwith {cachevalue}
```
File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 57](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L57)
## checkempty(cachevalue)

Type: constant

Description: 
- Param: cachevalue

Replaced value:
```sqf
if (_cache get cachevalue == "") exitwith {cachevalue}
```
File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 58](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L58)
## editorDebug_serializePlayerSettings

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 3](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L3)
## editorDebug_getPlayerSettings

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 38](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L38)
## editorDebug_updatePosAndDirInCache

Type: function

Description: only for 3den
- Param: _pos
- Param: _dir (optional, default 0)

File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 43](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L43)
## editorDebug_internal_validateValuesCanStart

Type: function

Description: 
- Param: _cache

File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 55](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L55)
# EditorDebug_visual.sqf

## editorDebug_handlerWidgets

Type: Variable

Description: struct of vec3: ref ctg, name, code target, positions(size),handler


Initial value:
```sqf
[...
```
File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 8](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L8)
## editorDebug_internal_activeTab

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 44](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L44)
## editorDebug_setVisibleWidgets

Type: function

Description: 
- Param: _mode

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 32](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L32)
## editorDebug_isVisibleWidgets

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 40](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L40)
## editorDebug_createVisual

Type: function

Description: 
- Param: _catName

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 46](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L46)
## editorDebug_scrollActiveTab

Type: function

Description: 
- Param: _val

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 77](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L77)
## editorDebug_handleKeyPress

Type: function

Description: 
- Param: _str
- Param: _isShift

File: [host\Tools\EditorDebug\EditorDebug_visual.sqf at line 90](../../../Src/host/Tools/EditorDebug/EditorDebug_visual.sqf#L90)
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
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 81](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L81)
## relicta_debug_internal_isEntryPointInitialized

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 41](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L41)
## relicta_debug_internal_isHandledError

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 85](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L85)
## relicta_debug_internal_canShowStackVariables

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 87](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L87)
## relicta_debug_internal_lastErrorName

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 89](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L89)
## relicta_debug_internal_lastErrorFileLine

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 90](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L90)
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
## messageBoxRet

Type: function

Description: 
- Param: _d

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 72](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L72)
## relicta_debug_onPostErrorHandle

Type: function

Description: 
- Param: _errorMsg
- Param: _file
- Param: _line
- Param: _stack
- Param: _offset

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 83](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L83)
## relicta_debug_internal_handleError

Type: function

Description: 
- Param: _errorMsg
- Param: _file
- Param: _line
- Param: _stack
- Param: _offset

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 92](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L92)
## relicta_debug_internal_serializeStackTrace

Type: function

Description: 
- Param: _fn
- Param: _line
- Param: _scope
- Param: _varmap

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 139](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L139)
## relicta_debug_setlasterror

Type: function

Description: used on halt system call
- Param: _name

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 175](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L175)
## relicta_debug_internal_testErrorInternal

Type: function

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 180](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L180)
## relicta_debug_internal_testError

Type: function

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 187](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L187)
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
## iconGen_output

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Tools\IconGenerator\IconGenerator.sqf at line 29](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L29)
## iconGen_outputInfo

Type: Variable

Description: 


Initial value:
```sqf
"" //non-code information
```
File: [host\Tools\IconGenerator\IconGenerator.sqf at line 30](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L30)
## iconGen_internal_typeTable

Type: Variable

Description: non-code information


Initial value:
```sqf
createHashMap
```
File: [host\Tools\IconGenerator\IconGenerator.sqf at line 32](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L32)
## iconGen_internal_isError

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Tools\IconGenerator\IconGenerator.sqf at line 33](../../../Src/host/Tools/IconGenerator/IconGenerator.sqf#L33)
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

## sdk_isFirstLoad

Type: Variable

Description: 


Initial value:
```sqf
isNull(sdk_firstLoadFlag)
```
File: [host\Tools\SDK\SDK_init.sqf at line 10](../../../Src/host/Tools/SDK/SDK_init.sqf#L10)
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
