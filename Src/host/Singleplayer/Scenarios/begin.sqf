// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

begin_handleKeyDown = -1;
["begin_start",{
	sp_playerCanMove = false;
	[""] call sp_view_setPlayerHudVisible;
	{
		setVar(call sp_getActor,stamina,1000);
	} call sp_threadStart;

	[true,0] call setBlackScreenGUI;
	["begin_pos_player",0] call sp_setPlayerPos;
	
	["begin_pos_watcher1","begin_watcher1",[
		["uniform","StreakCloth"],
		["name",["Смотрящий"]]
	],{
		["DBShotgun",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	
	["begin_pos_watcher2","begin_watcher2",[
		["uniform","StreakCloth"],
		["name",["Смотрящий"]]
	],{
		["ShortSword",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	
	for "_i" from 1 to 3 do {
		_strI = str _i;
		["begin_pos_keeper" + _strI,"begin_keeper"+_strI,
			[
				["uniform","StreakCloth"],
				["name",["Житель"]]
			],{
				if (_i == 2) then {
					["ShortSword",_this,INV_HAND_L] call createItemInInventory;
				};
			},
			{
				if (_i==2) then {
					_this switchMove "Acts_JetsMarshallingLeft_loop";
				}
			}
		] call sp_ai_createPersonEx;
	};

	for "_i" from 1 to 9 do {
		_strI = str _i;
		["begin_pos_startdead" + _strI,"begin_startdead"+_strI,
			[
				["uniform","StreakCloth"],
				["name",["Житель"]]
			],{

			}
		] call sp_ai_createPersonEx;
	};

	_NAInvData = [
		["uniform","NewArmyStdCloth"],
		["name",["Воин"]]
	];

	for "_i" from 1 to 6 do {
		_strI = str _i;
		["begin_pos_mainattacker" + _strI,"begin_mainattacker" + _strI,
			_NAInvData,{
				if (_i == 3) then {
					["PistolHandmade",_this,INV_HAND_R] call createItemInInventory;
				} else {
					["RifleAuto",_this,INV_HAND_R] call createItemInInventory;
				};
				callFuncParams(_this,setCombatMode,true);
				callFunc(_this,switchTwoHands);
			}
		] call sp_ai_createPersonEx;
	};


	//cutscene1
	["begin_pos_cutscene1dead","begin_cutscene1dead",[["uniform","StreakCloth"],["name",["Житель"]]],{}] call sp_ai_createPersonEx;
	["begin_pos_cutscene1attack","begin_cutscene1attack",_NAInvData,{
		["BattleAxe",_this,INV_HAND_R] call createItemInInventory;
	}] call sp_ai_createPersonEx;


	//cutscene2 with keeper
	["begin_pos_cutscene2attack1","begin_cutscene2attack1",_NAInvData,{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
		callFuncParams(_this,setCombatMode,true);
	}] call sp_ai_createPersonEx;
	["begin_pos_cutscene2dead2","begin_cutscene2dead2",[["uniform","StreakCloth"],["name",["Житель"]]],{}] call sp_ai_createPersonEx;

	_na_chase_weapons = {
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
		callFuncParams(_this,setCombatMode,true);
	};
	//chase behinder
	["begin_pos_chase_attacker1","begin_chase_attacker1",_NAInvData,_na_chase_weapons] call sp_ai_createPersonEx;
	//chase last
	["begin_pos_chase_attacker2","begin_chase_attacker2",_NAInvData,_na_chase_weapons] call sp_ai_createPersonEx;


	//["begin_naattacked"] call sp_startScene;
	if (begin_handleKeyDown != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown",begin_handleKeyDown];
		begin_handleKeyDown = -1;
	};
	begin_handleKeyDown = (findDisplay 46) displayAddEventHandler ["keyDown",{
		params ["_d","_key"];
		_sprintAndWalk = (ACT(MoveFastForward) + ACT(MoveSlowForward) + ACT(turbo) + ACT(TurboToggle) + ACT(GetOver) + ACT(TactToggle) + ACT(WalkRunToggle));
		_locked = CHANGE_STANCE_BUTTONS + FAST_DROP_BUTTONS + _sprintAndWalk;
		if (_key in _locked) then {true} else {false};
	}];
	
	{
		2 call sp_threadPause;
		[false,3] call setBlackScreenGUI;
		5 call sp_threadPause;
		_h = ["Чтобы осмотреться <t size='1.3' color='#e20048'>вращайте мышкой</t>"] call sp_setNotification;

		{
			callFuncParams("begin_keeper1" call sp_ai_getMobObject,getDirTo,call sp_getActor) == DIR_FRONT
		} call sp_threadWait;

		{
			["being_toattack"] call sp_startScene
		} call sp_threadCriticalSection;

		2 call sp_threadPause;
		[_h,false] call sp_setNotificationVisible;

	} call sp_threadStart;

}] call sp_addScene;

begin_attackStarted = false;
begin_canStartAttack = false;
["being_toattack",{
	/*
	state1 - inanim
	state2 - go to attackzone
	state3 -inanim
	state4 - run
	5-door1open
	6-door2open
	*/
	["begin_keeper1","begin_pos_keeper1","begin\keeper1",{},[
		["state_1",{
			params ["_obj"];
			_anim = "acts_explaining_ew_idle03";
			_obj switchMove _anim;
			

			[{tickTime > _this},tickTime + rand(2,5)] call sp_ai_animWait;
		}],
		["state_2",{
			{
				sp_playerCanMove = true;
				player forcewalk true;

				1 call sp_threadPause;

				[
					"Передвижение вперёд @MoveForward,"
					+ sbr + "передвижение назад @MoveBack,"
					+ sbr + "влево @TurnLeft,"
					+ sbr + "вправо @TurnRight,"
				] call sp_setNotification;

				10 call sp_threadPause;

				_h = [
					"Для свободного осмотра (вращения головой) удерживайте @lookAround,"
					+ sbr + "для переключения режима нажмите @lookAroundToggle"
				] call sp_setNotification;
				
				10 call sp_threadPause;

				[false,_h] call sp_setNotificationVisible;
			} call sp_threadStart;
		}],
		["state_3",{
			params ["_obj"];
			_anim = "hubbriefing_ext_contact";
			_obj switchMove _anim;
			begin_canStartAttack=true;
			[{begin_attackStarted}] call sp_ai_animWait;
		}],
		["state_4",{}],
		["state_5",{
			//open door1
			callFuncParams("begin_rundoor1" call sp_getObject,setDoorOpen,true);
		}],
		["state_6",{
			//open door2
			callFuncParams("begin_rundoor2" call sp_getObject,setDoorOpen,true);
		}]
	]] call sp_ai_playAnim;
}] call sp_addScene;

begin_startattack_activated = false;
["begin_startattack",{
	
	if (begin_startattack_activated) exitWith {};
	begin_startattack_activated = true;

	//for reload mode close doors
	callFuncParams("begin_doorenter" call sp_getObject,setDoorOpen,false);
	callFuncParams("begin_rundoor1" call sp_getObject,setDoorOpen,false);
	callFuncParams("begin_rundoor2" call sp_getObject,setDoorOpen,false);

	callFuncParams("begin_doorexit" call sp_getObject,setDoorOpen,false);

	for "_i" from 1 to 2 do {
		_strI = str _i;
		["begin_mainattacker"+_strI,"begin_pos_mainattacker"+_strI,"begin\mainattacker"+_strI,{},[
			["state_1",{
				[{begin_attackStarted}] call sp_ai_animWait;
			}],
			["state_2",{
				[{
					_mbs = [];
					for "_i" from 1 to 5 do {
						_mbs pushBack (("begin_startdead" + (str _i)) call sp_ai_getMobObject);
					};
					({callFunc(_x,isActive)} count _mbs) == 0
				}] call sp_ai_animWait;
			}]
		]] call sp_ai_playAnim;
	};

	for "_i" from 1 to 5 do {
		[{
			params ["_i"];

			rand(0.2,2) call sp_threadPause;

			_strI = str _i;
			_anm = ["begin_startdead"+_strI,"begin_pos_startdead"+_strI,"begin\startdead"+_strI,{

			},[
				["state_1",{
					params ["_body"];
					[{
						params ["_body"];
						if (begin_attackStarted) then {
							[{
								params ["_body"];

								//задержка перед смертью убегающийх
								rand(4,7) call sp_threadPause;
								_bmob = _body getvariable "link";
								if !callFunc(_bmob,isActive) exitWith {};

								{
									_ps = _body modelToWorld (_body selectionPosition "head");
									[("begin_mainattacker"+str(randInt(1,2))) call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
									_refv = _body getvariable "anim_handle";
									[_refv] call sp_ai_stopAnim;
									callFuncParams(_bmob,lossLimb,BP_INDEX_HEAD)
								} call sp_threadCriticalSection;
							},[_body]] call sp_threadStart;
						};

						begin_attackStarted
					},[_body]] call sp_ai_animWait;
					
				}]
			]] call sp_ai_playAnim;

			(("begin_startdead"+_strI) call sp_ai_getMobBody) setvariable ["anim_handle",_anm];
		},_i] call sp_threadStart;
	};

	_anm = ["begin_watcher2","begin_pos_watcher2","begin\watcher2",{},[
		["state_1",{
			params ["_obj"];
			[{begin_attackStarted}] call sp_ai_animWait;
		}]
	]] call sp_ai_playAnim;
	("begin_watcher2" call sp_ai_getMobBody) setvariable ["anim_handle",_anm];

	{
		{begin_canStartAttack} call sp_threadWait;
		5 call sp_threadPause;
		_wbody = ("begin_watcher1" call sp_ai_getMobBody);
		[
			"begin_mainattacker1" call sp_ai_getMobObject,
			_wbody modelToWorld (_wbody selectionPosition "head")
		] call cpt5_act_doShot;
		0.1 call sp_threadPause;

		{callFuncParams("begin_watcher1" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD)} call sp_threadCriticalSection;

		0.15 call sp_threadPause;

		player forcewalk false;

		//bum grenade
		_trg = "begin_posdata_grenade" call sp_getObject;
		_pos = callFunc(_trg,getPos);
		{
			[_pos] call cpt5_explosionGrenade;
		} call sp_threadCriticalSection;

		//dooropen
		{
			callFuncParams("begin_doorenter" call sp_getObject,setDoorOpen,true);
		} call sp_threadCriticalSection;

		{
			2 call sp_threadPause;
			["begin_mainattacker1" call sp_ai_getMobObject,("begin_watcher2" call sp_ai_getMobBody) modelToWorld [0,0,0.4]] call cpt5_act_doShot;
			0.1 call sp_threadPause;
			{
				_refv = ("begin_watcher2" call sp_ai_getMobBody) getvariable "anim_handle";
				[_refv] call sp_ai_stopAnim;
				callFuncParams("begin_watcher2" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD);
			} call sp_threadCriticalSection;
		} call sp_threadStart;
		
		begin_attackStarted = true;

		//loop attack targets
		for "_i" from 1 to 2 do {
			[{
				params ["_i"];
				_strI = str _i;
				2.1 call sp_threadPause;
				while {true} do {
					
					_target = player;
					_mbs = [];
					for "_i" from 1 to 5 do {
						_ptrg = ("begin_startdead" + (str _i)) call sp_ai_getMobObject;
						if callFunc(_ptrg,isActive) then {
							_mbs pushBack getVar(_ptrg,owner);
						};
					};
					if (count _mbs > 0) then {
						_target = pick _mbs;
					};
					
					_trg = _target;
					_ps = _trg modelToWorld ((_trg selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);

					for "_iP" from 1 to randInt(1,4) do {
						[("begin_mainattacker"+_strI) call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
						0.15 call sp_threadPause;
					};

					rand(2,4) call sp_threadPause;
				};
			},_i] call sp_threadStart;
		};

		1.8 call sp_threadPause;

		_refv = ("begin_startdead4" call sp_ai_getMobBody) getvariable "anim_handle";
		[_refv] call sp_ai_stopAnim;
		{callFuncParams("begin_startdead4" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD)} call sp_threadCriticalSection;


		rand(1,2) call sp_threadPause;

		_refv = ("begin_startdead5" call sp_ai_getMobBody) getvariable "anim_handle";
		[_refv] call sp_ai_stopAnim;
		{callFuncParams("begin_startdead5" call sp_ai_getMobObject,lossLimb,BP_INDEX_ARM_L)} call sp_threadCriticalSection;
		{callFuncParams("begin_startdead5" call sp_ai_getMobObject,lossLimb,BP_INDEX_LEG_R)} call sp_threadCriticalSection;
		{callFuncParams("begin_startdead5" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD)} call sp_threadCriticalSection;
		
		
	} call sp_threadStart;

}] call sp_addTriggerEnter;

begin_run1_act = false;
["begin_run1",{
	if (begin_run1_act) exitWith {};
	begin_run1_act = true;
	{
		_player = call sp_getActor;
		_body = player;
		while {true} do {
			_ps = _body modelToWorld ((_body selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);

			for "_iP" from 1 to randInt(1,4) do {
				[("begin_mainattacker3") call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
				0.35 call sp_threadPause;
			};

			rand(2,4) call sp_threadPause;
		};

	} call sp_threadStart;
	["begin_mainattacker3","begin_pos_mainattacker3","begin\mainattacker3",{},[
		["state_1",{
			//[{begin_enterrun2_act}] call sp_ai_animWait;
		}],
		["state_2",{
			[{begin_run3_act}] call sp_ai_animWait;
		}],
		["state_3",{
			["begin_mainattacker3" call sp_ai_getMobObject,("begin_keeper1" call sp_ai_getMobBody) modelToWorld [0,0,0.4]] call cpt5_act_doShot;
			callFuncParams("begin_keeper1" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD)
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_enterrun2_act = false;
["begin_run2",{
	if (begin_enterrun2_act) exitWith {};
	begin_enterrun2_act = true;
	callFuncParams("begin_rundoor1" call sp_getObject,setDoorOpen,false);

	["begin_mainattacker4","begin_pos_mainattacker4","begin\mainattacker4",{},[
		["state_1",{
			[{begin_enterrun4}] call sp_ai_animWait;
		}]
	]] call sp_ai_playAnim;

	//start begin_pos_mainattacker5
	//attacking
	_hndl = ["begin_startdead6","begin_pos_startdead6","begin\startdead6",{

	},[
		["state_1",{
			params ["_obj"];
			_objT = "begin_obj_startdead6weap" call sp_getObject;
			[_obj,_objT,INV_HAND_L] call sp_ai_moveItemToMob;
		}],
		["state_2",{

		}]
	]] call sp_ai_playAnim;
	("begin_startdead6" call sp_ai_getMobBody) setvariable ["anim_handle",_hndl];

	["begin_mainattacker5","begin_pos_mainattacker5","begin\mainattacker5",{},[
		["state_1",{
			//attack1
			{
				_body = "begin_startdead6" call sp_ai_getMobBody;
				_ps = _body modelToWorld ((_body selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);
				_ps = _ps vectoradd [rand(-1.5,1.5),0,rand(0,0.8)];
				for "_iP" from 1 to randInt(3,6) do {
					[("begin_mainattacker5") call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
					rand(0.3,0.4) call sp_threadPause;
				};				
			} call sp_threadStart;
		}],
		["state_2",{
			//kill
			{
				_body = "begin_startdead6" call sp_ai_getMobBody;
				_target = "begin_startdead6" call sp_ai_getMobObject;
				_ps = _body modelToWorld ((_body selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);
				
				{
					[_body getvariable "anim_handle"] call sp_ai_stopAnim;
					_body switchmove "";
				} call sp_threadCriticalSection;

				for "_iP" from 1 to randInt(3,6) do {
					[("begin_mainattacker5") call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
					rand(0.3,0.4) call sp_threadPause;
				};

				_prts = [BP_INDEX_ARM_L,BP_INDEX_ARM_R,BP_INDEX_LEG_L,BP_INDEX_LEG_R];
				for "_i" from 1 to randInt(1,3) do {
					{
						callFuncParams(_target,lossLimb,pick _prts);
					} call sp_threadCriticalSection;
				};
				{
					callFuncParams(_target,lossLimb,BP_INDEX_HEAD);
				} call sp_threadCriticalSection;

			} call sp_threadStart;
		}],
		["state_3",{
			//offcomb
			callFuncParams("begin_mainattacker5" call sp_ai_getMobObject,setCombatMode,false);
		}],
		["state_4",{
			//check door
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_run3_act = false;
["begin_run3",{
	if (begin_run3_act) exitWith {};
	begin_run3_act = true;

}] call sp_addTriggerEnter;

begin_enterrun4 = false;
begin_run4_processenemy = true;
["begin_run4",{
	if (begin_enterrun4) exitWith {};
	begin_enterrun4 = true;

	callFuncParams("begin_rundoor2" call sp_getObject,setDoorOpen,false);
	{
		_mob = ("begin_mainattacker4" call sp_ai_getMobObject);
		_targets = [];
		for "_i" from 7 to 9 do {
			_targets pushBack (("begin_startdead"+(str _i)) call sp_ai_getMobObject);
		};
		while {begin_run4_processenemy} do {
			
			_target = pick _targets;
			_tbody = getVar(_target,owner);
			_ps = _tbody modelToWorld ((_tbody selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);
			
			for "_i" from 1 to randInt(2,4) do {
				[_mob,_ps] call cpt5_act_doShot;
				rand(0.15,0.18) call sp_threadPause;	
			};

			rand(1.5,2.1) call sp_threadPause;

			if not_equals(_target,call sp_getActor) then {
				callFuncParams(_target,lossLimb,BP_INDEX_HEAD);
				_prts = [BP_INDEX_ARM_L,BP_INDEX_ARM_R,BP_INDEX_LEG_L,BP_INDEX_LEG_R];
				for "_i" from 1 to randInt(1,3) do {
					{
						callFuncParams(_target,lossLimb,pick _prts);
					} call sp_threadCriticalSection;
				};
				
				{
					if !callFunc(_x,isActive) then {
						_targets set [_forEachIndex,objNull];
					};
				} foreach _targets;
				_targets = _targets - [objNull];
				if (count _targets == 0) then {
					_targets = [call sp_getActor];
				};
			};
			
		};
	} call sp_threadStart;
}] call sp_addTriggerEnter;

begin_run4enterercutscene_act = false;
begin_act_readyToDown = false;
["begin_run4enterercutscene",{
	if (begin_run4enterercutscene_act) exitWith {};
	begin_run4enterercutscene_act = true;

	/*
		state1 - ожидание и диалог
		state2 - закрытие когда игрок спрятался
		state3 - комбат начало
		state4 - смерть
	*/
	["begin_keeper2","begin_pos_keeper2","begin\keeper2",{},[
		["state_1",{
			[{begin_run5_act}] call sp_ai_animWait;
		}],
		["state_2",{
			//todo close crate and sounds
		}],
		["state_3",{
			//sounds sword
			_obj = "begin_keeper2" call sp_ai_getMobObject;
			callFunc(_obj,switchTwoHands);
			callFuncParams(_obj,setCombatMode,true);
			{
				_obj = "begin_keeper2" call sp_ai_getMobObject;
				0.5 call sp_threadPause;
				for "_i" from 1 to 6 do {
					private _snd = "attacks\blade_parry" + (str randInt(1,3));
					private _rpith = getRandomPitchInRange(0.6,1.3);
					callFuncParams(_obj,playSound,_snd arg _rpith arg 20 arg null arg null arg false);
					rand(0.6,0.8) call sp_threadPause;
				};
				
			} call sp_threadStart;
		}],
		["state_4",{
			callFuncParams("begin_keeper2" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD);
			//death
		}]
	]] call sp_ai_playAnim;

}] call sp_addTriggerEnter;

begin_internal_collisionObjects = [];
begin_internal_setNearCollisionMode = {
	params ["_mode",["_dist",10]];
	private _isEnabled = count begin_internal_collisionObjects > 0;
	if (_mode == _isEnabled) exitWith {};
	if (_mode) then {
		begin_internal_collisionObjects = player nearObjects _dist;
		{
			player disableCollisionWith _x;
		} foreach begin_internal_collisionObjects;
	} else {
		{
			player enableCollisionWith _x;
		} foreach begin_internal_collisionObjects;
		begin_internal_collisionObjects = [];
	};
};

begin_run5_act = false;
["begin_run5",{
	if (begin_run5_act) exitWith {};
	begin_run5_act = true;

	//player animation
	//begin_pos_playerautoanim1
	player forcewalk true;
	[true] call begin_internal_setNearCollisionMode;
	[true] call sp_gui_setCinematicMode;
	[player,"begin_pos_playerautoanim1","begin\playerautoanim1",{
		[false] call begin_internal_setNearCollisionMode;
		[false] call sp_gui_setCinematicMode;
	}] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_cutscene1_act = false;
["begin_cutscene1",{
	if (begin_cutscene1_act) exitWith {};
	begin_cutscene1_act = true;

	begin_run4_processenemy = false; //stop far enemy processing

	//begin_pos_cutscene1dead
	//begin_pos_cutscene1attack
	["begin_cutscene1dead","begin_pos_cutscene1dead","begin\cutscene1dead",{},[]] call sp_ai_playAnim;
	["begin_cutscene1attack","begin_pos_cutscene1attack","begin\cutscene1attack",{},[
		["state_1",{
			_dead = "begin_cutscene1dead" call sp_ai_getMobObject;
			callFuncParams("begin_cutscene1attack" call sp_ai_getMobObject,attackOtherMob,_dead);
			callFuncParams(_dead,lossLimb,BP_INDEX_HEAD);
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_run6_act = false;
["begin_run6",{
	if (begin_run6_act) exitWith {};
	begin_run6_act = true;
	//begin_pos_playerautoanim2
	[true] call begin_internal_setNearCollisionMode;
	[true] call sp_gui_setCinematicMode;
	[player,"begin_pos_playerautoanim2","begin\playerautoanim2",{
		[false] call begin_internal_setNearCollisionMode;
		[false] call sp_gui_setCinematicMode;
	}] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_tokeeper3_act = false;
["begin_tokeeper3",{
	if (begin_tokeeper3_act) exitWith {};
	begin_tokeeper3_act = true;

	["begin_keeper3","begin_pos_keeper3","begin\keeper3",{},[
		["state_1",{}],//hello
		["state_2",{
			player forcewalk false;
			callFuncParams("begin_doortoexit" call sp_getObject,setDoorOpen,true);
		}],//open
		["state_3",{}],//pre close
		["state_4",{
			{
				{
					callFuncParams("begin_doortoexit" call sp_getObject,setDoorOpen,false);
				} call sp_threadCriticalSection;				
				0.3 call sp_threadPause;
				{
					callFuncParams("begin_doortoexit" call sp_getObject,setDoorLock,true);
				} call sp_threadCriticalSection;
			} call sp_threadStart;
		}],//close
		["state_5",{}]//die
	]] call sp_ai_playAnim;

	["begin_cutscene2dead2","begin_pos_cutscene2dead2","begin\cutscene2dead2",{},[
		["state_1",{
			[{begin_cutscene2_act}] call sp_ai_animWait
		}]
	]] call sp_ai_playAnim;

	["begin_cutscene2attack1","begin_pos_cutscene2attack1","begin\cutscene2attack",{},[
		["state_1",{
			[{begin_cutscene2_act}] call sp_ai_animWait
		}],
		["state_2",{
			//kill
			{
				_src = ("begin_cutscene2attack1") call sp_ai_getMobObject;
				{
					_t = _x call sp_ai_getMobObject;
					_body = getVar(_t,owner);
					_ps = _body modelToWorld (_body selectionPosition "head");
					[_src,_ps] call cpt5_act_doShot;

					rand(0.1,0.15) call sp_threadPause;
					{
						callFuncParams(_t,lossLimb,BP_INDEX_HEAD);
					} call sp_threadCriticalSection;

					rand(0.6,0.8) call sp_threadPause;
				} foreach [
					"begin_cutscene2dead2",
					"begin_keeper3"
				];
			} call sp_threadStart;
		}],
		["state_3",{
			//check door
			_door = "begin_doortoexit" call sp_getObject;

			private _snd = "doors\locked" + str pick [1 arg 2];
			private _rpith = getRandomPitchInRange(0.6,1.3);
			callFuncParams(_door,playSound,_snd arg _rpith arg 50 arg null arg null arg false);
		}]
	]] call sp_ai_playAnim;

	//exitdoor - begin_doortoexit
	//cutscene door - begin_doorexit_cutscene2

}] call sp_addTriggerEnter;

begin_cutscene2_act = false;
["begin_cutscene2",{
	if (begin_cutscene2_act) exitWith {};
	begin_cutscene2_act = true;

	callFuncParams("begin_doorexit_cutscene2" call sp_getObject,setDoorOpen,true);
	_snd = "doors\kick_break" + str randInt(1,3);
	callFuncParams("begin_doorexit_cutscene2" call sp_getObject,playSound,_snd arg getRandomPitchInRange(0.6,1.3));

}] call sp_addTriggerEnter;

begin_prechase_act = false;
["begin_prechase",{
	if (begin_prechase_act) exitWith {};
	begin_prechase_act = true;

	[true,30] call begin_internal_setNearCollisionMode;
	[true] call sp_gui_setCinematicMode;
	[player,"begin_pos_playerautoanim3","begin\playerautoanim3",{
		[false] call begin_internal_setNearCollisionMode;
		[false] call sp_gui_setCinematicMode;
	}] call sp_ai_playAnim;

}] call sp_addTriggerEnter;

begin_chase_act = false;
["begin_chase",{
	if (begin_chase_act) exitWith {};
	begin_chase = true;

	//begin_pos_chase_attacker1/2
	["begin_chase_attacker1","begin_pos_chase_attacker1","begin\chase_attacker1",{

	},[
		["state_1",{
			callFuncParams("begin_doorexit" call sp_getObject,setDoorOpen,true);
		}]
	]] call sp_ai_playAnim;

	{
		
		_body = player;
		while {true} do {
			setVar(("begin_chase_attacker1") call sp_ai_getMobObject,stamina,100);
			_ps = _body modelToWorld ((_body selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);

			for "_iP" from 1 to randInt(1,5) do {
				[("begin_chase_attacker1") call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
				rand(0.5,0.7) call sp_threadPause;
			};

			rand(3,5) call sp_threadPause;
		};
		
	} call sp_threadStart;

}] call sp_addTriggerEnter;

begin_chaseend_act = false;
["begin_chaseend",{
	if (begin_chaseend_act) exitWith {};
	begin_chaseend_act = true;

	["begin_chase_attacker2","begin_pos_chase_attacker2","begin\chase_attacker2",{

	},[
		["state_1",{
			callFuncParams("begin_doorexit2" call sp_getObject,setDoorOpen,true);
		}]
	]] call sp_ai_playAnim;

	{
		
		_body = player;
		while {true} do {
			setVar(("begin_chase_attacker2") call sp_ai_getMobObject,stamina,100);
			_ps = _body modelToWorld ((_body selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);

			for "_iP" from 1 to randInt(1,5) do {
				[("begin_chase_attacker2") call sp_ai_getMobObject,_ps] call cpt5_act_doShot;
				rand(0.5,0.7) call sp_threadPause;
			};

			rand(3,5) call sp_threadPause;
		};
		
	} call sp_threadStart;

}] call sp_addTriggerEnter;

begin_finalizer_act = false;
["begin_finalizer",{
	if (begin_finalizer_act) exitWith {};
	begin_finalizer_act = true;

	(findDisplay 46) displayRemoveEventHandler ["KeyDown",begin_handleKeyDown];
	begin_handleKeyDown = -1;

	[""] call sp_view_setPlayerHudVisible;
	[true,0.1] call setBlackScreenGUI;
	{
		5 call sp_threadPause;
		["cpt1_begin"] call sp_startScene;
	} call sp_threadStart;

}] call sp_addTriggerEnter;