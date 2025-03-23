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
*/

["cpt4_begin",{
	["cpt4_pos_start",0] call sp_setPlayerPos;
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	[false,1.5] call setBlackScreenGUI;

	_body = ["cpt4_pos_enterkochevs",null,"cpt4_karim"] call sp_ai_createPerson;
	_body setDir (callFunc("cpt4_pos_enterkochevs" call sp_getObject,getDir));
	_mob = _body getvariable "link";
	callFuncParams(_mob,generateNaming,"Карим" arg "Сухач");

	_cloth = ["NomadCloth3",_mob,INV_CLOTH] call createItemInInventory;
	["ShuttleBag",_mob,INV_HAND_L] call createItemInInventory;
	["Torch",_mob,INV_HAND_R] call createItemInInventory;
	
	[_mob,"cpt4_pos_enterkochevs","cpt4_koch1_enter",{
		params ["_mob"];
		[_mob,getposatl _mob,null] call sp_ai_setMobPos;
		_mob switchmove "ApanPercMstpSnonWnonDnon_G01";
	}] call sp_ai_playAnim;
}] call sp_addScene;

//event started anim army guys
["cpt4_trg_gotomed",{

}] call sp_addScene;