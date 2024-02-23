// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================




class(CFoodBase) extends(Craft_Base)
	var(categoryName,CRAFT_CATEGORY_TO_NAME(CRAFT_CATEGORY_FOOD));
	var(categoryID,CRAFT_CATEGORY_FOOD);
endclass

class(CFryingPan) extends(CFoodBase)
	var(collectNearItemsDistance,0.45);
	func(hasVisible)
	{
		objParams();
		if (callFunc(src,getClassName) != "FryingPan") exitWith {false};
		if (!callFunc(src,isConnectedToSource)) exitWith {false};
		true
	};
	
	func(canCraft)
	{
		objParams();
		super() && !getVar(src,isCooked) && callFunc(src,isConnectedToSource)
	};
	
	var(doStartCooking,true); //
	var(isCustomGiver,false); //для выдачи в тарелку
	//через сколько сготовится
	func(getCookingTime)
	{
		objParams();
		randInt(30,60*2);
	};
	
	func(onCraftSuccess)
	{
		objParams();
		//removing all items
		callSelf(DeleteItemSTD);
		
		if getSelf(doStartCooking) then {
			private _time = callSelf(getCookingTime);
			#ifdef EDITOR
			_time = 5;
			#endif
			callFuncParams(src,startCookingProcess,_time);
			
			if getSelf(isCustomGiver) then {
				setVar(src,isCookingResultAsItem,false);
				callFuncParams(src,addDish,getSelf(name) arg getSelf(resultAmount));
			} else {
				setVar(src,isCookingResultAsItem,true);
				for "_c" from 1 to getSelf(resultAmount) do {
					callFuncParams(src,addItemContent,instantiate(getSelf(resultItem)));
				};
			};

		};	
	};
	
	
endclass

class(CKastrula) extends(CFoodBase)
	
	func(hasVisible)
	{
		objParams();
		if (callFunc(src,getClassName) != "Kastrula") exitWith {false};
		if (!callFunc(src,isConnectedToSource)) exitWith {false};
		true
	};
	
endclass

// Печка. Внимание внутри методов рецептов печки usr будет возвращать nullPtr так как печка сама перебирает возможные крафты
// !!!Внимание!!! При наследовании от этого класса более простые рецепты должны быть определены позже чем рецепты с более сложными частями
// Из-за того, что в печи делается проход по всем рецептам, рецепты с большим количеством ингредиентов могут не прокнуть.
// Порядок проверки рецептов по очереди определения
class(CFoodBaker) extends(CFoodBase)

	func(hasVisible)
	{
		objParams();
		if (callFunc(src,getClassName) != "BlackSmallStove") exitWith {false};
		true
	};
	
	func(collectItems)
	{
		objParams();
		getVar(src,input);
	};
	
	func(onCraftSuccess)
	{
		objParams();
		private _input = getVar(src,input);
		{
			_input deleteAt (_input find _x);
			delete(_x);
		} forEach array_copy(collectedItems); //copy list
		
		private _item = instantiate(getSelf(resultItem));
		_input pushBack _item;
		setVar(_item,loc,src);
	};

endclass

// FryingPan crafts
region(FryingPan)

	class(CFryingPan_Bibki) extends(CFryingPan)
		var(name,"Бибки");
		var(reqItems,[vec2("Testo",1) arg vec2("Egg",1)]);
		var(resultItem,"Bun");
		var(resultAmount,3);
	endclass

	class(CFryingPan_Pancakes) extends(CFryingPan)
		var(name,"Блинцы");
		var(reqItems,[vec2("Lepeshka",1) arg vec2("Egg",1)]);
		var(resultItem,"Pancakes");
		var(resultAmount,1);
	endclass

	//котлетки требуют 5 еденичек соли
	class(CFryingPan_Cutlets) extends(CFryingPan)
		var(name,"Котлетки");
		var(reqItems,[vec2("MeatMinced",2) arg vec2("SaltShaker",1)]);
		var(resultItem,"Cutlet");
		var(resultAmount,5);
		
		var(haveSalt,false);
		
		func(canCraft)
		{
			objParams();
			private _salt = collectedItems findif {callFunc(_x,getClassName) == "SaltShaker"};
			private _canRemSalt = false;
			if (_salt != -1) then {
				_salt = collectedItems select _salt;
				_canRemSalt = callFunc(_salt,getFilledSpace) >= 5;
			};
			setSelf(haveSalt,_canRemSalt);
			super() && _canRemSalt
		};
		
		func(conditionalDeleteSTD)
		{
			objParams_1(_obj);
			if isTypeOf(_obj,SaltShaker) exitWith {
				callFuncParams(_obj,removeReagents,5);
				false;
			};
			true;
		};
		
		func(onCraftFail)
		{
			objParams();
			callFuncParams(usr,localSay,"Не хватает соли." arg "mind");
		};
		
	endclass

	// class(Spureshkay) extends(CFryingPan)
	// 	var(name,"Котлетки с пюрешкой");
	// 	var(reqItems,[vec2("BakedPotato",5) arg vec2("Cutlet",5)]);
	// 	var(resultAmount,6); //порции
	// 	var(isCustomGiver,true);
	// endclass



