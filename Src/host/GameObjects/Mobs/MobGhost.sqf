// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\text.hpp"
#include "..\GameConstants.hpp"
#include "..\..\ServerRpc\serverRpc.hpp"
#include <..\..\Networking\Network.hpp>

class(MobGhost) extends(BasicMob)

	getter_func(isGameplayGhost,true); //персонаж для игровых призраков. для обсерверов флаг выключен

	var(voiceType,"ghost");
	
	//["ghost","inputedsignlang","onActGhost"] call ie_actions_regNew;
	
	["ghost","returnlobby","onActGhost"] call ie_actions_regNew;
	["ghost","tolobby","onActGhost"] call ie_actions_regNew;
	["ghost","getdeadtime","onActGhost"] call ie_actions_regNew;
	
	func(onActGhost)
	{
		objParams();
		"ghost" call ie_action_setPrefix;
		
		if (["tolobby"] call ie_action_check) exitWith {
			private _event = {
				
				callFuncParams(getSelf(client),localSay,format vec2("<t size='1.5' font='Ringbear' color='#5959FF'>И наступила благодатная тьма для %1...</t>",getSelf(deadWhoName)));
				
				callSelf(CloseMessageBox);
				[this,"LobbyAndDestroy"] call cm_switchToMob;
			};
			private _mcan = pick["Ещё понаблюдаю","Дела не закончены","Я не готов","За живыми нужно присмотреть"];
			callSelfParams(ShowMessageBox,"MessageBox" arg ["<t size='1.4'>Вы уверены что хотите навсегда покинуть этот мир?</t>" arg "ДА" arg _mcan] arg _event);
		};
		if (["returnlobby"] call ie_action_check) exitWith {
			private _event = {
				callSelf(CloseMessageBox);
				[this,"LobbyAndDestroy"] call cm_switchToMob;
			};
			callSelfParams(ShowMessageBox,"MessageBox" arg ["<t size='1.4'>Вы уверены?</t>" arg "Да" arg "Нет"] arg _event);
		};
		if (["getdeadtime"] call ie_action_check) exitWith {
			callSelf(printTimeoutInfo);
		};
	};
	
	var(deadWhoName,"неизвестного");
	
	var(__listactions,[]); //у госта нет действий
	func(syncGhostVisualWithTarget)
	{
		objParams_1(_src);
		
		setSelf(deadWhoName,callFuncParams(_src,getNameEx,"кого"));
		
		private _armaMob = getVar(_src,owner);
		private _myPlayer = getSelf(owner);
		//slots (arma side)
		private _uni = uniform _armaMob;
		if (_uni == "") then {
			//возможный фикс сетевого лага когда призрак копирует персонажа без одежды
			_myPlayer forceAddUniform "U_I_pilotCoveralls";
			nextFrameParams({removeUniform _this},_myPlayer);
			//removeUniform _myPlayer;
		} else {
			_myPlayer forceAddUniform _uni;
		};
		_myPlayer addBackpackGlobal (backpack _armaMob);
		_myPlayer addGoggles (goggles _armaMob);
		_myPlayer addHeadgear (headgear _armaMob);
		//smd slots (relicta side)
		{
			_item = callFuncParams(_src,getItemInSlot,_x);
			_m = if isNullReference(_item) then {0} else {
				[getVar(_item,model),[callFunc(_item,getHandAnim),callFunc(_item,getCombAnim)]]
			};
			callSelfParams(syncSmdVar,"s"+str _x arg _m);
		} foreach INV_LIST_ALL;
		//body parts
		private _bpArray = getVar(_src,bodyParts);
		#define hasBP(idx) !isNullObject(_bpArray getOrDefault [idx arg nullPtr])
		private _list = [hasBP(BP_INDEX_ARM_R),hasBP(BP_INDEX_ARM_L),hasBP(BP_INDEX_LEG_R),hasBP(BP_INDEX_LEG_L)];
		netSyncObjVar(_myPlayer,"smd_bodyParts",_list);
		if (!callSelf(isPlayer)) then {
			// sync anim if not playable mob
			private _isBodyPartsChanged = true;
			[_myPlayer] call anim_syncAnim;
		};
		
	};
	
	func(initAsActor)
	{
		objParams_1(_playerObject);
		super();
		#ifndef EDITOR
		//temporary ghost hiding on serverside
		_playerObject hideObject true;
		#endif

		if callSelf(isGameplayGhost) then {

			callSelfParams(addVisualState,"VST_GHOST_EFFECT");

			callSelfParams(addAction,"Призрак" arg "Время?" arg "ghost_getdeadtime");

		};
	};
	
	var(clientConnected,false);
	
	func(onConnected)
	{
		objParams();
		super();
		//выключение инвентаря
		callSelfParams(sendInfo,"invsetglobvis" arg false);
		callSelfParams(fastSendInfo,"interactMenu_disableGlobal" arg true);
		callSelfParams(fastSendInfo,"interactCombat_disableGlobal" arg true);

		setSelf(clientConnected,true);
		
		if callSelf(isGameplayGhost) then {
			
			callSelfParams(localEffectUpdate,"GhostNightVision");
			callSelfParams(localEffectUpdate,"GhostPostprocess");

			//Это ОЧЕНЬ временное решение для гостов
			callSelf(printTimeoutInfo);
			
			private _ctx = [["repeat",0],["wait",false],["smooth",0]];
			callSelfParams(playMusic,"dead\Burgundian-Lullaby.ogg" arg "MUSIC_CHANNEL_AMBIENT" arg _ctx);
		};

	};
	
	func(onDisconnected)
	{
		objParams();
		super();
		//рестор инвентаря после выхода с госта инвентаря
		callSelfParams(sendInfo,"invsetglobvis" arg true);
		callSelfParams(fastSendInfo,"interactMenu_disableGlobal" arg false);
		callSelfParams(fastSendInfo,"interactCombat_disableGlobal" arg false);
		
		setSelf(clientConnected,false);
	};
	
	func(ghostBreakThroughDoor)
	{
		objParams_1(_door);
		if getVar(_door,isOpen) then {
			callFuncParams(this,localSay,"Дверь не закрыта..." arg "error");
		} else {
			private _doorObj = getVar(_door,loc);
			//!error: слишком далеко активировав дверь можно наебнуться за текстуры
			/* use:
			si_rayCast = {
	params ["_rayPosStart","_rayVector",["_retVirtual",false],
			 */
			(_doorObj worldToModel callFunc(this,getPos))params["_x","_y","_z"];
			callFuncParams(this,setPosServer,_doorObj modelToWorld vec3(0,-_y,_z));
		};
	};
	func(mainAction)
	{
		objParams_1(_targ);

		//copypaste from Mob_Interact.sqf
		if isNullReference(_item) exitWith {};
		if (callSelf(getLastInteractDistance)>INTERACT_ITEM_DISTANCE)exitWith {
			//далеко для действия
			//тут можно реализовать onLongMainAction
		};

		if callFunc(_targ,isDoor) exitWith {
			callFuncParams(_targ,onMainAction,this);
		};
		if isTypeOf(_targ,Paper) exitwith {
			callFuncParams(_targ,onMainAction,this);
		};
		if isTypeOf(_targ,TeleportInteractible) exitWith {
			callFuncParams(_targ,onMainAction,this);
		};
	};
	
	func(printTimeoutInfo)
	{
		objParams();
		private _client = getSelf(client);
		private _deadTimeout = callFunc(_client,getDeadTimeout);
		private _deadTime = getVar(_client,lastDeadTime);
		if (_deadTime > 0 && {(_deadTime+_deadTimeout)>tickTime}) then {
			private _timeToPick = round((_deadTime+_deadTimeout)-tickTime);
			_timeToPick = [_timeToPick,["секунду","секунды","секунд"],true] call toNumeralString;
			callFuncParams(_client,localSay,format vec2("<t size='1.5' font='Ringbear' color='#FF5C00'>Упокоение наступит через %1</t>",_timeToPick));
		};
	};
	var(__lastPrintMes,0);
	func(onUpdate)
	{
		updateParams();
		if getSelf(clientConnected) then {
			//Это ОЧЕНЬ временное решение для гостов
			private _client = getSelf(client);
			private _deadTimeout = callFunc(_client,getDeadTimeout);
			private _deadTime = getVar(_client,lastDeadTime);
			if (_deadTime > 0 && {(_deadTime+_deadTimeout)>tickTime}) then {
				//private _timeToPick = round((_deadTime+_deadTimeout)-tickTime);
				//
			} else {
				if !callSelfParams(hasAction,"ghost_tolobby") then {
					callSelfParams(addAction,"Призрак" arg "Упокоиться" arg "ghost_tolobby");
				};
				if (tickTime >= getSelf(__lastPrintMes)) then {
					setSelf(__lastPrintMes,tickTime + randInt(30,60));
					callFuncParams(_client,localSay,"Вы можете упокоиться" arg "system");
				};
			};
		};
	};
	func(onFalling)
	{
		objParams_1(_ctx);
		//гост не падает
	};
	func(handle_falling)
	{
		updateParams();
		//хандлер фаллигна выключен
	};
	func(getDescFor)
	{
		objParams_1(_usr);
		format["Это %1. Он выглядит покинутым.",callSelfParams(getNameEx,"кто")];
	};
	
