// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\struct.hpp>
#include <..\..\text.hpp>

csys_map_storages = [];

csys_cat_names = [ 
	"Одежда",
	"Кулинария",
	"Алхимия",
	"Медицина",
	"Оружие",
	"Мебель",
	"Свет",
	"Постройки",
	"Прочее"
];

csys_init = {
	//collecting all files and load into buffer
	private _files = ["src\host\CraftSystem\Crafts\",".yml",true] call fso_getFiles;
	private _content = [];//this is full array of preloaded crafts
	private _loaded = null;
	private _errored = false;
	private _erroredString = "";
	{
		_loaded = [_x,_rdat] call yaml_loadFile;
		if isNullVar(_loaded) then {
			_errored = true;
			_erroredString = format["Craft error: %1",call yaml_getLastError];
		} else {
			_content append _loaded;
		};
	} foreach _files;

	if (_errored) exitWith {
		assert_str(false,_erroredString);
		setLastError(_erroredString);
	};

	{
		[_x] call csys_loadConfig;
	} foreach _content;
};

csys_loadConfig = {
	params ["_cfgDict"];
	
};


/*
	специальное форматирование строк
	["{message.lower} {postfix}", 
		createHashMapFromArray [
			["message","Hello!"],
			["postfix","world!"]
		]
	] call csys_format; // "hello! world!"
*/
csys_format = {
	params ["_str","_argsmap"];
	private _patternKeys = "\ *\w+([ \t]*\.[ \t]*\w+)*\ *";
	private _patternFormatter = "\{("+_patternKeys+")\}";
	private _match = null;
	private _kmap = null;
	private _tokens = null;
	private _argName = null;

	while {[_str,_patternFormatter] call regex_isMatch} do {
		_match = [_str,_patternFormatter] call regex_getFirstMatch;
		_kmap = [_match,_patternKeys] call regex_getFirstMatch;
		_tokens = _kmap splitString " .";
		_argName = _tokens deleteAt 0;
		if (_argName in _argsmap) then {
			private _val = _argsmap get _argName;
			assert(!isNullVar(_val));
			{
				_val = _val call (csys_map_tokenMap getOrDefault [_x,csys_defaultTokenCode]);
			} foreach _tokens;
			_str = [_str,_match,_val] call regex_replace;
		};
	};

	_str
};

csys_map_tokenMap = createHashMapFromArray [
	["lower",{lowerize(_this)}],
	["upper",{capitalize(_this)}],
];

csys_defaultTokenCode = { _this };