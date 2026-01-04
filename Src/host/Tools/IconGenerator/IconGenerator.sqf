// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>

/*
	Инструкция:
	папка профиля не должна содержать utf-16
	При создании скриншотов увеличьте графику и отключите тени

	Лучшим вариантом будет сначала вырезать фон а потом ресайзить. Лучше качество

	Убираем серый фон
	https://www.remove.bg/ru

	Меняем размер под 128х128
	https://www.iloveimg.com/ru/resize-image

	Для глобальной конвертации в paa используем paa конвертер в A3Tools
*/

#include "IconMaker.sqf"


iconGen_output = "";
iconGen_outputInfo = ""; //non-code information

iconGen_internal_typeTable = createHashMap;
iconGen_internal_isError = false;

#define main_ExitIfError() \
if (iconGen_internal_isError) exitWith { \
	error("Process icon generator aborted"); \
}

iconGenerator_start = {

	iconGen_internal_isError = false;
	iconGen_output = "";
	iconGen_outputInfo = "";


	//making typetable
	[] call iconGen_internal_generateTypeTable;
	main_ExitIfError();

	private _typeNames = [];
	{
		private _obj = instantiate(_x);
		private _model = getVar(_obj,model);
		delete(_obj);

		if ("\" in _model) then {
			if (_model select [0,1] != "\") then {
				_model = "\" + _model;
			};
		};

		private _typename = [_model] call iconGen_internal_findTypeByModel_alg2;
		if (".p3d" in _typename || "\" in _typename) then {
			errorformat("WRONG CONFIG %1 in class %2. Model was %3",_typename arg _x arg _model);
			iconGen_internal_isError = true;
		};
		if (iconGen_internal_isError) exitWith {

		};

		_typeNames pushBackUnique (str tolower _typename);
		iconGen_outputInfo = (iconGen_outputInfo + _typename);
		iconGen_outputInfo = iconGen_outputInfo + " as " + str _x + endl;

	} forEach (["Item",true] call oop_getinhlist);

	main_ExitIfError();

	_buffer = _typeNames call iconGen_internal_makeIconCtors;

	log("iconGenerator() - All item icons saved in variable iconGen_output; Information in iconGen_outputInfo");

	iconGen_output = _buffer;

};

iconGen_internal_findTypeByModel_alg2 = {
	params ["_model"];
	FHEADER;
	if !("\" in _model) exitWith {_model};
	private _ret = _model;
	{
		_p3d = tolower getText(_x>>"model");
		if (_p3d != "") then {
			private _check = toLower _model;
			if (_p3d == _check || (_p3d +".p3d" == _check) || ("\"+_p3d)==_check || ("\"+_p3d+".p3d")=="_check") exitWith {
				RETURN(configName _x);
			};
		};
	} foreach ("true" configClasses (configFile >> "CfgVehicles"));
	_ret
};

iconGen_internal_findTypeByModel = {
	params ["_model"];

	if !(".p3d" in _model) exitWith {_model};

	if !(_model in iconGen_internal_typeTable) exitWith {
		if !(_model call iconGen_internal_isValidConfig) exitWith {
			errorformat("CANNOT FIND TYPE BY MODEL %1",_model);
			iconGen_internal_isError = true;
			_model
		};

		_model
	};

};

iconGen_internal_makeIconCtors = {
	private _classes = _this;
	_header = '[nil, "all", [], [], [], [';
	_footer = ']] spawn BIS_fnc_exportEditorPreviews;';
	_header + (_classes joinString ("," + endl)) + _footer
};

iconGen_internal_isValidConfig = {
	(getText(configFile >> "CfgVehicles" >> _this >> "model"))!=""
};

iconGen_internal_generateTypeTable = {
	{
		_p3d = tolower getText(_x>>"model");
		if (_p3d != "") then {
			if !(".p3d" in _p3d) then {_p3d = _p3d + ".p3d"};
			if (_p3d select [0,1] != "\") then {_p3d = "\"+_p3d};

			_lowerName = tolower configName _x;
			if (_p3d in iconGen_internal_typeTable) exitWith {
				//is non a error
				//errorformat("MODEL PATH ALREADY REGISTERED %1",_p3d);
				//iconGen_internal_isError = true;
			};
			iconGen_internal_typeTable set [_p3d,_lowerName];
		};
	} foreach ("true" configClasses (configFile >> "CfgVehicles"));
};
