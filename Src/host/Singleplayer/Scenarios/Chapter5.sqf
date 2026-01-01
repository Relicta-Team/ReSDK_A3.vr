// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

cpt5_debug_skipStart = false;

cpt5_questName_startCombat = "Война";
cpt5_questName_rangedCombat = "Лучшая защита - нападение";
cpt5_questName_preend = "Последний рывок";

cpt5_playerUniform = "StreakCloth";

cpt5_data_rifleSkill = 5;

["cpt5_begin",{
	if (!sp_debug) then {cpt5_debug_skipStart = false};
	["cpt5_pos_start",0] call sp_setPlayerPos;

	if isNullReference(callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH)) then {
		private _cloth = [cpt5_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;
	};

	call sp_initializeDefaultPlayerHandlers;
	[call sp_getActor] call sp_loadCharacterData;
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
		_texData = [0,"#(rgb,512,512,3)text(1,1,""Caveat"",0.28,""#00000000"",""#2b1b0ddf"",""ОРУЖЕЙНАЯ "")"];
		_ref = getVar("cpt5_obj_signinfoboard" call sp_getObject,pointer);
		_objReal = objNull;
		while {isNullReference(_objReal)} do {
			_obj = noe_client_allPointers getOrDefault [_ref,objNull];
			if isNullReference(_obj) then {
				1 call sp_threadPause;
				continue;
			};
			_objReal = "signad_sponsors_f" createVehicleLocal [0,0,0];
			_objReal setposatl getposatl _obj;
			_objReal setVectorDirAndUp [vectorDir _obj,vectorUp _obj];
			_objReal setObjectTexture _texData;
			break;
		};

		{
			[_ref] call deleteGameObject;
		} call sp_threadCriticalSection;
	} call sp_threadStart;

	[{
        params ["_t","_wid"];
        _t == "wrld_toGhost"
    },{
		params ["_t","_wid"];
		//array_exists(COMBAT_STYLE_LIST_ALL,_t)
		true //всё в комбат меню разрешено
	},{
		params ["_t","_wid"];
        if array_exists(interactMenu_selectionWidgets,_wid) exitWith {true};
		if ("Сон" == _t) exitWith {true};
		if ("Бросок" == _t && (["cpt5_data_canUseThrowAction",false] call sp_storageGet)) exitWith {true};
		if ("Схватить" == _t && (["cpt5_data_canUseGrabAction",false] call sp_storageGet)) exitWith {true};
		false
	}] call sp_gui_setInventoryVisibleHandler;

	["activate_verb",{
		params ["_t","_name"];
		private _ret = false;
		if (_name == "pull") then {
			if !(["cpt5_data_canUseGrabAction",false] call sp_storageGet) then {
				_ret = true;
			};
		};
		_ret
	}] call sp_addPlayerHandler;

	sp_allowebVerbs append ["pull"];

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
	
	//save rifle skill
	cpt5_data_rifleSkill = getVar(call sp_getActor,rifle);
	//update rifle skill
	setVar(call sp_getActor,rifle,17);

	//open closecombat door
	callFuncParams("cpt5_obj_doorclosecombat" call sp_getObject,setDoorOpen,true);

	//cant take items
	_post = {
		{
			if isTypeOf(_x,IRangedWeapon) then {continue};
			if isTypeOf(_x,IMagazineBase) then {continue};
			if isTypeOf(_x,AmmoBoxBase) then {continue};
			if isTypeOf(_x,IPaperItemBase) then {continue};
			
			sp_blacklistClickItems pushBack _x;
		} foreach (callFuncParams(call sp_getActor,getNearItems,300) - [
			"cpt5_obj_oldshortswordclosecombat" call sp_getObject
		]);
	}; invokeAfterDelay(_post,1);

	setVar("cpt5_obj_woundedmanleg" call sp_getObject,side,-1);

	//no attack my firends
	//todo

	
	//making mobs
	_beder = [];
	for "_i" from 1 to 2 do {
		_beder pushback ("cpt5_bedwall_" + (str _i));
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
		_beder pushback ("cpt5_bednear_" + (str _iReal));
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

	[{
		params ["_beder"];
		while {true} do {
			_m = (pick _beder) call sp_ai_getMobObject;
			callFuncParams(_m,playSound,"singleplayer\sp_guide\chap5\sfx\sleeper" + (str randInt(1,3)) arg rand(0.8,1.3) arg 15);
			rand(1.5,7) call sp_threadPause;
		};
	},[_beder]] call sp_threadStart;

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
		_this addHeadgear "H_HeadBandage_stained_F";
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
					if isNullVar(_obj) exitWith {};
					if isNullReference(_obj) exitWith {};

					_obj switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_5_loop";
					[getposatl _obj,"chap5\sfx\ammo" + (str randInt(1,2))] call sp_audio_playSound;
				}],
				["cpt5_pos_weaponloader2","cpt5_weaponloader2",{rand(10,15)},{ 
					params ["_obj"]; 
					if isNullVar(_obj) exitWith {};
					if isNullReference(_obj) exitWith {};
					
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
		["ArmorLite",_this,INV_ARMOR] call createItemInInventory;
		["RifleSVT",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;

	["cpt5_pos_defstrelok","cpt5_defstrelok",[
		["uniform","StreakCloth"],
		["name",["Боец"]],
		["head","HatBandana4"],
		["age",37]
	],{
		["RifleSVT",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
		callFuncParams(_this,setCombatMode,true);
	},{
		_this switchMove "amovpknlmstpsraswpstdnon";
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
		_mob addHeadgear "H_HeadBandage_stained_F";
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
			["name",["Боец"]],
			["head",pick["HatBandana4","HatBandana5","HatBandana6","HatBandana7","CombatHelmet",""]]
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
		["uniform","BlackLightweightArmyCloth2"],
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
			["uniform",["TorturerCloth1","TorturerCloth2"] select (_i-1)],
			["name",["Истязатель"]],
			["face","asian"]
		],{
			["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
			callFuncParams(_this,setCombatMode,true);
			callFunc(_this,switchTwoHands);
		}] call sp_ai_createPersonEx;
	};

	["cpt5_pos_izt2","cpt5_izt2",[
		["uniform","BlackLightweightArmyCloth2"],
		["name",["Истязатель"]],
		["face","asian"]
	],{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFuncParams(_this,setCombatMode,true);
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	["cpt5_pos_izt3","cpt5_izt3",[
		["uniform","LeatherCoatWithoutSleeves"],
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
						if isNullVar(_obj) exitWith {};
						if isNullReference(_obj) exitWith {};

						_m = _obj getvariable ["link",nullPtr];
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
		["uniform","KnightCaveArmor2"],
		["name",["Дико","Убивать"]],
		["face","face60"]
	],{
		["ShortSword",_this,INV_HAND_R] call createItemInInventory;
	}] call sp_ai_createPersonEx;


	{
		["chat+right+stats+up+cursor+inv+stam"] call sp_view_setPlayerHudVisible;
		["press_specact",false] call sp_setLockPlayerHandler;
		_unsleepHandle = ["press_specact",{
			params ["_id"];
			_id != SPECIAL_ACTION_SLEEP
		}] call sp_addPlayerHandler;

		_thandle = {
			10 call sp_threadPause;
			["Чтобы #(проснуться) нажмите $input_act_inventory и справа выберите #(""Сон"")."] call sp_setNotification;
		} call sp_threadStart;

		{
			!callFunc(call sp_getActor,isSleep)
		} call sp_threadWait;
		_thandle call sp_threadStop;
		_unsleepHandle call sp_removePlayerHandler;

		_thandle = {
			15 call sp_threadPause;
			["Чтобы #(встать) с кровати нажмите $input_act_resist"] call sp_setNotification;
		} call sp_threadStart;

		{
			!callFunc(call sp_getActor,isConnected)
		} call sp_threadWait;
		_thandle call sp_threadStop;
		[false] call sp_setNotificationVisible;
		
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
				["cpt5_weaponloader","chap5\underground\guy3",["distance",20]]
			] call sp_audio_startDialog);
		} call sp_threadStart;

	} call sp_threadStart;
}] call sp_addScene;

cpt5_trg_underguystalk_act = false;
["cpt5_trg_underguystalk",{
	if (cpt5_trg_underguystalk_act) exitWith {};
	cpt5_trg_underguystalk_act = true;

	{

		(5.5+rand(0.3,0.6)) call sp_threadPause;
		([
			["cpt5_bedwall_1","chap5\underground\guy2"]
		] call sp_audio_startDialog);
	} call sp_threadStart;
	{
		rand(0.01,0.2) call sp_threadPause;
		([
			["cpt5_bedwall_2","chap5\underground\guy4"]
		] call sp_audio_startDialog);
	} call sp_threadStart;
}] call sp_addTriggerEnter;

//общение лекарей
cpt5_act_lekartalks = false;
["cpt5_trg_lekarstalks",{
	if (!cpt5_act_lekartalks) then {
		cpt5_act_lekartalks = true;

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

		{
			3 call sp_threadPause;
			{
				while {true} do {
					{
						callFuncParams("cpt5_underground_mover" call sp_ai_getMobObject,getDistanceTo,"cpt5_obj_clothwallunder" call sp_getObject arg true) 
						<= 2.3
						&& !getVar("cpt5_obj_clothwallunder" call sp_getObject,isOpen)
					} call sp_threadWait;
					callFuncParams("cpt5_underground_mover" call sp_ai_getMobObject,meSay,"резко открывает дверь");
					
					{
						callFuncParams("cpt5_obj_clothwallunder" call sp_ai_getMobObject,playSound,"doors\kick_break2" arg getRandomPitchInRange(0.6,1.3));

						//todo remove invwall
						//["cpt5_obj_clothwallunder_invwall" call sp_getObject] call deleteGameObject;
						_door = "cpt5_obj_clothwallunder" call sp_getObject;
						callFuncParams(_door,setDoorLock,false arg false);
						callFuncParams(_door,setDoorOpen,true);
					} call sp_threadCriticalSection;
					
					3 call sp_threadPause;
				};
			} call sp_threadStart;

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
		} call sp_threadStart;

		//dialog kapitan
		([
			["cpt5_kapitan","chap5\underground\under_kap1",[["endoffset",0.1],["distance",50]]],
			[player,"chap5\underground\under_gg1",[["endoffset",0.1],["distance",50]]],
			["cpt5_kapitan","chap5\underground\under_kap2",[["endoffset",0.1],["distance",50]]]
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
		["Откройте #(коробку с патронами). Для этого нажмите $input_act_mainAction по ней. Чтобы вытащить патрон нажмите ЛКМ. Патроны вытаскиваются по 1 штуке за раз."] call sp_setNotification;

		{
			callFuncParams(call sp_getActor,hasItem,"AmmoRifle" arg true)
		} call sp_threadWait;

		["Чтобы зарядить патрон в магазин нажмите ЛКМ с патроном в руке по магазину. Зарядите #(несколько полных магазинов)."] call sp_setNotification;

		{
			_mags = ["cpt5_data_wtable_mags",[]] call sp_storageGet;
			({callFunc(_x,getAmmoCount) == getVar(_x,maxCount)}count _mags) >= 2
		} call sp_threadWait;

		["Чтобы #(вставить магазин) в винтовку нажмите ЛКМ с магазином в руке по винтовке."] call sp_setNotification;

		{
			_rifles = ["cpt5_data_wtable_rifles",[]] call sp_storageGet;
			({callFunc(_x,hasMagazine)}count _rifles) >= 1
		} call sp_threadWait;

		["two_hands",false] call sp_setLockPlayerHandler;
		[cpt5_questName_startCombat,"Поднимайтесь наверх"] call sp_setTaskMessageEff;

		if (!callFuncParams(call sp_getActor,isHoldedTwoHands,callFunc(call sp_getActor,getItemInActiveHandRedirect))) then {
			["Нажмите $input_act_switchTwoHands чтобы схватить винтовку #(двумя руками)."] call sp_setNotification;
		};
		{
			callFuncParams(call sp_getActor,isHoldedTwoHands,callFunc(call sp_getActor,getItemInActiveHandRedirect))
		} call sp_threadWait;

		[false] call sp_setNotificationVisible;


	} call sp_threadStart;
}] call sp_addScene;

cpt5_act_doShot = {
	params ["_mob","_targetPos"];
	if canSuspend exitWith {
		private _args = _this;
		{_args call cpt5_act_doShot} call sp_threadCriticalSection;
	};
	if isNullVar(_mob) exitWith {};
	if isNullReference(_mob) exitWith {};
	
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
	if isNullVar(_src) exitWith {VISIBILITY_MODE_NONE};
	if isNullReference(_src) exitWith {VISIBILITY_MODE_NONE};

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

//таймер первой перестрелки
cpt5_data_first_shootingTimeCanReset = 0;
cpt5_trg_combat_stage1_act = false;
//приказ подавления
["cpt5_trg_combat_stage1",{
	if (cpt5_trg_combat_stage1_act) exitWith {};
	cpt5_trg_combat_stage1_act = true;

	["combat",false] call sp_setLockPlayerHandler;

	["cpt5_data_izt_runaway_count",0] call sp_storageSet;
	["cpt5_data_shootCount",0] call sp_storageSet;
	cpt5_data_first_shootingTimeCanReset = tickTime + (60 * 1 + 30); //полторы минуты на первый бой
	["click_target",{
		params ["_t"];
		_it = callFunc(call sp_getActor,getItemInActiveHandRedirect);
		if !isNullReference(_it) then {
			if (
				isTypeOf(_it,RifleSVT)
				&& {getVar(call sp_getActor,isCombatModeEnable)}
				&& {callFunc(_it,isCocked)}
			) then {

				["cpt5_data_shootCount",{_this + 1}] call sp_storageUpdate;
			};
		};
		
		false
	}] call sp_addPlayerHandler;

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
			_iztbody setvariable ["secondMobPos","cpt5_pos_izt1_cov2_" + (str _i)];
			_iztmob = _iztref call sp_ai_getMobObject;
			_canUpdate = true;
			while {_canUpdate} do {
				{
					if (
						((getVar(_iztmob,penaltySupressFire) > 0)
						|| (["cpt5_data_shootCount",0] call sp_storageGet) >= 15)
					) exitWith {
						_canUpdate = false;
						setVar(_iztmob,penaltySupressFire,0);

						_post = {
							params ["_iztref","_iztpos","_iztbody"];

							["cpt5_data_izt_runaway_count",{_this + 1}] call sp_storageUpdate;

							//stop anim and play another
							_refizt = _iztbody getvariable "anim_handler";
							refset(_refizt,true);

							[_iztref,_iztpos,_iztbody getvariable "runawayanim",{
								params ["_body"];
								[_body,_body getvariable "secondMobPos",0] call sp_ai_setMobPos;
								_body hideObject true;
							}] call sp_ai_playAnim;
						};
						_args = [_iztref,_iztpos,_iztbody];

						_leftTime = (cpt5_data_first_shootingTimeCanReset - tickTime) max 0;
						invokeAfterDelayParams(_post,_leftTime,_args);

						break;
					};
				} call sp_threadCriticalSection;
				0.1 call sp_threadPause;
				

			};
		},_i] call sp_threadStart;
	};

	{
		//dialog
		([
			["cpt5_kapitan","chap5\underground\kap_podavl",[["endoffset",0.1],["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;


		[cpt5_questName_rangedCombat,"Подавите позиции врага"] call sp_setTaskMessageEff;
		
		["Возьмите #(винтовку) в руки."] call sp_setNotification;

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

		["Чтобы #(передёрнуть затвор) винтовки нажмите ЛКМ по ней. Винтовка при этом должна находится в активной руке."] call sp_setNotification;

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
		
		
		_threadGuide = {
			_h = ["#(Стрельба на подавление) снижает точность противника. Не обязательно попадать по нему, достаточно выстрелить в его сторону."
			+" Для стрельбы на подавление выбреите режим #(""Подавление"") в боевом меню и начинайте стрельбу по #(истязателям)"] call sp_setNotification;
			_it = callFunc(call sp_getActor,getItemInActiveHandRedirect);
			{!isNullReference(_it) && isTypeOf(_it,RifleSVT)} call sp_threadWait;
			
			{
				!isNullReference(getVar(_it,magazine)) 
				&& {(count(getVar(getVar(_it,magazine),content))) == 0}
				&& {!callFunc(_it,isCocked)}
			} call sp_threadWait;
			_h = ["Чтобы #(вытащить магазин), кликните ЛКМ по винтовке в руке второй пустой рукой. Вставьте заряженный магазин и #(продолжайте стрелять)"] call sp_setNotification;
			{
				!isNullReference(getVar(_it,magazine)) 
				&& {(count(getVar(getVar(_it,magazine),content))) > 0}
				&& {callFunc(_it,isCocked)}
			} call sp_threadWait;
			[false,_h] call sp_setNotificationVisible;
		} call sp_threadStart;
		//
		{
			(["cpt5_data_izt_runaway_count",0] call sp_storageGet) >= 2
		} call sp_threadWait;
		_threadGuide call sp_threadStop;

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
		nextFrameParams({_this call sp_audio_setMusicVolume},[0 arg 0]);
		_post = {
			[1,0.3] call sp_audio_setMusicVolume;
		}; invokeAfterDelay(_post,2.32);
		1.3 call sp_threadPause;
		{
			[callFunc("cpt5_trgobj_event_grenade2" call sp_getObject,getPos)] call cpt5_explosionGrenade;
		} call sp_threadCriticalSection;
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

	[cpt5_questName_rangedCombat,"Вернитесь к капитану"] call sp_setTaskMessageEff;

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
			[
				"cpt5_kapitan"
				//!throws error callFunc("cpt5_pos_capitan3" call sp_getObject,getPos) vectorAdd [0,0,2]
			,"chap5\warzone\kap1",[["endoffset",0.8],["distance",100]]],
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

		[cpt5_questName_rangedCombat,"Дотащите раненого до ваших позиций"] call sp_setTaskMessageEff;
		_h = ["Чтобы #(тащить) человека выберите режим #(""Схватить"") в правом меню и нажмите $input_act_extraAction по раненому человеку."] call sp_setNotification;
		["cpt5_data_canUseGrabAction",true] call sp_storageSet;
		["extra_action",false] call sp_setLockPlayerHandler;

		_mob = "cpt5_woundedman" call sp_ai_getMobObject;
		{callFunc(_mob,isGrabbed)} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;


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
		{
			_mob = "cpt5_woundedman" call sp_ai_getMobObject;
			_h = ["Чтобы #(отпустить) раненого нажмите $input_act_dropitem"] call sp_setNotification;
			{!callFunc(_mob,isGrabbed)} call sp_threadWait;
			{
				["cpt5_woundedman",null,false] call sp_ai_commitMobPos;
				//["cpt5_data_canUseGrabAction",false] call sp_storageSet;
			} call sp_threadCriticalSection;
			[false,_h] call sp_setNotificationVisible;
		} call sp_threadStart;

		["cpt5_data_destroywallonstage2",false] call sp_storageSet;
		{
			//1.5 call sp_threadPause;
			{
				["cpt5_data_destroywallonstage2",false] call sp_storageGet;
			} call sp_threadWait;

			_pos = callFunc("cpt5_trgobj_event_grenade_stage2" call sp_getObject,getPos);
			for "_i" from 1 to 4 do {
				{
					[_pos vectorAdd [rand(-2,2),rand(-2,2),rand(0,2)]] call cpt5_explosionGrenade;
				} call sp_threadCriticalSection;
				rand(0.5,1.7) call sp_threadPause;
			};
			{
				for "_i" from 1 to 2 do {
					[("cpt5_obj_wireonstage2_"+(str _i)) call sp_getObject] call deleteGameObject;
				};
			} call sp_threadCriticalSection;
		} call sp_threadStart;

		//dialog
		{
			([
				["cpt5_kapitan","chap5\warzone\kap3",["endoffset",0.1]],
				["cpt5_kapitan","chap5\warzone\kap4",["endoffset",0.1]],
				[player,"chap5\warzone\gg3",["endoffset",0.7]],
				["cpt5_kapitan","chap5\warzone\kap5",[
					["endoffset",1]
				]],
				[player,"chap5\warzone\gg4",["endoffset",1.4]],
				["cpt5_kapitan","chap5\warzone\kap6",[
					["endoffset",0.1],
					["onstart",{
						["cpt5_data_destroywallonstage2",true] call sp_storageSet;
					}]
				]]
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
						callFuncParams(this,Die,null);
						_body = getVar(this,owner);
						if (_body getvariable ["__die_action",false]) exitWith {};
						_body setvariable ["__die_action",true];
						["cpt5_data_deadizt",{_this + 1},0] call sp_storageUpdate;
						refset(_body getvariable "anim_handler",true);
						_body switchMove (pick ["Acts_StaticDeath_04","Acts_StaticDeath_05","Acts_StaticDeath_06","Acts_StaticDeath_10","Acts_StaticDeath_13"]);

						[getposatl _body,"chap5\sfx\scream" + (str randInt(1,3)),30] call sp_audio_playSound;

					};
				}; invokeAfterDelayParams(_nfHndl,0.1,[this]);
			};
		}] call sp_addWsimHandler;

		[cpt5_questName_rangedCombat,"Убейте трёх истязателей"] call sp_setTaskMessageEff;

		{
			(["cpt5_data_deadizt",0] call sp_storageGet) >= 3
		} call sp_threadWait;

		["damage",_hdam] call sp_removeWsimHandler;

		[true] call sp_setHideTaskMessageCtg; 
		cpt5_warzone_danger = false; //зона безопасна
		cpt5_internal_warzoneGrenades = false; //гранаты не взрываются
		2 call sp_threadPause;

		[cpt5_questName_rangedCombat,"Продвигайтесь на вражескую позицию"] call sp_setTaskMessageEff;
		//reset strelok attack handler
		{
			refset(("cpt5_defstrelok" call sp_ai_getMobBody) getvariable "anim_handler",true);
			("cpt5_defstrelok" call sp_ai_getMobBody) switchMove "amovpknlmstpsraswpstdnon";
		} call sp_threadCriticalSection;
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
					if (_body getvariable ["__die_action",false]) exitWith {};
					_body setvariable ["__die_action",true];

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
					if ((["cpt5_data_deadiztdefcount",0] call sp_storageGet) == 1
					&& {
						// только если ближний был убит можем сместить позицию опасности
						equals(this,"cpt5_izt1_cov2" call sp_ai_getMobObject)
					}) then {

						_oldPos = callFunc("cpt5_trgobj_iztdefkilldanger" call sp_getObject,getPos);
						MODARR(_oldPos,1, + 5);
						callFuncParams("cpt5_trgobj_iztdefkilldanger" call sp_getObject,setPos__,_oldPos);
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
					for "_i" from 1 to randInt(1,3) do {
						[_m,
							(player modelToWorld (player selectionPosition "head"))
							vectoradd [rand(-.1,.1),rand(-.1,.1),rand(-.1,.3)]
						] call cpt5_act_doShot;
						rand(1.2,1.4) call sp_threadPause;
					};
					rand(0.5,1.5) call sp_threadPause;
				} else {
					if prob_new(70) then {
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
		_iztbody hideobject false;
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

		//если они по какой то причине потеряли оружие - выдаем новое
		_iztmob = "cpt5_izt1_cov"+(str _i) call sp_ai_getMobObject;
		if (!callFuncParams(_iztmob,hasItem,"RifleFinisher")) then {
			["RifleFinisher",_iztmob,INV_HAND_R] call createItemInInventory;
			callFuncParams(_iztmob,switchTwoHands);
			callFuncParams(_iztmob,setCombatMode,true);
			[_iztbody] call anim_syncAnim;
		};

		//прикрывающий поможет игроку
		["cpt5_defstrelok","cpt5_pos_defstrelok_cover",0] call sp_ai_setMobPos;
		("cpt5_defstrelok" call sp_ai_getMobBody) switchMove "amovpercmstpsraswpstdnon";
		
		{
			2 call sp_threadPause;
			while {(["cpt5_data_deadiztdefcount",0] call sp_storageGet) < 2} do {
				rand(1.5,5.8) call sp_threadPause;
				_targetList = [];
				{
					for "_i" from 1 to 2 do {
						private _ctargName = "cpt5_izt1_cov"+(str _i);
						private _ctarg = _ctargName call sp_ai_getMobObject;
						if (!getVar(_ctarg,isDead)) then {
							_targetList pushBack _ctargName;
						};
					};
				} call sp_threadCriticalSection;
				
				if (count _targetList == 0) exitWith {};

				_targetref = (pick _targetList);
				_tm = _targetref call sp_ai_getMobBody;
				for "_i" from 1 to randInt(1,3) do {
					["cpt5_defstrelok" call sp_ai_getMobObject,
						(_tm modelToWorld (_tm selectionPosition "head"))
						vectoradd [rand(-2.5,2.5),rand(-2.5,2.5),rand(-.1,2.3)]
					] call cpt5_act_doShot;
					rand(1.2,1.5) call sp_threadPause;
				};
			};
			{
				("cpt5_defstrelok" call sp_ai_getMobBody) switchMove "amovpercmstpsnonwnondnon";
			} call sp_threadCriticalSection;

		} call sp_threadStart;

		//! не уверен что это актуально
		// [{
		// 	params ["_i"];
		// 	_iztref = "cpt5_izt1_cov"+(str _i);
		// 	_iztpos = "cpt5_pos_izt1_cov2_"+(str _i);
		// 	_iztbody = _iztref call sp_ai_getMobBody;
		// 	_iztmob = _iztref call sp_ai_getMobObject;
		// 	while {true} do {
		// 		if (getVar(_iztmob,penaltySupressFire) > 1) exitWith {
		// 			{
		// 				["cpt5_data_izt_runaway_count",{_this + 1}] call sp_storageUpdate;
		// 				//stop anim and play another
		// 				_refizt = _iztbody getvariable "anim_handler";
		// 				refset(_refizt,true);

		// 				[_iztref,_iztpos,_iztbody getvariable "runawayanim"] call sp_ai_playAnim;
		// 				break;
		// 			} call sp_threadCriticalSection;
		// 		};
		// 		0.1 call sp_threadPause;
				

		// 	};
		// },_i] call sp_threadStart;
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
		["extra_action",{
			params ["_targ"];
			_ret = false;
			if (cd_specialAction == SPECIAL_ACTION_GRAB) then {
				if (not_equals(_targ,"cpt5_obj_boxwall" call sp_getObject)) then {
					_ret = true;
				};
			};
			_ret
		}] call sp_addPlayerHandler;
		[cpt5_questName_preend,"Возьмите меч, избавьтесь от преграды и зайдите в здание."] call sp_setTaskMessageEff;
		{
			callFuncParams(call sp_getActor,hasItem,"ShortSword");
		} call sp_threadWait;

		_h = ["Чтобы отодвинуть ящик - схватите его. Вы можете сделать это через ПКМ меню, либо выбрав режим #(""Схватить"") в правом меню и нажав $input_act_extraAction. #(Отодвиньте ящик), чтобы освободить проход"] call sp_setNotification; 
		_oldPos = callFunc("cpt5_obj_boxwall" call sp_getObject,getPos);
		{
			callFuncParams("cpt5_trgobj_boxposrequired" call sp_getObject,getDistanceTo,"cpt5_obj_boxwall" call sp_getObject arg true) <= 1
			||
			(callFunc("cpt5_obj_boxwall" call sp_getObject,getPos) distance2d _oldPos) > 1
		} call sp_threadWait;

		[false,_h] call sp_setNotificationVisible;

	} call sp_threadStart;
}] call sp_addScene;

cpt5_trg_closecombat_enterhouse_act = false;
["cpt5_trg_closecombat_enterhouse",{
	if (cpt5_trg_closecombat_enterhouse_act) exitWith {};
	cpt5_trg_closecombat_enterhouse_act = true;

	[false] call sp_setNotificationVisible;
	call cpt5_internal_fnc_prepCloseCombatLogic;
}] call sp_addTriggerEnter;

cpt5_act_closecombat_started = false;
["cpt5_trg_ccomb_activate",{
	if (cpt5_act_closecombat_started) exitWith {};
	cpt5_act_closecombat_started = true;

	callFuncParams("cpt5_obj_doorclosecombat" call sp_getObject,setDoorOpen,false);
	
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

cpt5_data_closecombat_izt_dx = 30;

#ifdef DEBUG
cpt5_debug_internal_fnc_testCloseCombat = {
	

	["combat",false] call sp_setLockPlayerHandler;
	["two_hands",false] call sp_setLockPlayerHandler;
	if (!callFuncParams(call sp_getActor,hasItem,"ShortSword")) then {
		["ShortSword",call sp_getActor,INV_HAND_R] call createItemInInventory;
	};
	player setposatl (callFunc("cpt5_obj_doorclosecombat" call sp_getObject,getPos) vectorAdd [0,0,0.8]);
	
	call cpt5_internal_fnc_prepCloseCombatLogic;
};
#endif

cpt5_internal_data_list_cacheRestoreInject = [];
cpt5_internal_data_closecombat_shoothandler = null;
cpt5_internal_fnc_prepCloseCombatLogic = {

	cpt5_internal_data_closecombat_shoothandler = ["click_target",{
		params ["_t"];
		private _it = callFunc(call sp_getActor,getItemInActiveHandRedirect);
		private _r = false;
		if !isNullReference(_it) then {
			if (
				isTypeOf(_it,IRangedWeapon)
				&& {getVar(call sp_getActor,isCombatModeEnable)}
				&& {callFunc(_it,isCocked)}
				
				//! это можно обойти
				//&& {equals(_t,"cpt5_izcombat" call sp_ai_getMobObject)}
			) then {
				_r = true;
				[
					pick[
						"Заклинило!",
						"Не стреляет.",
						"НЕ СТРЕЛЯЕТ БЛЯТЬ!",
						"ЗАКЛИНИЛОСЬ!",
						"Заклинило...",
						"Говно заклинило!"
					],
					"mind"
				] call chatPrint;
			};
		};
		
		_r
	}] call sp_addPlayerHandler;

	//get sword weapmodule and override
	_sword = "cpt5_obj_oldshortswordclosecombat" call sp_getObject;
	_weapModule = getVar(_sword,attachedWeapon);
	cpt5_debug_internal_fnc_methodRollAttack = getFunc(_weapModule,rollAttack);
	//без крит успехов и провалов в атаке
	[callFunc(_weapModule,getClassName),"rollAttack",{
		objParams();
		private _baseRet = call cpt5_debug_internal_fnc_methodRollAttack;
		//override sword throw handlers
		_baseRet set [0,1];
		_baseRet set [1,DICE_SUCCESS];
		_baseRet set [2,1];

		_baseRet
	},"replace"] call oop_injectToMethod;
	cpt5_internal_data_list_cacheRestoreInject pushBack [
		callFunc(_weapModule,getClassName),
		"rollAttack",
		cpt5_debug_internal_fnc_methodRollAttack,
		"replace"
	];

	//update target def
	cpt5_debug_internal_fnc_methodGetDefenceWeapon = getFunc(call sp_getActor,defenceReturn);
	["Mob","defenceReturn",{
		objParams();
		private _r = call cpt5_debug_internal_fnc_methodGetDefenceWeapon;
		if (equals("cpt5_izcombat" call sp_ai_getMobObject,this) && (cpt5_internal_data_ctr_canDamage > 0)) then {
			_r set [0,1];
			_r set [1,DICE_SUCCESS];
			_r set [2,1];
		};
		_r
	},"replace"] call oop_injectToMethod;
	cpt5_internal_data_list_cacheRestoreInject pushBack [
		"Mob",
		"defenceReturn",
		cpt5_debug_internal_fnc_methodGetDefenceWeapon,
		"replace"
	];
	
};

cpt5_internal_data_ctr_canDamage = 0;

["cpt5_act_ccomb_loop",{

	{
		for "_i" from 1 to 6 do {
			private _covName = "cpt5_obj_preendcov" + (str _i);
			private _cov = _covName call sp_getObject;
			[_cov] call deleteGameObject;
		}
	} call sp_threadCriticalSection;

	{
		{
			[true,0.01] call setBlackScreenGUI;
			2 call sp_threadPause;
			0.5 call sp_threadPause;
			sp_playerHp = 100;
			[false,3.5] call setBlackScreenGUI;
		} call sp_threadStart;
	} call sp_setEventDiePlayer;
	
	[cpt5_questName_preend,"Убейте истязателя"] call sp_setTaskMessageEff;
	if (!callFuncParams(call sp_getActor,hasItem,"ShortSword")) then {
		if !isNullReference(callFunc(call sp_getActor,getItemInActiveHandRedirect)) then {
			callFuncParams(call sp_getActor,dropItem,getVar(call sp_getActor,activeHand));
		};
		["ShortSword",call sp_getActor,getVar(call sp_getActor,activeHand)] call createItemInInventory;
	};

	{
		["В ближнем бою будьте максимально внимательны и осторожны. Одно неверное действие может полностью изменить ход сражения. Комбинируйте разные #(стили атаки) и #(зоны попадания), не забывая следить за вашей #(выносливостью)."] call sp_setNotification;
		15 call sp_threadPause;
		[false] call sp_setNotificationVisible;
	} call sp_threadStart;

	["damage",{
		objParams_1(_am);		
		if equals(getVar(this,name),"Дико") exitWith {
			_nf = {
				params ['this'];
				if ((({
				!callFuncParams(this,hasPart,_x)
				} count BP_INDEX_ALL) > 0) || getVar(this,isDead) || !callFunc(this,isActive)) then {
					if (getVar(this,isDead)) exitWith {};

					refset(("cpt5_izcombat" call sp_ai_getMobBody) getvariable "anim_handler",true);
					//setVar(this,isDead,true);
					callFuncParams(this,Die,null);
				};
			}; invokeAfterDelayParams(_nf,0.1,this);
			sp_wsim_invokeNextAction = true;
		};
		if equals(call sp_getActor,this) then {
			[10] call sp_applyPlayerDamage;
		};
	}] call sp_addWsimHandler;
	sp_playerCanMove = true;
	_refizt = ["cpt5_izcombat",[
		["cpt5_pos_izcombat1","cpt5_izt_ccomb_point1",rand(1,5),{}],
		["cpt5_pos_izcombat2","cpt5_izt_ccomb_point2",rand(1,5),{}]
	]
	] call sp_ai_playAnimsLooped;
	("cpt5_izcombat" call sp_ai_getMobBody) setvariable ["anim_handler",_refizt];
	_mob = "cpt5_izcombat" call sp_ai_getMobObject;
	setVar(_mob,curDefType,DEF_TYPE_PARRY);
	setVar(_mob,DX,vec2(cpt5_data_closecombat_izt_dx,0));
	
	cpt5_internal_data_ctr_canDamage = 5;

	_thdcombat = {
		_mob = "cpt5_izcombat" call sp_ai_getMobObject;
		_defmodeList = [DEF_TYPE_PARRY,DEF_TYPE_DODGE];
		
		while {true} do {
			setVar(_mob,curDefType,pick _defmodeList);
			
			if (callFuncParams(_mob,getDistanceTo,call sp_getActor arg true) <= 1.8) then {
				
				{callFuncParams(_mob,attackOtherMob,call sp_getActor)} call sp_threadCriticalSection;
				DEC(cpt5_internal_data_ctr_canDamage);
				rand(2,2.3) call sp_threadPause;
			} else {

				if (prob_new(40) && cpt5_internal_data_ctr_canDamage <= 0) then {
					callFuncParams(_mob,playEmoteSound,"laugh");
					setVar(_mob,DX,vec2(9,0));
					rand(1.3,2) call sp_threadPause;
					setVar(_mob,DX,vec2(cpt5_data_closecombat_izt_dx,0));
					cpt5_internal_data_ctr_canDamage = 5;
				} else {
					rand(2,6) call sp_threadPause;
				};
			};
		};
	} call sp_threadStart;

	[{
		params ["_thdcombat"];
		{getVar("cpt5_izcombat" call sp_ai_getMobObject,isDead)} call sp_threadWait;
		_thdcombat call sp_threadStop;
		{
			cpt5_internal_data_list_cacheRestoreInject apply {_x call oop_injectToMethod};
			cpt5_internal_data_closecombat_shoothandler call sp_removePlayerHandler;
		} call sp_threadCriticalSection;

		[] call sp_audio_stopMusic;

		_refizt = ("cpt5_izcombat" call sp_ai_getMobBody)getvariable "anim_handler";
		refset(_refizt,true);

		[cpt5_questName_preend,"Поверните рычаг"] call sp_setTaskMessageEff;
		["closecombat_after",true] call sp_audio_playMusic;
		
		{getVar("SteelGridDoorElectronic G:pubFKk0z1KE" call sp_getObject,isOpen)} call sp_threadWait;
		{
			callFuncParams("cpt5_obj_doorclosecombat" call sp_getObject,setDoorOpen,true);
		} call sp_threadCriticalSection;
		["cpt5_act_lastscene"] call sp_startScene;
	
	},[_thdcombat]] call sp_threadStart;

}] call sp_addScene;


["cpt5_act_lastscene",{
	cpt5_data_lastbattle = false;
	[cpt5_questName_preend,"Вернитесь к проходу"] call sp_setTaskMessageEff;

	["cpt5_kapitan","cpt5_pos_capitan5",0] call sp_ai_setMobPos;
	("cpt5_kapitan" call sp_ai_getMobBody) switchMove "Acts_AidlPercMstpSloWWrflDnon_warmup_3_loop";

	for "_i" from 1 to 5 do {
		_strI = str _i;
		["cpt5_pos_attacker" + _strI,"cpt5_attacker" + _strI,[
			["uniform","StreakCloth"],
			["name",["Боец"]],
			["head",pick["HatBandana4","HatBandana5","HatBandana6","HatBandana7","CombatHelmet",""]]
		],{
			[pick["RifleFinisher","RifleAuto","PistolHandmade"],_this,INV_HAND_R] call createItemInInventory;
			//callFuncParams(_this,setCombatMode,true);
			callFunc(_this,switchTwoHands);
		},{
			_elist = [
				"Acts_AidlPercMstpSloWWpstDnon_warmup_3_loop",
				"Acts_AidlPercMstpSloWWpstDnon_warmup_5_loop",
				"Acts_AidlPercMstpSloWWpstDnon_warmup_6_loop",
				"Acts_AidlPercMstpSloWWpstDnon_warmup_8_loop",
				"Acts_AidlPercMstpSloWWrflDnon_warmup_2_loop"
			];
			if ((_elist select _i) != "") then {
				_this switchMove (_elist select _i);
				
			};
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
		},{
			_this switchMove "amovpknlmstpsraswpstdnon";
		}] call sp_ai_createPersonEx;
	};

	{
		{
			callFuncParams("cpt5_kapitan" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true)
			<= 7
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

	sp_playerCanMove = false;

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

		8 call sp_threadPause;
		[""] call sp_view_setPlayerHudVisible;
		[true,0.2] call setBlackScreenGUI;
		
		_ender = {
			["cpt5end_start"] call sp_startScene;
		};
		invokeAfterDelay(_ender,2);
	} call sp_threadStart;
}] call sp_addTriggerEnter;

cpt5_end_fnc_effOnDoor = {
	callFuncParams(call sp_getActor,playSound,"internal\skillcheckdx.wav" arg getRandomPitch);
	{
		_handle = ppEffectCreate ["Fisheye", 3000];
		_handle ppEffectEnable true; 
		_handle ppEffectAdjust [0.05,0.31,-0.1]; 
		_handle ppEffectCommit 0.4;
		0.4 call sp_threadpause;
		_handle ppEffectAdjust [0.1,0.1,0.1]; 
		_handle ppEffectCommit 0.5;
		0.5 call sp_threadpause;

		_handle ppEffectEnable false;
		ppEffectDestroy _handle;
	} call sp_threadStart;
};

["cpt5end_start",{
	call sp_threadStopAll;
	call sp_ai_deleteAllPersons;
	
	["left"] call sp_view_setPlayerHudVisible;

	callFuncParams(call sp_getActor,Die, null);

	private _chair = "cpt5end_obj_chairmybody" call sp_getObject;
	["cpt5_pos_deadplayerpos","player_cutscene",[],{
		[_this] call sp_copyPlayerInventoryTo;
		callFuncParams(_chair,seatConnect,_this);
		callFuncParams(_this,Die,null);
	},{
		
	}] call sp_ai_createPersonEx;

	[true] call sp_setHideTaskMessageCtg;

	{
		private _switcher = {
			_d = getDisplay;
			if isNullReference(_d) exitWith {false};
			_d getvariable ["ieMenuCtg",widgetNull] getvariable ["categsGroup",widgetNull] getvariable ["isloadedlist",false]
		};

		_hDie = [{
			_wid = widgetNull;
			{
				if (!isNullReference(_x) && ({_x getvariable "act" == "wrld_toGhost"})) then {
					_wid = _x;
				}
			} foreach interactEmote_act_widgets;
			_wid
		},null,_switcher] call sp_createWidgetHighlight;

		_hmes = ["Вы #(умерли). Чтобы покинуть тело нажмите $input_act_inventory и в левом меню найдите пункт #(Покинуть тело)"] call sp_setNotification;

		{
			private _act = call sp_getActor;
			private _prep = call sp_isPlayerPosPrepared;
			private _cond = !isNullVar(_act) && {isTypeOf(_act,MobGhost)} && {!isNullVar(_prep) && {_prep}};
			!isNullVar(_cond) && {_cond}
		} call sp_threadWait;
		_d = getGUI;
		_w = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
		_w setBackgroundColor [0,0,0,1];
		refset(_hDie,true);
		[false,_hmes] call sp_setNotificationVisible;
		

		{call sp_isPlayerPosPrepared} call sp_threadWait;
		
		["cpt5end_pos_start",0] call sp_setPlayerPos;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		0.1 call sp_threadPause;
		[true,0,false] call sp_gui_setBlackScreenGUI;
		{
			[_w,true] call deleteWidget;
		} call sp_threadCriticalSection;

		[false,5,false] call sp_gui_setBlackScreenGUI;
		//fix broken unhiding (sp reasons...)
		player hideobject false;
		sp_playerCanMove = true;

		{
			["main_action",{
				params ["_t"];
				if (isTypeOf(_t,DoorDynamic) || isTypeOf(_t,DoorStatic)) then {
					if (callFuncParams(call sp_getActor,getDistanceTo,_t arg true) <= 5) then {
						call cpt5_end_fnc_effOnDoor;
					};
				};
				false
			}] call sp_addPlayerHandler;
			["activate_verb",{
				params ["_t","_name"];
				if (_name == "mainact") then {
					if (isTypeOf(_t,DoorDynamic) || isTypeOf(_t,DoorStatic)) then {
						if (callFuncParams(call sp_getActor,getDistanceTo,_t arg true) <= 5) then {
							call cpt5_end_fnc_effOnDoor;
						};
					};
				};
				false
			}] call sp_addPlayerHandler;
		} call sp_threadCriticalSection;
	} call sp_threadStart;



	//["cpt5_endtitle"] call sp_startScene;
}] call sp_addScene;


["cpt5end_trg_ghostseedoor",{
	["Призраки могут проходить сквозь двери. Для этого нажмите $input_act_mainAction"] call sp_setNotification;
}] call sp_addScene;

cpt5end_trg_ghostenterdoor_act = false;
["cpt5end_trg_ghostenterdoor",{
	if (cpt5end_trg_ghostenterdoor_act) exitWith {};
	cpt5end_trg_ghostenterdoor_act = true;
	[false] call sp_setNotificationVisible;
}] call sp_addTriggerEnter;

["cpt5end_trg_final",{
	{
		_chair = "cpt5end_obj_chairmybody" call sp_getObject;
		{
			callFuncParams(_chair,getDistanceTo, call sp_getActor arg true)
			<= 3
		} call sp_threadWait;

		[true] call sp_cam_setCinematicCam;
		[true] call sp_gui_setCinematicMode;
		["VR",[3808.41,3620.74,6.37576],269.908,0.96,[-7.26865,0],0,0,720.001,0.0493299,0,1,0,1] call sp_cam_prepCamera;
		private _t = 30;
		["all",["VR",[3807.31,3620.73,6.37576],269.908,0.39,[-7.26865,0],0,0,720.001,0.0493299,0,1,0,1],_t] call sp_cam_interpTo;
		[false,1] call sp_gui_setBlackScreenGUI;
		10 call sp_threadPause;

		[true,0.1] call sp_gui_setBlackScreenGUI;
		call sp_cam_stopAllInterp;
		
		[5] call sp_onChapterDone;
		[false] call sp_gui_setCinematicMode;

		3 call sp_threadPause;
		["cpt5_endtitle"] call sp_startScene;

	} call sp_threadStart;
}] call sp_addScene;

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
		["kollector_underground",false] call sp_audio_playMusic;

		_d = call displayOpen;
		_sX = 70;
		_sY = 5;
		_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
		_logoSize = 60;
		_curY = 50-_logoSize/2;
		_logo = [_d,PICTURE,[50-_sX/2,_curY,_sx,_logoSize],_ctg] call createWidget;
		[_logo,"rel_ui\Assets\log.paa"] call widgetSetPicture;
		widgetSetFade(_logo,1,0);
		widgetSetFade(_logo,0,5);


		modvar(_curY) + _logoSize*1.5;

		_itlist = [
			"Над обучением работали:",
			"",
			"Yodes - код, карта",
			"Devil - озвучка",
			"Rumyn - озвучка",
			"Astra - озвучка",
			"BublkJpeg - озвучка",
			"Mnenekogda - звуки",
			"",
			"Тестеры:",
			"Sranych - тестирование",
			"Lampyridae - тестирование",
			"Geomem - тестирование",
			"Mark - тестирование",
			""
		];

		{
			modvar(_curY) + (_sY);
			_w = [
				_d,TEXT,[50-_sX/2,_curY,_sX,_sY],_ctg
			] call createWidget;
			[_w,format["<t align='center' size='1.5'>%1</t>",_x]] call widgetSetText;
		} foreach _itlist;
		
		4 call sp_threadPause;

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