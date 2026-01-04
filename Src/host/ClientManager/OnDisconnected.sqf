// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//params ["_unit", "_id", "_uid", "_name"]; (only for HandleDisconnect)

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

// cleanup owners
{
	if (owner _x in [2,_owner]) then {deletevehicle _x};
} foreach (entities [["I_VirtualCurator_F"],[]]);

_cli = _owner call cm_findClientById;
if !isNullReference(_cli) then {
	//errorformat("ClientManager::OnDisconnected() - Cant find client by id %1",_owner);
	
	//getting client mob
	_mob = getVar(_cli,actor) getVariable "link";
	if (!isNullVar(_mob) && {!isNullReference(_mob)}) then {
		callFunc(_mob,onDisconnected);

		private _mobIndex = cm_allInGamePlayerMobs find getVar(_mob,owner);
		if (_mobIndex >= 0) then {
			cm_allInGamePlayerMobs deleteAt _mobIndex;
			netSetGlobal(smd_allInGamePlayerMobs,cm_allInGamePlayerMobs);
		};
	};

	//удаляем клиента из всех его ролей
	callFunc(_cli,onFinalize);
	//delete(_cli)
};

logger_client("Client disconnected. Owner %1; UID:%2; ID %3",_owner arg _uid arg _id);

//удаляем клиента из списка преавайтеров если есть
_pwData = cm_preAwaitClientData get _owner;
if !isNullVar(_pwData) then {
	_pwData setv(cancelToken,true); //do nothing on timeout
	cm_preAwaitClientData deleteAt _owner;
};

//удаляем запись из cm_map_ownerToDisIdAssoc
cm_map_ownerToDisIdAssoc deleteAt _owner;
