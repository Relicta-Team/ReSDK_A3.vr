// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "host\engine.hpp"
#include "host\struct.hpp"
#include "host\oop.hpp"
#include <host\Networking\Network.hpp>

#include <host\precompiled.sqf>

//server password and crypt key if exists
if (fileExists("src\private.h")) then {
	private _CRYPT_COMPILE_SERVER_ = true;
	call compile __pragma_preprocess ("src\private.h");
};

//предварительная компиляция трассировки стека в редакторе
#ifdef EDITOR
if (!isMultiplayer) then {
	call compile __pragma_preprocess ("src\host\Tools\EditorWorkspaceDebug\InternalImpl.sqf");
};
#else
	//assert preinit
	call compile __pragma_preprocess ("src\host\CommonComponents\Assert.sqf");
#endif

#ifdef EDITOR
	projectEditor_isCompileProcess = true;
#endif

//pre init logger
call compile __pragma_preprocess ("src\host\Logger\Logger_init.sqf");

if (isMultiplayer) then {
	static_assert_str(SERVER_PASSWORD,"Server password must be defined");

	//lock server
	SERVER_PASSWORD serverCommand "#lock";

	//first kicking all users
	{
		(getUserInfo _x) params ["","_owner"];
		if (_owner > 2) then {
			SERVER_PASSWORD serverCommand (format["#kick %1 Сервер ещё не загружен.",_owner]);
		};
	} forEach allUsers;

	// fast connected clients protect
	/*_code = {
		{
			(getUserInfo _x) params ["","_owner"];
			if (_owner > 2) then {
				SERVER_PASSWORD serverCommand (format["#kick %1 Сервер ещё не загружен.",_owner]);
			};
		} forEach allUsers;
	};
	server_internal_preInit_kickHandle = startUpdate(_code,1);*/


	//base decl funcs
	#define __parametrize__ params ["_m","_ft"];
	#define __parametrize__disc__ params ["_m"];
	#define decl_print_base(module,__params) module = {__params "debug_console" callExtension (format['(preload) [module]: %1',_m]); ['(preinit) [module]: %1',_m] call logInfo}

	decl_print_base(cprint,__parametrize__);
	decl_print_base(cprintErr,__parametrize__);
	decl_print_base(cprintWarn,__parametrize__);
	decl_print_base(discLog,__parametrize__disc__);
	decl_print_base(discWarning,__parametrize__disc__);
	decl_print_base(discError,__parametrize__disc__);

};

#define consoleNullLine() "debug_console" callExtension ("")
#define progLog(mes) "debug_console" callExtension (mes + "#0101"); [mes] call logInfo

if (isMultiplayer && isNullVar(server_isLocked)) then {
	server_isLocked = false; // указывает может ли сервер принимать активные соединения. !Не путать с cm_isServerLocked!
};
["Start loading server..."] call systemLog;

//Валидация включенного редактора
private __EDITOR_MACRO_VALIDATE__ = "";
call compile preprocessFileLineNumbers "src\host\oop.hpp";
if (__EDITOR_MACRO_VALIDATE__ == "EDITOR_MACRO") exitWith {
	progLog("EDITOR NOT DISABLED. SERVER WONT LAUNCHED");
	appExit(APPEXIT_REASON_CRITICAL);
};


//Обязательно инитим ооп перед всеми приколами
#include "host\OOP_engine\oop_preinit.sqf"
loadFile("src\host\OOP_engine\oop_main_loader.sqf");
loadFile("src\host\Discord\Discord.sqf"); //Предварительная инициализация дискорд бота
if (canSuspend) then {
	warning("Server side code process init runs in the scheduler");
};
//Нужно для CommonComponents (использует rpcAddGlobal())
loadFile("src\host\ServerRpc\serverRpc_init.sqf"); //Предварительная инициализация rpc для сервера.

progLog("START LOADING CONTENT...");

loadFile("src\host\SceneReloader\SceneReloader.sqf"); //works only inside debug mode

allClientContents = [];
allClientModulePathes = [];

//removing all cba events in debug mode
if (isnil {mem_cba_events}) then {

	mem_cba_events = [];
	mem_cba_hashes = [];

	//Запись
	{
		_code = cba_events_eventNamespace getVariable _x; //array?
		mem_cba_events pushBack [_x,_code]
	} foreach (allVariables cba_events_eventNamespace);

	{
		_code = cba_events_eventHashes getVariable _x; //array?
		mem_cba_hashes pushBack [_x,_code]
	} foreach (allVariables cba_events_eventHashes);

} else {

	deleteLocation cba_events_eventNamespace;
	deleteLocation cba_events_eventHashes;

	cba_events_eventNamespace = call CBA_fnc_createNamespace;
	cba_events_eventHashes = call CBA_fnc_createNamespace;

	{
		_x params ["_var","_val"];

		cba_events_eventNamespace setVariable [_var,_val];

	} foreach mem_cba_events;

	{
		_x params ["_var","_val"];

		cba_events_eventHashes setVariable [_var,_val];

	} foreach mem_cba_hashes;
	
	cba_common_waituntilAndExecArray = [];
	cba_common_waitAndExecArray = [];
	cba_events_lastJIPID = nil;
};
if (!isnil {allThreads}) then {
	{
		terminate _x;
	} foreach allThreads;
};
allThreads = [];

