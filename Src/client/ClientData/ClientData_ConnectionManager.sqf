// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(clientData,client_;cd_)

macro_const(cd_preparePlayerPosTimeout)
#define PREPARE_PLAYER_POS_TIMEOUT 120

macro_const(cd_switchPlayerTimeout)
#define SWITCH_PLAYER_TIMEOUT 30

#include <..\..\host\ClientManager\ClientController.hpp>

decl(string)
client_state = "init";
decl(string())
client_getState = {client_state};
decl(string(string))
client_setState = {client_state = _this};
decl(bool())
client_isInGame = {client_state == "game"};
decl(bool())
client_isInLobby = {client_state == "lobby"};

// Подготавливает позицию персонажа для спавна
decl(void(vector3;actor))
cd_prepPlayerPos = {
	params ["_pos","_mob"];

	if !(call noe_client_isEnabled) then {
		call noe_client_startListening;
	};
	//_pos set [2,1]; //to grounded

	player setposatl _pos;

	startAsyncInvoke
		{
			params ["_pos"];

			player setPosATL _pos;

			call noe_client_isPlayerPositionChunksLoaded;
		},
		{
			params ["_pos","_connectionMob"];

			//rpcSendToServer(_callBackRPC,[clientOwner]);
			[_connectionMob,CONNECTION_ACTION_PREPARECLIENT] call cd_connectToMob;
		},
		[_pos,_mob],
		PREPARE_PLAYER_POS_TIMEOUT,
		{
			rpcCall("clientDisconnect",vec2("Ошибка загрузки позиции","Позиция не была загружена за отведённое время"));
		}
	endAsyncInvoke

}; rpcAdd("prepPlayerPos",cd_prepPlayerPos);

// Внутренний интрфейс подключения к мобу или безголовому клиенту
decl(void(bool;actor;int))
cd_processConnection = {
	params ["_isLinkTo","_mob","_prepareNextMode"];

	private _curUnit = if (_isLinkTo) then {clientMob} else {player};
	private _newUnit = if (_isLinkTo) then {_mob} else {clientMob};

	private _rpcType = if (_isLinkTo) then {"connectToMob"} else {"disconnectFromMob"};

	rpcSendToServer(_rpcType,vec2(_newUnit,_curUnit));

	trace("start switching handle");

	startAsyncInvoke
		{
			params ["_newMob"];
			local _newMob;
		},
		{
			params ["_newMob","_oldMob","_action","_isLinkTo"];

			_lastPos = getposatl _oldMob;

			selectPlayer _newMob;

			// Делаем принудительное обновление smd слотов по сети
			// Данное действие выполняется из-за того, что при селектинге юнита голова устанавливается из профиля
			if (_isLinkTo) then {
				_newMob setVariable ["__smd_lastUpdate",tickTime,true];
			} else {
				_oldMob setVariable ["__smd_lastUpdate",tickTime,true];
			};

			_oldOwner = _oldMob getVariable ["OriginalOwner",-1];
			if (_oldOwner > -1) then {
				rpcSendToServer("setNewOwner",vec2(_oldMob,_oldOwner));
			};
			_oldMob setposatl _lastPos;
			
			//стандартная локальная функция возврата в игру
			private _returnFromGameImpl = {
				if (call noe_client_isEnabled) then {
					if (_isLinkTo) exitWith {
						error("cd::processConnection() - Cant stop listening NOE. Is not disconnect action");
					};
					[_oldMob] call noe_client_stopListening;
				};

				//остановить SMD
				call smd_stopUpdate;

				//выгрузить визуальные эффекты
				[_oldMob] call smd_unloadVST;

				//остановить GF
				call gf_stop;

				//остановить onesync services
				call os_stop;

				call vs_disconnectVoiceSystem;

				call vs_audio_releaseAllSounds; //stop all sounds

				//остановка пакетирования атмоса
				[false] call noe_client_nat_setEnabled;
				
				//перезагрузка постпроцессора
				[false] call pp_reload;
				
				//отключение тряски камеры
				call cam_camShake_resetAll;
				
				//восстановление стамины
				cd_stamina_cur = 100;
				cd_stamina_max = 100;
				
				//Сброс бессознанки
				cd_isUnconscious = false;
				
				//Сброс forcewalk: Fix 0.7.598 
				// - когда моб заходит в сущность если smd_bodyParts не реплицирована, то данные не синхронизируются: моб с ногами не может бегать
				cd_fw_forceWalk = false;

				//Сброс эмоут индекса
				interactEmote_curTabIdx = 0;
				
				//сброс худа
				call hud_cleanup;
			};
			
			switch (_action) do {
			    case CONNECTION_ACTION_PREPARECLIENT: {
					_oldMob setPosATL [0,0,0]; //Уже после назначения на нужную нам позицию безголовый не нужен

					rpcSendToServer("prepareClient",[clientOwner]);
				};
				case CONNECTION_ACTION_OPENLOBBY: { //стейт возврата из игры в лобби

					call _returnFromGameImpl;

					rpcSendToServer("RequestOpenLobby",[clientOwner]);
				};
				case CONNECTION_ACTION_OPENLOBBY_AND_DELMOB: {//стейт возврата из игры в лобби с удалением игрового моба
					call _returnFromGameImpl;

					rpcSendToServer("RequestOpenLobby",[clientOwner arg true]);
				};
				case CONNECTION_ACTION_AWAITSWITCH: { //стейт ожидания смены моба
					call _returnFromGameImpl;
					rpcSendToServer("RequestNextMob",[clientOwner]);
				};
				default {
					// В идеале это исключение не должно выпадать никогда.
					errorformat("cd::processConnection() - Cant find action enum: %1",_action);
					rpcCall("clientDisconnect",vec2("Ошибка подключения","Неизвестное действие..."));
				};
			};
		},
		[_newUnit,_curUnit,_prepareNextMode,_isLinkTo],
		SWITCH_PLAYER_TIMEOUT,
		{
			rpcCall("clientDisconnect",vec2("Ошибка загрузки игрока","Не удалось изменить игрового актера за отведённое время"));
		}
	endAsyncInvoke
};

//Подключаемся к мобу
decl(void(actor;int))
cd_connectToMob = {
	params ["_mob",["_nextAction",-1]];

	[true,_mob,_nextAction] call cd_processConnection;
};

decl(void(actor;int))
cd_onPlayingEnd = {
	params ["_mob",["_nextAction",-1]];

	[false,_mob,_nextAction] call cd_processConnection;

}; rpcAdd("onPlayingEnd",cd_onPlayingEnd);
