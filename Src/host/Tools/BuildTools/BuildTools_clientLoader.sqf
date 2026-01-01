// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
	for compiling error code use setvar _clientCompileErrorCode > 100
*/
#include "..\..\engine.hpp"

log("Compiling shared components");
//call compile __pragma_preprocess "src\host\CommonComponents\loader.hpp";
#include <..\..\CommonComponents\loader.hpp>

;

//adding scripted lights
private _ltData = ["lt_preload_cfgList = [];"];
{
	if !(fileExists(_x)) exitWith {
		_clientCompileErrorCode = 103;
		_ltData = [];
		errorformat("Light config not found => %1",_x);
	};
	_ltData pushBack (
		["lt_preload_cfgList pushBack (",str (preprocessFile _x),");"] joinString " "
	)
} foreach slt_internal_fileListBuffer;
if (count _ltData == 0) exitWith {}; //fatal light loading
allClientContents pushBack (compile(_ltData joinString endl));
allClientModulePathes pushBack "scripted_light_configs";


private _shCnt = count allClientContents;
if (_shCnt == 0) exitWith {
	error("Shared components not found or empty");
	_clientCompileErrorCode = 101;
};

logformat("Shared components count: %1",_shCnt);

log("Compiling client components");

#ifdef DEBUG
	#define cmplog(fcat) allClientContents pushBack (compile format['log("Init %1")',fcat]); allClientModulePathes pushBack "internal module logging";
#else
	#define cmplog(fcat)
#endif

#include <..\..\..\client\loader.hpp>

;
private _cliCnt = (count allClientContents)-  _shCnt;
if (_cliCnt == 0) exitWith {
	error("Client components not found or empty");
	_clientCompileErrorCode = 102;
};

logformat("Client components count: %1",_cliCnt);

_finalizedStageCatch = true;