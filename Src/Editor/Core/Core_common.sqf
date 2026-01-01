// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

hashMapNull = createHashMapFromArray [["__NULL_HASH_MAP__","__NULL_HASH_MAP__"]];

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

regex_getMatches = {
	params ["_txt","_pattern",["_optMath",0]];
	private _out = _txt regexfind [_pattern,0];
	private _rList = [];
	{
		_rList pushBack (_x select _optMath select 0);
		false
	} count _out;
	_rList
};

regex_replace = {
	params ["_txt","_pattern","_replacer"];
	_txt regexReplace [_pattern,_replacer];
};

//copy from preipit build
stringStartWith = {
	params ["_checked","_started",["_casesense",true]];
	private _comparer = _checked select [0,count _started];
	ifcheck(_casesense,equals(_comparer,_started),_comparer == _started)
};


searchInList = {
	params ["_list","_lambda","_defaultReturn"];
	private _idx = _list findif _lambda;
	if (_idx == -1) exitWith {_defaultReturn};
	_list select _idx
};

arrayDeleteItem = {
	params["_a","_it"];
	private _ix = _a findif {_it isequalto _x}; 
	if (_ix != -1) then {_a deleteAt _ix}; 
	_ix != -1
};

arrayIsValidIndex = {
	params ["_a","_ix"];
	count _a > 0 && {_ix < count _a} && {_ix >= 0}
};

//shuffle array elements, return alter array
arrayShuffleOrig = {
	params ["_array"];
	private _tempArray = + _array;

    for "_size" from (count _tempArray) to 1 step -1 do {
        _array set [_size - 1, (_tempArray deleteAt (floor random _size))];
    };

    _array
};

//swap 2 elements in array
arraySwap = {
	params ["_a","_is","_id"];
	private _t = _a select _is;
	_a set [_is,_a select _id];
	_a set [_id,_t];
};

stringEndWith = {
	params ["_checked","_ended",["_casesense",true]];
	private _cnt = count _ended;
	private _comparer = _checked select [(count _checked) - _cnt,_cnt];
	ifcheck(_casesense,equals(_comparer,_ended),_comparer == _ended)
};

stringReplace = {
	params [["_string", ""], ["_find", ""], ["_replace", ""]];
	if (_find == "") exitWith {_string}; // "1" find "" -> 0

	private _result = "";
	forceUnicode 0;
	private _offset = count (_find splitString "");

	while {_string find _find != -1} do {
		private _index = _string find _find;

		_result = _result + (_string select [0, _index]) + _replace;
		_string = _string select [_index + _offset];
	};

	_result + _string
};