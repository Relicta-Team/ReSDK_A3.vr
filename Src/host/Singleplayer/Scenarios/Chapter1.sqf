// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

#include "..\..\..\client\Inventory\inventory.hpp"

["cpt1_begin",{

	//enable input

	private _usr = call sp_getActor;

	private _bedObj = "cpt1_obj_bed" call sp_getObject;
	["cpt1_pos_bed",0] call sp_setPlayerPos;
	
	private _restDir = getDir player;
	callFuncParams(_bedObj,seatConnect,call sp_getActor);
	(getVar(_bedObj,_seatListDummy) select 0)setvariable ["_restDir",_restDir];

	callFuncParams(_usr,changeVisionBlock,+1 arg "slp");
	callFuncParams(_usr,fastSendInfo,"hud_sleep" arg 1);
	setVar(_usr,sleepStrength,1);
	setVar(_usr,__isFirstUnsleep,false);

	["right+stats"] call sp_view_setPlayerHudVisible;

	["get_memories",{
		params ["_mode"];
		if (_mode == 0) exitWith {["Я помню всё что нужно..."] call chatPrint};
		if (_mode == 1) exitWith {["Я умею всё что нужно..."] call chatPrint};
		true
	}] call sp_addPlayerHandler;
	
	{
		[
			"Добро пожаловать в Relicta. Любой раунд начинается с того, что вы просыпаетесь в кровати."
		] call sp_setNotification;

		5 call sp_threadPause;

		["open_inventory",{false}] call sp_addPlayerHandler;
		[
			"Для начала нужно проснуться. Для этого нажмите $input_act_inventory, переместите мышь вправо и выберите кнопку ""Сон""."
		] call sp_setNotification;
		_ct = [{
			_wid = widgetNull;
			{
				if (!isNullReference(_x) && {(_x getvariable "actionName") == "Сон"}) exitWith {
					_wid = _x;
				};
			} foreach interactMenu_specActWidgets;
			_wid
		}] call sp_createWidgetHighlight;

		{
			!callFunc(call sp_getActor,isSleep)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;
		refset(_ct,true);

		2 call sp_threadPause;
		callFuncParams(call sp_getActor,playSound, "emotes\sigh_male" arg getRandomPitchInRange(0.85,1.2));
		1 call sp_threadPause;
		["chap1\gg1"] call sp_audio_sayPlayer;

		["resist",{false}] call sp_addPlayerHandler;
		[
			"Чтобы встать с кровати нажмите $input_act_resist."
		] call sp_setNotification;

		{
			!callFunc(call sp_getActor,isConnected)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		1 call sp_threadPause;

		[
			"Передвижение вперёд @MoveForward,"
			+ sbr + "передвижение назад @MoveBack,"
			+ sbr + "влево @TurnLeft,"
			+ sbr + "вправо @TurnRight,"
		] call sp_setNotification;

		5 call sp_threadPause;

		[
			"Для свободного осмотра (вращения головой) удерживайте @lookAround,"
			+ sbr + "для переключения режима нажмите @lookAroundToggle"
		] call sp_setNotification;

		5 call sp_threadPause;

		["right+stats+cursor"] call sp_view_setPlayerHudVisible;
		["Курсор в центре отображает то, на что вы смотрите. Его яркость отражает уровень освещённости вашего персонажа."] call sp_setNotification;
		_ct = [
			interaction_aim_widgets select 0
		] call sp_createWidgetHighlight;
		
		5 call sp_threadPause;
		refset(_ct,true);
		
		["examine",{false}] call sp_addPlayerHandler;
		private _h = ["examine",{
			["examine_count",{ _this + 1},0] call sp_storageUpdate;
			["examine_has_update",{ true },false] call sp_storageUpdate;

			false
		}] call sp_addPlayerHandler;
		
		["Для осмотра окружающих вас объектов наведите на них курсор и нажмите $input_act_examine. Попробуйте осмотреть окружение..."] call sp_setNotification;
		{
			(["examine_count",0] call sp_storageGet) >= 2
			&& {(["examine_has_update",false] call sp_storageGet)}
		} call sp_threadWait;
		_h call sp_removePlayerHandler;

		[false] call sp_setNotificationVisible;

		2 call sp_threadPause;
		_h = ["chap1\gg2"] call sp_audio_sayPlayer;
		_h call sp_audio_waitForEndSound;

		["Для основного действия с объектами в мире нажмите $input_act_mainAction. "+
		"Например: дверь - открыть, кнопка - нажать, кровать - лечь."+
		sbr+" Откройте дверь и выходите наружу."] call sp_setNotification;

		["main_action",{false}] call sp_addPlayerHandler;
		setVar(["cpt1_bed_door"] call sp_getObject,isLocked,false);

		//wait for door open
		{ getVar(["cpt1_bed_door"] call sp_getObject,isOpen)} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		["cpt1_basemoving"] call sp_startScene;

	} call sp_threadStart;
	
}] call sp_addScene;

["cpt1_basemoving", {
	["Снова в путь","Отправляйтесь в пещеры и найдите новое пристанище"] call sp_setTaskMessageEff;
}] call sp_addScene;

["cpt1_trg_Xbutton",{
	{
		["Чтобы пригнуться нажмите @MoveUp"] call sp_setNotification;
		{
			callFunc(call sp_getActor,getStance) <= STANCE_MIDDLE
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_Zbutton",{
	{
		["Чтобы лечь нажмите @MoveDown"] call sp_setNotification;
		{
			callFunc(call sp_getActor,getStance) <= STANCE_DOWN
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;
		[true] call sp_setHideTaskMessageCtg;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_ZbuttonUp",{
	{
		_h = ["Чтобы встать нажмите ещё раз @MoveDown, либо @MoveUp"] call sp_setNotification;
		{
			callFunc(call sp_getActor,getStance) != STANCE_DOWN
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_walkbutton",{
	{
		_h = ["Чтобы переключиться на медленный шаг нажмите @WalkRunToggle"] call sp_setNotification;
		private _tReset = tickTime + 5;
		{
			callFunc(call sp_getActor,isWalking)
			|| (tickTime >= _tReset)
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_campfiresee",{
	{
		_h = ["chap1\gg3"] call sp_audio_sayPlayer;
		_h call sp_audio_waitForEndSound;
		["chap1\gg4"] call sp_audio_sayPlayer;
		2 call sp_threadPause;
		["cpt1_looting"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

//spawn cpt1_pos_looting
["cpt1_looting",{
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	["Остатки цивилизации","Осмотрите ящики на наличие ценных предметов"] call sp_setTaskMessageEff;

	{
		_bpref = "cpt1_looting_bottle";
		_barr = [];
		for "_i" from 1 to 2 do {
			private _probbottle = (_bpref + (str _i)) call sp_getObject;
			if !isNullReference(_probbottle) then {
				_barr pushBack _probbottle;
			};
		};

		{
			any_of(_barr apply {callFuncParams(_x,getDistanceTo,call sp_getActor arg true) <= 2})
		} call sp_threadWait;

		["У вас есть 2 свободных руки, в которые можно взять любые предметы."+
		"Чтобы взять предметы с земли нажмите ЛКМ нацелившись на необходимый предмет - он будет взят в активную руку. Для изменения активной руки нажмите $input_act_changeActHand."+
		sbr+" Попробуйте подобрать бутылку возле костра."] call sp_setNotification;

		_actHand = [{getVar(call sp_getActor,activeHand) call inventoryGetWidgetById}] call sp_createWidgetHighlight;
		["cpt1_looting_evt_changeHandHandler",[_actHand]] call sp_storageSet;
		_hChangeActHand = ["change_active_hand",{
			_d = ["cpt1_looting_evt_changeHandHandler",[refcreate(false)]] call sp_storageGet;
			refset(_d select 0,true);
			_d set [0,
				[{getVar(call sp_getActor,activeHand) call inventoryGetWidgetById}] call sp_createWidgetHighlight
			];
			false
		}] call sp_addPlayerHandler;

		{
			any_of(_barr apply {equals(callFunc(_x,getSourceLoc),call sp_getActor)})
		} call sp_threadWait;

		_d = ["cpt1_looting_evt_changeHandHandler",[refcreate(false)]] call sp_storageGet;
		refset(_d select 0,true);
		_hChangeActHand call sp_removePlayerHandler;

		["Чтобы положить предмет нажмите $input_act_putdownitem. Предметы выкладываются из активной руки на место, в которое смотрит ваш персонаж. Чтобы быстро выбросить предмет - нажмите $input_act_dropitem."+
		"Однако, будьте осторожны - хрупкие предметы могут разбиться от падения на твёрдые поверхности"] call sp_setNotification;

		{
			all_of(_barr apply {not_equals(callFunc(_x,getSourceLoc),call sp_getActor)})
		} call sp_threadWait;

		["Действия с предметами можно проводить в режиме открытого инвентаря ($input_act_inventory). В этом режиме, например, вы так же можете точнее выкладывать предметы, перетягивая их из слота руки в мир и поворачивая колесом мыши"] call sp_setNotification;
		
		10 call sp_threadPause;
		[false] call sp_setNotificationVisible;

	} call sp_threadStart;

	_objname = "cpt1_obj_loot";
	_objlist = [];
	for "_i" from 1 to 6 do {
		_objlist pushBack ((_objname + (str _i)) call sp_getObject);
	};
	["cpt1_loot_objlist",_objlist] call sp_storageSet;
	["cpt1_loot_objlist_lootCreated",[]] call sp_storageSet;	

	//enable inventory buttons
	["open_inventory",{false}] call sp_addPlayerHandler;

	["change_active_hand",{false}] call sp_addPlayerHandler;
	["click_target",{false}] call sp_addPlayerHandler;
	["interact_with",{false}] call sp_addPlayerHandler;
	["transfer_slots_item",{false}] call sp_addPlayerHandler;
	["drop_item",{false}] call sp_addPlayerHandler;
	["putdown_item",{false}] call sp_addPlayerHandler;

	_h = ["main_action",{
		params ["_t"];
		if (_t in (["cpt1_loot_objlist",[]] call sp_storageGet)) then {
			_catch = ["cpt1_loot_objlist_lootCreated",[]] call sp_storageGet;
			if !(_t in _catch) then {
				_catch pushBack _t;
				_newcnt = count _catch ;
				if (_newcnt == 1) exitWith {
					_obj = ["HatUshanka",_t] call createItemInContainer;
					["cpt_1_lootobj1",_obj] call sp_storageSet;

					setVar(_obj,name,"Старая шапка");
					["Одежда помогает согреться и защищает вашего персонажа. Только что вы нашли шапку. Перетащите её в слот любой свободной руки, а затем на слот головы."] call sp_setNotification;
					_refItm = [{
						
						_wid = widgetNull;
						{
							private _desc = ctrltooltip (_x getvariable "icon");
							if (equals("Старая шапка",_desc)) then { //SD_NAME
								_wid = _x getvariable "icon";
							};
						} foreach inventory_containerSlots;
						_wid
					},0.04] call sp_createWidgetHighlight;

					_refHandLeft = [
						INV_HAND_L call inventoryGetWidgetById
					] call sp_createWidgetHighlight;
					_refHandRight = [
						INV_HAND_R call inventoryGetWidgetById
					] call sp_createWidgetHighlight;

					_refHead = [{
						INV_HEAD call inventoryGetWidgetById;
					}] call sp_createWidgetHighlight;


					[{
						params ["_obj","_refItm","_refHndArr","_refHead"];
						{
							equals(call sp_getActor,callFunc(_obj,getSourceLoc))
						} call sp_threadWait;

						refset(_refItm,true);
						{refset(_x,true)} foreach _refHndArr;

						{
							!callFuncParams(call sp_getActor,isEmptySlot,INV_HEAD)
						} call sp_threadWait;

						refset(_refHead,true);

						[false] call sp_setNotificationVisible;

					},[_obj,_refItm,[_refHandLeft,_refHandRight],_refHead]] call sp_threadStart;

				};
				if (_newcnt == 2) exitwith {
					_obj = ["TorchDisabled",_t] call createItemInContainer;
					["Вы нашли Факел - незаменимую вещь в Сети. Возьмите его и вернитесь к костру."] call sp_setNotification;
					["cpt1_loot_torchItem",_obj] call sp_storageSet;
					{
						_obj = ["cpt1_loot_torchItem",nullPtr] call sp_storageGet;
						_camp = "cpt1_loot_campfire" call sp_getObject;
						if isNullReference(_obj) exitWith {};

						{
							callFuncParams(callFunc(_obj,getSourceLoc),getDistanceTo,_camp) <= 1
						} call sp_threadWait;

						["Для того, чтобы зажечь факел нажмите ЛКМ с факелом в активной руке по костру"] call sp_setNotification;

						{
							getVar(_obj,lightIsEnabled)
						} call sp_threadWait;
						
						["Затушить факел можно, нажав $input_act_mainAction по нему."] call sp_setNotification;
						private _tOff = tickTime + 5;
						{
							tickTime >= _tOff
							|| !getVar(_obj,lightIsEnabled)
						} call sp_threadWait;
						[false] call sp_setNotificationVisible;

					} call sp_threadStart;
				};
				if (_newcnt == 3) exitWith {
					_obj = ["Paper",_t] call createItemInContainer;
					setVar(_obj,name,"Карта");
					setVar(_obj,desc,"Нарисованная от руки схема ближайших пещер.");
					["cpt1_loot_mapItem",_obj] call sp_storageSet;
					
					["Возьмите карту"] call sp_setNotification;
					{
						_obj = ["cpt1_loot_mapItem",nullPtr] call sp_storageGet;
						if isNullReference(_obj) exitWith {};

						{
							equals(call sp_getActor,callFunc(_obj,getSourceLoc))
						} call sp_threadWait;

						["cpt1_foundmap"] call sp_startScene;

						[false] call sp_setNotificationVisible;
						[true] call sp_setHideTaskMessageCtg;
					} call sp_threadStart;
				};
			};
			
		};
		false
	}] call sp_addPlayerHandler;

	{
		_lst = (["cpt1_loot_objlist",[]] call sp_storageGet);
		_act = call sp_getActor;
		{
			any_of(_lst apply {callFuncParams(_x,getDistanceTo,_act arg true) <= 3 && callFuncParams(_act,canSeeObject,_x)})
		} call sp_threadWait;

		["Чтобы посмотреть содержимое ящиков, сумок, одежды и контейнеров - нажмите $input_act_mainAction"] call sp_setNotification;

		{
			inventory_isOpenContainer
		} call sp_threadWait;

	} call sp_threadStart;

}] call sp_addScene;

["cpt1_foundmap",{
	{
		_h = [
			"chap1\gg5",
			"chap1\gg6",
			"chap1\gg7",
			"chap1\gg8"
		] call sp_audio_sayPlayerList;
		_h call sp_threadWaitForEnd;
		_wall = "cpt1_loot_wall_topart2" call sp_getObject;
		if !isNullReference(_wall) then {
			[_wall] call deleteStructure;
		};
		["cpt1_walk_topart2"] call sp_startScene;

	} call sp_threadStart;
}] call sp_addScene;

["cpt1_walk_topart2",{
	["Новый дом","Отправляйтесь к ближайшему городу через коллекторы"] call sp_setTaskMessageEff;
}] call sp_addScene;

["cpt1_trg_founddoor",{
	
	["chap1\gg9"] call sp_audio_sayPlayer;
	["Вы также можете взаимодействовать с миром через ПКМ меню. Попробуйте открыть дверь с помощью ПКМ, выбрав пункт ""Открыть"""] call sp_setNotification;
	["load_verbs",{
		params ["_targ","_verbs"];
		if equals(_targ,"cpt1_obj_doortopart2" call sp_getObject) then {
			[_verbs,{
				params ["_name","_id"];
				_name in ["description","mainact"]
			}] call sp_filterVerbsOnHandle;
		};
		false
	}] call sp_addPlayerHandler;

	["activate_verb",{
		params ["_t","_name"];
		if (_name == "mainact") then {
			if equals(_t,"cpt1_obj_doortopart2" call sp_getObject) then {
				["chap1\gg10"] call sp_audio_sayPlayer;
				[false] call sp_setNotificationVisible;
				call sp_removeCurrentPlayerHandler;
				["cpt1_walk_searchkey"] call sp_startScene;
			};
		};
	}] call sp_addPlayerHandler;

	// ["main_action",{
	// 	params ["_t"];
	// 	if equals(_t,"cpt1_obj_doortopart2" call sp_getObject) then {
	// 		["chap1\gg10"] call sp_audio_sayPlayer;
	// 		[false] call sp_setNotificationVisible;
	// 		call sp_removeCurrentPlayerHandler;
	// 		["cpt1_walk_searchkey"] call sp_startScene;
	// 	};
	// 	false
	// }] call sp_addPlayerHandler;
	
}] call sp_addScene;

["cpt1_walk_searchkey",{
	["Новый дом","Найдите способ открыть дверь"] call sp_setTaskMessageEff;
	{
		{
			equals(call sp_getActor,callFunc("cpt1_obj_keytopart2" call sp_getObject,getSourceLoc))
		} call sp_threadWait;
		["Новый дом","Откройте дверь"] call sp_setTaskMessageEff;

		{
			callFuncParams("cpt1_obj_doortopart2" call sp_getObject,getDistanceTo,call sp_getActor arg true) <= 3
			&& equals(call sp_getActor,callFunc("cpt1_obj_keytopart2" call sp_getObject,getSourceLoc))
		} call sp_threadWait;

		["Чтобы открыть дверь с помощью ключа - возьмите его в руку и нажмите ЛКМ, нацелившись на дверь"] call sp_setNotification;
		{
			!getVar("cpt1_obj_doortopart2" call sp_getObject,isLocked)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		{
			getVar("cpt1_obj_doortopart2" call sp_getObject,isOpen)
		} call sp_threadWait;
		[true] call sp_setHideTaskMessageCtg;
		["cpt1_walk_final"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_walk_final",{
	{
		{
			getVar("cpt1_obj_finaldoor" call sp_getObject,isOpen)
		} call sp_threadWait;

		[""] call sp_view_setPlayerHudVisible;
		[true,2.5] call setBlackScreenGUI;
		2.5 call sp_threadPause;

		["cpt2_begin"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;
