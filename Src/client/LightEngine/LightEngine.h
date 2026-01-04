// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(LightEngine,le_)

//#define usedebuglightrender

inline_macro
#define lightObject _light

inline_macro
#define sourceObject _source

inline_macro
#define allEmitters _allEmitters

macro_const(le_light_max_index)
#define le_light_max_index 1999

inline_macro
#define emitterObject _effEmitter

//source object who inited vst
//! can be used in light engine code. check and remove
inline_macro
#define src _src
//external reference, defined in smd
//local player == this
inline_macro
#define localPlayer __LOCAL_PLAYER__

//частота обновления основного треда
//!not used
inline_macro
#define update_delay_mainThread 0.01

//начальное число индексатора для firelight событий (исключая его)
inline_macro
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

/*
================================================================================
	GROUP: Scripted emitter
================================================================================
*/

//used in le_se_list_fassoc
//стандартный обработчик скриптовых эффектов
enum(ScriptEmitHandlerType,SCRIPT_EMIT_HANDLER_MODE_)
#define SCRIPT_EMIT_HANDLER_MODE_DEFAULT 0
//скриптовый обработчик дроппер. основная особенность - не создает направленные источники, удаляется самостоятельно
#define SCRIPT_EMIT_HANDLER_MODE_DROP 1
//скриптовый обработчик неуправляемый. основная особенность - не привязан к объекту, создается в позиции. пользователь самостоятельно должен удалять его
#define SCRIPT_EMIT_HANDLER_MODE_UNMANAGED 2
enumend

// макросы ниже сохранены для обратной совместимости

//scripted emitters
inline_macro
#define regScriptEmit(type) _semDat = []; le_se_map set ['type',_semDat]; le_conf_##type = { \
	params ['sourceObject']; \
	sourceObject setvariable ["__config",type]; \
	private allEmitters = []; \
	sourceObject setVariable ["__allEmitters",allEmitters]; \
	[(le_se_map get 'type')] call le_se_handleConfig; \
};	_semDat append [

inline_macro
#define endScriptEmit ] ;

//уникальный алиас
inline_macro
#define _emitAlias(strval) ["alias",strval],