endclass

class(MobObserver) extends(MobGhost)

	var(isEnabledObserverNightVision,false);

	func(switchNightVision)
	{
		objParams();
		setSelf(isEnabledObserverNightVision,!getSelf(isEnabledObserverNightVision));
		callSelf(syncNightVision);
	};
	func(syncNightVision)
	{
		objParams();
		if getSelf(isEnabledObserverNightVision) then {
			callSelfParams(localEffectUpdate,"GhostNightVision");
		} else {
			callSelfParams(localEffectRemove,"GhostNightVision");
		};
	};

	getter_func(isGameplayGhost,false);

	["admin","cmdLobbyReturn","cmdLobbyReturn"] call ie_actions_regNew;
	["admin","cmdTpTo","cmdTpTo"] call ie_actions_regNew;
	["admin","cmdTpToMe","cmdTpToMe"] call ie_actions_regNew;
	["admin","cmdMindMes","cmdMindMes"] call ie_actions_regNew;

	["admin","cmdcurjobban","cmdHandleAdminCommand"] call ie_actions_regNew;
	["admin","cmdjobban","cmdHandleAdminCommand"] call ie_actions_regNew;
	["admin","cmdjobunban","cmdHandleAdminCommand"] call ie_actions_regNew;
	["admin","cmdshowbans","cmdHandleAdminCommand"] call ie_actions_regNew;

	["admin","cmddoban","cmdHandleAdminCommand"] call ie_actions_regNew;
	["admin","cmdunban","cmdHandleAdminCommand"] call ie_actions_regNew;
	["admin","cmdadminmes","cmdHandleAdminCommand"] call ie_actions_regNew;

	["admin","nightvision","cmdHandleAdminCommand"] call ie_actions_regNew;
	

	func(initAsActor)
	{
		objParams_1(_actor);
		super();
		//adding lobby return action
		callSelfParams(addAction,"Наблюдатель" arg "Вернуться в лобби" arg "ghost_returnlobby");
		callSelfParams(addAction,"Наблюдатель" arg "Выкинуть игрока в лобби" arg "admin_cmdLobbyReturn");
		callSelfParams(addAction,"Наблюдатель" arg "Телепорт к игроку" arg "admin_cmdTpTo");
		callSelfParams(addAction,"Наблюдатель" arg "Телепорт игрока к себе" arg "admin_cmdTpToMe");

		callSelfParams(addAction,"Наблюдатель" arg "Совесть говорит..." arg "admin_cmdMindMes");
		callSelfParams(addAction,"Наблюдатель" arg "Забанить текущую роль" arg "admin_cmdcurjobban");
		callSelfParams(addAction,"Наблюдатель" arg "Забанить роль" arg "admin_cmdjobban");
		callSelfParams(addAction,"Наблюдатель" arg "Забанить" arg "admin_cmddoban");
		callSelfParams(addAction,"Наблюдатель" arg "Разбан" arg "admin_cmdunban");
		callSelfParams(addAction,"Наблюдатель" arg "Посмотреть баны" arg "admin_cmdshowbans");
		callSelfParams(addAction,"Наблюдатель" arg "Разбанить роль" arg "admin_cmdjobunban");
		callSelfParams(addAction,"Наблюдатель" arg "Админ.сообщение игроку" arg "admin_cmdadminmes");
		callSelfParams(addAction,"Наблюдатель" arg "Ночное зрение" arg "admin_nightvision");
		//callSelfParams(addVisualState,"VST_GHOST_EFFECT" arg ["no_gray"]);

		//очень временное решение инвиза
		callSelfParams(addVisualState,"VST_HUMAN_STEALTH");

		//
	};

	func(cmdHandleAdminCommand)
	{
		objParams();
		"admin" call ie_action_setPrefix;
		if (["nightvision"] call ie_action_check) exitWith {
			callSelf(switchNightVision);
		};
		if (["cmdcurjobban"] call ie_action_check) exitWith {
			[getSelf(owner),"curjobban"] call cm_processClientCommand;
		};
		if (["cmdjobban"] call ie_action_check) exitWith {
			[getSelf(owner),"jobban"] call cm_processClientCommand;
		};
		if (["cmddoban"] call ie_action_check) exitwith {
			[getSelf(owner),"doban"] call cm_processClientCommand;
		};
		if (["cmdunban"] call ie_action_check) exitwith {
			private _h = {
				callSelf(CloseMessageBox);
				[getSelf(owner),"unban " + _value] call cm_processClientCommand;
			};
			callSelfParams(ShowMessageBox,"Input" arg ["Введите ник для разбана" arg "" arg "Разбанить"] arg _h);
		};
		if (["cmdshowbans"] call ie_action_check) exitwith {
			private _h = {
				callSelf(CloseMessageBox);
				[getSelf(owner),"showbans " + _value] call cm_processClientCommand;
			};
			callSelfParams(ShowMessageBox,"Input" arg ["Введите ник для проверки" arg "" arg "Проверка"] arg _h);
		};
		if (["cmdjobunban"] call ie_action_check) exitwith {
			private _h = {
				private _disId = [_value] call db_NickToDisId;
				if (_disId == "") exitwith {
					callSelf(CloseMessageBox);
					callSelfParams(localSay,"Неверное имя" arg "system");
				};
				private _list = [_disId,{
					format["%1 (%2)|%3 %1",
						_jobClass,
						getVar(_jobClass call gm_getRoleObject,name),
						_value
					]
				}] call db_getAllBannedRolesWithDescription;
				private _dat = ["Выберите роль для разбана " +_value + ":"] + _list;
				private _handl = {
					callSelf(CloseMessageBox);
					[getSelf(owner),"roleunban " + _value] call cm_processClientCommand;
				};
				callSelfParams(ShowMessageBox,"Listbox" arg _dat arg _handl);
				
			};
			callSelfParams(ShowMessageBox,"Input" arg ["Введите ник для проверки" arg "" arg "Проверка"] arg _h);
		};
		if (["cmdadminmes"] call ie_action_check) exitWith {
			[getSelf(owner),"adminmes"] call cm_processClientCommand;
		};
	};

	func(cmdLobbyReturn)
	{
		objParams();
		[getSelf(owner),"returnlobby"] call cm_processClientCommand;
	};

	func(cmdTpTo)
	{
		objParams();
		[getSelf(owner),"tpto"] call cm_processClientCommand;
	};
	func(cmdTpToMe)
	{
		objParams();
		[getSelf(owner),"tptome"] call cm_processClientCommand;
	};

	func(cmdMindMes)
	{
		objParams();
		[getSelf(owner),"mindmes"] call cm_processClientCommand;
	};

	func(onUpdate)
	{

	};

	func(onConnected)
	{
		objParams();
		super();
		
		callSelf(syncNightVision);

		callSelfParams(localSay,"<t size='1.5' color='#FF0238'>Для возврата в лобби нажмите соответствующую кнопку в левом меню</t>");

		callSelfParams(fastSendInfo,"vst_human_stealth_allowStepsounds" arg false);
	};

	func(onDisconnected)
	{
		objParams();
		super();
		callSelfParams(fastSendInfo,"vst_human_stealth_allowStepsounds" arg true);
	};

endclass