// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



class(ReagentHolder)
	
	var(reagentList,[]);
	var(totalVolume,0);
	var(maxVolume,0);
	var(loc,nullPtr);//игровой объект
	
	//удаляет реагенты пока не останется _amount количества
	func(removeAny)
	{
		objParams_1(_amount);
	};
	
	abstract_func(transferTo);
	abstract_func(transferIdTo);
	abstract_func(metabolize);
	abstract_func(handleReactions);
	abstract_func(isolateReagent);
	abstract_func(deleteReagent);
	abstract_func(updateTotal);
	abstract_func(clearReagents);
	abstract_func(reaction);
	abstract_func(addReagent);
	abstract_func(removeReagent);
	abstract_func(getReagentAmount);
	

endclass