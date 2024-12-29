# LightEngine.h

## lightObject

Type: constant

Description: #define usedebuglightrender


Replaced value:
```sqf
_light
```
File: [client\LightEngine\LightEngine.h at line 9](../../../Src/client/LightEngine/LightEngine.h#L9)
## sourceObject

Type: constant

Description: 


Replaced value:
```sqf
_source
```
File: [client\LightEngine\LightEngine.h at line 11](../../../Src/client/LightEngine/LightEngine.h#L11)
## allEmitters

Type: constant

Description: 


Replaced value:
```sqf
_allEmitters
```
File: [client\LightEngine\LightEngine.h at line 13](../../../Src/client/LightEngine/LightEngine.h#L13)
## le_light_max_index

Type: constant

Description: 


Replaced value:
```sqf
1999
```
File: [client\LightEngine\LightEngine.h at line 15](../../../Src/client/LightEngine/LightEngine.h#L15)
## regLight(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
le_conf_##type = { params ['sourceObject']; private lightObject = "#lightpoint" createVehicleLocal [0,0,0]; \
sourceObject setvariable ["__config",type]; sourceObject setVariable ["__light",lightObject]; private allEmitters = [lightObject]; sourceObject setVariable ["__allEmitters",allEmitters]; \
1 call le_debug_lightRender;
```
File: [client\LightEngine\LightEngine.h at line 17](../../../Src/client/LightEngine/LightEngine.h#L17)
## endRegLight

Type: constant

Description: 


Replaced value:
```sqf
lightObject };
```
File: [client\LightEngine\LightEngine.h at line 21](../../../Src/client/LightEngine/LightEngine.h#L21)
## regCustomLight(type,classnamestr)

Type: constant

Description: 
- Param: type
- Param: classnamestr

Replaced value:
```sqf
le_conf_##type = {params ['sourceObject']; private lightObject = (classnamestr) createVehicleLocal [0,0,0]; \
sourceObject setvariable ["__config",type]; sourceObject setVariable ["__light",lightObject]; private allEmitters = [lightObject]; sourceObject setVariable ["__allEmitters",allEmitters]; \
2 call le_debug_lightRender;
```
File: [client\LightEngine\LightEngine.h at line 23](../../../Src/client/LightEngine/LightEngine.h#L23)
## emitterObject

Type: constant

Description: 


Replaced value:
```sqf
_effEmitter
```
File: [client\LightEngine\LightEngine.h at line 27](../../../Src/client/LightEngine/LightEngine.h#L27)
## regEffect(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
le_conf_##type = { params ['sourceObject']; private emitterObject = "#particlesource" createVehicleLocal [0,0,0]; \
sourceObject setvariable ["__config",type]; sourceObject setVariable ["__light",emitterObject]; private allEmitters = [emitterObject]; sourceObject setVariable ["__allEmitters",allEmitters]; \

```
File: [client\LightEngine\LightEngine.h at line 29](../../../Src/client/LightEngine/LightEngine.h#L29)
## endRegEffect

Type: constant

Description: 


Replaced value:
```sqf
};
```
File: [client\LightEngine\LightEngine.h at line 32](../../../Src/client/LightEngine/LightEngine.h#L32)
## regFireLight(type)

Type: constant

Description: firelight event type def
- Param: type

Replaced value:
```sqf
_rfl_t = type; _rfl_ev = {params ['sourceObject'];
```
File: [client\LightEngine\LightEngine.h at line 35](../../../Src/client/LightEngine/LightEngine.h#L35)
## endRegFireLight

Type: constant

Description: 


Replaced value:
```sqf
}; missionNamespace setVariable ["le_conf_fire_" + str(_rfl_t - le_firelight_startindex),_rfl_ev];
```
File: [client\LightEngine\LightEngine.h at line 37](../../../Src/client/LightEngine/LightEngine.h#L37)
## initLightObject()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
private lightObject = "#lightpoint" createVehicleLocal [0,0,0]
```
File: [client\LightEngine\LightEngine.h at line 39](../../../Src/client/LightEngine/LightEngine.h#L39)
## regVST(type)

Type: constant

Description: visual states functionality
- Param: type

Replaced value:
```sqf
le_conf_##type = { params ["_condit","_src",["_ctxParams",0]]; private __GLOB_CFG_IDX__ = type ;
```
File: [client\LightEngine\LightEngine.h at line 42](../../../Src/client/LightEngine/LightEngine.h#L42)
## vstParams

Type: constant

Description: 


Replaced value:
```sqf
_ctxParams
```
File: [client\LightEngine\LightEngine.h at line 43](../../../Src/client/LightEngine/LightEngine.h#L43)
## src

Type: constant

Description: source object who inited vst


Replaced value:
```sqf
_src
```
File: [client\LightEngine\LightEngine.h at line 45](../../../Src/client/LightEngine/LightEngine.h#L45)
## localPlayer

Type: constant

Description: local player == this


Replaced value:
```sqf
__LOCAL_PLAYER__
```
File: [client\LightEngine\LightEngine.h at line 48](../../../Src/client/LightEngine/LightEngine.h#L48)
## VST_COND_CREATE

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\LightEngine\LightEngine.h at line 49](../../../Src/client/LightEngine/LightEngine.h#L49)
## VST_COND_DESTR

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\LightEngine\LightEngine.h at line 50](../../../Src/client/LightEngine/LightEngine.h#L50)
## vstIsState(state)

Type: constant

Description: 
- Param: state

Replaced value:
```sqf
(state == _condit)
```
File: [client\LightEngine\LightEngine.h at line 51](../../../Src/client/LightEngine/LightEngine.h#L51)
## VSTCreate

Type: constant

Description: 


Replaced value:
```sqf
if (_condit == VST_COND_CREATE) exitWith
```
File: [client\LightEngine\LightEngine.h at line 52](../../../Src/client/LightEngine/LightEngine.h#L52)
## VSTDestroy

Type: constant

Description: 


Replaced value:
```sqf
if (_condit == VST_COND_DESTR) exitWith
```
File: [client\LightEngine\LightEngine.h at line 53](../../../Src/client/LightEngine/LightEngine.h#L53)
## endRegVST

Type: constant

Description: 


Replaced value:
```sqf
};
```
File: [client\LightEngine\LightEngine.h at line 55](../../../Src/client/LightEngine/LightEngine.h#L55)
## vector(x,y,z)

Type: constant

Description: 
- Param: x
- Param: y
- Param: z

Replaced value:
```sqf
[x,y,z]
```
File: [client\LightEngine\LightEngine.h at line 57](../../../Src/client/LightEngine/LightEngine.h#L57)
## initBrightness(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
lightObject setLightBrightness (val); sourceObject setvariable ["__defBright",val];
```
File: [client\LightEngine\LightEngine.h at line 59](../../../Src/client/LightEngine/LightEngine.h#L59)
## initAsRenderer()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
sourceObject call le_initRenderer;
```
File: [client\LightEngine\LightEngine.h at line 61](../../../Src/client/LightEngine/LightEngine.h#L61)
## linkLight(light,object,anotherParams)

Type: constant

Description: Сразу делает свет динамическим и рабочим (проблема при отсутствии первого атача к игроку)
- Param: light
- Param: object
- Param: anotherParams

Replaced value:
```sqf
light attachto [object,anotherParams]
```
File: [client\LightEngine\LightEngine.h at line 63](../../../Src/client/LightEngine/LightEngine.h#L63)
## linkLightDynamic(src,object,anotParams)

Type: constant

Description: Сразу делает свет динамическим и рабочим (проблема при отсутствии первого атача к игроку)
- Param: src
- Param: object
- Param: anotParams

Replaced value:
```sqf
linkLight(src,player,vector(0,0,0)); linkLight(src,object,anotParams)
```
File: [client\LightEngine\LightEngine.h at line 66](../../../Src/client/LightEngine/LightEngine.h#L66)
## joinEmitter(link)

Type: constant

Description: 
- Param: link

Replaced value:
```sqf
allEmitters pushBackUnique link
```
File: [client\LightEngine\LightEngine.h at line 69](../../../Src/client/LightEngine/LightEngine.h#L69)
## update_delay_mainThread

Type: constant

Description: частота обновления основного треда


Replaced value:
```sqf
0.01
```
File: [client\LightEngine\LightEngine.h at line 72](../../../Src/client/LightEngine/LightEngine.h#L72)
## checktime_ondestroysource

Type: constant

Description: частота проверики на необходимость удаления


Replaced value:
```sqf
0
```
File: [client\LightEngine\LightEngine.h at line 74](../../../Src/client/LightEngine/LightEngine.h#L74)
## le_firelight_startindex

Type: constant

Description: начальное число индексатора для firelight событий (исключая его)


Replaced value:
```sqf
5000
```
File: [client\LightEngine\LightEngine.h at line 76](../../../Src/client/LightEngine/LightEngine.h#L76)
## addEventOnDestroySource(listobjects)

Type: constant

Description: 
- Param: listobjects

Replaced value:
```sqf
private __onframecode = { sourceObject = (_this select 0) select 0; lightObject = (_this select 0) select 1 select 0;if (isNULL sourceObject || isNULL lightObject) then { \
{deleteVehicle _x} foreach ((_this select 0) select 1); [sourceObject] call le_unloadLight; stopThisUpdate(); \
}}; startUpdateParams(__onframecode,checktime_ondestroysource,[sourceObject arg [listobjects]])
```
File: [client\LightEngine\LightEngine.h at line 78](../../../Src/client/LightEngine/LightEngine.h#L78)
## __lcfg__null_params__

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\LightEngine\LightEngine.h at line 82](../../../Src/client/LightEngine/LightEngine.h#L82)
## addEventOnDestroySourceNoParams()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
addEventOnDestroySource(__lcfg__null_params__)
```
File: [client\LightEngine\LightEngine.h at line 83](../../../Src/client/LightEngine/LightEngine.h#L83)
## stopUpdateIfNull(data)

Type: constant

Description: spec events helper
- Param: data

Replaced value:
```sqf
if (isNULL (data)) exitWith {stopThisUpdate()}
```
File: [client\LightEngine\LightEngine.h at line 86](../../../Src/client/LightEngine/LightEngine.h#L86)
## isAttachedToMob()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(!isNullVar(_smd_slotId))
```
File: [client\LightEngine\LightEngine.h at line 90](../../../Src/client/LightEngine/LightEngine.h#L90)
## attachedMobSlot

Type: constant

Description: 


Replaced value:
```sqf
_smd_slotId
```
File: [client\LightEngine\LightEngine.h at line 91](../../../Src/client/LightEngine/LightEngine.h#L91)
## le_shot_startindex

Type: constant

Description: начальное число индексатора для shot событий (исключая его)


Replaced value:
```sqf
10000
```
File: [client\LightEngine\LightEngine.h at line 110](../../../Src/client/LightEngine/LightEngine.h#L110)
## shotParams

Type: constant

Description: 


Replaced value:
```sqf
_shotParams
```
File: [client\LightEngine\LightEngine.h at line 112](../../../Src/client/LightEngine/LightEngine.h#L112)
## regShot(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
_rshot_t = type; _rfl_ev = {params ['sourceObject','shotParams']; private __disposable = [];
```
File: [client\LightEngine\LightEngine.h at line 114](../../../Src/client/LightEngine/LightEngine.h#L114)
## makeParticle(namevar)

Type: constant

Description: 
- Param: namevar

Replaced value:
```sqf
namevar = "#particlesource" createVehicleLocal [0,0,0]; __disposable pushBack namevar
```
File: [client\LightEngine\LightEngine.h at line 115](../../../Src/client/LightEngine/LightEngine.h#L115)
## makeLight(namevar)

Type: constant

Description: 
- Param: namevar

Replaced value:
```sqf
namevar = "#lightpoint" createVehicleLocal [0,0,0]; __disposable pushBack namevar
```
File: [client\LightEngine\LightEngine.h at line 116](../../../Src/client/LightEngine/LightEngine.h#L116)
## disposeAllAfterTime(time)

Type: constant

Description: 
- Param: time

Replaced value:
```sqf
invokeAfterDelayParams({{deleteVehicle _x}count _this},time,__disposable)
```
File: [client\LightEngine\LightEngine.h at line 118](../../../Src/client/LightEngine/LightEngine.h#L118)
## linkObject(light,object,anotherParams)

Type: constant

Description: 
- Param: light
- Param: object
- Param: anotherParams

Replaced value:
```sqf
light attachto [object,anotherParams]
```
File: [client\LightEngine\LightEngine.h at line 120](../../../Src/client/LightEngine/LightEngine.h#L120)
## endRegShot

Type: constant

Description: 


Replaced value:
```sqf
}; missionNamespace setVariable ["le_conf_shot_" + str(_rshot_t - le_shot_startindex),_rfl_ev];
```
File: [client\LightEngine\LightEngine.h at line 122](../../../Src/client/LightEngine/LightEngine.h#L122)
## SCRIPT_EMIT_HANDLER_MODE_DEFAULT

Type: constant

Description: стандартный обработчик скриптовых эффектов


Replaced value:
```sqf
0
```
File: [client\LightEngine\LightEngine.h at line 132](../../../Src/client/LightEngine/LightEngine.h#L132)
## SCRIPT_EMIT_HANDLER_MODE_DROP

Type: constant

Description: скриптовый обработчик дроппер. основная особенность - не создает направленные источники, удаляется самостоятельно


Replaced value:
```sqf
1
```
File: [client\LightEngine\LightEngine.h at line 134](../../../Src/client/LightEngine/LightEngine.h#L134)
## SCRIPT_EMIT_HANDLER_MODE_UNMANAGED

Type: constant

Description: скриптовый обработчик неуправляемый. основная особенность - не привязан к объекту, создается в позиции. пользователь самостоятельно должен удалять его


Replaced value:
```sqf
2
```
File: [client\LightEngine\LightEngine.h at line 136](../../../Src/client/LightEngine/LightEngine.h#L136)
## regScriptEmit(type)

Type: constant

Description: scripted emitters
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
File: [client\LightEngine\LightEngine.h at line 139](../../../Src/client/LightEngine/LightEngine.h#L139)
## endScriptEmit

Type: constant

Description: 


Replaced value:
```sqf
] ;
```
File: [client\LightEngine\LightEngine.h at line 147](../../../Src/client/LightEngine/LightEngine.h#L147)
## _emitAlias(strval)

Type: constant

Description: уникальный алиас
- Param: strval

Replaced value:
```sqf
["alias",strval],
```
File: [client\LightEngine\LightEngine.h at line 150](../../../Src/client/LightEngine/LightEngine.h#L150)
## type

Type: function

Description: 
- Param: sourceObject

File: [client\LightEngine\LightEngine.h at line 139](../../../Src/client/LightEngine/LightEngine.h#L139)
# LightEngine.hpp

## LIGHT_FIRE

Type: constant

Description: !!!Значение нумератора не должно быть меньше нуля!!!


Replaced value:
```sqf
1
```
File: [client\LightEngine\LightEngine.hpp at line 8](../../../Src/client/LightEngine/LightEngine.hpp#L8)
## LIGHT_CAMPFIRE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\LightEngine\LightEngine.hpp at line 9](../../../Src/client/LightEngine/LightEngine.hpp#L9)
## LIGHT_SIGARETTE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\LightEngine\LightEngine.hpp at line 10](../../../Src/client/LightEngine/LightEngine.hpp#L10)
## LIGHT_STREETLAMP

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\LightEngine\LightEngine.hpp at line 11](../../../Src/client/LightEngine/LightEngine.hpp#L11)
## LIGHT_FLASHLIGHT

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\LightEngine\LightEngine.hpp at line 12](../../../Src/client/LightEngine/LightEngine.hpp#L12)
## LIGHT_CAMPFIRE_BIG

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\LightEngine\LightEngine.hpp at line 13](../../../Src/client/LightEngine/LightEngine.hpp#L13)
## LIGHT_SIGN_BAR

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\LightEngine\LightEngine.hpp at line 14](../../../Src/client/LightEngine/LightEngine.hpp#L14)
## LIGHT_SIGN_MEDICAL

Type: constant

Description: 


Replaced value:
```sqf
8
```
File: [client\LightEngine\LightEngine.hpp at line 15](../../../Src/client/LightEngine/LightEngine.hpp#L15)
## LIGHT_LAMP_CEILING

Type: constant

Description: 


Replaced value:
```sqf
9
```
File: [client\LightEngine\LightEngine.hpp at line 16](../../../Src/client/LightEngine/LightEngine.hpp#L16)
## LIGHT_LAMP_WALL

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\LightEngine\LightEngine.hpp at line 17](../../../Src/client/LightEngine/LightEngine.hpp#L17)
## LIGHT_LAMP_KEROSENE

Type: constant

Description: 


Replaced value:
```sqf
11
```
File: [client\LightEngine\LightEngine.hpp at line 18](../../../Src/client/LightEngine/LightEngine.hpp#L18)
## LIGHT_CANDLE

Type: constant

Description: 


Replaced value:
```sqf
12
```
File: [client\LightEngine\LightEngine.hpp at line 19](../../../Src/client/LightEngine/LightEngine.hpp#L19)
## LIGHT_LAMP_CEILING_REDLIGHT

Type: constant

Description: 


Replaced value:
```sqf
13
```
File: [client\LightEngine\LightEngine.hpp at line 20](../../../Src/client/LightEngine/LightEngine.hpp#L20)
## LIGHT_BAKE

Type: constant

Description: 


Replaced value:
```sqf
14
```
File: [client\LightEngine\LightEngine.hpp at line 21](../../../Src/client/LightEngine/LightEngine.hpp#L21)
## LIGHT_BAKESTOVE

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\LightEngine\LightEngine.hpp at line 22](../../../Src/client/LightEngine/LightEngine.hpp#L22)
## LIGHT_MATCH

Type: constant

Description: 


Replaced value:
```sqf
16
```
File: [client\LightEngine\LightEngine.hpp at line 23](../../../Src/client/LightEngine/LightEngine.hpp#L23)
## LIGHT_AREA_EATER_NIGHTVISION

Type: constant

Description: area light configs (starts after 500)


Replaced value:
```sqf
501
```
File: [client\LightEngine\LightEngine.hpp at line 25](../../../Src/client/LightEngine/LightEngine.hpp#L25)
## LIGHT_AREA_GHOST_NIGHTVISION

Type: constant

Description: 


Replaced value:
```sqf
502
```
File: [client\LightEngine\LightEngine.hpp at line 26](../../../Src/client/LightEngine/LightEngine.hpp#L26)
## LIGHT_TRAP_HIDDEN_EFFECT

Type: constant

Description: trap effect


Replaced value:
```sqf
1000
```
File: [client\LightEngine\LightEngine.hpp at line 28](../../../Src/client/LightEngine/LightEngine.hpp#L28)
## LIGHT_LAMP_CEILING_OLD

Type: constant

Description: 


Replaced value:
```sqf
90
```
File: [client\LightEngine\LightEngine.hpp at line 30](../../../Src/client/LightEngine/LightEngine.hpp#L30)
## LIGHT_LAMP_WALL_OLD

Type: constant

Description: 


Replaced value:
```sqf
100
```
File: [client\LightEngine\LightEngine.hpp at line 31](../../../Src/client/LightEngine/LightEngine.hpp#L31)
## EFF_DUST_PARTICLES

Type: constant

Description: effects start after 2000


Replaced value:
```sqf
2001
```
File: [client\LightEngine\LightEngine.hpp at line 34](../../../Src/client/LightEngine/LightEngine.hpp#L34)
## EFF_DUST_CLOUDS

Type: constant

Description: 


Replaced value:
```sqf
2002
```
File: [client\LightEngine\LightEngine.hpp at line 35](../../../Src/client/LightEngine/LightEngine.hpp#L35)
## EFF_GREEN_DUST

Type: constant

Description: 


Replaced value:
```sqf
2003
```
File: [client\LightEngine\LightEngine.hpp at line 36](../../../Src/client/LightEngine/LightEngine.hpp#L36)
## EFF_ROTTEN_HUMAN

Type: constant

Description: 


Replaced value:
```sqf
2004
```
File: [client\LightEngine\LightEngine.hpp at line 37](../../../Src/client/LightEngine/LightEngine.hpp#L37)
## FLIGHT_TEST

Type: constant

Description: firelghts start after 5000 (le_firelight_startindex)


Replaced value:
```sqf
5001
```
File: [client\LightEngine\LightEngine.hpp at line 43](../../../Src/client/LightEngine/LightEngine.hpp#L43)
## SHOT_MEATSPLAT

Type: constant

Description: shotable effects start only after 10000 (le_shot_startindex)


Replaced value:
```sqf
10001
```
File: [client\LightEngine\LightEngine.hpp at line 46](../../../Src/client/LightEngine/LightEngine.hpp#L46)
## SHOT_DESTROYLIMB

Type: constant

Description: 


Replaced value:
```sqf
10002
```
File: [client\LightEngine\LightEngine.hpp at line 47](../../../Src/client/LightEngine/LightEngine.hpp#L47)
## SHOT_BULLET_PISTOL

Type: constant

Description: 


Replaced value:
```sqf
10003
```
File: [client\LightEngine\LightEngine.hpp at line 48](../../../Src/client/LightEngine/LightEngine.hpp#L48)
## SHOT_BULLET_SHOTGUN

Type: constant

Description: 


Replaced value:
```sqf
10004
```
File: [client\LightEngine\LightEngine.hpp at line 49](../../../Src/client/LightEngine/LightEngine.hpp#L49)
## SHOT_BULLET_SHOTRIFLE

Type: constant

Description: 


Replaced value:
```sqf
10005
```
File: [client\LightEngine\LightEngine.hpp at line 50](../../../Src/client/LightEngine/LightEngine.hpp#L50)
## VST_EATER_NIGHTVISION

Type: constant

Description: visual states start only after 20000


Replaced value:
```sqf
20001
```
File: [client\LightEngine\LightEngine.hpp at line 53](../../../Src/client/LightEngine/LightEngine.hpp#L53)
## VST_HUMAN_STEALTH

Type: constant

Description: 


Replaced value:
```sqf
20002
```
File: [client\LightEngine\LightEngine.hpp at line 54](../../../Src/client/LightEngine/LightEngine.hpp#L54)
## VST_CLOTH_BREASTPLATE

Type: constant

Description: 


Replaced value:
```sqf
20003
```
File: [client\LightEngine\LightEngine.hpp at line 55](../../../Src/client/LightEngine/LightEngine.hpp#L55)
## VST_CLOTH_CERAMIC

Type: constant

Description: 


Replaced value:
```sqf
20004
```
File: [client\LightEngine\LightEngine.hpp at line 56](../../../Src/client/LightEngine/LightEngine.hpp#L56)
## VST_CLOTH_STRONGARMOR

Type: constant

Description: 


Replaced value:
```sqf
20005
```
File: [client\LightEngine\LightEngine.hpp at line 57](../../../Src/client/LightEngine/LightEngine.hpp#L57)
## VST_CLOTH_METALARMOR

Type: constant

Description: 


Replaced value:
```sqf
20006
```
File: [client\LightEngine\LightEngine.hpp at line 58](../../../Src/client/LightEngine/LightEngine.hpp#L58)
## VST_CLOTH_FLEXIBLEARMOR

Type: constant

Description: 


Replaced value:
```sqf
20007
```
File: [client\LightEngine\LightEngine.hpp at line 59](../../../Src/client/LightEngine/LightEngine.hpp#L59)
## VST_GHOST_EFFECT

Type: constant

Description: 


Replaced value:
```sqf
20008
```
File: [client\LightEngine\LightEngine.hpp at line 60](../../../Src/client/LightEngine/LightEngine.hpp#L60)
## VST_ATTACHED_OBJECTS

Type: constant

Description: 


Replaced value:
```sqf
20009
```
File: [client\LightEngine\LightEngine.hpp at line 61](../../../Src/client/LightEngine/LightEngine.hpp#L61)
# LightEngine.sqf

## le_simulated

Type: Variable

Description: Нужно выяснить какое существо самое лучшее в плане атачинга при первом создании


Initial value:
```sqf
clientMob//"B_Soldier_F" createVehicleLocal [0,0,0]
```
File: [client\LightEngine\LightEngine.sqf at line 36](../../../Src/client/LightEngine/LightEngine.sqf#L36)
## le_allChunkTypes

Type: Variable

Description: le_localGlsData = nullPtr;


Initial value:
```sqf
[CHUNK_TYPE_ITEM,CHUNK_TYPE_STRUCTURE,CHUNK_TYPE_DECOR]
```
File: [client\LightEngine\LightEngine.sqf at line 43](../../../Src/client/LightEngine/LightEngine.sqf#L43)
## le_allLights

Type: Variable

Description: 


Initial value:
```sqf
[] //all light points
```
File: [client\LightEngine\LightEngine.sqf at line 45](../../../Src/client/LightEngine/LightEngine.sqf#L45)
## le_loadLight

Type: function

Description: загружает источник освещения или частиц
- Param: _type (optional, default -1)
- Param: _src

File: [client\LightEngine\LightEngine.sqf at line 67](../../../Src/client/LightEngine/LightEngine.sqf#L67)
## le_doFireLight

Type: function

Description: автоматическое событие освещения, эффектов или звука
- Param: _type (optional, default -1)
- Param: _src

File: [client\LightEngine\LightEngine.sqf at line 101](../../../Src/client/LightEngine/LightEngine.sqf#L101)
## le_doShot

Type: function

Description: 
- Param: _type
- Param: _src
- Param: _ctxParams (optional, default [])

File: [client\LightEngine\LightEngine.sqf at line 117](../../../Src/client/LightEngine/LightEngine.sqf#L117)
## le_unloadLight

Type: function

Description: выгружает источник освещения
- Param: _obj

File: [client\LightEngine\LightEngine.sqf at line 134](../../../Src/client/LightEngine/LightEngine.sqf#L134)
## le_isLoadedLight

Type: function

Description: проверяет висит ли на объекте источник света
- Param: _obj

File: [client\LightEngine\LightEngine.sqf at line 164](../../../Src/client/LightEngine/LightEngine.sqf#L164)
## le_getLoadedLightCfg

Type: function

Description: 
- Param: _obj

File: [client\LightEngine\LightEngine.sqf at line 170](../../../Src/client/LightEngine/LightEngine.sqf#L170)
## le_isLightConfig

Type: function

Description: 


File: [client\LightEngine\LightEngine.sqf at line 177](../../../Src/client/LightEngine/LightEngine.sqf#L177)
## le_isShotConfig

Type: function

Description: 


File: [client\LightEngine\LightEngine.sqf at line 181](../../../Src/client/LightEngine/LightEngine.sqf#L181)
## le_debug_canViewLight

Type: function

Description: 
- Param: _src
- Param: _isLightObject

File: [client\LightEngine\LightEngine.sqf at line 219](../../../Src/client/LightEngine/LightEngine.sqf#L219)
## le_debug_lightRender

Type: function

Description: 


File: [client\LightEngine\LightEngine.sqf at line 320](../../../Src/client/LightEngine/LightEngine.sqf#L320)
# LightEngine_mainThread.sqf

## loadLightOnObject(_x)

Type: constant

Description: 
- Param: _x

Replaced value:
```sqf
[_x getVariable "light",_x] call le_loadLight
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 47](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L47)
## unloadLightOnObject(_x)

Type: constant

Description: 
- Param: _x

Replaced value:
```sqf
[_x] call le_unloadLight
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 48](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L48)
## __chunkToGLSType()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(format["%1:%2:%3",_type,_cx,_cy])
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 50](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L50)
## __compareHashesStr()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
(format["G:%1 -> L:%2",_hash,_localHash])
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 51](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L51)
## le_lastChunkItem

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 7](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L7)
## le_lastChunkStructure

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\LightEngine\LightEngine_mainThread.sqf at line 8](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L8)
## le_onUpdate

Type: function

Description: основной поток обновления


File: [client\LightEngine\LightEngine_mainThread.sqf at line 11](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L11)
## le_collectAroundChunks

Type: function

Description: 
- Param: _loadList
- Param: _chunk
- Param: _chunkType

File: [client\LightEngine\LightEngine_mainThread.sqf at line 110](../../../Src/client/LightEngine/LightEngine_mainThread.sqf#L110)
# LightEngine_ScriptedCulling.sqf

## LESC_USE_FAST_UPDATE

Type: constant

Description: #define LESC_ENABLE_CULLING


Replaced value:
```sqf

```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 12](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L12)
## lesc_list_allObjects

Type: Variable

Description: all light objects


Initial value:
```sqf
[]
```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 262](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L262)
## lesc_list_allDataObjs

Type: Variable

Description: renderer list point lights


Initial value:
```sqf
[]
```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 265](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L265)
## lesc_cullCnt

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 338](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L338)
## lesc_setDebugRender

Type: function

> Exists if **EDITOR** defined

Description: 
- Param: _mode

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 255](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L255)
## lesc_handleLight

Type: function

Description: handle light object adding to scene
 Вызывается при добавлении света
- Param: _lt
- Param: _isDirect (optional, default false)

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 271](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L271)
## lesc_onLightRemove

Type: function

Description: 
- Param: _dummyParam

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 290](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L290)
## lesc_handleProp

Type: function

Description: 
- Param: _o
- Param: _prop
- Param: _val

File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 303](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L303)
## lesc_cullingProcess

Type: function

Description: 


File: [client\LightEngine\LightEngine_ScriptedCulling.sqf at line 340](../../../Src/client/LightEngine/LightEngine_ScriptedCulling.sqf#L340)
# LightRender.sqf

## LIGHT_RENDER_PRINT_ERROR_IF_NOT_INIT_ON_CUSTOM

Type: constant

Description: так как на конфиг-объектах света нельзя изменять яркость (не скриптовый свет)


Replaced value:
```sqf

```
File: [client\LightEngine\LightRender.sqf at line 8](../../../Src/client/LightEngine/LightRender.sqf#L8)
## NEW_ALGORITHM_LIGHT_RENDERING

Type: constant

Description: Новый алгоритм затухания и появления света. С первой легаси версии является основным способом рендеринга света


Replaced value:
```sqf

```
File: [client\LightEngine\LightRender.sqf at line 11](../../../Src/client/LightEngine/LightRender.sqf#L11)
## BRIGHT_CHANGE_VALUE_ON_FRAME

Type: constant

Description: как я понял расчёт по кадрам


Replaced value:
```sqf
10
```
File: [client\LightEngine\LightRender.sqf at line 14](../../../Src/client/LightEngine/LightRender.sqf#L14)
## LE_RENDER_DISTANCE_ONCHECK

Type: constant

Description: дистанция отрисовки света если локальный игрок не смотрит на него


Replaced value:
```sqf
7
```
File: [client\LightEngine\LightRender.sqf at line 19](../../../Src/client/LightEngine/LightRender.sqf#L19)
## distRad

Type: constant

Description: 


Replaced value:
```sqf
1400.5
```
File: [client\LightEngine\LightRender.sqf at line 48](../../../Src/client/LightEngine/LightRender.sqf#L48)
## upperMax

Type: constant

Description: 


Replaced value:
```sqf
1000
```
File: [client\LightEngine\LightRender.sqf at line 49](../../../Src/client/LightEngine/LightRender.sqf#L49)
## constbias

Type: constant

Description: lastpos_cached = _npos;


Replaced value:
```sqf
0.1
```
File: [client\LightEngine\LightRender.sqf at line 150](../../../Src/client/LightEngine/LightRender.sqf#L150)
## gvar(obj,val)

Type: constant

Description: _eyeZ = eyepos player select 2;
- Param: obj
- Param: val

Replaced value:
```sqf
(obj getvariable #val)
```
File: [client\LightEngine\LightRender.sqf at line 159](../../../Src/client/LightEngine/LightRender.sqf#L159)
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
File: [client\LightEngine\LightRender.sqf at line 160](../../../Src/client/LightEngine/LightRender.sqf#L160)
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
File: [client\LightEngine\LightRender.sqf at line 161](../../../Src/client/LightEngine/LightRender.sqf#L161)
## timetofadelight

Type: constant

Description: 


Replaced value:
```sqf
0.05
```
File: [client\LightEngine\LightRender.sqf at line 162](../../../Src/client/LightEngine/LightRender.sqf#L162)
## le_list_changevis

Type: Variable

Description: structs in type: src,lt,curview,


Initial value:
```sqf
[]
```
File: [client\LightEngine\LightRender.sqf at line 28](../../../Src/client/LightEngine/LightRender.sqf#L28)
## le_render_handleState

Type: Variable

> Exists if **NEW_ALGORITHM_LIGHT_RENDERING** defined

Description: 


Initial value:
```sqf
startUpdate(le_onchangeview,0)
```
File: [client\LightEngine\LightRender.sqf at line 306](../../../Src/client/LightEngine/LightRender.sqf#L306)
## le_render_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
startUpdate(le_onupdrender,0)
```
File: [client\LightEngine\LightRender.sqf at line 309](../../../Src/client/LightEngine/LightRender.sqf#L309)
## le_initRenderer

Type: function

Description: 
- Param: _obj

File: [client\LightEngine\LightRender.sqf at line 30](../../../Src/client/LightEngine/LightRender.sqf#L30)
## le_render_findUpSide

Type: function

Description: 


File: [client\LightEngine\LightRender.sqf at line 45](../../../Src/client/LightEngine/LightRender.sqf#L45)
## le_addTransitionState

Type: function

Description: if _mode then do render else hide
- Param: _src
- Param: _mode

File: [client\LightEngine\LightRender.sqf at line 78](../../../Src/client/LightEngine/LightRender.sqf#L78)
## le_onupdrender

Type: function

Description: 


File: [client\LightEngine\LightRender.sqf at line 105](../../../Src/client/LightEngine/LightRender.sqf#L105)
## le_onchangeview

Type: function

Description: 
- Param: _src
- Param: _lt
- Param: _curval
- Param: _modif
- Param: _mode

File: [client\LightEngine\LightRender.sqf at line 258](../../../Src/client/LightEngine/LightRender.sqf#L258)
# ScriptedEffects.hpp

## SLIGHT_MAGICSTORM_DEBUG

Type: constant

Description: 


Replaced value:
```sqf
2100
```
File: [client\LightEngine\ScriptedEffects.hpp at line 6](../../../Src/client/LightEngine/ScriptedEffects.hpp#L6)
## SLIGHT_SET123_DEBUG

Type: constant

Description: 


Replaced value:
```sqf
2101
```
File: [client\LightEngine\ScriptedEffects.hpp at line 7](../../../Src/client/LightEngine/ScriptedEffects.hpp#L7)
## SLIGHT_TEMPLATE_DIRECTLIGHT

Type: constant

Description: 


Replaced value:
```sqf
2102
```
File: [client\LightEngine\ScriptedEffects.hpp at line 8](../../../Src/client/LightEngine/ScriptedEffects.hpp#L8)
## SLIGHT_TEMPLATE_POINTLIGHT

Type: constant

Description: 


Replaced value:
```sqf
2103
```
File: [client\LightEngine\ScriptedEffects.hpp at line 9](../../../Src/client/LightEngine/ScriptedEffects.hpp#L9)
## SLIGHT_STREET_LAMP

Type: constant

Description: 


Replaced value:
```sqf
2104
```
File: [client\LightEngine\ScriptedEffects.hpp at line 10](../../../Src/client/LightEngine/ScriptedEffects.hpp#L10)
## SLIGHT_SHIT_SMELL

Type: constant

Description: 


Replaced value:
```sqf
2105
```
File: [client\LightEngine\ScriptedEffects.hpp at line 11](../../../Src/client/LightEngine/ScriptedEffects.hpp#L11)
## SLIGHT_WEAK_FIRE

Type: constant

Description: 


Replaced value:
```sqf
2106
```
File: [client\LightEngine\ScriptedEffects.hpp at line 12](../../../Src/client/LightEngine/ScriptedEffects.hpp#L12)
## SLIGHT_SPOT_LAMP

Type: constant

Description: 


Replaced value:
```sqf
2107
```
File: [client\LightEngine\ScriptedEffects.hpp at line 13](../../../Src/client/LightEngine/ScriptedEffects.hpp#L13)
## SLIGHT_LAMP_HOUSE

Type: constant

Description: 


Replaced value:
```sqf
2108
```
File: [client\LightEngine\ScriptedEffects.hpp at line 14](../../../Src/client/LightEngine/ScriptedEffects.hpp#L14)
## SLIGHT_LIGHT_STOVE

Type: constant

Description: 


Replaced value:
```sqf
2109
```
File: [client\LightEngine\ScriptedEffects.hpp at line 15](../../../Src/client/LightEngine/ScriptedEffects.hpp#L15)
## SLIGHT_LIGHT_BAKE

Type: constant

Description: 


Replaced value:
```sqf
2110
```
File: [client\LightEngine\ScriptedEffects.hpp at line 16](../../../Src/client/LightEngine/ScriptedEffects.hpp#L16)
## SLIGHT_STREET_LAMP_DORM

Type: constant

Description: 


Replaced value:
```sqf
2111
```
File: [client\LightEngine\ScriptedEffects.hpp at line 17](../../../Src/client/LightEngine/ScriptedEffects.hpp#L17)
## SLIGHT_DAM_METAL

Type: constant

Description: 


Replaced value:
```sqf
2112
```
File: [client\LightEngine\ScriptedEffects.hpp at line 18](../../../Src/client/LightEngine/ScriptedEffects.hpp#L18)
## SLIGHT_DAM_STONE

Type: constant

Description: 


Replaced value:
```sqf
2113
```
File: [client\LightEngine\ScriptedEffects.hpp at line 19](../../../Src/client/LightEngine/ScriptedEffects.hpp#L19)
## SLIGHT_DAM_WOOD

Type: constant

Description: 


Replaced value:
```sqf
2114
```
File: [client\LightEngine\ScriptedEffects.hpp at line 20](../../../Src/client/LightEngine/ScriptedEffects.hpp#L20)
## SLIGHT_DAM_BETON

Type: constant

Description: 


Replaced value:
```sqf
2115
```
File: [client\LightEngine\ScriptedEffects.hpp at line 21](../../../Src/client/LightEngine/ScriptedEffects.hpp#L21)
## SLIGHT_DAM_DIRT

Type: constant

Description: 


Replaced value:
```sqf
2116
```
File: [client\LightEngine\ScriptedEffects.hpp at line 22](../../../Src/client/LightEngine/ScriptedEffects.hpp#L22)
## SLIGHT_DAM_GLASS

Type: constant

Description: 


Replaced value:
```sqf
2117
```
File: [client\LightEngine\ScriptedEffects.hpp at line 23](../../../Src/client/LightEngine/ScriptedEffects.hpp#L23)
## SLIGHT_DAM_CLOTH

Type: constant

Description: 


Replaced value:
```sqf
2118
```
File: [client\LightEngine\ScriptedEffects.hpp at line 24](../../../Src/client/LightEngine/ScriptedEffects.hpp#L24)
## SLIGHT_DAM_PAPER

Type: constant

Description: 


Replaced value:
```sqf
2119
```
File: [client\LightEngine\ScriptedEffects.hpp at line 25](../../../Src/client/LightEngine/ScriptedEffects.hpp#L25)
## SLIGHT_DAM_FLESH

Type: constant

Description: 


Replaced value:
```sqf
2120
```
File: [client\LightEngine\ScriptedEffects.hpp at line 26](../../../Src/client/LightEngine/ScriptedEffects.hpp#L26)
## SLIGHT_DAM_ORGANIC

Type: constant

Description: 


Replaced value:
```sqf
2121
```
File: [client\LightEngine\ScriptedEffects.hpp at line 27](../../../Src/client/LightEngine/ScriptedEffects.hpp#L27)
## SLIGHT_DAM_SYNT

Type: constant

Description: 


Replaced value:
```sqf
2122
```
File: [client\LightEngine\ScriptedEffects.hpp at line 28](../../../Src/client/LightEngine/ScriptedEffects.hpp#L28)
## SLIGHT_ATMOS_FIRE_1

Type: constant

Description: 


Replaced value:
```sqf
2123
```
File: [client\LightEngine\ScriptedEffects.hpp at line 29](../../../Src/client/LightEngine/ScriptedEffects.hpp#L29)
## SLIGHT_ATMOS_FIRE_2

Type: constant

Description: 


Replaced value:
```sqf
2124
```
File: [client\LightEngine\ScriptedEffects.hpp at line 30](../../../Src/client/LightEngine/ScriptedEffects.hpp#L30)
## SLIGHT_ATMOS_FIRE_3

Type: constant

Description: 


Replaced value:
```sqf
2125
```
File: [client\LightEngine\ScriptedEffects.hpp at line 31](../../../Src/client/LightEngine/ScriptedEffects.hpp#L31)
## SLIGHT_ATMOS_SMOKE_1

Type: constant

Description: 


Replaced value:
```sqf
2126
```
File: [client\LightEngine\ScriptedEffects.hpp at line 32](../../../Src/client/LightEngine/ScriptedEffects.hpp#L32)
## SLIGHT_ATMOS_SMOKE_2

Type: constant

Description: 


Replaced value:
```sqf
2127
```
File: [client\LightEngine\ScriptedEffects.hpp at line 33](../../../Src/client/LightEngine/ScriptedEffects.hpp#L33)
## SLIGHT_ATMOS_SMOKE_3

Type: constant

Description: 


Replaced value:
```sqf
2128
```
File: [client\LightEngine\ScriptedEffects.hpp at line 34](../../../Src/client/LightEngine/ScriptedEffects.hpp#L34)
## SLIGHT_THEATRE_SCENE_MAIN

Type: constant

Description: 


Replaced value:
```sqf
2129
```
File: [client\LightEngine\ScriptedEffects.hpp at line 35](../../../Src/client/LightEngine/ScriptedEffects.hpp#L35)
## SLIGHT_THEATRE_SCENE_AREA_MAIN

Type: constant

Description: 


Replaced value:
```sqf
2130
```
File: [client\LightEngine\ScriptedEffects.hpp at line 36](../../../Src/client/LightEngine/ScriptedEffects.hpp#L36)
## SLIGHT_THEATRE_SCENE_STREETS

Type: constant

Description: 


Replaced value:
```sqf
2131
```
File: [client\LightEngine\ScriptedEffects.hpp at line 37](../../../Src/client/LightEngine/ScriptedEffects.hpp#L37)
## SLIGHT_THEATRE_ROOM_GENERIC

Type: constant

Description: 


Replaced value:
```sqf
2132
```
File: [client\LightEngine\ScriptedEffects.hpp at line 38](../../../Src/client/LightEngine/ScriptedEffects.hpp#L38)
## SLIGHT_STREET_LAMP_ITAL

Type: constant

Description: 


Replaced value:
```sqf
2133
```
File: [client\LightEngine\ScriptedEffects.hpp at line 39](../../../Src/client/LightEngine/ScriptedEffects.hpp#L39)
## SLIGHT_ITAL_LAMP_STRONG

Type: constant

Description: 


Replaced value:
```sqf
2134
```
File: [client\LightEngine\ScriptedEffects.hpp at line 40](../../../Src/client/LightEngine/ScriptedEffects.hpp#L40)
## SLIGHT_ITAL_LAMP_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
2135
```
File: [client\LightEngine\ScriptedEffects.hpp at line 41](../../../Src/client/LightEngine/ScriptedEffects.hpp#L41)
## SLIGHT_MOB_VOMIT

Type: constant

Description: 


Replaced value:
```sqf
2136
```
File: [client\LightEngine\ScriptedEffects.hpp at line 42](../../../Src/client/LightEngine/ScriptedEffects.hpp#L42)
## SLIGHT_SEARCHLIGHT_DORM

Type: constant

Description: 


Replaced value:
```sqf
2137
```
File: [client\LightEngine\ScriptedEffects.hpp at line 43](../../../Src/client/LightEngine/ScriptedEffects.hpp#L43)
## SLIGHT_LIGHT_BAKE_SAUNA

Type: constant

Description: 


Replaced value:
```sqf
2138
```
File: [client\LightEngine\ScriptedEffects.hpp at line 44](../../../Src/client/LightEngine/ScriptedEffects.hpp#L44)
## SLIGHT_MAGICSTORM_DEBUG_var

Type: Variable

> Exists if **SCRIPT_EMIT_EVAL_SERVER** defined

Description: 


Initial value:
```sqf
2100
```
File: [client\LightEngine\ScriptedEffects.hpp at line 48](../../../Src/client/LightEngine/ScriptedEffects.hpp#L48)
## SLIGHT_SET123_DEBUG_var

Type: Variable

Description: 


Initial value:
```sqf
2101
```
File: [client\LightEngine\ScriptedEffects.hpp at line 49](../../../Src/client/LightEngine/ScriptedEffects.hpp#L49)
## SLIGHT_TEMPLATE_DIRECTLIGHT_var

Type: Variable

Description: 


Initial value:
```sqf
2102
```
File: [client\LightEngine\ScriptedEffects.hpp at line 50](../../../Src/client/LightEngine/ScriptedEffects.hpp#L50)
## SLIGHT_TEMPLATE_POINTLIGHT_var

Type: Variable

Description: 


Initial value:
```sqf
2103
```
File: [client\LightEngine\ScriptedEffects.hpp at line 51](../../../Src/client/LightEngine/ScriptedEffects.hpp#L51)
## SLIGHT_STREET_LAMP_var

Type: Variable

Description: 


Initial value:
```sqf
2104
```
File: [client\LightEngine\ScriptedEffects.hpp at line 52](../../../Src/client/LightEngine/ScriptedEffects.hpp#L52)
## SLIGHT_SHIT_SMELL_var

Type: Variable

Description: 


Initial value:
```sqf
2105
```
File: [client\LightEngine\ScriptedEffects.hpp at line 53](../../../Src/client/LightEngine/ScriptedEffects.hpp#L53)
## SLIGHT_WEAK_FIRE_var

Type: Variable

Description: 


Initial value:
```sqf
2106
```
File: [client\LightEngine\ScriptedEffects.hpp at line 54](../../../Src/client/LightEngine/ScriptedEffects.hpp#L54)
## SLIGHT_SPOT_LAMP_var

Type: Variable

Description: 


Initial value:
```sqf
2107
```
File: [client\LightEngine\ScriptedEffects.hpp at line 55](../../../Src/client/LightEngine/ScriptedEffects.hpp#L55)
## SLIGHT_LAMP_HOUSE_var

Type: Variable

Description: 


Initial value:
```sqf
2108
```
File: [client\LightEngine\ScriptedEffects.hpp at line 56](../../../Src/client/LightEngine/ScriptedEffects.hpp#L56)
## SLIGHT_LIGHT_STOVE_var

Type: Variable

Description: 


Initial value:
```sqf
2109
```
File: [client\LightEngine\ScriptedEffects.hpp at line 57](../../../Src/client/LightEngine/ScriptedEffects.hpp#L57)
## SLIGHT_LIGHT_BAKE_var

Type: Variable

Description: 


Initial value:
```sqf
2110
```
File: [client\LightEngine\ScriptedEffects.hpp at line 58](../../../Src/client/LightEngine/ScriptedEffects.hpp#L58)
## SLIGHT_STREET_LAMP_DORM_var

Type: Variable

Description: 


Initial value:
```sqf
2111
```
File: [client\LightEngine\ScriptedEffects.hpp at line 59](../../../Src/client/LightEngine/ScriptedEffects.hpp#L59)
## SLIGHT_DAM_METAL_var

Type: Variable

Description: 


Initial value:
```sqf
2112
```
File: [client\LightEngine\ScriptedEffects.hpp at line 60](../../../Src/client/LightEngine/ScriptedEffects.hpp#L60)
## SLIGHT_DAM_STONE_var

Type: Variable

Description: 


Initial value:
```sqf
2113
```
File: [client\LightEngine\ScriptedEffects.hpp at line 61](../../../Src/client/LightEngine/ScriptedEffects.hpp#L61)
## SLIGHT_DAM_WOOD_var

Type: Variable

Description: 


Initial value:
```sqf
2114
```
File: [client\LightEngine\ScriptedEffects.hpp at line 62](../../../Src/client/LightEngine/ScriptedEffects.hpp#L62)
## SLIGHT_DAM_BETON_var

Type: Variable

Description: 


Initial value:
```sqf
2115
```
File: [client\LightEngine\ScriptedEffects.hpp at line 63](../../../Src/client/LightEngine/ScriptedEffects.hpp#L63)
## SLIGHT_DAM_DIRT_var

Type: Variable

Description: 


Initial value:
```sqf
2116
```
File: [client\LightEngine\ScriptedEffects.hpp at line 64](../../../Src/client/LightEngine/ScriptedEffects.hpp#L64)
## SLIGHT_DAM_GLASS_var

Type: Variable

Description: 


Initial value:
```sqf
2117
```
File: [client\LightEngine\ScriptedEffects.hpp at line 65](../../../Src/client/LightEngine/ScriptedEffects.hpp#L65)
## SLIGHT_DAM_CLOTH_var

Type: Variable

Description: 


Initial value:
```sqf
2118
```
File: [client\LightEngine\ScriptedEffects.hpp at line 66](../../../Src/client/LightEngine/ScriptedEffects.hpp#L66)
## SLIGHT_DAM_PAPER_var

Type: Variable

Description: 


Initial value:
```sqf
2119
```
File: [client\LightEngine\ScriptedEffects.hpp at line 67](../../../Src/client/LightEngine/ScriptedEffects.hpp#L67)
## SLIGHT_DAM_FLESH_var

Type: Variable

Description: 


Initial value:
```sqf
2120
```
File: [client\LightEngine\ScriptedEffects.hpp at line 68](../../../Src/client/LightEngine/ScriptedEffects.hpp#L68)
## SLIGHT_DAM_ORGANIC_var

Type: Variable

Description: 


Initial value:
```sqf
2121
```
File: [client\LightEngine\ScriptedEffects.hpp at line 69](../../../Src/client/LightEngine/ScriptedEffects.hpp#L69)
## SLIGHT_DAM_SYNT_var

Type: Variable

Description: 


Initial value:
```sqf
2122
```
File: [client\LightEngine\ScriptedEffects.hpp at line 70](../../../Src/client/LightEngine/ScriptedEffects.hpp#L70)
## SLIGHT_ATMOS_FIRE_1_var

Type: Variable

Description: 


Initial value:
```sqf
2123
```
File: [client\LightEngine\ScriptedEffects.hpp at line 71](../../../Src/client/LightEngine/ScriptedEffects.hpp#L71)
## SLIGHT_ATMOS_FIRE_2_var

Type: Variable

Description: 


Initial value:
```sqf
2124
```
File: [client\LightEngine\ScriptedEffects.hpp at line 72](../../../Src/client/LightEngine/ScriptedEffects.hpp#L72)
## SLIGHT_ATMOS_FIRE_3_var

Type: Variable

Description: 


Initial value:
```sqf
2125
```
File: [client\LightEngine\ScriptedEffects.hpp at line 73](../../../Src/client/LightEngine/ScriptedEffects.hpp#L73)
## SLIGHT_ATMOS_SMOKE_1_var

Type: Variable

Description: 


Initial value:
```sqf
2126
```
File: [client\LightEngine\ScriptedEffects.hpp at line 74](../../../Src/client/LightEngine/ScriptedEffects.hpp#L74)
## SLIGHT_ATMOS_SMOKE_2_var

Type: Variable

Description: 


Initial value:
```sqf
2127
```
File: [client\LightEngine\ScriptedEffects.hpp at line 75](../../../Src/client/LightEngine/ScriptedEffects.hpp#L75)
## SLIGHT_ATMOS_SMOKE_3_var

Type: Variable

Description: 


Initial value:
```sqf
2128
```
File: [client\LightEngine\ScriptedEffects.hpp at line 76](../../../Src/client/LightEngine/ScriptedEffects.hpp#L76)
## SLIGHT_THEATRE_SCENE_MAIN_var

Type: Variable

Description: 


Initial value:
```sqf
2129
```
File: [client\LightEngine\ScriptedEffects.hpp at line 77](../../../Src/client/LightEngine/ScriptedEffects.hpp#L77)
## SLIGHT_THEATRE_SCENE_AREA_MAIN_var

Type: Variable

Description: 


Initial value:
```sqf
2130
```
File: [client\LightEngine\ScriptedEffects.hpp at line 78](../../../Src/client/LightEngine/ScriptedEffects.hpp#L78)
## SLIGHT_THEATRE_SCENE_STREETS_var

Type: Variable

Description: 


Initial value:
```sqf
2131
```
File: [client\LightEngine\ScriptedEffects.hpp at line 79](../../../Src/client/LightEngine/ScriptedEffects.hpp#L79)
## SLIGHT_THEATRE_ROOM_GENERIC_var

Type: Variable

Description: 


Initial value:
```sqf
2132
```
File: [client\LightEngine\ScriptedEffects.hpp at line 80](../../../Src/client/LightEngine/ScriptedEffects.hpp#L80)
## SLIGHT_STREET_LAMP_ITAL_var

Type: Variable

Description: 


Initial value:
```sqf
2133
```
File: [client\LightEngine\ScriptedEffects.hpp at line 81](../../../Src/client/LightEngine/ScriptedEffects.hpp#L81)
## SLIGHT_ITAL_LAMP_STRONG_var

Type: Variable

Description: 


Initial value:
```sqf
2134
```
File: [client\LightEngine\ScriptedEffects.hpp at line 82](../../../Src/client/LightEngine/ScriptedEffects.hpp#L82)
## SLIGHT_ITAL_LAMP_MEDIUM_var

Type: Variable

Description: 


Initial value:
```sqf
2135
```
File: [client\LightEngine\ScriptedEffects.hpp at line 83](../../../Src/client/LightEngine/ScriptedEffects.hpp#L83)
## SLIGHT_MOB_VOMIT_var

Type: Variable

Description: 


Initial value:
```sqf
2136
```
File: [client\LightEngine\ScriptedEffects.hpp at line 84](../../../Src/client/LightEngine/ScriptedEffects.hpp#L84)
## SLIGHT_SEARCHLIGHT_DORM_var

Type: Variable

Description: 


Initial value:
```sqf
2137
```
File: [client\LightEngine\ScriptedEffects.hpp at line 85](../../../Src/client/LightEngine/ScriptedEffects.hpp#L85)
## SLIGHT_LIGHT_BAKE_SAUNA_var

Type: Variable

Description: 


Initial value:
```sqf
2138
```
File: [client\LightEngine\ScriptedEffects.hpp at line 86](../../../Src/client/LightEngine/ScriptedEffects.hpp#L86)
# ScriptedEffects.sqf

## le_se_map

Type: Variable

Description: place this file before all configs


Initial value:
```sqf
createHashMap
```
File: [client\LightEngine\ScriptedEffects.sqf at line 10](../../../Src/client/LightEngine/ScriptedEffects.sqf#L10)
## le_se_noattr

Type: Variable

Description: 


Initial value:
```sqf
null
```
File: [client\LightEngine\ScriptedEffects.sqf at line 11](../../../Src/client/LightEngine/ScriptedEffects.sqf#L11)
## le_se_cfgRange

Type: Variable

Description: 


Initial value:
```sqf
[2100,4900]
```
File: [client\LightEngine\ScriptedEffects.sqf at line 12](../../../Src/client/LightEngine/ScriptedEffects.sqf#L12)
## le_se_map_cfgHandlers

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //карта зарегистрированных конфигов
```
File: [client\LightEngine\ScriptedEffects.sqf at line 196](../../../Src/client/LightEngine/ScriptedEffects.sqf#L196)
## le_se_mapHandlersUnmanaged

Type: Variable

Description: 


Initial value:
```sqf
null //карта нативных эффектов
```
File: [client\LightEngine\ScriptedEffects.sqf at line 201](../../../Src/client/LightEngine/ScriptedEffects.sqf#L201)
## le_se_mapHandlersShots

Type: Variable

Description: карта нативных эффектов


Initial value:
```sqf
null
```
File: [client\LightEngine\ScriptedEffects.sqf at line 202](../../../Src/client/LightEngine/ScriptedEffects.sqf#L202)
## le_se_mapHandlers

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\LightEngine\ScriptedEffects.sqf at line 203](../../../Src/client/LightEngine/ScriptedEffects.sqf#L203)
## le_se_map_partAddress

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //key setParticleN , value [functions]
```
File: [client\LightEngine\ScriptedEffects.sqf at line 440](../../../Src/client/LightEngine/ScriptedEffects.sqf#L440)
## le_se_list_fassoc

Type: Variable

Description: see macro SCRIPT_EMIT_HANDLER_MODE_


Initial value:
```sqf
[]
```
File: [client\LightEngine\ScriptedEffects.sqf at line 543](../../../Src/client/LightEngine/ScriptedEffects.sqf#L543)
## le_se_handleConfig

Type: function

Description: Функция-обработчик скриптового освещения (для клиента)
- Param: _cfgDataList
- Param: _hMode (optional, default SCRIPT_EMIT_HANDLER_MODE_DEFAULT)
- Param: _dropPos

File: [client\LightEngine\ScriptedEffects.sqf at line 36](../../../Src/client/LightEngine/ScriptedEffects.sqf#L36)
## le_se_createUnmanagedEmitter

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 138](../../../Src/client/LightEngine/ScriptedEffects.sqf#L138)
## le_se_handleCfgEvents

Type: function

Description: 
- Param: _cfgName
- Param: _cfgInParams

File: [client\LightEngine\ScriptedEffects.sqf at line 159](../../../Src/client/LightEngine/ScriptedEffects.sqf#L159)
## le_se_internal_errorFuncCfgEvents

Type: function

Description: 
- Param: _errpar

File: [client\LightEngine\ScriptedEffects.sqf at line 173](../../../Src/client/LightEngine/ScriptedEffects.sqf#L173)
## le_se_registerConfigHandler

Type: function

Description: 
- Param: _cfgName
- Param: _cfgCode

File: [client\LightEngine\ScriptedEffects.sqf at line 177](../../../Src/client/LightEngine/ScriptedEffects.sqf#L177)
## le_se_getCurrentConfigPropVal

Type: function

Description: получает значение опции из конфига. используется в хандлерах событий скриптовых эмиттеров
- Param: _srch

File: [client\LightEngine\ScriptedEffects.sqf at line 183](../../../Src/client/LightEngine/ScriptedEffects.sqf#L183)
## le_se_getCurrentConfigId

Type: function

Description: получает айди текущего конфига. только внутри хандлееров событий скриптовых эмиттеров


File: [client\LightEngine\ScriptedEffects.sqf at line 192](../../../Src/client/LightEngine/ScriptedEffects.sqf#L192)
## le_se_errorHandler

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 239](../../../Src/client/LightEngine/ScriptedEffects.sqf#L239)
## le_se_intenral_handleVarInit

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 243](../../../Src/client/LightEngine/ScriptedEffects.sqf#L243)
## le_se_internal_createDropEmitterMap

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 257](../../../Src/client/LightEngine/ScriptedEffects.sqf#L257)
## le_se_internal_createUnmanagedEmitterMap

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 305](../../../Src/client/LightEngine/ScriptedEffects.sqf#L305)
## le_se_intenral_handleUnmanagedVarInit

Type: function

Description: 
- Param: _prop
- Param: _val

File: [client\LightEngine\ScriptedEffects.sqf at line 324](../../../Src/client/LightEngine/ScriptedEffects.sqf#L324)
## le_se_intenral_handleDropVarInit

Type: function

Description: 
- Param: _prop
- Param: _val

File: [client\LightEngine\ScriptedEffects.sqf at line 341](../../../Src/client/LightEngine/ScriptedEffects.sqf#L341)
## le_se_fireEmit

Type: function

Description: 
- Param: _cfg
- Param: _pos
- Param: _norm (optional, default ['0', '0', '1'])
- Param: _deleteAfter
- Param: _refemitters
- Param: _reservedParam

File: [client\LightEngine\ScriptedEffects.sqf at line 349](../../../Src/client/LightEngine/ScriptedEffects.sqf#L349)
## le_se_doSorting

Type: function

Description: Спасибо Богемия...


File: [client\LightEngine\ScriptedEffects.sqf at line 393](../../../Src/client/LightEngine/ScriptedEffects.sqf#L393)
## le_se_getParticleOption

Type: function

Description: key setParticleN , value [functions]
- Param: _optName
- Param: _varname
- Param: _storage

File: [client\LightEngine\ScriptedEffects.sqf at line 441](../../../Src/client/LightEngine/ScriptedEffects.sqf#L441)
## le_se_setParticleOption

Type: function

Description: 
- Param: _optName
- Param: _varname
- Param: _storage
- Param: _value

File: [client\LightEngine\ScriptedEffects.sqf at line 450](../../../Src/client/LightEngine/ScriptedEffects.sqf#L450)
## le_se_getCurrentEmitterIndex

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 459](../../../Src/client/LightEngine/ScriptedEffects.sqf#L459)
## le_se_internal_generateOptionAddress

Type: function

Description: 


File: [client\LightEngine\ScriptedEffects.sqf at line 461](../../../Src/client/LightEngine/ScriptedEffects.sqf#L461)
# VisualStatesConfigs.sqf

## VAR_FULL_PREFIX__VST_PRIVATE

Type: constant

Description: vst varmap manager


Replaced value:
```sqf
("__levst_cfg"+str __GLOB_CFG_IDX__+"_var_"+_var)
```
File: [client\LightEngine\VisualStatesConfigs.sqf at line 77](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L77)
## le_vst_create

Type: function

Description: initialize vst
- Param: _type
- Param: _src
- Param: _ctx

File: [client\LightEngine\VisualStatesConfigs.sqf at line 7](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L7)
## le_isVSTConfig

Type: function

Description: 


File: [client\LightEngine\VisualStatesConfigs.sqf at line 37](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L37)
## le_vst_remove

Type: function

Description: remove vst
- Param: _type
- Param: _src
- Param: _ctx

File: [client\LightEngine\VisualStatesConfigs.sqf at line 40](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L40)
## le_vst_createDummyObj

Type: function

Description: 
- Param: _model (optional, default "Sign_Sphere10cm_F")
- Param: _doHide (optional, default true)
- Param: _createAsVehicle (optional, default false)

File: [client\LightEngine\VisualStatesConfigs.sqf at line 63](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L63)
## le_vst_regVar

Type: function

Description: 
- Param: _obj
- Param: _var
- Param: _val

File: [client\LightEngine\VisualStatesConfigs.sqf at line 78](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L78)
## le_vst_hasVar

Type: function

Description: 
- Param: _obj
- Param: _var

File: [client\LightEngine\VisualStatesConfigs.sqf at line 82](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L82)
## le_vst_hasVarExt

Type: function

Description: 
- Param: _obj
- Param: _var
- Param: _cfg

File: [client\LightEngine\VisualStatesConfigs.sqf at line 85](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L85)
## le_vst_getVar

Type: function

Description: 
- Param: _obj
- Param: _var

File: [client\LightEngine\VisualStatesConfigs.sqf at line 90](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L90)
## le_vst_getVarExt

Type: function

Description: 
- Param: _obj
- Param: _var
- Param: _cfg

File: [client\LightEngine\VisualStatesConfigs.sqf at line 93](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L93)
## le_vst_remVar

Type: function

Description: 
- Param: _obj
- Param: _var

File: [client\LightEngine\VisualStatesConfigs.sqf at line 98](../../../Src/client/LightEngine/VisualStatesConfigs.sqf#L98)
# Natural.sqf

## __event

Type: constant

Description: Blinking light


Replaced value:
```sqf
stopUpdateIfNull(_this select 0); \
		(_this select 0) setLightColor [rand(0.7,1) , 0.65 , rand(0.4,0.5)]; \
		(_this select 0) setLightAmbient [rand(0.18,0.2),0.05,0]; \
		(_this select 0) setLightBrightness rand(0.04,0.043);
```
File: [client\LightEngine\LightConfigs\Natural.sqf at line 603](../../../Src/client/LightEngine/LightConfigs/Natural.sqf#L603)
## TORCH_SOUND_DELAY

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\LightEngine\LightConfigs\Natural.sqf at line 111](../../../Src/client/LightEngine/LightConfigs/Natural.sqf#L111)
## CAMPFIRE_SOUND_DELAY

Type: constant

Description: 


Replaced value:
```sqf
50
```
File: [client\LightEngine\LightConfigs\Natural.sqf at line 550](../../../Src/client/LightEngine/LightConfigs/Natural.sqf#L550)
## light_min_brightness

Type: constant

Description: [false,0,10,4.34,[0.013,0.001,0],0,[0,0,0],[0,50,3,700,4,1]]


Replaced value:
```sqf
2.5
```
File: [client\LightEngine\LightConfigs\Natural.sqf at line 256](../../../Src/client/LightEngine/LightConfigs/Natural.sqf#L256)
## light_max_brightness

Type: constant

Description: 


Replaced value:
```sqf
4.34
```
File: [client\LightEngine\LightConfigs\Natural.sqf at line 257](../../../Src/client/LightEngine/LightConfigs/Natural.sqf#L257)
# Bullets.sqf

## SHOT_BULLET_PISTOL_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
0.25
```
File: [client\LightEngine\ShotableConfigs\Bullets.sqf at line 50](../../../Src/client/LightEngine/ShotableConfigs/Bullets.sqf#L50)
## SHOT_BULLET_SHOTGUN_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
0.25
```
File: [client\LightEngine\ShotableConfigs\Bullets.sqf at line 91](../../../Src/client/LightEngine/ShotableConfigs/Bullets.sqf#L91)
## SHOT_BULLET_RIFLE_TIMEOUT

Type: constant

Description: 


Replaced value:
```sqf
0.25
```
File: [client\LightEngine\ShotableConfigs\Bullets.sqf at line 110](../../../Src/client/LightEngine/ShotableConfigs/Bullets.sqf#L110)
## le_internal_shot_bullet_loadLight

Type: function

Description: 
- Param: _intensity
- Param: _timeout

File: [client\LightEngine\ShotableConfigs\Bullets.sqf at line 7](../../../Src/client/LightEngine/ShotableConfigs/Bullets.sqf#L7)
## le_internal_shot_bullet_getFactPos

Type: function

Description: 
- Param: _addY (optional, default 0)

File: [client\LightEngine\ShotableConfigs\Bullets.sqf at line 32](../../../Src/client/LightEngine/ShotableConfigs/Bullets.sqf#L32)
# Stealth.sqf

## vst_human_stealth_allowStepsounds

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\LightEngine\VisualStates\Stealth.sqf at line 7](../../../Src/client/LightEngine/VisualStates/Stealth.sqf#L7)
