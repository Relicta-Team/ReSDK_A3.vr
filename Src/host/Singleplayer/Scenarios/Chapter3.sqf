// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"
cpt3_hudvis_default = "right+stats+cursor+inv";
cpt3_hudvis_eaterzone = cpt3_hudvis_default + "+left";
["cpt3_begin",{
	
	["cpt3_pos_start",0] call sp_setPlayerPos;
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	[false,1.5] call setBlackScreenGUI;

	if (!callFuncParams(call sp_getActor,hasItem,"Torch" arg true)) then {
		["Torch",call sp_getActor] call createItemInInventory;
	};

	//create deadbody
	_posDeadbody = callFunc("cpt3_pos_deadbody_looting" call sp_getObject,getPos);
	_body = [_posDeadbody,null,"cpt3_deadbody"] call sp_ai_createPerson;
	_mob = _body getvariable "link";

	callFuncParams(_mob,generateNaming,"Уба" arg "Бахот");
	setVar(_mob,age,27);

	_cloth = ["NomadCloth10",_mob,INV_CLOTH] call createItemInInventory;
	["Lockpick",_cloth] call createItemInContainer;
	
	callFuncParams(_mob,destroyLimb,BP_INDEX_HEAD);
	callFuncParams(_mob,destroyLimb,BP_INDEX_LEG_L);
	//callFuncParams(_mob,destroyLimb,BP_INDEX_ARM_L);
	callFuncParams(_mob,destroyLimb,BP_INDEX_ARM_R);

	_body switchMove "acts_staticdeath_10";
	_body enablemimics false;

	//make eater
	_eaterBdy = ["cpt3_pos_eaterbase","GMPreyMobEater","cpt3_eater"] call sp_ai_createPerson;
	_eaterBdy setDir (callFunc("cpt3_pos_eaterbase" call sp_getObject,getDir));
	if (!sp_debug) then {
		_eaterBdy hideObject false;
	};
	_eater = _eaterBdy getvariable "link";

	callFuncParams(_eater,generateNaming,"Сонный" arg "Жрун");
	["Castoffs1",_eater,INV_CLOTH] call createItemInInventory;

	_eaterBdy switchmove "ApanPercMstpSnonWnonDnon_G01";


}] call sp_addScene;

["cpt3_trg_katafound",{
	["На подступе","Идите через катакомбы"] call sp_setTaskMessageEff;
}] call sp_addScene;

