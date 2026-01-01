// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"
cpt3_hudvis_default = "chat+stam+right+stats+cursor+inv";
cpt3_hudvis_eaterzone = cpt3_hudvis_default + "+left";
cpt3_hudvis_eatercombat = cpt3_hudvis_eaterzone + "+up";
["cpt3_begin",{
	call sp_initializeDefaultPlayerHandlers;
	[call sp_getActor] call sp_loadCharacterData;
    [true,0] call setBlackScreenGUI;

	if isNullReference(callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH)) then {
		[cpt1_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;
	};

	if (!callFuncParams(call sp_getActor,hasItem,"Torch" arg true)) then {
		["Torch",call sp_getActor] call createItemInInventory;
	};

	call cpt2_act_enableTorchHadnler;
	cpt2_data_listTorches pushback ("cpt3_obj_torchoneater" call sp_getObject);

	//левая рука стала правой...
	setVar("cpt3_obj_armdeadbody" call sp_getObject,side,1);
	
	[sp_const_list_stdPlayerHandlers,false] call sp_setLockPlayerHandler;
	[true] call sp_setPlayerSprintAllowed;
    call cpt1_act_addMapViewHandler;

	[{
        params ["_t","_wid"];
        _t == "pr_see" || _t == "pr_hear"
    },{
		params ["_t","_wid"];
		array_exists(COMBAT_STYLE_LIST_ALL,_t)
	},{
		params ["_t","_wid"];
        if array_exists(interactMenu_selectionWidgets,_wid) exitWith {true};
		if ("Бросок" == _t && (["cpt3_data_canUseThrowAction",false] call sp_storageGet)) exitWith {true};
		if ("Прятаться" == _t && (["cpt3_data_canUseHideAction",false] call sp_storageGet)) exitWith {true};
		false
	}] call sp_gui_setInventoryVisibleHandler;

	sp_allowebVerbs append ["undress"];

	["cpt3_pos_start",0] call sp_setPlayerPos;
	[cpt3_hudvis_default] call sp_view_setPlayerHudVisible;
	[false,1.5] call setBlackScreenGUI;

	//create deadbody
	_body = objNull;
	_mob = nullPtr;
	["cpt3_pos_deadbody_looting","cpt3_deadbody",[
		["uniform","NomadCloth10"],
		["name",["Мертвец"]],
		["age",27]
	],{
		_cloth = callFuncParams(_this,getItemInSlot,INV_CLOTH);
		["Lockpick",_cloth] call createItemInContainer;
		_mob = _this;
	},{
		_body = _this;
	}] call sp_ai_createPersonEx;
	
	callFuncParams(_mob,destroyLimb,BP_INDEX_HEAD);
	callFuncParams(_mob,destroyLimb,BP_INDEX_LEG_L);
	callFuncParams(_mob,destroyLimb,BP_INDEX_ARM_R);

	_body switchMove "acts_staticdeath_10";
	_body enablemimics false;

	//make eater
	_eaterBdy = objNull;
	["cpt3_pos_eaterbase_pre","cpt3_eater",[
		["class","GMPreyMobEater"],
		["name",["Сонный","Жрун"]]
	],{
		["Castoffs1",_this,INV_CLOTH] call createItemInInventory;
	},{
		_eaterBdy = _this;
	}] call sp_ai_createPersonEx;
	_eaterBdy setDir (callFunc("cpt3_pos_eaterbase_pre" call sp_getObject,getDir));
	if (!sp_debug) then {
		//_eaterBdy hideObject true;
	};
	_eaterBdy switchmove "ApanPercMstpSnonWnonDnon_G01";
	_eaterBdy setface "persianhead_a3_01_player";//disable eater head


	["click_self",{
        params ["_t"];
        if (isTypeOf(_t,Knife)) exitWith {
            _m = pick[
                "Я не буду себя резать.",
                "Что я творю?",
                "Это глупо.",
                "В этом нет необходимости.",
                "Зачем мне резать себя?",
                "Я не хочу это делать."
            ];
            callFuncParams(call sp_getActor,mindSay,_m);
            true
        };
        false
    }] call sp_addPlayerHandler;

}] call sp_addScene;

["cpt3_trg_katafound",{
	["katacombs"] call sp_audio_playMusic;
	["На подступе","Идите через катакомбы"] call sp_setTaskMessageEff;
}] call sp_addScene;

