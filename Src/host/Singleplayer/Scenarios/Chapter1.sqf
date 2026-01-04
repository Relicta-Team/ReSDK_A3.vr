// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

#include "..\..\..\client\Inventory\inventory.hpp"

cpt1_playerUniform = "NomadCloth9";

["cpt1_begin",{

	if isNullReference(callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH)) then {
		[cpt1_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;
	};

	//enable input
	call sp_initializeDefaultPlayerHandlers;
	[call sp_getActor] call sp_loadCharacterData;

	[null,null,{
		params ["_t","_wid"];
		_tlist = ["Сон"];
		array_exists(_tlist,_t);
	}] call sp_gui_setInventoryVisibleHandler;

	private _usr = call sp_getActor;

	private _bedObj = "cpt1_obj_bed" call sp_getObject;
	["cpt1_pos_bed",0] call sp_setPlayerPos;
	
	private _restDir = getDir player;
	callFuncParams(_bedObj,seatConnect,call sp_getActor);
	(getVar(_bedObj,_seatListDummy) select 0)setvariable ["_restDir",_restDir];

	callFuncParams(_usr,changeVisionBlock,+1 arg "slp");
	callFuncParams(_usr,fastSendInfo,"hud_sleep" arg 1);
	setVar(_usr,sleepStrength,1);

	["right+stats"] call sp_view_setPlayerHudVisible;

	{
		[
			"Добро пожаловать в #(Relicta)! Впереди вас ждёт пошаговое обучение - новые возможности будут открываться постепенно. "
			+"Внимательно читайте #(уведомления) в этом окне: они подскажут, как освоиться в игре. "
			+"Но помните: не всё будет разжёвано - иногда потребуется проявить #(смекалку) и разобраться самому."
		] call sp_setNotification;

		15 call sp_threadPause;

		["Для начала нажмите $input_act_inventory"] call sp_setNotification;
		["open_inventory",false] call sp_setLockPlayerHandler;
		{
			isInventoryOpen
		} call sp_threadWait;

		[
			"Только что вы перешли в режим #(взаимодействия и инвентаря). Переместив мышь вправо вы увидите панель взаимодействия с навыками персонажа, зонами взаимодействия и кнопками особых действий."
		] call sp_setNotification;

		_zoneH = [{
			private _d = getDisplay;
			if isNullReference(_d) exitWith {widgetNull};

			_d getvariable ["interactMenuCtg",widgetNull];
		},0.02] call sp_createWidgetHighlight;

		15 call sp_threadPause;

		["press_specact",false] call sp_setLockPlayerHandler;
		_unsleepHandle = ["press_specact",{
			params ["_id"];
			_id != SPECIAL_ACTION_SLEEP
		}] call sp_addPlayerHandler;

		[
			"Любая смена в Сети начинается с пробуждения в кровати. Попробуем разбудить вашего персонажа. Для этого переместите мышь вправо и нажмите кнопку #(""Сон"") в нижней части панели взаимодействия и ваш персонаж начнёт просыпаться."
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
		
		//["press_specact",true] call sp_setLockPlayerHandler;
		_unsleepHandle call sp_removePlayerHandler;
		["press_specact",{
			params ["_id"];
			if (_id == SPECIAL_ACTION_SLEEP) then {
				callFuncParams(call sp_getActor,mindSay,"Я не хочу больше спать");
			};
			true
		}] call sp_addPlayerHandler;

		[false] call sp_setNotificationVisible;
		refset(_zoneH,true);
		refset(_ct,true);

		2 call sp_threadPause;
		callFuncParams(call sp_getActor,playSound, "emotes\sigh_male" arg 0.92);
		1.8 call sp_threadPause;
		["chap1\gg1"] call sp_audio_sayPlayer;

		if (isInventoryOpen) then {
			["Снова нажмите $input_act_inventory чтобы закрыть режим взаимодействия и инвентаря"] call sp_setNotification;
			{
				!isInventoryOpen
			} call sp_threadWait;
		};	

		["resist",false] call sp_setLockPlayerHandler;
		[
			"Чтобы встать с кровати нажмите $input_act_resist."
		] call sp_setNotification;

		{
			!callFunc(call sp_getActor,isConnected)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		2 call sp_threadPause;

		["chat+right+stats+cursor"] call sp_view_setPlayerHudVisible;
		["#(Прицел) в центре обозначает вашу цель - то, на что вы смотрите и с чем собираетесь взаимодействовать. Его яркость отражает уровень освещённости вашего персонажа."] call sp_setNotification;
		_ct = [
			interaction_aim_widgets select 0
		] call sp_createWidgetHighlight;
		
		7 call sp_threadPause;
		refset(_ct,true);
		
		["examine",false] call sp_setLockPlayerHandler;
		private _h = ["examine",{
			["examine_count",{ _this + 1},0] call sp_storageUpdate;
			["examine_has_update",{ true },false] call sp_storageUpdate;

			false
		}] call sp_addPlayerHandler;
		
		["Для #(осмотра) любых окружающих вас объектов наведитесь на них прицелом и нажмите $input_act_examine. В вашем временном пристанище много интересного. Попробуйте осмотреть окружение..."] call sp_setNotification;
		{
			(["examine_count",0] call sp_storageGet) >= 2
			&& {(["examine_has_update",false] call sp_storageGet)}
		} call sp_threadWait;
		_h call sp_removePlayerHandler;

		[false] call sp_setNotificationVisible;

		2 call sp_threadPause;
		_h = ["chap1\gg2"] call sp_audio_sayPlayer;
		_h call sp_audio_waitForEndSound;

		["Для #(основного действия) с объектами в мире нажмите $input_act_mainAction. Откройте дверь и выходите наружу."] call sp_setNotification;

		["main_action",false] call sp_setLockPlayerHandler;
		setVar(["cpt1_bed_door"] call sp_getObject,isLocked,false);

		//wait for door open
		{ getVar(["cpt1_bed_door"] call sp_getObject,isOpen)} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		//lamp disabling handler
		{
			rand(2,4) call sp_threadPause;
			{
				if (getVar("cpt1_obj_beginlamp" call sp_getObject,lightIsEnabled)) then {
					callFuncParams("cpt1_obj_beginlamp" call sp_getObject,worldSay,"Лампа начинает угасать" arg "act");
				};
			} call sp_threadCriticalSection;
			
			rand(4,5) call sp_threadPause;
			{
				if (getVar("cpt1_obj_beginlamp" call sp_getObject,lightIsEnabled)) then {
					callFuncParams("cpt1_obj_beginlamp" call sp_getObject,lightSetMode,false);
					callFuncParams("cpt1_obj_beginlamp" call sp_getObject,worldSay,"Лампа затухает" arg "act");
				};
			} call sp_threadCriticalSection;

		} call sp_threadStart;

		["cpt1_basemoving"] call sp_startScene;

	} call sp_threadStart;
	
}] call sp_addScene;

["cpt1_basemoving", {
	["tomb"] call sp_audio_playMusic;
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
		{
			callFunc(call sp_getActor,getStance) != STANCE_DOWN
		} call sp_threadWait;
		
		1 call sp_threadPause;

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
	["chat+right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	["Остатки цивилизации","Осмотрите ящики на наличие ценных предметов"] call sp_setTaskMessageEff;

	{
		4 call sp_threadPause;
		["hellocave"] call sp_audio_playMusic;
	} call sp_threadStart;

	private _scrHndl = {
		_bpref = "cpt1_looting_bottle";
		_barr = [];
		for "_i" from 1 to 2 do {
			private _probbottle = (_bpref + (str _i)) call sp_getObject;
			if !isNullReference(_probbottle) then {
				_barr pushBack _probbottle;
			};
		};

		{
			any_of(_barr apply {callFuncParams(_x,getDistanceTo,call sp_getActor arg true) <= 3})
		} call sp_threadWait;

		_baseInteractHandle = ["У вас есть 2 свободных руки. Чтобы #(взять предметы) нажмите ЛКМ по ним."
		+sbr+"Для смены активной руки нажмите $input_act_changeActHand. Попробуйте подобрать бутылку."] call sp_setNotification;

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
		["cpt1_looting_evt_handleChangeActiveHand",_hChangeActHand] call sp_storageSet;

		{
			any_of(_barr apply {equals(callFunc(_x,getSourceLoc),call sp_getActor)})
			|| !callFunc(call sp_getActor,isEmptyActiveHand)
		} call sp_threadWait;

		_d = ["cpt1_looting_evt_changeHandHandler",[refcreate(false)]] call sp_storageGet;
		refset(_d select 0,true);
		_hChangeActHand call sp_removePlayerHandler;

		["Чтобы #(положить предмет) нажмите $input_act_putdownitem. Чтобы #(выбросить) - нажмите $input_act_dropitem."] call sp_setNotification;
		{
			all_of(_barr apply {not_equals(callFunc(_x,getSourceLoc),call sp_getActor)})
		} call sp_threadWait;

		_baseInteractHandle = [
			"В режиме #(открытого инвентаря) ($input_act_inventory):"
			+sbr+"ЛКМ = #(подбор), перетаскивание из руки = #(выкладывание) на поверхность, СКМ (крутить) = #(поворот) предмета"] call sp_setNotification;
		
		10 call sp_threadPause;
		[false,_baseInteractHandle] call sp_setNotificationVisible;

	} call sp_threadStart;
	["cpt1_looting_data_firstinventory_threadhandle",_scrHndl] call sp_storageSet;

	_objname = "cpt1_obj_loot";
	_objlist = [];
	for "_i" from 1 to 6 do {
		_objlist pushBack ((_objname + (str _i)) call sp_getObject);
	};
	["cpt1_loot_objlist",_objlist] call sp_storageSet;
	["cpt1_loot_objlist_lootCreated",[]] call sp_storageSet;	

	//enable inventory buttons
	["item_action",false] call sp_setLockPlayerHandler;

	//антизатухалка костра
	["main_action",{
		params ["_t"];
		if equals(_t,"cpt1_loot_campfire" call sp_getObject) exitWith {
			[pick[
				"Да я могу затушить этот костёр. Но зачем?..",
				"Было бы глупо сейчас затушить единственный источник огня.",
				"Не стоит тушить единственный в округе костёр..."
			],"mind"] call chatPrint;

			true
		};
		null //bypass main action activation
	}] call sp_addPlayerHandler;

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
					};
					if (_newcnt == 2) exitwith {
						_obj = ["TorchDisabled",_t] call createItemInContainer;
						["cpt1_loot_torchItem",_obj] call sp_storageSet;
						
					};
					if (_newcnt == 3) exitWith {
						_obj = ["Paper",_t] call createItemInContainer;
						setVar(_obj,name,"Карта");
						setVar(_obj,desc,"Нарисованная от руки схема ближайших пещер.");
						["cpt1_loot_mapItem",_obj] call sp_storageSet;
						call sp_removeCurrentPlayerHandler;
					};
				};
				
				false
			} else {
				//всё кроме контейнеров лочится
				
				// и одежды тоже потому что юзер может убрать факел в карман...
				if (equals(callFuncParams(call sp_getActor,getItemInSlotRedirect,INV_CLOTH),_t)) exitWith {false};
				// и факел тоже потому что там тест факела в стадии 2
				if isTypeOf(_t,Torch) exitWith {false};

				true
			};
		}] call sp_addPlayerHandler;
		["cpt1_looting_evt_clothHandler",
			[
				//disable cloth closer
				["main_action",{
					params ["_t"];
					if (isTypeOf(_t,Cloth)) exitWith {
						true
					};
					false
				}] call sp_addPlayerHandler,
				//disable torch transfer with interact
				["interact_with",{
					params ["_item","_with"];
					if (callFunc(_item,isContainer) && {isTypeOf(_with,Torch)}) exitWith {
						true
					};
					false
				}] call sp_addPlayerHandler,
				//disable torch transfer with click
				["click_target",{
					params ["_t"];
					if (callFunc(_t,isContainer) && isTypeOf(callFunc(call sp_getActor,getItemInActiveHandRedirect),Torch)) exitWith {
						true
					};
					false
				}] call sp_addPlayerHandler
			]
		] call sp_storageSet;

	{
		_lst = (["cpt1_loot_objlist",[]] call sp_storageGet);
		_searchedList = ["cpt1_loot_objlist_lootCreated",[]] call sp_storageGet;
		
		_act = call sp_getActor;
		{
			any_of(_lst apply {callFuncParams(_x,getDistanceTo,_act arg true) <= 3 && callFuncParams(_act,canSeeObject,_x)})
		} call sp_threadWait;

		{
			_h = ["cpt1_looting_data_firstinventory_threadhandle",nullPtr] call sp_storageGet;
			_h call sp_threadStop;
			private _hinv = ["cpt1_looting_evt_changeHandHandler",[refcreate(false)]] call sp_storageGet;
			refset(_hinv select 0,true);

			private _hsw = ["cpt1_looting_evt_handleChangeActiveHand",null] call sp_storageGet;
			if !isNullVar(_hsw) then {
				_hsw call sp_removePlayerHandler;
			};
		} call sp_threadCriticalSection;

		["Чтобы посмотреть содержимое #(контейнеров) в мире - нажмите $input_act_mainAction"] call sp_setNotification;

		
		while {true} do {
			if (inventory_isOpenContainer) then {
				0.5 call sp_threadPause;
				if (inventory_isOpenContainer && {!isNullReference(["cpt_1_lootobj1" arg nullPtr] call sp_storageGet)}) then {break};
			};
			0.2 call sp_threadPause;
		};
		sp_playerCanMove = false;

		_obj = ["cpt_1_lootobj1",nullPtr] call sp_storageGet;
		["Вы нашли шапку. #(Достаньте) её из ящика, перетащив на слот руки, а затем #(наденьте) на себя - перетащив на слот головы."] call sp_setNotification;
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
		
		{
			equals(call sp_getActor,callFunc(_obj,getSourceLoc))
		} call sp_threadWait;

		refset(_refItm,true);
		{refset(_x,true)} foreach [_refHandLeft,_refHandRight];

		{
			!callFuncParams(call sp_getActor,isEmptySlot,INV_HEAD)
		} call sp_threadWait;

		refset(_refHead,true);

		[false] call sp_setNotificationVisible;
		sp_playerCanMove = true;

		// second item check
		while {true} do {
			if (inventory_isOpenContainer) then {
				0.5 call sp_threadPause;
				if (inventory_isOpenContainer && {count _searchedList == 2} && {!isNullReference(["cpt1_loot_torchItem" arg nullPtr] call sp_storageGet)}) then {break};
			};
			0.2 call sp_threadPause;
		};

		{
			["Вы нашли факел. #(Возьмите) его и вернитесь к костру."] call sp_setNotification;
			_obj = ["cpt1_loot_torchItem",nullPtr] call sp_storageGet;
			_camp = "cpt1_loot_campfire" call sp_getObject;
			if isNullReference(_obj) exitWith {};

			{
				callFuncParams(callFunc(_obj,getSourceLoc),getDistanceTo,_camp arg true) <= 1.7
			} call sp_threadWait;

			["#(Зажгите) факел: нажмите ЛКМ по костру с факелом в #(активной руке)"] call sp_setNotification;

			{
				getVar(_obj,lightIsEnabled)
			} call sp_threadWait;
			
			["Чтобы #(затушить) факел нажмите $input_act_mainAction по нему"] call sp_setNotification;
			private _tOff = tickTime + 5;
			{
				tickTime >= _tOff
				|| !getVar(_obj,lightIsEnabled)
			} call sp_threadWait;
			[false] call sp_setNotificationVisible;

			{
				//disable torch light off
				call cpt2_act_enableTorchHadnler;
			} call sp_threadCriticalSection;

		} call sp_threadStart;

		//third item check
		while {true} do {
			if (inventory_isOpenContainer) then {
				0.5 call sp_threadPause;
				if (inventory_isOpenContainer && {count _searchedList == 3} && {!isNullReference(["cpt1_loot_mapItem" arg nullPtr] call sp_storageGet)}) then {break};
			};
			0.2 call sp_threadPause;
		};
						
		["Вы нашли карту. #(Возьмите) её"] call sp_setNotification;
		_obj = ["cpt1_loot_mapItem",nullPtr] call sp_storageGet;
		if !isNullReference(_obj) then {
			{
				equals(call sp_getActor,callFunc(_obj,getSourceLoc))
			} call sp_threadWait;

			[false] call sp_setNotificationVisible;
			[true] call sp_setHideTaskMessageCtg;

			{
				{_x call sp_removePlayerHandler} foreach (array_copy(["cpt1_looting_evt_clothHandler" arg []] call sp_storageGet));
			} call sp_threadCriticalSection;

			["cpt1_foundmap"] call sp_startScene;
		};

	} call sp_threadStart;

}] call sp_addScene;

