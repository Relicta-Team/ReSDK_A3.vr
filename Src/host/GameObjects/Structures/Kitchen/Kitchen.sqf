// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(MeatGrinder) extends(IStruct)
	var(name,"Мясодавка");
	var(desc,"Пригодна для создания фарша или лапши.");
	var(model,"ml\ml_object_new\model_24\press.p3d");
	
	var(source,[]);
	getterconst_func(getMaxCountSource,5);
	var(output,[]);
	getterconst_func(getMaxCountOutput,5);
	
	func(getDescFor)
	{
		objParams_1(_usr);
		callSuper(IStruct,getDescFor) + callSelf(getAdditionalDesc);
	};
	
	func(getAdditionalDesc)
	{
		objParams();
		private _txt = "";
		if (count getSelf(source) > 0) then {
			_txt = "Сверху: " + str count getSelf(source);
		};
		if (count getSelf(output) > 0) then {
			if (_txt != "") then {MOD(_txt, + sbr)};
			MOD(_txt, + "Прокручено: " + str count getSelf(output));
		};
		if (_txt != "") then {_txt = sbr + _txt};
		_txt
	};
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		
		if (callSelf(getMaxCountSource) > (count getSelf(source))) then {
			callFuncParams(_with,moveItem,this);
		} else {
			callFuncParams(_usr,localSay,"Сначала прокрутить бы..." arg "mind");
		};	
	};
	getter_func(getMainActionName,"Крутить");
	func(onMainAction)
	{
		objParams_1(_usr);
		if (count getSelf(source) > 0) then {
			if (callSelf(getMaxCountOutput) == ((count getSelf(output)))) exitWith {
				callFuncParams(_usr,localSay,"Не поддаётся. Надо сначала вытащить прокрученное." arg "error");
			};
			private _srclist = getSelf(source);
			private _itm = _srclist deleteAt ((count _srclist) - 1);
			private _newItm = callSelfParams(getMincedItem,_itm);
			
			_newItm1 = instantiate(_newItm);
			_newItm2 = instantiate(_newItm);
			setVar(_newItm1,loc,this);
			getSelf(output) pushBack _newItm1;
			setVar(_newItm2,loc,this);
			getSelf(output) pushBack _newItm2;

			delete(_itm);
			private _mes = pick ["кряхтит.","работает.","крутит кушанья.","вертит яства."];
			callSelfParams(worldSay,callSelf(getName) + " " +_mes arg "info");
			callSelfParams(playSound,"reagents\canopen" arg getRandomPitch);
			
		} else {
			callFuncParams(_usr,localSay,"Там нечего прокручивать." arg "mind");
		};	
	};
	
	func(onClick)
	{
		objParams_1(_usr);
		if (count getSelf(output) > 0) then {
			callFuncParams(getSelf(output) select 0,moveItem,_usr);
		} else {
			callFuncParams(_usr,localSay,"Там ничего нет." arg "mind");
		};
	};
	
	#define isclass(type) equals(callFunc(_item,getClassName),'type')
	
	func(getMincedItem)
	{
		objParams_1(_item);
		if isclass(MeatChopped) exitWith {"MeatMinced"};
		if isclass(Testo) exitWith {"Lapsha"};
		"Item"
	};
	
	func(canMoveInItem)
	{
		objParams_1(_item);
		(isclass(MeatChopped) || isclass(Testo))
	};
	
	func(canMoveOutItem)
	{
		objParams_1(_item);
		(count getSelf(output)) > 0
	};
	
	func(onMoveInItem)
	{
		objParams_1(_item);
		getSelf(source) pushBack _item;
		setVar(_item,loc,this);
	};
	
	func(onMoveOutItem)
	{
		objParams_1(_item);
		getSelf(output) deleteAt (getSelf(output) find _item)
	};
	
endclass


