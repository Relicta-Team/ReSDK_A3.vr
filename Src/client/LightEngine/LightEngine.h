// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//#define usedebuglightrender

#define lightObject _light

#define sourceObject _source

#define allEmitters _allEmitters

#define le_light_max_index 1999

#define emitterObject _effEmitter

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

//частота обновления основного треда
//!not used
#define update_delay_mainThread 0.01

//начальное число индексатора для firelight событий (исключая его)
#define le_firelight_startindex 5000

//helpers
#include <..\Inventory\inventory.hpp>

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

// макросы ниже сохранены для обратной совместимости

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
