// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//insert here all cba functions


CBA_fnc_log = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_log'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_log';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\diagnostic\fnc_log.sqf [CBA_fnc_log]"
#line 1 "x\cba\addons\diagnostic\fnc_log.sqf"
#line 1 "x\cba\addons\diagnostic\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\diagnostic\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 12 "x\cba\addons\diagnostic\script_component.hpp"
#line 1 "a3\ui_f\hpp\defineDIKCodes.inc"
#line 14 "x\cba\addons\diagnostic\script_component.hpp"
#line 1 "a3\ui_f\hpp\defineCommonGrids.inc"
#line 15 "x\cba\addons\diagnostic\script_component.hpp"
#line 1 "a3\ui_f\hpp\defineResincl.inc"
#line 16 "x\cba\addons\diagnostic\script_component.hpp"
#line 2 "x\cba\addons\diagnostic\fnc_log.sqf"
scriptName 'cba\diagnostic\log';

params [["_message", "", [""]]];

if (isNil "cba_diagnostic_logArray") then {
cba_diagnostic_logArray = [];
cba_diagnostic_logScript = scriptNull;
};

cba_diagnostic_logArray pushBack text _message;

if (scriptDone cba_diagnostic_logScript) then {
cba_diagnostic_logScript = 0 spawn {
private "_selected";

while {
_selected = cba_diagnostic_logArray deleteAt 0;
!isNil "_selected"
} do {
diag_log _selected;
};
};
};

nil

};

cba_fnc_createNamespace = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_createNamespace'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_createNamespace';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_createNamespace.sqf [CBA_fnc_createNamespace]"
#line 1 "x\cba\addons\common\fnc_createNamespace.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_createNamespace.sqf"
scriptName 'cba\common\createNamespace';

params [["_isGlobal", false]];

if (_isGlobal isEqualTo true) then {
createSimpleObject ["CBA_NamespaceDummy", [-1000, -1000, 0]]
} else {
createLocation ["CBA_NamespaceDummy", [-1000, -1000, 0], 0, 0]
};

};

cba_fnc_addEventHandler = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_addEventHandler'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_addEventHandler';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_addEventHandler.sqf [CBA_fnc_addEventHandler]"
#line 1 "x\cba\addons\events\fnc_addEventHandler.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_addEventHandler.sqf"
scriptName 'cba\events\addEventHandler';

[{
params [["_eventName", "", [""]], ["_eventFunc", nil, [{}]]];

if (_eventName isEqualTo "" || isNil "_eventFunc") exitWith {-1};

private _events = cba_events_eventNamespace getVariable _eventName;
private _eventHash = cba_events_eventHashes getVariable _eventName;


if (isNil "_events") then {
_events = [];
cba_events_eventNamespace setVariable [_eventName, _events];

_eventHash = [[], -1] call CBA_fnc_hashCreate;
cba_events_eventHashes setVariable [_eventName, _eventHash];
};

private _internalId = _events pushBack _eventFunc;


private _eventId = [_eventHash, "#lastId"] call CBA_fnc_hashGet;
_eventId = (_eventId) + 1;

[_eventHash, "#lastId", _eventId] call CBA_fnc_hashSet;
[_eventHash, _eventId, _internalId] call CBA_fnc_hashSet;

_eventId
}, _this] call CBA_fnc_directCall;

};

cba_fnc_removeEventHandler = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_removeEventHandler'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_removeEventHandler';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_removeEventHandler.sqf [CBA_fnc_removeEventHandler]"
#line 1 "x\cba\addons\events\fnc_removeEventHandler.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_removeEventHandler.sqf"
scriptName 'cba\events\removeEventHandler';

params [["_eventName", "", [""]], ["_eventId", -1, [0]]];

{
if (_eventId < 0) exitWith {};

private _events = cba_events_eventNamespace getVariable _eventName;
private _eventHash = cba_events_eventHashes getVariable _eventName;

if (isNil "_events") exitWith {};

private _internalId = [_eventHash, _eventId] call CBA_fnc_hashGet;

if (_internalId != -1) then {
_events deleteAt _internalId;
[_eventHash, _eventId] call CBA_fnc_hashRem;


[_eventHash, {
if (_value > _internalId && {!(_key isEqualTo "#lastId")}) then {
[_eventHash, _key, _value - 1] call CBA_fnc_hashSet;
};
}] call CBA_fnc_hashEachPair;
};
} call CBA_fnc_directCall;

nil

};