["cpt3_trg_foundmushrooms",{
	{
		_h = ["В Сети растёт множество разных культур. Чаще всего здесь можно найти различные #(грибы), в том числе съедобные. Будьте осторожны и не ешьте неизвестные вам грибы."] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

cpt3_trg_enterdarkzone_act = false;
["cpt3_trg_enterdarkzone",{
	if (cpt3_trg_enterdarkzone_act) exitWith {};
	cpt3_trg_enterdarkzone_act = true;

	{
		_h = ["В Сети много темных мест. Учитесь ориентироваться на местности в условиях плохой освещённости. Ищите и создавайте ориентиры, чтобы не заблудиться."] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;

}] call sp_addTriggerEnter;

["cpt3_trg_founddeadbody",{
	{
		["strange"] call sp_audio_playMusic;
		["chap3\gg1"] call sp_audio_sayPlayer;

		["Вы можете обыскивать тела людей не проявляющих активности: мертвых, связанных или спящих." + 
		sbr + sbr +
		"Подойдите к телу, нажмите ПКМ и выберите пункт #(""Раздеть""). В открывшемся меню инвентаря чужого персонажа нажмите по слоту с предметом и он будет взят в активную руку."+
		sbr+"Снимите одежду с трупа и осмотрите её карманы."] call sp_setNotification;
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

		refset(_refItm,true);

		if !(["cpt4_data_foundlockpickdoor",false] call sp_storageGet) then {
			[false,_h] call sp_setNotificationVisible;
			[true] call sp_setHideTaskMessageCtg;
		} else {
			["На подступе","Взломайте замок двери"] call sp_setTaskMessageEff;
		};

	} call sp_threadStart;
}] call sp_addScene;

["cpt_trg_founddoor",{
	_baseMethod = getFunc("cpt3_obj_lockeddoor" call sp_getObject,onLockpicking);
	["lockpick_method_orig",_baseMethod] call sp_storageSet;
	
	_newmethod = {
		objParams_2(_usr,_lockpick);

		if !getSelf(isLocked) exitWith {
			private _m = pick["Так не закрыто же!","Не заперто.","Зачем взламывать открытое?!?!"];
			callFuncParams(_usr,localSay,_m arg "error");
		};
		if not_equals("cpt3_obj_lockeddoor" call sp_getObject,this) exitWith {
			callFuncParams(_usr,mindSay,"Слишком сложный замок...");
		};
		if getSelf(isOpen) exitWith {};

		callFuncParams(_usr,mindSay,"Мне удалось взломать замок... но отмычка не пережила это.");
		callSelfParams(setDoorLock,false arg false);
		nextFrameParams({delete(_this)},_lockpick);
	};

	[callFunc("cpt3_obj_lockeddoor" call sp_getObject,getClassName),"onLockpicking",_newmethod,"replace"] call oop_injectToMethod;
	
	["cpt4_data_foundlockpickdoor",true] call sp_storageSet;

	{
		if (!callFuncParams(call sp_getActor,hasItem,"Lockpick" arg true arg true)) then {
			["На подступе","Найдите способ открыть дверь"] call sp_setTaskMessageEff;
		};
		1 call sp_threadPause;
		{
			["found_lockpick",false] call sp_storageGet
			&& callFuncParams(call sp_getActor,getDistanceTo,"cpt3_obj_lockeddoor" call sp_getObject) <= 2.4
		} call sp_threadWait;
		
		["На подступе","Взломайте замок двери"] call sp_setTaskMessageEff;

		["Для #(взлома) двери нажмите ЛКМ по двери держа в руке #(отмычку). Если у вас есть соответствующие навыки - вы сможете взломать замок."] call sp_setNotification;

		{
			!getVar("cpt3_obj_lockeddoor" call sp_getObject,isLocked)
		} call sp_threadWait;
		
		[false] call sp_setNotificationVisible;

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

	[] call sp_audio_stopMusic;

	{
		_lampSrc = "LampCeiling G:Kym4iXFMOZ0 (3)" call sp_getObject;
		
		callFuncParams("cpt3_eater" call sp_ai_getMobObject,playSound,"monster\eater\idle2" arg getRandomPitchInRange(0.8,1.3) arg 20 arg 2.2 arg null arg false);
		sp_playerCanMove = false;
		_m = "Я что-то слышу...";
		callFuncParams(call sp_getActor,mindSay,_m);
		["Вы можете внимательно #(всматриваться) и #(прислушиваться) к окружению, чтобы замечать подозрительные вещи. "
		+sbr+sbr+"Нажмите $input_act_inventory, переместите мышь влево и в выезжающем меню перейдите в раздел #(""восприятие""). "
		+"Попробуйте присмотреться к окружению."] call sp_setNotification;

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

		private _switcher = {
			_d = getDisplay;
			if isNullReference(_d) exitWith {false};
			_d getvariable ["ieMenuCtg",widgetNull] getvariable ["categsGroup",widgetNull] getvariable ["isloadedlist",false]
		};
		// _switcher = {
		// 	//(interactEmote_actions select interactEmote_curTabIdx select 0) == "Восприятие"
		// 	false
		// };

		//we can also select catname with (interactEmote_actions select interactEmote_curTabIdx)
		_hWidName = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_widName = _d getVariable "ieMenuCtg";
			if (isNullVar(_widName) || {isNullReference(_widName)}) exitwith {_wid};
			_widName = _widName getVariable "ctgCatAct";
			if (isNullVar(_widName) || {isNullReference(_widName)}) exitwith {_wid};
			if (_d getvariable ["ieMenuCtg",widgetNull] getvariable ["categsGroup",widgetNull] getvariable ["isloadedlist",false]) exitWith {_wid};
			_widName
		},0.002,_switcher] call sp_createWidgetHighlight;

		_pvHandler = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			if (_d getvariable ["ieMenuCtg",widgetNull] getvariable ["categsGroup",widgetNull] getvariable ["isloadedlist",false]) exitWith {_wid};
			_wid = _d getVariable ["ieMenuCtg",widgetNull] getvariable ["ctgPrevActionButton",widgetNull];
			_wid
		},0.002,_switcher] call sp_createWidgetHighlight;
		_ntHandler = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			if (_d getvariable ["ieMenuCtg",widgetNull] getvariable ["categsGroup",widgetNull] getvariable ["isloadedlist",false]) exitWith {_wid};
			_wid = _d getVariable ["ieMenuCtg",widgetNull] getvariable ["ctgNextActionButton",widgetNull];
			_wid
		},0.002,_switcher] call sp_createWidgetHighlight;

		//not work
		// _hCateg = [{
		// 	_wid = widgetNull;
		// 	_d = getDisplay;
		// 	if isNullReference(_d) exitWith {_wid};
		// 	{
		// 		if ("Восприятие" in (ctrlText _x)) exitWith {
		// 			_wid = _x;
		// 		};
		// 	} foreach (allControls(_d getvariable ["ieMenuCtg",widgetNull] getvariable ["categsGroup",widgetNull]
		// 	getvariable ["ctglistcatsie",widgetNull]));
		// 	_wid
		// },0.002,{true}] call sp_createWidgetHighlight;

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
		},null,_switcher] call sp_createWidgetHighlight;

		{
			["perform_search_action",false] call sp_storageGet;
		} call sp_threadWait;

		refset(_hSee,true);
		refset(_hWidget,true);
		//refset(_hCateg,true);

	} call sp_threadStart;
}] call sp_addScene;