_time_global = tickTime;
#include <host\CommonComponents\loader.hpp>
progLog("Common components loaded in "+ str(diag_ticktime - _time_global) + " sec");

_time_global = diag_ticktime;

if (!isMultiplayer) then {
	#ifndef EMULATE_CLIENT_INSP
		loadFile("src\client\init.sqf");
		progLog("Clientside scripts loaded in " + str(diag_ticktime - _time_global) + " sec");
	#else
		progLog("CLIENTSIDE IS NOT LOADED IN EMULATE MODE");
	#endif
};

private _onexit = {
	#ifdef RBUILDER
	call RBuilder_onServerLockedLoading;
	#endif
};

_calculateClientSide = {

	private _size = 0;

	{
		_str_content = (str _x);
		_str_updated = _str_content select [1,count _str_content - 1];
		MOD(_size, + count(_str_updated));

	} foreach allClientContents;

	progLog("Clientside scripts size is " + str _size + " bytes");

	//for testing
	//alldat = str allClientContents;

};

_time_global = diag_ticktime;
loadFile("src\host\init.sqf");
if (server_isLocked) exitwith _onexit; //because class compiler can throws errors
call dsm_initialize; //discord mgr init

//do not validate yaml in spmode
#ifndef SP_MODE

	if (!call yaml_isExtensionLoaded) then {
		#ifdef EDITOR
		["Yaml библиотека не найдена."
			+endl+endl+"Пожалуйста выполните команду по обновлению файлов редактора: Закройте Платформу и запустите ""RBuilder\DEPLOY.bat"""] call messageBox;
		#endif
		setLastError("Yaml library not found.");
		appExit(APPEXIT_REASON_EXTENSION_ERROR);
	};

	private _yamlObj = call yaml_getExtensionVersion;
	logformat("Yaml version: %1",_yamlObj);
	if ((_yamlObj getv(major)) == 0) then {
		#ifdef EDITOR
		["Yaml библиотека не обновлена."
			+endl+endl+"Пожалуйста выполните команду по обновлению файлов редактора: Закройте Платформу и запустите ""RBuilder\DEPLOY.bat"""] call messageBox;
		#endif
		setLastError("Yaml library outdated.");
		appExit(APPEXIT_REASON_EXTENSION_ERROR);
	};
	
#endif

if (server_isLocked) exitWith _onexit;

progLog("Serverside scripts loaded in " + str(diag_ticktime - _time_global) + " sec");

if (!isMultiplayer) then {
	#ifndef EMULATE_CLIENT_INSP
		call _calculateClientSide;
	#else
		progLog("Clientside scripts SKIPPED.");
	#endif
};

//init database
[call db_init] call db_checkSystemReturn;
private __revision = preprocessFile "src\REVISION";
private __sha = __revision;
if (__sha != "Unrevisioned") then {
	__sha = __sha select [0,7];
};
project_version = (((preprocessFile "src\VERSION") splitString endl) select 0) + "+" + (__sha);
netSetGlobal(relicta_version,project_version);

#ifdef DISABLETEAMSPEAK
vs_serverdisabled = true;
netSetGlobal(vs_serverdisabled,vs_serverdisabled);
#endif
progLog("Project loaded! Version " + project_version);
progLog("Revision: " + __revision);

#ifdef RELEASE
	_release = true;
#else
	_release = false;
#endif

#ifdef DEBUG
	_debug = true;
#else
	_debug = false;
#endif

progLog("isDebug: " + str _debug + "; isRelease: " + str _release);
if (_debug == _release) exitWith {
	setLastError("Debug/Release modes cannot be the same! " + (str _debug));
	appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
};

#ifdef EDITOR
	if !isNull(relicta_debug_compileMain) then {
		call relicta_debug_compileMain;
	};
	call relicta_debug_internal_postCompileProcess;
	projectEditor_isCompileProcess = false;
#endif

#ifdef USEEVERYDAYRUN_HOUR
	progLog(format vec3("!!!WARNING!!! Server will shutting down after %1:%2",USEEVERYDAYRUN_HOUR,USEEVERYDAYRUN_MINUTE));
	_idEVD = startUpdate({USEEVERYDAYRUN_THREAD_UPDATE()},10);
	progLog("Added every day shutdown task; Id: " + str _idEVD);
#endif

