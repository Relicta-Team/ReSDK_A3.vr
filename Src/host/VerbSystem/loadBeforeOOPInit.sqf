// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

ie_actions_list_preInitActions = [];

//предварительная регистрация действий
// ["wrld","sniff","onActWorld"] call ie_actions_regNew;
ie_actions_regNew = {
	params ["_catprefix","_name","_met"];
	private _ps = format[_catprefix +"_"+ _name];
	ie_actions_list_preInitActions pushBackUnique [_ps,_met];
};

verbs_parse_strToListOfNum = {
	private _strData = _this;
	private _listStr = _strData splitString " |,";

	private _val = null;
	private _outputArray = [];


	{
		_val = verb_list get _x;
		if isNullVar(_val) exitWith {
			errorformat("Error on parsing expression %1: %2.getVerbs() not compiled",_strData arg _class);
			_outputArray
		};

		_outputArray pushBack (_val select 1);
	} foreach _listStr;

	str _outputArray
};
