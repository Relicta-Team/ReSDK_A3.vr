// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

["cpt1_begin",{
	private _usr = call sp_getActor;

	private _bedObj = "cpt1_obj_bed" call sp_getObject;
	["cpt1_pos_bed",0] call sp_setPlayerPos;
	
	private _restDir = getDir player;
	callFuncParams(_bedObj,seatConnect,call sp_getActor);
	(getVar(_bedObj,_seatListDummy) select 0)setvariable ["_restDir",_restDir];

	callFuncParams(_usr,changeVisionBlock,+1 arg "slp");
	callFuncParams(_usr,fastSendInfo,"hud_sleep" arg 0);
	setVar(_usr,sleepStrength,1);
	setVar(_usr,__isFirstUnsleep,false);

	["right+stats"] call sp_view_setPlayerHudVisible;

	//["Снова в путь","Проснитесь"] call sp_setTaskMessageEff;
	{
		[
			"Добро пожаловать в Relicta. Любой раунд начинается с того, что вы просыпаетесь в кровати."
		] call sp_setNotification;

		5 call sp_threadPause;

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

		[
			"Чтобы встать с кровати нажмите $input_act_resist."
		] call sp_setNotification;

		{
			!callFunc(call sp_getActor,isConnected)
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		1 call sp_threadPause;

		[
			"Передвижение вперёд @MoveBack,"
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

		["Для осмотра окружающих вас объектов наведите на них курсор и нажмите $input_act_examine"] call sp_setNotification;

		

		setVar(["cpt1_bed_door"] call sp_getObject,isLocked,false);
	} call sp_threadStart;
	
}] call sp_addScene;