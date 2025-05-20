// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
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
			"Добро пожаловать в Relicta. По мере прохождения обучения вам будет постепенно открываться всё больше возможностей. "
			+"Вас погрузят в основные тонкости управления в игре - не спешите и действуйте инструкциям, появляющимся в этом окне. "
			+"Однако не думайте, что вас будут всё время вести за руку. В некоторых случаях потребуется проявить смекалку."
		] call sp_setNotification;

		15 call sp_threadPause;

		["Для начала нажмите $input_act_inventory"] call sp_setNotification;
		["open_inventory",false] call sp_setLockPlayerHandler;
		{
			isInventoryOpen
		} call sp_threadWait;

		[
			"Только что вы перешли в режим взаимодействия и инвентаря. В этом режиме вы будете взаимодействовать с предметами и вашим инвентарём. Переместив мышь вправо вы увидите панель взаимодействия. "
			+" На ней в верхней части отображаются навыки вашего персонажа, по центру - зоны взаимодействия к живым сущностям а внизу - кнопки особых действий."
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
			"Любая смена в Сети начинается с пробуждения в кровати. Попробуем разбудить вашего персонажа. Для этого переместите мышь вправо и нажмите кнопку ""Сон"" в нижней части панели взаимодействия и ваш персонаж начнёт просыпаться."
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

		[false] call sp_setNotificationVisible;
		refset(_zoneH,true);
		refset(_ct,true);

		2 call sp_threadPause;
		callFuncParams(call sp_getActor,playSound, "emotes\sigh_male" arg 0.92);
		1 call sp_threadPause;
		["chap1\gg1"] call sp_audio_sayPlayer;

		["resist",false] call sp_setLockPlayerHandler;
		[
			"Чтобы встать с кровати нажмите $input_act_resist."
		] call sp_setNotification;

		{
			!callFunc(call sp_getActor,isConnected)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		2 call sp_threadPause;

		["right+stats+cursor"] call sp_view_setPlayerHudVisible;
		["Курсор в центре обозначает вашу цель - то, на что вы смотрите и с чем собираетесь взаимодействовать. Его яркость отражает уровень освещённости вашего персонажа."] call sp_setNotification;
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
		
		["Для осмотра любых окружающих вас объектов наведитесь на них курсором и нажмите $input_act_examine. В вашем временном пристанище много интересного. Попробуйте осмотреть окружение..."] call sp_setNotification;
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

		["main_action",false] call sp_setLockPlayerHandler;
		setVar(["cpt1_bed_door"] call sp_getObject,isLocked,false);

		//wait for door open
		{ getVar(["cpt1_bed_door"] call sp_getObject,isOpen)} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		//lamp disabling handler
		{
			rand(2,4) call sp_threadPause;
			{
				callFuncParams("cpt1_obj_beginlamp" call sp_getObject,worldSay,"Лампа начинает угасать" arg "act");
			} call sp_threadCriticalSection;
			
			rand(4,5) call sp_threadPause;
			{
				callFuncParams("cpt1_obj_beginlamp" call sp_getObject,lightSetMode,false);
				callFuncParams("cpt1_obj_beginlamp" call sp_getObject,worldSay,"Лампа затухает" arg "act");
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
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	["Остатки цивилизации","Осмотрите ящики на наличие ценных предметов"] call sp_setTaskMessageEff;

	{
		4 call sp_threadPause;
		["hellocave"] call sp_audio_playMusic;
	} call sp_threadStart;

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
			any_of(_barr apply {callFuncParams(_x,getDistanceTo,call sp_getActor arg true) <= 3})
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
					["Вы нашли Факел - незаменимую вещь в Сети. Он будет вашим лучшим другом в этих мрачных пещерах. Возьмите его и вернитесь к костру."] call sp_setNotification;
					["cpt1_loot_torchItem",_obj] call sp_storageSet;
					{
						_obj = ["cpt1_loot_torchItem",nullPtr] call sp_storageGet;
						_camp = "cpt1_loot_campfire" call sp_getObject;
						if isNullReference(_obj) exitWith {};

						{
							callFuncParams(callFunc(_obj,getSourceLoc),getDistanceTo,_camp arg true) <= 1.3
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

		_h = ["Чтобы ещё раз посмотреть карту нажмите $input_act_mainAction по ней"] call sp_setNotification;
		5 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;

		["cpt1_walk_topart2"] call sp_startScene;

	} call sp_threadStart;
}] call sp_addScene;

["cpt1_walk_topart2",{
	["transition4"] call sp_audio_playMusic;
	["Новый дом","Отправляйтесь к ближайшему городу"] call sp_setTaskMessageEff;
}] call sp_addScene;

["cpt1_trg_founddoor",{
	
	["chap1\gg9"] call sp_audio_sayPlayer;
	["Вы также можете взаимодействовать с миром через ПКМ меню. Попробуйте открыть дверь с помощью ПКМ, выбрав пункт ""Открыть"""] call sp_setNotification;
	
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

		["yell"] call sp_audio_playMusic;

		{
			callFuncParams("cpt1_obj_doortopart2" call sp_getObject,getDistanceTo,call sp_getActor arg true) <= 3
			&& equals(call sp_getActor,callFunc("cpt1_obj_keytopart2" call sp_getObject,getSourceLoc))
		} call sp_threadWait;

		["Чтобы отпереть дверь с помощью ключа - возьмите его в руку и нажмите ЛКМ, нацелившись на дверь."] call sp_setNotification;
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
		call sp_cam_stopAllInterp;
		_post = {
			call sp_cleanupSceneData;
			["cpt2_begin"] call sp_startScene;
		};
		invokeAfterDelay(_post,3);
	} call sp_threadStart;
}] call sp_addScene;