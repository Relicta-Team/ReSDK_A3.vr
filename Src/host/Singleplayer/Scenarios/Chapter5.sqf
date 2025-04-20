// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

cpt5_debug_skipStart = true;

["cpt5_begin",{
	if (!sp_debug) then {cpt5_debug_skipStart = false};
	["cpt5_pos_start",0] call sp_setPlayerPos;

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
	
	
	//making mobs
	for "_i" from 1 to 2 do {
		["cpt5_pos_bedwall","cpt5_bedwall_" + (str _i),[
			["uniform","StreakCloth"],
			["name",["Защитник"]]
		],{
			callFuncParams(("cpt5_obj_bedwall"+(str _i)) call sp_getObject,seatConnect,_this arg _i - 1);
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
	},{
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
	},{
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
				["cpt5_pos_weaponloader1","cpt5_weaponloader1",{rand(10,15)},{ params ["_obj"]; _obj switchMove "Acts_Kore_IdleNoWeapon_loop"}],
				["cpt5_pos_weaponloader2","cpt5_weaponloader2",{rand(10,15)},{ params ["_obj"]; _obj switchMove "Acts_Kore_IdleNoWeapon_loop"}]
			]
		] call sp_ai_playAnimsLooped;

	["cpt5_pos_capitan1","cpt5_kapitan",[
		["uniform","StreakCloth"],
		["name",["Капитан"]]
	]] call sp_ai_createPersonEx;

	["cpt5_pos_armytalker1","cpt5_armytalker",[
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
		["name",["Истязатель"]]
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
		]] call sp_ai_playAnimsLooped;
	}] call sp_ai_createPersonEx;

	["cpt5_pos_izt2","cpt5_izt2",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]]
	],{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFuncParams(_this,setCombatMode,true);
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	["cpt5_pos_izt3","cpt5_izt3",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]]
	],{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFuncParams(_this,setCombatMode,true);
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;

	for "_i" from 2 to 3 do {
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
		]] call sp_ai_playAnimsLooped;
	};


	//moving pos (left->right) cpt5_pos_izcombat1 cpt5_pos_izcombat2
	["cpt5_pos_izcombat_spawn","cpt5_izcombat",[
		["uniform","StreakCloth"],
		["name",["Дико","Убивать"]]
	],{
		["ShortSword",_this,INV_HAND_R] call createItemInInventory;
	}] call sp_ai_createPersonEx;


	{
		["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;

	} call sp_threadStart;
}] call sp_addScene;

//общение лекарей
cpt5_act_lekartalks = false;
["cpt5_trg_lekarstalks",{
	if (!cpt5_act_lekartalks) then {
		cpt5_act_lekartalks = true;

		{
			2 call sp_threadPause;
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
["cpt5_trg_kapitanunderground",{



	if (cpt5_act_kapitanunderground) exitWith {
		if (cpt5_act_kapitanreadytoup) exitWith {};

		if (callFuncParams(call sp_getActor,hasItem,"RifleSVT")) exitWith {
			cpt5_act_kapitanreadytoup = true;

			["cpt5_kapitan","cpt5_pos_capitan2","cpt5_capitan2",{
				params ["_mob"];
				_mob switchmove "acts_aidlpercmstpslowwpstdnon_warmup_1_loop";
			}] call sp_ai_playAnim;

		};

	};

	cpt5_act_kapitanunderground = true;
	["cpt5_kapitan","cpt5_pos_capitan1","cpt5_capitan1",{
		params ["_mob"];
		_mob switchmove "acts_aidlpercmstpslowwpstdnon_warmup_1_loop";
	}] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

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
//приказ подавления
["cpt5_pos_combat_stage1",{

	{
		//dialog

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

["cpt5_trg_warzone",{

}] call sp_addTriggerEnter;

["cpt5_trg_closecombat_pre",{

}] call sp_addScene;

cpt5_act_closecombat_started = false;
["cpt5_trg_ccomb_activate",{
	if (cpt5_act_closecombat_started) exitWith {};
	cpt5_act_closecombat_started = true;
	
	["cpt5_izcombat","cpt5_pos_izcombat_spawn","cpt5_izt_ccmb_prepare",{
		["cpt5_act_ccomb_loop"] call sp_startScene;
	},[
		["state_1",{
			params ["_body"];
			_izt = "cpt5_izcombat" call sp_ai_getMobObject;
			callFunc(_izt,switchTwoHands);
			[_body] call anim_syncAnim;
			callFuncParams(_izt,setCombatMode,true);
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

["cpt5_act_ccomb_loop",{
	["cpt5_izcombat",[
		["cpt5_pos_izcombat1","cpt5_izt_ccomb_point1",rand(2,4),{}],
		["cpt5_pos_izcombat2","cpt5_izt_ccomb_point2",rand(2,4),{}]
	]
	] call sp_ai_playAnimsLooped;
}] call sp_addScene;