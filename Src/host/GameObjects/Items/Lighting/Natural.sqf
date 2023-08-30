// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\..\text.hpp>
#include "..\..\GameConstants.hpp"
#include <..\..\..\NOEngine\NOEngine.hpp>
#include <..\..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>


editor_attribute("InterfaceClass")
class(ILightible) extends(Item)

	editor_attribute("EditorVisible" arg "custom_provider:scriptedlight")
	var(light,-1);

	editor_attribute("EditorVisible" arg "type:bool") editor_attribute("Tooltip" arg "Включен ли источник света")
	var(lightIsEnabled,true);
	getter_func(canLight,true);

	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		//private _o = callSuper(Item,InitModel);

		_vObj = createSimpleObject [getSelf(model),[0,0,0],true];
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_true;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		if getSelf(lightIsEnabled) then {
			_vObj setVariable ["light",getSelf(light)];
			MOD(_headerT,+lightObj_true);
			//create serverside light
			[_vObj,getSelf(light)] call slt_create;
		};

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};

	func(lightSetMode)
	{
		objParams_1(_mode);

		private _isEnabled = getSelf(lightIsEnabled);
		if (_isEnabled == _mode) exitWith {
			//this is not warning
			//warningformat("Instance of %1 already setted on %2",callSelf(getClassName) arg _mode);
			false;
		};

		setSelf(lightIsEnabled,_mode);

		private _vObj = getSelf(loc);
		if callSelf(isInWorld) then {
			if (_mode) then {
				[_vObj,CHUNK_TYPE_ITEM,getSelf(light)] call noe_registerLightAtObject;
			} else {
				[_vObj,CHUNK_TYPE_ITEM] call noe_unregisterLightAtObject;
			};

		} else {

			private _slot = getSelf(slot);
			if (_slot >= 0) then {
				callFuncParams(_vObj,syncSmdSlot,_slot);
			};
		};

		true;
	};

/*	func(lightAddEmitter)
	{
		objParams(); getSelf(loc) setvariable ['light',getSelf(light),true];
	};

	func(lightRemoveEmitter)
	{
		objParams(); getSelf(loc) setvariable ['light',null,true];
	};*/

endclass

class(TorchDisabled) extends(Torch)
	var(lightIsEnabled,false);
endclass

