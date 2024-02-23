// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(widget_winapi_openTextBox)
{
	params ["_refOut",["_header","Ввод текста"],["_desc","Введите текст"],["_baseText",""],["_canMultiLine",true]];
	if isNullVar(_refOut) exitWith {false};
	//private _cachedMousePos = getMousePosition; //replaced inside c#-side
	private _result = ["OOPBuilder","textbox",[_header,_desc,_canMultiLine,_baseText],true] call rescript_callCommand;
	//setMousePosition _cachedMousePos;
	if (_result != "$CLOSED$") exitWith {
		refset(_refOut,_result);
		true
	};
	false
}

function(widget_winapi_openColor)
{
	params ["_refOut",["_defColor",[0,0,0]],["_precision",6]];
	if isNullVar(_refOut) exitWith {false};
	private _result = ["OOPBuilder","colorbox",[
		clamp(_defColor select 0,0,1),
		clamp(_defColor select 1,0,1),
		clamp(_defColor select 2,0,1)
	],true] call rescript_callCommand;
	if (_result != "$CLOSED$") exitWith {
		refset(_refOut,(parseSimpleArray _result) apply {parseNumber (_x toFixed _precision)});
		true;
	};
	false
}