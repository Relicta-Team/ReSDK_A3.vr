// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(Grenade) extends(Item)
	var(name,"Разрывная граната");
	var(model,"relicta_models\models\weapons\rgd5.p3d");
	var(weight,gramm(310));
	var(size,ITEM_SIZE_SMALL);
	var(dr,4);
	var(isReady,false);

	var(explosionTimeout,5);

	getter_func(getExplosionDamageType,DAMAGE_TYPE_CRUSHING);
	getter_func(getExplosionDamage,vec2(5,0));
	getter_func(getFragmentDamage,vec2(0,0));

	getterconst_func(activateSound,"guns\pin_pull");

	getterconst_func(activeDistance,10);

	func(setReady)
	{
		objParams_1(_mode);

		if equals(_mode,getSelf(isReady)) exitWith {};

		if (_mode) then {
			callSelfParams(playSound,callSelf(activateSound) arg rand(0.8,1.3));
			callSelfAfter(onExplosionActImpl,getSelf(explosionTimeout));
		} else {

		};
		setSelf(isReady,_mode)
	};
	getter_func(getMainActionName,"Вырвать чеку");
	func(onMainAction)
	{
		objParams_1(_usr);
		if !getSelf(isReady) then {
			callSelfParams(setReady,true);
		};
	};

	func(onExplosionActImpl)
	{
		objParams();
		if callSelf(isFlying) exitWith {
			callSelf(stopFlying);
		};
		callSelf(onExplosionAct);
		delete(this);
	};

	func(onStopFlying)
	{
		objParams();
		if getSelf(isReady) then {
			callSelf(onExplosionActImpl);
		};
	};

	//событие при взырве
	func(onExplosionAct)
	{
		objParams();
		
		#ifndef EDITOR
		if (true) exitwith {
			
		};
		#endif

		callSelfParams(playSound,"atmos\Explosion" + str randInt(1,6) arg rand(0.8,1.2) arg 120);
		callSelf(getExplosionDamage) params ["_dices","_mod"];
		private _allZones = TARGET_ZONE_LIST_HEAD + TARGET_ZONE_LIST_LIMBS + TARGET_ZONE_LIST_TORSO;
		private _dam = 0;

		{
			if callFuncParams(_x,canSeeObject,this) then {
				_dam = (_dices call gurps_throwdices) + _mod;
				//_basicDamage arg _dType arg _attTargetZone arg _dir);
				for "_i" from 1 to randInt(1,6) do {
					callFuncParams(_x,applyDamage,_dam arg callSelf(getExplosionDamageType) arg pick _allZones arg DIR_RANDOM arg di_grenade);
				};
			};

		} foreach callSelfParams(getNearMobs,callSelf(activeDistance) arg false);

	};

endclass

class(GrenadeFragment) extends(Grenade)
	var(name,"Осколочная граната");
	var(model,"relicta_models\models\weapons\m21.p3d");
	var(weight,gramm(280));
endclass
