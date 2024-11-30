// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//#define usedebuglightrender

#define lightObject _light

#define sourceObject _source

#define allEmitters _allEmitters

#define le_light_max_index 1999

#define regLight(type) le_conf_##type = { params ['sourceObject']; private lightObject = "#lightpoint" createVehicleLocal [0,0,0]; \
sourceObject setvariable ["__config",type]; sourceObject setVariable ["__light",lightObject]; private allEmitters = [lightObject]; sourceObject setVariable ["__allEmitters",allEmitters]; \
1 call le_debug_lightRender;

#define endRegLight lightObject };

#define regCustomLight(type,classnamestr) le_conf_##type = {params ['sourceObject']; private lightObject = (classnamestr) createVehicleLocal [0,0,0]; \
sourceObject setvariable ["__config",type]; sourceObject setVariable ["__light",lightObject]; private allEmitters = [lightObject]; sourceObject setVariable ["__allEmitters",allEmitters]; \
2 call le_debug_lightRender;

#define emitterObject _effEmitter

#define regEffect(type) le_conf_##type = { params ['sourceObject']; private emitterObject = "#particlesource" createVehicleLocal [0,0,0]; \
sourceObject setvariable ["__config",type]; sourceObject setVariable ["__light",emitterObject]; private allEmitters = [emitterObject]; sourceObject setVariable ["__allEmitters",allEmitters]; \

#define endRegEffect };

//firelight event type def
#define regFireLight(type) _rfl_t = type; _rfl_ev = {params ['sourceObject'];

#define endRegFireLight }; missionNamespace setVariable ["le_conf_fire_" + str(_rfl_t - le_firelight_startindex),_rfl_ev];

#define initLightObject() private lightObject = "#lightpoint" createVehicleLocal [0,0,0]

//visual states functionality
#define regVST(type) le_conf_##type = { params ["_condit","_src",["_ctxParams",0]]; private __GLOB_CFG_IDX__ = type ;
#define vstParams _ctxParams
//source object who inited vst
#define src _src
//external reference, defined in smd
//local player == this
#define localPlayer __LOCAL_PLAYER__
#define VST_COND_CREATE 1
#define VST_COND_DESTR 0
#define vstIsState(state) (state == _condit)
#define VSTCreate if (_condit == VST_COND_CREATE) exitWith
#define VSTDestroy if (_condit == VST_COND_DESTR) exitWith

#define endRegVST };

#define vector(x,y,z) [x,y,z]

#define initBrightness(val) lightObject setLightBrightness (val); sourceObject setvariable ["__defBright",val];

#define initAsRenderer() sourceObject call le_initRenderer;

#define linkLight(light,object,anotherParams) light attachto [object,anotherParams]

//Сразу делает свет динамическим и рабочим (проблема при отсутствии первого атача к игроку)
#define linkLightDynamic(src,object,anotParams) linkLight(src,player,vector(0,0,0)); linkLight(src,object,anotParams)


#define joinEmitter(link) allEmitters pushBackUnique link

//частота обновления основного треда
#define update_delay_mainThread 0.01
//частота проверики на необходимость удаления
#define checktime_ondestroysource 0
//начальное число индексатора для firelight событий (исключая его)
#define le_firelight_startindex 5000

#define addEventOnDestroySource(listobjects) private __onframecode = { sourceObject = (_this select 0) select 0; lightObject = (_this select 0) select 1 select 0;if (isNULL sourceObject || isNULL lightObject) then { \
{deleteVehicle _x} foreach ((_this select 0) select 1); [sourceObject] call le_unloadLight; stopThisUpdate(); \
}}; startUpdateParams(__onframecode,checktime_ondestroysource,[sourceObject arg [listobjects]])

#define __lcfg__null_params__
#define addEventOnDestroySourceNoParams() addEventOnDestroySource(__lcfg__null_params__)

//spec events helper
#define stopUpdateIfNull(data) if (isNULL (data)) exitWith {stopThisUpdate()}

//helpers
#include <..\Inventory\inventory.hpp>
#define isAttachedToMob() (!isNullVar(_smd_slotId))
#define attachedMobSlot _smd_slotId

/*
================================================================================
	GROUP: Light engine internal macro
================================================================================
*/
/*
//////                 ===== OBSOLETE =====
#define glsNull ["nan"]

#define getGLSData(_type,_x,_y) le_glsData getvariable [format["%1:%2:%3",_type,_x,_y],glsNull]
#define setLocalGLSData(_type,_x,_y,lastHash) le_localGlsData setvariable [format["%1:%2:%3",_type,_x,_y],lastHash]
#define getLocalGLSData(_type,_x,_y) le_localGlsData getvariable [format["%1:%2:%3",_type,_x,_y],glsNull]

#define getOnlyObjects(_data) ((_data) select [1,count (_data) - 1])
*/

//начальное число индексатора для shot событий (исключая его)
#define le_shot_startindex 10000

#define shotParams _shotParams

#define regShot(type) _rshot_t = type; _rfl_ev = {params ['sourceObject','shotParams']; private __disposable = [];
#define makeParticle(namevar) namevar = "#particlesource" createVehicleLocal [0,0,0]; __disposable pushBack namevar
#define makeLight(namevar) namevar = "#lightpoint" createVehicleLocal [0,0,0]; __disposable pushBack namevar

#define disposeAllAfterTime(time) invokeAfterDelayParams({{deleteVehicle _x}count _this},time,__disposable)

#define linkObject(light,object,anotherParams) light attachto [object,anotherParams]

#define endRegShot }; missionNamespace setVariable ["le_conf_shot_" + str(_rshot_t - le_shot_startindex),_rfl_ev];

/*
================================================================================
	GROUP: Scripted emitter
================================================================================
*/

//used in le_se_list_fassoc
//стандартный обработчик скриптовых эффектов
#define SCRIPT_EMIT_HANDLER_MODE_DEFAULT 0
//скриптовый обработчик дроппер. основная особенность - не создает направленные источники, удаляется самостоятельно
#define SCRIPT_EMIT_HANDLER_MODE_DROP 1
//скриптовый обработчик неуправляемый. основная особенность - не привязан к объекту, создается в позиции. пользователь самостоятельно должен удалять его
#define SCRIPT_EMIT_HANDLER_MODE_UNMANAGED 2

//scripted emitters
#define regScriptEmit(type) _semDat = []; le_se_map set ['type',_semDat]; le_conf_##type = { \
	params ['sourceObject']; \
	sourceObject setvariable ["__config",type]; \
	private allEmitters = []; \
	sourceObject setVariable ["__allEmitters",allEmitters]; \
	[(le_se_map get 'type')] call le_se_handleConfig; \
};	_semDat append [

#define endScriptEmit ] ;

//уникальный алиас
#define _emitAlias(strval) ["alias",strval],
