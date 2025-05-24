# LightEngine.h

## lightObject

Type: constant

Description: 


Replaced value:
```sqf
_light
```
File: [client\LightEngine\LightEngine.h at line 13](../../../Src/client/LightEngine/LightEngine.h#L13)
## sourceObject

Type: constant

Description: 


Replaced value:
```sqf
_source
```
File: [client\LightEngine\LightEngine.h at line 16](../../../Src/client/LightEngine/LightEngine.h#L16)
## allEmitters

Type: constant

Description: 


Replaced value:
```sqf
_allEmitters
```
File: [client\LightEngine\LightEngine.h at line 19](../../../Src/client/LightEngine/LightEngine.h#L19)
## le_light_max_index

Type: constant

Description: 


Replaced value:
```sqf
1999
```
File: [client\LightEngine\LightEngine.h at line 22](../../../Src/client/LightEngine/LightEngine.h#L22)
## emitterObject

Type: constant

Description: 


Replaced value:
```sqf
_effEmitter
```
File: [client\LightEngine\LightEngine.h at line 25](../../../Src/client/LightEngine/LightEngine.h#L25)
## src

Type: constant

Description: 


Replaced value:
```sqf
_src
```
File: [client\LightEngine\LightEngine.h at line 30](../../../Src/client/LightEngine/LightEngine.h#L30)
## localPlayer

Type: constant

Description: 


Replaced value:
```sqf
__LOCAL_PLAYER__
```
File: [client\LightEngine\LightEngine.h at line 34](../../../Src/client/LightEngine/LightEngine.h#L34)
## update_delay_mainThread

Type: constant

Description: 


Replaced value:
```sqf
0.01
```
File: [client\LightEngine\LightEngine.h at line 39](../../../Src/client/LightEngine/LightEngine.h#L39)
## le_firelight_startindex

Type: constant

Description: 


Replaced value:
```sqf
5000
```
File: [client\LightEngine\LightEngine.h at line 43](../../../Src/client/LightEngine/LightEngine.h#L43)
## SCRIPT_EMIT_HANDLER_MODE_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\LightEngine\LightEngine.h at line 73](../../../Src/client/LightEngine/LightEngine.h#L73)
## SCRIPT_EMIT_HANDLER_MODE_DROP

Type: constant

Description: скриптовый обработчик дроппер. основная особенность - не создает направленные источники, удаляется самостоятельно


Replaced value:
```sqf
1
```
File: [client\LightEngine\LightEngine.h at line 75](../../../Src/client/LightEngine/LightEngine.h#L75)
## SCRIPT_EMIT_HANDLER_MODE_UNMANAGED

Type: constant

Description: скриптовый обработчик неуправляемый. основная особенность - не привязан к объекту, создается в позиции. пользователь самостоятельно должен удалять его


Replaced value:
```sqf
2
```
File: [client\LightEngine\LightEngine.h at line 77](../../../Src/client/LightEngine/LightEngine.h#L77)
## regScriptEmit(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
_semDat = []; le_se_map set ['type',_semDat]; le_conf_##type = { \
	params ['sourceObject']; \
	sourceObject setvariable ["__config",type]; \
	private allEmitters = []; \
	sourceObject setVariable ["__allEmitters",allEmitters]; \
	[(le_se_map get 'type')] call le_se_handleConfig; \
};	_semDat append [
```
File: [client\LightEngine\LightEngine.h at line 84](../../../Src/client/LightEngine/LightEngine.h#L84)
## endScriptEmit

Type: constant

Description: 


Replaced value:
```sqf
] ;
```
File: [client\LightEngine\LightEngine.h at line 93](../../../Src/client/LightEngine/LightEngine.h#L93)
## _emitAlias(strval)

Type: constant

Description: 
- Param: strval

Replaced value:
```sqf
["alias",strval],
```
File: [client\LightEngine\LightEngine.h at line 97](../../../Src/client/LightEngine/LightEngine.h#L97)
## type

Type: function

Description: 
- Param: sourceObject

File: [client\LightEngine\LightEngine.h at line 84](../../../Src/client/LightEngine/LightEngine.h#L84)
# LightEngine.sqf

## le_simulated

Type: Variable

Description: 


Initial value:
```sqf
clientMob//"B_Soldier_F" createVehicleLocal [0,0,0]
```
File: [client\LightEngine\LightEngine.sqf at line 49](../../../Src/client/LightEngine/LightEngine.sqf#L49)
## le_allChunkTypes

Type: Variable

Description: 


Initial value:
```sqf
[CHUNK_TYPE_ITEM,CHUNK_TYPE_STRUCTURE,CHUNK_TYPE_DECOR]
```
File: [client\LightEngine\LightEngine.sqf at line 56](../../../Src/client/LightEngine/LightEngine.sqf#L56)
## le_allLights

Type: Variable

Description: 


Initial value:
```sqf
[] //all light points
```
File: [client\LightEngine\LightEngine.sqf at line 59](../../../Src/client/LightEngine/LightEngine.sqf#L59)
## le_initializeScriptedConfigs

Type: function

Description: 


File: [client\LightEngine\LightEngine.sqf at line 19](../../../Src/client/LightEngine/LightEngine.sqf#L19)
## le_loadLight

Type: function

Description: 
- Param: _type (optional, default -1)
- Param: _src

File: [client\LightEngine\LightEngine.sqf at line 82](../../../Src/client/LightEngine/LightEngine.sqf#L82)
## le_unloadLight

Type: function

Description: 
- Param: _obj

File: [client\LightEngine\LightEngine.sqf at line 138](../../../Src/client/LightEngine/LightEngine.sqf#L138)
## le_isLoadedLight

Type: function

Description: 
- Param: _obj

File: [client\LightEngine\LightEngine.sqf at line 168](../../../Src/client/LightEngine/LightEngine.sqf#L168)
## le_getLoadedLightCfg

Type: function

Description: 
- Param: _obj

File: [client\LightEngine\LightEngine.sqf at line 175](../../../Src/client/LightEngine/LightEngine.sqf#L175)
## le_isLightConfig

Type: function

Description: 


File: [client\LightEngine\LightEngine.sqf at line 183](../../../Src/client/LightEngine/LightEngine.sqf#L183)
## le_debug_canViewLight

Type: function

Description: 
- Param: _src
- Param: _isLightObject

File: [client\LightEngine\LightEngine.sqf at line 223](../../../Src/client/LightEngine/LightEngine.sqf#L223)
## le_se_emitFireAtPos

Type: function

Description: 
- Param: _pos
- Param: _type
- Param: _norm

File: [client\LightEngine\LightEngine.sqf at line 374](../../../Src/client/LightEngine/LightEngine.sqf#L374)
## le_se_emitFireAtActor

Type: function

Description: 
- Param: _owner
- Param: _type
- Param: _sel (optional, default "spine3")
- Param: _deleteAfter

File: [client\LightEngine\LightEngine.sqf at line 382](../../../Src/client/LightEngine/LightEngine.sqf#L382)
# LightEngine_mainThread.sqf

## loadLightOnObject(_x)

Type: constant

Description: 
- Param: _x

Replaced value:
```sqf
[_x getVariable "light",_x] call le_loadLight
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 48](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L48)
## unloadLightOnObject(_x)

Type: constant

Description: 
- Param: _x

Replaced value:
```sqf
[_x] call le_unloadLight
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 49](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L49)
## __chunkToGLSType()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(format["%1:%2:%3",_type,_cx,_cy])
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 51](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L51)
## __compareHashesStr()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(format["G:%1 -> L:%2",_hash,_localHash])
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 52](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L52)
## le_lastChunkItem

Type: Variable

Description: ! This file not used.


Initial value:
```sqf
null
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 8](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L8)
## le_lastChunkStructure

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 9](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L9)
## le_onUpdate

Type: function

Description: основной поток обновления


File: [client\LightEngine\LightEngine_mainThread.sqf at line 12](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L12)
## le_collectAroundChunks

Type: function

Description: 
- Param: _loadList
- Param: _chunk
- Param: _chunkType

File: [client\LightEngine\LightEngine_mainThread.sqf at line 111](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L111)
# LightEngine_ScriptedCulling.sqf

## LESC_USE_FAST_UPDATE

Type: constant

Description: #define LESC_ENABLE_CULLING


Replaced value:
```sqf

```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 15](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L15)
## lesc_list_allObjects

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 269](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L269)
## lesc_list_allDataObjs

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 273](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L273)
## lesc_cullCnt

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 350](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L350)
## lesc_setDebugRender

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _mode

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 261](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L261)
## lesc_handleLight

Type: function

Description: 
- Param: _lt
- Param: _isDirect (optional, default false)

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 280](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L280)
## lesc_onLightRemove

Type: function

Description: 
- Param: _dummyParam

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 300](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L300)
## lesc_handleProp