class(BlackSmallStove) extends(ILightibleStruct)
	var(name,null);
	var(desc,null);
	getterconst_func(getName,"Печь");
	getterconst_func(getDesc,"Используется для приготовления пищи.");
	var(model,"ml_shabut\pechka\pechechkas.p3d");
	getterconst_func(isFireLight,true);
	var(light,LIGHT_BAKE);
	var(lightIsEnabled,true);
	
	getterconst_func(canUseAsCraftSpace,true);
	getterconst_func(getAllowedCraftCategories,[CRAFT_CATEGORY_FOOD]);
	
	var_array(recipeIdList); //сюда кешируется список айди рецептов для печки
	
	var_array(input); //что внутри
	getterconst_func(maxInput,6);
	var_num(lastPuttedItemTime); //момент когда положили последнюю еду
	var_num(cookedTime); //время когда будет проход по крафтам

	
	autoref var(handleUpdate,-1);//обновление метода
	
	getter_func(canUseMainAction,getSelf(lightIsEnabled) && super());
	getter_func(getMainActionName,"Затушить");
	func(onMainAction) {
		objParams_1(_usr);
		if getSelf(lightIsEnabled) then {
			callSelfParams(lightSetMode,false);
		};
	};
	
	//Получает список рецептов под печь при помощи рефлексии типов
	func(getAllBakeRecipes)
	{
		objParams();
		
		private _result = getSelf(recipeIdList);
		
		if (count _result > 0) exitWith {_result};
		
		private _list = null;
		private _typeListString = getAllObjectsTypeOf(CFoodBaker);
		private _typeObj = null;
		{
			_typeObj = typeGetFromString(_x);
			
			// !!! unsafe context !!!
			_list = ([nullPtr,_typeObj] call typeGetVar(_typeObj,getRefListFromType));
			// !!! unsafe context end !!!
			
			if (count _list > 0) then {
				_result pushBack (getVar(_list select 0,recipeId));
			};	
		} foreach _typeListString;
		
		_result
	};
	

	//Цикл проверки всех допустимых крафтов
	func(passCrafts)
	{
		objParams_1(_usr);
		FHEADER;
		{
			if ([/*_usr*/ nullPtr,this,_x] call craft_tryCraft_internal) exitWith {
				RETURN(true);
			};
		} foreach callSelf(getAllBakeRecipes);
		
		false
	};
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		if callFunc(_with,isFireLight) exitWith {
			private _isSrcLightEnabled = getSelf(lightIsEnabled);
			private _isWithLightEnabled = getVar(_with,lightIsEnabled);

			//поджигаем то с чем взаимодействуем
			if (!_isWithLightEnabled && _isSrcLightEnabled) exitWith {
				callFuncParams(_with,lightSetMode,true);
			};

			//поджигаем этот предмет
			if (_isWithLightEnabled && !_isSrcLightEnabled) exitWith {
				callSelfParams(lightSetMode,true);
			};
		};
		if callFunc(_with,isFood) exitWith {
			callFuncParams(_with,moveItem,this);
		};	
	};
	
	func(onClick)
	{
		objParams_1(_usr);
		
		private _cnt = count getSelf(input);
		if (_cnt > 0) then {
			callFuncParams(getSelf(input) select (_cnt - 1),moveItem,_usr);
		};	
	};
	
	func(getCookingTime)
	{
		objParams();
#ifdef EDITOR
		5
#else
		randInt(40,120);
#endif
	};
	
	func(constructor)
	{
		objParams();
		if getSelf(lightIsEnabled) then {
			callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
		};
	};
	
	func(lightSetMode)
	{
		objParams_1(_mode);
		if (callSuper(ILightibleStruct,lightSetMode)) then {
			if (_mode) then {
				callSelfParams(playSound, "fire\torch_on" arg rand(0.8,1.8));
				callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
				
				//сброс времени готовки
				setSelf(cookedTime,tickTime + callSelf(getCookingTime));
			} else {
				callSelfParams(stopUpdateMethod,"handleUpdate");
				callSelfParams(playSound, "fire\torch_off" arg getRandomPitch);
			};
			true
		} else {
			false
		};
	};
	
	var_num(lastDoneCookingTime);
	var_bool(__lockCooking);//выключает готовку если что-то приготовилось
	getter_func(canPrintDoneCookingMessage,false);
	
	func(onDoneCooking)
	{
		objParams();
		private _rand = pick ["А пахнет как...","Вкуснятинкой пахнет.","От этого запаха аж слюнки текут!"];
		callSelfParams(worldSay,_rand arg "mind");
		
		setSelf(lastDoneCookingTime,tickTime + randInt(10,40));
	};
	
	func(onUpdate)
	{
		updateParams();
		
		if getSelf(__lockCooking) exitWith {
			if (tickTime >= getSelf(lastDoneCookingTime)) then {
				callSelf(onDoneCooking);
			};	
		};
		
		if (tickTime >= getSelf(cookedTime)) then {
			if (count getSelf(input) > 0) then {
				private _isCrafted = callSelf(passCrafts);
				if (_isCrafted) then {
					setSelf(__lockCooking,true);
				} else {
					//сброс времени готовки
					setSelf(cookedTime,tickTime + callSelf(getCookingTime));
				};
			};
		};
	};
	
	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = callSuper(ILightibleStruct,getDescFor);
		if (count getSelf(input) > 0) then {
			MOD(_txt, + sbr + "Внутри " + str count getSelf(input) + " чего-то.");
		};
		if !getSelf(lightIsEnabled) exitWith {_txt};
		
		if (count getSelf(input) > 0) then {
			private _timeLeft = getSelf(cookedTime) - tickTime;
			if (_timeLeft > 60) exitWith {MOD(_txt, + sbr + "Там ещё готовится...")};
			if (_timeLeft >= 20) exitWith {MOD(_txt, + sbr + "Что-то скоро приготовится.")};
			if (_timeLeft <= 0) exitWith {MOD(_txt, + sbr + "ПОРА ВЫНИМАТЬ!")};
			MOD(_txt, + sbr + "Почти готово!");
		};
		
		_txt;
	};
	
	func(canMoveInItem)
	{
		objParams_1(_item);
		callFunc(_item,isFood) && !isTypeOf(this,SaltShaker) && count getSelf(input) < callSelf(maxInput)
	};
	
	func(canMoveOutItem)
	{
		objParams_1(_item);
		count getSelf(input) > 0
	};
	
	func(onMoveInItem)
	{
		objParams_1(_item);
		getSelf(input) pushBack _item;
		setVar(_item,loc,this);
		setSelf(lastPuttedItemTime,tickTime);
		setSelf(cookedTime,tickTime + callSelf(getCookingTime));
		setSelf(lastDoneCookingTime,0);
	};
	
	func(onMoveOutItem)
	{
		objParams_1(_item);
		setSelf(__lockCooking,false); //сброс лока готовки
		getSelf(input) deleteAt (getSelf(input) find _item);
		setSelf(lastDoneCookingTime,0);
	};
	
