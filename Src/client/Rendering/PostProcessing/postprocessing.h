// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



#define PP_MACRO_PREF "pp_effect_"

#define setGV(var,val) missionNamespace setVariable [var,val]
#define getGV(var) (missionNamespace getVariable (var))

#define setPPVar(var,val) setGV(PP_MACRO_PREF + var,val)
#define getPPVar(var) getGV(PP_MACRO_PREF + var)


#define setEffect ppEffectAdjust
#define commitEffect ppEffectCommit

#define setThisEffect getPPVar(__EFFECT_NAME) setEffect
#define setThisEffectCommit getPPVar(__EFFECT_NAME) commitEffect
#define setThisEffectEnable getPPVar(__EFFECT_NAME) ppEffectEnable 

//для отложенных вызовов
#define unpackParams() params ["__EFFECT_NAME","__args"]
#define packParams() vec2(__EFFECT_NAME,__args)