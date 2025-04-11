// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"
cpt3_hudvis_default = "right+stats+cursor+inv";
cpt3_hudvis_eaterzone = cpt3_hudvis_default + "+left";
cpt3_hudvis_eatercombat = cpt3_hudvis_eaterzone + "+up";
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
		_eaterBdy hideObject true;
	};
	_eater = _eaterBdy getvariable "link";

	callFuncParams(_eater,generateNaming,"Сонный" arg "Жрун");
	["Castoffs1",_eater,INV_CLOTH] call createItemInInventory;

	_eaterBdy switchmove "ApanPercMstpSnonWnonDnon_G01";
	_eaterBdy setface "persianhead_a3_01_player";//disable eater head


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
		["chap3\gg1"] call sp_audio_sayPlayer;

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
		if not_equals("cpt3_obj_lockeddoor" call sp_getObject,this) exitWith {
			callFuncParams(_usr,mindSay,"Слишком сложный замок...");
		};
		if getSelf(isOpen) exitWith {};

		callFuncParams(_usr,mindSay,"Мне удалось взломать замок... но отмычка не пережила это.");
		callSelfParams(setDoorLock,false arg false);
		nextFrame({delete(_this)},_lockpick);
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
		+sbr+sbr+"Нажмите $input_act_inventory, переместите мышь влево и в выезжающем меню перейдите в раздел ""восприятие"". "
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
		{
			[0,1.5,0.01,0.5] call cam_addCamShake;
		} call sp_threadCriticalSection;

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

		_hmes = ["Активное особое действие отображается в статусах справа. Каждое активное действие устанавливается для левой и правой руки отдельно. Для активации особого действия нажмите $input_act_extraAction нацелившись в сторону жруна."] call sp_setNotification;
		
		_hact = ["extra_action",{
			params ["_targ"];
			_trch = callFunc(call sp_getActor,getItemInActiveHandRedirect);
			if (isNullReference(_trch)) exitWith {true};
			if !isTypeOf(_trch,Torch) exitWith {true};
			
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

		0.5 call sp_threadPause;
		["chap3\gg2"] call sp_audio_sayPlayer;

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

["cpt3_trg_stealthguide",{

	//eater stealth handler
	{
		_eater = "cpt3_eater" call sp_ai_getMobObject;
		while {!getVar(_eater,isDead)} do {
			_refm = refcreate(0);
			if (callFuncParams(_eater,canSeeObject,call sp_getActor arg _refm)
				&& !getVar(call sp_getActor,isStealthEnabled)
			) then {
				//уже за спиной у жруна
				if (callFuncParams(call sp_getActor,getDirTo,_eater) == DIR_BACK) exitWith {};

				if (refget(_refm) >= VISIBILITY_MODE_LOW) then {
					{
						
						[_eater,null,"cpt3_eater_attack",{
							params ["_mob"];
							[_mob,"cpt3_pos_eaterstealth",0] call sp_ai_setMobPos;
							_mob switchmove "ApanPercMstpSnonWnonDnon_G01";
						}] call sp_ai_playAnim;

						callFuncParams(_eater,playSound,"monster\eater\scream5" arg getRandomPitchInRange(0.9,1.1) arg 50 arg 2.2 arg null arg false);
						_c = { [0.23,30.5,0.05,0.8] call cam_addCamShake; };
						invokeAfterDelay(_c,0.45);
						[true,1.8] call setBlackScreenGUI;
						callFuncParams(call sp_getActor,setStealth,false);
						["cpt3_flag_caneatercheck",false] call sp_storageSet;
						
					} call sp_threadCriticalSection;
					_post = {
						["cpt3_flag_caneatercheck",true] call sp_storageSet;
						["cpt3_pos_onfailstealth",0] call sp_setPlayerPos;
						[false,1.1] call setBlackScreenGUI;
					}; invokeAfterDelay(_post,3);

					{
						(["cpt3_flag_caneatercheck",false] call sp_storageGet)
					} call sp_threadWait;
					
				};
			};
		};
		
	} call sp_threadStart;

	{
		_notifHandle = ["Чтобы двигаться незаметно для других перейдите в режим скрытности. Для этого в правом меню нажмите ""Прятаться""."] call sp_setNotification;

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
		[false,_notifHandle] call sp_setNotificationVisible;
		refset(_ct,true);

		["Прятки со смертью","Незаметно подкрадитесь к жруну сзади"] call sp_setTaskMessageEff;

	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_stealthlightnotif",{
	{
		_h = ["<t align='left'>Скрытное передвижение прекратится в следующих случаях:"
			+sbr+ " - Яркое освещение"
			+sbr+ " - Быстрое передвижение"
			+sbr+ " - Враг бдительно осматривается или прислушивается"
			+sbr+ " - Вы атаковали кого-то или получили урон"
			+ "</t>"
		] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_attackeater",{
	[cpt3_hudvis_eatercombat] call sp_view_setPlayerHudVisible;
	["click_target",{
		params ["_t"];
		_ret = true;
		_eater = "cpt3_eater" call sp_ai_getMobObject;
		if equals(_t,_eater) then {
			if not_equals(callFunc(call sp_getActor,getItemInActiveHandRedirect),"cpt3_obj_caveaxeguide" call sp_getObject) exitWith {};
			if (getVar(call sp_getActor,isCombatModeEnable)) then {
				_ret = false;
				_tzSel = [getVar(call sp_getActor,curTargZone)] call gurps_convertTargetZoneToBodyPart;
				
				if (_tzSel != BP_INDEX_TORSO) then {
					callFuncParams(_eater,lossLimb,_tzSel);
				};
				
				setVar(_eater,isDead,true);
				getVar(_eater,owner) switchMove "Acts_StaticDeath_05";
				call sp_removeCurrentPlayerHandler;
			};
		};
		_ret
	}] call sp_addPlayerHandler;

	{
		_h = ["Чтобы атаковать противника перейдите в боевой режим, нажав $input_act_combatMode"] call sp_setNotification;
		{
			getVar(call sp_getActor,isCombatModeEnable)
		} call sp_threadWait;

		_hWidget = [{
			_wid = widgetNull;
			_d = getDisplay;
			if isNullReference(_d) exitWith {_wid};
			_d getvariable ["combatMenuCtg",widgetNull]
		},0.02] call sp_createWidgetHighlight;

		_h = ["Нажмите $input_act_inventory. В верхнем меню вы можете настроить способы атаки и защиты, а справа настраивается зона атаки - место куда вы будете бить противника."+
		sbr+"Как будете готовы атаковать - нажмите ЛКМ для атаки"] call sp_setNotification;

		{
			getVar("cpt3_eater" call sp_ai_getMobObject,isDead)
		} call sp_threadWait;
		
		refset(_hWidget,true);
		[false,_h] call sp_setNotificationVisible;

		["cpt3_lightswitch",false] call sp_storageSet;
		[true] call sp_setHideTaskMessageCtg;

		1.2 call sp_threadPause;

		_sound = ["chap3\gg3"] call sp_audio_sayPlayer;
		_sound call sp_audio_waitForEndSound;

		_threadlook = {
			{
				callFuncParams(call sp_getActor,canSeeObject,"cpt3_obj_doordestr" call sp_getObject)
			} call sp_threadWait;
			[
				"chap3\gg4",
				"chap3\gg5"
			] call sp_audio_sayPlayerList;
		} call sp_threadStart;
		
		_threadlook = call sp_threadWaitForEnd;
		
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
		["chap3\gg6"] call sp_audio_sayPlayer;
		
		1 call sp_threadPause;

		["Вы можете разрушать объекты с помощью вашего оружия. Для этого нажмите ЛКМ в боевом режиме по двери"] call sp_setNotification;
		_obj = "cpt3_obj_doordestr" call sp_getObject;
		//callFuncParams(_obj,setHPCurrentPrecentage,10);

		["click_target",{
			params ["_t"];
			_hret = true;
			if (!getVar(call sp_getActor,isCombatModeEnable)) exitWith {_hret};
			if equals(_t,"cpt3_obj_doordestr" call sp_getObject) then {
				_t call cpt3_func_damageEvent;
				if ((["cpt3_ctr_doordam",{_this + 1},0] call sp_storageUpdate) >= 4) then {
					[false] call sp_setNotificationVisible;
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
	} call sp_threadStart;
}] call sp_addScene;

["t3_trg_foundgate",{
	["chap3\gg7"] call sp_audio_sayPlayer;
}] call sp_addScene;

["cpt3_trg_ongate",{
	//cpt3_obj_radio - speaker
	//cpt3_obj_bigspeaker - big speaker
	{
		[
			[player,"chap3\gg8"],
			["cpt3_obj_radio","chap3\radio1",["endoffset",2]],

			[player,"chap3\gg9",["endoffset",3.1]], 
			["cpt3_obj_radio","chap3\radio2",["endoffset",-2]],

			[player,"chap3\gg10",["endoffset",2]], 
			["cpt3_obj_radio","chap3\radio3",["endoffset",2]],

			[player,"chap3\gg11",["endoffset",3.1]], 
			["cpt3_obj_radio","chap3\radio4",["onend",{
				["cpt3_onend"] call sp_startScene;
			}]]
		] call sp_audio_startDialog;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_onend",{
	[""] call sp_view_setPlayerHudVisible;
    [true] call sp_setHideTaskMessageCtg;
	[true,2] call setBlackScreenGUI;
	{
        3 call sp_threadPause;
        ["cpt4_begin"] call sp_startScene;
    } call sp_threadStart;
}] call sp_addScene;