//Kastrula class
region(Kastrula)

	class(CKastrula_Nekachsoup) extends(CKastrula)
		var(name,"Некашлиновый суп");
		var(desc,"Дополнительно: яйцо или крысу");
		var(reqItems,[vec2("Lapsha",2)]);
		
		func(handleAdditionalItems)
		{		
			objParams_1(_list);
			
			modSelf(allReqItemsAmount, + 1); //нужно яичко или крыса
			
			{
				if (callFunc(_x,getClassName) == "Egg") exitWith {
					collectedItems pushBack _x;
				};	
			} foreach _list;
		};
		
	endclass

//bake food
region(FoodBake)

	class(CFoodBaker_Shavirma) extends(CFoodBaker)
		var(reqItems,[vec2("Lepeshka",1) arg vec2("Melteshonok",1)]);
		var(resultItem,"Shavirma");
	endclass
	
	class(CFoodBaker_Pie) extends(CFoodBaker)
		var(reqItems,[vec2("Testo",2) arg vec2("ButterPiece",1)]);
		var(resultItem,"Pie");
		var(desc,"Дополнительно 1 любой ингредиент");
		
		func(canCraft)
		{
			objParams();
			super() && !isNullObject(getSelf(mainIngredient))
		};
		
		//Основной ингредиент для пирога (начинка)
		var(mainIngredient,nullPtr);
		
		func(handleAdditionalItems)
		{
			objParams_1(_list);
			FHEADER;
			
			setSelf(mainIngredient,nullPtr);
			
			{
				if callFunc(_x,isFood) then {
					if (callFunc(_x,getFilledSpace) >= 5) then {
						setSelf(mainIngredient,_x);
						RETURN(0);
					};
				};
			} foreach _list;
		};
		
		func(onCraftSuccess)
		{
			objParams();
			private _input = getVar(src,input);
			{
				_input deleteAt (_input find _x);
				
			} forEach array_copy(collectedItems); //copy list
			
			private _item = instantiate(getSelf(resultItem));
			_input pushBack _item;
			setVar(_item,loc,src);
			
			setVar(_item,name,"Пирог """ + callFunc(getSelf(mainIngredient),getName) + """");
			{	
				if (callFunc(_x,getFilledSpace) > 0) then {
					callFuncParams(_x,transferTo,_item arg callFunc(_x,getFilledSpace));
				};		
				
				delete(_x);
			} foreach collectedItems;
			
			_input deleteAt (_input find getSelf(mainIngredient));
			delete(getSelf(mainIngredient));
		};
		
	endclass
	
	class(CFoodBaker_Bread) extends(CFoodBaker)
		var(reqItems,[vec2("Testo",1) arg vec2("Egg",2)]);
		var(resultItem,"Bread");
	endclass
	
	class(CFoodBaker_Omlet) extends(CFoodBaker)
		var(reqItems,[vec2("Egg",2) ]);
		var(resultItem,"Omlet");
	endclass
	
	class(CFoodBaker_LepFromTesto) extends(CFoodBaker)
		var(reqItems,[vec2("Testo",1)]);
		var(resultItem,"Lepeshka");
	endclass