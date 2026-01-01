// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\text.hpp>

#define PUBLIC_COMMAND -99999

_processClientCommand = {
	params ["_text","_playerObject"];
	[_playerObject,_text] call cm_processClientCommand;
};
rpcAdd("processClientCommand",_processClientCommand);

cm_processClientCommand = {
	params ["_playerObject","_text",["_isClient",false]];

	private _owner = if (isMultiplayer) then {
		ifcheck(_isClient,callFunc(_playerObject,getOwner),owner _playerObject)
	} else {0};

	private this = _playerObject getvariable ["link",nullPtr];
	private _canAccessMob = not_equals(this,nullPtr);

	private _client = ifcheck(_isClient,_playerObject,_owner call cm_findClientById);
	if equals(_client,nullPtr) exitWith {
		errorformat("cm::processClientCommand() - Client with id %1 not found",_owner);
	};
	private _command = "";
	private _arguments = "";
	if ((_text find " ") != -1) then {
		_idx = _text find " ";
		_command = _text select [0,_idx];
		_arguments = _text select [_idx + 1,count _text - _idx - 1];
		traceformat("command:%1;",_command)
		traceformat("arguments:%1;",_arguments)
	} else {
		_command = _text;
	};

	//check command
	private _scom = cm_commands_map get _command;
	if isNullVar(_scom)  exitWith {
		warningformat("cm::processClientCommand() - Cant find command %1 (called on %2)",_command arg _owner);
	};

	//check owner
	private _accessList = _scom select 0;
	if (!array_exists(_accessList,getVar(_client,access)) && !array_exists(_accessList,PUBLIC_COMMAND) && (selectMax _accessList > getVar(_client,access))) exitWith {
		warningformat("cm::processClientCommand() - No access to call %1 (called on %2): list access:%3; client access %4",_command arg _owner arg _accessList arg getVar(_client,access));
	};

	//check code
	if (count _scom != 3) exitWith {
		errorformat("cm::processClientCommand() - Command %1 is undefined (called on %2)",_command arg _owner);
	};

	//now call command!
	call (_scom select 2);

	logformat("cm::processClientCommand() - Command %1 called!",_command);
	
	[format["cm::processClientCommand() - %1 called cmd '%2' with args: %3",getVar(_client,name),_command,_arguments]] call adminLog;
	[format["cm::processClientCommand() - %1 called cmd '%2' with args: %3",getVar(_client,name),_command,_arguments]] call disc_adminlog_provider;
};

cm_commands_map = createHashMap;
private _cm_map_dataCode = [];
#define __validate_cmd(cmdname) if (cmdname in cm_commands_map) exitWith {errorformat("Duplicate command %1 (%3 at %2)",cmdname arg __LINE__ arg __FILE__); ["Duplicate command %1 (%3 at %2)",cmdname arg __LINE__ arg __FILE__] call logCritical; appExit(APPEXIT_REASON_DOUBLEDEF)}
#define addCommand(name,owners) _cm_map_dataCode = [[owners],""]; __validate_cmd(name); cm_commands_map set [name,_cm_map_dataCode]; _cm_map_dataCode pushBack
#define addCommandWithDescription(name,owners,desc) _cm_map_dataCode = [[owners],desc]; __validate_cmd(name); cm_commands_map set [name,_cm_map_dataCode]; _cm_map_dataCode pushBack
#define IS_LOCAL_COMMAND() rpcSendToClient(_owner,"onLocalCommandCalled",[_command arg _arguments])
#define caller _owner
#define args _arguments
#define checkIfMobExists() if (!_canAccessMob) exitWith {false};
#define thisClient _client
/*
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
----------------------------------------------------------------------------------------------------
********************************LIST OF SERVER COMMANDS*********************************************
----------------------------------------------------------------------------------------------------
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
*/

#include <cmds\Access.sqf>
#include <cmds\Admin.sqf>
#include <cmds\Common.sqf>
#include <cmds\EditorAndDebug.sqf>
#include <cmds\Local.sqf>
#include <cmds\Reflect.sqf>
#include <cmds\ServerControl.sqf>