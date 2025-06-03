// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

cpt5_debug_skipStart = false;

cpt5_questName_startCombat = "Война";
cpt5_questName_rangedCombat = "Лучшая защита - нападение";
cpt5_questName_preend = "Последний рывок";

cpt5_playerUniform = "StreakCloth";

["cpt5_begin",{
	if (!sp_debug) then {cpt5_debug_skipStart = false};
	["cpt5_pos_start",0] call sp_setPlayerPos;

	if isNullReference(callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH)) then {
		private _cloth = [cpt5_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;
	};

	call sp_initializeDefaultPlayerHandlers;
	[sp_const_list_stdPlayerHandlers,false] call sp_setLockPlayerHandler;
	[true] call sp_setPlayerSprintAllowed;

	if (!cpt5_debug_skipStart) then {
		private _bedObj = "cpt5_obj_bedplayer" call sp_getObject;
		callFuncParams(_bedObj,seatConnect,call sp_getActor arg 0);
		(getVar(_bedObj,_seatListDummy) select 0)setvariable ["_restDir",_restDir];

		private _usr = call sp_getActor;
		callFuncParams(_usr,changeVisionBlock,+1 arg "slp");
		callFuncParams(_usr,fastSendInfo,"hud_sleep" arg 1);
		setVar(_usr,sleepStrength,1);
		setVar(_usr,__isFirstUnsleep,false);
	};

	{
		{
			[true,0.01] call setBlackScreenGUI;
			3 call sp_threadPause;
			["cpt5_pos_playerrespawn_warzone",0] call sp_setPlayerPos;
			0.5 call sp_threadPause;
			sp_playerHp = 100;
			[false,3.5] call setBlackScreenGUI;
		} call sp_threadStart;
	} call sp_setEventDiePlayer;
	
	
	//making mobs
	for "_i" from 1 to 2 do {
		["cpt5_pos_bedwall","cpt5_bedwall_" + (str _i),[
			["uniform","StreakCloth"],
			["name",["Защитник"]]
		],{
			callFuncParams(("cpt5_obj_bedwall"+(str _i)) call sp_getObject,seatConnect,_this arg _i - 1);
			callFuncParams(_this,setCloseEyes,true);
		}] call sp_ai_createPersonEx;
	};
	
	for "_i" from 1 to 3 do {
		_iReal = (_i %2) + 1;
		["cpt5_pos_bednear","cpt5_bednear_" + (str _iReal),[
			["uniform","StreakCloth"],
			["name",["Защитник"]]
		],{
			private _indplc = _iReal - 1;
			if (_iReal == 2) then {_indplc = null};
			callFuncParams(("cpt5_obj_bednear"+(str _iReal)) call sp_getObject,seatConnect,_this arg _indplc);

			callFuncParams(_this,setCloseEyes,true);
		}] call sp_ai_createPersonEx;
	};

	["cpt5_pos_lekarstand","cpt5_lekarstand",[
		["uniform","DoctorCloth"],
		["name",["Лекарь"]]
	],{},{
		_this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop";
	}] call sp_ai_createPersonEx;
	["cpt5_pos_lekarmove","cpt5_lekarmove",[
		["uniform","DoctorCloth"],
		["name",["Лекарь"]]
	],{},{
		_this switchMove "Acts_Accessing_Computer_Loop";
	}] call sp_ai_createPersonEx;

	["cpt5_pos_lekarmove","cpt5_lekar_dead",[
		["uniform","StreakCloth"],
		["name",["Раненый"]]
	],{
		callFuncParams("cpt5_obj_lekarbed" call sp_getObject,seatConnect,_this);
		
		private _item = callFuncParams(_this,getPart,BP_INDEX_ARM_R);		
		callFuncParams(_item,unlink,null arg true);

		_item = callFuncParams(_this,getPart,BP_INDEX_LEG_L);		
		callFuncParams(_item,unlink,null arg true);

		callFuncParams(_this,setCloseEyes,true);
	},{
		_this enablemimics false;
		_this switchMove "Acts_Accessing_Computer_Loop";
	}] call sp_ai_createPersonEx;

	["cpt5_pos_lekarwoundbody","cpt5_lekar_woundedman",[
		["uniform","StreakCloth"],
		["name",["Раненый"]]
	],{
		callFuncParams("cpt5_obj_lekarwoundbody_bed" call sp_getObject,seatConnect,_this);
		
		private _item = callFuncParams(_this,getPart,BP_INDEX_LEG_R);		
		callFuncParams(_item,unlink,null arg true);

		_item = callFuncParams(_this,getPart,BP_INDEX_LEG_L);		
		callFuncParams(_item,unlink,null arg true);

		callFuncParams(_this,setCloseEyes,true);
	},{
		_this enablemimics false;
		_this switchMove "Acts_Accessing_Computer_Loop";
	}] call sp_ai_createPersonEx;
	
	//mover anim acts_millerDisarming_deskCrouch_loop
	["cpt5_pos_underground_mover","cpt5_underground_mover",[
		["uniform","StreakCloth"],
		["name",["Боец"]]
	],{},{
		_this switchMove "acts_millerDisarming_deskCrouch_loop";
	}] call sp_ai_createPersonEx;

	["cpt5_pos_weaponloader1","cpt5_weaponloader",[
		["uniform","StreakCloth"],
		["name",["Боец"]]
	]] call sp_ai_createPersonEx;
		["cpt5_weaponloader",
			[
				["cpt5_pos_weaponloader1","cpt5_weaponloader1",{rand(10,15)},{ 
					params ["_obj"]; 
					_obj switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_5_loop";
					[getposatl _obj,"chap5\sfx\ammo" + (str randInt(1,2))] call sp_audio_playSound;
				}],
				["cpt5_pos_weaponloader2","cpt5_weaponloader2",{rand(10,15)},{ 
					params ["_obj"]; 
					_obj switchMove "Acts_JetsCrewaidFCrouch_loop_m";
					[getposatl _obj,"chap5\sfx\ammo" + (str randInt(1,2))] call sp_audio_playSound;	
				}]
			]
		] call sp_ai_playAnimsLooped;

	["cpt5_pos_capitan1","cpt5_kapitan",[
		["uniform","StreakCloth"],
		["name",["Капитан"]],
		["face","facepoet"],
		["age",29]
	],{
		["RifleSVT",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;

	["cpt5_pos_defstrelok","cpt5_defstrelok",[
		["uniform","StreakCloth"],
		["name",["Боец"]],
		["age",37]
	],{
		["RifleSVT",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
		callFuncParams(_this,setCombatMode,true);
	}] call sp_ai_createPersonEx;

	["cpt5_pos_armytalker1","cpt5_armytalker1",[
		["uniform","StreakCloth"],
		["name",["Боец"]]
	],{},{
		//switchmove
		params ["_mob"];
		_mob switchMove "acts_aidlpercmstpsnonwnondnon_warmup_5_loop";
	}] call sp_ai_createPersonEx;

	["cpt5_pos_armytalker2","cpt5_armytalker2",[
		["uniform","StreakCloth"],
		["name",["Боец"]]
	],{},{
		//switchmove
		params ["_mob"];
		_mob switchMove "passenger_flatground_3_idle_unarmed";
	}] call sp_ai_createPersonEx;

	//wounded and static
	//anim lying Acts_SittingWounded_loop
	//lying normal Acts_Waking_Up_Player
	//wounded Acts_CivilInjuredGeneral_1
	//wounded2 Acts_CivilInjuredHead_1
	private _animlist = [
		"Acts_Waking_Up_Player",
		"Acts_SittingWounded_loop",
		"Acts_CivilInjuredGeneral_1"
	];
	for "_i" from 1 to 3 do {
		private _strnum = str _i;
		["cpt5_pos_armyguy"+_strnum,"cpt5_armyguy"+_strnum,[
			["uniform","StreakCloth"],
			["name",["Боец"]]
		],{},{
			_this switchMove (_animlist select (_i-1));
		}] call sp_ai_createPersonEx;

	};

	["cpt5_pos_woundedman","cpt5_woundedman",[
		["uniform","StreakCloth"],
		["name",["Раненый"]]
	],{
		private _item = callFuncParams(_this,getPart,BP_INDEX_LEG_R);		
		callFuncParams(_item,unlink,null arg true);
	},{
		_this switchmove "Acts_CivilInjuredLegs_1";
	}] call sp_ai_createPersonEx;

	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	//----------------------------------------------------------------------
	//-------------------------- spawn emeny -----------------------------
	["cpt5_pos_izt1","cpt5_izt1",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]],
		["face","asian"]
	],{
		["RifleAuto",_this,INV_HAND_R] call createItemInInventory;
		callFuncParams(_this,setCombatMode,true);
		callFunc(_this,switchTwoHands);
		[{
			_m = _this;
			while {true} do {
				rand(1,5) call sp_threadPause;
				
				
			};
		},_this] call sp_threadStart;
	},{
		_this setvariable ["anim_handler",
			["cpt5_izt1",[
				["cpt5_pos_izt1","cpt5_izt1_attackloop",rand(2,8),{},[
					["state_1",{
						//attack
						{
							rand(0.7,1.3) call sp_threadPause;
							_m = "cpt5_izt1" call sp_ai_getMobObject;
							for "_iter" from 1 to randInt(1,3) do {
								if (([_m] call cpt5_getVisMode)>=VISIBILITY_MODE_LOW) then {
									for "_i" from 1 to randInt(2,5) do {
										[_m,
											(player modelToWorld (player selectionPosition "head"))
											vectoradd [rand(-.3,.3),rand(-.3,.3),rand(-.1,.3)]
										] call cpt5_act_doShot;
										rand(0.05,0.1) call sp_threadPause;
									};
									rand(0.5,1.5) call sp_threadPause;
								};
								
							};
							
						} call sp_threadStart;
					}],
					["state_2",{
						//stop attack
					}]
				]]
			]] call sp_ai_playAnimsLooped
		];
	}] call sp_ai_createPersonEx;

	//сбегающие засранцы
	for "_i" from 1 to 2 do {
		_strI = str _i;
		["cpt5_pos_izt1_cov" + _strI,"cpt5_izt1_cov" + _strI,[
			["uniform","StreakCloth"],
			["name",["Истязатель"]],
			["face","asian"]
		],{
			["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
			callFuncParams(_this,setCombatMode,true);
			callFunc(_this,switchTwoHands);
		}] call sp_ai_createPersonEx;
	};

	["cpt5_pos_izt2","cpt5_izt2",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]],
		["face","asian"]
	],{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFuncParams(_this,setCombatMode,true);
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	["cpt5_pos_izt3","cpt5_izt3",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]],
		["face","asian"]
	],{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFuncParams(_this,setCombatMode,true);
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;

	for "_i" from 2 to 3 do {
		_iztbody = "cpt5_izt"+(str _i) call sp_ai_getMobBody;
		_iztbody setvariable ["anim_handler",
			["cpt5_izt"+(str _i),[
				["cpt5_pos_izt"+(str _i),"cpt5_izt_common_combat_loop",rand(2,8),{},[
					["state_1",{
						params ["_obj"];
						_m = _obj getvariable "link";
						//attack
						[{
							params ["_m"];
							rand(0.3,0.8) call sp_threadPause;
							
							for "_iter" from 1 to randInt(1,4) do {
								if (([_m] call cpt5_getVisMode)>=VISIBILITY_MODE_LOW) then {
									for "_i" from 1 to randInt(1,3) do {
										[_m,
											(player modelToWorld (player selectionPosition "head"))
											vectoradd [rand(-.3,.3),rand(-.3,.3),rand(-.1,.3)]
										] call cpt5_act_doShot;
										rand(1.2,1.4) call sp_threadPause;
									};
									rand(0.5,1.5) call sp_threadPause;
								} else {
									if prob(70) then {
										for "_i" from 1 to randInt(1,3) do {
											[_m,
												(player modelToWorld (player selectionPosition "head"))
												vectoradd [rand(-2.5,2.5),rand(-2.5,2.5),rand(-.1,2.3)]
											] call cpt5_act_doShot;
											rand(1.2,1.5) call sp_threadPause;
										};
									};
								};
								
							};
							
						},_m] call sp_threadStart;
					}],
					["state_2",{
						//stop attack
					}]
				]]
			]] call sp_ai_playAnimsLooped
		];
	};


	//moving pos (left->right) cpt5_pos_izcombat1 cpt5_pos_izcombat2
	["cpt5_pos_izcombat_spawn","cpt5_izcombat",[
		["uniform","StreakCloth"],
		["name",["Дико","Убивать"]],
		["face","face60"]
	],{
		["ShortSword",_this,INV_HAND_R] call createItemInInventory;
	}] call sp_ai_createPersonEx;


	{
		["right+stats+up+cursor+inv+stam"] call sp_view_setPlayerHudVisible;
		["press_specact",false] call sp_setLockPlayerHandler;
		_unsleepHandle = ["press_specact",{
			params ["_id"];
			_id != SPECIAL_ACTION_SLEEP
		}] call sp_addPlayerHandler;

		_thandle = {
			5 call sp_threadPause;
			["Чтобы проснуться нажмите $input_act_inventory и справа выберите ""Сон""."] call sp_setNotification;
		} call sp_threadStart;

		{
			!callFunc(call sp_getActor,isSleep)
		} call sp_threadWait;
		_thandle call sp_threadStop;
		_unsleepHandle call sp_removePlayerHandler;
		[false] call sp_setNotificationVisible;

		{
			!callFunc(call sp_getActor,isConnected)
		} call sp_threadWait;
		
		["war_under",true] call sp_audio_playMusic;

		[cpt5_questName_startCombat,"Отправляйтесь в бой"] call sp_setTaskMessageEff;

		{
			while {true} do {
				_p = pick [[-5,0,2],[5,0,2],[0,-5,2],[0,5,2]];
				[(getposatl player) vectoradd _p,"chap5\sfx\bum" + (str randInt(1,5)),30] call sp_audio_playSound;	
				rand(0.2,5) call sp_threadPause;
			};
		} call sp_threadStart;

		{
			{
				callFuncParams("cpt5_weaponloader" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true) <= 3;
			} call sp_threadWait;
			([
				["cpt5_weaponloader","chap5\underground\guy3"]
			] call sp_audio_startDialog);
		} call sp_threadStart;

	} call sp_threadStart;
}] call sp_addScene;

