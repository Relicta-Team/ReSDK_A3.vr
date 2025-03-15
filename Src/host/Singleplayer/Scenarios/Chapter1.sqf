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
		["chap1\gg2"] call sp_audio_sayPlayer;

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
	["Снова в путь","Отправляйтесь через пещеры и найдите новое пристанище"] call sp_setTaskMessageEff;
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

["cpt1_trg_walkbutton",{
	{
		["Чтобы переключиться на медленный шаг нажмите @WalkRunToggle"] call sp_setNotification;
		private _tReset = tickTime + 5;
		{
			callFunc(call sp_getActor,isWalking)
			|| (tickTime >= _tReset)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_trg_campfiresee",{
	{
		_h = ["chap1\gg3"] call sp_audio_sayPlayer;
		{count soundParams _h == 0} call sp_threadWait;
		["chap1\gg4"] call sp_audio_sayPlayer;
		["cpt1_looting"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt1_looting",{
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	["Остатки цивилизации","Осмотрите ящики на наличие ценных предметов"] call sp_setTaskMessageEff;

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
					["Одежда помогает согреться и защищает вашего персонажа. Только что вы нашли шапку. Перетащите её в слот свободной руки, а затем в слот головы."] call sp_setNotification;
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
							equals(getVar(_obj,slot),INV_HEAD)
						} call sp_threadWait;

						refset(_refHead,true);

					},[_obj,_refItm,[_refHandLeft,_refHandRight],_refHead]] call sp_threadStart;

				};
				if (_newcnt == 2) exitwith {
					_obj = ["TorchDisabled",_t] call createItemInContainer;
				};
				if (_newcnt == 3) exitWith {
					_obj = ["Paper",_t] call createItemInContainer;
				};
			};
			
		};
		false
	}] call sp_addPlayerHandler;

}] call sp_addScene;