Type: function

Description: 
- Param: _o
- Param: _prop
- Param: _val

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 314](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L314)
## lesc_cullingProcess

Type: function

Description: 


File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 353](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L353)
# LightRender.sqf

## LIGHT_RENDER_PRINT_ERROR_IF_NOT_INIT_ON_CUSTOM

Type: constant

Description: todo doc update


Replaced value:
```sqf

```
File: [client\LightEngine\LightRender.sqf at line 11](../../../Src/client/LightEngine/LightRender.sqf#L11)
## NEW_ALGORITHM_LIGHT_RENDERING

Type: constant

Description: Новый алгоритм затухания и появления света. С первой легаси версии является основным способом рендеринга света


Replaced value:
```sqf

```
File: [client\LightEngine\LightRender.sqf at line 14](../../../Src/client/LightEngine/LightRender.sqf#L14)
## BRIGHT_CHANGE_VALUE_ON_FRAME

Type: constant

Description: как я понял расчёт по кадрам


Replaced value:
```sqf
10
```
File: [client\LightEngine\LightRender.sqf at line 17](../../../Src/client/LightEngine/LightRender.sqf#L17)
## LE_RENDER_DISTANCE_ONCHECK

Type: constant

Description: дистанция отрисовки света если локальный игрок не смотрит на него


Replaced value:
```sqf
7
```
File: [client\LightEngine\LightRender.sqf at line 22](../../../Src/client/LightEngine/LightRender.sqf#L22)
## distRad

Type: constant

Description: 


Replaced value:
```sqf
1400.5
```
File: [client\LightEngine\LightRender.sqf at line 51](../../../Src/client/LightEngine/LightRender.sqf#L51)
## upperMax

Type: constant

Description: 


Replaced value:
```sqf
1000
```
File: [client\LightEngine\LightRender.sqf at line 52](../../../Src/client/LightEngine/LightRender.sqf#L52)
## constbias

Type: constant

Description: lastpos_cached = _npos;


Replaced value:
```sqf
0.1
```
File: [client\LightEngine\LightRender.sqf at line 153](../../../Src/client/LightEngine/LightRender.sqf#L153)
## gvar(obj,val)

Type: constant

Description: _eyeZ = eyepos player select 2;
- Param: obj
- Param: val

Replaced value:
```sqf
(obj getvariable #val)
```
File: [client\LightEngine\LightRender.sqf at line 162](../../../Src/client/LightEngine/LightRender.sqf#L162)
## gvardef(obj,val,def)

Type: constant

Description: 
- Param: obj
- Param: val
- Param: def

Replaced value:
```sqf
(obj getvariable [#val,def])
```
File: [client\LightEngine\LightRender.sqf at line 163](../../../Src/client/LightEngine/LightRender.sqf#L163)
## svar(obj,var,val)

Type: constant

Description: 
- Param: obj
- Param: var
- Param: val

Replaced value:
```sqf
obj setvariable [#var,val]
```
File: [client\LightEngine\LightRender.sqf at line 164](../../../Src/client/LightEngine/LightRender.sqf#L164)
## timetofadelight

Type: constant

Description: 


Replaced value:
```sqf
0.05
```
File: [client\LightEngine\LightRender.sqf at line 165](../../../Src/client/LightEngine/LightRender.sqf#L165)
## le_list_changevis

Type: Variable

Description: structs in type: src,lt,curview,


Initial value:
```sqf
[]
```
File: [client\LightEngine\LightRender.sqf at line 31](../../../Src/client/LightEngine/LightRender.sqf#L31)
## le_render_handleState

Type: Variable

> Exists if **NEW_ALGORITHM_LIGHT_RENDERING** defined

Description: 


Initial value:
```sqf
startUpdate(le_onchangeview,0)
```
File: [client\LightEngine\LightRender.sqf at line 309](../../../Src/client/LightEngine/LightRender.sqf#L309)
## le_render_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(le_onupdrender,0)
```
File: [client\LightEngine\LightRender.sqf at line 312](../../../Src/client/LightEngine/LightRender.sqf#L312)
## le_initRenderer

Type: function

Description: 
- Param: _obj

File: [client\LightEngine\LightRender.sqf at line 33](../../../Src/client/LightEngine/LightRender.sqf#L33)
## le_render_findUpSide

Type: function

Description: 


File: [client\LightEngine\LightRender.sqf at line 48](../../../Src/client/LightEngine/LightRender.sqf#L48)
## le_addTransitionState

Type: function

Description: if _mode then do render else hide
- Param: _src
- Param: _mode

File: [client\LightEngine\LightRender.sqf at line 81](../../../Src/client/LightEngine/LightRender.sqf#L81)
## le_onupdrender

Type: function

Description: 


File: [client\LightEngine\LightRender.sqf at line 108](../../../Src/client/LightEngine/LightRender.sqf#L108)
## le_onchangeview

Type: function

Description: 
- Param: _src
- Param: _lt
- Param: _curval
- Param: _modif
- Param: _mode

File: [client\LightEngine\LightRender.sqf at line 261](../../../Src/client/LightEngine/LightRender.sqf#L261)
# ScriptedEffects.sqf

## le_se_map

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\LightEngine\ScriptedEffects.sqf at line 12](../../../Src/client/LightEngine/ScriptedEffects.sqf#L12)
## le_se_noattr

Type: Variable

Description: 


Initial value:
```sqf
null //!not used
```
File: [client\LightEngine\ScriptedEffects.sqf at line 14](../../../Src/client/LightEngine/ScriptedEffects.sqf#L14)
## le_se_cfgRange

Type: Variable

Description: 


Initial value:
```sqf
[2100,4900]
```
File: [client\LightEngine\ScriptedEffects.sqf at line 16](../../../Src/client/LightEngine/ScriptedEffects.sqf#L16)
## le_se_map_cfgHandlers

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //карта зарегистрированных конфигов
```
File: [client\LightEngine\ScriptedEffects.sqf at line 221](../../../Src/client/LightEngine/ScriptedEffects.sqf#L221)
## le_se_mapHandlersUnmanaged

Type: Variable

Description: 


Initial value:
```sqf
null //карта нативных эффектов
```
File: [client\LightEngine\ScriptedEffects.sqf at line 227](../../../Src/client/LightEngine/ScriptedEffects.sqf#L227)
## le_se_mapHandlersShots

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\LightEngine\ScriptedEffects.sqf at line 229](../../../Src/client/LightEngine/ScriptedEffects.sqf#L229)
## le_se_mapHandlers

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\LightEngine\ScriptedEffects.sqf at line 238](../../../Src/client/LightEngine/ScriptedEffects.sqf#L238)
## le_se_map_partAddress

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key setParticleN , value [functions]
```
File: [client\LightEngine\ScriptedEffects.sqf at line 505](../../../Src/client/LightEngine/ScriptedEffects.sqf#L505)
## le_se_list_fassoc

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\LightEngine\ScriptedEffects.sqf at line 614](../../../Src/client/LightEngine/ScriptedEffects.sqf#L614)
## le_se_handleConfig

Type: function

Description: 
- Param: _cfgDataList
- Param: _hMode (optional, default SCRIPT_EMIT_HANDLER_MODE_DEFAULT)
- Param: _dropPos

File: [client\LightEngine\ScriptedEffects.sqf at line 40](../../../Src/client/LightEngine/ScriptedEffects.sqf#L40)
## le_se_createUnmanagedEmitter

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 143](../../../Src/client/LightEngine/ScriptedEffects.sqf#L143)
## le_se_handleCfgEvents

Type: function

Description: 
- Param: _cfgName
- Param: _cfgInParams

File: [client\LightEngine\ScriptedEffects.sqf at line 165](../../../Src/client/LightEngine/ScriptedEffects.sqf#L165)
## le_se_internal_errorFuncCfgEvents

Type: function

Description: 
- Param: _errpar

File: [client\LightEngine\ScriptedEffects.sqf at line 181](../../../Src/client/LightEngine/ScriptedEffects.sqf#L181)
## le_se_registerConfigHandler

Type: function

Description: 
- Param: _cfgName
- Param: _cfgCode

File: [client\LightEngine\ScriptedEffects.sqf at line 187](../../../Src/client/LightEngine/ScriptedEffects.sqf#L187)
## le_se_isAttachedToMob

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 194](../../../Src/client/LightEngine/ScriptedEffects.sqf#L194)
## le_se_getAttachedProxySlot

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 200](../../../Src/client/LightEngine/ScriptedEffects.sqf#L200)
## le_se_getCurrentConfigPropVal

Type: function

Description: 
- Param: _srch

File: [client\LightEngine\ScriptedEffects.sqf at line 206](../../../Src/client/LightEngine/ScriptedEffects.sqf#L206)
## le_se_getCurrentConfigId

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 216](../../../Src/client/LightEngine/ScriptedEffects.sqf#L216)
## le_se_getSimProxObj

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 233](../../../Src/client/LightEngine/ScriptedEffects.sqf#L233)
## le_se_errorHandler

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 275](../../../Src/client/LightEngine/ScriptedEffects.sqf#L275)
## le_se_intenral_handleVarInit

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 280](../../../Src/client/LightEngine/ScriptedEffects.sqf#L280)
## le_se_internal_createDropEmitterMap

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 295](../../../Src/client/LightEngine/ScriptedEffects.sqf#L295)
## le_se_internal_createUnmanagedEmitterMap

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 344](../../../Src/client/LightEngine/ScriptedEffects.sqf#L344)
## le_se_intenral_handleUnmanagedVarInit

Type: function

Description: 
- Param: _prop
- Param: _val

File: [client\LightEngine\ScriptedEffects.sqf at line 364](../../../Src/client/LightEngine/ScriptedEffects.sqf#L364)
## le_se_intenral_handleDropVarInit

Type: function

Description: 
- Param: _prop
- Param: _val

File: [client\LightEngine\ScriptedEffects.sqf at line 382](../../../Src/client/LightEngine/ScriptedEffects.sqf#L382)
## le_se_fireEmit

Type: function

Description: 
- Param: _cfg
- Param: _pos
- Param: _norm (optional, default ['0', '0', '1'])
- Param: _deleteAfter
- Param: _refemitters
- Param: _reservedParam

File: [client\LightEngine\ScriptedEffects.sqf at line 391](../../../Src/client/LightEngine/ScriptedEffects.sqf#L391)
## le_se_initScriptedLights

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 433](../../../Src/client/LightEngine/ScriptedEffects.sqf#L433)
## le_se_doSorting

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 457](../../../Src/client/LightEngine/ScriptedEffects.sqf#L457)
## le_se_getParticleOption

Type: function

Description: 
- Param: _optName
- Param: _varname
- Param: _storage

File: [client\LightEngine\ScriptedEffects.sqf at line 508](../../../Src/client/LightEngine/ScriptedEffects.sqf#L508)
## le_se_setParticleOption

Type: function

Description: 
- Param: _optName
- Param: _varname
- Param: _storage
- Param: _value

File: [client\LightEngine\ScriptedEffects.sqf at line 518](../../../Src/client/LightEngine/ScriptedEffects.sqf#L518)
## le_se_getCurrentEmitterIndex

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 528](../../../Src/client/LightEngine/ScriptedEffects.sqf#L528)
## le_se_internal_generateOptionAddress

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 531](../../../Src/client/LightEngine/ScriptedEffects.sqf#L531)