//общение лекарей
cpt5_act_lekartalks = false;
["cpt5_trg_lekarstalks",{
	if (!cpt5_act_lekartalks) then {
		cpt5_act_lekartalks = true;
		
		{

			([
				["cpt5_bedwall_1","chap5\underground\guy2"]
			] call sp_audio_startDialog);
			rand(2,4) call sp_threadPause;

			([
				["cpt5_bedwall_2","chap5\underground\guy4"]
			] call sp_audio_startDialog);
		} call sp_threadStart;

		{
			([
				["cpt5_lekarstand","chap5\underground\lek1_1",["endoffset",0.1]],
				["cpt5_lekarmove","chap5\underground\lek2_1",["endoffset",0.3]],
				["cpt5_lekarstand","chap5\underground\lek1_2",["endoffset",0.2]],
				["cpt5_lekarmove","chap5\underground\lek2_2",["endoffset",0.1]],
				["cpt5_lekarstand","chap5\underground\lek1_3",["endoffset",0.2]]
			] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
			//2 call sp_threadPause;
			["cpt5_lekarmove","cpt5_pos_lekarmove","cpt5_lekarmove_towounded",{
				params ["_mob"];
				_mob switchmove "Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop";
			}] call sp_ai_playAnim;
		} call sp_threadStart;
	};
}] call sp_addTriggerEnter;

//парень, идущий от спальников до оружейки
cpt5_act_undergroundmover = false;
["cpt5_trg_undergroundmover",{
	if (!cpt5_act_undergroundmover) then {
		cpt5_act_undergroundmover = true;

		([
			["cpt5_underground_mover","chap5\underground\guy1",["endoffset",0.1]]
		] call sp_audio_startDialog);

		["cpt5_underground_mover",[
			["cpt5_pos_underground_mover","cpt5_undergroundmover",rand(2,5),{
				params ["_mob"];
				[_mob,"cpt5_pos_underground_mover",0] call sp_ai_setMobPos;
				_mob switchMove "acts_millerDisarming_deskCrouch_loop";
			},[
				["state_1",{
					[{tickTime > _this},tickTime + rand(2,5)] call sp_ai_animWait;
				}]
			]]
		]] call sp_ai_playAnimsLooped;
	};
}] call sp_addTriggerEnter;

//капитан на входе подземки
cpt5_act_kapitanunderground = false;
cpt5_act_kapitanreadytoup = false;
cpt5_data_kapitan_startQuest_loadweapon = false;
["cpt5_trg_kapitanunderground",{



	if (cpt5_act_kapitanunderground) exitWith {
		if (cpt5_act_kapitanreadytoup) exitWith {};

		if (callFuncParams(call sp_getActor,hasItem,"RifleSVT")) exitWith {
			cpt5_act_kapitanreadytoup = true;

			["cpt5_kapitan","cpt5_pos_capitan2","cpt5_capitan2",{
				params ["_mob"];
				_mob switchmove "acts_aidlpercmstpslowwpstdnon_warmup_1_loop";
			}] call sp_ai_playAnim;
			
			_obj = "cpt5_obj_invvaltoup" call sp_getObject;
			if !isNullReference(_obj) then {
				[_obj] call deleteGameObject;
			};

		};

	};

	cpt5_act_kapitanunderground = true;
	["cpt5_kapitan","cpt5_pos_capitan1","cpt5_capitan1",{
		params ["_mob"];
		[_mob,"cpt5_pos_capitan2",0] call sp_ai_setMobPos;
		_mob switchmove "acts_aidlpercmstpslowwpstdnon_warmup_1_loop";
	}] call sp_ai_playAnim;
	["cpt5_act_kapitanunderground_talk"] call sp_startScene;
}] call sp_addTriggerEnter;

["cpt5_act_kapitanunderground_talk",{
	{
		{
			callFuncParams("cpt5_kapitan" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true)
			<= 2.5
			||
			(animationState ("cpt5_kapitan" call sp_ai_getMobBody)) == "acts_aidlpercmstpslowwpstdnon_warmup_1_loop"
		} call sp_threadWait;

		//dialog kapitan
		([
			["cpt5_kapitan","chap5\underground\under_kap1",["endoffset",0.1]],
			[player,"chap5\underground\under_gg1",["endoffset",0.1]],
			["cpt5_kapitan","chap5\underground\under_kap2",["endoffset",0.1]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
		//2 call sp_threadPause;

		[cpt5_questName_startCombat,"Возьмите со склада вооружение и подготовьтесь к бою."] call sp_setTaskMessageEff;
		cpt5_data_kapitan_startQuest_loadweapon = true;

	} call sp_threadStart;
}] call sp_addScene;

["cpt5_trg_prepareweapon",{

	private _trig = "cpt5_obj_virttrigger_weapontable" call sp_getObject;
	
	private _mags = ["MagazineSVT",callFunc(_trig,getPos),4] call getAllItemsOnPosition;
	["cpt5_data_wtable_mags",_mags] call sp_storageSet;

	private _rifles = ["RifleSVT",callFunc(_trig,getPos),4] call getAllItemsOnPosition;
	["cpt5_data_wtable_rifles",_rifles] call sp_storageSet;

	{
		{cpt5_data_kapitan_startQuest_loadweapon} call sp_threadWait;

		[cpt5_questName_startCombat,"Зарядите магазины."] call sp_setTaskMessageEff;
		["Откройте коробку с патронами. Для этого нажмите $input_act_mainAction по ней. Чтобы вытащить патроны нажмите ЛКМ. Патроны вытаскиваются по 1 штуке за раз."] call sp_setNotification;

		{
			callFuncParams(call sp_getActor,hasItem,"AmmoRifle" arg true)
		} call sp_threadWait;

		["Чтобы зарядить патрон в магазин нажмите ЛКМ с патроном в руке по магазину. Зарядите несколько полных магазинов."] call sp_setNotification;

		{
			_mags = ["cpt5_data_wtable_mags",[]] call sp_storageGet;
			({callFunc(_x,getAmmoCount) == getVar(_x,maxCount)}count _mags) >= 2
		} call sp_threadWait;

		["Чтобы вставить магазин в винтовку нажмите ЛКМ с магазином в руке по винтовке."] call sp_setNotification;

		{
			_rifles = ["cpt5_data_wtable_rifles",[]] call sp_storageGet;
			({callFunc(_x,hasMagazine)}count _rifles) >= 1
		} call sp_threadWait;
		[false] call sp_setNotificationVisible;

		[cpt5_questName_startCombat,"Поднимайтесь наверх"] call sp_setTaskMessageEff;

	} call sp_threadStart;
}] call sp_addScene;

cpt5_act_doShot = {
	params ["_mob","_targetPos"];
	if canSuspend exitWith {
		private _args = _this;
		{_args call cpt5_act_doShot} call sp_threadCriticalSection;
	};
	private _gobj = callFunc(_mob,getItemInActiveHandRedirect);
	if isNullReference(_gobj) exitWith {};
	if !isTypeOf(_gobj,IRangedWeapon) exitWith {};
	private _model = getFieldBaseValueWithMethod("IAmmoBase","","getProjectileModel");

	private _vData = callFunc(_gobj,getAttackVisualData);
	
	callFunc(_mob,generateLastInteractOnServer);

	private _startPos = callFunc(_mob,getLastInteractStartPos);
	private _vectorDirection = vectorNormalized(_targetPos vectorDiff _startPos);
	private _distance = callFuncParams(_gobj,getBasicDistance,_mob);
	private _precdown = callFuncParams(_gobj,getPrecDown,_mob);
	private _leveldown = callFuncParams(_gobj,getLevelDown,_mob);
	private _speed = callFuncParams(_gobj,getShootSpeed,_mob);

	callFunc(_gobj,getShootSound) params ["_path","_pitchMin","_pitchMax"];
	private _dat = [
		[_model] call model_getAssoc,
		interact_map_shassoc_keystr get _path,
		[rand(_pitchMin,_pitchMax),callFunc(_gobj,getShootSoundDistance)],
		_distance,
		_precdown,
		_leveldown,
		_speed/10
	];
	if not_equals(_vData,"") then {
		_dat pushBack _vData;
	};
	
	private _lookatredirect = [_startPos,_targetPos] call cpt5_getLookAt;
	getVar(_mob,owner) setvariable ["__sp_temp_lookat_redirect",_lookatredirect];

	callFuncParams(_mob,applyAttackVisualEffects,_gobj arg "shot" arg _dat);
	
	
};

cpt5_getLookAt = {
	params [["_start", [0.0, 0.0, 0.0]], ["_end", [0.0, 0.0, 0.0]], ["_default", [[0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]]];

	if (_start isEqualTo _end) exitWith {_default;};

	private _forward = vectorNormalized (_end vectorDiff _start);
	private _right = _forward vectorCrossProduct [0.0, 0.0, 1.0];
	private _up = (_forward vectorCrossProduct _right) vectorMultiply -1;

	[_forward, _up];
};

cpt5_explosionGrenade = {
	params ["_pos"];
	
	callFuncParams(call sp_getActor,playSound,"atmos\grenade" arg rand(0.8,1.2) arg 80);

	private _dist = _pos distance (getposatl player);
	private _mv = linearConversion [5,30,_dist,0.23,0.01,true];
	private _dr = linearConversion [5,30,_dist,30.5,0.01,true];
	private _coef = linearConversion [5,30,_dist,0.08,1,true];
	[_mv,_dr,0.08,0.8] call cam_addCamShake;

	private _emt = "SLIGHT_FX_GRENADE" call lightSys_getConfigIdByName;
	_dur = rand(0.1,0.2);
	callFuncParams(call sp_getActor,sendInfo,"do_fe" arg [_pos arg _emt arg null arg _dur]);
};

cpt5_getVisMode = {
	params ["_src"];
	private _refm = refcreate(VISIBILITY_MODE_NONE);
	if (callFuncParams(_src,canSeeObject,call sp_getActor arg _refm)
	&& !getVar(call sp_getActor,isStealthEnabled)) exitWith {
		refget(_refm);
	};
	refget(_refm);
};

if !isNull(cpt5_internal_handleUpdateFire) then {
	stopUpdate(cpt5_internal_handleUpdateFire);
};
cpt5_internal_handleUpdateFire = startUpdate(interact_th__clith,0); //start fire update

cpt5_internal_warzoneGrenades = true;

cpt5_trg_combat_enterstrelok_act = false;
["cpt5_trg_combat_enterstrelok",{
	if (cpt5_trg_combat_enterstrelok_act) exitWith {};
	cpt5_trg_combat_enterstrelok_act = true;

	_body = "cpt5_defstrelok" call sp_ai_getMobBody;
	_attackEvent = {
		[{
			if (tickTime > _this) then {
				{
					rand(0.2,0.8) call sp_threadPause;
					_targetref = (pick["cpt5_izt1_cov1","cpt5_izt1_cov2","cpt5_izt1"]);
					_tm = _targetref call sp_ai_getMobBody;
					for "_i" from 1 to randInt(1,3) do {
						["cpt5_defstrelok" call sp_ai_getMobObject,
							(_tm modelToWorld (_tm selectionPosition "head"))
							vectoradd [rand(-2.5,2.5),rand(-2.5,2.5),rand(-.1,2.3)]
						] call cpt5_act_doShot;
						rand(1.2,1.5) call sp_threadPause;
					};
				} call sp_threadStart;
			};
			tickTime > _this
		},tickTime + rand(1,7)] call sp_ai_animWait;
	};
	_body setvariable ["anim_handler",
		["cpt5_defstrelok",[
			["cpt5_pos_defstrelok","cpt5_defstrelok",rand(2,8),{},[
				["state_1",_attackEvent],
				["state_2",_attackEvent],
				["state_3",_attackEvent]
			]]
		]] call sp_ai_playAnimsLooped
	];

	{
		1.3 call sp_threadPause;
		([
			["cpt5_defstrelok","chap5\warzone\strelok1",["endoffset",0.4]]
		] call sp_audio_startDialog);
	} call sp_threadStart;
}] call sp_addTriggerEnter;


cpt5_trg_combat_stage1_act = false;
//приказ подавления
["cpt5_trg_combat_stage1",{
	if (cpt5_trg_combat_stage1_act) exitWith {};
	cpt5_trg_combat_stage1_act = true;

	["combat",false] call sp_setLockPlayerHandler;
	["two_hands",false] call sp_setLockPlayerHandler;

	["cpt5_data_izt_runaway_count",0] call sp_storageSet;

	//thread attackers for suppressing
	for "_i" from 1 to 2 do {
		_attackEvent = {
			params ["_obj"];
			_m = _obj getvariable "link";
			//attack
			[{
				params ["_m"];
				rand(0.3,0.8) call sp_threadPause;
				
				for "_iter" from 1 to randInt(1,4) do {
					if (([_m] call cpt5_getVisMode)>=VISIBILITY_MODE_LOW) then {
						for "_i" from 1 to randInt(1,3) do {
							[_m,
								(player modelToWorld (player selectionPosition "head"))
								vectoradd [rand(-.3,.3),rand(-.3,.3),rand(-.1,.3)]
							] call cpt5_act_doShot;
							rand(1.2,1.4) call sp_threadPause;
						};
						rand(0.5,1.5) call sp_threadPause;
					} else {
						if prob(70) then {
							for "_i" from 1 to randInt(1,3) do {
								[_m,
									(player modelToWorld (player selectionPosition "head"))
									vectoradd [rand(-2.5,2.5),rand(-2.5,2.5),rand(-.1,2.3)]
								] call cpt5_act_doShot;
								rand(1.2,1.5) call sp_threadPause;
							};
						};
					};
					
				};
				
			},_m] call sp_threadStart;
		};

		_iztbody = "cpt5_izt1_cov"+(str _i) call sp_ai_getMobBody;
		_iztbody setvariable ["runawayanim","cpt5_iztsuppress"+(str _i)+"_run"];
		_iztbody setvariable ["anim_handler",
			["cpt5_izt1_cov"+(str _i),[
				["cpt5_pos_izt1_cov"+(str _i),"cpt5_iztsuppresser" + (str _i),rand(2,8),{},[
					["state_1",_attackEvent]
				],_attackEvent]
			]] call sp_ai_playAnimsLooped
		];
		[{
			params ["_i"];
			_iztref = "cpt5_izt1_cov"+(str _i);
			_iztpos = "cpt5_pos_izt1_cov"+(str _i);
			_iztbody = _iztref call sp_ai_getMobBody;
			_iztmob = _iztref call sp_ai_getMobObject;
			while {true} do {
				{
					if (getVar(_iztmob,penaltySupressFire) > 0) exitWith {
						setVar(_iztmob,penaltySupressFire,0);
						["cpt5_data_izt_runaway_count",{_this + 1}] call sp_storageUpdate;
						//stop anim and play another
						_refizt = _iztbody getvariable "anim_handler";
						refset(_refizt,true);

						[_iztref,_iztpos,_iztbody getvariable "runawayanim"] call sp_ai_playAnim;
					};
				} call sp_threadCriticalSection;
				0.1 call sp_threadPause;
				

			};
		},_i] call sp_threadStart;
	};

	{
		//dialog
		([
			["cpt5_kapitan","chap5\underground\kap_podavl",["endoffset",0.1]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;


		[cpt5_questName_rangedCombat,"Подавите позиции врага"] call sp_setTaskMessageEff;
		
		["Возьмите винтовку в руки."] call sp_setNotification;

		_slots = [INV_HAND_L,INV_HAND_R];
		{
			_wpns = _slots apply {
				callFuncParams(call sp_getActor,getItemInSlot,_x)
			};
			({
				!isNullReference(_x)
				&& {
					isTypeOf(_x,RifleSVT)
				}
			}count _wpns) > 0

		} call sp_threadWait;

		["Чтобы передёрнуть затвор винтовки нажмите ЛКМ по ней. Винтовка при этом должна находится в активной руке."] call sp_setNotification;

		{
			_wpns = _slots apply {
				callFuncParams(call sp_getActor,getItemInSlot,_x)
			};
			({
				!isNullReference(_x)
				&& {
					isTypeOf(_x,RifleSVT)
				} &&
				{
					!isNullReference(callFunc(_x,getBullet))
				}
			}count _wpns) > 0
		} call sp_threadWait;

		if (!callFuncParams(call sp_getActor,isHoldedTwoHands,callFunc(call sp_getActor,getItemInActiveHandRedirect))) then {
			["Нажмите $input_act_switchTwoHands чтобы схватить винтовку двумя руками."] call sp_setNotification;
		};
		{
			callFuncParams(call sp_getActor,isHoldedTwoHands,callFunc(call sp_getActor,getItemInActiveHandRedirect))
		} call sp_threadWait;
		
		["Стрельба на подавление снижает точность противника. Не обязательно попадать по нему, достаточно выстрелить в его сторону."
		+" Для стрельбы на подавление выбреите режим ""Подавление"" в верхнем меню и начинайте стрельбу по истязателям"] call sp_setNotification;

		//
		{
			(["cpt5_data_izt_runaway_count",0] call sp_storageGet) >= 2
		} call sp_threadWait;

		[false] call sp_setNotificationVisible;
		["cpt5_attack_afterstage1"] call sp_startScene;

		{
			_trg = "cpt5_obj_warzoneobjref" call sp_getObject;
			_xMid = getVar(_trg,sizeX)/2;
			_yMid = getVar(_trg,sizeY)/2;
			_zMid = getVar(_trg,sizeZ)/2;
			_pos = callFunc(_trg,getPos);

			while {cpt5_internal_warzoneGrenades} do {
				_rpos = _pos vectorAdd [
					rand(-_xMid,_xMid),
					rand(-_yMid,_yMid),
					_zMid
				];
				_rdata = [_rpos,_rpos vectoradd [0,0,-1000]] call interact_getRayCastData;
				if !isNullReference(_rdata select 0) then {
					{
						[_rdata select 1] call cpt5_explosionGrenade;
					} call sp_threadCriticalSection;
				};

				rand(5,100) call sp_threadPause;
			};
		} call sp_threadStart;
	} call sp_threadStart;

}] call sp_addTriggerEnter;

["cpt5_trg_warzonetalkers",{
	{
		([
			["cpt5_armytalker2","chap5\warzone\campfirer1",["endoffset",1.2]],
			["cpt5_armytalker1","chap5\warzone\campfirer2",["endoffset",0.1]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
	} call sp_threadStart;
}] call sp_addScene;

cpt5_trg_enterwarzone_entered = false;
["cpt5_trg_enterwarzone",{
	if (cpt5_trg_enterwarzone_entered) exitWith {};
	cpt5_trg_enterwarzone_entered = true;

	{
		2 call sp_threadPause;
		{
			[callFunc("cpt5_trgobj_event_grenade1" call sp_getObject,getPos)] call cpt5_explosionGrenade;
		} call sp_threadCriticalSection;
		["war_v2",true] call sp_audio_playMusic;
	} call sp_threadStart;
}] call sp_addTriggerEnter;

cpt5_warzone_danger = true;
["cpt5_trg_warzone",{
	if (cpt5_warzone_danger) then {
		{
			rand(2,3) call sp_threadPause;
			_spos = player modelToWorld [0,2,2];
			_idat = [_spos,_spos vectoradd vec3(0,0,-100)] call interact_getRayCastData;
			if !isNullReference(_idat select 0) then {
				_spos = _idat select 1;
			};
			{
				[_spos] call cpt5_explosionGrenade;
			} call sp_threadCriticalSection;
			0.3 call sp_threadPause;
			[true,0.2] call setBlackScreenGUI;
			1 call sp_threadPause;
			["cpt5_pos_playerrespawn_warzone",0] call sp_setPlayerPos;
			0.2 call sp_threadPause;
			[false,2.5] call setBlackScreenGUI;
		} call sp_threadStart;
	};
	
}] call sp_addTriggerEnter;

//подавили врагов. двигаем вперёд
["cpt5_attack_afterstage1",{

	_obj = "cpt5_obj_invvaltowoundedman" call sp_getObject;
	if !isNullReference(_obj) then {
		[_obj] call deleteGameObject;
	};
	["cpt5_armyguy1","cpt5_pos_armyguy1_new",0] call sp_ai_setMobPos;

	["cpt5_armyguy2","cpt5_pos_armyguy2_new",0] call sp_ai_setMobPos;
	_mobj = ("cpt5_armyguy2" call sp_ai_getMobObject);
	["RifleFinisher",_mobj] call createItemInInventory;
	callFunc(_mobj,switchTwoHands);
	callFuncParams(_mobj,setCombatMode,true);
	_mbod = "cpt5_armyguy2" call sp_ai_getMobBody;
	_mbod switchmove "AadjPercMstpSrasWpstDright";
	[_mbod] call anim_syncAnim;

	["war_peacefull",true] call sp_audio_playMusic;

	{
		["cpt5_kapitan","cpt5_pos_capitan4",0] call sp_ai_setMobPos;
		//dialog
		([
			["cpt5_kapitan","chap5\warzone\kap1",[["endoffset",0.8],["distance",80]]],
			["cpt5_defstrelok","chap5\warzone\strelok2",["endoffset",0.4]],
			[player,"chap5\warzone\gg1",["endoffset",0.1]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
		
	} call sp_threadStart;
}] call sp_addScene;

cpt5_trg_savewoundedstart_act = false;
["cpt5_trg_savewoundedstart",{
	if (cpt5_trg_savewoundedstart_act) exitWith {};
	cpt5_trg_savewoundedstart_act = true;

	{
		([
			["cpt5_kapitan","chap5\warzone\kap2",["endoffset",0.4]],
			[player,"chap5\warzone\gg2",["endoffset",0.1]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		[cpt5_questName_rangedCombat,"Спасите раненого бойца на поле боя"] call sp_setTaskMessageEff;
	} call sp_threadStart;
}] call sp_addTriggerEnter;

["cpt5_trg_woundedmanfound",{
	{
		//dialog
		([
			["cpt5_woundedman","chap5\warzone\wounded1",["endoffset",1.4]],
			[player,"chap5\warzone\gg_towounded",["endoffset",1.2]],
			["cpt5_woundedman","chap5\warzone\wounded2",["endoffset",0.8]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		{
				//callFuncParams("cpt5_woundedman" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true) <= 5
			while {!cpt5_trg_woundedmansave_act} do {
				[
					["cpt5_woundedman","chap5\sfx\moan" + (str randInt(1,3))]
				] call sp_audio_startDialog;
				rand(5,10) call sp_threadPause;
			};
		} call sp_threadStart;

		_h = ["Чтобы тащить человека выберите режим ""Схватить"" в правом меню и нажмите $input_act_extraAction по раненому человеку."] call sp_setNotification;
		
		["extra_action",false] call sp_setLockPlayerHandler;

		_mob = "cpt5_woundedman" call sp_ai_getMobObject;
		{callFunc(_mob,isGrabbed)} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;

		[cpt5_questName_rangedCombat,"Дотащите раненого до ваших позиций"] call sp_setTaskMessageEff;

	} call sp_threadStart;
}] call sp_addScene;

cpt5_trg_woundedmansave_act = false;
["cpt5_trg_woundedmansave",{
	if (cpt5_trg_woundedmansave_act) exitWith {};
	_mob = "cpt5_woundedman" call sp_ai_getMobObject;
	_kapobjpos = "cpt5_pos_capitan4" call sp_getObject;
	 
	if ((callFuncParams(_kapobjpos,getDistanceTo,_mob arg true)) <= 3.5) then {
		cpt5_trg_woundedmansave_act = true;
		[true] call sp_setHideTaskMessageCtg;

		//dialog
		{
			([
				["cpt5_kapitan","chap5\warzone\kap3",["endoffset",0.1]],
				["cpt5_kapitan","chap5\warzone\kap4",["endoffset",0.1]],
				[player,"chap5\warzone\gg3",["endoffset",0.7]],
				["cpt5_kapitan","chap5\warzone\kap5",["endoffset",1]],
				[player,"chap5\warzone\gg4",["endoffset",1.1]],
				["cpt5_kapitan","chap5\warzone\kap6",["endoffset",0.1]]
			] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

			[cpt5_questName_rangedCombat,"Отправляйтесь к позиции на возвышености"] call sp_setTaskMessageEff;
		} call sp_threadStart;
	};
}] call sp_addTriggerEnter;

cpt5_act_shotingStarted = false;
["cpt5_trg_shooting",{
	if (!cpt5_trg_woundedmansave_act) exitWith {};
	if (cpt5_act_shotingStarted) exitWith {};
	cpt5_act_shotingStarted = true;

	["war_v2",true] call sp_audio_playMusic;

	["cpt5_data_deadizt",0] call sp_storageSet;

	{
		_hdam = ["damage",{
			objParams_1(_amount);
			//["act - " + str [this,_am,getVar(this,name)]] call chatPrint;
			if equals(this,call sp_getActor) exitWith {};
			if equals(getSelf(name),"Истязатель") then {
				sp_wsim_invokeNextAction = true;
				_nfHndl = {
					params ['this'];
					if ((({
						!callFuncParams(this,hasPart,_x)
					} count BP_INDEX_ALL) > 0) || getVar(this,isDead) || !callFunc(this,isActive)) then {
						_body = getVar(this,owner);
						["cpt5_data_deadizt",{_this + 1},0] call sp_storageUpdate;
						refset(_body getvariable "anim_handler",true);
						_body switchMove (pick ["Acts_StaticDeath_04","Acts_StaticDeath_05","Acts_StaticDeath_06","Acts_StaticDeath_10","Acts_StaticDeath_13"]);

						[getposatl _body,"chap5\sfx\scream" + (str randInt(1,3)),30] call sp_audio_playSound;

					};
				}; invokeAfterDelayParams(_nfHndl,0.1,[this]);
			};
		}] call sp_addWsimHandler;

		[cpt5_questName_rangedCombat,"Убейте истязателей"] call sp_setTaskMessageEff;

		{
			(["cpt5_data_deadizt",0] call sp_storageGet) >= 3
		} call sp_threadWait;

		["damage",_hdam] call sp_removeWsimHandler;

		[true] call sp_setHideTaskMessageCtg; 
		cpt5_warzone_danger = false; //зона безопасна
		cpt5_internal_warzoneGrenades = false; //гранаты не взрываются
		2 call sp_threadPause;

		[cpt5_questName_rangedCombat,"Продвигайтесь на вражескую позицию"] call sp_setTaskMessageEff;
		["war_peacefull",true] call sp_audio_playMusic;

	} call sp_threadStart;
}] call sp_addTriggerEnter;

cpt5_trg_dialog_onseegate = false;
["cpt5_trg_dialog_onseegate",{
	if (cpt5_trg_dialog_onseegate) exitWith {};
	cpt5_trg_dialog_onseegate = true;

	["cpt5_data_deadiztdefcount",0] call sp_storageSet;

	_hdam = ["damage",{
		objParams_1(_amount);
		//["act - " + str [this,_am,getVar(this,name)]] call chatPrint;
		if equals(this,call sp_getActor) exitWith {};
		if equals(getSelf(name),"Истязатель") then {
			sp_wsim_invokeNextAction = true;
			_nfHndl = {
				params ['this'];
				if ((({
					!callFuncParams(this,hasPart,_x)
				} count BP_INDEX_ALL) > 0) || getVar(this,isDead) || !callFunc(this,isActive)) then {
					_body = getVar(this,owner);
					refset(_body getvariable "anim_handler",true);
					_body switchMove (pick ["Acts_StaticDeath_04","Acts_StaticDeath_05","Acts_StaticDeath_06","Acts_StaticDeath_10","Acts_StaticDeath_13"]);
					[getposatl _body,"chap5\sfx\scream" + (str randInt(1,3)),30] call sp_audio_playSound;
					if ((["cpt5_data_deadiztdefcount",{_this + 1},0] call sp_storageUpdate) >= 2) then {
						[true,true] call sp_audio_setMusicPause;
			
						_post = {
							[] call sp_audio_stopMusic;
							[!true,true] call sp_audio_setMusicPause;
						};
						invokeAfterDelay(_post,5);
					};
				};
			}; invokeAfterDelayParams(_nfHndl,0.1,[this]);
		};
	}] call sp_addWsimHandler;

	//threads for last izt
	for "_i" from 1 to 2 do {
		_attackEvent = {
			params ["_obj"];
			_m = _obj getvariable "link";
			//attack
			[{
				params ["_m"];
				rand(0.3,0.8) call sp_threadPause;
				
				if (([_m] call cpt5_getVisMode)>=VISIBILITY_MODE_LOW) then {
					for "_i" from 1 to randInt(1,5) do {
						[_m,
							(player modelToWorld (player selectionPosition "head"))
							vectoradd [rand(-.3,.3),rand(-.3,.3),rand(-.1,.3)]
						] call cpt5_act_doShot;
						rand(1.2,1.4) call sp_threadPause;
					};
					rand(0.5,1.5) call sp_threadPause;
				} else {
					if prob(70) then {
						for "_i" from 1 to randInt(1,3) do {
							[_m,
								(player modelToWorld (player selectionPosition "head"))
								vectoradd [rand(-2.5,2.5),rand(-2.5,2.5),rand(-.1,2.3)]
							] call cpt5_act_doShot;
							rand(1.2,1.5) call sp_threadPause;
						};
					};
				};				
				
			},_m] call sp_threadStart;
		};

		_iztbody = "cpt5_izt1_cov"+(str _i) call sp_ai_getMobBody;
		_iztbody setvariable ["runawayanim","cpt5_iztsuppress"+(str _i)+"_run"];
		_iztbody setvariable ["anim_handler",
			["cpt5_izt1_cov"+(str _i),[
				["cpt5_pos_izt1_cov2_"+(str _i),"cpt5_iztlastdef_" + (str _i),rand(2,4),{},[
					["state_1",_attackEvent],
					["state_2",_attackEvent],
					["state_3",_attackEvent]
				]]
			]] call sp_ai_playAnimsLooped
		];
		[{
			params ["_i"];
			_iztref = "cpt5_izt1_cov"+(str _i);
			_iztpos = "cpt5_pos_izt1_cov2_"+(str _i);
			_iztbody = _iztref call sp_ai_getMobBody;
			_iztmob = _iztref call sp_ai_getMobObject;
			while {true} do {
				if (getVar(_iztmob,penaltySupressFire) > 1) exitWith {
					{
						["cpt5_data_izt_runaway_count",{_this + 1}] call sp_storageUpdate;
						//stop anim and play another
						_refizt = _iztbody getvariable "anim_handler";
						refset(_refizt,true);

						[_iztref,_iztpos,_iztbody getvariable "runawayanim"] call sp_ai_playAnim;
					} call sp_threadCriticalSection;
				};
				0.1 call sp_threadPause;
				

			};
		},_i] call sp_threadStart;
	};

	{
		//dialog can see gate
		([
			[player,"chap5\warzone\gg_seedoor",["endoffset",0.7]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		[cpt5_questName_preend,"Откройте автоматическую решётку"] call sp_setTaskMessageEff;
	} call sp_threadStart;
}] call sp_addTriggerEnter;

cpt5_trg_iztdefkilldanger_process = true;
["cpt5_trg_iztdefkilldanger",{
	if ((["cpt5_data_deadiztdefcount",0] call sp_storageGet) >= 2) exitWith {};
	call sp_callEventDiePlayer;
}] call sp_addTriggerEnter;

["cpt5_trg_closecombat_pre",{
	{
		[cpt5_questName_preend,"Возьмите меч, избавьтесь от преграды и зайдите в здание."] call sp_setTaskMessageEff;
		{
			callFuncParams(call sp_getActor,hasItem,"ShortSword");
		} call sp_threadWait;

		_h = ["Чтобы отодвинуть ящик схватите его. Вы можете сделать это через ПКМ меню, либо выбрав режим ""Схватить"" в правом меню и нажав $input_act_extraAction. Отодвиньте ящик, чтобы освободить проход"] call sp_setNotification; 

		{
			callFuncParams("cpt5_trgobj_boxposrequired" call sp_getObject,getDistanceTo,"cpt5_obj_boxwall" call sp_getObject arg true) <= 1
		} call sp_threadWait;

		[false,_h] call sp_setNotificationVisible;

	} call sp_threadStart;
}] call sp_addScene;

cpt5_act_closecombat_started = false;
["cpt5_trg_ccomb_activate",{
	if (cpt5_act_closecombat_started) exitWith {};
	cpt5_act_closecombat_started = true;
	
	["closecombat",true] call sp_audio_playMusic;
	sp_playerCanMove = false;

	["cpt5_izcombat","cpt5_pos_izcombat_spawn","cpt5_izt_ccmb_prepare",{
		["cpt5_act_ccomb_loop"] call sp_startScene;
	},[
		["state_1",{
			params ["_body"];
			_izt = "cpt5_izcombat" call sp_ai_getMobObject;
			callFunc(_izt,switchTwoHands);
			[_body] call anim_syncAnim;
			callFuncParams(_izt,setCombatMode,true);

			([
				["cpt5_izcombat","chap5\warzone\dikoubivat",["endoffset",0.7]]
			] call sp_audio_startDialog);
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

["cpt5_act_ccomb_loop",{
	[cpt5_questName_preend,"Убейте истязателя"] call sp_setTaskMessageEff;
	["damage",{
		objParams_1(_am);
		if equals(getVar(this,name),"Дико") exitWith {
			sp_wsim_invokeNextAction = true;
		};
	}] call sp_addWsimHandler;
	sp_playerCanMove = true;
	_refizt = ["cpt5_izcombat",[
		["cpt5_pos_izcombat1","cpt5_izt_ccomb_point1",rand(2,4),{}],
		["cpt5_pos_izcombat2","cpt5_izt_ccomb_point2",rand(2,4),{}]
	]
	] call sp_ai_playAnimsLooped;
	("cpt5_izcombat" call sp_ai_getMobBody) setvariable ["anim_handler",_refizt];
	_mob = "cpt5_izcombat" call sp_ai_getMobObject;
	setVar(_mob,curDefType,DEF_TYPE_PARRY);
	setVar(_mob,DX,vec2(30,0));
	
	_thdcombat = {
		_mob = "cpt5_izcombat" call sp_ai_getMobObject;
		while {true} do {

			if (callFuncParams(_mob,getDistanceTo,call sp_getActor arg true) <= 1.5) then {
				
				{callFuncParams(_mob,attackOtherMob,call sp_getActor)} call sp_threadCriticalSection;
				2 call sp_threadPause;
			} else {
				if prob_new(60) then {
					callFuncParams(_mob,playEmoteSound,"laugh");
					setVar(_mob,DX,vec2(9,0));
					2 call sp_threadPause;
					setVar(_mob,DX,vec2(10,0));
				} else {
					5 call sp_threadPause;
				};
			};
		};
	} call sp_threadStart;

	[{
		params ["_thdcombat"];
		{getVar("cpt5_izcombat" call sp_ai_getMobObject,isDead)} call sp_threadWait;
		
		_thdcombat call sp_threadStop;

		[] call sp_audio_stopMusic;

		_refizt = ("cpt5_izcombat" call sp_ai_getMobBody)getvariable "anim_handler";
		refset(_refizt,true);

		[cpt5_questName_preend,"Поверните рычаг"] call sp_setTaskMessageEff;
		["closecombat_after",true] call sp_audio_playMusic;
		
		{getVar("SteelGridDoorElectronic G:pubFKk0z1KE" call sp_getObject,isOpen)} call sp_threadWait;
		["cpt5_act_lastscene"] call sp_startScene;
	
	},[_thdcombat]] call sp_threadStart;

}] call sp_addScene;


["cpt5_act_lastscene",{
	cpt5_data_lastbattle = false;
	[cpt5_questName_preend,"Вернитесь к проходу"] call sp_setTaskMessageEff;

	["cpt5_kapitan","cpt5_pos_capitan5",0] call sp_ai_setMobPos;
	for "_i" from 1 to 5 do {
		_strI = str _i;
		["cpt5_pos_attacker" + _strI,"cpt5_attacker" + _strI,[
			["uniform","StreakCloth"],
			["name",["Боец"]]
		],{
			[pick["RifleFinisher","RifleAuto","PistolHandmade"],_this,INV_HAND_R] call createItemInInventory;
			//callFuncParams(_this,setCombatMode,true);
			callFunc(_this,switchTwoHands);
		}] call sp_ai_createPersonEx;
	};

	//izt spawn
	for "_i" from 1 to 4 do {
		_strI = str _i;
		_strI = str _i;
		["cpt5_pos_defender" + _strI,"cpt5_defender" + _strI,[
			["uniform","StreakCloth"],
			["name",["Истязатель"]],
			["face","asian"]
		],{
			[pick["RifleFinisher","RifleAuto","PistolHandmade"],_this,INV_HAND_R] call createItemInInventory;
			callFuncParams(_this,setCombatMode,true);
			callFunc(_this,switchTwoHands);
		}] call sp_ai_createPersonEx;
	};

	{
		{
			callFuncParams("cpt5_kapitan" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true)
			<= 4
		} call sp_threadWait;
		[true] call sp_setHideTaskMessageCtg;

		//dialog
		([
			["cpt5_kapitan","chap5\final\kap1",[["endoffset",0.7],["distance",40]]],

			["cpt5_attacker2","chap5\final\guy1",["endoffset",1.4]],
			["cpt5_attacker4","chap5\final\guy3",["endoffset",1.5]],
			["cpt5_attacker5","chap5\final\guy4",["endoffset",1.5]],
			[player,"chap5\final\gg1",["endoffset",0.1]],
			["cpt5_attacker3","chap5\final\guy2",["endoffset",2.1]],


			["cpt5_kapitan","chap5\final\kap2",[["endoffset",0],["distance",40]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
		//1 call sp_threadPause;

		["cpt5_kapitan","cpt5_pos_capitan5","cpt5_capitan_attack",{
			params ["_mob"];
			
		},[
			["state_1",{
				[{cpt5_data_lastbattle}] call sp_ai_animWait;
			}],
			["state_2",{
				params ["_body"];
				callFuncParams(_body getvariable "link",setCombatMode,true);
			}]
		]] call sp_ai_playAnim;

		for "_i" from 1 to 5 do {
			//if (_i!=5) then{continue};
			_strI = str _i;
			_pars = ["cpt5_attacker" + _strI,"cpt5_pos_attacker" + _strI,"cpt5_attacker" + _strI,{
				params ["_mob"];
				
			},[
				["state_1",{
					params ["_body"];
					callFuncParams(_body getvariable "link",setCombatMode,true);
				}],
				["state_2",{
					[{cpt5_data_lastbattle}] call sp_ai_animWait;
				}]
			]];
			invokeAfterDelayParams(sp_ai_playAnim,0.2 + (_i/2),_pars);
		};
		


	} call sp_threadStart;
}] call sp_addScene;

cpt5_data_lastbattle = false;
["cpt5_trg_lastbattle",{
	if (cpt5_data_lastbattle) exitWith {};
	cpt5_data_lastbattle = true;

	_post = {
		[] call sp_audio_stopMusic;
		[!true,true] call sp_audio_setMusicPause;
	};
	invokeAfterDelay(_post,5);

	//play anim and actions

	for "_i" from 1 to 4 do {
		_strI = str _i;
		["cpt5_defender" + _strI,"cpt5_pos_defender" + _strI,"cpt5_defender" + _strI,{
			params ["_mob"];
			
		},[
			
		]] call sp_ai_playAnim;
	};

	([
		["cpt5_defender1","chap5\final\izt1",[["endoffset",1.5],["distance",50]]],
		["cpt5_defender2","chap5\final\izt2",[["endoffset",1.5],["distance",50]]],
		["cpt5_defender3","chap5\final\izt3",[["endoffset",1.2],["distance",50]]]
	] call sp_audio_startDialog);

	{
		_izt = [];
		for "_i" from 1 to 4 do {_izt pushBack ("cpt5_defender"+(str _i))};
		_attackers = ["cpt5_kapitan"];
		for "_i" from 1 to 5 do {
			_attackers pushBack ("cpt5_attacker" + (str _i));
		};
		_mobAtt = _attackers apply {_x call sp_ai_getMobBody};
		_mobIzt = _izt apply {_x call sp_ai_getMobBody};

		{
			[{
				params ["_curM","_enemyList","_ind"];
				(rand(1,1.2)+(_ind/2)) call sp_threadPause;
				for "_i" from 1 to randInt(5,10) do {
					_pos = (pick _enemyList) modelToWorld [rand(-1,1),rand(-1,1),rand(-0.2,2)];
					[_curM,_pos] call cpt5_act_doShot;
					rand(0.8,2.5) call sp_threadPause;
				};
			},[_x getvariable "link",_mobIzt,_forEachIndex]] call sp_threadStart;
		} foreach _mobAtt;

		{
			[{
				params ["_curM","_enemyList","_ind"];
				(rand(1,1.2)+(_ind/2)) call sp_threadPause;
				for "_i" from 1 to randInt(5,10) do {
					_pos = (pick _enemyList) modelToWorld [rand(-1,1),rand(-1,1),rand(-0.2,2)];
					[_curM,_pos] call cpt5_act_doShot;
					rand(0.8,2.5) call sp_threadPause;
				};
			},[_x getvariable "link",_mobAtt+[player],_forEachIndex]] call sp_threadStart;
		} foreach _mobIzt;

		5 call sp_threadPause;
		[""] call sp_view_setPlayerHudVisible;
		[true,0.2] call setBlackScreenGUI;
		
		_ender = {
			call sp_cleanupSceneData;

			["cpt5_endtitle"] call sp_startScene;
		};
		invokeAfterDelay(_ender,2);
	} call sp_threadStart;
}] call sp_addTriggerEnter;


cpt5_func_createRef = {
	params ["_txt",["_color","#ffffff"]];
	format["<t colorLink='%2'><a href='%1'>",_txt,_color];
};

cpt5_endtitle_text = "Дату следующего запуска вы можете узнать в дискорде " + (["https://discord.relicta.ru"] call cpt5_func_createRef);



["cpt5_endtitle",{
	_addr = "https://auth.relicta.ru:9700/api/server_info";
	[_addr,{
		params ["_t"];
		_obj = FromJSON _t;
		if (_obj getOrDefault ["server_is_online",false]) then {
			cpt5_endtitle_text = "Сервер онлайн. Заходите!";
		} else {
			_nl = _obj getOrDefault ["next_launch",""];
			if (_nl != "") then {
				(_nl splitstring "-T:.") params ["_year","_m","_d"];
				cpt5_endtitle_text = format["Следующий запуск %1.%2.%3. Приходите на игру!",_d,_m,_year];
			};
		};
	},[]] call curl_addRequest;
	{
		_d = call displayOpen;
		_sX = 70;
		_sY = 5;
		_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
		_logoSize = 60;
		_curY = 50-_logoSize/2;
		_logo = [_d,PICTURE,[50-_sX/2,_curY,_sx,_logoSize],_ctg] call createWidget;
		[_logo,"rel_ui\Assets\log.paa"] call widgetSetPicture;

		modvar(_curY) + _logoSize*1.5;

		_itlist = [
			"Над обучением работали:",
			"",
			"Yodes - код, карта",
			"Devil - озвучка",
			"Rumyn - озвучка",
			"Astra - озвучка",
			"Mnenekogda - звуки",
			"",
			"Тестеры:",
			"Sranych - тестирование",
			"Lampyridae - тестирование",
			""
		];

		{
			modvar(_curY) + (_sY);
			_w = [
				_d,TEXT,[50-_sX/2,_curY,_sX,_sY],_ctg
			] call createWidget;
			[_w,format["<t align='center' size='1.5'>%1</t>",_x]] call widgetSetText;
		} foreach _itlist;
		
		2 call sp_threadPause;

		private _maxY = _curY + _sY;
		[_ctg,[0,0,100,_maxY]] call widgetSetPosition;

		[{
			params ["_ctg","_maxY"];
			_tdur = 30;
			[_ctg,[0,-_maxY],_tdur] call widgetSetPositionOnly;
			_tdur call sp_threadPause;

			{
				_b = [getDisplay,TEXT,[50-70/2,50-30/2,70,30]] call createWidget;
				[_b,format[
					"<t align='center' size='1.8'>%1</t>",
					cpt5_endtitle_text,
					sbr
				]] call widgetSetText;
				widgetSetFade(_b,1,0);
				widgetSetFade(_b,0,5);

				_b = [getDisplay,TEXT,[50-70/2,70-25/2,70,25]] call createWidget;
				[_b,"<t align='center' size='1.9'>Нажмите для выхода</t>"] call widgetSetText;
				widgetSetFade(_b,1,0);
				widgetSetFade(_b,0,5);

				_b ctrlAddEventHandler ["MouseButtonUp",{
					nextFrame(displayClose);
					_post = {
						endMission "END1";
					}; invokeAfterDelay(_post,2);
				}];

			} call sp_threadCriticalSection;

			5 call sp_threadPause;
			//nextFrame(displayClose);
		},[_ctg,_maxY]] call sp_threadStart;
	} call sp_threadStart;

}] call sp_addScene;