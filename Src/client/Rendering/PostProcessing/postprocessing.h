// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(Rendering.PostProcess,pp_)

macro_const(pp_effect_macro_prefix)
#define PP_MACRO_PREF "pp_effect_"

inline_macro
#define setGV(var,val) missionNamespace setVariable [var,val]
inline_macro
#define getGV(var) (missionNamespace getVariable (var))

macro_func(pp_setPPVar,void(string;any))
#define setPPVar(var,val) setGV(PP_MACRO_PREF + var,val)
macro_func(pp_getPPVar,any(string))
#define getPPVar(var) getGV(PP_MACRO_PREF + var)

inline_macro
#define setEffect ppEffectAdjust
inline_macro
#define commitEffect ppEffectCommit

inline_macro
#define setThisEffect getPPVar(__EFFECT_NAME) setEffect
inline_macro
#define setThisEffectCommit getPPVar(__EFFECT_NAME) commitEffect
inline_macro
#define setThisEffectEnable getPPVar(__EFFECT_NAME) ppEffectEnable 

//для отложенных вызовов
//__EFFECT_NAME - out ref
inline_macro
#define unpackParams() params ["__EFFECT_NAME","__args"]
inline_macro
#define packParams() vec2(__EFFECT_NAME,__args)