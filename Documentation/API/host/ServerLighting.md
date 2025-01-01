# ServerLighting_init.sqf

## sltInit(cfg)

Type: constant

Description: 
- Param: cfg

Replaced value:
```sqf
_new_seg_slt = [cfg]; __slt_configs pushBack _new_seg_slt; _new_seg_slt pushBack
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 12](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L12)
## slt_createLight()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
("#lightpoint" createVehicleLocal [0,0,0])
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 14](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L14)
## slt_createObj(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
(call {private __o = (type) createVehicleLocal [0,0,0]; __o allowDamage false; __o})
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 15](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L15)
## sourceObject

Type: constant

Description: 


Replaced value:
```sqf
_wObj
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 28](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L28)
## lightObject

Type: constant

Description: 


Replaced value:
```sqf
_firstLight
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 29](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L29)
## linkToSource(obj,vecoffset)

Type: constant

Description: 
- Param: obj
- Param: vecoffset

Replaced value:
```sqf
obj setPosAtl (getPosATL sourceObject); obj setVectorDirAndUp [vectorDirVisual sourceObject,vectorUpVisual sourceObject]
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 18](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L18)
## linkLightToSource(obj,vecoffset)

Type: constant

Description: 
- Param: obj
- Param: vecoffset

Replaced value:
```sqf
obj lightAttachObject [sourceObject,vecoffset]
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 19](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L19)
## regScriptEmit(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
_semDat = []; slt_map_scriptCfgs set ['type',_semDat]; slt_cfg_id_##type = { \
	params ['sourceObject']; \
	(slt_map_scriptCfgs get 'type') call slt_handleScriptedCfg; \
}; _semDat append [
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 33](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L33)
## endScriptEmit

Type: constant

Description: 


Replaced value:
```sqf
];
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 37](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L37)
## _emitAlias(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf

```
File: [host\ServerLighting\ServerLighting_init.sqf at line 38](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L38)
## SCRIPT_EMIT_EVAL_SERVER

Type: constant

Description: Опеределяем предкомпилированные константы


Replaced value:
```sqf

```
File: [host\ServerLighting\ServerLighting_init.sqf at line 44](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L44)
## slt_map_scriptCfgs

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 31](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L31)
## slt_scriptedCfgMapHandlers

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 90](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L90)
## slt_const_dummyMob

Type: Variable

Description: 


Initial value:
```sqf
[10,10,0] call gm_createMob
```
File: [host\ServerLighting\ServerLighting_init.sqf at line 130](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L130)
## type

Type: function

Description: 
- Param: sourceObject

File: [host\ServerLighting\ServerLighting_init.sqf at line 33](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L33)
## slt_handleScriptedCfg

Type: function

Description: 


File: [host\ServerLighting\ServerLighting_init.sqf at line 48](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L48)
## slt_handleScriptedCfgVars

Type: function

Description: 


File: [host\ServerLighting\ServerLighting_init.sqf at line 79](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L79)
## slt_create

Type: function

Description: 
- Param: _obj
- Param: _cfg
- Param: _autolink (optional, default true)
- Param: _select (optional, default "")

File: [host\ServerLighting\ServerLighting_init.sqf at line 132](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L132)
## slt_destr

Type: function

Description: 
- Param: _obj

File: [host\ServerLighting\ServerLighting_init.sqf at line 157](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L157)
## slt_destr_impl

Type: function

Description: real impl of destroy server light
- Param: _o

File: [host\ServerLighting\ServerLighting_init.sqf at line 165](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L165)
## slt_scriptCfg_doSorting

Type: function

Description: фикс из le_se_doSorting с доп.оптимизацией


File: [host\ServerLighting\ServerLighting_init.sqf at line 175](../../../Src/host/ServerLighting/ServerLighting_init.sqf#L175)