#ifdef PRIVATELAUNCH
	progLog("!!! Server is running in private mode !!!");
#endif

#ifdef TEXTCHAT
	relicta_global_textChatEnabled = true;
	netSetGlobal(relicta_global_textChatEnabled,relicta_global_textChatEnabled);
	progLog("!!! Text chat activated !!!");
#endif

if (isMultiplayer) then {
	#ifdef TEST_WHITELISTED
	[format["Тестовый сервер запущен.\nДоступ по вайтлисту\nВерсия %1",project_version]] call discServerNotif;
	#else
	[format["Сервер запущен! Версия %1",project_version]] call discServerNotif;
	#endif
};

#ifdef SP_MODE
	loadFile("src\host\Singleplayer\singleplayer_init.sqf");
#endif

server_maxclients = 70; //максимальное количество подключаемых клиентов

server_isHandleEndSession = false;

// on server launch sync reputations and tests
call db_onSyncReputations;

//Специалка для выключения сервера
server_end = {

	server_isHandleEndSession = true;

	if (!cm_isServerLocked) then {
		call cm_serverLock;
	};
	
	deferred {
		//kick all clients
		{
			[getVar(_x,id),"Конец приключениям."] call cm_serverKickById;
		} foreach cm_allClients;
		["Kicking clients"] call logInfo;

		call db_onSyncReputations;

		//save db info
		deferred {

			{
				[_x] call db_saveClient;
			} foreach (values cm_disconnectedClients);
			["Saving clients"] call logInfo;

			//closing database
			call db_closeConnection;
			["Closing database"] call logInfo;

			//restart function
			deferred {
				["Invoke shutdown..."] call logInfo;
				"#shutdown" call cm_serverCommand;
			} doInvoke(1);

		} doInvoke(1);

	} doInvoke(0.5); //2.5 sec to rest

	#ifdef RELEASE
	[format["Сервер выключен."]] call discServerNotif;
	#endif
};

server_restart = {

	server_isHandleEndSession = true;

	if (!cm_isServerLocked) then {
		call cm_serverLock;
	};

	deferred {
		//kick all clients
		{
			[getVar(_x,id),"Жители Сети засыпают и скоро начнется новый день."] call cm_serverKickById;
		} foreach cm_allClients;
		["Kicking clients"] call logInfo;

		call db_onSyncReputations;

		//save db info
		deferred {

			{
				[_x] call db_saveClient;
			} foreach (values cm_disconnectedClients);
			["Saving clients"] call logInfo;

			//closing database
			call db_closeConnection;
			["Closing database"] call logInfo;

			//restart function
			deferred {
				["Invoke reboot..."] call logInfo;
				"#restart" call cm_serverCommand;
			} doInvoke(1);

		} doInvoke(1);

	} doInvoke(0.5); //2.5 sec to rest

	#ifdef TEST_WHITELISTED
	[format["ТЕСТ - перезапуск."]] call discServerNotif;
	#else
	[format["Перезапуск раунда."]] call discServerNotif;
	#endif
};

#ifdef PRIVATELAUNCH
	server_privateLaunch_list_awaitCheck = [];
	server_privateLaunch_requiredRoles = ["Inner Rule","S.R.I.","Cool Man"];
	server_privatelaunch_onUpdate = {
		
		if (count server_privateLaunch_list_awaitCheck == 0) exitWith {};

		private _client = nullPtr;
		private _haveRole = false;
		{
			_client = _x;
			if isNullReference(_client) then {continue};
			if (!callFunc(_client,isConnected)) then {
				server_privateLaunch_list_awaitCheck deleteAt (server_privateLaunch_list_awaitCheck find _client);
				continue;
			};

			if !callFunc(_client,isDiscordAccountRegistered) then {
				callFuncParams(_client,forceDisconnect,"Приватный запуск. У вас не привязан аккаунт");
				server_privateLaunch_list_awaitCheck deleteAt (server_privateLaunch_list_awaitCheck find _client);
				continue;
			};

			if getVar(_client,hasFirstLoadedRoles) then {
				_haveRole = false;
				_ldat = getVar(_client,_discordRolesCache);
				{
					if callFuncParams(_client,hasDiscordRole,_x) exitWith {
						_haveRole = true;
					};
				} foreach server_privateLaunch_requiredRoles;

				if (!_haveRole) then {
					callFuncParams(_client,forceDisconnect,"Приватный запуск. У вас нет нужной роли в дискорде. Ваши роли: " + (_ldat joinString "; "));
				};

				server_privateLaunch_list_awaitCheck deleteAt (server_privateLaunch_list_awaitCheck find _client);
			};
		} foreach array_copy(server_privateLaunch_list_awaitCheck);
	};
	server_privatelaunch_onUpdate_handle = startUpdate(server_privatelaunch_onUpdate,0.5);
#endif