class(Torch) extends(ILightible)

	var(name,"Факел");
	var(desc,"Самый популярный источник освещения");
	var(model,"relicta_models\models\weapons\melee\torch.p3d");
	var(allowedSlots,[INV_BELT]);
	var(size,ITEM_SIZE_LARGE);
	var(weight,gramm(560));
	var(icon,invicon(torch));
	var(light,LIGHT_FIRE);
	getter_func(isFireLight,true);
	getterconst_func(getHandAnim,ITEM_HANDANIM_TORCH);
	getter_func(getTwoHandAnim,ITEM_2HANIM_SWORD);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_SWORD);

	var(handleUpdate,-1);
	var(fuelLeft,60 * 60 * 1.2);

	func(getDescFor)
	{
		objParams_1(_usr);
		private _desc = callSuper(ILightible,getDescFor);
		private _fleft = getSelf(fuelLeft);
		if getSelf(lightIsEnabled) then {
			if (_fleft > 0 && _fleft <= 60) then {_desc = _desc + sbr + pick["Скоро потухнет","Почти выгорело всё","Огонь угасает"]};
		};

#ifdef DEBUG
		_desc = _desc + sbr + "ОСТАЛОСЬ: " + formatTime(_fleft);
#endif

		_desc
	};

	//событие вызывается при опустошении топлива
	func(onFuelEmpty)
	{
		objParams();
	};

	func(onUpdate)
	{
		updateParams();
		modSelf(fuelLeft,-1);
		if (getSelf(fuelLeft) == 0) then {
			callSelf(onFuelEmpty);
			callSelfParams(lightSetMode,false);
		};
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
	getter_func(canUseMainAction,getSelf(lightIsEnabled) && super());
	getter_func(getMainActionName,"Затушить");
	func(onMainAction) {
		objParams_1(_usr);
		if getSelf(lightIsEnabled) then {
			callSelfParams(lightSetMode,false);
		};
	};

	func(lightSetMode)
	{
		objParams_1(_mode);
		private _result = callSuper(ILightible,lightSetMode);
		if (_result) then {
			if (_mode) then {
				callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
				if callSelf(isInContainer) exitWith {};
				callSelfParams(playSound, "fire\torch_on" arg rand(0.8,1.8));
			} else {
				callSelfParams(stopUpdateMethod,"handleUpdate");
				if callSelf(isInContainer) exitWith {};
				callSelfParams(playSound, "fire\torch_off" arg getRandomPitch);
			};
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		if callFunc(_with,isFireLight) then {
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
			if (getSelf(lightIsEnabled) && callSelf(isFireLight)) then {
				callFuncParams(_with,doBurn,this arg _usr);
			};
		};
	};

endclass

class(Sigarette) extends(Torch)
	var(name,"Сигарета");
	var(desc,"Для перекура самое то!");
	var(light,LIGHT_SIGARETTE);
	var(allowedSlots,[INV_FACE]);
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(1.08));
	var(model,"relicta_models\models\interier\props\cigarette.p3d");
	var(icon,invicon(sigarette));
	var(fuelLeft,60 * 6);
	getterconst_func(getHandAnim,ITEM_HANDANIM_LOWERONLYHAND);

	var(canRestoreLight,true); //можно ли восстановить после тушения (нужно для расходников без восстановления)

	func(onFuelEmpty)
	{
		objParams();
		setSelf(canRestoreLight,false);
		//nextFrameParams({delete(_this)},this);
		setSelf(name,"Окурок");
		callSelfParams(setModel,"relicta_models2\misc\s_cigarette_end\s_cigarette_end.p3d");
		if !callSelf(isInWorld) then {
			private _loc = getSelf(loc);
			if callFunc(_loc,isMob) then {
				callFuncParams(_mob,localSay,"Сигарета кончилась..." arg "mind");
			};
		};
		
	};

	func(lightSetMode)
	{
		objParams_1(_mode);
		if (_mode && !getSelf(canRestoreLight)) exitWith {false};
		callSuper(Torch,lightSetMode);
	};

	func(onUpdate)
	{
		updateParams();
		super();
		//TODO if in slot mob then add nicotine
	};

endclass

class(SigaretteDisabled) extends(Sigarette)
	var(lightIsEnabled,false);
endclass

class(Candle) extends(Sigarette)
	var(name,"Свеча");
	var(desc,"");
	var_array(allowedSlots); //override but inherite from sigarette
	var(icon,invicon(candle));
	var(model,"relicta_models\models\interier\props\svecha.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(25));
	var(light,LIGHT_CANDLE);
	getterconst_func(getHandAnim,ITEM_HANDANIM_TORCH);
	var(fuelLeft,60 * 30);

	func(onFuelEmpty)
	{
		objParams();
		setSelf(canRestoreLight,false);
		setSelf(name,"Прогоревшая " + tolower callSelf(getName));
	};
endclass

class(CandleDisabled) extends(Candle)
	var(lightIsEnabled,false);
endclass

class(LampKerosene) extends(Torch)
	var(name,"Керосиновая лампа");
	var(desc,"Простая, но надёжная - больше и нечего сказать.");
	var(icon,invicon(kerosene));
	var(allowedSlots,[]);
	var(model,"ml_shabut\exoduss\keroslampa.p3d");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(360));
	var(light,LIGHT_LAMP_KEROSENE);
	getterconst_func(getHandAnim,ITEM_HANDANIM_LAMP);
	var(fuelLeft,60 * 60 * 1.3);
endclass

class(LampKeroseneDisabled) extends(LampKerosene)
	var(lightIsEnabled,false);
endclass


class(Match) extends(Sigarette)
	var(name,"Спичка");
	var(desc,"");
	var(model,"relicta_models\models\interier\props\spichka.p3d");
	var(weight,gramm(5));
	var(size,ITEM_SIZE_TINY);
	var(light,LIGHT_MATCH);
	var(lightIsEnabled,false);
	var(canRestoreLight,true);
	var(fuelLeft,randInt(30,60));
	getterconst_func(getHandAnim,ITEM_HANDANIM_TORCH);

	func(onFuelEmpty)
	{
		objParams();
		callSelfParams(worldSay,getSelf(name) + " сгорает." arg "act");
		delete(this);
	};

	func(lightSetMode)
	{
		objParams_1(_mode);
		if (getSelf(lightIsEnabled) && !_mode) then {setSelf(canRestoreLight,false)};
		super();
	};

endclass

class(MatchBox) extends(Item)
	var(name,"Коробок спичек");
	var(countLeft,15);
	var(model,"a3\structures_f_epa\items\tools\matches_f.p3d");

	func(onItemClick)
	{
		objParams_1(_usr);
		if callFunc(_usr,isEmptyActiveHand) then {
			if (getSelf(countLeft) <= 0) exitWith {
				callFuncParams(_usr,localSay,"Больше не осталось спичек" arg "info");
			};
			["Match",_usr,getVar(_usr,activeHand)] call createItemInInventory;
			modSelf(countLeft, - 1);
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		callSuper(Item,getDescFor) + sbr + ifcheck(getSelf(countLeft)>0,"Там ещё "+(vec3(getSelf(countLeft),vec3("спичка","спички","спичек"),true) call toNumeralString),"В коробочке пусто");
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		//callSuper(Item,onInteractWith);
		if isTypeOf(_with,Match) exitWith {
			callFuncParams(_with,lightSetMode,true);
		};
	};

endclass
