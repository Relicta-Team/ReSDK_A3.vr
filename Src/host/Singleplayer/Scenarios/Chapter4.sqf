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
cpt4_questName_tomed = "На досмотр";

cpt4_questName_tobar = "Смену отпахал";

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

		cpt4_canOpenWindow = true;
		{getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)} call sp_threadWait;
		cpt4_canOpenWindow = false;

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

["cpt4_trg_openwindow",{
	{
		_h = ["Нажмите красную кнопку под окном"] call sp_setNotification;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;
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
			_papers = callFuncParams(_karim,getNearObjects,"Paper" arg 2 arg false arg true);
			private _found = false;
			forceunicode 0;
			{
				_found = [tolower getVar(_x,content),"карим\s*сухач"] call regex_isMatch;
				if (_found || sp_debug)exitWith{_tpaper = _x};
			} foreach _papers;
			_found
		} call sp_threadWait;
		
		1 call sp_threadPause;
		[_karim,_tpaper,INV_HAND_L] call sp_ai_moveItemToMob;
		1.2 call sp_threadPause;
		{
			callFuncParams(_tpaper,onMainAction,_karim);
			[getVar(_karim,owner)] call anim_syncAnim;
		} call sp_threadCriticalSection;
		
		3.5 call sp_threadPause;
		{
			callFuncParams(_tpaper,closeNDisplayServer,_karim);
			[getVar(_karim,owner)] call anim_syncAnim;
		} call sp_threadCriticalSection;
		0.5 call sp_threadPause;

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

		[cpt4_questName_kochevs,"Возвращайтесь в свой кабинет"] call sp_setTaskMessageEff;

		{
			callFuncParams(cpt4_gref_doorenter call sp_getObject,setDoorOpen,false arg true);
		} call sp_threadCriticalSection;
		0.3 call sp_threadPause;
		{
			callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
		} call sp_threadCriticalSection;

		["cpt4_act_koch2_prepare"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch2_prepare",{
	
	callFuncParams("cpt4_obj_doorbegin" call sp_getObject,setDoorLock,false arg false);

	{
		{
			callFuncParams("cpt4_obj_radio1" call sp_getObject,getDistanceTo,call sp_getActor arg true)
			<= 3
		} call sp_threadWait;
		[true] call sp_setHideTaskMessageCtg;
		
		3 call sp_threadPause;

		callFuncParams("cpt4_obj_radio1" call sp_getObject,playSound,"electronics\siren" arg 1.25 arg 20 arg 1.2 arg null arg false);
		1.5 call sp_threadPause;

		[cpt4_questName_kochevs,"Встречайте следующего посетителя"] call sp_setTaskMessageEff;

		{
			_body = ["cpt4_pos_enterkochevs",null,"cpt4_ibam"] call sp_ai_createPerson;
			_body setDir (callFunc("cpt4_pos_enterkochevs" call sp_getObject,getDir));
			_mob = _body getvariable "link";
			setVar(_mob,age,26);
			callFuncParams(_mob,generateNaming,"Ибам" arg "Шнурок");

			_cloth = ["NomadCloth8",_mob,INV_CLOTH] call createItemInInventory;
			["WoolCoat",_mob,INV_BACK] call createItemInInventory;
			["Candle",_mob,INV_HAND_L] call createItemInInventory;
			
			//sync speed
			[_body] call anim_syncAnim;
		} call sp_threadCriticalSection;

		cpt4_canOpenWindow = true;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenWindow = false;

		["cpt4_ibam" call sp_ai_getMobObject,"cpt4_pos_enterkochevs","cpt4_koch2_enter",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "acts_jetscrewaidf_idle2";
			["cpt4_act_koch2_enter"] call sp_startScene;
		}] call sp_ai_playAnim;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch2_enter",{
	{
		[true] call sp_setHideTaskMessageCtg;
		1 call sp_threadPause;
		[cpt4_questName_kochevs,"Решите стоит ли пропускать его в город"] call sp_setTaskMessageEff;
		1 call sp_threadPause;
		_hreg = ["Люди, использующие странные слова в речи могут быть опасны. Решите - пропустить кочевника или закрыть окно."
		+ sbr + "Если решите пропустить его - оформите пропуск на его имя - ""Ибам Шнурок"". В ином случае просто нажмите кнопку, чтобы отказать в регистрации."] call sp_setNotification;

		cpt4_canOpenWindow = true;

		["cpt4_act_ibam_result",0] call sp_storageSet;
		_tOnClose = {
			_ibam = "cpt4_ibam" call sp_ai_getMobObject;
			{!getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)} call sp_threadWait;
			//speak ibam

			4 call sp_threadPause;
			{["cpt4_ibam"] call sp_ai_deletePerson} call sp_threadCriticalSection;
			["cpt4_act_ibam_result",-1] call sp_storageSet;
		} call sp_threadStart;
		
		_tOnEnter = {
			_ibam = "cpt4_ibam" call sp_ai_getMobObject;
			_ibamPos = getposatl getVar(_ibam,owner);
			_tpaper = nullPtr;
			{
				
				private _papers = callFuncParams(_ibam,getNearObjects,"Paper" arg 2 arg false arg true);
				private _found = false;
				forceunicode 0;
				if !isNullVar(_papers) then {
					{
						_found = [tolower getVar(_x,content),"ибам\s*шнурок"] call regex_isMatch;
						if (_found || sp_debug)exitWith{_tpaper = _x};
					} foreach _papers;
				};				
				_found
			} call sp_threadWait;

			if !isNullReference(_tpaper) then {
				1.2 call sp_threadPause;
				[_ibam,_tpaper,INV_HAND_R] call sp_ai_moveItemToMob;
				1 call sp_threadPause;
			};

			cpt4_canOpenEnter = true;
			{
				getVar(cpt4_gref_doorenter call sp_getObject,isOpen)
			} call sp_threadWait;
			cpt4_canOpenEnter = false;

			[_ibam,_ibamPos,"cpt4_koch2_exit",{
				params ["_mob"];
				[_mob,getposatl _mob,null] call sp_ai_setMobPos;
				_mob switchmove "acts_commenting_on_fight_loop";
				["cpt4_act_koch2_done",true] call sp_storageSet;

				["cpt4_ibam"] call sp_ai_deletePerson;
			}] call sp_ai_playAnim;

			{["cpt4_act_koch2_done",false] call sp_storageGet} call sp_threadWait;

			["cpt4_act_ibam_result",1] call sp_storageSet;
		} call sp_threadStart;

		_threads = [_tOnClose,_tOnEnter];

		{(["cpt4_act_ibam_result",0] call sp_storageGet) != 0} call sp_threadWait;
		cpt4_canOpenWindow = false;
		[false,_hreg] call sp_setNotificationVisible;
		{[_x] call sp_threadStop} foreach _threads;

		{
			if (getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)) then {
				callFuncParams(cpt4_gref_doorenter call sp_getObject,setDoorOpen,false arg true);
			};
		} call sp_threadCriticalSection;
		0.4 call sp_threadPause;
		{
			if (getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)) then {
				callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
			};
		} call sp_threadCriticalSection;

		["cpt4_act_koch3_prepare"] call sp_startScene;
		

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch3_prepare",{
	{
		[cpt4_questName_kochevs,"Возвращайтесь к заполнению отчёта"] call sp_setTaskMessageEff;
		
		{
			callFuncParams("cpt4_obj_radio1" call sp_getObject,getDistanceTo,call sp_getActor arg true)
			<= 3
		} call sp_threadWait;
		[true] call sp_setHideTaskMessageCtg;
		
		1 call sp_threadPause;

		callFuncParams("cpt4_obj_radio1" call sp_getObject,playSound,"electronics\siren" arg 1.25 arg 20 arg 1.2 arg null arg false);
		1.5 call sp_threadPause;

		[cpt4_questName_kochevs,"Вернитесь к окну регистрации"] call sp_setTaskMessageEff;

		//========== tombomz
		{
			_body = ["cpt4_pos_enterkochevs",null,"cpt4_tombomz"] call sp_ai_createPerson;
			_body setDir (callFunc("cpt4_pos_enterkochevs" call sp_getObject,getDir));
			_mob = _body getvariable "link";
			setVar(_mob,age,44);
			callFuncParams(_mob,generateNaming,"Бомж" arg "Нормальнышек");
			_cloth = ["Castoffs2",_mob,INV_CLOTH] call createItemInInventory;
			[_body] call anim_syncAnim;
		} call sp_threadCriticalSection;

		//========== armyguy
		{
			_body = ["cpt4_pos_armyattacktom",null,"cpt4_tombomz_armyguy"] call sp_ai_createPerson;
			_body setDir (callFunc("cpt4_pos_armyattacktom" call sp_getObject,getDir));
			_mob = _body getvariable "link";
			setVar(_mob,age,24);
			callFuncParams(_mob,generateNaming,"Выха" arg "Штрих");

			_cloth = ["StreakCloth",_mob,INV_CLOTH] call createItemInInventory;
			["ShortSword",_mob,INV_HAND_R] call createItemInInventory;
			callFunc(_mob,switchTwoHands);
			[_body] call anim_syncAnim;
		} call sp_threadCriticalSection;

		cpt4_canOpenWindow = true;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenWindow = false;
		[true] call sp_setHideTaskMessageCtg;

		["cpt4_tombomz" call sp_ai_getMobObject,"cpt4_pos_enterkochevs","cpt4_koch3_enter",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "amovpknlmstpsnonwnondnon";
			["cpt4_act_koch3_enter"] call sp_startScene;
		}] call sp_ai_playAnim;
		//for test
		//["cpt4_act_koch3_enter"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch3_enter",{
	{
		3 call sp_threadPause;
		["Люди, которые ведут себя странно, говорят непонятные слова больны болезнью Тоннельного Образа Мышления (ТОМность)."
		+sbr + "Избегайте любых контактов с ними, так как ТОМность заразна. Если у вас есть силы и возможность - облегчите муки болезненного и убейте его."
		] call sp_setNotification;

		1 call sp_threadPause;

		["cpt4_tombomz_armyguy" call sp_ai_getMobObject,"cpt4_pos_armyattacktom","cpt4_armygettom",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
		},[
			["state_1",{
				params ["_obj"];
				callFuncParams(_obj getvariable "link",setCombatMode,true);

				["cpt4_tombomz",callFunc("cpt4_tombomz" call sp_ai_getMobObject,getPos),"cpt4_koch3_gettom",{
					params ["_mob"];
					[_mob,getposatl _mob,null] call sp_ai_setMobPos;
				}] call sp_ai_playAnim;
			}],
			["state_2",{
				["cpt4_act_tomdie",true] call sp_storageSet;
			}]
		]] call sp_ai_playAnim;

		{["cpt4_act_tomdie",false] call sp_storageGet} call sp_threadWait;
		{
			if (getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)) then {
				callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
			};
		} call sp_threadCriticalSection;
		
		2 call sp_threadPause;
		[false]	call sp_setHideTaskMessageCtg;
		{
			["cpt4_tombomz"] call sp_ai_deletePerson;
			["cpt4_tombomz_armyguy"] call sp_ai_deletePerson;
		} call sp_threadCriticalSection;

		1 call sp_threadPause;
		//speaker activate GODO med

		["cpt4_act_gotomed_begin"] call sp_startScene;

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_gotomed_begin",{
	callFuncParams("cpt4_obj_doortomed" call sp_getObject,setDoorOpen,true);

	[cpt4_questName_tomed,"Отправляйтесь на медицинское обследование"] call sp_setTaskMessageEff;

	["cpt4_pos_armyfrommeds","cpt4_armyguy1",[
		["name",["Охр","Исимбар"]],
		["uniform","CaretakerCloth"]
	]] call sp_ai_createPersonEx;
	["cpt4_pos_armyfrommeds","cpt4_armyguy2",[
		["name",["Младший Охр","Акептис"]],
		["uniform","StreakCloth"]
	],{
		["Baton",_this,INV_HAND_R] call createItemInInventory;
	}] call sp_ai_createPersonEx;

	
}] call sp_addScene;

