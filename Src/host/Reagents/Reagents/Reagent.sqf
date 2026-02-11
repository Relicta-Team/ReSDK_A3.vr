// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



class(ReagentBase)
	getter_func(getId,this getVariable PROTOTYPE_VAR_NAME getVariable "classname");
	var(name,"Реагент");
	getter_func(getName,getSelf(name));
	getter_func(getDesc,"");
	var(holder,nullPtr); //держатель реагентов
	var(data,null); //кастомные данные например как группа крови
	var(volume,0);

	var(reagentState,SOLID);
	
	var(data,[]);
	var(isFirstLife,true);
	
	
	getterconst_func(getNutrimentFactor,0);
	getterconst_func(getMetabolizeRate,0.3);
	
	getterconst_func(getOverdose,0);
	var(isOverdosed,false);
	
	getterconst_func(getColor,"#000000");

region(non-usable vars)
	// ------- DO NOT USE OR CHANGE THIS DEFINES
	var(chilling_products,[]); //продукты которые выделятся в результате заморозки
	var(chilling_point,null); //температура прехода в холодное состояние. Если null то охлаждения не произойдёт
	var(chilling_message,""); //сообщение которое выведется при охлаждении
	
	var(heating_products,[]); //продукты которые выделятся в результате нагрева
	var(heating_point,null);
	var(heating_message,"");
	// ------- 

region(initializers)
	func(constructor)
	{
		objParams();
		INC(reagentSystem_count_destroyed);
	};

	func(destructor)
	{
		objParams();
		INC(reagentSystem_count_destroyed);
	};

region(common funcs)

	//этот метод вызывается при контакте с реагентом. Типы контактов TOUCH, INGEST, INJECT
	//сам метод вызывается на холдере реагентов
	func(reactionOnMob)
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
				callFuncParams(getVar(_mob,reagents),addReagent,callSelf(getId) arg getSelf(volume)/2);
			};
		};
		
		true
	};
	
	//это событие вызвается при контакте объекта с реагентом. 
	//например добавив предмет к реагенту получится взрыв или подобное..
	func(reactionOnObj)
	{
		objParams_2(_obj,_volume);
		
	};

	func(onMob)
	{
		objParams_1(_mob);
		callFuncParams(getSelf(holder),removeReagent,callSelf(getId) arg callSelf(getMetabolizeRate));
	};

	//called after addReagents creates a new reagent
	//Вызывается если data не null
	func(onNew)
	{
		objParams_1(_data);
	};

	// Called when two reagents of the same are mixing.
	//вызывается в addReagent когда даты объединяются
	func(onMerge)
	{
		objParams_1(_data);
	};

	//вызывается при удалении реагента
	func(onRemove)
	{
		objParams();
	};

	//Вызывается, если реагент превысил порог передозировки и настроен на запуск 
	//эффектов передозировки
	func(onOverdose)
	{
		objParams_1(_mob);
	};

endclass