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
# BuildTools_clientLoader.sqf

## cmplog(fcat)

Type: constant

> Exists if **DEBUG** defined

Description: 
- Param: fcat

Replaced value:
```sqf
allClientContents pushBack (compile format['log("Init %1")',fcat]); allClientModulePathes pushBack "internal module logging";
```
File: [host\Tools\BuildTools\BuildTools_clientLoader.sqf at line 44](../../../Src/host/Tools/BuildTools/BuildTools_clientLoader.sqf#L44)
## cmplog(fcat)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: fcat

Replaced value:
```sqf

```
File: [host\Tools\BuildTools\BuildTools_clientLoader.sqf at line 46](../../../Src/host/Tools/BuildTools/BuildTools_clientLoader.sqf#L46)
# BuildTools_init.sqf

## BT_ERRCODE(code)

Type: constant

Description: 
- Param: code

Replaced value:
```sqf
(-2100 - (code))
```
File: [host\Tools\BuildTools\BuildTools_init.sqf at line 16](../../../Src/host/Tools/BuildTools/BuildTools_init.sqf#L16)
## bt_buildClient

Type: function

Description: 


File: [host\Tools\BuildTools\BuildTools_init.sqf at line 18](../../../Src/host/Tools/BuildTools/BuildTools_init.sqf#L18)
# EditorDebug.sqf

## editorDebug_isEnabled

Type: Variable

Description: 


Initial value:
```sqf
true //global mode
```
File: [host\Tools\EditorDebug\EditorDebug.sqf at line 17](../../../Src/host/Tools/EditorDebug/EditorDebug.sqf#L17)
## editorDebug_handlerUpdate

Type: Variable

Description: global mode


Initial value:
```sqf
-1
```
File: [host\Tools\EditorDebug\EditorDebug.sqf at line 19](../../../Src/host/Tools/EditorDebug/EditorDebug.sqf#L19)
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
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 225](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L225)
## bcol(button)

Type: constant

Description: 
- Param: button

Replaced value:
```sqf
<t color=''symb__(ff0000)''>button</t> 
```
File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 226](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L226)
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


File: [host\Tools\EditorDebug\EditorDebug_datahandler.sqf at line 224](../../../Src/host/Tools/EditorDebug/EditorDebug_datahandler.sqf#L224)
# EditorDebug_input.sqf

## inputDebug_list_events

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Tools\EditorDebug\EditorDebug_input.sqf at line 6](../../../Src/host/Tools/EditorDebug/EditorDebug_input.sqf#L6)
## inputDebug_addMouseEvent

Type: function

Description: 
- Param: _code

File: [host\Tools\EditorDebug\EditorDebug_input.sqf at line 8](../../../Src/host/Tools/EditorDebug/EditorDebug_input.sqf#L8)
## inputDebug_handleMouseEvent

Type: function

Description: 
- Param: _button
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [host\Tools\EditorDebug\EditorDebug_input.sqf at line 13](../../../Src/host/Tools/EditorDebug/EditorDebug_input.sqf#L13)
# EditorDebug_io.sqf

## PRINT_FILEWRITE_ERROR_REASON

Type: constant

Description: 


Replaced value:
```sqf

```
File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 16](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L16)
## file_const_defaultDelimeter

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 12](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L12)
## file_const_defaultAsyncWriteTimeout

Type: Variable

Description: 


Initial value:
```sqf
5
```
File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 14](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L14)
## file_getSourcePath

Type: function

Description: #define EXTENDED_LOGGING_ASYNCUNLOCK


File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 21](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L21)
## file_open

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)
- Param: _args (optional, default "")

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 29](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L29)
## file_openReturn

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)
- Param: _args (optional, default "")

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 49](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L49)
## file_copy

Type: function

Description: this cannot copy directory
- Param: _path
- Param: _dest
- Param: _relInfo
- Param: _canOverride (optional, default true)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 66](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L66)
## file_move

Type: function

Description: 
- Param: _path
- Param: _dest
- Param: _relInfo

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 81](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L81)
## dir_move

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 96](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L96)
## file_getFileList

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)
- Param: _searchOption (optional, default "*.*")
- Param: _useDeepSearch (optional, default false)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 100](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L100)
## file_read

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 116](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L116)
## file_write

Type: function

Description: 
- Param: _path
- Param: _data
- Param: _isRelative (optional, default true)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 128](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L128)
## file_delete

Type: function

Description: 
- Param: _path

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 148](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L148)
## folder_delete

Type: function

Description: 
- Param: _path

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 159](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L159)
## file_exists

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 170](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L170)
## folder_exists

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 176](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L176)
## file_isLocked

Type: function

Description: 
- Param: _path
- Param: _isRelative (optional, default true)

File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 183](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L183)
## file_clearFileLock

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_io.sqf at line 190](../../../Src/host/Tools/EditorDebug/EditorDebug_io.sqf#L190)
# EditorDebug_shared.sqf

## checkdata(cachevalue)

Type: constant

Description: 
- Param: cachevalue

Replaced value:
```sqf
if !(cachevalue in _cache) exitwith {cachevalue}
```
File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 62](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L62)
## checkempty(cachevalue)

