// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Based on:
// DiscordRichPresence extension
// Author: https://steamcommunity.com/sharedfiles/filedetails/?id=1493485159

#include <..\..\host\engine.hpp>

namespace(DiscordRPC,discrpc_)

#include <DiscordRPC.h>

decl(map)
discrpc_list_ruLetters = createHashMap; //в кодировке 1251
#include "DiscordRPC_ruLetters.sqf"


//допустимые ключи для расширения
decl(string[])
discrpc_allowedTaskTypes = [
	"UpdateDetails",
	"UpdateState",
	"UpdateLargeImageKey",
	"UpdateLargeImageText",
	"UpdateSmallImageKey",
	"UpdateSmallImageText",
	"UpdateStartTimestamp",
	"UpdateEndTimestamp",
	"UpdatePartySize",
	"UpdatePartyMax"
];

//отправляет новую информацию в rpc и обновляет статус клиента
decl(void(...any[]))
discrpc_send = {
	if (isNullVar(_this) || {not_equalTypes(_this,[])}) exitwith {
		error("discrpc::send() - Cant update client state: wrong type or null params");
	};
	
	private __taskResult = "";

	{
		_x params [["_taskType",""],["_value",""]];
		if (_taskType in discrpc_allowedTaskTypes) then {
			
			//Конвертация кодировки
			if equalTypes(_value,"") then {_value = encodeString(_value)};
			
			__taskResult = setTask(_taskType,_value);
			#ifdef allowtrace
			traceformat("discrpc::send() - output %1: input %2",__taskResult arg _x);
			#endif
		} else {
			errorformat("discrpc::send() - Unknown pair %1",_x);
		};
	} foreach _this;

	__taskResult = updateState();
	#ifdef allowtrace
	traceformat("discrpc::send() - on update %1",__taskResult)
	#endif

};

//инициализатор. вызывается при подключении к серверу и устанавливает статус клиента
decl(void())
discrpc_init = {

	private _ret = initApplication();
	#ifdef allowtrace
	traceformat("discrpc::init() - is inited %1",_ret#1 == 1);
	#endif

	[
		getAppToken(),
		"На сервере",
		"",
		"pic_large",
		"relicta.ru",
		"pic_small",
		"",
		true
	] params [
		"_applicationID","_defaultDetails","_defaultState",
		"_defaultLargeImageKey","_defaultLargeImageText",
		"_defaultSmallImageKey","_defaultSmallImageText",
		"_showTimeElapsed"
	];

	//current load checking


	private _settings = [
		["UpdateDetails",_defaultDetails],
		["UpdateState",_defaultState],
		["UpdateLargeImageKey",_defaultLargeImageKey],
		["UpdateLargeImageText",_defaultLargeImageText]/*,
		["UpdateSmallImageKey",_defaultSmallImageKey],
		["UpdateSmallImageText",_defaultSmallImageText]*/
	];
	if _showTimeElapsed then {_settings pushback ["UpdateStartTimestamp",[0,0]]};

	//just first load...
	_settings call discrpc_send;

};

decl(void())
discrpc_reload = {
	initApplication();
};

decl(void())
discrpc_unload = {
	extname callExtension ["CloseRichPresence",[]];
};

//кодирует русские символы из utf8 в win-1252
decl(string(string))
discrpc_encodeRu = {
	private _ruStr = _this;
	forceUnicode 1;
	private _char = "";
	private _outSB = [];
	{
		#ifdef USE_LOCALES
			_outSB pushBack ((discrpc_list_ruLetters getOrDefault [_x,_x]) call discrpc_getLetterByLocale)
		#else
			_outSB pushBack (discrpc_list_ruLetters getOrDefault [_x,_x])
		#endif
		
	} foreach (_ruStr splitString "");
	
	_outSB joinString ""
};

#ifdef USE_LOCALES
decl(any(any))
discrpc_getLetterByLocale = {
	private _l = _this;
	//private _langs = ["Russian","English"];
	_l select ifcheck(LANGuage == "Russian",0,1);
};
#endif

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

	---------------------------------------- HLAPI -------------------------------------------------

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

//установить статус клиента. Доступные статусы ingame,lobby
decl(void(string))
discrpc_setStatus = {
	params ["_strStatus"];

	call {
		if (_strStatus == "ingame") exitWith {
			call discrpc_setIngameStatus;
		};
		if (_strStatus == "lobby") exitWith {
			call discrpc_setInLobbyStatus;
		};
		if (_strStatus == "playing") exitWith {
			call discrpc_setPlayingStatus;
		};

		errorformat("discrpc::setStatus() - Unknown status '%1'",_strStatus);
	};
};

//вызывается когда клиент подключился
decl(void())
discrpc_setIngameStatus = {
	private _randState = pick ["Готовится к худшему","Пожирает мельтешат",""];
	[
		["UpdateDetails","В игре"],
		["UpdateState",_randState]
	] call discrpc_send;
};

//вызывается когда клиент в лобби
decl(void(string))
discrpc_setInLobbyStatus = {
	params [["_mainRole",""]];

	//todo если раунд уже идёт статус не будет показываться
	private _args = [
		["UpdateDetails","В лобби"]
	];
	
	if not_equals(_mainRole,"") then {
		_args pushBack ["UpdateState","Роль: " + _mainRole]
	} else {
		_args pushBack ["UpdateState","Он же " + cd_clientName];
	};
	
	_args call discrpc_send;
};

//вызывается когда клиент в игре
decl(void())
discrpc_setPlayingStatus = {
	//params ["_charName"];
	
	private _args = [
		["UpdateDetails","В игре"]
	];
	_mes = if (isMultiplayer) then {
		pick ["Пытается выжить","Скитается по Сети","Исполняет свою роль","В поисках смерти","Существует"]
	} else {
		"In dev mode"
	};
	_args pushBack ["UpdateState",_mes];
	
	_args call discrpc_send;
};

if (is3DEN) then {
	decl(void())
	discrpc_editor_init = {
		initApplication();

		private _settings = [
			["UpdateDetails","In ReSDK_A3"],
			["UpdateState","Developing process"],
			["UpdateLargeImageKey","pic_large"],
			["UpdateLargeImageText","relicta.ru"]/*,
			["UpdateSmallImageKey",_defaultSmallImageKey],
			["UpdateSmallImageText",_defaultSmallImageText]*/
		];
		_settings pushback ["UpdateStartTimestamp",[0,0]];

		_settings call discrpc_send;
	};

	decl(void(string))
	discrpc_editor_updateState = {
		[
			["UpdateState",_this]
		] call discrpc_send;
	};
};