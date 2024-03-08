// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



function(systools_checkClassPathes)
{
	if (!goasm_isbuilded) exitWith {
		["Game object assembly not builded..."] call printLog;
	};
	
	_errored = [];
	{
		(missionNameSpace getVariable ("pt_"+_x) getVariable "__decl_info__")params ["_f","_l"];
		["%1 - %2 at line %3",_x,_f,_l] call printlog;
		
		if !("\" in _f) then {
			_errored pushBack [_x,_f,_l];
		};
	} foreach (["object",true] call oop_getinhlist);
	
	for "_i" from 1 to 5 do {
		[""] call printLog;
	};
	
	if (count _errored > 0) then {
		{
			["%1			%2 at %3",_x select 0,_x select 1,_x select 2] call printError;
		} foreach _errored;
		["---------------------------------------------------------"] call printError;
		["FINDED %1 ERRORED PATHES",count _errored] call printError;
	} else {
		["Operation done - all pathes is ok!"] call printLog;
	};
}