Type: constant

Description: 
- Param: cachevalue

Replaced value:
```sqf
if (_cache get cachevalue == "") exitwith {cachevalue}
```
File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 63](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L63)
## editorDebug_serializePlayerSettings

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 8](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L8)
## editorDebug_getPlayerSettings

Type: function

Description: 


File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 43](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L43)
## editorDebug_updatePosAndDirInCache

Type: function

Description: only for 3den
- Param: _pos
- Param: _dir (optional, default 0)

File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 48](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L48)
## editorDebug_internal_validateValuesCanStart

Type: function

Description: 
- Param: _cache

File: [host\Tools\EditorDebug\EditorDebug_shared.sqf at line 60](../../../Src/host/Tools/EditorDebug/EditorDebug_shared.sqf#L60)
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
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 87](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L87)
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
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 91](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L91)
## relicta_debug_internal_canShowStackVariables

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 93](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L93)
## relicta_debug_internal_lastErrorName

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 95](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L95)
## relicta_debug_internal_lastStackTrace

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 96](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L96)
## relicta_debug_internal_lastErrorFileLine

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 97](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L97)
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
## messageBox_Node

Type: function

Description: 
- Param: _mes
- Param: _opt (optional, default [])

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 72](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L72)
## messageBoxRet

Type: function

Description: 
- Param: _d

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 78](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L78)
## relicta_debug_onPostErrorHandle

Type: function

Description: 
- Param: _errorMsg
- Param: _file
- Param: _line
- Param: _stack
- Param: _offset

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 89](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L89)
## relicta_debug_internal_handleError

Type: function

Description: 
- Param: _errorMsg
- Param: _file
- Param: _line
- Param: _stack
- Param: _offset

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 99](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L99)
## relicta_debug_internal_serializeStackTrace

Type: function

Description: 
- Param: _fn
- Param: _line
- Param: _scope
- Param: _varmap

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 149](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L149)
## relicta_debug_setlasterror

Type: function

Description: used on halt system call
- Param: _name

File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 185](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L185)
## relicta_debug_internal_testErrorInternal

Type: function

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 192](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L192)
## relicta_debug_internal_testError

Type: function

Description: 


File: [host\Tools\EditorWorkspaceDebug\InternalImpl.sqf at line 199](../../../Src/host/Tools/EditorWorkspaceDebug/InternalImpl.sqf#L199)
# HotReload_init.sqf

## printTrace

Type: constant

Description: 


Replaced value:
```sqf
fws_printTrace
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 28](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L28)
## fileWatcher_enableSystem

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 9](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L9)
## fileWatcher_autoReloadObjects

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 11](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L11)
## fileWatcher_list_checkedPathsForReloadRequest

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 13](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L13)
## fileWatcher_list_ignoredPathParts

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 18](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L18)
## fileWatcher_hostChangedPath

Type: Variable

Description: 


Initial value:
```sqf
tolower "Src\host\"
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 25](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L25)
## fileWatcher_clientChangedPath

Type: Variable

Description: 


Initial value:
```sqf
tolower "Src\client"
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 26](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L26)
## fws_autorecompSources

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Tools\HotReload\HotReload_init.sqf at line 29](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L29)
## fws_printTrace

Type: function

Description: 


File: [host\Tools\HotReload\HotReload_init.sqf at line 31](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L31)
## fileWatcher_init

Type: function

Description: 


File: [host\Tools\HotReload\HotReload_init.sqf at line 40](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L40)
## fileWatcher_onFrame

Type: function

Description: 


File: [host\Tools\HotReload\HotReload_init.sqf at line 59](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L59)
## FileWatcher_handleCallbackExtension

Type: function

Description: 
- Param: _path
- Param: _func
- Param: _args

File: [host\Tools\HotReload\HotReload_init.sqf at line 83](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L83)
## FileWatcher_onChangeFile

Type: function

Description: 
- Param: _filepath

File: [host\Tools\HotReload\HotReload_init.sqf at line 99](../../../Src/host/Tools/HotReload/HotReload_init.sqf#L99)
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


File: [host\Tools\SDK\SDK_init.sqf at line 55](../../../Src/host/Tools/SDK/SDK_init.sqf#L55)
## sdk_hasSystemFlag

Type: function

Description: 


File: [host\Tools\SDK\SDK_init.sqf at line 59](../../../Src/host/Tools/SDK/SDK_init.sqf#L59)
## sdk_getSDKPropertyMap

Type: function

Description: sdk property list is simple getter some values from editor


File: [host\Tools\SDK\SDK_init.sqf at line 64](../../../Src/host/Tools/SDK/SDK_init.sqf#L64)
## sdk_getPropertyValue

Type: function

Description: 
- Param: _key
- Param: _def

File: [host\Tools\SDK\SDK_init.sqf at line 68](../../../Src/host/Tools/SDK/SDK_init.sqf#L68)
