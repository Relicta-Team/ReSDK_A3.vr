// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\host\engine.hpp>
allClientContents = [];
client_isLocked = false;
vm_lastError = "unk_err";
#define __vm_log(text) "debug_console" callExtension ((text)+"#1110")
#define throwsafe(res) vm_lastError = res; throw vm_lastError;

//disable postoutput info
#define cmplog(data) 

#define DISABLE_REGEX_ON_FLIE

#ifdef __NO_WIN32_MODE__
	__vm_log("VM started in shell");
#endif

#ifdef __GH_ACTION
#define __vm_log(text) diag_log (text)
#endif

__G_FLAG_VALIDATE = false;
__G_FLAG_BUILD = false;

#ifdef __VM_VALIDATE
	__vm_log(" VM started in validate mode");
	__G_FLAG_VALIDATE = true;
#endif
#ifdef __VM_BUILD
	__G_FLAG_BUILD = true;
	__vm_log(" VM started in build mode");
#endif

{
	call compile preprocessFile "src\host\CommonComponents\Assert.sqf";

	if (!__G_FLAG_BUILD && !__G_FLAG_VALIDATE) then {
		throwsafe("!VMUnknownVMMode");
	};

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
		throwsafe("!EditorMacroError");
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

#include <..\host\CommonComponents\loader.hpp>

#define importClient(path) if (isNil {allClientContents}) then {allClientContents = [];}; if (client_isLocked) exitWith {__vm_log("Compile process aborted - client.isLocked == true")}; \
	__vm_log("[LOAD] " + path + " (" + (str(count allClientContents))+ ")"); \
	private _ctx = compile ((preprocessFile (path))); allClientContents pushback _ctx;

#include <loader.hpp>

	//override vmlog again
	#define __vm_log(text) "debug_console" callExtension ((text)+"#1110")
	#ifdef __GH_ACTION
	#define __vm_log(text) diag_log (text)
	#endif

	if (count allClientContents == 0) then {
		__vm_log("Not found any client files...");
		throwsafe("!NotFoundClientContent!");
	} else {
		__vm_log("Collected " + str count allClientContents + " modules!");
	};
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
	__vm_log("End process...");
	for"_i"from 0 to 900000 do {};
	#endif
	
	exitcode__ 1;
};

__vm_log("VM compile done");

#ifdef __FLAG_ONLY_PARSE__
	if (true) exitWith {
		__vm_log("");
		__vm_log("");
		__vm_log("	Parsing done!");
		exitcode__ 0;
	};
#endif

__vm_log("Validate modules");

{
	{
		__vm_log("Checking module " + (str _foreachIndex));
		//включить для тестов если старая виртуалка начнет опять тупить
		//copytoclipboard (CRYPT_KEY+"|"+(str (allClientContents select _foreachIndex)));
	} foreach allClientContents;
}
except__
{
	_exName = str _exception;
	_m = format ["	FATAL EXCEPTION: %1", _exName];
	__vm_log(endl+endl+_m);

	exitcode__ -25555;
};

__vm_log("Start copy to clipboard...");
copyToClipboard (CRYPT_KEY+"|"+(str allClientContents));

exitcode__ 0;