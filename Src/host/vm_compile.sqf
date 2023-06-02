// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <precomiled.sqf>
#include <engine.hpp>
allClientContents = [];
client_isLocked = false;
vm_lastError = "unk_err";
#define __vm_log(text) "debug_console" callExtension ((text)+"#1110")
#define throwsafe(res) vm_lastError = res; throw vm_lastError;

#define cmplog(data) __vm_log("	[LOAD] Module "+data);

#define DISABLE_REGEX_ON_FLIE

#ifdef __NO_WIN32_MODE__
	__vm_log("VM started in shell");
#endif

#ifdef __GH_ACTION
#define __vm_log(text) diag_log (text)
#endif

vm_allClasses = [];

checkClassInheritance = {
	//vm_allClasses = [];

	_classesTest = [
		["object","<superbase>"],
		["ManagedObject","object"],
		["RefCounterObject","object"],
		["NetObject","<superbase>"],
		["GameObject","ManagedObject"],
		["IDestructible","GameObject"],
		["BasicMob","GameObject"],
		["MobGhost","BasicMob"]
	];

	_readyClasses = [];
	_findBaseClass = {
		params ["_base","_errRet"];
		private _idx = vm_allClasses findif {_x select 0 == _base};
		if (_idx == -1) exitwith {_errRet};
		vm_allClasses select _idx select 1;
	};
	{
		_pObj = missionNamespace getvariable ["pt_"+_x,"@noclass"];
		_className_str = _x;
		if (_pObj isequalto "@noclass") exitwith {
			__vm_log("Cant find class " + _className_str);
			throwsafe("!ClassNotFoundException!");
		};
		if ((tolower _className_str) in _readyClasses) then {
			__vm_log("Duplicate classname " + _className_str);
			throwsafe("!DuplicateClassNameException!");
		};
		_readyClasses pushBack (tolower _className_str);
		
		_motherType = [_pObj,"@nullclass"] call _findBaseClass;
		if (_motherType != "<superbase>" && {missionNamespace getvariable ["pt_"+_motherType,"@nullclass"] isequalto "@nullclass"}) exitwith {
			__vm_log("Cant find mother class " + _motherType + "; Base: " + _className_str);
			throwsafe("!MotherClassNotFoundException!");
		};

		_mot = _pObj;
		
	} foreach p_table_allclassnames;
};

{
	private _pcontent = LOADFILE "src\private.h";
	if (count _pcontent > 0) then {
		call compile preprocessFile "src\private.h";
		if isNull(CRYPT_ENABLED) then {
			__vm_log("		Crypt not enabled (but header found)");
			CRYPT_KEY = "public_build";
		} else {
			__vm_log("		Crypt enabled - header found");
		};
	} else {
		__vm_log("		Crypt not enabled (file not found)");
		CRYPT_KEY = "public_build";
	};


	#ifdef EDITOR
		__vm_log("		Editor macro not disabled");
		throw "!EditorMacroError";
	#endif

	#ifdef RELEASE
		__vm_log("		Start RELEASE compile");
		_LV_RELEASE = true;
	#else
		_LV_RELEASE = false;
	#endif
	
	#ifdef DEBUG
		__vm_log("		Start DEBUG compile");
		_LV_DEBUG_ = true;
	#else
		_LV_DEBUG_ = false;
	#endif
	
	if (_LV_DEBUG_ == _LV_RELEASE) then {
		__vm_log("		Build type equals: " + str _LV_DEBUG_);
		throwsafe( "!BuildTypeNotSelectedException!");
	};
	
	#ifdef ENABLE_HOT_RELOAD
		__vm_log("		Macro ENABLE_HOT_RELOAD active");
		if (!_LV_DEBUG_) exitWith {
			__vm_log("		Macro ENABLE_HOT_RELOAD allowed only in DEBUG mode. Enable this flag in the SETTINGS.h file");
			throwsafe( "!HotReloadInNotDebugException!");
		};
	#endif
	
	if !isNull(CRYPT_SAVE_AS_BINARY) then {
		if (CRYPT_SAVE_AS_BINARY) then {
			__vm_log("		CRYPT_SAVE_AS_BINARY flag ENABLED");
		};
	};
	
	#ifdef USE_LOCAL_PATHES
		__vm_log("		Macro USE_LOCAL_PATHES enabled. Disable this and try again");
		throwsafe( "!LocalPathesEnabledException!");
	#endif

	if isNull(CRYPT_KEY) then {
		throwsafe( "!NullCryptKeyException");
	};

//#include <CommonComponents\loader.hpp>

	#include "init.sqf"
	call checkClassInheritance;
}
except__
{
	_exName = str _exception;
	if (_exName select[2,1] == "!") then {
		//_exName = ((_exName splitString "!")select 1) ;
		_exName = vm_lastError;
	} else {
		_exName = _exception;
	};
	_m = format ["	EXCEPTION OCCURRED: %1", _exName];
	__vm_log(endl+endl+_m);
	
	#ifdef __NO_WIN32_MODE__
	for"_i"from 0 to 900000 do {};
	#endif
	
	exitcode__ 1;
};

#ifdef __FLAG_ONLY_PARSE__
	if (true) exitWith {
		__vm_log("	Class count:" + str count vm_allClasses);
		__vm_log("	Parsing done!");
		copyToClipboard (str vm_allClasses);
		exitcode__ 0;
	};
#endif

copyToClipboard (CRYPT_KEY+"|"+(str allClientContents));

exitcode__ 0;