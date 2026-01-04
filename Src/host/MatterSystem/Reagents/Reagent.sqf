// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define SOLID 1
#define LIQUID 2
#define GAS 3

#define TOUCH 1
#define INGEST 2
#define INJECT 3

class(ReagentBase)
	
	var(name,"Реагент");
	var(id,"Reagent");
	var(desc,"");
	var(loc,nullPtr);
	
	var(reagentState,SOLID);
	
	var(data,[]);
	var(isFirstLife,true);
	
	var(volume,0);
	getterconst_func(nutrimentFactor,0);
	getterconst_func(metabolizeRate,0.3);
	
	getterconst_func(overdose,0);
	
	getterconst_func(getColor,"#000000");
	
	func(reactionMob)
	{
		params['this',"_mob",["_method",TOUCH],"_volume","_targetZone"];
		if isTypeOf(_mob,Mob) exitWith {false};
		
		if isTypeOf(getSelf(loc),EffectSmoke) exitWith {false};
		
		private _chance = 1;
		private _isBlocked = false;
		{
			//если био костюмы есть то даем шансы на защиту
		} foreach INV_LIST_ALL;
		
		modvar(_chance) * 100;
		
		if (prob(_chance) && !_block) then {
			if !isNullReference(getVar(_mob,reagents)) then {
				callFuncParams(getVar(_mob,reagents),addReagent,getSelf(id) arg getSelf(volume)/2);
			};
		};
		
		true
	};
	
	func(reactionObj)
	{
		objParams_2(_obj,_volume);
		
	};
	
	abstract_func(reactionTurf);
	abstract_func(touchTurf);
	
	func(onRemove)
	{
		objParams_1(_data);
	};
	
	func(onMobLife)
	{
		objParams_1(_mob);
		if !isTypeOf(_mob,Mob) exitWith {};
		
		callFuncParams(getSelf(loc),removeReagent,getSelf(id) arg callFunc(metabolizeRate));
	};
	
	func(onMove)
	{
		objParams_1(_mob);
	};
	
	func(onNew)
	{
		objParams_1(_data);
	};
	
	func(onMerge)
	{
		objParams_1(_data);
	};
	
	func(onUpdate)
	{
		objParams_1()
	}
	
endclass