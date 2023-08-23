// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\..\client\LightEngine\LightEngine.hpp>
#include <..\..\GameConstants.hpp>
#include <..\..\..\text.hpp>

class(ICampfireStruct) extends(ILightibleStruct)
	#include "..\..\Interfaces\IConnectibleSource.Interface"
	getterconst_func(allowedConnectItems,["Kastrula" arg "FryingPan"]);
	var(connectedItems,[nullPtr]);
	
	#include "..\..\Interfaces\ITrigger.Interface"
	//attributeParams(hasField,"tDistance" arg "tDelay" arg "tCallDelay");
	var(tDistance,0.55);
	var(tDelay,0.8);
	var(tCallDelay,0);
	
	
	func(onTriggerActivated)
	{
		objParams_1(_usr);
		
		//призраки не горят...
		if isTypeOf(_usr,MobGhost) exitWith {};
		//От потушенного костра не будет урона
		if !getSelf(lightIsEnabled) exitWith {};
		
		//callFuncParams(_usr,localSay,"жжётся!!!" arg "mind");
		private _dam = D6 - 1;
		callFuncParams(_usr,applyDamage,_dam arg DAMAGE_TYPE_BURN arg callFunc(_usr,pickRandomTargZone) arg DIR_RANDOM);
		if prob(35) then {
			private _m = pick["палится","горит","жарится"];
			callFuncParams(_usr,meSay,_m +".");
		};

	};	
	
endclass

// !!!WARNING!!! связано с SmallStoveGrill
class(Campfire) extends(ICampfireStruct)
	
	var(connectedItems,[nullPtr]);
	getterconst_func(getConnectionOffset,[ICONSRC_POSDAT(vec3(0,0,0.05),0,vec3(0,0,1))]);// смещение объектов присоединения

	var(name,"Костёр");
	var(desc,"Главный источник тепла и света.");
	var(light,LIGHT_CAMPFIRE);
	var(model,"a3\structures_f\civ\camping\fireplace_f.p3d");
	getterconst_func(isFireLight,true);

	var(fuelLeft,60 * 25); //сколько топлива осталось
	var(handleUpdate,-1);

	func(getDescFor)
	{
		objParams_1(_usr);
		private _desc = callSuper(ILightibleStruct,getDescFor);
		private _fleft = getSelf(fuelLeft);
		if (_fleft > 0 && _fleft <= 30) then {_desc = _desc + sbr + "Он совсем скоро потухнет"};
		if (_fleft == 0) then {MOD(_desc, + sbr + "Там не осталось чему гореть")};

#ifdef DEBUG
		_desc = _desc + sbr + "ОСТАЛОСЬ: " + formatTime(_fleft);
#endif

		_desc
	};

	func(lightSetMode)
	{
		objParams_1(_mode);
		if (_mode && getSelf(fuelLeft) == 0) exitWith {
			if !isNullVar(_usr) then {
				callFuncParams(_usr,localSay,pick vec3("Нужно подкинуть дровишек","Гореть-то нечему уже","Нужно закинуть туда того"+comma+" что будет гореть") arg "error");
			};
		};

		private _success = callSuper(ILightibleStruct,lightSetMode);

		if (_success) then {
			
			//trigger work mode
			callSelfParams(setTriggerEnalbe,_mode);
			
			//с доп проверкой если инфинити источник
			if (_mode) then {
				callSelfParams(playSound, "fire\torch_on" arg rand(0.8,1.8));
				if (getSelf(fuelLeft) == -1) exitWith {};
				callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
			} else {
				callSelfParams(playSound, "fire\torch_off" arg getRandomPitch);
				if (getSelf(fuelLeft) == -1) exitWith {};
				callSelfParams(stopUpdateMethod,"handleUpdate");
			};
		};

		_success
	};

	func(constructor)
	{
		objParams();
		if (getSelf(fuelLeft) != -1) then {
			if getSelf(lightIsEnabled) then {
				callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
			};
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
		modSelf(fuelLeft,-1);
		if (getSelf(fuelLeft) == 0) exitWith {
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
		
		if isTypeOf(_with,IPaperItemBase) exitWith {
			callFuncParams(_with,doBurn,this arg _usr);
		};
		
		if (callSelf(getClassName) == "Campfire" || callSelf(getClassName) == "CampfireDisabled") then {
			callSelfParams(connectItem,_with);
		};
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

class(CampfireBig) extends(Campfire)
	var(name,"Большой костёр");
	var(desc,"Он достаточно хорошо закидан различными горящими материалами, что позволит осветить и согреть окружение на долгий срок.");
	var(light,LIGHT_CAMPFIRE_BIG);
	var(model,"ml_shabut\drova\pepelishe.p3d");
	var(fuelLeft,-1);
	//getterconst_func(allowedConnectItems,[]);
	getter_func(canConnect,false);
endclass

editor_attribute("EditorGenerated")
class(BarrelCampfireBig) extends(CampfireBig)
	var(model,"a3\props_f_enoch\military\garbage\garbagebarrel_02_buried_f.p3d");
	var(name,"Костёр в бочке");
endclass

class(CampfireDisabled) extends(Campfire)
	var(lightIsEnabled,false);
endclass

class(CampfireBigDisabled) extends(CampfireBig)
	var(lightIsEnabled,false);
endclass