cpt1_act_openMap = {
	["updown\paper_up"+str randInt(1,3),player modelToWorldVisual (player selectionPosition "head"),1,null,5,null,0] call soundGlobal_play;
	
	if (isInventoryOpen) then {
		call closeInventory;
	};

	startAsyncInvoke
	{
		!isInventoryOpen
	},{
		_openMap = {
			_d = call displayOpen;
			_sizeX = 40;
			_sizeY = 85; 
			_w = [_d,PICTURE,[50-(_sizeX/2),50-(_sizeY/2),_sizeX,_sizeY]] call createWidget;
			widgetSetFade(_w,1,0);
			[_w,PATH_PICTURE("mapsp_scaled.paa")] call widgetSetPicture;
			_butposY = (50-(_sizeY/2)) + _sizeY - 2;
			_butsizeY = 100 - _butposY;
			_w2 = [_d,BUTTON,[50-(_sizeX/2/2),_butposY,_sizeX/2,_butsizeY]] call createWidget;
			_w2 ctrlsettext "Закрыть";
			widgetSetFade(_w2,1,0);

			widgetSetFade(_w,0,0.7);
			widgetSetFade(_w2,0,0.5);

			_w2 ctrlAddEventHandler ["MouseButtonUp",{
				_nf = {
					call displayClose;
					["updown\paper_up"+str randInt(1,3),player modelToWorldVisual (player selectionPosition "head"),1,null,5,null,0] call soundGlobal_play;
				};
				nextFrame(_nf);
			}];
		};
		nextFrame(_openMap);
	}
	endAsyncInvoke
};

