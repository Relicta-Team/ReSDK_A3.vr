// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

class(RTVTRole) extends(BasicRole)
	var(name,"Воин");
	var(desc,"Займите одну из сторон конфлита и примите участие в жестокой схватке.");
	getter_func(canTakeInLobby,true);
	getter_func(canVisibleAfterStart,true);
	
	var(returnInLobbyAfterDead,true);
	
	var(count,100);
	
	getter_func(getInitialDir,callFunc(gm_currentMode,getSpawnDir));
	getter_func(getInitialPos,callFunc(gm_currentMode,getSpawnPos));
	getter_func(getSkills,callFunc(gm_currentMode,getSkills));
	func(getOtherSkills) {[
		skillrand(fight,1,2) arg
		skillrand(throw,1,3) arg
		skillrand(pistol,1,2) arg
		skillrand(stealth,0,5) arg
		skillrand(rifle,1,5) arg
		skillrand(sword,1,3) arg
		skillrand(traps,0,6)
	]};
	func(getEquipment)
	{
		objParams_1(_mob);
		
		callFuncParams(gm_currentMode,setEquipment,_mob);
	};
	
	func(initWelcome)
	{
		objParams_1(_mob);
		private _ft = format["<t size='1.4'>Вы - %1</t>%3%2",callFunc(gm_currentMode,getCurRoleName),callFunc(gm_currentMode,getCurRoleDesc),sbr];
		callFuncParams(_mob,addFirstJoinMessage,_ft);
	};
	
	func(onAssigned)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(gm_currentMode,onSpawnedMob,_mob);
	};
	
	func(onDead)
	{
		objParams_2(_mob,_usr);
		super();
		callFuncParams(gm_currentMode,onKilledMob,_mob);
		//+2 минуты за смерть
		modVar(gm_currentMode,duration, + 60*2);
		
		#ifndef EDITOR
		callFuncParams(_usr,setDeadTimeout,10);
		#else
		//вместо 5 минут 1 ждать
		if (getVar(gm_currentMode,stage)==1) then {
			callFuncParams(_usr,setDeadTimeout,10);
		} else {
			callFuncParams(_usr,setDeadTimeout,60);
		};
		#endif
	};
	
endclass