//event started anim army guys
["cpt4_trg_gotomed",{
	["cpt4_armyguy1","cpt4_pos_armyfrommeds","cpt4_gotomed1",{
		params ["_mob"];
		[_mob,getposatl _mob,null] call sp_ai_setMobPos;
		["cpt4_act_gotomed_dialog_start",true] call sp_storageSet;
	},[
		["state_1",{
			callFuncParams("cpt4_obj_doorarmyguys" call sp_getObject,setDoorOpen,true);
		}]
	]] call sp_ai_playAnim;
	_after = {
		["cpt4_armyguy2","cpt4_pos_armyfrommeds","cpt4_gotomed2",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
		}] call sp_ai_playAnim;
	};
	invokeAfterDelay(_after,3);
	
	{
		{["cpt4_act_gotomed_dialog_start",false] call sp_storageGet} call sp_threadWait;
		3 call sp_threadPause;
		[true] call sp_setHideTaskMessageCtg;
		[true,1.5] call setBlackScreenGUI;

		2 call sp_threadPause;
		//black screen
		["cpt4_armyguy1"] call sp_ai_deletePerson;
		["cpt4_armyguy2"] call sp_ai_deletePerson;

		{
			["cpt4_bar_begin"] call sp_startScene;
		} call sp_threadCriticalSection;
	} call sp_threadStart;
}] call sp_addScene;

