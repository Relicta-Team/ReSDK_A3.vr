// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\host\engine.hpp"
#include <..\host\client_compiled.hpp>

if isnil {buffer_cba_funcs} then {

	if (!_canCallClientCode) exitWith {}; //скипаем сегмент

	//TODO cleanup logics adding on client

	cba_common_perFrameHandlerArray = [];
	cba_common_PFHhandles = [];

	//buffer_cba_funcs = [];
	/*

	deleteLocation cba_events_eventNamespace;
	deleteLocation cba_events_eventHashes;

	cba_events_eventNamespace = call CBA_fnc_createNamespace;
	cba_events_eventHashes = call CBA_fnc_createNamespace;

	//cba refresh pfh handlers
	cba_common_perFrameHandlerArray = [];
	cba_common_PFHhandles = [];

	*/
};



//verify addons with getLoadedModsInfo
_getRelictaModHashes = {
	//getLoadedModsInfo
};
_ctx = compile 'errorformat("Version mismatch - %1 (required %2)",client_version arg relicta_version); endMission "LOSER";';

//saving and create models assoc
if !isNullVar(__USE_OOP_CREATE__) then {
	log("Starting models saver");
	log("Saving models not implemented");
};

#ifdef DEBUG
	#define cmplog(fcat) allClientContents pushBack (compile format['log("Init %1")',fcat]);
#else
	#define cmplog(fcat)
#endif

#ifdef USE_COMPILED_CLIENT
	if (true) exitWith {
		//not implemented
		error("Flag USE_COMPILED_CLIENT not implemented");
		appExit(APPEXIT_REASON_CRITICAL);
		//call compile preprocessFile "src\private.h";
		//(LoadFile "third-party\CLIENT_MISSION\CLIENT") call rc_deflow_compile;
	};
#endif

#include "loader.hpp"
