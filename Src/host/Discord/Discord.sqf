// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\ServerRpc\serverRpc.hpp>

#include <ServerManager.sqf>
#include <Accounts.sqf>

//#define DISCORD_ENABLE_EXTENDED_TRANSPORT


#ifdef DISCORD_ENABLE_EXTENDED_TRANSPORT

	#define DISCORD_MAX_MESSAGES_COUNT_PERDELAY 5

	disc_stack_logger = [];
	disc_lastLoggerTime = tickTime;
	disc_messagesLeftPerSec = DISCORD_MAX_MESSAGES_COUNT_PERDELAY;
	#define discord_reset_stackcount() disc_messagesLeftPerSec = DISCORD_MAX_MESSAGES_COUNT_PERDELAY
	disc_handle_update = -1;
	//задержка между сообщениями
	#define DISCORD_UPDATE_DELAY 5.001

#endif

disc_token_admin = "Admin";
disc_token_logger = "Logger";
	disc_icon_logger = "https://flammlin.com/wp-content/uploads/2020/03/logfile_file.png";
disc_token_serverNotif = 
	#ifdef TEST_WHITELISTED
	"TestWhitelist"
	#else
	"Broadcaster"
	#endif
	;
	disc_icon_serverNotif = "https://cdn.discordapp.com/emojis/467665814540124170.png?v=1";

#ifdef DISCORD_ENABLE_EXTENDED_TRANSPORT
	disc_onUpdate = {
		
		if (count disc_stack_logger > 0) then {
			
			//Восстанавливаем значение на кадр
			discord_reset_stackcount();
			
			
			for "_i" from 0 to ((count disc_stack_logger) -1) do {
				
				[
					disc_token_logger,
					disc_stack_logger deleteAt 0,
					"Logger",
					disc_icon_logger,
					false
				] call DiscordEmbedBuilder_fnc_buildSqf;
				DEC(disc_messagesLeftPerSec);
				//на данном фрейме возникло ограничение - выходим
				if (disc_messagesLeftPerSec == 0) exitWith {};
			};
		} else {
			//Прошла секунда и в стеке нет сообщений
			//Просто очищаем стэк
			discord_reset_stackcount();
		};
		
	};
	disc_handle_update = startUpdate(disc_onUpdate,DISCORD_UPDATE_DELAY);
#endif

if (!isMultiplayer) then {
	disc_debug_allowMessages = false;
	DiscordEmbedBuilder_fnc_buildSqf = {
		params ["_token","_mes","_name","_ico","_flg"];
		if (!disc_debug_allowMessages) exitWith {};
		
		logformat("[DEBUG::DISCORD]: %1",_mes);
	};
};

disc_logger_provider = {
	params ["_message"];
#ifdef DISCORD_ENABLE_EXTENDED_TRANSPORT
	if (disc_messagesLeftPerSec > 0) then {
		
		[
			disc_token_logger,
			_message,
			"Logger",
			disc_icon_logger,
			false
		] call DiscordEmbedBuilder_fnc_buildSqf;
		
		DEC(disc_messagesLeftPerSec);
	} else {
		disc_stack_logger pushBack _message;
	};
#else
	[
		disc_token_logger,
		_message,
		"Logger",
		disc_icon_logger,
		false
	] call DiscordEmbedBuilder_fnc_buildSqf;
#endif
};

disc_adminlog_provider = {
	params ["_message"];
	[
		disc_token_admin,
		_message,
		"AdminMessage",
		disc_icon_logger,
		false
	] call DiscordEmbedBuilder_fnc_buildSqf;
};

discLog = {
	params ["_message"];
	_message = format["[LOG]:	%1",_message];
	[_message] call disc_logger_provider;
};

discError = {
	params ["_message"];
	_message = format["[ERROR]:	%1",_message];	
	[_message] call disc_logger_provider;
};

discWarning = {
	params ["_message"];
	_message = format["[WARN]:	%1",_message];
	[_message] call disc_logger_provider;
};

discServerNotif = {
	params ["_message",["_header","Оповещение"],["_preMessage",""]];
	[
	    disc_token_serverNotif,
	    _preMessage, //@everyone
	    "Вещатель Сети",
	    disc_icon_serverNotif,
	    false,
		[
			[
			_header,
			        _message,
			        "",
			        "218359",
			        false
			]
		]
	] call DiscordEmbedBuilder_fnc_buildSqf;
};

discUserLog = {
	params ["_message","_name"];
	_message = format["(from %2) [USERLOG]:	%1",_message,_name];
	[_message] call disc_logger_provider;
};

#ifdef RBUILDER
	DiscordEmbedBuilder_fnc_buildSqf = {};
#endif

_cliErr = {
	params ["_fmtMessage","_cli"];

	_usr = _cli call cm_findClientById;
	if equals(_usr,nullPtr) exitWith {
		errorformat("RPC::sendMesToDisc() - Unknown client id %1",_cli);
	};

	[_fmtMessage,getVar(_usr,name)] call discUserLog;
};
// ОШИБКА! - функция добавления события определена позже чем этот метод 
//rpcAdd("sendMesToDisc",_cliErr);
