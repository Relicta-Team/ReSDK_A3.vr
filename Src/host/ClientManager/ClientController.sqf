// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


// ClientController.sqf - Управляет назначением клиентов в мобов

#include <ClientController.hpp>


cm_switchLocality = {
	params ["_unit", "_player"];
	
	#ifdef EDITOR_OR_SP_MODE
	if (true) exitWith {_unit setVariable ["OriginalOwner", owner _unit, true];};
	#endif
	
	_isChanged = _unit setOwner (owner _player);
	if (_isChanged) then {
		_unit setVariable ["OriginalOwner", owner _unit, true]; //setted original owner
	} else {
		if (owner _player == owner _unit) exitWith {};
		errorformat("Cant change owner unit %1; Owner player was %2, unit %3. Player was %4",_unit arg owner _player arg owner _unit arg _player);
	};
}; //rpcAdd("switchLocality",_switchLocality);


cm_setOwner = {
	(_this select 0) setowner (_this select 1);
}; 
//check this fix
rpcAdd("setNewOwner",cm_setOwner);

_connectToMob = {
	params ["_mob","_curClient"];
	#ifndef EDITOR_OR_SP_MODE
	if (typeof _mob != BASIC_MOB_TYPE || typeof _curClient == BASIC_MOB_TYPE) exitWith {
		errorformat("rpc::connectToMob() - Error types: mob::%1; client::%2",typeof _mob arg typeof _curClient);
	};	
	#endif
	[_mob,_curClient] call cm_switchLocality;
}; rpcAdd("connectToMob",_connectToMob);

_disconnectFromMob = {
	params ["_client","_curMob"];
	#ifndef EDITOR_OR_SP_MODE
	if (typeof _client == BASIC_MOB_TYPE || typeof _curMob != BASIC_MOB_TYPE) exitWith {
		errorformat("rpc::disconnectFromMob() - Error types: client::%1; mob::%2",typeof _client arg typeof _curMob);
	};
	#endif
	[_client,_curMob] call cm_switchLocality;
}; rpcAdd("disconnectFromMob",_disconnectFromMob);

_prepareClient = {
	params ["_owner"];
	
	this = _owner call cm_findClientById;
	if isNullReference(this) exitWith {
		rpcSendToClient(_owner,"clientDisconnect",vec2("Ошибка готовности","Клиент с указанным сетевым ID не был найден"));
	};
	
	_mob = getVar(getSelf(actor),link);
	setVar(_mob,client,this);
	//odata = getSelf(actor);
	callFunc(_mob,onConnected);

	cm_allInGamePlayerMobs pushback getVar(_mob,owner);
	netSetGlobal(smd_allInGamePlayerMobs,cm_allInGamePlayerMobs);

	//обновляем счетчик активности региона
	if not_equals(getVar(_mob,__curRegion),"") then {
		[getVar(_mob,__curRegion),+1] call ai_modifyRegionRefCount;
	};
	
}; rpcAdd("prepareClient",_prepareClient);


