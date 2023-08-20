// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(widget_winapi_openTextBox)
{
	params ["_refOut",["_header","Ввод текста"],["_desc","Введите текст"],["_baseText",""],["_canMultiLine",true]];
	if isNullVar(_refOut) exitWith {false};

	private _result = ["OOPBuilder","textbox",[_header,_desc,_canMultiLine,_baseText],true] call rescript_callCommand;
	if (_result != "$CLOSED$") exitWith {
		refset(_refOut,_result);
		true
	};
	false
}

function(widget_winapi_openColor)
{
	params ["_refOut"];
	if isNullVar(_refOut) exitWith {false};
	private _result = ["OOPBuilder","colorbox",[],true] call rescript_callCommand;
	if (_result != "$CLOSED$") exitWith {
		refset(_refOut,parseSimpleArray _result);
		true;
	};
	false
}