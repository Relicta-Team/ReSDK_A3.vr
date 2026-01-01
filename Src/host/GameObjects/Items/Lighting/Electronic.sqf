// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\..\text.hpp>
#include "..\..\GameConstants.hpp"
#include <..\..\..\NOEngine\NOEngine.hpp>
#include <..\..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>


class(Flashlight) extends(ILightible)
	var(name,"Фонарик");
	var(desc,"Собираются народными умельцами.");
	var(light,"SLIGHT_LEGACY_FLASHLIGHT" call lightSys_getConfigIdByName);
	var(lightIsEnabled,false);
	var(size,ITEM_SIZE_SMALL);
	var(dr,2);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(weight,gramm(315));
	var(model,"relicta_models\models\nocategory\flashlight.p3d");
	var(material,"MatSynt");
	var(icon,invicon(flashlight));
	var(allowedSlots,[INV_BELT]);

	var(handler,-1);

	getter_func(getHandAnim,ITEM_HANDANIM_FLASHLIGHT);

	var(energySource,nullPtr);
	var(energyUsage,0.32); //сколько энергии тратися за секунду
	//Минутная формула вычисления работы: 100 * 1 / 0.32 [/ 60] . без скобок в секундах
		getter_func(isEnabled,getSelf(lightIsEnabled));
		getter_func(hasEnergySource,not_equals(getSelf(energySource),nullPtr));

	func(getWeight)
	{
		objParams();
		super + ifcheck(isNullReference(getSelf(energySource)),0,callFunc(getSelf(energySource),getWeight));
	};


	//интеракция батарейки с фонариком
	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		callFuncParams(_with,moveItem,this);
	};

	func(canMoveInItem)
	{
		objParams_1(_item);
		private _cond = callSuper(ILightible,canMoveInItem);
		_cond && !callSelf(hasEnergySource) && isTypeOf(_item,SmallBattery)
	};

	func(canMoveOutItem)
	{
		objParams_1(_item);
		callSelf(hasEnergySource)
	};

	func(onMoveInItem)
	{
		objParams_1(_item);
		setVar(_item,loc,this);
		setSelf(energySource,_item);
		callFunc(_item,onChangeLoc);
		callSelf(onWeightChanged);
	};

	func(onMoveOutItem)
	{
		objParams_1(_item);
		setSelf(energySource,nullPtr);
		callSelf(onWeightChanged);
		if (callSelf(isEnabled)) then {
			callSelf(fullDisableThread);
		};
	};

	func(connectBattery)
	{
		objParams_1(_with);


		setSelf(energySource,_with);

		//reconnect loc
		private _oldLoc = getVar(_with,loc);
		private _oldSlot = getVar(_with,slot);
		private _isSlot = _oldSlot != -1;
		if (isTypeOf(_oldLoc,Mob) && _isSlot) then {
			callFuncParams(_oldLoc,removeItemOnSlot,_oldSlot arg this);
		};
		if not_equals(getVar(_with,loc),this) then {
			setVar(_with,loc,this);
		};

		callSelf(onWeightChanged);
	};

	func(onItemClick)
	{
		objParams_1(_usr);

		if callSelf(hasEnergySource) then {
			callFuncParams(getSelf(energySource),moveItem,_usr);
		};
	};
	getter_func(getMainActionName,ifcheck(edIsEnabled,"Выключить","Включить"));
	func(onMainAction)
	{
		objParams_1(_usr);
		if (callSelf(isEnabled)) then {
			//выключить
			callSelf(fullDisableThread);

		} else {
			//включить
			if (callSelf(hasEnergySource)) then {

				private _src = getSelf(energySource);

				if (getVar(_src,energy) <= 0) exitWith {
					private _mes = pick ["А заряда и нету.","Совсем разрядилось.","Разряжено."];
					callFuncParams(_usr,localSay,_mes arg "error");
				};

				callSelfParams(lightSetMode,true);
				setSelf(handler,startSelfUpdate(onUpdate));INC(oop_upd);

			} else {
				private _mes = pick ["Сначала-бы батарейку.","Батарейки нету.","Без батарейки не будет работать."];
				callFuncParams(_usr,localSay,_mes arg "error");
			};
		};
	};

	func(onUpdate)
	{
		updateParams();

		private _ensrc = getSelf(energySource);
		if (isNullObject(_ensrc)) exitWith {
			callSelf(fullDisableThread);
		};
		private _curEnergy = getVar(_ensrc,energy);
		if (_curEnergy <= 0) exitWith {
			callSelf(fullDisableThread);
		};
		private _needEnergy = getSelf(energyUsage);
		MOD(_curEnergy,- _needEnergy);

		if (_curEnergy <= 0) then {
			callSelf(fullDisableThread);
			_curEnergy = _curEnergy max 0;
		};

		setVar(_ensrc,energy,_curEnergy);
	};

	//Полное выключение потока
	func(fullDisableThread)
	{
		objParams();
		stopUpdate(getSelf(handler));DEC(oop_upd);
		setSelf(handler,-1);
		callSelfParams(lightSetMode,false);
	};

	func(getDescFor)
	{
		objParams_1(_usr);

		private _desc = callSuper(ILightible,getDescFor);

		if (callSelf(hasEnergySource)) then {
			_desc = _desc + sbr + callFunc(getSelf(energySource),getEnergyInfo);
		};

		_desc
	};

endclass

class(FlashlightLoaded) extends(Flashlight)
	func(constructor)
	{
		objParams();
		callSelfParams(connectBattery,new(SmallBattery));
	};
endclass

class(SmallBattery) extends(Item)
	var(name,"Батарейка");
	var(desc,"Источник энергии.");
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(95));
	var(model,"a3\structures_f_epa\items\electronics\battery_f.p3d");
	var(material,"MatMetal");
	var(icon,invicon(smallbattery));
	var(energy,100);

	func(getEnergyInfo)
	{
		objParams();
		format["Заряд: %1%2",getSelf(energy),"%"];
	};

	func(getDescFor)
	{
		objParams_1(_usr);

		private _desc = callSuper(Item,getDescFor);
		_desc = _desc + sbr + callSelf(getEnergyInfo);
		_desc
	};

endclass
