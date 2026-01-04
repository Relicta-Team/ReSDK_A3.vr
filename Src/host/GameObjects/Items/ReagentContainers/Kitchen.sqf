// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>
#include <..\..\..\MatterSystem\MatterSystem.hpp>



class(Kastrula) extends(IReagentNDItem)
	
	#include "..\..\Interfaces\IConnectibleItem.Interface"
	getterconst_func(connectOffset,vec3(vec3(0,0,0.05),0,vec3(0,0,0)));
	
	var_num(cookingTime); //через сколько приготовится
	var_bool(isCooked);
	var_str(cookedNamePostfix); //постфикс чего там внутри
	
	var(name,"Кастрюля");
	//"ml\ml_object_new\shabbat\kostrylya_2.p3d" CHANGE MODEL AND REMOVE OTHERS
	var(model,"relicta_models\models\interier\props\kitchen\kastryla.p3d");
	var(material,"MatMetal");
	getter_func(getDropSound,"dropping\potspans_" + (str randInt(1,4)));
	var(allowedSlots,[INV_HEAD]);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(700));
	var(dr,3);
	//var(reagents,vec3(this,60,[vec2("Water",50)]) call ms_create);
	var(reagents,vec3(this,1000,[vec2("Water",50) arg vec2("Gribicin",50)]) call ms_create);
	
	getterconst_func(transferAmount,[20 arg 30 arg 60]);
	
	func(onEquip) {
		objParams_1(_usr);
		callSuper(IReagentNDItem,onEquip);
		callFuncParams(_usr,changeVisionBlock,+1 arg "itmeq");
	};
	
	func(onUnequip) {
		objParams_1(_usr);
		callSuper(IReagentNDItem,onUnequip);
		callFuncParams(_usr,changeVisionBlock,-1 arg "itmuneq");
	};

	func(onPickup)
	{
		objParams_1(_usr);
		callSuper(IReagentNDItem,onPickup);
		
		private _consrc = getSelf(connectibleSource);
		if !isNullObject(_consrc) then {
			callFuncParams(_consrc,onDisconnectItem,this);
		};
	};
	
	func(onConnectToSource)
	{
		objParams_1(_src);
		callSuper(IReagentNDItem,onConnectToSource);
		
		if isTypeOf(_src,Campfire) then {
			if getVar(_src,lightIsEnabled) then {
				
			};
		};
		
		callSelf(calculateCookingTime);
		setSelf(isCooked,false);	
	};
	
	func(calculateCookingTime)
	{
		objParams();
		private _additionalTime = rand(30,60*3);
		#ifdef EDITOR
		_additionalTime = 5;
		#endif
		
		if (callSelf(getFilledSpace) == 0) then {_additionalTime = +INFINITY};
		
		setSelf(cookingTime,tickTime + _additionalTime);
	};	
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Polovnik) then {
			private _filled = callSelf(getFilledSpace);
			callSelfParams(transferReagents,_with arg getVar(_with,curTransferSize));
			if not_equals(_filled,callSelf(getFilledSpace)) then {
				callSelfParams(playSound,"reagents\soupget" arg getRandomPitch);
				setVar(_with,soupName,getSelf(cookedNamePostfix));
			};
		};
	};
	
	func(calculateCookingPostfix)
	{
		objParams();
		private _postfix = "";
		private _stack = [];
		{
			if (_y > 5) then {
				_stack pushBack getMatterProp(_x,name);
				_stack pushBack "+";
			};
		} foreach callSelf(getReagents);
		if (count _stack > 0) then {
			_postfix = " (";
			if (count _stack > 2) then {
				_stack deleteAt (count _stack - 1);
				_stack set [(count _stack) - 2,"и"];
			} else {
				_stack deleteAt 1;
			};	
			setSelf(cookedNamePostfix,_postfix + (_stack joinString " ") + ")");
		} else {
			setSelf(cookedNamePostfix,"");
		};		
	};
	
	func(onDisconnectFromSource)
	{
		objParams_1(_src);
		callSuper(IReagentNDItem,onDisconnectFromSource);
	};
	
	func(onTransferReagents)
	{
		objParams();
		callSuper(IReagentNDItem,onTransferReagents);
		callSelf(calculateCookingTime);
		
		if getSelf(isCooked) then {setSelf(isCooked,false)};
	};
	
	func(onCooked)
	{
		objParams();
		private _mes = "Содержимое кастрюли закипело";
		
		private _isReacted = false;
		private _i = 1;
		while {_i <= 9999} do {
			if (callSelfParams(processReaction,REACTION_COOKING)) then {
				_isReacted = true;
			} else {
				break; //exit while loop
			};
		};
		if (_i > 5000) then {
			warningformat("Kastrula::onCooked() - Probably reaction logic error: %1",getSelf(reagents));
		};
		
		if (_isReacted) then {
			callSelf(calculateCookingPostfix);
			MOD(_mes,+ "!");
		} else {
			MOD(_mes, + comma + " но ничего не произошло.");
		};
		
		
		callSelfParams(worldSay,_mes arg "info");
	};
	
	func(getName)
	{
		objParams();
		private _name = callSuper(IReagentNDItem,getName);
		_name + (if getSelf(isCooked) then {getSelf(cookedNamePostfix)} else {""});
	};
	
