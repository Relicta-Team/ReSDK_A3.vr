// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	For successful build required:
		RELEASE|DEBUG
		BUILD_CLIENT
		CLIENT_BIN_PATH

*/

#include "..\..\engine.hpp"

#define BT_ERRCODE(code) (-2100 - (code))

bt_buildClient = {
	private _time = tickTime;
	
	allClientContents = [];
	allClientModulePathes = [];
	client_isLocked = false;

	log("Start building client");
	
	// --- build type code 0-10
	log("Checking build type...");
	private _mode = "";
	private _hasRelease = false;
	private _hasDebug = false;

	#ifdef RELEASE
		_mode = "release";
		_hasRelease = true;
	#endif
	#ifdef DEBUG
		_mode = "debug";
		_hasDebug = true;
	#endif

	if (_mode == "") exitWith {
		error("Undefined build type");
		BT_ERRCODE(1);
	};
	if (_hasRelease == _hasDebug) exitWith {
		error("Build type error");
		BT_ERRCODE(2);
	};
	#ifdef EDITOR
		if(true)exitWith{
			error("	Editor macro not disabled");
			BT_ERRCODE(3);
		};
	#endif

	#ifdef USE_LOCAL_PATHES
		if (true) exitwith {
			error("		Macro USE_LOCAL_PATHES enabled. Disable this and try again");
			BT_ERRCODE(4);
		};
	#endif

	logformat("	Build type - %1",_mode);

	// --- private header code 10-20
	log("Checking private header");
	private _pcontent = LOADFILE "src\private.h";
	if (count _pcontent > 0) then {
		call compile preprocessFile "src\private.h";
		if isNull(CRYPT_ENABLED) then {
			log("	Crypt not enabled (but header found)");
			CRYPT_KEY = "public_build";
		} else {
			log("	Crypt enabled - header found");
		};
	} else {
		log("	Crypt not enabled (file not found)");
		CRYPT_KEY = "public_build";
	};
	if isNull(CRYPT_KEY) exitWith {
		error("Crypt key not found");
		BT_ERRCODE(10);
	};

	if (CRYPT_KEY == "public_build") then {
		log("	This is public build. Crypt disabled");
	};
	if !isNull(CRYPT_SAVE_AS_BINARY) then {
		if (CRYPT_SAVE_AS_BINARY) then {
			log("	CRYPT_SAVE_AS_BINARY flag ENABLED");
		} else {
			log("	CRYPT_SAVE_AS_BINARY flag DISABLED");
		};
	} else {
		log("	CRYPT_SAVE_AS_BINARY flag DISABLED (not defined)");
	};

	// --- host code 100-500
	log("Compiling...");
	private _finalizedStageCatch = false;
	private _clientCompileErrorCode = -1;
	private _preCalledCode = compile __pragma_preprocess "src\host\Tools\BuildTools\BuildTools_clientLoader.sqf";
	
	private _disableCalling = true;
	isnil _preCalledCode;

	if (!_finalizedStageCatch) exitWith {
		error("Compiling error");
		if (_clientCompileErrorCode != -1) then {
			BT_ERRCODE(_clientCompileErrorCode);
		} else {
			BT_ERRCODE(100);
		};
	};

	logformat("	Compiling done; Modules: %1",count allClientContents);

	if ((count allClientModulePathes) != (count allClientContents)) exitWith {
		error("Modules count error");
		BT_ERRCODE(101);	
	};

	// build codebase metadata
	private _keyFormatter = "CODEKEY_LINE_PRAGMA_NUMBER_%1;";
	{
		private _codebase = (format[_keyFormatter,_foreachIndex]) + (toString _x);
		allClientContents set [_foreachIndex,compile _codebase];
	} foreach allClientContents;	

	// --- saving 600-700
	log("Saving build");
	private _allContent = str allClientContents;
	{
		private _pattern = 
			//format["\bCODEKEY_LINE_PRAGMA_NUMBER_%1;",_foreachIndex];
			format[_keyFormatter,_foreachIndex];
		//! какая-то ебаная ошибка возникает при использовании #line в строке...
		private _replacer = format['Scopename "%1";%2',_x,ENDL,'#']; //%3line 1 "%1"%2 <- error on preprocess
		//_allContent = _allContent RegexReplace [_pattern,_replacer];
		_allContent = [_allContent,_pattern,_replacer] call stringReplace;
	} foreach allClientModulePathes;
	logformat("	Content size: %1 kb",(count _allContent)toFixed 0 splitString "." select 0);

	if isNull(file_write) exitWith {
		error("Function file_write not found");
		BT_ERRCODE(600);
	};
	private _savePath = RBuilder_map_defines get "RBUILDER_DIR";
	if isNullVar(_savePath) exitWith {
		error("Save path not found; Macro CLIENT_BIN_PATH undefined");
		BT_ERRCODE(601);	
	};
	_savePath = format["%1\bin\client\mission\CLIENT",_savePath];
	logformat("	Saving path: %1",_savePath);
	if ([_savePath,false] call file_exists) then {
		errorformat("Save path already exists: %1",_savePath);
		BT_ERRCODE(602);
	};
	private _savingResult = [_savePath,_allContent,false] call file_write;

	if (!_savingResult) exitWith {
		error("Saving error");
		BT_ERRCODE(603);
	};

	logformat(" Saving done in %1 ms",((tickTime-_time)*1000)toFixed 0 splitString "." select 0);

	0 //normally exit
};