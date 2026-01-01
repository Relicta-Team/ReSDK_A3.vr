// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

#include "begin_playerSetup.sqf"

begin_debug_showLogo = true;

begin_logoshown = false;
["begin_prestart",{
	[true] call sp_cam_setCinematicCam;

	[""] call sp_view_setPlayerHudVisible;
	[true,0] call setBlackScreenGUI;

	["begin_pos_camcutsceneintro",0] call sp_setPlayerPos;

	//=======================================making mob================================

	//bum in house
	["begin_pos_intromob1","begin_intromob1",[
		["uniform","Castoffs1"]
	],{},{
		_this switchMove "passenger_flatground_2_Idle_Unarmed";
	}] call sp_ai_createPersonEx;

	//2 nomads
	["begin_pos_intromob2","begin_intromob2",[
		["uniform","NomadCloth9"]
	],{},{
		_this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_5_loop";
	}] call sp_ai_createPersonEx;
	["begin_pos_intromob3","begin_intromob3",[
		["uniform","HuntingCaveCloak2"]
	],{
		["Torch",_this,INV_HAND_L] call createItemInInventory;
	},{
		
	}] call sp_ai_createPersonEx;

	//walker nomad
	["begin_pos_intromob4","begin_intromob4",[
		["uniform","LeatherCaveArmor1"]
	],{
		["Torch",_this,INV_HAND_R] call createItemInInventory;
	},{
		
	}] call sp_ai_createPersonEx;

	//caveguy
	["begin_pos_intromob5","begin_intromob5",[
		["uniform","CaveCombatUniform"]
	],{
		["RifleSVT",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	},{
		
	}] call sp_ai_createPersonEx;

	//merchant location
	["begin_pos_intromob6","begin_intromob6",[
		["uniform","NomadCloth2"]
	],{
		
	},{
		_this switchmove "inbasemoves_table1";
	}] call sp_ai_createPersonEx;
	["begin_pos_intromob7","begin_intromob7",[
		["uniform","NomadCloth2"]
	],{
		
	},{
		_this switchmove "Acts_B_M01_briefing";
	}] call sp_ai_createPersonEx;

	for "_i" from 1 to 3 do {
		_strI = str _i;

		
		["begin_pos_introna"+_strI,"begin_introna"+_strI,[
			["uniform","NewArmyStdCloth"]
		],{
			[ifcheck(_i==3,"BattleAxe","RifleSVT"),_this,INV_HAND_R] call createItemInInventory;
			callFunc(_this,switchTwoHands);

			["CombatHat",_this,INV_HEAD] call createItemInInventory;
		}] call sp_ai_createPersonEx;
	};

	//starting thread
	{
		{call sp_isPlayerPosPrepared} call sp_threadWait;

		{
			3 call sp_threadPause;
			["intro"] call sp_audio_playMusic;
			_post = {
				{
					_d = getGUI;
					_mainBack = widgetNull;
					_ctg = widgetNull;
					_b = widgetNull;
					_logo = widgetNull;

					{
						_mainBack = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
						_mainBack setBackgroundColor [0,0,0,1];
						_ctg = [_d,WIDGETGROUP,WIDGET_FULLSIZE] call createWidget;
						_b = [_d,BACKGROUND,WIDGET_FULLSIZE,_ctg] call createWidget;
						_b setBackgroundColor [0,0,0,1];
						_sx = 40;
						_sy = 40;
						_logo = [_d,PICTURE,[50-_sx/2,50-_sy/2,_sx,_sy],_ctg] call createWidget;
						[_logo,"rel_ui\Assets\log.paa"] call widgetSetPicture;
						{widgetSetFade(_x,1,0)} foreach [_logo,_b,_mainBack];
					} call sp_threadCriticalSection;

					widgetSetFade(_b,0,0.05);
					0.1 call sp_threadPause;
					widgetSetFade(_logo,0,0.15);

					//fog effect
					{
						_localFogs = [];
						for "_i" from 1 to 100 do {
							
							_h = 70;
							_args = [_d,PICTURE,[-100,-100,rand(40,70),rand(40,70)],_ctg];
							
							_fog = _args call createWidget;
							_fog ctrlEnable false;
							_fog ctrlSetTextColor [1,1,1,0.4];
							
							_localFogs pushback _fog;
							
							[_fog,PATH_PICTURE("lobby\fog.paa")] call widgetSetPicture;
							_fog setVariable ['lastupdate',tickTime + rand(0.1,1)];
							
						};
						
						private _onFrameCodeFog = {
							
							_lifetime = 12;
							
							{
								if isNullReference(_x) exitWith {
									stopThisUpdate();
								};

								_sprStartPos = [50 + rand(-0,50),100 - rand(-5,0)];
								_sprEndPos = [50 + rand(-50,50),30];

								_lastUpd = _x getVariable 'lastupdate';
								if (tickTime >= _lastUpd) then {
									if (begin_logoshown) exitWith {
										_x setVariable ['lastupdate',tickTime + 1000];
										_x setFade 1;
										[_x,[rand(0,50),-50],rand(2.8,3)] call widgetSetPositionOnly
									};
									_x setFade 0;
									_sp = _sprStartPos;
									[_x,_sp] call widgetSetPositionOnly;
									_randBias = rand(1,8);
									_x setFade 0;
									_x ctrlSetAngle [random 360, 0.5, 0.5,false];
									[_x,_sprEndPos,_lifetime - _randBias] call widgetSetPositionOnly;
									_x setVariable ['lastupdate',tickTime + _lifetime-_randBias];
								};
							} foreach (_this select 0);
						};
						
						startUpdateParams(_onFrameCodeFog,0,_localFogs);
					} call sp_threadCriticalSection;	

					if (begin_debug_showLogo) then {
						5 call sp_threadPause;
						//enable native background
						widgetSetFade(_mainBack,0,0);
					
						//hide logo
						widgetSetFade(_logo,1,1);
						1 call sp_threadPause;
						begin_logoshown = true;
						//hide ctg (smoke effect)
						//widgetSetFade(_ctg,1,3);
						
						7 call sp_threadPause;
					};
					[_ctg] call deleteWidget;
					[_mainback] call deleteWidget;
					[true,0] call setBlackScreenGUI;
					[false] call sp_cam_setCinematicCam;
					{
						call sp_ai_deleteAllPersons;
					} call sp_threadCriticalSection;

					["begin_start"] call sp_startScene;
				} call sp_threadStart;

			}; 
			_t = 42.5; //logo time
			invokeAfterDelay(_post,_t);

			6 call sp_threadPause;
			(["begin\precutscene\gg1"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
			5 call sp_threadPause;
			(["begin\precutscene\gg2"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
			1 call sp_threadPause;
			(["begin\precutscene\gg3",1.5] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
			2.8 call sp_threadPause;
			(["begin\precutscene\gg4",1.5] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
			3 call sp_threadPause;
			(["begin\precutscene\gg5",2] call sp_audio_sayPlayer);
		} call sp_threadStart;

		//1 call sp_threadPause;
		begin_debug_timingIntro = tickTime;

		//walker in tunnel
		["vr",[3943.62,3999.43,87.8217],305.033,0.51,[7.31202,2.04198],0,0,720,0.028667,0,1,0,1] call sp_cam_prepCamera;
		["all",["vr",[3942.64,4000.11,87.8217],304.549,0.41,[8.59264,2.04198],0,0,720,0.028667,0,1,0,1],20] call sp_cam_interpTo;
		"begin_intromob4" call sp_ai_waitForMobLoaded;
		{["begin_intromob4","begin_pos_intromob4","begin\introtunnel.anm"] call sp_ai_playAnim} call sp_threadCriticalSection;
		[false,2] call sp_gui_setBlackScreenGUI; //потому что это первая сцена
		8 call sp_threadPause;
		[true,1] call sp_gui_setBlackScreenGUI;
		call sp_cam_stopAllInterp;

		//nomads looting
		["vr",[3920.89,3990.54,90.0218],192.304,0.35,[3.56222,2.04198],0,0,720,0.028667,0,1,0,1] call sp_cam_prepCamera;
		["all",["vr",[3920.56,3988.97,90.6218],191.199,0.35,[-5.81236,2.04198],0,0,720,0.028667,0,1,0,1],25] call sp_cam_interpTo;
		"begin_intromob2" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		[false,1] call setBlackScreenGUI;
		8 call sp_threadPause;
		[true,1] call sp_gui_setBlackScreenGUI;
		call sp_cam_stopAllInterp;

		//bum inside house
		// ["vr",[3917.29,3976.71,122.421],41.1298,0.58,[-4.15509,0],0,0,720,0.028667,0,1,0,1] call sp_cam_prepCamera;
		// ["all",["vr",[3918.33,3977.92,122.421],40.7631,0.58,[1.67053,4.10418],0,0,720,0.028667,0,1,0,1],25] call sp_cam_interpTo;
		// "begin_intromob1" call sp_ai_waitForMobLoaded;
		// {call sp_isPlayerPosPrepared} call sp_threadWait;
		// [false,1] call setBlackScreenGUI;
		// 5 call sp_threadPause;
		// [true,1] call sp_gui_setBlackScreenGUI;
		// call sp_cam_stopAllInterp;

		//cave guard
		["vr",[3968.64,3990.48,91.8219],257.031,0.36,[16.4857,2.04198],0,0,720,0.028667,0,1,0,1] call sp_cam_prepCamera;
		["all",["vr",[3968.09,3989.14,91.8219],267.178,0.55,[12.5978,-8.55648],0,0,720,0.028667,0,1,0,1],25] call sp_cam_interpTo;
		"begin_intromob5" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		[false,1] call setBlackScreenGUI;
		8 call sp_threadPause;
		[true,1] call sp_gui_setBlackScreenGUI;
		call sp_cam_stopAllInterp;


		//merchanters
		// ["vr",[3929.36,4006.03,149.022],300.822,0.47,[-33.279,-14.5418],0,0,720,0.028667,0,1,0,1] call sp_cam_prepCamera;
		// "begin_intromob7" call sp_ai_waitForMobLoaded;
		// _bdy = ("begin_intromob7" call sp_ai_getMobBody);
		// _bdy switchmove "Acts_B_M01_briefing"; _bdy setAnimSpeedCoef 0.8;
		// ["all",["vr",[3928.92,4005.79,148.822],315.817,0.47,[-32.0988,-14.5418],0,0,720,0.028667,0,1,0,1],15] call sp_cam_interpTo;
		// 0.1 call sp_threadPause;
		// [false,0.2] call sp_gui_setBlackScreenGUI;
		// 4 call sp_threadPause;
		// [true,0.2] call sp_gui_setBlackScreenGUI;
		// call sp_cam_stopAllInterp;

		

		//napos
		["vr",[3934.05,3981.78,9.79338],296.457,0.46,[6.10687,7.22812],0,0,4.00993,0,1,1,0,1] call sp_cam_prepCamera;
		"begin_introna1" call sp_ai_waitForMobLoaded;
		{
			for "_i" from 1 to 3 do {
				_strI = str _i;
				["begin_introna"+_strI,"begin_pos_introna"+_strI,"begin\introna"+_strI] call sp_ai_playAnim;
			};
		} call sp_threadCriticalSection;
		1 call sp_threadPause;
		["fov",0.46,0.42,9] call sp_cam_interpCam;
		[false,4] call sp_gui_setBlackScreenGUI;

		4.5 call sp_threadPause;
		

		begin_debug_timingIntro = tickTime - begin_debug_timingIntro;

		
	} call sp_threadStart;
}] call sp_addScene;

begin_debug_fastTests = sp_debug;

//говорящие ребята и все из первого сегмента
begin_internal_hwcut_list = [];

begin_internal_NAInvData = [
	["uniform","NewArmyStdCloth"],
	["name",["Новоармеец"]]
];

begin_handleKeyDown = -1;
["begin_start",{
	
	[cpt1_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;

	{
		[] call sp_audio_stopMusic;
		player forcewalk false;

		["begin_finalizer"] call sp_callTriggerEvent;
	} call sp_setEventDiePlayer;

	sp_playerCanMove = false;
	
	[""] call sp_view_setPlayerHudVisible;
	{
		setVar(call sp_getActor,stamina,1000);
	} call sp_threadStart;

	[true,0] call setBlackScreenGUI;
	["begin_pos_player",0] call sp_setPlayerPos;
	
	
	begin_internal_hwcut_list pushback (["begin_pos_hwcut1","begin_hwcut1",[
		["uniform","CitizenCloth5"]
	],{},{
		_this switchmove "Acts_Accessing_Computer_Loop";
	}] call sp_ai_createPersonEx);

	begin_internal_hwcut_list pushback (["begin_pos_hwcut2man","begin_hwcut2man",[
		["uniform","GreenWorkerCloth"]
	],{},{
		_this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_3_loop";
	}] call sp_ai_createPersonEx);
	begin_internal_hwcut_list pushback (["begin_pos_hwcut2woman","begin_hwcut2woman",[
		["uniform","BlueRobe"],
		["class","MobWoman"],
		["face","FaceW10"]
	],{},{
		_this switchMove "Acts_CivilIdle_1";
	}] call sp_ai_createPersonEx);

	begin_internal_hwcut_list pushback (["begin_pos_hwcut3","begin_hwcut3",[
		["uniform","WorkSuit"]
	],{
		["Shovel",_this,INV_BACK] call createItemInInventory;
	},{
		
	}] call sp_ai_createPersonEx);

	begin_internal_hwcut_list pushback (["begin_pos_hwcut4man1","begin_hwcut4man1",[
		["uniform","CitizenCloth4"]
	]] call sp_ai_createPersonEx);
	begin_internal_hwcut_list pushback (["begin_pos_hwcut4man2","begin_hwcut4man2",[
		["uniform","LuxRusticCloth4"]
	],{},{
		_this switchmove "acts_taking_cover_from_jets_in_loop";
	}] call sp_ai_createPersonEx);

	//arounders

		//cageman
		begin_internal_hwcut_list pushback (["begin_pos_arounder1","begin_arounder1",[
			["uniform","CookerCloth"],
			["head","CookerCap"]
		],{},{
			_this switchmove "Acts_JetsCrewaidF_idle2";
		}] call sp_ai_createPersonEx);
		//lookat cages
		begin_internal_hwcut_list pushback (["begin_pos_arounder2","begin_arounder2",[
			["uniform","LuxRusticCloth19"]
		],{},{
			_this switchmove "InBaseMoves_table1";
		}] call sp_ai_createPersonEx);
		//campfire sitter
		begin_internal_hwcut_list pushback (["begin_pos_arounder3","begin_arounder3",[
			["uniform","LuxRusticCloth15"],
			["head","PeasantHat"]
		],{},{
			_this switchmove "passenger_flatground_3_Idle_Unarmed";
		}] call sp_ai_createPersonEx);
		//bench sitter
		begin_internal_hwcut_list pushback (["begin_pos_arounder4","begin_arounder4",[
			["uniform","HuntingCaveCloak3"]
		],{
			callFuncParams("begin_obj_hwbench" call sp_getObject,seatConnect,_this);
		}] call sp_ai_createPersonEx);

	//end arounders
	
	//keepers
	for "_i" from 1 to 3 do {
		_strI = str _i;
		["begin_pos_keeper" + _strI,"begin_keeper"+_strI,
			[
				["uniform",ifcheck(_i!=2,"NomadCloth10","CaveChainArmor1")],
				["name",["Житель"]]
			],{
				if (_i == 2) then {
					["ShortSword",_this,INV_HAND_L] call createItemInInventory;
				};
				if (_i == 0) then {
					["PeasantHat",_this,INV_HEAD] call createItemInInventory;
				};
			},
			{
				if (_i==2) then {
					//_this switchMove "Acts_JetsMarshallingLeft_loop";
					_this switchmove "Acts_ShowingTheRightWay_loop";
				}
			}
		] call sp_ai_createPersonEx;
	};


	//["begin_naattacked"] call sp_startScene;
	if (begin_handleKeyDown != -1) then {
		(findDisplay 46) displayRemoveEventHandler ["KeyDown",begin_handleKeyDown];
		begin_handleKeyDown = -1;
	};
	begin_handleKeyDown = (findDisplay 46) displayAddEventHandler ["keyDown",{
		params ["_d","_key"];
		_sprintAndWalk = (ACT(MoveFastForward) + ACT(MoveSlowForward) + ACT(turbo) + ACT(TurboToggle) + ACT(GetOver) + ACT(TactToggle) + ACT(WalkRunToggle));
		_locked = CHANGE_STANCE_BUTTONS + FAST_DROP_BUTTONS + _sprintAndWalk;
		#ifdef SP_DEBUG
		if (true) exitWith {false};
		#endif
		if (_key in _locked) then {true} else {false};
	}];
	
	{
		if (!begin_debug_fastTests) then {
			2 call sp_threadPause;
		};
		[false,3] call setBlackScreenGUI;
		if (!begin_debug_fastTests) then {
			5 call sp_threadPause;
		};

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

begin_func_startTalkerAnimations = {
	["begin_hwcut1",
		[
			["begin_pos_hwcut1","begin\village_kuhar",
			{rand(8,17)},
			{ 
				params ["_obj"];
				//pos begin_pos_hwcut1
				_obj switchmove "Acts_Accessing_Computer_Loop";
				[_obj,"begin_pos_hwcut1",0] call sp_ai_setMobPos;
			},
			[
				["state_1",{
					params ["_obj"]; _obj switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop";
					[{tickTime > _this},tickTime + rand(5,10)] call sp_ai_animWait;
				}],
				["state_2",{
					params ["_obj"]; _obj switchMove "hubbriefing_ext_contact";
					[{tickTime > _this},tickTime + rand(10,15)] call sp_ai_animWait;
				}]
			]
			]
		]
	] call sp_ai_playAnimsLooped;

	["begin_hwcut3",
		[
			["begin_pos_hwcut3","begin\village_lopat",
			{rand(10,15)},
			{ 
				params ["_obj"];
				_obj switchmove "hubstandinguc_idle1";
			},
			[
				["state_1",{
					params ["_obj"]; 
					_obj switchMove "acts_aidlpercmstpsnonwnondnon_warmup_4_loop";
					[{tickTime > _this},tickTime + rand(5,10)] call sp_ai_animWait;
				}],
				["state_2",{
					params ["_obj"]; 
					_obj switchMove "acts_aidlpercmstpsnonwnondnon_warmup_4_loop";
					[{tickTime > _this},tickTime + rand(5,10)] call sp_ai_animWait;
				}],
				["state_3",{
					params ["_obj"]; 
					_obj switchMove "acts_aidlpercmstpsnonwnondnon_warmup_4_loop";
					[{tickTime > _this},tickTime + rand(5,10)] call sp_ai_animWait;
				}]
			]
			]
		]
	] call sp_ai_playAnimsLooped;
};

begin_internal_list_hwcut = [];
//kuhar
["beging_trg_talker1",{
	begin_internal_list_hwcut pushback ({
		for "_i" from 1 to 3 do {
			_strI = str _i;
			rand(0.2,0.8) call sp_threadPause;
			([
				["begin_hwcut1","begin\village\kuh" + _strI,["distance",30]]
			] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

			rand(1.2,3.8) call sp_threadPause;
			{
				callFuncParams("begin_hwcut1" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true) <= 3
			} call sp_threadWait;

		};
	} call sp_threadStart);
}] call sp_addScene;
//man and woman
["beging_trg_talker2",{
	begin_internal_list_hwcut pushback ({
		([
			["begin_hwcut2man","begin\village\muzh1",[["endoffset",0.1],["distance",30]]],
			["begin_hwcut2woman","begin\village\cac1",[["endoffset",0.1],["distance",30]]],
			["begin_hwcut2man","begin\village\muzh2",[["endoffset",0.4],["distance",30]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
		
		//["begin_hwcut2man",player] call sp_ai_setLookAtControl;
		["begin_hwcut2woman",player] call sp_ai_setLookAtControl;

		{
			callFuncParams("begin_hwcut2man" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true) <= 3
		} call sp_threadWait;

		([
			["begin_hwcut2woman","begin\village\cac2",[["endoffset",0.1],["distance",30]]],
			["begin_hwcut2man","begin\village\muzh3",[["endoffset",0.7],["distance",30]]],
			["begin_hwcut2woman","begin\village\cac3",[["endoffset",1.3],["distance",30]]],
			["begin_hwcut2man","begin\village\muzh4",[["endoffset",0.4],["distance",30],["onstart",{
				{
					1.7 call sp_threadPause;
					["begin_hwcut2woman","begin_pos_hwcut2woman","begin\village_caca",{
						params ["_obj"];
						_obj switchmove "Acts_CivilIdle_1";
					}] call sp_ai_playAnim;
				} call sp_threadStart;
			}]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
		
		0.7 call sp_threadPause;

		["begin_hwcut2man","begin_pos_hwcut2man","begin\village_muzh",{
			params ["_obj"];
			_obj switchMove "acts_explaining_ew_idle01";
		}] call sp_ai_playAnim;


	} call sp_threadStart);
}] call sp_addScene;
//mushroomer
["beging_trg_talker3",{
	begin_internal_list_hwcut pushback ({
		for "_i" from 1 to 3 do {
			_strI = str _i;
			rand(0.2,0.8) call sp_threadPause;
			([
				["begin_hwcut3","begin\village\lop" + _strI,["distance",30]]
			] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

			rand(3.2,5.8) call sp_threadPause;
			{
				callFuncParams("begin_hwcut3" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true) <= 4
			} call sp_threadWait;

		};
	} call sp_threadStart);
}] call sp_addScene;
//guys
["beging_trg_talker4",{
	begin_internal_list_hwcut pushback ({
		([
			["begin_hwcut4man1","begin\village\talk1_1",[["endoffset",0.1],["distance",20]]],
			["begin_hwcut4man2","begin\village\talk2_1",[["endoffset",0.8],["distance",20]]],
			["begin_hwcut4man1","begin\village\talk1_2",[["endoffset",0.1],["distance",20]]],
			["begin_hwcut4man2","begin\village\talk2_2",[["endoffset",0.8],["distance",20]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		["begin_hwcut4man1",player] call sp_ai_setLookAtControl;
		["begin_hwcut4man2",player] call sp_ai_setLookAtControl;
		{
			callFuncParams("begin_hwcut4man1" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true) <= 3
		} call sp_threadWait;

		([
			["begin_hwcut4man1","begin\village\talk1_3",[["endoffset",0.1],["distance",20]]],
			["begin_hwcut4man2","begin\village\talk2_3",[["endoffset",0.8],["distance",20]]],
			["begin_hwcut4man1","begin\village\talk1_4",[["endoffset",1],["distance",20],["onstart",{
				{
					1.5 call sp_threadPause;
					{
						if !isNullReference("begin_hwcut4man2" call sp_ai_getMobObject) then {
							["begin_hwcut4man2","begin_pos_hwcut4man2","begin\village_guy2",{
								params ["_obj"];
								//sitdown
								callFuncParams("begin_obj_hwbench" call sp_getObject,seatConnect,"begin_hwcut4man2" call sp_ai_getMobObject);
							}] call sp_ai_playAnim;
						};
					} call sp_threadCriticalSection;
				} call sp_threadStart;
			}]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		["begin_hwcut4man1","begin_pos_hwcut4man1","begin\village_guy1",{
			params ["_obj"];
			//sitdown
			_obj switchMove "passenger_flatground_3_idle_unarmed";
		}] call sp_ai_playAnim;
	} call sp_threadStart);
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
	["begin_keeper1","begin_pos_keeper1","begin\keeper1",{
		//on end
		params ["_mob"];
		_anim = "hubbriefing_ext_contact";
		_mob switchMove _anim;

		[_mob,"begin_pos_keeper1_gate",0] call sp_ai_setMobPos;
		begin_canStartAttack=true;
	},[
		["state_1",{
			params ["_obj"];
			callFuncParams("begin_obj_hwdoor" call sp_getObject,setDoorOpen,true);
		}],
		["state_2",{
			params ["_obj"];
			_anim = "acts_explaining_ew_idle03";
			_obj switchMove _anim;
			_thd = {
				//dialog
				([
					["begin_keeper1","begin\start\prov1",[["endoffset",0.5],["distance",50]]],
					[player,"begin\start\gg1",["endoffset",0.3]],
					["begin_keeper1","begin\start\prov2",[["endoffset",1.1],["distance",50]]],
					[player,"begin\start\gg2",["endoffset",1.3]],
					["begin_keeper1","begin\start\prov3",[["endoffset",0],["distance",50]]],
					["begin_keeper1","begin\start\prov4",[["endoffset",0],["distance",50]]]
				] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

				1 call sp_threadPause;
				sp_playerCanMove = true;
	 			player forcewalk true;
				player setAnimSpeedCoef 0.78;

				call begin_func_startTalkerAnimations;
				
			} call sp_threadStart;
			
			//nocheck thread
			[{
				_this call sp_threadWaitForEnd;
				1 call sp_threadPause;
				["beginstart",true] call sp_audio_playMusic;
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
			},_thd] call sp_threadStart;

			[{equals(_this,sp_threadNull)},_thd] call sp_ai_animWait;
		}]
	]] call sp_ai_playAnim;
	
}] call sp_addScene;

begin_startattack_lockzone_act = false;
["begin_startattack_lockzone",{
	if (begin_startattack_lockzone_act) exitWith {};

	if (callFuncParams("begin_pos_keeper1_gate" call sp_getObject,getDistanceTo,call sp_getActor) <= 4) then {
		begin_startattack_lockzone_act = true;
		private _ivl = "begin_obj_invvalpreattack_lock" call sp_getObject;
		private _oldpos = callFunc(_ivl,getPos);
		callFuncParams(_ivl,changePosition,_oldpos vectoradd vec3(0,0,-4));
	};
}] call sp_addTriggerExit;

begin_prepgate_act = false;
begin_gate_list_deadcivils = [];
begin_gate_list_attackers = [];
["begin_prepgate",{
	if (begin_prepgate_act) exitWith {};
	begin_prepgate_act = true;

	["begin_pos_watcher1","begin_watcher1",[
		["uniform","NomadCloth10"],
		["head","Turban2"],
		["name",["Смотрящий"]]
	],{
		["DBShotgun",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	
	["begin_pos_watcher2","begin_watcher2",[
		["uniform","CaveChainArmor1"],
		["head","LeatherHat"],
		["name",["Смотрящий"]]
	],{
		["ShortSword",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;

	for "_i" from 1 to 9 do {
		_civCreate = {
			params ["_i"];
			_strI = str _i;
			begin_gate_list_deadcivils pushback (["begin_pos_startdead" + _strI,"begin_startdead"+_strI,
				[
					["head",pick["Turban2","HatBandanaOpen1","PeasantHat","WorkerCap","","","",""]],
					["uniform",pick["NomadCloth"+(str randInt(1,23)),"HuntingCaveCloak" + (str randInt(1,3)),"CookerCloth","GriblanCloth"]],
					["name",["Житель"]]
				],{

				}
			] call sp_ai_createPersonEx);
		};
		invokeAfterDelayParams(_civCreate,(_foreachindex) * 0.3,[_i]);
	};

	for "_i" from 1 to 6 do {
		_attackerCreate = {
			params ["_i"];
			_strI = str _i;
			begin_gate_list_attackers pushback (["begin_pos_mainattacker" + _strI,"begin_mainattacker" + _strI,
				begin_internal_NAInvData,{
					if (_i == 3) then {
						["PistolHandmade",_this,INV_HAND_R] call createItemInInventory;
					} else {
						["RifleAuto",_this,INV_HAND_R] call createItemInInventory;
					};
					callFuncParams(_this,setCombatMode,true);
					callFunc(_this,switchTwoHands);
				}
			] call sp_ai_createPersonEx);
		};
		invokeAfterDelayParams(_attackerCreate,(_foreachindex) * 0.3,[_i]);
	};


}] call sp_addTriggerEnter;

begin_startattack_activated = false;
["begin_startattack",{
	if (begin_startattack_activated) exitWith {};
	begin_startattack_activated = true;

	{
		[_x] call sp_threadStop;
	} foreach begin_internal_list_hwcut;

	{
		//[_x] call sp_ai_deletePerson;
		invokeAfterDelayParams({_this call sp_ai_deletePerson},_foreachindex * 0.1,[_x]);
	} foreach begin_internal_hwcut_list;
	
	[true,true] call sp_audio_setMusicPause;
	_post = {
		[] call sp_audio_stopMusic;
		[!true,true] call sp_audio_setMusicPause;
	};
	invokeAfterDelay(_post,4);

	private _ivl = "begin_obj_invvalpreattack" call sp_getObject;
	private _oldpos = callFunc(_ivl,getPos);
	callFuncParams(_ivl,changePosition,_oldpos vectoradd vec3(0,0,-4));

	//for reload mode close doors
	callFuncParams("begin_doorenter" call sp_getObject,setDoorOpen,false);
	callFuncParams("begin_rundoor1" call sp_getObject,setDoorOpen,false);
	callFuncParams("begin_rundoor2" call sp_getObject,setDoorOpen,false);

	callFuncParams("begin_doorexit" call sp_getObject,setDoorOpen,false);

	for "_i" from 1 to 2 do {
		_strI = str _i;
		(("begin_mainattacker"+_strI) call sp_ai_getMobBody) hideObject true;
		["begin_mainattacker"+_strI,"begin_pos_mainattacker"+_strI,"begin\mainattacker"+_strI,{},[
			["state_1",{
				[{
					
					if (begin_attackStarted) then {
						(("begin_mainattacker1") call sp_ai_getMobBody) hideObject false;
						(("begin_mainattacker2") call sp_ai_getMobBody) hideObject false;
						
						if equals(_mob,"begin_mainattacker1" call sp_ai_getMobBody) then {
							_post = {
								[
									["begin_mainattacker1","begin\gate\na1_1",["distance",100]],
									["begin_mainattacker2","begin\gate\na2_1",["distance",100]]
								] call sp_audio_startDialog;
							}; invokeAfterDelay(_post,2.3);
						};
					};
					begin_attackStarted
				}] call sp_ai_animWait;
				
			}],
			["state_2",{
				params ["_mob"];

				[{
					_mbs = [];
					for "_i" from 1 to 5 do {
						_mbs pushBack (("begin_startdead" + (str _i)) call sp_ai_getMobObject);
					};
					({callFunc(_x,isActive)} count _mbs) == 0
				}] call sp_ai_animWait;

				if equals(_mob,"begin_mainattacker1" call sp_ai_getMobBody) then {
					[
						["begin_mainattacker1","begin\gate\na1_2",["distance",50]],
						["begin_mainattacker2","begin\gate\na2_2",["distance",50]]
					] call sp_audio_startDialog;

					{
						3 call sp_threadPause;
						[getposatl("begin_mainattacker1" call sp_ai_getMobBody),"begin\radio5",35] call sp_audio_playSound;
						2 call sp_threadPause;
						[getposatl("begin_mainattacker1" call sp_ai_getMobBody),"begin\radio7",35] call sp_audio_playSound;
					} call sp_threadStart;
				};
				
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
								if isNullVar(_body) exitWith {};
								if isNullReference(_body) exitWith {};

								//задержка перед смертью убегающийх
								rand(4,7) call sp_threadPause;
								{
									_bmob = _body getvariable ["link",nullPtr];
									if (isNullReference(_bmob)) exitWith {};
									if !callFunc(_bmob,isActive) exitWith {};

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
		1 call sp_threadPause;
		([
			["begin_watcher2","begin\gate\sword1",["distance",40]],
			["begin_startdead1","begin\gate\guy1",[["distance",30],["endoffset",0.9]]],
			["begin_startdead5","begin\gate\guy2",[["distance",40],["endoffset",1.8]]],
			["begin_startdead4","begin\gate\guy3",[["distance",40],["endoffset",1.6]]],
			["begin_startdead3","begin\gate\guy4",[["distance",40],["endoffset",0.1]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		{begin_canStartAttack} call sp_threadWait;
		2.2 call sp_threadPause;

		([["begin_watcher1","begin\gate\watcher",["distance",50]]] call sp_audio_startDialog)
			call sp_audio_waitForEndDialog;
		{
			_wbody = ("begin_watcher1" call sp_ai_getMobBody);
			[
				"begin_mainattacker1" call sp_ai_getMobObject,
				_wbody modelToWorld (_wbody selectionPosition "head")
			] call cpt5_act_doShot;
		} call sp_threadCriticalSection;
		
		0.01 call sp_threadPause;

		{callFuncParams("begin_watcher1" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD)} call sp_threadCriticalSection;

		0.01 call sp_threadPause;

		player forcewalk false;

		//bum grenade
		_trg = "begin_posdata_grenade" call sp_getObject;
		_pos = callFunc(_trg,getPos);
		{
			[_pos] call cpt5_explosionGrenade;
		} call sp_threadCriticalSection;

		[["begin_startdead4","begin\gate\guy3_run",["distance",50]]] call sp_audio_startDialog;
		
		[["begin_startdead5","begin\gate\guy2_run",["distance",50]]] call sp_audio_startDialog;

		["beginchase",true] call sp_audio_playMusic;

		//dooropen
		{
			callFuncParams("begin_doorenter" call sp_getObject,setDoorOpen,true);
		} call sp_threadCriticalSection;
		[["begin_startdead3","begin\gate\guy4_run",["distance",50]]] call sp_audio_startDialog;

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
		
		[["begin_watcher2","begin\gate\sword2",["distance",40]]] call sp_audio_startDialog;

		begin_attackStarted = true;

		2 call sp_threadPause;
		[["begin_startdead1","begin\gate\guy1_run",["distance",40]]] call sp_audio_startDialog;

		{ [[3755.28,3927.41,7.12903]] call cpt5_explosionGrenade; } call sp_threadCriticalSection;
		for "_i" from 1 to 2 do {
			_strI = str _i;
			private _objname = "begin_obj_destr" + _strI;
			private _obj = _objname call sp_getObject;
			private _pos = callFunc(_obj,getPos);
			callFuncParams(_obj,changePosition,_pos vectoradd vec3(0,0,5) arg false);
		};

		//keeper anim
		["begin_keeper1","begin_pos_keeper1_gate","begin\keeper1_run",{
			//on end
			params ["_mob"];
			_anim = "hubbriefing_ext_contact";
			_mob switchMove _anim;

				begin_canStartAttack=true;
			},[
				["state_1",{
					params ["_obj"];
					callFuncParams("begin_rundoor1" call sp_getObject,setDoorOpen,true);
				}],
				["state_2",{
					callFuncParams("begin_rundoor2" call sp_getObject,setDoorOpen,true);
				}]
			]
		] call sp_ai_playAnim;
		[
			["begin_keeper1","begin\gate\prov1",[["distance",20],["endoffset",0.9]]],
			[player,"begin\gate\gg1",[["distance",10],["endoffset",2]]],
			["begin_keeper1","begin\gate\prov2",[["distance",30],["endoffset",0.1]]]
		] call sp_audio_startDialog;

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
			[getposatl("begin_mainattacker3" call sp_ai_getMobBody),"begin\radio3",35] call sp_audio_playSound;
		}],
		["state_3",{
			{
				{!isNull(begin_run3_dialogHandle)} call sp_threadWait;
				[getposatl("begin_mainattacker3" call sp_ai_getMobBody),"begin\radio1",35] call sp_audio_playSound;
				begin_run3_dialogHandle call sp_audio_waitForEndDialog;
				{
					["begin_mainattacker3" call sp_ai_getMobObject,("begin_keeper1" call sp_ai_getMobBody) modelToWorld [0,0,0.4]] call cpt5_act_doShot;
					callFuncParams("begin_keeper1" call sp_ai_getMobObject,lossLimb,BP_INDEX_HEAD)
				} call sp_threadCriticalSection;

			} call sp_threadStart;
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_enterrun2_act = false;
["begin_run2",{
	if (begin_enterrun2_act) exitWith {};
	begin_enterrun2_act = true;
	callFuncParams("begin_rundoor1" call sp_getObject,setDoorOpen,false);

	for "_i" from 7 to 9 do {
		(("begin_startdead"+(str _i)) call sp_ai_getMobBody) switchMove ["Acts_ShockedUnarmed_2_Loop",rand(0,1),1,false];
	};

	["begin_mainattacker4","begin_pos_mainattacker4","begin\mainattacker4",{},[
		["state_1",{
			[{begin_enterrun4}] call sp_ai_animWait;
			[getposatl("begin_mainattacker3" call sp_ai_getMobBody),"begin\radio8",30] call sp_audio_playSound;
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
begin_run3_dialogHandle = null;
["begin_run3",{
	if (begin_run3_act) exitWith {};
	begin_run3_act = true;

	begin_run3_dialogHandle = [
		["begin_keeper1","begin\gate\prov3",[["distance",20],["endoffset",1.3]]],
		[player,"begin\gate\gg2",[["distance",10],["endoffset",1]]],
		["begin_keeper1","begin\gate\prov4",[["distance",30],["endoffset",0]]]
	] call sp_audio_startDialog;

}] call sp_addTriggerEnter;

begin_enterrun4 = false;
begin_run4_processenemy = true;
["begin_run4",{
	if (begin_enterrun4) exitWith {};
	begin_enterrun4 = true;

	[["begin_keeper2","begin\under\sword1",["distance",80]]] call sp_audio_startDialog;

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

begin_internal_list_cutscene1 = [];
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
	[
		["begin_keeper2","begin\under\sword2",[["endoffset",0.4],["distance",50]]],
		[player,"begin\under\gg1",[["endoffset",1.3],["distance",50]]],
		["begin_keeper2","begin\under\sword3",[["endoffset",0],["distance",50]]],
		[player,"begin\under\gg2",[["endoffset",0.1],["distance",50]]],
		["begin_keeper2","begin\under\sword4",[["endoffset",0],["distance",50],["onend",{
			begin_act_readyToDown = true;
		}],["onstart",{
			//cutscene1
			begin_internal_list_cutscene1 pushback (["begin_pos_cutscene1dead","begin_cutscene1dead",[["uniform","NomadCloth23"],["name",["Житель"]]],{}] call sp_ai_createPersonEx);
			begin_internal_list_cutscene1 pushback (["begin_pos_cutscene1attack","begin_cutscene1attack",begin_internal_NAInvData,{
				["BattleAxe",_this,INV_HAND_R] call createItemInInventory;
				callFunc(_this,switchTwoHands);
				callFuncParams(_this,setCombatMode,true);
			}] call sp_ai_createPersonEx);
		}]]]
	] call sp_audio_startDialog;

	["begin_keeper2",player] call sp_ai_setLookAtControl;

	["begin_keeper2","begin_pos_keeper2","begin\keeper2",{},[
		["state_1",{
			[{begin_playerInVent}] call sp_ai_animWait;
		}],
		["state_2",{
			//todo close crate and sounds
			_obj = "begin_obj_crate" call sp_getObject;
			_pos = callFunc("begin_pos_cratenewpos" call sp_getObject,getPos) vectoradd [0,0,0.7];

			//callFuncParams(call sp_getActor,interpolate,"trans" arg _obj)
			callFuncParams(_obj,changePosition,_pos);
			callFuncParams(_obj,playSound,"pull\wood2" arg 1 arg 10 arg 1 arg null arg false);

			_post = {
				[
					["begin_keeper2","begin\under\sword5",["endoffset",0.3]]
				] call sp_audio_startDialog;
			}; invokeAfterDelay(_post,1.8);
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
begin_playerInVent = false;
["begin_run5",{
	if (begin_run5_act) exitWith {};
	begin_run5_act = true;

	{
		invokeAfterDelayParams({_this call sp_ai_deletePerson},_foreachindex * 1,[_x]);
	} foreach begin_gate_list_deadcivils;

	{
		{begin_act_readyToDown} call sp_threadWait;

		//player animation
		//begin_pos_playerautoanim1
		player forcewalk true;
		[true] call begin_internal_setNearCollisionMode;
		[true] call sp_gui_setCinematicMode;
		[player,"begin_pos_playerautoanim1","begin\playerautoanim1",{
			[false] call begin_internal_setNearCollisionMode;
			[false] call sp_gui_setCinematicMode;

			[true,true] call sp_audio_setMusicPause;
			_post = {
				[!true,true] call sp_audio_setMusicPause;
				["beginchase2",true] call sp_audio_playMusic;
			};
			invokeAfterDelay(_post,4);

			begin_playerInVent = true;
		}] call sp_ai_playAnim;
	} call sp_threadStart;
	
}] call sp_addTriggerEnter;

begin_cutscene1_act = false;
["begin_cutscene1",{
	if (begin_cutscene1_act) exitWith {};
	begin_cutscene1_act = true;

	begin_run4_processenemy = false; //stop far enemy processing

	_mob = "begin_cutscene1attack" call sp_ai_getMobObject;
	setVar(_mob,curTargZone,TARGET_ZONE_FACE);
	setVar(_mob,DX,vec2(30,0));

	[
		["begin_cutscene1dead","begin\under\cutsdead1",["distance",20]],
		["begin_cutscene1dead","begin\under\cutsdead2",[["distance",20],["onstart",{
			{
				[getposatl("begin_cutscene1attack" call sp_ai_getMobBody),"begin\radio9",35] call sp_audio_playSound;
				5.2 call sp_threadPause;
				[getposatl("begin_cutscene1attack" call sp_ai_getMobBody),"begin\radio6",35] call sp_audio_playSound;

			} call sp_threadStart;
		}]]],
		["begin_cutscene1dead","begin\under\cutsdead3",["distance",20]]
	] call sp_audio_startDialog;

	//begin_pos_cutscene1dead
	//begin_pos_cutscene1attack
	["begin_cutscene1dead","begin_pos_cutscene1dead","begin\cutscene1dead",{},[]] call sp_ai_playAnim;
	["begin_cutscene1attack","begin_pos_cutscene1attack","begin\cutscene1attack",{},[
		["state_1",{
			[
				["begin_cutscene1attack","begin\under\cutsna1",["distance",20]]
			] call sp_audio_startDialog;
			_dead = "begin_cutscene1dead" call sp_ai_getMobObject;
			callFuncParams("begin_cutscene1attack" call sp_ai_getMobObject,attackOtherMob,_dead);
			callFuncParams(_dead,lossLimb,BP_INDEX_HEAD);
			{
				2 call sp_threadPause;
				[
					["begin_cutscene1attack","begin\under\cutsna2",["distance",15]]
				] call sp_audio_startDialog;
			} call sp_threadStart;
		}]
	]] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_run6_act = false;
["begin_run6",{
	if (begin_run6_act) exitWith {};
	begin_run6_act = true;

	{
		[_x] call sp_ai_deletePerson;
	} foreach begin_internal_list_cutscene1;

	//удаленные атакеры вызывают ошибки
	// {
	// 	invokeAfterDelayParams({_this call sp_ai_deletePerson},_foreachindex * 0.3,[_x]);
	// } foreach begin_gate_list_attackers;

	//cutscene2 with keeper
	["begin_pos_cutscene2attack1","begin_cutscene2attack1",begin_internal_NAInvData,{
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
		callFuncParams(_this,setCombatMode,true);
	}] call sp_ai_createPersonEx;
	["begin_pos_cutscene2dead2","begin_cutscene2dead2",[["uniform","CitizenCloth4"],["name",["Житель"]]],{}] call sp_ai_createPersonEx;

	//begin_pos_playerautoanim2
	[true] call begin_internal_setNearCollisionMode;
	[true] call sp_gui_setCinematicMode;
	[player,"begin_pos_playerautoanim2","begin\playerautoanim2",{
		[false] call begin_internal_setNearCollisionMode;
		[false] call sp_gui_setCinematicMode;
	}] call sp_ai_playAnim;
}] call sp_addTriggerEnter;

begin_tokeeper3_act = false;
begin_internal_data_keeper3readytoNextDialog = false;
["begin_trg_tokeeper3",{
	if (begin_tokeeper3_act) exitWith {};
	begin_tokeeper3_act = true;
	
	["begin_keeper3",player] call sp_ai_setLookAtControl;

	private _post = {
		{
			_hndl = ([
				["begin_keeper3","begin\end\bro1",[["endoffset",0.3],["distance",40]]],
				[player,"begin\end\gg1",["endoffset",0.1]],
				["begin_keeper3","begin\end\bro2",[["endoffset",0.1],["distance",30]]],
				[player,"begin\end\gg2",["endoffset",0.7]],
				["begin_keeper3","begin\end\bro3",[["endoffset",0.1],["distance",30]]]
			] call sp_audio_startDialog);
			
			_hndl call sp_audio_waitForEndDialog;
			1.2 call sp_threadPause;

			([
				[player,"begin\end\gg3",[["endoffset",0.2],["distance",30],["onstart",{
					begin_internal_data_keeper3readytoNextDialog = true;
				}]]],
				["begin_keeper3","begin\end\bro4",[["endoffset",0.3],["distance",30]]],
				[player,"begin\end\gg4",["endoffset",0.1]],
				["begin_keeper3","begin\end\bro5",[["endoffset",0.2],["distance",30]]],
				[player,"begin\end\gg5",["endoffset",0.1]]
			] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
			5 call sp_threadPause;
			{
				player distance ("begin_keeper3" call sp_ai_getMobBody) <= 3
			} call sp_threadWait;
			[
				["begin_keeper3","begin\end\bro6",[["endoffset",0.3],["distance",30]]]
			] call sp_audio_startDialog;
		} call sp_threadStart;
		
	}; invokeAfterDelay(_post,0.6);
	["begin_keeper3","begin_pos_keeper3","begin\keeper3",{},[
		["state_1",{
			params ["_obj"];
			
			_obj switchmove "acts_explaining_ew_idle01";

			[{begin_internal_data_keeper3readytoNextDialog}] call sp_ai_animWait;
		}],
		["state_2",{
			
			//[{tickTime > _this},tickTime + rand(5,10)] call sp_ai_animWait;
		}],
		//3 open, 4 goto, 5 close
		["state_3",{
			player forcewalk false;
			callFuncParams("begin_doortoexit" call sp_getObject,setDoorOpen,true);
		}],
		["state_4",{
			params ["_obj"];
			_obj switchmove "acts_taking_cover_from_jets_in_loop";
			[{begin_data_behinddoorEnd}] call sp_ai_animWait;
		}],
		["state_5",{
			{
				{
					callFuncParams("begin_doortoexit" call sp_getObject,setDoorOpen,false);
				} call sp_threadCriticalSection;				
				0.3 call sp_threadPause;
				{
					callFuncParams("begin_doortoexit" call sp_getObject,setDoorLock,true);
				} call sp_threadCriticalSection;
			} call sp_threadStart;
		}]
	]] call sp_ai_playAnim;

	["begin_cutscene2dead2","begin_pos_cutscene2dead2","begin\cutscene2dead2",{},[
		["state_1",{
			[{
				begin_cutscene2_act
			}] call sp_ai_animWait
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

				2.3 call sp_threadPause;
				
				[getposatl("begin_cutscene2attack1" call sp_ai_getMobBody),"begin\radio5",35] call sp_audio_playSound;
				1.8 call sp_threadPause;
				[
					["begin_cutscene2attack1","begin\end\na1",["endoffset",0.1]],
					["begin_cutscene2attack1","begin\radio8",["endoffset",3]],
					["begin_cutscene2attack1","begin\end\na2",["endoffset",0.1]]
				] call sp_audio_startDialog;
			
			} call sp_threadStart;
		}],
		["state_3",{
			//check door
			_door = "begin_doortoexit" call sp_getObject;

			private _snd = "doors\locked" + str pick [1 arg 2];
			private _rpith = getRandomPitchInRange(0.6,1.3);
			callFuncParams(_door,playSound,_snd arg _rpith arg 50 arg null arg null arg false);

			[{tickTime > _this},tickTime + 2.4] call sp_ai_animWait;
			_postOff = {
				callFuncParams("begin_cutscene2attack1" call sp_ai_getMobObject,setCombatMode,false);
			}; invokeAfterDelay(_postOff,5.5);
		}]
	]] call sp_ai_playAnim;

	//exitdoor - begin_doortoexit
	//cutscene door - begin_doorexit_cutscene2

}] call sp_addTriggerEnter;

begin_data_behinddoorEnd = false;
["begin_trg_behinddoorend",{
	if (begin_data_behinddoorEnd) exitWith {};
	begin_data_behinddoorEnd = true;

	//backwall for fix softlock
	private _obj = "begin_obj_invwaldoorend" call sp_getObject;
	private _pos = callFunc(_obj,getPos) vectorAdd [0,0,10];
	callFuncParams(_obj,changePosition,_pos arg false);

}] call sp_addTriggerEnter;

begin_cutscene2_act = false;
["begin_cutscene2",{
	if (begin_cutscene2_act) exitWith {};
	begin_cutscene2_act = true;

	callFuncParams("begin_doorexit_cutscene2" call sp_getObject,setDoorOpen,true);
	_snd = "doors\kick_break" + str randInt(1,3);
	callFuncParams("begin_doorexit_cutscene2" call sp_getObject,playSound,_snd arg getRandomPitchInRange(0.6,1.3));

	{
		2.7 call sp_threadPause;
		[getposatl("begin_cutscene2attack1" call sp_ai_getMobBody),"begin\radio4",35] call sp_audio_playSound;
	} call sp_threadStart;

	[
		["begin_cutscene2dead2","begin\end\dead1",[["endoffset",0.1],["distance",30]]],
		["begin_keeper3","begin\end\bro_end",[["endoffset",0.3],["distance",30]]], 
		["begin_cutscene2dead2","begin\end\dead2",[["endoffset",0.1],["distance",30]]]
	] call sp_audio_startDialog;
}] call sp_addTriggerEnter;

begin_prechase_act = false;
["begin_prechase",{
	if (begin_prechase_act) exitWith {};
	begin_prechase_act = true;

	_na_chase_weapons = {
		["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
		callFuncParams(_this,setCombatMode,true);
	};
	//chase behinder
	["begin_pos_chase_attacker1","begin_chase_attacker1",begin_internal_NAInvData,_na_chase_weapons] call sp_ai_createPersonEx;
	//chase last
	["begin_pos_chase_attacker2","begin_chase_attacker2",begin_internal_NAInvData,_na_chase_weapons] call sp_ai_createPersonEx;

	
	[true,true] call sp_audio_setMusicPause;

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
	begin_chase_act = true;
	[!true,true] call sp_audio_setMusicPause;
	//begin_pos_chase_attacker1/2
	["begin_chase_attacker1","begin_pos_chase_attacker1","begin\chase_attacker1",{

	},[
		["state_1",{
			callFuncParams("begin_doorexit" call sp_getObject,setDoorOpen,true);
			["beginchase"] call sp_audio_playMusic;
		}]
	]] call sp_ai_playAnim;

	{
		1.3 call sp_threadPause;
		
		[getposatl("begin_chase_attacker1" call sp_ai_getMobBody),"begin\radio2",55] call sp_audio_playSound;

		2.4 call sp_threadPause;

		_body = player;
		while {true} do {
			["begin_chase_attacker1",null,false] call sp_ai_commitMobPos;

			setVar(("begin_chase_attacker1") call sp_ai_getMobObject,stamina,100);
			_ps = _body modelToWorld ((_body selectionPosition "spine3") vectoradd [rand(-.01,.01),rand(-.01,.01),rand(-.01,.01)]);

			for "_iP" from 1 to randInt(1,5) do {
				[("begin_chase_attacker1") call sp_ai_getMobObject,_ps] call cpt5_act_doShot;

				//check player cheating with ai
				if (
					callFuncParams(call sp_getActor,getDirTo,"begin_chase_attacker1" call sp_ai_getMobObject) == DIR_BACK
					&& callFuncParams(call sp_getActor,getDistanceTo,"begin_chase_attacker1" call sp_ai_getMobObject arg true) > 3
				) then {
					call sp_callEventDiePlayer;
					break;
				};
				if (
					callFuncParams(call sp_getActor,getDistanceTo,"begin_chase_attacker1" call sp_ai_getMobObject arg true) <= 2
					|| callFuncParams(call sp_getActor,getDistanceTo,"begin_chase_attacker2" call sp_ai_getMobObject arg true) <= 2
				) then {
					call sp_callEventDiePlayer;
					break;
				};

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

	{
		15 call sp_threadPause;
		while {true} do {
			[5] call sp_applyPlayerDamage;
			0.2 call sp_threadPause;
		};
	} call sp_threadStart;

	["begin_chase_attacker2","begin_pos_chase_attacker2","begin\chase_attacker2",{

	},[
		["state_1",{
			callFuncParams("begin_doorexit2" call sp_getObject,setDoorOpen,true);
		}]
	]] call sp_ai_playAnim;

	{
		2 call sp_threadPause;
		_body = player;
		while {true} do {
			
			["begin_chase_attacker1",null,false] call sp_ai_commitMobPos;

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

	player setAnimSpeedCoef 1;

	[""] call sp_view_setPlayerHudVisible;
	[true,0.1] call setBlackScreenGUI;
	call sp_cleanupSceneData;
	
	["intro2"] call sp_audio_playMusic;
	[0] call sp_onChapterDone;
	{} call sp_setEventDiePlayer;
	{
		10 call sp_threadPause;  //because intro2
		["cpt1_begin"] call sp_startScene;
	} call sp_threadStart;

}] call sp_addTriggerEnter;