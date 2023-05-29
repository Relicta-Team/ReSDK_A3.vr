// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



core_vec3_toString = {
	private _vProb = _this;
	if equalTypes(_vProb,[]) then {
		private _stack = ["{%1,%2,%3}"];
		_stack append (_vProb);
		format _stack;
	} else {
		"vec3:ERROR PARAMS->" + str (_this select 0)
	};
};


//model helpers


function(model_convertPithBankYawToVec)
{ 
	private [/*"_object","_rotations",*/"_aroundX","_aroundY","_aroundZ","_dirX","_dirY","_dirZ","_upX","_upY","_upZ","_dir","_up","_dirXTemp",
	"_upXTemp"];
/*	_object = _this select 0;
	_rotations = _this select 1;*/
	_aroundX = _this select 0;
	_aroundY = _this select 1;
	_aroundZ = (360 - (_this select 2)) - 360;
	_dirX = 0;
	_dirY = 1;
	_dirZ = 0;
	_upX = 0;
	_upY = 0;
	_upZ = 1;
	if (_aroundX != 0) then { 
		_dirY = cos _aroundX;
		_dirZ = sin _aroundX;
		_upY = -sin _aroundX;
		_upZ = cos _aroundX;
	};
	if (_aroundY != 0) then { 
		_dirX = _dirZ * sin _aroundY;
		_dirZ = _dirZ * cos _aroundY;
		_upX = _upZ * sin _aroundY;
		_upZ = _upZ * cos _aroundY;
	};
	if (_aroundZ != 0) then { 
		_dirXTemp = _dirX;
		_dirX = (_dirXTemp* cos _aroundZ) - (_dirY * sin _aroundZ);
		_dirY = (_dirY * cos _aroundZ) + (_dirXTemp * sin _aroundZ);
		_upXTemp = _upX;
		_upX = (_upXTemp * cos _aroundZ) - (_upY * sin _aroundZ);
		_upY = (_upY * cos _aroundZ) + (_upXTemp * sin _aroundZ);
	};
	/*_dir = [_dirX,_dirY,_dirZ];
	_up = [_upX,_upY,_upZ];*/
	[[_dirX,_dirY,_dirZ],[_upX,_upY,_upZ]];
};

function(core_SetPitchBankYaw) {
	params ["_object","_data"];
	(_data call model_convertPithBankYawToVec) params ["_dir","_up"];
	_object setVectorDirAndUp [_dir,_up];
};

function(core_getPitchBankYaw) {
	params ["_vehicle"];
	(_vehicle call BIS_fnc_getPitchBank) + [getDir _vehicle]
};

//видно ли конфиг в редакторе
//https://community.bistudio.com/wiki/CfgVehicles_Config_Reference#access
function(config_isEditorVisible)
{
	(getNumber (configFile >> "CfgVehicles" >> _this >> "scope")) > 0
};


regex_isMatch = {
	params ["_txt","_pattern"];
	private _out = _txt regexfind [_pattern,0];
	count _out > 0
};

regex_getFirstMatch = {
	params ["_txt","_pattern",["_optMath",0]];
	private _out = _txt regexfind [_pattern,0];
	if (count _out > 0) exitWith {_out select 0 select _optMath select 0};
	""
};

regex_replace = {
	params ["_txt","_pattern","_replacer"];
	_txt regexReplace [_pattern,_replacer];
};
