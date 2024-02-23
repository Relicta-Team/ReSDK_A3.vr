// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(CuttingBoard) extends(Item)
	var(name,"Доска");
	var(desc,"Доска для резки всякого съедобного...");
	var(model,"ml_exodusnew\doskarez.p3d");
	var(weight,gramm(150));
	var(size,ITEM_SIZE_MEDIUM);
endclass
/*
	Новые правила готовки:
	
*/
class(FryingPan) extends(Item)
	#include "..\..\Interfaces\IConnectibleItem.Interface"

	getterconst_func(connectOffset,vec3(vec3(0,0,0.05),0,vec3(0,0,0)));

	var(name,"Сковородка");
	var(desc,"Ей можно выпрямить кому-нибудь лицо... ну или зажарить мельтешонка.");
	var(weight,1.45);
	var(size,ITEM_SIZE_MEDIUM);
	var(model,"ml_exodusnew\skovoroda.p3d");//"relicta_models\models\interier\props\kitchen\pan.p3d"
	
	var_num(cookingTime); //через сколько приготовится
	var_bool(isCookingProcess); //запущен ли процесс готовки
	var_bool(isCooked); //означате что блюдо готово и находится в источнике
	var_str(cookedName); //название готового блюда
	
	var_bool(isCookingResultAsItem); //если true то возвращается в виде итемов
	var(items,[]); //физические предметы
	var(resultReagent,new(IReagentItem)); //жижки
	var_num(amountServings); //количество порций
	
	getter_func(canUseAsCraftSpace,callSelf(isConnectedToSource));
	getter_func(getAllowedCraftCategories,[CRAFT_CATEGORY_FOOD]);
	verbList("craft",Item);
	
	func(onPickup)
	{
		objParams_1(_usr);
		callSuper(Item,onPickup);
		
		private _consrc = getSelf(connectibleSource);
		if !isNullObject(_consrc) then {
			callFuncParams(_consrc,onDisconnectItem,this);
		};
	};

	//временный фикс 
	func(canPickup)
	{
		objParams();
		
		private _super = super();
		if (!_super) exitwith {false};
		if (!isNullVar(__GLOBAL_FLAG_SPECACT_KICK__) && callSelf(isConnectedToSource)) exitwith {false};
		true
	};
	
	func(onConnectToSource)
	{
		objParams_1(_src);
		if isTypeOf(_src,Campfire) then {
			if getVar(_src,lightIsEnabled) then {
				
			};
		};
	};
	getter_func(canUseMainAction,getSelf(isCookingResultAsItem) && getSelf(isCooked) && count getSelf(items)>0 && super());
	getter_func(getMainActionName,"Забрать приготовленное");
	func(onMainAction)
	{
		objParams_1(_usr);
		
		if getSelf(isCookingResultAsItem) then {
			if getSelf(isCooked) then {
				private _items = getSelf(items);
				callFuncParams(_items select (count _items - 1),moveItem,_usr);
			};
		} else {
			
		};

	};	
	
	func(addItemContent)
	{
		objParams_1(_item);
		setVar(_item,loc,this);
		callFuncParams(_item,moveItem,this);
	};	
	
	func(addDish)
	{
		objParams_2(_dishName,_amountServings);
		setSelf(cookedName,_dishName);
		setSelf(amountServings,_amountServings);
	};
	
	func(onMoveInItem)
	{
		objParams_1(_item);
		getSelf(items) pushBack _item
	};
	
	func(onMoveOutItem)
	{
		objParams_1(_item);
		getSelf(items) deleteAt (getSelf(items) find _item);
		if (count getSelf(items) == 0) then {
			setSelf(isCooked,false);
		};	
	};
	
	func(startCookingProcess)
	{
		objParams_1(_time);
		setSelf(cookingTime,_time);
		setSelf(isCookingProcess,true);
	};
	
	func(onUpdate)
	{
		objParams();
		if getSelf(isCookingProcess) then {
			modSelf(cookingTime, - 1);
			if (getSelf(cookingTime) <= 0) then {
				setSelf(isCookingProcess,false);
				callSelf(onCooked);
			};
		};	
	};
	
	func(onCooked)
	{
		objParams();
		private _rmes = pick ["манит ароматом.","шкварчит.","испускает дивный аромат."];
		callSelfParams(worldSay, callSelf(getName) + " " + _rmes arg "info");
		setSelf(isCooked,true);
	};
	
	func(getDesc)
	{
		objParams();
		private _desc = callSuper(Item,getDesc);
		if (getSelf(isCookingResultAsItem)) then {
			if getSelf(isCooked) then {
				_desc = _desc + format[" В ней ещё лежит %1 кое-чего.",count getSelf(items)];
			} else {
				if !getSelf(isCookingProcess) exitWith {};
				_desc = "Там должно что-то приготовиться.";
			};
		};
		
		_desc
	};
	
	func(getDescFor)
	{
		objParams_1(_usr);
		private _d = callSuper(Item,getDescFor);
		if getSelf(isCookingProcess) then {
			if (callFunc(_usr,getCooking) > 2) then {
				_d = _d + sbr + "Приготовится через: " + formatTime(getSelf(cookingTime));
			};	
		};
		_d
	};
	
	func(getName)
	{
		objParams();
		if (getSelf(isCooked) && !getSelf(isCookingResultAsItem)) then {getSelf(cookedName)} else {callSuper(Item,getName)};
	};
	
endclass

class(Polovnik) extends(Item)
	var(name,"Половник");
	var(model,"relicta_models\models\interier\props\kitchen\ladle.p3d");
	
	
	#include "..\..\Interfaces\INetDisplay.Interface"

	var(ndName,"MessageBox");
	var(ndInteractDistance,INTERACT_DISTANCE);
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
	};
	
	func(getNDInfo)
	{
		objParams();
		[]
	};
	
	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);
	};
	
endclass