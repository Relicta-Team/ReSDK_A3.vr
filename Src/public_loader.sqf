// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "host\engine.hpp"

relicta_cli_waitForLoaded = {
	waitUntil {
		!isNullReference(findDisplay 46) && 
		getClientStateNumber >= 10 && 
		count (missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]]) == 0
	};
};

//called only in scheduler (public initializer)
relicta_cli_publicLoader = {
	// waitUntil {
	// 	!isNullReference(findDisplay 46) && 
	// 	getClientStateNumber >= 10 && 
	// 	count (missionnamespace getvariable ["BIS_fnc_startLoadingScreen_ids",[]]) == 0
	// };
	call relicta_cli_waitForLoaded;
		
	startLoadingScreen["","Relicta_loadingScreen"];
	
	_d=uiNamespace getVariable ['relicta_loadingscreen_pre',displayNull];
	_ct = _d displayCtrl 102;_topCt = _d displayCtrl 101;
	_ct ctrlSetText "Подготовка";
	if (!canSuspend) exitwith {
		_topCt ctrlSetText "Контекст выполнения не является запланированным";
		_ct ctrlSetText "Ошибка выполнения";
		[] spawn {
			uiSleep 5;
			endLoadingScreen;
			endMission "LOSER";
		};
	};
	uiSleep 0.1;

	_dat = (call compile preprocessFile PATH_TO_CLIENT_DATA);
	_ct ctrlSetText "Чтение файла модулей";
	uiSleep 0.1;
	_err = -1;
	{
		_ct ctrlSetText format["Проверка модуля %1/%2",_forEachIndex+1,count _dat];
		if isNullVar(_x) exitwith {_err = _foreachindex + 1; _topCt ctrlSetText "Модуль не определён"};
		if not_equalTypes(_x,{}) exitwith {_err = _foreachindex+1; _topCt ctrlSetText "Неверный тип данных"};
		uiSleep 0.001;
	} foreach _dat;
	if (_err != -1) exitwith {
		_ct ctrlSetText format["Модуль %1 повреждён",_err];
		uiSleep 5;
		endLoadingScreen;
		endMission "LOSER";
	};
	uiSleep 0.1;

	_ct ctrlSetText "Данные загружены";
	_topCt ctrlSetText ("Relicta server version: "+relicta_version);
	uiSleep 1;

	isNil {
		{
			_ct ctrlSetText ("Инициализация модуля " + str _forEachIndex);
			call _x
		} foreach _dat;
		endLoadingScreen;
	}	
};

if (isMultiplayer && isNull(CRYPT_ENABLED)) then {
	missionnamespace setvariable ["relicta_cli_publicLoader",relicta_cli_publicLoader,true];
	missionnamespace setvariable ["relicta_cli_waitForLoaded",relicta_cli_waitForLoaded,true];
};