/*
---------------------------------------------------------------------------------------------------------
 												BAR STAGE
---------------------------------------------------------------------------------------------------------


cpt4_pos_p2player - pos for playerspawn

citywalkers:
cpt4_pos_citywalker1 - above gate
cpt4_pos_citywalker2 - abobe bumcar

cpt4_pos_poorman - poor man

cpt4_pos_bomzcar - bum mob
cpt4_pos_bomzowner - bum owner (merchant)

ohr-walker
cpt4_pos_ohrwalk1

cpt4_pos_barsmoker1
cpt4_pos_barsmoker2
---- guys with sigarets


bar:
cpt4_pos_brodyaga_bar - sitter
	cpt4_obj_barsit_brod
cpt4_pos_barnik - barkeeper

cpt4_pos_barkarim - karim inside bar
	cpt4_obj_bar_karimsit - sit

cpt4_pos_bar_aloguys - 3 sits


*/

["cpt4_bar_begin",{
	["cpt4_pos_p2player",0] call sp_setPlayerPos;
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;

	//prep mobs
	["cpt4_pos_citywalker1","cpt4_citywalker1",[
		["uniform","CitizenCloth6"]
	],{
		["Sigarette",_this,INV_FACE] call createItemInInventory;
	}] call sp_ai_createPersonEx;

	["cpt4_pos_citywalker2","cpt4_citywalker2",[
		["uniform","CitizenCloth8"]
	]] call sp_ai_createPersonEx;

	["cpt4_pos_poorman","cpt4_poorman",[
		["uniform","Castoffs3"],
		["name",["Раган","Бедолагин"]]
	],{
		private _item = callFuncParams(_this,getPart,BP_INDEX_ARM_L);		
		callFuncParams(_item,unlink,null arg true);
	},{
		_this switchMove "passenger_boat_4_idle_unarmed";
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barsmoker1","cpt4_barsmoker1",[
		["uniform","WhitePlaidCoat"]
	],{
		["Sigarette",_this,INV_FACE] call createItemInInventory;
	}, { _this switchMove "acts_commenting_on_fight_loop" }] call sp_ai_createPersonEx;
	["cpt4_pos_barsmoker2","cpt4_barsmoker2",[
		["uniform","WhitePlaidCoat"]
	],{
		["Sigarette",_this,INV_FACE] call createItemInInventory;
	}, { _this switchMove "hubbriefing_ext_contact" }] call sp_ai_createPersonEx;

	["cpt4_pos_bomzcar","cpt4_bomzcar",[
		["uniform","Castoffs1"],
		["name",["Бомжара","Тянульщик"]]
	],{
		
	},{ _this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop"; [_this, player] call sp_ai_setLookAtControl; }] call sp_ai_createPersonEx;

	["cpt4_pos_bomzowner","cpt4_bomzowner",[
		["uniform","WhitePlaidCoat"],
		["name",["Архатил","Вялов"]]
	],{
		
	}, { _this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop" }] call sp_ai_createPersonEx;

	["cpt4_pos_ohrwalk1","cpt4_ohrwalk1",[
		["uniform","StreakCloth"],
		["name",["Охр","Варош"]]
	],{
		["ShortSword",_this,INV_BELT] call createItemInInventory;
	}] call sp_ai_createPersonEx;

	["cpt4_pos_ohrstand","cpt4_ohrstand1",[
		["uniform","StreakCloth"],
		["name",["Охр","Измур"]]
	],{
		["Baton",_this,INV_BELT] call createItemInInventory;
	},{
		_this switchMove "Acts_JetsCrewaidR_idle_m";
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barstrangeman","cpt4_barstrangeman",[
		["uniform","HeadCloth"],
		["name",["Дий","Черный"]]
	],{},{[_this, player] call sp_ai_setLookAtControl; _this enableMimics false}] call sp_ai_createPersonEx;

	//-------------------------- bar spawn -------------------
	["cpt4_pos_bar_alсoguys","cpt4_bar_alсoguys1",[
		["uniform","WhitePlaidCoat"],
		["name",["Выха","Забойщик"]]
	],{
		callFuncParams("cpt4_obj_barsit_party1" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;
	["cpt4_pos_bar_alсoguys","cpt4_bar_alсoguys2",[
		["uniform","WhitePlaidCoat"],
		["name",["Губан","Мощин"]]
	],{
		callFuncParams("cpt4_obj_barsit_party2" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;
	["cpt4_pos_bar_alсoguys","cpt4_bar_alсoguys3",[
		["uniform","WhitePlaidCoat"],
		["name",["Иванур","Володин"]]
	],{
		callFuncParams("cpt4_obj_barsit_party3" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;

	["cpt4_pos_brodyaga_bar","cpt4_brodyaga_bar",[
		["uniform","WhitePlaidCoat"],
		["name",["Алкашня",""]]
	],{
		callFuncParams("cpt4_obj_barsit_brod" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barnik","cpt4_bar_barnik",[
		["uniform","CookerCloth"],
		["name",["Барник","Малим"]]
	],{
		
	}] call sp_ai_createPersonEx;



	//looped state of ohrwalk
	_anims = {
		["cpt4_ohrwalk1",
			[
				["cpt4_pos_ohrwalk1","cpt4_bar_ohrwalk1",{rand(10,15)},{ params ["_obj"]; _obj switchMove "Acts_Kore_IdleNoWeapon_loop"}],
				["cpt4_pos_ohrwalk2","cpt4_bar_ohrwalk2",{rand(10,15)},{ params ["_obj"]; _obj switchMove "Acts_Kore_IdleNoWeapon_loop"}]
			]
		] call sp_ai_playAnimsLooped;

		["cpt4_citywalker1","cpt4_pos_citywalker1","cpt4_bar_citywalker1"] call sp_ai_playAnim;
		["cpt4_citywalker2","cpt4_pos_citywalker2","cpt4_bar_citywalker2",{
			callFuncParams("cpt4_citywalker2" call sp_ai_getMobObject,seatConnect,"cpt4_obj_barnearmed_bench" call sp_getObject);
		}] call sp_ai_playAnim;
	};
	invokeAfterDelay(_anims,2);

	//main handle
	{
		1 call sp_threadPause;
		[false,1.5] call setBlackScreenGUI;
		3 call sp_threadPause;
		[cpt4_questName_tobar,"Идите в бар"] call sp_setTaskMessageEff;

	} call sp_threadStart;
}] call sp_addScene;

cpt4_bar_musicProc = false;
cpt4_bar_musicUpdateReq = false;
if !isNull(cpt4_bar_musicHandle) then {
	stopUpdate(cpt4_bar_musicHandle);
};
cpt4_bar_musicHandle = -1;
if !isNull(cpt4_bar_curMusicPlayed) then {
	stopSound (cpt4_bar_curMusicPlayed);
};
cpt4_bar_curMusicPlayed = -1;
cpt4_bar_curMusicStartTime = 0;
cpt4_bar_curMusicDist = 10;
cpt4_bar_curMusicName = "";

["cpt4_trg_barhallway",{
	cpt4_bar_curMusicDist = 12;
	cpt4_bar_musicUpdateReq = true;
}] call sp_addTriggerEnter;

["cpt4_trg_bazone",{
	cpt4_bar_curMusicDist = 18;
	cpt4_bar_musicUpdateReq = true;
}] call sp_addTriggerEnter;

["cpt4_trg_bazone",{
	cpt4_bar_curMusicDist = 12;
	cpt4_bar_musicUpdateReq = true;
}] call sp_addTriggerExit;

["cpt4_trg_bardoor",{
	//start bar handle
	//!unknown undefined behaviour (fuck bis)
	if (!cpt4_bar_musicProc && false) then {
		cpt4_bar_musicProc = true;
		_mlist = [
			"chap4\radios\bar_radio1",
			"chap4\radios\bar_radio2",
			"chap4\radios\bar_radio3"
		];
		private _fnc = {
			(_this select 0) params ["_mlist"];

			if (cpt4_bar_musicUpdateReq && cpt4_bar_curMusicPlayed != -1) exitWith {
				cpt4_bar_musicUpdateReq = false;
				//_startTime = (soundParams cpt4_bar_curMusicPlayed) select 3;
				_startTime = tickTime - cpt4_bar_curMusicStartTime; //new offset
				stopSound cpt4_bar_curMusicPlayed;
				cpt4_bar_curMusicPlayed = [
					"cpt4_obj_barradio",cpt4_bar_curMusicName,cpt4_bar_curMusicDist,_startTime-diag_deltaTime
				] call sp_audio_sayAtTarget;

				[format["update mus: %1 (%2m) dur: %3",cpt4_bar_curMusicName,cpt4_bar_curMusicDist,_startTime]] call chatPrint;
			};

			if equals(soundParams cpt4_bar_curMusicPlayed,[]) then {
				_m = _mlist deleteAt 0;
				_mlist pushBack _m;
				cpt4_bar_curMusicName = _m;
				
				cpt4_bar_curMusicPlayed = ["cpt4_obj_barradio",_m,cpt4_bar_curMusicDist,
					//!errors... ifcheck(cpt4_bar_curMusicPlayed==-1,30,0) //first time offset
					0 
				] call sp_audio_sayAtTarget;
				cpt4_bar_curMusicStartTime = tickTime;

				[format["start mus: %1 (%2m) dur: %3",cpt4_bar_curMusicName,cpt4_bar_curMusicDist,_startTime]] call chatPrint;
			};
		};
		cpt4_bar_musicHandle = startUpdateParams(_fnc,0,[_mlist]);
	};

	cpt4_bar_curMusicDist = 0.5;
	cpt4_bar_musicUpdateReq = true;
}] call sp_addTriggerEnter;

["cpt4_trg_barenter",{
	
	//radlist: chap4\radios\bar_radio3.ogg
	private _distance = 10;
	//["cpt4_obj_barradio","chap4\radios\bar_radio1",_distance] call sp_audio_sayAtTarget;
}] call sp_addScene;

["cpt4_trg_barmainroom",{
	{
		[cpt4_questName_tobar,"Сядьте за барную стойку и закажите выпивку"] call sp_setTaskMessageEff;
		
		{
			equals(getVar(call sp_getActor,connectedTo),"cpt4_obj_barchair_forplayer" call sp_getObject);
		} call sp_threadWait;

		//todo close and lock door

		//dialog 

		["Достаньте из кармана свои деньги - звяки, взяв их в руки"] call sp_setNotification;

		private _handitems = [];
		{
			_handitems = [INV_HAND_L,INV_HAND_R] apply {
				isTypeOf(callFuncParams(call sp_getActor,getItemInSlotRedirect,_x),Zvak)
			};
			any_of(_handitems);
		} call sp_threadWait;

		["Чтобы разделить звяки, нажмите $input_act_mainAction по ним пустой рукой. Разделите 3 звяка и выложите на барную стойку"] call sp_setNotification;

		_barnik = "cpt4_bar_barnik" call sp_ai_getMobObject;
		private _money = nullPtr;
		{
			private _found = false;
			{
				_found = getVar(_x,stackCount) == 3;
				if (_found)exitWith{_money = _x};
			} foreach callFuncParams(_barnik,getNearObjects,"Zvak" arg 2 arg false arg true);
			_found
		} call sp_threadWait;

		[false] call sp_setNotificationVisible;

		if !isNullReference(_money) then {
			1.2 call sp_threadPause;
			
			[_barnik,_money,INV_HAND_R] call sp_ai_moveItemToMob;
			
			//talk
			1 call sp_threadPause;
			{
				[_money] call deleteGameObject;

				["cpt4_bar_barnik","cpt4_pos_barnik","cpt4_bar_barnik1",{
					params ["_obj"];
					{
						_obj = "cpt4_bar_barnik" call sp_ai_getMobObject;
						_pos = callFunc("cpt4_pos_bar_itemdrinkloc" call sp_getObject,getPos);
						[_obj,INV_HAND_L,_pos vectoradd [0.1,0,0]] call sp_ai_moveItemToWorld;
						0.8 call sp_threadPause;
						[_obj,INV_HAND_R,_pos vectoradd [-0.1,0,0]] call sp_ai_moveItemToWorld;
						
						["cpt4_act_drinklearn"] call sp_startScene;
					} call sp_threadStart;
					
				},[
					["state_1",{
						params ["_obj"];
						[_obj,"cpt4_obj_barbottle" call sp_getObject,INV_HAND_L] call sp_ai_moveItemToMob;
					}],
					["state_2",{
						params ["_obj"];
						[_obj,"cpt4_obj_barcup" call sp_getObject,INV_HAND_R] call sp_ai_moveItemToMob;
					}]
				]] call sp_ai_playAnim;
			} call sp_threadCriticalSection;

		};
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_drinklearn",{
	[cpt4_questName_tobar,"Отдыхайте..."] call sp_setTaskMessageEff;
	["cpt4_data_drinkcount",0] call sp_storageSet;
	["cpt4_data_drinksuccess",false] call sp_storageSet;
	["click_self",{
		params ["_targ"];
		if callFunc(_targ,isReagentContainer) then {
			if (callFunc(_targ,getFilledSpace) > 0) then {
				_nval = ["cpt4_data_drinkcount",{_this + getVar(_targ,curTransferSize)}] call sp_storageUpdate;
				if (_nval >= 30) then {
					call sp_removeCurrentPlayerHandler;
					["cpt4_data_drinksuccess",true] call sp_storageSet;
				};
			};
		};
		false
	}] call sp_addPlayerHandler;
	{
		//dialog

		_h = ["Питьё жидкостей работает по аналогии с поеданием. Выберите справа зону ""рот"" и нажмите ЛКМ с кружкой или бутылкой в руке по кнопке ""моя персона"". "
		+"Для регулирования размера глотков нажмите $input_act_mainAction по емкости для жидкости"] call sp_setNotification;
		{
			["cpt4_data_drinksuccess"] call sp_storageGet
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;

		[cpt4_questName_tobar,"Идите домой"] call sp_setTaskMessageEff;
	} call sp_threadStart;
}] call sp_addScene;