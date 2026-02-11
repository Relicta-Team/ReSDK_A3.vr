// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

ie_actions_map = createHashMap;
ie_actions_mapinverted = createHashMap;

//Тут регистрируются действия, декларированные во время инициализации ООП классов
{ _x params ["_ps","_met"]; ie_actions_map set [_ps,_met]; ie_actions_mapinverted set [_met,_ps]; } forEach ie_actions_list_preInitActions;

/*
	Система действий. Вызывает метод забинженный по ключевому слову
	Добавляются новые ключевые слова с методами с помощью ie::actions::regNew() или макросов ниже
*/
//Установить префикс: "emt" call ie_aciton_setPrefix
ie_action_setPrefix = {
	__thisActionPref__ = _this + "_";
};

ie_action_check = {
	params ["_n"];
	__thisAction__ == (__thisActionPref__+_n)
};

ie_action_getCalledActionName = { __thisAction__ };

ie_action_call = {
	params ["_mob","_act"];
	
	//external reference
	private __thisAction__ = _act;
	private __thisActionPref__ = "";
	
	private _mName = ie_actions_map get _act;
	if isNullVar(_mName) exitWith {
		
		(_act splitString "_")params["_pr","_ps"];
		_mName = format["on%1%2",_pr,_ps];
		private ___func = getFuncReflect(_mob,_mName);
		if isNullVar(___func) exitWith {
			errorformat("ie::actions::call() - cant call non-existen action <%1>",_act);
		};
		
		callFuncReflect(_mob,_mName);
	};
	
	callFuncReflect(_mob,_mName);
};
#define setcat(catpref) __catprefix = #catpref;
#define reg(name,method) _ps = format[__catprefix +"_"+ 'name']; _met = #method ; \
ie_actions_map set [_ps,_met]; ie_actions_mapinverted set [_met,_ps];

//==============================================================================
//				LIST OF ACTIONS
//==============================================================================
/*setcat(emt);
reg(cry,onActEmote);
reg(shlep,onActEmote);*/
/*setcat(wrld);
reg(sniff,onActWorld)
reg(die,onActWorld);
reg(teach,onActWorld);*/