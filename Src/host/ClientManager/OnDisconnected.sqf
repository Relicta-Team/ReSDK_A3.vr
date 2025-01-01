// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//params ["_unit", "_id", "_uid", "_name"]; (only for HandleDisconnect)

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

// cleanup owners
{
	if (owner _x in [2,_owner]) then {deletevehicle _x};
} foreach (entities [["I_VirtualCurator_F"],[]]);

_cli = _owner call cm_findClientById;
if equals(_cli,nullPtr) exitWith {
	errorformat("ClientManager::OnDisconnected() - Cant find client by id %1",_owner);
};

//getting client mob
_mob = getVar(_cli,actor) getVariable "link";
if (!isNullVar(_mob) && {!isNullReference(_mob)}) then {
	callFunc(_mob,onDisconnected);
};


logger_client("Client disconnected. Owner %1; UID:%2; ID %3",_owner arg _uid arg _id);

//удаляем клиента из списка преавайтеров если есть
_indPreAwait = cm_preAwaitClientData findIf {equals(_x select 0,_owner)};
if (_indPreAwait != -1) then {cm_preAwaitClientData deleteAt _indPreAwait};

//удаляем клиента из всех его ролей
callFunc(_cli,onFinalize);
//delete(_cli)
