// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

["begin_start",{
	[""] call sp_view_setPlayerHudVisible;

	[true,0] call setBlackScreenGUI;
	["begin_pos_player",0] call sp_setPlayerPos;

	[false,3] call setBlackScreenGUI;
	
	["begin_pos_watcher1","begin_watcher1",[
		["uniform","StreakCloth"],
		["name",["Смотрящий"]]
	],{
		["DBShotgun",_this,INV_HAND_R] call createItemInInventory;
		callFunc(_this,switchTwoHands);
	}] call sp_ai_createPersonEx;
	
	for "_i" from 1 to 4 do {
		_strI = str _i;
		["begin_pos_campfirer" + _strI,"begin_campfirer"+_strI,
			[
				["uniform","StreakCloth"],
				["name",["Житель"]]
			],{

			}
		] call sp_ai_createPersonEx;
	};

	for "_i" from 1 to 2 do {
		_strI = str _i;
		["begin_pos_arounder" + _strI,"begin_arounder"+_strI,
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

	for "_i" from 1 to 3 do {
		_strI = str _i;
		["begin_pos_mainattacker" + _strI,"begin_mainattacker" + _strI,
			_NAInvData,{}
		] call sp_ai_createPersonEx;
	};


	//cutscene1
	["begin_pos_cutscene1dead","begin_cutscene1dead",[["uniform","StreakCloth"],["name",["Житель"]]],{}] call sp_ai_createPersonEx;
	["begin_pos_cutscene1attack","begin_cutscene1attack",_NAInvData,{}] call sp_ai_createPersonEx;


	//cutscene2
	["begin_pos_cutscene2dead1","begin_cutscene2dead1",[["uniform","StreakCloth"],["name",["Житель"]]],{}] call sp_ai_createPersonEx;

	["begin_pos_cutscene2attack1","begin_cutscene2attack1",_NAInvData,{}] call sp_ai_createPersonEx;
	["begin_pos_cutscene2dead2","begin_cutscene2dead2",[["uniform","StreakCloth"],["name",["Житель"]]],{}] call sp_ai_createPersonEx;

	//chase behinder
	["begin_pos_chase_attacker1","begin_chase_attacker1",_NAInvData,{}] call sp_ai_createPersonEx;
	//chase last
	["begin_pos_chase_attacker2","begin_chase_attacker2",_NAInvData,{}] call sp_ai_createPersonEx;


	["begin_naattacked"] call sp_startScene;

}] call sp_addScene;

["begin_naattacked",{

	for "_i" from 1 to 3 do {
		_strI = str _i;
		["begin_mainattacker"+_strI,"begin_pos_mainattacker"+_strI,"begin_mainattacker"+_strI,{

		}] call sp_ai_playAnim;
	};

}] call sp_addScene;