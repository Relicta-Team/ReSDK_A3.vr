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
			callFuncParams(("cpt5_obj_bednear"+(str _iReal)) call sp_getObject,seatConnect,_this arg _iReal - 1);
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
	]] call sp_ai_createPersonEx;
	["cpt5_pos_izt2","cpt5_izt2",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]]
	]] call sp_ai_createPersonEx;
	["cpt5_pos_izt3","cpt5_izt3",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]]
	]] call sp_ai_createPersonEx;

	//moving pos (left->right) cpt5_pos_izcombat1 cpt5_pos_izcombat2
	["cpt5_pos_izcombat_spawn","cpt5_izcombat1",[
		["uniform","StreakCloth"],
		["name",["Истязатель"]]
	]] call sp_ai_createPersonEx;


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

//приказ подавления
["cpt5_pos_combat_stage1",{

}] call sp_addTriggerEnter;