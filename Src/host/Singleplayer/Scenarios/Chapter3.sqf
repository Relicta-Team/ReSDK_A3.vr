// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

["cpt3_begin",{
	
	["cpt3_pos_start",0] call sp_setPlayerPos;
	["right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;
	[false,1.5] call setBlackScreenGUI;

	if (!callFuncParams(call sp_getActor,hasItem,"Torch" arg true)) then {
		["Torch",call sp_getActor] call createItemInInventory;
	};

	//create deadbody
	_posDeadbody = callFunc("cpt3_pos_deadbody_looting" call sp_getObject,getPos);
	_body = [_posDeadbody,null,"cpt3_deadbody"] call sp_ai_debug_createTestPerson;
	_mob = _body getvariable "link";

	callFuncParams(_mob,generateNaming,"Уба" arg "Бахот");
	setVar(_mob,age,27);

	_cloth = ["NomadCloth10",_mob,INV_CLOTH] call createItemInInventory;
	["Lockpick",_cloth] call createItemInContainer;
	
	callFuncParams(_mob,destroyLimb,BP_INDEX_HEAD);
	callFuncParams(_mob,destroyLimb,BP_INDEX_LEG_L);
	//callFuncParams(_mob,destroyLimb,BP_INDEX_ARM_L);
	callFuncParams(_mob,destroyLimb,BP_INDEX_ARM_R);

	_body switchMove "acts_staticdeath_10";
	_body enablemimics false;

}] call sp_addScene;

["cpt3_trg_katafound",{
	["Подступ к городу","Идите через катакомбы"] call sp_setTaskMessageEff;
}] call sp_addScene;

["cpt3_trg_foundmushrooms",{
	{
		_h = ["В Сети растёт множество разных культур. Чаще всего здесь можно найти ралзичные грибы, в том числе съедобные. Будьте осторожны и не ешьте неизвестные вам грибы."] call sp_setNotification;
		10 call sp_threadPause;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_founddeadbody",{
	{
		["Вы можете обыскивать тела"] call sp_setNotification;
	} call sp_threadStart;
}] call sp_addScene;

["cpt3_trg_searchhide",{
	{
		callFuncParams(call sp_getActor,playSound,"monster\eater\idle2" arg getRandomPitchInRange(0.8,1.3) arg null arg 2.2);
		callFuncParams(call sp_getActor,syncSmdVar,"isStunned" arg true);
		["Подозрительный шум - здесь может быть опасно. Прислушайтесь"] call sp_setNotification;

	} call sp_threadStart;
}] call sp_addScene;


// "LampCeiling G:Kym4iXFMOZ0 (3)" - lamp screamer (todo disable by default)
// "LampCeiling G:a3+rKIedoM0" - lamp stealth testing

["cpt3_trg_startStealthPre",{
	
	{
		
		private _obj = "LampCeiling G:a3+rKIedoM0" call sp_getObject;
		while {true} do {
			
			1 call sp_threadPause;
			private _mode = false;
			for "_i" from 1 to 5 do {
				callFuncParams(_obj,setEnable,_mode);
				_mode = !_mode;
				
				rand(0.2,0.7) call sp_threadPause;
			};
			
			4 call sp_threadPause;
			
			callFuncParams(_obj,setEnable,true);

			4 call sp_threadPause;
		};
	} call sp_threadStart;
}] call sp_addScene;

//cpt3_obj_lockeddoor - door object
//cpt3_trg_searchhide - trigger do look at eater