["cpt3_foundmonster",{
	["cpt3_eater","cpt3_pos_eaterbase",0] call sp_ai_setMobPos;

	if (
		!callFuncParams(call sp_getActor,hasItem,"Torch" arg true)
	) then {
		{
			if isTypeOf(_x,Torch) then {
				if equals("cpt3_obj_torchoneater" call sp_getObject,_x) exitWith {};
				[_x] call deleteGameObject;
			};
		} foreach (callFuncParams(call sp_getActor,getNearItems,40));
		if !isNullReference(callFunc(call sp_getActor,getItemInActiveHandRedirect)) then {
			callFuncParams(call sp_getActor,dropItem,getVar(call sp_getActor,activeHand));
		};
		["Torch",call sp_getActor] call createItemInInventory;
	};

	//("cpt3_eater" call sp_ai_getMobBody) hideObject false;
	{
		["eaterstealth"] call sp_audio_playMusic;

		{
			[0,1.5,0.01,0.5] call cam_addCamShake;
		} call sp_threadCriticalSection;

		["press_specact",false] call sp_setLockPlayerHandler;
		["extra_action",false] call sp_setLockPlayerHandler;

		{
			["cpt3_data_canUseThrowAction",true] call sp_storageSet;
			call sp_gui_syncInventoryVisible;
		} call sp_threadCriticalSection;


		["Вы заметили #(жруна) - опасного монстра, обитающего в Сети. Попробуйте отпугнуть его, метнув факел."
		+sbr+sbr
		+"Выберите #(""Бросок"") в правом меню."] call sp_setNotification;

		_ct = [{
			_wid = widgetNull;
			{
				if (
					!isNullReference(_x) 
					&& {(_x getvariable "actionName") == "Бросок"}
				) exitWith {
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
			if (cd_specialAction != SPECIAL_ACTION_THROW) exitWith {_w};
            _w = hud_map_widgets getOrDefault ["specAct",_w];
            _w
        },null,{
			cd_specialAction != SPECIAL_ACTION_THROW
		}] call sp_createWidgetHighlight;

		_hmes = ["Активное #(особое действие) отображается в статусах справа. Каждое активное действие устанавливается для левой и правой руки отдельно. Для активации особого действия нажмите $input_act_extraAction нацелившись в сторону жруна."] call sp_setNotification;
		
		_hact = ["extra_action",{
			params ["_targ"];
			_trch = callFunc(call sp_getActor,getItemInActiveHandRedirect);
			if (isNullReference(_trch)) exitWith {true};
			if !isTypeOf(_trch,Torch) exitWith {true};
			
			if (callFuncParams(call sp_getActor,getDirFrom,"cpt3_eater" call sp_ai_getMobObject) == DIR_FRONT) exitWith {
				["cpt3_obj_torchonthrow",_trch] call sp_storageSet;
				call sp_removeCurrentPlayerHandler;
				false
			};
			true
		}] call sp_addPlayerHandler;
		_hthrow = ["extra_action",{
			params ["_targ"];
			if (isNullReference(_targ)) exitWith {true};
			if (cd_specialAction == SPECIAL_ACTION_THROW && isTypeOf(callFunc(call sp_getActor,getItemInActiveHandRedirect),CaveAxe)) exitWith {
				[
					pick[
						"Я не буду кидать единственное нормальное оружие.",
						"Не стоит разбрасываться хорошим оружием.",
						"Кидать нельзя - носить с собой..."
					],
					"error"
				] call chatPrint;
				true;
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
			_mob setvelocity [0,0,0]; //fix fast moving bug
			[_mob,"cpt3_pos_eaterstealth",0] call sp_ai_setMobPos;
			_mob switchmove "ApanPercMstpSnonWnonDnon_G01";
		}] call sp_ai_playAnim;

		0.5 call sp_threadPause;
		["chap3\gg2"] call sp_audio_sayPlayer;

		["Прятки со смертью","Проберитесь через пропускную зону к городу"] call sp_setTaskMessageEff;

		//хандлер броска предмета в жруна или рядом с ним
		["cpt4_data_eaterThrowObjectHandle",sp_threadNull] call sp_storageSet;
		["extra_action",{
			params ["_targ"];
			private _eater = "cpt3_eater" call sp_ai_getMobObject;
			private _res = false;
			if (cd_specialAction == SPECIAL_ACTION_THROW) then {
				if (equals(_targ,_eater)) exitWith {
					if (call cpt4_func_isEaterAlive) then {
						call cpt4_func_eaterAttack;
					};
				};
				(["cpt4_data_eaterThrowObjectHandle",sp_threadNull] call sp_storageGet) call sp_threadStop;
				["cpt4_data_eaterThrowObjectHandle",[{
					params ["_obj","_eater"];
					if isNullReference(_obj) exitWith {};
					
					{
						callFunc(_obj,isInWorld) && !callFunc(_obj,isFlying)
					} call sp_threadWait;
					if (callFuncParams(_obj,getDistanceTo,_eater arg true) <= 9) then {
						if (call cpt4_func_isEaterAlive) then {
							call cpt4_func_eaterAttack;
						};
					};
				},[callFunc(call sp_getActor,getItemInActiveHandRedirect),_eater]] call sp_threadStart] call sp_storageSet;
			};
			
			false
		}] call sp_addPlayerHandler;

	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_takeaxe",{
	{
		_h = ["Возьмите #(топор) со стола"] call sp_setNotification;
		{
			callFuncParams(call sp_getActor,hasItem,"cpt3_obj_caveaxeguide" call sp_getObject);
		} call sp_threadWait;

		_wall = "cpt3_obj_invvalstelathstart" call sp_getObject;
		if !isNullReference(_wall) then {
			[_wall] call deleteGameObject;
		};

		_h = ["Вы можете #(сражаться) при помощи любых предметов у вас в руках. Однако помните, что в бою #(холодное оружие) значительно эффективнее подручных предметов."] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
		
	} call sp_threadStart;
}] call sp_addScene;

// "LampCeiling G:Kym4iXFMOZ0 (3)" - lamp screamer (todo disable by default)
// "LampCeiling G:a3+rKIedoM0" - lamp stealth testing

["cpt3_trg_startStealthPre",{
	if (sp_debug) then {
		_mob = getVar("cpt3_eater" call sp_ai_getMobObject,owner);
		[_mob,"cpt3_pos_eaterstealth",0] call sp_ai_setMobPos;
		_mob switchmove "ApanPercMstpSnonWnonDnon_G01";
	};
	["cpt3_lightswitch",true] call sp_storageSet;
	{
		
		private _obj = "LampCeiling G:a3+rKIedoM0" call sp_getObject;
		while {["cpt3_lightswitch",true] call sp_storageGet} do {
			
			1 call sp_threadPause;
			private _mode = false;

			callFuncParams(_obj,playSound,"electronics\lamp_lag" arg getRandomPitchInRange(0.8,1.3) arg 20 arg 2.2 arg null arg false);
			for "_i" from 1 to 5 do {
				callFuncParams(_obj,setEnable,_mode);
				_mode = !_mode;
				
				rand(0.1,0.45) call sp_threadPause;
			};
			//callFuncParams(_obj,playSound,"electronics\lamp_lag" arg getRandomPitchInRange(0.8,1.3) arg 20 arg 2.2 arg null arg false);
			5.5 call sp_threadPause;
			
			callFuncParams(_obj,setEnable,true);

			3 call sp_threadPause;
		};

		callFuncParams(_obj,setEnable,true);
	} call sp_threadStart;
}] call sp_addScene;

cpt4_data_eaterHandleLife = threadNull;

cpt4_func_isEaterAlive = {
	!getVar("cpt3_eater" call sp_ai_getMobObject,isDead)
};

cpt4_func_eaterAttack = {
	private _eater = "cpt3_eater" call sp_ai_getMobObject;
	{
		[_eater,"cpt3_pos_eaterstealth","cpt3_eater_attack",{
			params ["_mob"];
			_mob switchmove "ApanPercMstpSnonWnonDnon_G01";
			_mob setvelocity [0,0,0]; //fix fast moving bug
			[_mob,"cpt3_pos_eaterstealth",0] call sp_ai_setMobPos;
		}] call sp_ai_playAnim;

		callFuncParams(_eater,playSound,"monster\eater\scream5" arg getRandomPitchInRange(0.9,1.1) arg 50 arg 2.2 arg null arg false);
		_c = { [0.23,30.5,0.05,0.8] call cam_addCamShake; };
		invokeAfterDelay(_c,0.45);
		[true,1.8] call setBlackScreenGUI;
		callFuncParams(call sp_getActor,setStealth,false);
		["cpt3_flag_caneatercheck",false] call sp_storageSet;
		
	} call sp_threadCriticalSection;
	_post = {
		
		["cpt3_eater","cpt3_pos_eaterstealth",0] call sp_ai_setMobPos;

		["cpt3_flag_caneatercheck",true] call sp_storageSet;
		["cpt3_pos_onfailstealth",0] call sp_setPlayerPos;
		[false,1.1] call setBlackScreenGUI;
	}; invokeAfterDelay(_post,3);
};

["cpt3_trg_stealthguide",{

	//eater stealth handler
	cpt4_data_eaterHandleLife = {
		_eater = "cpt3_eater" call sp_ai_getMobObject;
		while {call cpt4_func_isEaterAlive} do {
			_refm = refcreate(0);
			if (callFuncParams(_eater,canSeeObject,call sp_getActor arg _refm)
				&& !getVar(call sp_getActor,isStealthEnabled)
			) then {
				//уже за спиной у жруна
				if (callFuncParams(call sp_getActor,getDirTo,_eater) == DIR_BACK) exitWith {};

				if (refget(_refm) >= VISIBILITY_MODE_LOW) then {
					call cpt4_func_eaterAttack;

					{
						(["cpt3_flag_caneatercheck",false] call sp_storageGet)
					} call sp_threadWait;
					
				};
			};
		};
		
	} call sp_threadStart;

	["cpt3_data_canUseHideAction",true] call sp_storageSet;
	call sp_gui_syncInventoryVisible;

	{
		_notifHandle = ["Чтобы двигаться незаметно для других перейдите в режим #(скрытности). Для этого в правом меню нажмите #(""Прятаться"")"] call sp_setNotification;

		_ct = [{
			_wid = widgetNull;
			{
				if (!isNullReference(_x) && {(_x getvariable "actionName") == "Прятаться"}) exitWith {
					_wid = _x;
				};
			} foreach interactMenu_specActWidgets;
			_wid
		}] call sp_createWidgetHighlight;

		{
			getVar(call sp_getActor,isStealthEnabled)
		} call sp_threadWait;
		refset(_ct,true);
		sp_playerCanMove = false;
		_notifHandle = ["Включенная #(скрытность) отображается в статусах справа. Быстрое движение лишает скрытности."] call sp_setNotification;
		
		_hspec = [{
            _w = widgetNull;
            _w = hud_map_widgets getOrDefault ["stealth",_w];
            _w
        },null,{hud_stealth == 0}] call sp_createWidgetHighlight;

		5 call sp_threadPause;
		sp_playerCanMove = true;
		[false,_notifHandle] call sp_setNotificationVisible;
		refset(_hspec,true);
		
		["Прятки со смертью","Незаметно подкрадитесь к жруну сзади"] call sp_setTaskMessageEff;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_stealthlightnotif",{
	{
		_h = ["<t align='left'>Скрытное передвижение так же #(прекратится) в следующих случаях:"
			+sbr+ " - Яркое освещение"
			+sbr+ " - Бег и быстрое передвижение"
			+sbr+ " - Враг бдительно осматривается или прислушивается"
			+sbr+ " - Вы атаковали кого-то или получили урон"
			+ "</t>"
		] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

cpt3_data_doorSeeDialogPerformed = false;

["cpt3_trg_attackeater",{
	[cpt3_hudvis_eatercombat] call sp_view_setPlayerHudVisible;
	//eater attack handler
	["click_target",{
		params ["_t"];
		_ret = true;
		_eater = "cpt3_eater" call sp_ai_getMobObject;
		if equals(_t,_eater) then {
			if not_equals(callFunc(call sp_getActor,getItemInActiveHandRedirect),"cpt3_obj_caveaxeguide" call sp_getObject) exitWith {};
			if (callFuncParams(call sp_getActor,getDistanceTo,_eater) > 1.5) exitWith {};
			if (getVar(call sp_getActor,isCombatModeEnable)) then {
				_tzSel = [getVar(call sp_getActor,curTargZone)] call gurps_convertTargetZoneToBodyPart;
				
				if not_equals(_tzSel,BP_INDEX_HEAD) exitWith {};

				_ret = false;
				if (_tzSel != BP_INDEX_TORSO) then {
					callFuncParams(_eater,lossLimb,_tzSel);
				};
				
				setVar(_eater,isDead,true);
				[cpt4_data_eaterHandleLife] call sp_threadStop;
				getVar(_eater,owner) switchMove "Acts_StaticDeath_05";
				call sp_removeCurrentPlayerHandler;
			};
		};
		_ret
	}] call sp_addPlayerHandler;

	{
		["combat",false] call sp_setLockPlayerHandler;

		_h = ["Чтобы атаковать противника перейдите в #(боевой режим), нажав $input_act_combatMode."] call sp_setNotification;
		{
			getVar(call sp_getActor,isCombatModeEnable)
		} call sp_threadWait;

		_hWidget = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_d getvariable ["combatMenuCtg",widgetNull]
		},0.02] call sp_createWidgetHighlight;

		_h = ["Нажмите $input_act_inventory. Переместив мышь вверх появится боевое меню - здесь вы можете настроить стили атаки и защиты. В области взаимодействия справа вы можете выбрать место куда атаковать противника."+
		sbr+"Выберите зону атаки #(""Голова"") и как будете готовы - нажмите ЛКМ для атаки топором по жруну."] call sp_setNotification;

		{
			getVar("cpt3_eater" call sp_ai_getMobObject,isDead)
		} call sp_threadWait;
		
		refset(_hWidget,true);
		[false,_h] call sp_setNotificationVisible;

		["cpt3_lightswitch",false] call sp_storageSet;
		[true] call sp_setHideTaskMessageCtg;

		[] call sp_audio_stopMusic;

		//удаление головы жруна (она человеческая...)
		{
			private _eater = "cpt3_eater" call sp_ai_getMobObject;
			{
				if isTypeOf(_x,Head) then {
					[_x] call deleteGameObject;
				};
			} foreach callFuncParams(_eater,getNearItems,10);
		} call sp_threadCriticalSection;

		1.2 call sp_threadPause;

		_sound = ["chap3\gg3"] call sp_audio_sayPlayer;
		_sound call sp_audio_waitForEndSound;
	

		// door destroy handler
		["click_target",{
			params ["_t"];
			_hret = true;
			if (!getVar(call sp_getActor,isCombatModeEnable)) exitWith {_hret};
			if (
				equals(_t,"cpt3_obj_doordestr" call sp_getObject)
				&& getSelf(lastCombatActionTime) <= tickTime
			) then {
				if not_equals(callFunc(call sp_getActor,getItemInActiveHandRedirect),"cpt3_obj_caveaxeguide" call sp_getObject) exitWith {};

				_t call cpt3_func_damageEvent;
				//fix unc state error (because dropping weapon from hands and cannot pick it up)
				if (getVar(call sp_getActor,stamina) <= 10) then {
					setVar(call sp_getActor,stamina,100);
				};
				if ((["cpt3_ctr_doordam",{_this + 1},0] call sp_storageUpdate) >= 4) then {
					[false] call sp_setNotificationVisible;
					
					call sp_removeCurrentPlayerHandler;

					nextFrameParams(deleteGameObject,[_t]);

					_worldPos = callFunc(_t,getPos) vectorAdd [0,0,0.5];
					for "_i" from 1 to 4 do {
						private _wpos = _worldPos vectoradd [rand(-0.8,0.8),rand(-0.8,0.8),0.5];
						_w = ["WoodenDebris" + (str randInt(3,4)),_wpos,null,true] call createItemInWorld;
					};
				};
				_hret = false;
			};
			_hret
		}] call sp_addPlayerHandler;

		_threadlook = {
			{
				_obj = "cpt3_obj_doordestr" call sp_getObject;
				_refobj = (call interact_cursorobject)getVariable ["ref","nullref"];
				callFuncParams(call sp_getActor,canSeeObject,_obj)
				|| callFuncParams(call sp_getActor,getDistanceTo,_obj arg true) <= 1.2
				|| equals(pointerList getOrDefault vec2(_refobj,nullPtr),_obj)
			} call sp_threadWait;
			
			sp_playerCanMove = false;
			([
				"chap3\gg4",
				"chap3\gg5"
			] call sp_audio_sayPlayerList) call sp_threadWaitForEnd;
			sp_playerCanMove = true;

			cpt3_data_doorSeeDialogPerformed = true;
			["Прятки со смертью","Попробуйте открыть дверь"] call sp_setTaskMessageEff;
		} call sp_threadStart;
		
		_threadlook call sp_threadWaitForEnd;
		
		_h1 = ["main_action",{
			params ["_t"];
			if equals(_t,"cpt3_obj_doordestr" call sp_getObject) then {
				{_x call sp_removePlayerHandler} foreach (["cpt3_handlers_dooract",[]] call sp_storageGet);
				["cpt3_dodestroydoor"] call sp_startScene;
			}
		}] call sp_addPlayerHandler;
		_h2 = ["activate_verb",{
			params ["_t","_name"];
			if (_name == "mainact") then {
				if equals(_t,"cpt3_obj_doordestr" call sp_getObject) then {
					{_x call sp_removePlayerHandler} foreach (["cpt3_handlers_dooract",[]] call sp_storageGet);
					["cpt3_dodestroydoor"] call sp_startScene;
				};
			};
		}] call sp_addPlayerHandler;
		["cpt3_handlers_dooract",[_h1,_h2]] call sp_storageSet;


	} call sp_threadStart;
}] call sp_addScene;

cpt3_func_damageEvent = {
    _trg = _this;
    _worldPos = callFunc(_trg,getPos) vectorAdd [0,0,0.5];
    _eff = true;
    _snd = true;
    _isblock = false;

    //[0.5,3.5,.05,0.8] call cam_addCamShake;

    callFuncParams(_trg,sendDamageVisualOnPos,_worldPos arg _eff arg _snd arg _isblock);

    _snd = false;
    for "_i" from 1 to randInt(2,4) do {
        private _wpos = _worldPos vectoradd [rand(-0.1,0.1),rand(-0.1,0.1),rand(-0.2,0.3)];
        callFuncParams(_trg,sendDamageVisualOnPos,_wpos arg _eff arg _snd arg _isblock);
    };
};

["cpt3_dodestroydoor",{
	{
		{cpt3_data_doorSeeDialogPerformed} call sp_threadWait;

		["chap3\gg6"] call sp_audio_sayPlayer;
		
		1 call sp_threadPause;

		["Вы можете #(разрушать) объекты с помощью вашего оружия. Для этого нажмите ЛКМ в #(боевом режиме) по двери."] call sp_setNotification;
		_obj = "cpt3_obj_doordestr" call sp_getObject;
		//callFuncParams(_obj,setHPCurrentPrecentage,10);

		
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_foundgate",{
	[true] call sp_setHideTaskMessageCtg;
	
	["gate"] call sp_audio_playMusic;
	{
		2 call sp_threadPause;
		["chap3\gg7"] call sp_audio_sayPlayer;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_ongate",{
	//cpt3_obj_radio - speaker
	//cpt3_obj_bigspeaker - big speaker
	
	{
		private _distanceCheckDialog = ["canstart",{
			callFuncParams(call sp_getActor,getDistanceTo,"cpt3_obj_radio" call sp_getObject arg true) <= 10
		}];
		private _distSpec = [
			["distance",40],
			_distanceCheckDialog
		];

		[
			[player,"chap3\gg8",_distanceCheckDialog],
			["cpt3_obj_radio","chap3\radio1",[["endoffset",2]]+_distSpec],

			[player,"chap3\gg9",[["endoffset",3.1],_distanceCheckDialog]], 
			["cpt3_obj_radio","chap3\radio2",[["endoffset",-2]]+_distSpec],

			[player,"chap3\gg10",[["endoffset",2],_distanceCheckDialog]], 
			["cpt3_obj_radio","chap3\radio3",[["endoffset",2]]+_distSpec],

			[player,"chap3\gg11",[["endoffset",3.1],_distanceCheckDialog]], 
			["cpt3_obj_radio","chap3\radio4",[
				["onend",{
					["cpt3_onend"] call sp_startScene;
				}]]+_distSpec
			]
		] call sp_audio_startDialog;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_onend",{
	[""] call sp_view_setPlayerHudVisible;
    [true] call sp_setHideTaskMessageCtg;
	[true,2] call setBlackScreenGUI;
	{
        3 call sp_threadPause;
		["cpt3_topart4"] call sp_startScene;
    } call sp_threadStart;
}] call sp_addScene;


["cpt3_topart4",{
	if (sp_debug) then {
		callFuncParams("GateCity G:6C2bvKArl3c" call sp_getObject,setDoorOpen,false);
	};

	{
		
		["transition1"] call sp_audio_playMusic;

		//cam shown
		[true] call sp_cam_setCinematicCam;
		[true] call sp_gui_setCinematicMode;
		{
			["cpt3_pos_cutscenetocpt4","player_cutscene",[],{
				[_this] call sp_copyPlayerInventoryTo;
			}] call sp_ai_createPersonEx;

			["cpt3_pos_cutscenearmygate","cpt3_armygate",[
				["uniform","StreakCloth"]
			],{
				["RifleSVT",_this,INV_HAND_R] call createItemInInventory;
				callFunc(_this,switchTwoHands);
			}] call sp_ai_createPersonEx;

		} call sp_threadCriticalSection;

		_animStartAG = {
			["cpt3_armygate","cpt3_pos_cutscenearmygate","cutscenes\cpt3_cutscenearmyongate",{}] call sp_ai_playAnim;
		}; invokeAfterDelay(_animStartAG,4);
		_eaterScream = {
			_pos = [4426.8,3777.53,8.74983];
			_obj = "player_cutscene" call sp_ai_getMobObject;
			callFuncParams(_obj,playSound,"monster\eater\idle3" arg 0.82 arg 30 arg 1.3 arg _pos arg false);
			
		}; invokeAfterDelay(_eaterScream,5.5);

		["vr",[4434.06,3779.81,9.47894],71.3239,0.28,[-0.95584,0],0,0,720,0.198145,0,1,0,1] call sp_cam_prepCamera;
		"player_cutscene" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		["player_cutscene","cpt3_pos_cutscenetocpt4","cutscenes\cpt3_cutscenetocpt4",{},[
			["state_1",{
				callFuncParams("GateCity G:6C2bvKArl3c" call sp_getObject,setDoorOpen,true);
			}]
		]] call sp_ai_playAnim;
		[false,4] call setBlackScreenGUI;
		11 call sp_threadPause;

		
		_pos2 = ["vr",[4438.88,3781.21,11.979],70.2198,0.91,[-23.9821,0],0,0,720,0.198145,0,1,0,1];
		["all",_pos2,16.3 + 8] call sp_cam_interpTo;
		(10) call sp_threadPause;
		[true,4] call sp_gui_setBlackScreenGUI;

		5 call sp_threadPause;

		[false] call sp_cam_setCinematicCam;
		[false] call sp_gui_setCinematicMode;
		call sp_cam_stopAllInterp;
		[3] call sp_onChapterDone;
		_post = {
			call sp_cleanupSceneData;
			call sp_clearPlayerInventory;
        	["cpt4_begin"] call sp_startScene;
		}; 
		invokeAfterDelay(_post,2);
	} call sp_threadStart;
}] call sp_addScene;