endclass



class(SoupPlate) extends(IReagentNDItem)
	var(name,"Тарелка");
	var(desc,"Глубокая тарелка для супов и похлёбок.");
	var(model,"ml_exodusnew\tarelochka.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(600));
	var(soupName,"");
	
	func(getName)
	{
		objParams();
		private _name = callSuper(IReagentNDItem,getName);
		if (callSelf(getFilledSpace) > 0) then {
			_name = "Суп" + getSelf(soupName);
		};
		_name
	};
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,Polovnik) then {
			private _filled = callSelf(getFilledSpace);
			callFuncParams(_with,transferReagents,this arg getVar(_with,curTransferSize));
			if not_equals(_filled,callSelf(getFilledSpace)) then {
				callSelfParams(playSound,"reagents\soupget" arg getRandomPitch);
				setSelf(soupName,getVar(_with,soupName));
			};
		};
	};
	
endclass

//"relicta_models\models\interier\props\kitchen\vilka.p3d"

class(FoodPlate) extends(Container)
	var(name,"Тарелка");
	var(desc,"Эта тарелка предназначена для вторых блюд.");
	var(model,"relicta_models\models\interier\props\kitchen\plate.p3d");
	var(material,"MatGlass");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(200));
	var(dr,1);
endclass

class(Ashtray) extends(Container)
	var(name,"Пепельница");
	var(desc,"Окурки все сюда!");
	var(model,"ml_shabut\exodus\ashtray.p3d");
	var(material,"MatMetal");
	var(weight,gramm(130));
	var_exprval(countSlots,BASE_STORAGE_CAPACITY(1.4));
	var(size,ITEM_SIZE_SMALL);
	var(maxSize,ITEM_SIZE_SMALL);
endclass

// Cups

class(Cup) extends(IReagentNDItem)
	var(name,"Чашка");
	var(model,"relicta_models\models\interier\props\cup.p3d");
	var(material,"MatGlass");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(200));
	var(reagents,vec2(this,30) call ms_create);
	getterconst_func(transferAmount,[2 arg 5 arg 10 arg 20 arg 30]);
endclass

class(Cup1) extends(Cup)
	var(name,"Чашка");
	var(model,"ml_exodusnew\chashunka.p3d");
	var(material,"MatGlass");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(200));
	var(reagents,vec2(this,30) call ms_create);
	getterconst_func(transferAmount,[2 arg 5 arg 10 arg 20 arg 30]);
endclass

class(WoodenCup) extends(Cup)
	var(name,"Деревянная кружка");
	
	var(model,"relicta_models\models\interier\props\kitchen\woodcup.p3d");
	var(material,"MatWood");
	var(weight,gramm(330));
endclass

class(OlderWoodenCup) extends(WoodenCup)
	var(model,"ml\ml_object_new\model_24\kryjka.p3d");
endclass

class(MetalCup) extends(Cup)
	var(name,"Стальная чашка");
	var(model,"ml_shabut\furniture\chashka_rja.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(weight,gramm(500));
endclass