["cpt3_trg_foundmushrooms",{
	{
		_h = ["В Сети растёт множество разных культур. Чаще всего здесь можно найти ралзичные грибы, в том числе съедобные. Будьте осторожны и не ешьте неизвестные вам грибы."] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_founddeadbody",{
	{
		["Вы можете обыскивать тела людей не проявляющих активности. Например: мертвых, связанных или спящих." + 
		sbr + sbr +
		"Для этого подойдите к телу, нажмите ПКМ и выберите пункт ""Раздеть"". В открывшемся меню инвентаря чужого персонажа нажмите по слоту с предметом. Выбранный предмет будет взят в активную руку."+
		sbr+"Попробуйте снять одежду с трупа и проверьте её карманы."] call sp_setNotification;
		5 call sp_threadPause;
		["На подступе","Обыщите тело"] call sp_setTaskMessageEff;

		["found_lockpick",false] call sp_storageSet;
		_refItm = [{
						
			_wid = widgetNull;
			{
				private _desc = ctrltooltip (_x getvariable "icon");
				if (equals("Отмычка",_desc)) then { //SD_NAME
					_wid = _x getvariable "icon";
					["found_lockpick",true] call sp_storageSet
				};
			} foreach inventory_containerSlots;
			_wid
		},0.02] call sp_createWidgetHighlight;

		{
			["found_lockpick",false] call sp_storageGet;
		} call sp_threadWait;

		_h = ["Заберите отмычку с собой и идите дальше"] call sp_setNotification;

		{
			_itsHands = INV_LIST_HANDS apply {callFuncParams(call sp_getActor,getItemInSlotRedirect,_x)};
			any_of(_itsHands apply {!isNullReference(_x) && isTypeOf(_x,Lockpick)})
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;
		refset(_refItm,true);

		[true] call sp_setHideTaskMessageCtg;

	} call sp_threadStart;
}] call sp_addScene;

["cpt_trg_founddoor",{
	_baseMethod = getFunc("cpt3_obj_lockeddoor" call sp_getObject,onLockpicking);
	["lockpick_method_orig",_baseMethod] call sp_storageSet;

	["На подступе","Взломайте замок двери"] call sp_setTaskMessageEff;
	
	_newmethod = {
		objParams_2(_usr,_lockpick);

		if !getSelf(isLocked) exitWith {
			private _m = pick["Так не закрыто же!","Не заперто.","Зачем взламывать открытое?!?!"];
			callFuncParams(_usr,localSay,_m arg "error");
		};
		if getSelf(isOpen) exitWith {};

		callFuncParams(_usr,mindSay,"Мне удалось взломать замок!");
		callSelfParams(setDoorLock,false arg false);
	};

	[callFunc("cpt3_obj_lockeddoor" call sp_getObject,getClassName),"onLockpicking",_newmethod,"replace"] call oop_injectToMethod;

	{
		{
			!getVar("cpt3_obj_lockeddoor" call sp_getObject,isLocked)
		} call sp_threadWait;

		[
			callFunc("cpt3_obj_lockeddoor" call sp_getObject,getClassName),
			"onLockpicking",
			["lockpick_method_orig",{}] call sp_storageGet,
			"replace"
		] call oop_injectToMethod;

		[true] call sp_setHideTaskMessageCtg;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_searchhide",{

	callFuncParams("cpt3_obj_lockeddoor" call sp_getObject,setDoorOpen,false);
	setVar("cpt3_obj_lockeddoor" call sp_getObject,isLocked,true);

	[cpt3_hudvis_eaterzone] call sp_view_setPlayerHudVisible;
	{
		_lampSrc = "LampCeiling G:Kym4iXFMOZ0 (3)" call sp_getObject;
		
		callFuncParams("cpt3_eater" call sp_ai_getMobObject,playSound,"monster\eater\idle2" arg getRandomPitchInRange(0.8,1.3) arg 20 arg 2.2 arg null arg false);
		sp_playerCanMove = false;
		_m = "Я что-то слышу...";
		callFuncParams(call sp_getActor,mindSay,_m);
		["Вы можете внимательно всматриваться и прислушиваться к окружению, чтобы замечать подозрительные вещи. "
		+sbr+sbr+"Нажмите $input_act_inventory, переместите мышь влево и в выезжающем перейдите в раздел ""восприятие"". "
		+"Попробуйте присмотреться к окружению"] call sp_setNotification;

		["perform_search_action",false] call sp_storageSet;
		["emote_action",{
			params ["_act"];
			if (_act == "pr_see" || _act == "pr_hear") exitWith {
				nextFrame({callFuncParams(call sp_getActor,stopProgress,true)});
				call sp_removeCurrentPlayerHandler;
				["perform_search_action",true] call sp_storageSet;
				["cpt3_foundmonster"] call sp_startScene;
				false
			};
			true
			//
		}] call sp_addPlayerHandler;

		_hWidget = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_wid = _d getVariable ["ieMenuCtg",widgetNull];
			_wid
		},0.02] call sp_createWidgetHighlight;

		//we can also select catname with (interactEmote_actions select interactEmote_curTabIdx)
		_hWidName = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_widName = _d getVariable "ieMenuCtg";
			if (isNullVar(_widName) || {isNullReference(_widName)}) exitwith {_wid};
			_widName = _widName getVariable "ctgCatAct";
			if (isNullVar(_widName) || {isNullReference(_widName)}) exitwith {_wid};
			_widName
		},0.002] call sp_createWidgetHighlight;

		_pvHandler = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_wid = _d getVariable ["ieMenuCtg",widgetNull] getvariable ["ctgPrevActionButton",widgetNull];
			_wid
		},0.0005] call sp_createWidgetHighlight;
		_ntHandler = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_wid = _d getVariable ["ieMenuCtg",widgetNull] getvariable ["ctgNextActionButton",widgetNull];
			_wid
		},0.0005] call sp_createWidgetHighlight;

		{
			(interactEmote_actions select interactEmote_curTabIdx select 0) == "Восприятие";
		} call sp_threadWait;
		refset(_hWidName,true);
		refset(_pvHandler,true);
		refset(_ntHandler,true);
		

		_hSee = [{
			_wid = widgetNull;
			{
				if (!isNullReference(_x) && ({_x getvariable "act" == "pr_see"})) then {
					_wid = _x;
				}
			} foreach interactEmote_act_widgets;
			_wid
		}] call sp_createWidgetHighlight;

		{
			["perform_search_action",false] call sp_storageGet;
		} call sp_threadWait;
		
		refset(_hSee,true);
		refset(_hWidget,true);
		

	} call sp_threadStart;
}] call sp_addScene;