cba_fnc_localEvent = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_localEvent'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_localEvent';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_localEvent.sqf [CBA_fnc_localEvent]"
#line 1 "x\cba\addons\events\fnc_localEvent.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_localEvent.sqf"
scriptName 'cba\events\localEvent';

params [["_eventName", "", [""]], ["_params", []]];

{    if !(isNil "_x") then {        _params call _x;    };} forEach +([cba_events_eventNamespace getVariable _eventName] param [0, []])  

};

cba_fnc_serverEvent = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_serverEvent'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_serverEvent';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_serverEvent.sqf [CBA_fnc_serverEvent]"
#line 1 "x\cba\addons\events\fnc_serverEvent.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_serverEvent.sqf"
scriptName 'cba\events\serverEvent';

params [["_eventName", "", [""]], ["_params", []]];

if (isServer) then {
{    if !(isNil "_x") then {        _params call _x;    };} forEach +([cba_events_eventNamespace getVariable _eventName] param [0, []]) ;
} else {
CBAs = [_eventName, _params]; publicVariableServer "CBAs";
};

nil

};

cba_fnc_targetEvent = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_targetEvent'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_targetEvent';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_targetEvent.sqf [CBA_fnc_targetEvent]"
#line 1 "x\cba\addons\events\fnc_targetEvent.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_targetEvent.sqf"
scriptName 'cba\events\targetEvent';

params [["_eventName", "", [""]], ["_params", []], ["_targets", objNull, [objNull, grpNull, []]]];

if !(_targets isEqualType []) then {
_targets = [_targets];
};

private _remoteTargets = _targets select {!local (if (_x isEqualType grpNull) then {leader _x} else {_x})};


if (count _targets > count _remoteTargets) then {
{    if !(isNil "_x") then {        _params call _x;    };} forEach +([cba_events_eventNamespace getVariable _eventName] param [0, []]) ;
};


if (_remoteTargets isEqualTo []) exitWith {};

if (isServer) then {
private _sentOwners = [];

{
private _owner = owner (if (_x isEqualType grpNull) then {leader _x} else {_x});


if !(_owner in _sentOwners) then {
_sentOwners pushBack _owner;
CBAs = [_eventName, _params]; _owner publicVariableClient "CBAs";
};
} forEach _remoteTargets;
} else {

CBAu = [_eventName, _params, _remoteTargets]; publicVariableServer "CBAu";
};

nil

};

cba_fnc_ownerEvent = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_ownerEvent'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_ownerEvent';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_ownerEvent.sqf [CBA_fnc_ownerEvent]"
#line 1 "x\cba\addons\events\fnc_ownerEvent.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_ownerEvent.sqf"
scriptName 'cba\events\ownerEvent';

params [["_eventName", "", [""]], ["_params", []], ["_targetOwner", -1, [0]]];
;

if (_targetOwner == 2) then { 
if (isServer) then {

{    if !(isNil "_x") then {        _params call _x;    };} forEach +([cba_events_eventNamespace getVariable _eventName] param [0, []]) ;
} else {


CBAs = [_eventName, _params]; publicVariableServer "CBAs";
};
} else {
if (CBA_clientID == _targetOwner) then {


{    if !(isNil "_x") then {        _params call _x;    };} forEach +([cba_events_eventNamespace getVariable _eventName] param [0, []]) ;
} else {

CBAs = [_eventName, _params]; _targetOwner publicVariableClient "CBAs";
};
};

nil

};

cba_fnc_globalEvent = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_globalEvent'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_globalEvent';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\events\fnc_globalEvent.sqf [CBA_fnc_globalEvent]"
#line 1 "x\cba\addons\events\fnc_globalEvent.sqf"
#line 1 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\events\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 14 "x\cba\addons\events\script_component.hpp"
#line 1 "a3\editor_f\Data\Scripts\dikCodes.h"
#line 38 "x\cba\addons\events\script_component.hpp"
#line 2 "x\cba\addons\events\fnc_globalEvent.sqf"
scriptName 'cba\events\globalEvent';

params [["_eventName", "", [""]], ["_params", []]];

{    if !(isNil "_x") then {        _params call _x;    };} forEach +([cba_events_eventNamespace getVariable _eventName] param [0, []]) ;
CBAs = [_eventName, _params]; publicVariable "CBAs";

nil

};

cba_fnc_addPerFrameHandler = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_addPerFrameHandler'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_addPerFrameHandler';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_addPerFrameHandler.sqf [CBA_fnc_addPerFrameHandler]"
#line 1 "x\cba\addons\common\fnc_addPerFrameHandler.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_addPerFrameHandler.sqf"
params [["_function", {}, [{}]], ["_delay", 0, [0]], ["_args", []]];

