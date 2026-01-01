// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\oop.hpp>
#include <..\engine.hpp>

#define thisAction _thisAct
#define src _src

#define SA_ADD(enum) __index_act = enum; __code_act = { params ['this','src']; private thisAction = enum;

#define SA_END(effectOnPress) effectOnPress }; missionNamespace setVariable [format["specact_%1",__index_act],__code_act];


//указываем что это действие должно сняться как активное после использования 
#define SA_EF_CANCEL_AFTER_USE callSelfParams(sendInfo,"callbackCancel_specAct" arg thisAction);
//без эффектов
#define SA_EF_NO 
	