cpt1_act_addMapViewHandler = {
	["main_action",{
		params ["_t"];
		private _ret = false;
		if (getVar(_t,name) == "Карта") then {
			call cpt1_act_openMap;
			_ret = true;
		};
		_ret
	}] call sp_addPlayerHandler;

	["activate_verb",{
		params ["_t","_name"];
		private _ret = false;
		if (_name == "mainact") then {
			if (getVar(_t,name)=="Карта") then {
				call cpt1_act_openMap;
				_ret = true;
			};
		};
		_ret
	}] call sp_addPlayerHandler;
};

["cpt1_act_mapview",{
	{
		sp_playerCanMove = false;
		0.5 call sp_threadPause;
		_d = getGUI;
		_sizeX = 40;
		_sizeY = 85; 
		_w = [_d,PICTURE,[50-(_sizeX/2),50-(_sizeY/2),_sizeX,_sizeY]] call createWidget;
		widgetSetFade(_w,1,0);
		[_w,PATH_PICTURE("mapsp_scaled.paa")] call widgetSetPicture;
		widgetSetFade(_w,0,0.7);
		
		{["cpt1_data_dialogmessageDone",false] call sp_storageGet} call sp_threadWait;
		//5 call sp_threadPause;

		widgetSetFade(_w,1,0.3);
		1 call sp_threadPause;
		[_w,true] call deleteWidget;
		sp_playerCanMove = true;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_checknextpath",{
	_wall = "cpt1_loot_wall_topart2" call sp_getObject;
	if !isNullReference(_wall) then {
		//tp
		{
			[true,1] call sp_gui_setBlackScreenGUI;
			_d = getGUI;
			_t = widgetNull;
			{
				_sizeX = 100;
				_sizeY = 60;
				_t = [_d,TEXT,[0,50-(_sizeY/2) + 20,_sizeX,_sizeY]] call createWidget;
				[_t,format["<t align='center' valign='middle' color='#781f4d' size='1.7' font='Ringbear'>%1</t>",pick[
					"Не стоит ходить в неизвестные места",
					"Я не знаю что там, лучше вернусь обратно...",
					"Там может быть опасно. Поищу в другом месте.",
					"Я не собираюсь идти туда..."
				]]] call widgetSetText;
				widgetSetFade(_t,1,0);
				widgetSetFade(_t,0,1);
			} call sp_threadCriticalSection;
			
			["cpt1_pos_looting",0] call sp_setPlayerPos;
			4 call sp_threadPause;
			widgetSetFade(_t,1,1);
			[false,1] call sp_gui_setBlackScreenGUI;

			[_t] call deleteWidget;
		} call sp_threadStart;
	} else {
		if !(["cpt1_data_entercaves",false] call sp_storageGet) then {
			["cpt1_data_entercaves",true] call sp_storageSet;
			["transition4"] call sp_audio_playMusic;
		};
	};
}] call sp_addTriggerEnter;

["cpt1_foundmap",{

	["cpt1_act_mapview"] call sp_startScene;
	{
		_h = [
			[player,"chap1\gg5"],
			[player,"chap1\gg6"],
			[player,"chap1\gg7"],
			[player,"chap1\gg8",["onstart",{
				["cpt1_data_dialogmessageDone",true] call sp_storageSet;
			}]]
		] call sp_audio_startDialog;
		_h call sp_audio_waitForEndDialog;
		_wall = "cpt1_loot_wall_topart2" call sp_getObject;
		if !isNullReference(_wall) then {
			[_wall] call deleteStructure;
		};
		
		call cpt1_act_addMapViewHandler;

		2 call sp_threadPause;
		
		{
			_h = ["Чтобы ещё раз #(посмотреть карту) нажмите $input_act_mainAction по ней"] call sp_setNotification;
			10 call sp_threadPause;
			_h = ["В вашей #(одежде) можно хранить предметы. Попробуйте перетащить #(карту) из руки в одежду. Чтобы посмотреть содержимое карманов - наведите мышку на одежду и нажмите $input_act_mainAction по ней."] call sp_setNotification;
			{
				count getVar(callFuncParams(call sp_getActor,getItemInSlotRedirect,INV_CLOTH),content) > 0
			} call sp_threadWait;
			[false,_h] call sp_setNotificationVisible;
		} call sp_threadStart;

		["cpt1_walk_topart2"] call sp_startScene;

	} call sp_threadStart;
}] call sp_addScene;

["cpt1_walk_topart2",{
	["Новый дом","Отправляйтесь к ближайшему городу"] call sp_setTaskMessageEff;
}] call sp_addScene;

cpt1_data_foundFirstMushroom = false;
["cpt1_trg_foundfirstmushroom",{
	if (cpt1_data_foundFirstMushroom) exitWith {};
	cpt1_data_foundFirstMushroom = true;
	
	{
		_h = ["#(Сеть) - система тоннелей и пещер, наполненная #(грибами). Со временем вы узнаете о них больше..."] call sp_setNotification;
		15 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_founddoor",{
	
	["chap1\gg9"] call sp_audio_sayPlayer;
	_msgHndl = ["#(ПКМ-меню) - универсальный способ взаимодействия. Наведите прицел на объект и нажмите ПКМ: появится меню с действиями для выбранного объекта. Попробуйте #(открыть дверь) этим способом."] call sp_setNotification;
	
	["verbs",false] call sp_setLockPlayerHandler;
	sp_allowebVerbs = ["description","mainact"];
	
	["load_verbs",{
		params ["_targ","_verbs"];
		if equals(_targ,"cpt1_obj_doortopart2" call sp_getObject) then {
			[_verbs,{
				params ["_name","_id"];
				_name in ["description","mainact"]
			}] call sp_filterVerbsOnHandle;
		} else {
			//для всех остальных тоже подключаем фильтрацию
			// [_verbs,{
			// 	params ["_name","_id"];
			// 	_name in ["description","mainact"]
			// }] call sp_filterVerbsOnHandle;
		};
		false
	}] call sp_addPlayerHandler;

	private _handlers = [];
	["cpt1_data_openDoorHandlers",_handlers] call sp_storageSet;

	_handlers pushBack (["activate_verb",{
		params ["_t","_name"];
		if (_name == "mainact") then {
			if equals(_t,"cpt1_obj_doortopart2" call sp_getObject) then {
				{ _x call sp_removePlayerHandler } foreach (["cpt1_data_openDoorHandlers",[]] call sp_storageGet);
				["cpt1_walk_searchkey"] call sp_startScene;
			};
		};
	}] call sp_addPlayerHandler);

	_handlers pushBack (["main_action",{
		params ["_t"];
		if equals(_t,"cpt1_obj_doortopart2" call sp_getObject) then {
			{ _x call sp_removePlayerHandler } foreach (["cpt1_data_openDoorHandlers",[]] call sp_storageGet);
			["cpt1_walk_searchkey"] call sp_startScene;
		};
		false
	}] call sp_addPlayerHandler);

	[{
		params ["_msgHndl"];
		{
			callFuncParams("cpt1_obj_keytopart2" call sp_getObject,getDistanceTo,call sp_getActor arg true) <= 20
		} call sp_threadWait;
		{ _x call sp_removePlayerHandler } foreach (["cpt1_data_openDoorHandlers",[]] call sp_storageGet);
		[false,_msgHndl] call sp_setNotificationVisible;
		
		if (sp_lastStartedScene != "cpt1_walk_searchkey") then {
			["cpt1_walk_searchkey"] call sp_startScene;
		};
	},_msgHndl] call sp_threadStart;
	
}] call sp_addScene;

["cpt1_walk_searchkey",{
	//ключ пока ещё не в руках игрока
	if (not_equals(call sp_getActor,callFunc("cpt1_obj_keytopart2" call sp_getObject,getSourceLoc))) then {
		if (callFuncParams("cpt1_obj_doortopart2" call sp_getObject,getDistanceTo,call sp_getActor arg true) <= 7) then {
			["chap1\gg10"] call sp_audio_sayPlayer;
		};
		[false] call sp_setNotificationVisible;

		["Новый дом","Найдите способ открыть дверь"] call sp_setTaskMessageEff;
	};

	{
		{
			equals(call sp_getActor,callFunc("cpt1_obj_keytopart2" call sp_getObject,getSourceLoc))
		} call sp_threadWait;
		
		["Новый дом","Откройте дверь"] call sp_setTaskMessageEff;

		["yell"] call sp_audio_playMusic;

		{
			callFuncParams("cpt1_obj_doortopart2" call sp_getObject,getDistanceTo,call sp_getActor arg true) <= 3
			&& equals(call sp_getActor,callFunc("cpt1_obj_keytopart2" call sp_getObject,getSourceLoc))
		} call sp_threadWait;

		["Чтобы #(отпереть) дверь: возьмите ключ в руку и нажмите ЛКМ по ней"] call sp_setNotification;
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
	
	[false] call sp_setNotificationVisible;
	[true] call sp_setHideTaskMessageCtg;

	{
		{
			getVar("cpt1_obj_finaldoor" call sp_getObject,isOpen)
		} call sp_threadWait;
		[""] call sp_view_setPlayerHudVisible;
		[true,2.5] call sp_gui_setBlackScreenGUI;
		["chap1end"] call sp_audio_playMusic;
		3 call sp_threadPause;
		
		["cpt1_topart2"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;


["cpt1_topart2",{
	{
		//cam shown
		[true] call sp_cam_setCinematicCam;
		[true] call sp_gui_setCinematicMode;
		{
			["cpt1_pos_cutscenetocpt2","player_cutscene",[],{
				[_this] call sp_copyPlayerInventoryTo;

				if (!callFuncParams(_this,hasItem,"Torch" arg true)) then {
					["Torch",_this] call createItemInInventory;
				};
			}] call sp_ai_createPersonEx;

		} call sp_threadCriticalSection;

		["vr",[4042.43,4139.39,12.0123],99.5766,0.39,[-18.5022,7.18263],0,0,720,0.412544,0,1,0,1] call sp_cam_prepCamera;
		"player_cutscene" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		["player_cutscene","cpt1_pos_cutscenetocpt2","cutscenes\cpt1_cutscenetocpt2"] call sp_ai_playAnim;
		2 call sp_threadPause;
		_del = 8.3;
		_pos2 = ["vr",[4040.72,4129.23,12.0123],99.5766,0.39,[-18.5022,7.18263],0,0,720,0.412544,0,1,0,1];
		["all",_pos2,_del] call sp_cam_interpTo;
		[false,1] call setBlackScreenGUI;
		(_del) call sp_threadPause;
		call sp_cam_stopAllInterp;
		_pos2 call sp_cam_prepCamera;
		
		2.4 call sp_threadPause;

		["all",["vr",[4039.76,4123.51,12.0123],99.5766,0.39,[-18.5022,7.18263],0,0,720,0.412544,0,1,0,1],8] call sp_cam_interpTo;
		[true,4] call sp_gui_setBlackScreenGUI;

		6 call sp_threadPause;

		[false] call sp_cam_setCinematicCam;
		[false] call sp_gui_setCinematicMode;
		call sp_cam_stopAllInterp;
		[1] call sp_onChapterDone;
		_post = {
			call sp_cleanupSceneData;
			["cpt2_begin"] call sp_startScene;
		};
		invokeAfterDelay(_post,3);
	} call sp_threadStart;
}] call sp_addScene;