if (_function isEqualTo {}) exitWith {-1};

if (isNil "cba_common_PFHhandles") then {
cba_common_PFHhandles = [];
};

if (count cba_common_PFHhandles >= 999999) exitWith {
format ['[%1] (%2) %3: %4', toUpper 'cba', 'common', 'WARNING', format ['%1 %2:%3', "Maximum amount of per frame handlers reached!", "x\cba\addons\common\fnc_addPerFrameHandler.sqf", 38 + 1]] call CBA_fnc_log;
diag_log _function;
-1
};

private _handle = cba_common_PFHhandles pushBack count cba_common_perFrameHandlerArray;

cba_common_perFrameHandlerArray pushBack [_function, _delay, diag_tickTime, diag_tickTime, _args, _handle];

_handle

};

cba_fnc_removePerFrameHandler = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_removePerFrameHandler'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_removePerFrameHandler';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_removePerFrameHandler.sqf [CBA_fnc_removePerFrameHandler]"
#line 1 "x\cba\addons\common\fnc_removePerFrameHandler.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_removePerFrameHandler.sqf"
params [["_handle", -1, [0]]];

if (_handle < 0 || {_handle >= count cba_common_PFHhandles}) exitWith {};

[{
params ["_handle"];

cba_common_perFrameHandlerArray deleteAt (cba_common_PFHhandles select _handle);
cba_common_PFHhandles set [_handle, nil];

{
_x params ["", "", "", "", "", "_handle"];
cba_common_PFHhandles set [_handle, _forEachIndex];
} forEach cba_common_perFrameHandlerArray;
}, _handle] call CBA_fnc_directCall;

nil

};

cba_fnc_execNextFrame = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_execNextFrame'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_execNextFrame';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_execNextFrame.sqf [CBA_fnc_execNextFrame]"
#line 1 "x\cba\addons\common\fnc_execNextFrame.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_execNextFrame.sqf"
params [["_function", {}, [{}]], ["_args", []]];

if (diag_frameno != cba_common_nextFrameNo) then {
cba_common_nextFrameBufferA pushBack [_args, _function];
} else {
cba_common_nextFrameBufferB pushBack [_args, _function];
};

};

cba_fnc_waitUntilAndExecute = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_waitUntilAndExecute'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_waitUntilAndExecute';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_waitUntilAndExecute.sqf [CBA_fnc_waitUntilAndExecute]"
#line 1 "x\cba\addons\common\fnc_waitUntilAndExecute.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_waitUntilAndExecute.sqf"
params [
["_condition", {}, [{}]],
["_statement", {}, [{}]],
["_args", []],
["_timeout", -1, [0]],
["_timeoutCode", {}, [{}]]
];

if (_timeout < 0) then {
cba_common_waitUntilAndExecArray pushBack [_condition, _statement, _args];
} else {
cba_common_waitUntilAndExecArray pushBack [{
params ["_condition", "_statement", "_args", "_timeout", "_timeoutCode", "_startTime"];

if (CBA_missionTime - _startTime > _timeout) exitWith {
_args call _timeoutCode;
true
};
if (_args call _condition) exitWith {
_args call _statement;
true
};
false
}, {}, [_condition, _statement, _args, _timeout, _timeoutCode, CBA_missionTime]];
};

nil

};

cba_fnc_waitAndExecute = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_waitAndExecute'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_waitAndExecute';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_waitAndExecute.sqf [CBA_fnc_waitAndExecute]"
#line 1 "x\cba\addons\common\fnc_waitAndExecute.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_waitAndExecute.sqf"
params [["_function", {}, [{}]], ["_args", []], ["_delay", 0, [0]]];

cba_common_waitAndExecArray pushBack [CBA_missionTime + _delay, _function, _args];
cba_common_waitAndExecArrayIsSorted = false;

};

CBA_fnc_directCall = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_directCall'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_directCall';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\common\fnc_directCall.sqf [CBA_fnc_directCall]"
#line 1 "x\cba\addons\common\fnc_directCall.sqf"
#line 1 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\common\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 13 "x\cba\addons\common\script_component.hpp"
#line 2 "x\cba\addons\common\fnc_directCall.sqf"
params [["_CBA_code", {}, [{}]], ["_this", []]];

private "_CBA_return";

isNil {

_CBA_return = ([_x] apply {call _CBA_code}) select 0;
};

if (!isNil "_CBA_return") then {_CBA_return};

};