cm_switchToMob = {
	params ["_oldMob","_newMob",["_destroyOld",false]];
	private _worldMobOld = getVar(_oldMob,owner);
	if isNullReference(_worldMobOld) exitWith {
		errorformat("cm::switchToMob() - old owner null reference %1",_oldMob);
	};
	this = (owner _worldMobOld) call cm_findClientById;
	if isNullReference(this) exitWith {
		errorformat("cm::switchToMob() - null reference client %1",owner _worldMobOld);
	};
	
	callFunc(_oldMob,onDisconnected);
	
	if equals(_newMob,"Ghost") exitWith {
		setVar(this,actor,objnull);

		//ставим трупу инвиз чтобы не улетел
		_worldMobOld enableSimulationGlobal false;

		callFunc(this,unsubAllChunks); //отписываем клиента из чанков
		callFuncParams(this,onChangeState,"lobby");
		private _event = {
			//код здесь по сути копирует спавнер от клиента
			getSelf(ctxOnRequestNextMob) params ["_mob","_worldMobOld"];
			_ghostRole = "GhostRole" call gm_getroleobject;
			_pos = callFunc(_mob,getPos) vectorAdd vec3(pick vec2(-.1,.1),pick vec2(-.1,.1),0);
			if callFunc(_mob,isConnected) then {
				private _seatPos = callFuncParams(getVar(_mob,connectedTo),getSeatRestPos,_mob);
				if !isNullVar(_seatPos) then {
					_pos = _seatPos;
				};
			};
			setVar(_ghostRole,lastSpawnpos,_pos);
			private _map = [
				["gender",getVar(_mob,gender)],
				["name",""],
				["age",getVar(_mob,age)],
				["face",getVar(_mob,face)]
			] call gm_initHashMapCharSettings;
			_ghost = [this,"GhostRole",false,_map] call gm_spawnClientToRole;
			(callFuncParams(_mob,getNameEx,"кого") splitString " ")params [["_f","призрак"],["_s","Дохлый"]];
			callFuncParams(_ghost,generateNaming,"Призрак "+_f arg _s);
			callFuncParams(_ghost,syncGhostVisualWithTarget,_mob);

			//убираем инвиз у трупа
			invokeAfterDelayParams({_this enableSimulationGlobal true},2,_worldMobOld);
		};
		setSelf(ctxOnRequestNextMob,[_oldMob arg _worldMobOld]);
		setSelf(delegate_onRequestNextMob,_event);
		
		private _id = getSelf(id);
		rpcSendToClient(_id,"onPlayingEnd",[_worldMobOld arg CONNECTION_ACTION_AWAITSWITCH]);

	};
	if (equals(_newMob,"Lobby") || equals(_newMob,"LobbyAndDestroy")) exitWith {
		// Возвращаем клиента в лобби	
		setVar(this,actor,objnull);
	
		callFunc(this,unsubAllChunks); //отписываем клиента из чанков
		callFuncParams(this,onChangeState,"lobby");
		
		private _action = ifcheck(equals(_newMob,"Lobby"),CONNECTION_ACTION_OPENLOBBY,CONNECTION_ACTION_OPENLOBBY_AND_DELMOB);
		
		if equals(_newMob,"LobbyAndDestroy") then {
			//моб будет удален когда клиент запросит лобби
			//в этот момент он точно уже будет отсоединён от него
			setVar(this,__internal_destrMob,_oldMob);
		};
		
		callFuncParams(_oldMob,sendInfo,"onPlayingEnd" arg [_worldMobOld arg _action]);
	};
	
	setVar(this,actor,objnull);
	callFunc(this,unsubAllChunks); //отписываем клиента из чанков
	callFuncParams(this,onChangeState,"lobby");
	private _event = {
		//код здесь по сути копирует спавнер от клиента
		getSelf(ctxOnRequestNextMob) params ["_old","_new","_client","_destroyOld"];
		private _playerObject = getVar(_new,owner);
		
		setVar(_client,actor,_playerObject);
		callFuncParams(_client,onChangeState,"ingame");
		//После полной инициализации клиента можно и подгрузить позицию
		private _initialPos = callFunc(_new,getPos);
		
		traceformat("switching client %1 from %2 to %3",getVar(_client,name) arg getVar(_old,pointer) arg getVar(_new,pointer))
		rpcSendToClient(callFunc(_client,getOwner),"prepPlayerPos",vec2(_initialPos,_playerObject));

		if (_destroyOld) then {
			callFunc(_old,__destroyImpl);
		};
	};
	setSelf(ctxOnRequestNextMob,[_oldMob arg _newMob arg this arg _destroyOld]);
	setSelf(delegate_onRequestNextMob,_event);
	
	private _id = getSelf(id);
	rpcSendToClient(_id,"onPlayingEnd",[_worldMobOld arg CONNECTION_ACTION_AWAITSWITCH]);
	
};