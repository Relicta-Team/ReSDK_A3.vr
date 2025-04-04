// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

/*
	poses:
	cpt4_pos_start - start playerpos
	cpt4_pos_armyattacktom - army enter to tom actor
	cpt4_pos_enterkochevs - pos of 3 nomads
	cpt4_pos_armyfrommeds - start army guys pos


	RedButton_Activator G:0BHVbZgUjcE - open window
	GateCity G:8fd0oIb9ArY (2) - window gate

	Tumbler_Activator G:hQrKBb16ltI - open enter
	GateCity G:8fd0oIb9ArY (1) - enter door
*/
cpt4_questName_begin = "Снова за работу";
cpt4_questName_kochevs = "Оформим как надо";

cpt4_canOpenEnter = false;
cpt4_canOpenWindow = false;

cpt4_gref_doorwindow = "GateCity G:8fd0oIb9ArY (2)";
cpt4_gref_doorenter = "GateCity G:8fd0oIb9ArY (1)";

cpt4_addProcessorMainAct = {
	params ["_tobjName","_code"];
	["main_action",compile format['
		params ["_t"];
		private _ret = false;
		private _target = "%1" call sp_getObject;
		if equals(_t,_target) then {
			private _result = false;
			%2 ;
			_ret = _result;
		};
		_ret
	',_tobjName,toString _code]] call sp_addPlayerHandler;
	["activate_verb",compile format['
		params ["_t","_name"];
		private _ret = false;
		if (_name == "mainact") then {
			private _target = "%1" call sp_getObject;
			if equals(_t,_target) then {
				private _result = false;
				%2 ;
				_ret = _result;
			};
		};
		_ret
	',_tobjName,toString _code]] call sp_addPlayerHandler;
};

["cpt4_begin",{
	["cpt4_pos_start",0] call sp_setPlayerPos;
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	[false,1.5] call setBlackScreenGUI;

	_body = ["cpt4_pos_enterkochevs",null,"cpt4_karim"] call sp_ai_createPerson;
	_body setDir (callFunc("cpt4_pos_enterkochevs" call sp_getObject,getDir));
	_mob = _body getvariable "link";
	setVar(_mob,age,34);
	callFuncParams(_mob,generateNaming,"Карим" arg "Сухач");

	_cloth = ["NomadCloth3",_mob,INV_CLOTH] call createItemInInventory;
	["ShuttleBag",_mob,INV_HAND_L] call createItemInInventory;
	["Torch",_mob,INV_HAND_R] call createItemInInventory;
	
	//sync speed
	[_body] call anim_syncAnim;

	callFuncParams("RedButton G:NJnbP0kznrs" call sp_getObject,setEnable,false);
	

	{
		[cpt4_questName_begin,"Включите свет"] call sp_setTaskMessageEff;

		_bt = "RedButton G:NJnbP0kznrs" call sp_getObject;
		_rememberTime = tickTime + 20;
		{
			getVar(_bt,edIsEnabled)
			||  (tickTime >= _rememberTime)
		} call sp_threadWait;

		if (tickTime >= _rememberTime) then {
			_h = ["Для включения света нажмите $input_act_mainAction"] call sp_setNotification;
			{getVar(_bt,edIsEnabled)} call sp_threadWait;
			[false,_h] call sp_setNotificationVisible;
		};

		[cpt4_questName_begin,"Возвращайтесь к своим рабочим обязанностям"] call sp_setTaskMessageEff;
		["Сядьте на стул, нажав $input_act_mainAction"] call sp_setNotification;
		{
			equals("cpt4_obj_chairbegin" call sp_getObject,getVar(call sp_getActor,connectedTo))
		} call sp_threadWait;

		["Возьмите ручку со стола нажав ЛКМ. Чтобы достать один листок из стопки бумаги нажмите $input_act_mainAction"] call sp_setNotification;
		{
			callFuncParams(call sp_getActor,hasItem,"Paper")
			&& callFuncParams(call sp_getActor,hasItem,"ItemWritter" arg true)
		} call sp_threadWait;

		["Чтобы написать на бумаге нажмите ЛКМ ручкой по бумаге."
		+"Обратите внимание, что вы можете писать как на бумаге, которую держите в руке, так и на бумаге, которая лежит на столе."
		+sbr+sbr+ "Напишите, что за эту смену в город пришло 5 человек."] call sp_setNotification;

		{
			_papers = callFuncParams(call sp_getActor,getNearObjects,"Paper" arg 3 arg false arg true);
			private _found = false;
			{
				_found = [getVar(_x,content),"5"] call regex_isMatch;
				if (_found)exitWith{};
			} foreach _papers;
			_found
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;
		["cpt4_act_koch1_arrived"] call sp_startScene;
		
	} call sp_threadStart;

}] call sp_addScene;

["cpt4_act_koch1_arrived",{

	["RedButton_Activator G:0BHVbZgUjcE",{
		_result = !cpt4_canOpenWindow
	}] call cpt4_addProcessorMainAct;

	["Tumbler_Activator G:hQrKBb16ltI",{
		_result = !cpt4_canOpenEnter
	}] call cpt4_addProcessorMainAct;

	["main_action",{
		params ["_t"];
		_ret = false;
		_ptarg = "cpt4_obj_papersrc" call sp_getObject;
		_porig = "cpt4_obj_paperdoc" call sp_getObject;
		if equals(_t,_ptarg) then {
			_pap = ["Paper",call sp_getActor] call createItemInInventory;
			setVar(_pap,name,getVar(_porig,name));
			setVar(_pap,content,getVar(_porig,content));

			_ret = true;
		};
		_ret
	}] call sp_addPlayerHandler;
	["activate_verb",{
		params ["_t","_name"];
		_ret = false;
		if (_name == "mainact") then {
			_ptarg = "cpt4_obj_papersrc" call sp_getObject;
			_porig = "cpt4_obj_paperdoc" call sp_getObject;
			if equals(_t,_ptarg) then {
				_pap = ["Paper",call sp_getActor] call createItemInInventory;
				setVar(_pap,name,getVar(_porig,name));
				setVar(_pap,content,getVar(_porig,content));

				_ret = true;
			};
		};
		_ret
	}] call sp_addPlayerHandler;

	{
		[cpt4_questName_kochevs,"В город постоянно приходят новые люди. Опрашивайте, досматривайте и запускайте их внутрь."] call sp_setTaskMessageEff;
		callFuncParams("cpt4_obj_doorbegin" call sp_getObject,setDoorLock,false arg false);
		callFuncParams("cpt4_obj_radio1" call sp_getObject,playSound,"electronics\siren" arg 1.25 arg 20 arg 1.2 arg null arg false);
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_trg_openwindow",{
	{
		cpt4_canOpenWindow = true;
		["Нажмите красную кнопку под окном"] call sp_setNotification;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenWindow = false;
		[false] call sp_setNotificationVisible;

		//play anim
		["cpt4_karim" call sp_ai_getMobObject,"cpt4_pos_enterkochevs","cpt4_koch1_enter",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "acts_commenting_on_fight_loop";
			["cpt4_act_koch1_enter"] call sp_startScene;
		},[
			["state_1",{
				params ["_obj"];
				_empPos = _obj modelToWorld [0.2,0.3,0];
				_bag = [_obj,INV_HAND_L,_empPos] call sp_ai_moveItemToWorld;
				["cpt4_obj_bag1koch",_bag] call sp_storageSet;
			}]
		]] call sp_ai_playAnim;

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch1_enter",{
	{
		1 call sp_threadPause;
		[cpt4_questName_kochevs,"Оформите пропуск на имя ""Карим Сухач"". "
		+ "Для этого возьмите бланк пропуска из стопки бумаги слева от окна на полке и впишите в него имя."
		] call sp_setTaskMessageEff;

		_karim = "cpt4_karim" call sp_ai_getMobObject;
		private _tpaper = nullPtr;
		{
			_papers = callFuncParams(_karim,getNearObjects,"Paper" arg 3 arg false arg true);
			private _found = false;
			forceunicode 0;
			{
				_found = [tolower getVar(_x,content),"карим\s*сухач"] call regex_isMatch;
				if (_found)exitWith{_tpaper = _x};
			} foreach _papers;
			_found
		} call sp_threadWait;
		
		2 call sp_threadPause;
		[_karim,_tpaper,INV_HAND_L] call sp_ai_moveItemToMob;
		
		3 call sp_threadPause;
		

		{
			[_tpaper] call deleteGameObject;
		} call sp_threadCriticalSection;
		
		["cpt4_act_koch1_exit"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch1_exit",{
	
	{
		["Откройте входные двери, повернув рычаг на стене"] call sp_setNotification;
		cpt4_canOpenEnter = true;
		{
			getVar(cpt4_gref_doorenter call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenEnter = false;
		[false] call sp_setNotificationVisible;

		_karimMob = "cpt4_karim" call sp_ai_getMobObject;
		_karimPos = getposatl getVar(_karimMob,owner);
		[_karimMob,_karimPos,"cpt4_koch1_exit",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "acts_commenting_on_fight_loop";
			["cpt4_act_koch1_done",true] call sp_storageSet;
		},[
			["state_1",{
				params ["_obj"];
				[_obj,["cpt4_obj_bag1koch",nullPtr] call sp_storageGet,INV_HAND_L] call sp_ai_moveItemToMob;
			}]
		]] call sp_ai_playAnim;

		{
			["cpt4_act_koch1_done",false] call sp_storageGet
		} call sp_threadWait;

		{
			callFuncParams(cpt4_gref_doorenter call sp_getObject,setDoorOpen,false arg true);
		} call sp_threadCriticalSection;
	} call sp_threadStart;
}] call sp_addScene;

//event started anim army guys
["cpt4_trg_gotomed",{

}] call sp_addScene;