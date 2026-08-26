// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

#define GRENADE_STATE_SAFE 0
#define GRENADE_STATE_PIN_PULLED 1
#define GRENADE_STATE_FUSE 2
#define GRENADE_STATE_DUD 3
#define GRENADE_STATE_DETONATED 4

class(Grenade) extends(Item)
	var(name,"Разрывная граната");
	var(desc,"Тяжёлая ручная граната с предохранительной чекой и рычагом.");
	var(model,"relicta_models\models\weapons\rgd5.p3d");
	var(weight,gramm(310));
	var(size,ITEM_SIZE_SMALL);
	var(dr,4);
	var(processInventoryTransitions,true);

	verbList("replacegrenadepin",Item);

	var(grenadeState,GRENADE_STATE_SAFE);
	var(fuseDuration,5);
	var(isDud,false);
	var(fuseGeneration,0);
	var(resolveOnStopFlying,false);

	getterconst_func(activateSound,"guns\pin_pull");
	getterconst_func(leverSound,"electronics\click");
	getterconst_func(replacePinSound,"updown\keyring_up");
	getterconst_func(getThrowSkillModifier,3);
	getterconst_func(getBlastRadius,6);
	getterconst_func(getShrapnelRadius,20);
	getterconst_func(getConcussionRadius,35);
	getterconst_func(getShrapnelCount,20);
	getterconst_func(getBlastDamageDice,5);
	getterconst_func(getShrapnelDamageDice,2);

	func(constructor)
	{
		objParams();
		setSelf(fuseDuration,rand(4,6));
		setSelf(isDud,prob_new(25));
	};

	getter_func(canReplacePin,getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED);
	getter_func(canUseMainAction,getSelf(grenadeState) in [GRENADE_STATE_SAFE,GRENADE_STATE_PIN_PULLED] && super());
	getter_func(getMainActionName,ifcheck(getSelf(grenadeState) == GRENADE_STATE_SAFE,"Вырвать чеку","Отпустить рычаг"));

	func(getDescFor)
	{
		objParams_1(_usr);
		private _desc = callSuper(Item,getDescFor);
		if (getSelf(grenadeState) == GRENADE_STATE_DUD) then {
			_desc = _desc + sbr + "Запал уже прогорел. Граната оказалась бракованной.";
		};
		_desc
	};

	func(onMainAction)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) == GRENADE_STATE_SAFE) exitWith {
			callSelfParams(pullPin,_usr);
		};
		if (getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED) then {
			callSelfParams(releaseLever,_usr);
		};
	};

	func(pullPin)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) != GRENADE_STATE_SAFE) exitWith {false};
		setSelf(grenadeState,GRENADE_STATE_PIN_PULLED);
		callSelfParams(playSound,callSelf(activateSound) arg rand(0.8,1.2) arg 35);
		private _actorName = callFuncParams(_usr,getNameEx,"кто");
		private _message = format["%1 ВЫДЁРГИВАЕТ ЧЕКУ ИЗ ГРАНАТЫ!",_actorName];
		_message = setstyle(_message,style_redbig);
		callSelfParams(worldSay,_message arg "combat" arg 25 arg false);
		true
	};

	func(replacePin)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) != GRENADE_STATE_PIN_PULLED) exitWith {false};
		setSelf(grenadeState,GRENADE_STATE_SAFE);
		callSelfParams(playSound,callSelf(replacePinSound) arg rand(0.9,1.1) arg 20);
		if !isNullReference(_usr) then {
			private _actorName = callFuncParams(_usr,getNameEx,"кто");
			private _message = format["%1 вставляет чеку обратно в гранату.",_actorName];
			callSelfParams(worldSay,_message arg "info" arg 20 arg false);
		};
		true
	};

	func(releaseLever)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) != GRENADE_STATE_PIN_PULLED) exitWith {false};
		setSelf(grenadeState,GRENADE_STATE_FUSE);
		modSelf(fuseGeneration,+1);
		private _generation = getSelf(fuseGeneration);
		callSelfParams(playSound,callSelf(leverSound) arg rand(0.9,1.1) arg 25);
		callSelfParams(worldSay,setstyle("РЫЧАГ ГРАНАТЫ ОТПУЩЕН — ЗАПАЛ ГОРИТ!",style_redbig) arg "combat" arg 25 arg false);
		callSelfAfterParams(onFuseExpired,getSelf(fuseDuration),_generation);
		true
	};

	func(onFuseExpired)
	{
		objParams_1(_generation);
		if (_generation != getSelf(fuseGeneration)) exitWith {};
		if (getSelf(grenadeState) != GRENADE_STATE_FUSE) exitWith {};

		if callSelf(isFlying) exitWith {
			setSelf(resolveOnStopFlying,true);
			callSelf(stopFlying);
		};

		callSelf(resolveFuse);
	};

	func(resolveFuse)
	{
		objParams();
		if (getSelf(grenadeState) != GRENADE_STATE_FUSE) exitWith {};
		if getSelf(isDud) exitWith {
			setSelf(grenadeState,GRENADE_STATE_DUD);
			callSelfParams(playSound,callSelf(leverSound) arg 0.7 arg 15);
			callSelfParams(worldSay,"Граната сухо щёлкает. Бракованный запал." arg "event" arg 20 arg false);
		};

		setSelf(grenadeState,GRENADE_STATE_DETONATED);
		callSelf(onExplosionAct);
		delete(this);
	};

	func(onStopFlying)
	{
		objParams();
		if !getSelf(resolveOnStopFlying) exitWith {};
		setSelf(resolveOnStopFlying,false);
		callSelf(resolveFuse);
	};

	func(onInventorySlotChanged)
	{
		objParams_4(_usr,_oldLoc,_oldSlot,_newSlot);
		if (getSelf(grenadeState) != GRENADE_STATE_PIN_PULLED) exitWith {};
		private _oldOwner = callSelfParams(getMobOwnerFromLoc,_oldLoc);
		if (!isNullReference(_oldOwner) && {equals(_oldOwner,_usr)}) then {
			if !(_newSlot in INV_LIST_HANDS) then {
				callSelfParams(replacePin,_usr);
			};
		} else {
			callSelfParams(releaseLever,_oldOwner);
		};
	};

	func(getMobOwnerFromLoc)
	{
		objParams_1(_loc);
		private _owner = nullPtr;
		private _cur = _loc;
		while {true} do {
			if (equalTypes(_cur,objNull) || {isNullReference(_cur)}) exitWith {};
			if !isExistsObject(_cur) exitWith {};
			if isTypeOf(_cur,Mob) exitWith {_owner = _cur};
			_cur = getVar(_cur,loc);
		};
		_owner
	};

	func(onMovedToContainer)
	{
		objParams_2(_container,_oldLoc);
		if (getSelf(grenadeState) != GRENADE_STATE_PIN_PULLED) exitWith {};
		private _oldOwner = callSelfParams(getMobOwnerFromLoc,_oldLoc);
		private _newOwner = callSelfParams(getMobOwnerFromLoc,_container);
		if (!isNullReference(_oldOwner) && {equals(_oldOwner,_newOwner)}) then {
			callSelfParams(replacePin,_newOwner);
		} else {
			callSelfParams(releaseLever,_oldOwner);
		};
	};

	func(onBeforeThrow)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED) then {
			callSelfParams(releaseLever,_usr);
		};
	};

	func(onPutdown)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED) then {
			callSelfParams(releaseLever,_usr);
		};
		callSuper(Item,onPutdown);
	};

	func(onDrop)
	{
		objParams_2(_usr,_isDropFromFly);
		if (getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED) then {
			callSelfParams(releaseLever,_usr);
		};
		callSuper(Item,onDrop);
	};

	func(hasBlastLine)
	{
		objParams_4(_origin,_targetPos,_sourceVis,_targetVis);
		private _hit = [_origin,_targetPos,_sourceVis,_targetVis] call si_getIntersectData;
		isNullReference(_hit select 0)
	};

	func(applyBlastWave)
	{
		objParams_2(_origin,_sourceVis);
		private _radius = callSelf(getBlastRadius);
		private _distance = 0;
		private _factor = 0;
		private _damage = 0;
		private _targetVis = objNull;
		private _targetPos = [0,0,0];

		{
			_targetVis = getVar(_x,owner);
			_targetPos = getPosATL _targetVis vectorAdd [0,0,1];
			_distance = _origin distance _targetPos;
			if (_distance <= _radius && {callSelfParams(hasBlastLine,_origin arg _targetPos arg _sourceVis arg _targetVis)}) then {
				_factor = linearConversion [0,_radius,_distance,1,0.1,true];
				_damage = round (((callSelf(getBlastDamageDice) call gurps_throwdices) * _factor) max 1);
				callFuncParams(_x,applyDamage,_damage arg DAMAGE_TYPE_BLAST arg pick [TARGET_ZONE_TORSO arg TARGET_ZONE_ABDOMEN] arg DIR_RANDOM arg di_grenade);
				if (_distance <= (_radius * 0.35)) then {
					callFuncParams(_x,applyDamage,round ((_damage * 0.5) max 1) arg DAMAGE_TYPE_BLAST arg callFunc(_x,pickRandomTargZone) arg DIR_RANDOM arg di_grenade);
				};
			};
		} foreach callSelfParams(getNearMobs,_radius arg false);

		{
			if (equals(_x,this) || {callFunc(_x,isMob)} || {!callFunc(_x,canApplyDamage)}) then {continue};
			_targetVis = callFunc(_x,getBasicLoc);
			_targetPos = getPosATL _targetVis;
			_distance = _origin distance _targetPos;
			if (_distance <= _radius && {callSelfParams(hasBlastLine,_origin arg _targetPos arg _sourceVis arg _targetVis)}) then {
				_factor = linearConversion [0,_radius,_distance,1,0.1,true];
				_damage = round (((callSelf(getBlastDamageDice) call gurps_throwdices) * _factor) max 1);
				callFuncParams(_x,applyDamage,_damage arg DAMAGE_TYPE_BLAST arg _targetPos arg di_grenade);
			};
		} foreach (["IDestructible",_origin,_radius,true,true] call getGameObjectOnPosition);
	};

	func(applyShrapnel)
	{
		objParams_2(_origin,_sourceVis);
		private _radius = callSelf(getShrapnelRadius);
		private _azimuth = 0;
		private _elevation = 0;
		private _direction = [0,0,0];
		private _endPos = [0,0,0];
		private _hitData = [];
		private _hitObj = objNull;
		private _hitPos = [0,0,0];
		private _target = nullPtr;
		private _factor = 0;
		private _damage = 0;

		for "_i" from 1 to callSelf(getShrapnelCount) do {
			_azimuth = random 360;
			_elevation = rand(1,8);
			_direction = [sin _azimuth * cos _elevation,cos _azimuth * cos _elevation,sin _elevation];
			_endPos = _origin vectorAdd (_direction vectorMultiply _radius);
			_hitData = [_origin,_endPos,_sourceVis] call si_getIntersectData;
			_hitObj = _hitData select 0;
			if isNullReference(_hitObj) then {continue};
			_hitPos = _hitData select 1;
			_target = [_hitObj] call si_handleObjectReturnCheckVirtual;
			if isNullReference(_target) then {continue};
			_factor = linearConversion [0,_radius,_origin distance _hitPos,1,0.25,true];
			_damage = round (((callSelf(getShrapnelDamageDice) call gurps_throwdices) * _factor) max 1);
			if callFunc(_target,isMob) then {
				callFuncParams(_target,applyDamage,_damage arg DAMAGE_TYPE_PIERCING_NO arg callFunc(_target,pickRandomTargZone) arg DIR_RANDOM arg di_grenade);
			} else {
				if callFunc(_target,canApplyDamage) then {
					callFuncParams(_target,applyDamage,_damage arg DAMAGE_TYPE_PIERCING_NO arg _hitPos arg di_grenade);
				};
			};
		};
	};

	func(sendExplosionEffects)
	{
		objParams_1(_origin);
		private _radius = callSelf(getConcussionRadius);
		private _effectId = "SLIGHT_FX_GRENADE" call lightSys_getConfigIdByName;
		private _effectUp = vec3(0,0,1);
		private _distance = 0;
		private _intensity = 0;
		{
			_distance = _origin distance getPosATL getVar(_x,owner);
			_intensity = linearConversion [0,_radius,_distance,1,0.05,true];
			callFuncParams(_x,sendInfo,"do_fe" arg [_origin arg _effectId arg _effectUp arg 0.35]);
			callFuncParams(_x,sendInfo,"grenade_concussion" arg [_origin arg _intensity]);
		} foreach callSelfParams(getNearMobs,_radius arg false);
	};

	func(onExplosionAct)
	{
		objParams();
		private _sourceVis = callSelf(getBasicLoc);
		private _origin = getPosATL _sourceVis vectorAdd [0,0,0.15];
		callSelfParams(playSound,"atmos\grenade" arg rand(0.8,1.2) arg 120);
		callSelfParams(sendExplosionEffects,_origin);
		callSelfParams(applyBlastWave,_origin arg _sourceVis);
		callSelfParams(applyShrapnel,_origin arg _sourceVis);
	};

endclass

class(GrenadeFragment) extends(Grenade)
	var(name,"Осколочная граната");
	var(model,"relicta_models\models\weapons\m21.p3d");
	var(weight,gramm(280));
endclass