["cpt3_foundmonster",{
	{
		["Вы заметили жруна - опасного монстра, обитающего в Сети. Метните в него факел, чтобы попытаться отпугнуть."
		+sbr+sbr
		+"Выберите ""Бросок"" в правом меню"] call sp_setNotification;
		_ct = [{
			_wid = widgetNull;
			{
				if (!isNullReference(_x) && {(_x getvariable "actionName") == "Бросок"}) exitWith {
					_wid = _x;
				};
			} foreach interactMenu_specActWidgets;
			_wid
		}] call sp_createWidgetHighlight;
		
		{
			equals(getVar(call sp_getActor,specialAction),SPECIAL_ACTION_THROW)
		} call sp_threadWait;
		refset(_ct,true);
		
		_hspec = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["specAct",_w];
            _w
        }] call sp_createWidgetHighlight;

		_hmes = ["Активное особое действие отображается справа. Для активации особого действия нажмите $input_act_extraAction"] call sp_setNotification;
		
		_hact = ["extra_action",{
			params ["_targ"];
			_trch = callFunc(call sp_getActor,getItemInActiveHandRedirect);
			if (isNullReference(_trch)) exitWith {true};
			
			if (callFuncParams(call sp_getActor,getDirFrom,(sp_ai_debug_testmobs get "cpt3_eater") getvariable "link") == DIR_FRONT) exitWith {
				["cpt3_obj_torchonthrow",_trch] call sp_storageSet;
				call sp_removeCurrentPlayerHandler;
				false
			};
			false
		}] call sp_addPlayerHandler;

		{!(_hact call sp_isValidPlayerHandler)} call sp_threadWait;
		refset(_hspec,true);
		
		[false,_hmes] call sp_setNotificationVisible;
		
		//switch off torch
		{
			_torch = ["cpt3_obj_torchonthrow",nullPtr] call sp_storageGet;
			if isNullReference(_torch) exitWith {true};
			callFunc(_torch,isInWorld) && !callFunc(_torch,isFlying)
		} call sp_threadWait;

		_torch = ["cpt3_obj_torchonthrow",nullPtr] call sp_storageGet;
		if !isNullReference(_torch) then {
			callFuncParams(_torch,lightSetMode,false);
		};

		sp_playerCanMove = true;
		
		_lampSrc = "LampCeiling G:Kym4iXFMOZ0 (3)" call sp_getObject;
		//play eater moving


		[0.03,5.5,0.05,1.5] call cam_addCamShake;
		_eaterSrc = "cpt3_eater" call sp_ai_getMobObject;
		callFuncParams(_eaterSrc,playSound,"monster\eater\scream2" arg getRandomPitchInRange(0.8,1.3) arg 30 arg 2.2 arg null arg false);
		[_eaterSrc,null,"cpt3_eater_runaway",{
			params ["_mob"];
			[_mob,"cpt3_pos_eaterstealth",0] call sp_ai_setMobPos;
			_mob switchmove "ApanPercMstpSnonWnonDnon_G01";
		}] call sp_ai_playAnim;

		["Прятки со смертью","Проберитесь через пропускную зону к городу"] call sp_setTaskMessageEff;

	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_takeaxe",{
	{
		_h = ["Возьмите топор со стола"] call sp_setNotification;
		{
			callFuncParams(call sp_getActor,hasItem,"cpt3_obj_caveaxeguide" call sp_getObject);
		} call sp_threadWait;

		_wall = "cpt3_obj_invvalstelathstart" call sp_getObject;
		if !isNullReference(_wall) then {
			[_wall] call deleteGameObject;
		};

		_h = ["Вы можете драться при помощи любых предметов, взятых в руки. Однако помните, что в бою холодное оружие значительно эффективнее чем подручные предметы"] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
		
	} call sp_threadStart;
}] call sp_addScene;

// "LampCeiling G:Kym4iXFMOZ0 (3)" - lamp screamer (todo disable by default)
// "LampCeiling G:a3+rKIedoM0" - lamp stealth testing

["cpt3_trg_startStealthPre",{
	
	{
		
		private _obj = "LampCeiling G:a3+rKIedoM0" call sp_getObject;
		while {true} do {
			
			1 call sp_threadPause;
			private _mode = false;

			callFuncParams(_obj,playSound,"electronics\lamp_lag" arg getRandomPitchInRange(0.8,1.3) arg 20 arg 2.2 arg null arg false);
			for "_i" from 1 to 5 do {
				callFuncParams(_obj,setEnable,_mode);
				_mode = !_mode;
				
				rand(0.2,0.7) call sp_threadPause;
			};
			//callFuncParams(_obj,playSound,"electronics\lamp_lag" arg getRandomPitchInRange(0.8,1.3) arg 20 arg 2.2 arg null arg false);
			5 call sp_threadPause;
			
			callFuncParams(_obj,setEnable,true);

			3 call sp_threadPause;
		};
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_attackeater",{

}] call sp_addScene;

//cpt3_obj_doordestr - need destroy

["t3_trg_foundgate",{

}] call sp_addScene;

["cpt3_trg_ongate",{
	//cpt3_obj_radio - speaker
	//cpt3_obj_bigspeaker - big speaker
}] call sp_addScene;