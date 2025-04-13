# singleplayer_ai.sqf

## SP_AI_TICKRATE_POSITION

Type: constant

Description: 


Replaced value:
```sqf
0.5
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 88](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L88)
## SP_AI_TICKRATE_DIRECTION

Type: constant

Description: 


Replaced value:
```sqf
0.05
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 89](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L89)
## SP_AI_TICKRATE_HEADTARGET

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 90](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L90)
## SP_AI_DATAFRAME_ANIMSTATE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 92](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L92)
## SP_AI_DATAFRAME_POSITION

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 93](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L93)
## SP_AI_DATAFRAME_DIRECTION

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 94](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L94)
## SP_AI_DATAFRAME_HEADTARGET

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 95](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L95)
## SP_AI_DATAFRAME_SCRIPTEDSTATE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 96](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L96)
## sp_ai_debug_curCaptureHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 20](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L20)
## sp_ai_debug_curCaptureTarget

Type: Variable

Description: 


Initial value:
```sqf
objNull
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 21](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L21)
## sp_ai_debug_captureMove

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\singleplayer_ai.sqf at line 23](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L23)
## sp_ai_debug_startCapture

Type: function

Description: 
- Param: _target
- Param: _movecapt

File: [host\Singleplayer\singleplayer_ai.sqf at line 25](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L25)
## sp_ai_debug_stopCapture

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 71](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L71)
## sp_ai_debug_processCaptureSwitch

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 78](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L78)
## sp_ai_debug_internal_handleUpdate

Type: function

Description: 
- Param: _mProg
- Param: _mTime
- Param: _mDur
- Param: _mBlndFact
- Param: _rtmStep
- Param: _gProg
- Param: _gTime
- Param: _gDur
- Param: _gBlndFact

File: [host\Singleplayer\singleplayer_ai.sqf at line 103](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L103)
## sp_ai_debug_addScriptedState

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 177](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L177)
## sp_ai_debug_isCapturing

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 185](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L185)
## sp_ai_debug_suspendCapture

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 189](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L189)
## sp_ai_playCapture

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 200](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L200)
## sp_ai_internal_processPlayingStates

Type: function

Description: 
- Param: _t
- Param: _obj
- Param: _cdata
- Param: _basePos
- Param: _ctx

File: [host\Singleplayer\singleplayer_ai.sqf at line 267](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L267)
## sp_ai_debug_playLastAnim

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 369](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L369)
## sp_ai_debug_getPreviewPerson

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 378](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L378)
## sp_ai_debug_createTestPerson

Type: function

Description: 
- Param: _pos
- Param: _mtype (optional, default "Mob")
- Param: _target (optional, default "CREATE_NEW")

File: [host\Singleplayer\singleplayer_ai.sqf at line 385](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L385)
## sp_ai_playAnim

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 397](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L397)
## sp_ai_createPerson

Type: function

Description: 
- Param: _pos
- Param: _mtype (optional, default "Mob")
- Param: _target (optional, default "CREATE_NEW")

File: [host\Singleplayer\singleplayer_ai.sqf at line 443](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L443)
## sp_ai_createPersonEx

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 463](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L463)
## sp_ai_deletePerson

Type: function

Description: 
- Param: _m

File: [host\Singleplayer\singleplayer_ai.sqf at line 495](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L495)
## sp_ai_getMobObject

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 516](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L516)
## sp_ai_commitMobPos

Type: function

Description: 
- Param: _m
- Param: _p
- Param: _doApply (optional, default true)

File: [host\Singleplayer\singleplayer_ai.sqf at line 522](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L522)
## sp_ai_moveItemToWorld

Type: function

Description: 
- Param: _m
- Param: _it
- Param: _pos
- Param: _dir (optional, default random 360)
- Param: _vecup (optional, default ['0', '0', '1'])

File: [host\Singleplayer\singleplayer_ai.sqf at line 532](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L532)
## sp_ai_moveItemToMob

Type: function

Description: 
- Param: _m
- Param: _item
- Param: _slot

File: [host\Singleplayer\singleplayer_ai.sqf at line 563](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L563)
## sp_ai_setMobPos

Type: function

Description: 
- Param: _mob
- Param: _reforpos
- Param: _dir (optional, default null)

File: [host\Singleplayer\singleplayer_ai.sqf at line 602](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L602)
## sp_ai_internal_onUpdate

Type: function

Description: 
- Param: _ps

File: [host\Singleplayer\singleplayer_ai.sqf at line 632](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L632)
## sp_ai_playAnimsLooped

Type: function

Description: 


File: [host\Singleplayer\singleplayer_ai.sqf at line 696](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L696)
## sp_ai_internal_playAnimStateLoop

Type: function

Description: 
- Param: _t
- Param: _anm
- Param: _ctxInt

File: [host\Singleplayer\singleplayer_ai.sqf at line 714](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L714)
## sp_ai_setLookAtControl

Type: function

Description: 
- Param: _mob
- Param: _target

File: [host\Singleplayer\singleplayer_ai.sqf at line 764](../../../Src/host/Singleplayer/singleplayer_ai.sqf#L764)
# singleplayer_audio.sqf

## sp_audio_sayPlayer

Type: function

Description: 
- Param: _pathPost

File: [host\Singleplayer\singleplayer_audio.sqf at line 15](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L15)
## sp_audio_waitForEndSound

Type: function

Description: 
- Param: _handle

File: [host\Singleplayer\singleplayer_audio.sqf at line 25](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L25)
## sp_audio_sayPlayerList

Type: function

Description: 
- Param: _pathlist

File: [host\Singleplayer\singleplayer_audio.sqf at line 32](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L32)
## sp_audio_sayAtTarget

Type: function

Description: 
- Param: _target
- Param: _pathPost
- Param: _dist (optional, default 20)
- Param: _startOffset (optional, default 0)

File: [host\Singleplayer\singleplayer_audio.sqf at line 46](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L46)
## sp_audio_internal_resolveTarget

Type: function

Description: 
- Param: _target

File: [host\Singleplayer\singleplayer_audio.sqf at line 62](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L62)
## sp_audio_startDialog

Type: function

Description: 
- Param: _dlg

File: [host\Singleplayer\singleplayer_audio.sqf at line 89](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L89)
## sp_audio_internal_procDialog

Type: function

Description: 
- Param: _stateSeq
- Param: _canCheckStartCond (optional, default true)

File: [host\Singleplayer\singleplayer_audio.sqf at line 115](../../../Src/host/Singleplayer/singleplayer_audio.sqf#L115)
# singleplayer_camera.sqf

## sp_cam_cinematicCam

Type: Variable

Description: camera control


Initial value:
```sqf
objNull
```
File: [host\Singleplayer\singleplayer_camera.sqf at line 7](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L7)
## sp_cam_createCinematicCam

Type: function

Description: 


File: [host\Singleplayer\singleplayer_camera.sqf at line 9](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L9)
## sp_cam_isCreated

Type: function

Description: 


File: [host\Singleplayer\singleplayer_camera.sqf at line 20](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L20)
## sp_cam_setCamPos

Type: function

Description: 
- Param: _pos

File: [host\Singleplayer\singleplayer_camera.sqf at line 24](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L24)
## sp_cam_setCinematicCam

Type: function

Description: 
- Param: _mode

File: [host\Singleplayer\singleplayer_camera.sqf at line 29](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L29)
## sp_cam_setTargetPos

Type: function

Description: 
- Param: _pos

File: [host\Singleplayer\singleplayer_camera.sqf at line 39](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L39)
## sp_cam_resetTargetPos

Type: function

Description: 


File: [host\Singleplayer\singleplayer_camera.sqf at line 45](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L45)
## sp_cam_setFov

Type: function

Description: 
- Param: _fov

File: [host\Singleplayer\singleplayer_camera.sqf at line 49](../../../Src/host/Singleplayer/singleplayer_camera.sqf#L49)
# singleplayer_gameControl.sqf

## sp_gc_internal_map_playerInputHandlers

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_gameControl.sqf at line 6](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L6)
## sp_internal_map_wsim

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_gameControl.sqf at line 167](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L167)
## sp_gc_handlePlayerInput

Type: function

Description: if returns true - input intercepted
- Param: _inputType
- Param: _params

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 9](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L9)
## sp_removeCurrentPlayerHandler

Type: function

Description: 


File: [host\Singleplayer\singleplayer_gameControl.sqf at line 43](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L43)
## sp_addPlayerHandler

Type: function

Description: Добавить обработчик ввода игрока. возврат true перехватит управление
- Param: _inputType
- Param: _handlerCode

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 48](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L48)
## sp_isValidPlayerHandler

Type: function

Description: 
- Param: _inputType
- Param: _hndlIndex

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 57](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L57)
## sp_filterVerbsOnHandle

Type: function

Description: фильтрует доступные ПКМ-действия
- Param: _verbs
- Param: _handlerCode

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 64](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L64)
## sp_removePlayerHandler

Type: function

Description: 
- Param: _inputType
- Param: _hndlIndex

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 78](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L78)
## sp_clearPlayerHandlers

Type: function

Description: clear all handlers


File: [host\Singleplayer\singleplayer_gameControl.sqf at line 93](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L93)
## sp_gc_onPlayerAssigned

Type: function

Description: used for on assigned handler
- Param: _mob

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 98](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L98)
## sp_setPlayerPos

Type: function

Description: устанавливает позицию игрока
- Param: _reforpos
- Param: _dir (optional, default null)

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 112](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L112)
## sp_getObject

Type: function

Description: получает объект по глобальной ссылке
- Param: _gref

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 156](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L156)
## sp_getPoint

Type: function

Description: получает точку спавна
- Param: _pointName

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 162](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L162)
## sp_wsimIsActive

Type: function

Description: use wsim sp_checkWSim for disable world simulation


File: [host\Singleplayer\singleplayer_gameControl.sqf at line 182](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L182)
## sp_wsimSetActive

Type: function

Description: 
- Param: _handler
- Param: _mode

File: [host\Singleplayer\singleplayer_gameControl.sqf at line 186](../../../Src/host/Singleplayer/singleplayer_gameControl.sqf#L186)
# singleplayer_init.sqf

## sp_storage

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_init.sqf at line 20](../../../Src/host/Singleplayer/singleplayer_init.sqf#L20)
## sp_debug

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [host\Singleplayer\singleplayer_init.sqf at line 22](../../../Src/host/Singleplayer/singleplayer_init.sqf#L22)
## sp_debug_viewOnReload

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [host\Singleplayer\singleplayer_init.sqf at line 23](../../../Src/host/Singleplayer/singleplayer_init.sqf#L23)
## sp_debug_skipAudio

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\singleplayer_init.sqf at line 24](../../../Src/host/Singleplayer/singleplayer_init.sqf#L24)
## sp_debug_doNotHideDebugObjects

Type: Variable

Description: 


Initial value:
```sqf
false//показ спавнпоинтов
```
File: [host\Singleplayer\singleplayer_init.sqf at line 25](../../../Src/host/Singleplayer/singleplayer_init.sqf#L25)
## sp_ai_debug_testmobs

Type: Variable

Description: показ спавнпоинтов


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_init.sqf at line 27](../../../Src/host/Singleplayer/singleplayer_init.sqf#L27)
## sp_ai_mobs

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_init.sqf at line 28](../../../Src/host/Singleplayer/singleplayer_init.sqf#L28)
## sp_ai_handleFarMobs

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(...
```
File: [host\Singleplayer\singleplayer_init.sqf at line 29](../../../Src/host/Singleplayer/singleplayer_init.sqf#L29)
## sp_ai_debug_curCaptureBasePos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [host\Singleplayer\singleplayer_init.sqf at line 30](../../../Src/host/Singleplayer/singleplayer_init.sqf#L30)
## sp_playerCanMove

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [host\Singleplayer\singleplayer_init.sqf at line 32](../../../Src/host/Singleplayer/singleplayer_init.sqf#L32)
## sp_gc_handleUpdateTriggers

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\Singleplayer\singleplayer_init.sqf at line 98](../../../Src/host/Singleplayer/singleplayer_init.sqf#L98)
## sp_gc_internal_listTriggers

Type: Variable

Description: reset triggers


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_init.sqf at line 99](../../../Src/host/Singleplayer/singleplayer_init.sqf#L99)
## sp_gc_internal_listTriggersZones

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_init.sqf at line 100](../../../Src/host/Singleplayer/singleplayer_init.sqf#L100)
## sp_gc_internal_activeTriggers

Type: Variable

Description: 


Initial value:
```sqf
createhashMap //key name, value gameobject
```
File: [host\Singleplayer\singleplayer_init.sqf at line 101](../../../Src/host/Singleplayer/singleplayer_init.sqf#L101)
## sp_internal_threads

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_init.sqf at line 203](../../../Src/host/Singleplayer/singleplayer_init.sqf#L203)
## sp_storageGet

Type: function

Description: 
- Param: _name
- Param: _def

File: [host\Singleplayer\singleplayer_init.sqf at line 34](../../../Src/host/Singleplayer/singleplayer_init.sqf#L34)
## sp_storageUpdate

Type: function

Description: 
- Param: _name
- Param: _valCode
- Param: _defval

File: [host\Singleplayer\singleplayer_init.sqf at line 43](../../../Src/host/Singleplayer/singleplayer_init.sqf#L43)
## sp_storageSet

Type: function

Description: 
- Param: _name
- Param: _defval

File: [host\Singleplayer\singleplayer_init.sqf at line 51](../../../Src/host/Singleplayer/singleplayer_init.sqf#L51)
## sp_internal_reloadScenario

Type: function

Description: 


File: [host\Singleplayer\singleplayer_init.sqf at line 56](../../../Src/host/Singleplayer/singleplayer_init.sqf#L56)
## sp_initMainModule

Type: function

Description: key name, value gameobject


File: [host\Singleplayer\singleplayer_init.sqf at line 103](../../../Src/host/Singleplayer/singleplayer_init.sqf#L103)
## sp_getTriggerByName

Type: function

Description: 
- Param: _searchName

File: [host\Singleplayer\singleplayer_init.sqf at line 151](../../../Src/host/Singleplayer/singleplayer_init.sqf#L151)
## sp_getActor

Type: function

Description: get actor


File: [host\Singleplayer\singleplayer_init.sqf at line 165](../../../Src/host/Singleplayer/singleplayer_init.sqf#L165)
## sp_createTrigger

Type: function

Description: 


File: [host\Singleplayer\singleplayer_init.sqf at line 176](../../../Src/host/Singleplayer/singleplayer_init.sqf#L176)
## sp_threadStart

Type: function

Description: 
- Param: _thdCode
- Param: _args (optional, default [])

File: [host\Singleplayer\singleplayer_init.sqf at line 205](../../../Src/host/Singleplayer/singleplayer_init.sqf#L205)
## sp_threadStop

Type: function

Description: 
- Param: _thd

File: [host\Singleplayer\singleplayer_init.sqf at line 215](../../../Src/host/Singleplayer/singleplayer_init.sqf#L215)
## sp_threadCriticalSection

Type: function

Description: 
- Param: _code

File: [host\Singleplayer\singleplayer_init.sqf at line 221](../../../Src/host/Singleplayer/singleplayer_init.sqf#L221)
## sp_threadPause

Type: function

Description: 
- Param: _time

File: [host\Singleplayer\singleplayer_init.sqf at line 226](../../../Src/host/Singleplayer/singleplayer_init.sqf#L226)
## sp_threadWait

Type: function

Description: called only when result is true


File: [host\Singleplayer\singleplayer_init.sqf at line 232](../../../Src/host/Singleplayer/singleplayer_init.sqf#L232)
## sp_threadWaitForEnd

Type: function

Description: 


File: [host\Singleplayer\singleplayer_init.sqf at line 236](../../../Src/host/Singleplayer/singleplayer_init.sqf#L236)
# singleplayer_scenarioFramework.sqf

## sp_map_scenario

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 6](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L6)
## sp_loadedScenarios

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 8](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L8)
## sp_lastStartedScene

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 9](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L9)
## sp_clientInstance

Type: Variable

Description: client object


Initial value:
```sqf
nullPtr
```
File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 12](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L12)
## sp_internal_map_scenes

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 41](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L41)
## sp_loadScenario

Type: function

Description: 
- Param: _name

File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 15](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L15)
## sp_startScene

Type: function

Description: 
- Param: _name
- Param: _doTeleport (optional, default false)

File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 25](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L25)
## sp_addScene

Type: function

Description: Добавление сцены. Если в мире есть триггер с таким же названием, либо объект - то при системном запуске персонажа телепортирует в сцену
- Param: _name
- Param: _code

File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 43](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L43)
## sp_addTriggerEnter

Type: function

Description: triggerzone works
- Param: _name
- Param: _code

File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 49](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L49)
## sp_addTriggerExit

Type: function

Description: 
- Param: _name
- Param: _code

File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 54](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L54)
## sp_callTriggerEvent

Type: function

Description: 
- Param: _name
- Param: _isEnter (optional, default true)

File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 59](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L59)
## sp_preloadScenarioEnvironment

Type: function

Description: 


File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 67](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L67)
## setNight

Type: function

Description: 


File: [host\Singleplayer\singleplayer_scenarioFramework.sqf at line 70](../../../Src/host/Singleplayer/singleplayer_scenarioFramework.sqf#L70)
# singleplayer_view.sqf

## sp_gui_taskWidgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_view.sqf at line 6](../../../Src/host/Singleplayer/singleplayer_view.sqf#L6)
## sp_gui_notificationWidgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_view.sqf at line 7](../../../Src/host/Singleplayer/singleplayer_view.sqf#L7)
## sp_gui_borders

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\Singleplayer\singleplayer_view.sqf at line 8](../../../Src/host/Singleplayer/singleplayer_view.sqf#L8)
## sp_gui_borderSize

Type: Variable

Description: 


Initial value:
```sqf
10
```
File: [host\Singleplayer\singleplayer_view.sqf at line 10](../../../Src/host/Singleplayer/singleplayer_view.sqf#L10)
## sp_gui_notificationSizeW

Type: Variable

Description: 


Initial value:
```sqf
40
```
File: [host\Singleplayer\singleplayer_view.sqf at line 11](../../../Src/host/Singleplayer/singleplayer_view.sqf#L11)
## sp_gui_notificationSizeH

Type: Variable

Description: 


Initial value:
```sqf
70
```
File: [host\Singleplayer\singleplayer_view.sqf at line 12](../../../Src/host/Singleplayer/singleplayer_view.sqf#L12)
## sp_gui_taskMessageWidth

Type: Variable

Description: 


Initial value:
```sqf
25
```
File: [host\Singleplayer\singleplayer_view.sqf at line 14](../../../Src/host/Singleplayer/singleplayer_view.sqf#L14)
## sp_internal_lastNotification

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Singleplayer\singleplayer_view.sqf at line 16](../../../Src/host/Singleplayer/singleplayer_view.sqf#L16)
## sp_isGUIInit

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\singleplayer_view.sqf at line 18](../../../Src/host/Singleplayer/singleplayer_view.sqf#L18)
## sp_int_taskTextOrigPos

Type: Variable

Description: 


Initial value:
```sqf
vec4(0,0,0,0)
```
File: [host\Singleplayer\singleplayer_view.sqf at line 90](../../../Src/host/Singleplayer/singleplayer_view.sqf#L90)
## sp_int_nextTaskTextParams

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [host\Singleplayer\singleplayer_view.sqf at line 114](../../../Src/host/Singleplayer/singleplayer_view.sqf#L114)
## sp_initGUI

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 19](../../../Src/host/Singleplayer/singleplayer_view.sqf#L19)
## sp_view_setBordersVisible

Type: function

Description: 
- Param: _mode
- Param: _time (optional, default 0)

File: [host\Singleplayer\singleplayer_view.sqf at line 77](../../../Src/host/Singleplayer/singleplayer_view.sqf#L77)
## sp_int_getTaskCtgWidget

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 92](../../../Src/host/Singleplayer/singleplayer_view.sqf#L92)
## sp_int_getTaskBackgroundWidget

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 93](../../../Src/host/Singleplayer/singleplayer_view.sqf#L93)
## sp_int_getTaskTextWidget

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 94](../../../Src/host/Singleplayer/singleplayer_view.sqf#L94)
## sp_int_getNotificationWidgetCtg

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 96](../../../Src/host/Singleplayer/singleplayer_view.sqf#L96)
## sp_int_getNotificationWidget

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 97](../../../Src/host/Singleplayer/singleplayer_view.sqf#L97)
## sp_setTaskMessage

Type: function

Description: 
- Param: _header
- Param: _desc (optional, default "")

File: [host\Singleplayer\singleplayer_view.sqf at line 99](../../../Src/host/Singleplayer/singleplayer_view.sqf#L99)
## sp_setTaskMessageEff

Type: function

Description: 
- Param: _header
- Param: _desc (optional, default "")

File: [host\Singleplayer\singleplayer_view.sqf at line 116](../../../Src/host/Singleplayer/singleplayer_view.sqf#L116)
## sp_setHideTaskMessageCtg

Type: function

Description: 
- Param: _mode

File: [host\Singleplayer\singleplayer_view.sqf at line 122](../../../Src/host/Singleplayer/singleplayer_view.sqf#L122)
## sp_isVisibleTaskMesssageCtg

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 133](../../../Src/host/Singleplayer/singleplayer_view.sqf#L133)
## sp_setNotification

Type: function

Description: notification system
- Param: _text

File: [host\Singleplayer\singleplayer_view.sqf at line 138](../../../Src/host/Singleplayer/singleplayer_view.sqf#L138)
## sp_setNotificationVisible

Type: function

Description: 
- Param: _mode
- Param: _notifHandler (optional, default "")

File: [host\Singleplayer\singleplayer_view.sqf at line 169](../../../Src/host/Singleplayer/singleplayer_view.sqf#L169)
## sp_isVisibleNotification

Type: function

Description: 


File: [host\Singleplayer\singleplayer_view.sqf at line 182](../../../Src/host/Singleplayer/singleplayer_view.sqf#L182)
## sp_createWidgetHighlight

Type: function

Description: 
- Param: _w
- Param: _sizePx (optional, default 0.01)

File: [host\Singleplayer\singleplayer_view.sqf at line 187](../../../Src/host/Singleplayer/singleplayer_view.sqf#L187)
## sp_view_setPlayerHudVisible

Type: function

Description: включение или отключение отображения худа. для черного экрана используем setBlackScreenGUI
- Param: _mode (optional, default "inv+right+up+left+stats+cursor")

File: [host\Singleplayer\singleplayer_view.sqf at line 282](../../../Src/host/Singleplayer/singleplayer_view.sqf#L282)
## sp_view_setPlayerHeadVisible

Type: function

Description: установить видимость головы игрока
- Param: _mode

File: [host\Singleplayer\singleplayer_view.sqf at line 296](../../../Src/host/Singleplayer/singleplayer_view.sqf#L296)
# Chapter2.sqf

## cpt2_json_allowedRecipes

Type: Variable

Description: startpos: cpt2_pos_start


Initial value:
```sqf
'...
```
File: [host\Singleplayer\Scenarios\Chapter2.sqf at line 10](../../../Src/host/Singleplayer/Scenarios/Chapter2.sqf#L10)
## cpt2_restoreTrapMethods

Type: function

Description: restore methods


File: [host\Singleplayer\Scenarios\Chapter2.sqf at line 497](../../../Src/host/Singleplayer/Scenarios/Chapter2.sqf#L497)
# Chapter3.sqf

## cpt3_hudvis_default

Type: Variable

Description: 


Initial value:
```sqf
"right+stats+cursor+inv"
```
File: [host\Singleplayer\Scenarios\Chapter3.sqf at line 7](../../../Src/host/Singleplayer/Scenarios/Chapter3.sqf#L7)
## cpt3_hudvis_eaterzone

Type: Variable

Description: 


Initial value:
```sqf
cpt3_hudvis_default + "+left"
```
File: [host\Singleplayer\Scenarios\Chapter3.sqf at line 8](../../../Src/host/Singleplayer/Scenarios/Chapter3.sqf#L8)
## cpt3_hudvis_eatercombat

Type: Variable

Description: 


Initial value:
```sqf
cpt3_hudvis_eaterzone + "+up"
```
File: [host\Singleplayer\Scenarios\Chapter3.sqf at line 9](../../../Src/host/Singleplayer/Scenarios/Chapter3.sqf#L9)
## cpt3_func_damageEvent

Type: function

Description: 


File: [host\Singleplayer\Scenarios\Chapter3.sqf at line 562](../../../Src/host/Singleplayer/Scenarios/Chapter3.sqf#L562)
# Chapter4.sqf

## cpt4_questName_begin

Type: Variable

Description: 


Initial value:
```sqf
"Снова за работу"
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 22](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L22)
## cpt4_questName_kochevs

Type: Variable

Description: 


Initial value:
```sqf
"Оформим как надо"
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 23](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L23)
## cpt4_questName_tomed

Type: Variable

Description: 


Initial value:
```sqf
"На досмотр"
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 24](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L24)
## cpt4_questName_tobar

Type: Variable

Description: 


Initial value:
```sqf
"Смену отпахал"
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 26](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L26)
## cpt4_canOpenEnter

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 28](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L28)
## cpt4_canOpenWindow

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 29](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L29)
## cpt4_gref_doorwindow

Type: Variable

Description: 


Initial value:
```sqf
"GateCity G:8fd0oIb9ArY (2)"
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 31](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L31)
## cpt4_gref_doorenter

Type: Variable

Description: 


Initial value:
```sqf
"GateCity G:8fd0oIb9ArY (1)"
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 32](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L32)
## cpt4_bar_musicProc

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 768](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L768)
## cpt4_bar_musicUpdateReq

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 769](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L769)
## cpt4_bar_musicHandle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 773](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L773)
## cpt4_bar_curMusicPlayed

Type: Variable

Description: !errors... ifcheck(


Initial value:
```sqf
-1
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 777](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L777)
## cpt4_bar_curMusicStartTime

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 778](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L778)
## cpt4_bar_curMusicDist

Type: Variable

Description: 


Initial value:
```sqf
10
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 779](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L779)
## cpt4_bar_curMusicName

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 780](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L780)
## cpt4_addProcessorMainAct

Type: function

Description: 
- Param: _tobjName
- Param: _code

File: [host\Singleplayer\Scenarios\Chapter4.sqf at line 34](../../../Src/host/Singleplayer/Scenarios/Chapter4.sqf#L34)