cba_fnc_hashSet = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_hashSet'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_hashSet';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\hashes\fnc_hashSet.sqf [CBA_fnc_hashSet]"
#line 1 "x\cba\addons\hashes\fnc_hashSet.sqf"
#line 1 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 12 "x\cba\addons\hashes\script_component.hpp"
#line 3 "x\cba\addons\hashes\fnc_hashSet.sqf"
#line 1 "x\cba\addons\hashes\script_hashes.hpp"
#line 4 "x\cba\addons\hashes\fnc_hashSet.sqf"
scriptName 'cba\hashes\hashSet';


params [["_hash", [], [[]]], "_key", "_value"];

if (isNil "_key") exitWith {_hash};
if (isNil "_hash") exitWith {_hash};


private _isDefault = false;

private _default = _hash select 3;

if (isNil "_default") then {
_isDefault = isNil "_value";
} else {
if (!isNil "_value") then {
_isDefault = _value isEqualTo _default;
};
};

private _index = (_hash select 1) find _key;

if (_index >= 0) then {
if (_isDefault) then {


private _keys = _hash select 1;
private _values = _hash select 2;

_keys deleteAt _index;
_values deleteAt _index;
} else {

;
(_hash select 2) set [_index, if (isNil "_value") then {nil} else {_value}];
};
} else {

if !(_isDefault) then {
_hash select 1 pushBack _key;
_hash select 2 pushBack _value;
};
};

;
_hash 

};

cba_fnc_hashGet = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_hashGet'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_hashGet';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\hashes\fnc_hashGet.sqf [CBA_fnc_hashGet]"
#line 1 "x\cba\addons\hashes\fnc_hashGet.sqf"
#line 1 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 12 "x\cba\addons\hashes\script_component.hpp"
#line 3 "x\cba\addons\hashes\fnc_hashGet.sqf"
#line 1 "x\cba\addons\hashes\script_hashes.hpp"
#line 4 "x\cba\addons\hashes\fnc_hashGet.sqf"
scriptName 'cba\hashes\hashGet';


params [["_hash", [], [[]]], "_key"];

private _index = (_hash select 1) find _key;

if (_index >= 0) then {
(_hash select 2) select _index 
} else {
private _default = param [2, _hash select 3];

if (isNil "_default") then {
nil 
} else {

if (_default isEqualType []) then {
_default = + _default;
};
_default 
};
};

};

CBA_fnc_hashRem = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_hashRem'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_hashRem';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\hashes\fnc_hashRem.sqf [CBA_fnc_hashRem]"
#line 1 "x\cba\addons\hashes\fnc_hashRem.sqf"
#line 1 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 12 "x\cba\addons\hashes\script_component.hpp"
#line 3 "x\cba\addons\hashes\fnc_hashRem.sqf"
#line 1 "x\cba\addons\hashes\script_hashes.hpp"
#line 4 "x\cba\addons\hashes\fnc_hashRem.sqf"
scriptName 'cba\hashes\hashRem';


params [["_hash", [], [[]]], "_key"];

private _defaultValue = _hash select 3;
[_hash, _key, if (isNil "_defaultValue") then {nil} else {_defaultValue}] call CBA_fnc_hashSet;

_hash 

};

CBA_fnc_hashEachPair = {

	private _fnc_scriptNameParent = if (isNil '_fnc_scriptName') then {'CBA_fnc_hashEachPair'} else {_fnc_scriptName};
	private _fnc_scriptName = 'CBA_fnc_hashEachPair';
	scriptName _fnc_scriptName;

#line 1 "\x\cba\addons\hashes\fnc_hashEachPair.sqf [CBA_fnc_hashEachPair]"
#line 1 "x\cba\addons\hashes\fnc_hashEachPair.sqf"
#line 1 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_mod.hpp"
#line 2 "x\cba\addons\hashes\script_component.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 1 "x\cba\addons\main\script_macros_common.hpp"
#line 1 "x\cba\addons\main\script_macros.hpp"
#line 12 "x\cba\addons\hashes\script_component.hpp"
#line 3 "x\cba\addons\hashes\fnc_hashEachPair.sqf"
#line 1 "x\cba\addons\hashes\script_hashes.hpp"
#line 4 "x\cba\addons\hashes\fnc_hashEachPair.sqf"
scriptName 'cba\hashes\hashEachPair';


params [["_hash", [], [[]]], ["_code", {}, [{}]]];

_hash params ["", "_keys", "_values"];

{
private _key = _x;
private _value = _values select _forEachIndex;
;
call _code;
} forEach _keys;

nil 

};
