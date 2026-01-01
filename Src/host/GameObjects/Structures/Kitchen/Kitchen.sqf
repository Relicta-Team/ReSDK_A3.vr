// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(MeatGrinder) extends(IStruct)
	var(name,"Фарширатор");
	var(desc,"Пригоден для создания фарша или лапши.");
	var(model,"ml\ml_object_new\model_24\press.p3d");
	var(material,"MatMetal");
	var(dr,3);
	getter_func(getMainActionName,"Крутить");
	var(craftComponentName,"OrganicGrinderSystem");
	
endclass


class(BlackSmallStove) extends(ILightibleStruct)
	var(name,"Печь");
	var(desc,"Используется для приготовления пищи.");
	var(model,"ml_shabut\pechka\pechechkas.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,50);
	var(dr,3);
	getterconst_func(isFireLight,true);
	var(light,"SLIGHT_LEGACY_BAKE" call lightSys_getConfigIdByName);
	var(lightIsEnabled,true);

	var(craftComponentName,"BakingOvenSystem");

	autoref var(handleUpdate,-1);//обновление метода
	getter_func(canUseMainAction,getSelf(lightIsEnabled) && super());
	getter_func(getMainActionName,"Затушить");
	func(onMainAction) {
		objParams_1(_usr);
		if getSelf(lightIsEnabled) then {
			callSelfParams(lightSetMode,false);
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
	func(onUpdate)
	{
		updateParams();
	};
	
endclass

// !!!WARNING!!! связано с Campfire
class(SmallStoveGrill) extends(ILightibleStruct)
	
	var(name,"Печка");
	var(model,"ml_shabut\pechka\pechka.p3d");
	var(material,"MatMetal");
	getterconst_func(getCoefAutoWeight,2.5);
	var(dr,3);
	
	getterconst_func(isFireLight,true);
	var(light,"SLIGHT_LEGACY_BAKESTOVE" call lightSys_getConfigIdByName);
	var(lightIsEnabled,true);
	
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
		if getSelf(lightIsEnabled) then {};
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

class(KitchenStove) extends(SmallStoveGrill)
	var(name,"Дружковка");
	var(desc,"Используется для приготовления пищи.")
	var(model,"ml_exodusnew\stalker_tun\plita.p3d");
endclass