endclass

// !!!WARNING!!! связано с Campfire
class(SmallStoveGrill) extends(ILightibleStruct)
	
	#include "..\..\Interfaces\IConnectibleSource.Interface"
	getterconst_func(allowedConnectItems,["Kastrula" arg "FryingPan"]);
	var(connectedItems,[nullPtr]);
	getterconst_func(getConnectionOffset,[ICONSRC_POSDAT(vec3(0.05,-0.1,0.43),0,vec3(0,0,1))]);
	
	var(name,null);
	getterconst_func(getName,"Печка");
	var(model,"ml_shabut\pechka\pechka.p3d");
	
	getterconst_func(isFireLight,true);
	var(light,LIGHT_BAKESTOVE);
	var(lightIsEnabled,true);
	
	getterconst_func(canUseAsCraftSpace,true);
	getterconst_func(getAllowedCraftCategories,[CRAFT_CATEGORY_FOOD]);
	
	
	var(handleUpdate,-1);

	func(getDescFor)
	{
		objParams_1(_usr);
		private _desc = callSuper(ILightibleStruct,getDescFor);

		_desc
	};

	func(lightSetMode)
	{
		objParams_1(_mode);

		private _success = callSuper(ILightibleStruct,lightSetMode);

		if (_success) then {
			
			//trigger work mode
			callSelfParams(setTriggerEnalbe,_mode);

			if (_mode) then {
				callSelfParams(playSound, "fire\torch_on" arg rand(0.8,1.8));
				callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
			} else {
				callSelfParams(playSound, "fire\torch_off" arg getRandomPitch);
				callSelfParams(stopUpdateMethod,"handleUpdate");
			};
		};

		_success
	};

	func(constructor)
	{
		objParams();
		
		if getSelf(lightIsEnabled) then {
			callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
		};
		
	};

	func(onUpdate)
	{
		updateParams();
		if getSelf(lightIsEnabled) then {
			_cookingCont = getSelf(connectedItems) select 0;
			if (!isNullObject(_cookingCont)) then {
				callFunc(_cookingCont,onUpdate);
			};
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		if callFunc(_with,isFireLight) exitWith {
			private _isSrcLightEnabled = getSelf(lightIsEnabled);
			private _isWithLightEnabled = getVar(_with,lightIsEnabled);

			//поджигаем то с чем взаимодействуем
			if (!_isWithLightEnabled && _isSrcLightEnabled) exitWith {
				callFuncParams(_with,lightSetMode,true);
			};

			//поджигаем этот предмет
			if (_isWithLightEnabled && !_isSrcLightEnabled) exitWith {
				callSelfParams(lightSetMode,true);
			};
		};
		

		callSelfParams(connectItem,_with);
		
	};
	getter_func(canUseMainAction,getSelf(lightIsEnabled) && super());
	getter_func(getMainActionName,"Затушить");
	func(onMainAction) {
		objParams_1(_usr);
		if getSelf(lightIsEnabled) then {
			callSelfParams(lightSetMode,false);
		};
	};
endclass