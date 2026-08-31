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

editor_attribute("HiddenClass")
class(GrenadeShrapnelProjectile) extends(IAmmoBase)
	var(name,"Осколок гранаты");
	getterconst_func(getProjectileName,"осколок гранаты");

	func(onDamageBulletProcess)
	{
		objParams_5(_targ,_dam,_type,_sel,_dir);
		callFuncParams(_targ,applyDamage,_dam arg _type arg _sel arg _dir arg di_grenade);
	};
endclass

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
	var(activator,nullPtr);

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
		setSelf(isDud,prob_new(10));
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

	func(useGrenadeAction)
	{
		objParams_1(_usr);
		if (getSelf(grenadeState) == GRENADE_STATE_SAFE) exitWith {
			callSelfParams(pullPin,_usr);
		};
		if (getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED) then {
			callSelfParams(releaseLever,_usr);
		};
	};

	// E is the world interaction. Inventory interaction is deliberately LMB.
	func(onMainAction)
	{
		objParams_1(_usr);
		if !callSelf(isInWorld) exitWith {};
		callSelfParams(useGrenadeAction,_usr);
	};

	func(onItemClick)
	{
		objParams_1(_usr);
		callSelfParams(onInventoryClick,_usr);
	};

	func(onItemSelfClick)
	{
		objParams_1(_usr);
		callSelfParams(onInventoryClick,_usr);
	};

	// Opt-in hook used by the inventory click RPC. This bypasses the ordinary
	// "active item interacts with clicked item" routing for this grenade only.
	func(onInventoryClick)
	{
		objParams_1(_usr);
		callSelfParams(useGrenadeAction,_usr);
	};

	func(isHeldByMob)
	{
		objParams();
		private _loc = getSelf(loc);
		if (isNullReference(_loc) || {!isExistsObject(_loc)}) exitWith {false};
		callFunc(_loc,isMob) && {getSelf(slot) in INV_LIST_HANDS}
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
		if !callSelf(isHeldByMob) then {
			callSelfParams(releaseLever,_usr);
		};
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
		if !isNullReference(_usr) then {
			setSelf(activator,_usr);
		};
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
		private _ownerChanged = !isNullReference(_oldOwner) && {not_equals(_oldOwner,_usr)};
		if (!(_newSlot in INV_LIST_HANDS) || {_ownerChanged}) then {
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
		callSelfParams(releaseLever,_oldOwner);
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

	// Spatial queries are rooted at the explosion, not at the grenade's current
	// inventory/world owner. The latter made an in-hand grenade see its holder
	// while a thrown grenade could miss every mob around the detonation point.
	func(getExplosionMobs)
	{
		objParams_2(_origin,_radius);
		private _result = [];
		private _owner = objNull;
		{
			if !callFunc(_x,isMob) then {continue};
			_owner = getVar(_x,owner);
			if isNullReference(_owner) then {continue};
			if (_origin distance (getPosATL _owner vectorAdd [0,0,1]) <= _radius) then {
				_result pushBack _x;
			};
		} foreach (["BasicMob",true] call getAllMobsInWorld);
		_result
	};

	func(getVisualCenter)
	{
		objParams_1(_visual);
		private _bounds = boundingBoxReal _visual;
		private _min = _bounds select 0;
		private _max = _bounds select 1;
		_visual modelToWorldVisual [
			((_min select 0) + (_max select 0)) / 2,
			((_min select 1) + (_max select 1)) / 2,
			((_min select 2) + (_max select 2)) / 2
		]
	};

	// One spatial set for blast damage. Mobs use their authoritative owner
	// model; structures retain the nearby visual that was actually discovered,
	// preferring an NGO collision proxy when one exists.
	func(getBlastWaveTargets)
	{
		objParams_2(_origin,_radius);
		private _targets = createHashMap;
		private _key = "";
		{
			_key = getVar(_x,pointer);
			_targets set [_key,[_x,getVar(_x,owner)]];
		} foreach callSelfParams(getExplosionMobs,_origin arg _radius);

		private _target = nullPtr;
		private _stored = [];
		{
			_target = [_x] call si_handleObjectReturnCheckVirtual;
			if isNullReference(_target) then {continue};
			if !callFunc(_target,isStruct) then {continue};
			_key = getVar(_target,pointer);
			_stored = _targets getOrDefault [_key,[]];
			if (count _stored == 0 || {_x call noe_server_isNGO}) then {
				_targets set [_key,[_target,_x]];
			};
		} foreach (_origin nearObjects _radius);
		values _targets
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
		private _hasLine = false;
		private _debugRays = [];
		private _rayColor = [1,0,0,0.85];
		private _target = nullPtr;
		private _isMob = false;

		{
			_x params ["_target","_targetVis"];
			if equals(_target,this) then {continue};
			_isMob = callFunc(_target,isMob);
			if (!_isMob && {!callFunc(_target,canApplyDamage)}) then {continue};
			_targetPos = ifcheck(
				_isMob,
				getPosATL _targetVis vectorAdd [0,0,1],
				callSelfParams(getVisualCenter,_targetVis)
			);
			_distance = _origin distance _targetPos;
			_hasLine = callSelfParams(hasBlastLine,_origin arg _targetPos arg _sourceVis arg _targetVis);
			#ifdef DEBUG
			_rayColor = [1,0,0,0.85];
			if (_hasLine) then {_rayColor = [0,1,0,0.85]};
			_debugRays pushBack [_origin,_targetPos,_rayColor];
			#endif
			if (_distance <= _radius && {_hasLine}) then {
				_factor = linearConversion [0,_radius,_distance,1,0.1,true];
				_damage = round (((callSelf(getBlastDamageDice) call gurps_throwdices) * _factor) max 1);
				if (_isMob) then {
					callFuncParams(_target,applyDamage,_damage arg DAMAGE_TYPE_BLAST arg pick [TARGET_ZONE_TORSO arg TARGET_ZONE_ABDOMEN] arg DIR_RANDOM arg di_grenade);
					if (_distance <= (_radius * 0.35)) then {
						callFuncParams(_target,applyDamage,round ((_damage * 0.5) max 1) arg DAMAGE_TYPE_BLAST arg callFunc(_target,pickRandomTargZone) arg DIR_RANDOM arg di_grenade);
					};
				} else {
					callFuncParams(_target,applyDamage,_damage arg DAMAGE_TYPE_BLAST arg _targetPos arg di_grenade);
				};
			};
		} foreach callSelfParams(getBlastWaveTargets,_origin arg _radius);
		_debugRays
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
		private _debugRays = [];
		private _rayEnd = [0,0,0];
		private _projectile = nullPtr;
		private _usr = getSelf(activator);
		private _distance = 0;

		for "_i" from 1 to callSelf(getShrapnelCount) do {
			_azimuth = random 360;
			_elevation = rand(1,8);
			_direction = [sin _azimuth * cos _elevation,cos _azimuth * cos _elevation,sin _elevation];
			_endPos = _origin vectorAdd (_direction vectorMultiply _radius);
			_hitData = [_origin,_endPos,_sourceVis] call si_getIntersectData;
			_hitObj = _hitData select 0;
			#ifdef DEBUG
			_rayEnd = _endPos;
			if !isNullReference(_hitObj) then {_rayEnd = _hitData select 1};
			_debugRays pushBack [_origin,_rayEnd,[1,0.65,0,0.85]];
			#endif
			if isNullReference(_hitObj) then {continue};
			_hitPos = _hitData select 1;
			_target = [_hitObj] call si_handleObjectReturnCheckVirtual;
			if isNullReference(_target) then {continue};
			_distance = _origin distance _hitPos;
			_factor = linearConversion [0,_radius,_distance,1,0.25,true];
			_damage = round (((callSelf(getShrapnelDamageDice) call gurps_throwdices) * _factor) max 1);
			if (!callFunc(_target,isMob) && {!callFunc(_target,canApplyDamage)}) then {continue};

			// Pure raycast, standard projectile hit contract. No throw task or
			// attack-visual RPC is created for grenade fragments.
			_projectile = instantiate("GrenadeShrapnelProjectile");
			setVar(_projectile,shooter,_usr);
			setVar(_projectile,shotedFrom,this);
			private _p = _hitPos;
			callFuncParams(_target,onBulletAct,_damage arg DAMAGE_TYPE_PIERCING_NO arg TARGET_ZONE_RANDOM arg _usr arg _distance arg _projectile);
		};
		_debugRays
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
		} foreach callSelfParams(getExplosionMobs,_origin arg _radius);
	};

	func(sendExplosionDebug)
	{
		objParams_3(_origin,_radius,_rays);
		#ifdef DEBUG
		private _debugRadius = callSelf(getConcussionRadius);
		{
			callFuncParams(_x,sendInfo,"grenade_debug" arg [_origin arg _radius arg _rays]);
		} foreach callSelfParams(getExplosionMobs,_origin arg _debugRadius);
		#endif
	};

	// A ray aimed at the model origin can be stopped by the grenade itself.
	// Put a world grenade's detonation point just above its rotated visual bounds
	// so neither blast nor client visibility depends on which end faces the mob.
	func(getExplosionOrigin)
	{
		objParams_1(_sourceVis);
		if !callSelf(isInWorld) exitWith {
			getPosATL _sourceVis vectorAdd [0,0,0.15]
		};

		private _bounds = boundingBoxReal _sourceVis;
		private _min = _bounds select 0;
		private _max = _bounds select 1;
		private _centerModel = [
			((_min select 0) + (_max select 0)) / 2,
			((_min select 1) + (_max select 1)) / 2,
			((_min select 2) + (_max select 2)) / 2
		];
		private _centerWorld = _sourceVis modelToWorldVisual _centerModel;
		private _topZ = _centerWorld select 2;
		private _corners = [
			[_min select 0,_min select 1,_min select 2],
			[_max select 0,_min select 1,_min select 2],
			[_min select 0,_max select 1,_min select 2],
			[_max select 0,_max select 1,_min select 2],
			[_min select 0,_min select 1,_max select 2],
			[_max select 0,_min select 1,_max select 2],
			[_min select 0,_max select 1,_max select 2],
			[_max select 0,_max select 1,_max select 2]
		];
		{
			_topZ = _topZ max ((_sourceVis modelToWorldVisual _x) select 2);
		} foreach _corners;
		[_centerWorld select 0,_centerWorld select 1,_topZ + 0.05]
	};

	func(onExplosionAct)
	{
		objParams();
		private _sourceVis = ifcheck(callSelf(isInWorld),getSelf(loc),callSelf(getBasicLoc));
		private _origin = callSelfParams(getExplosionOrigin,_sourceVis);
		callSelfParams(playSound,"atmos\grenade" arg rand(0.8,1.2) arg 120);
		callSelfParams(sendExplosionEffects,_origin);
		private _blastRays = callSelfParams(applyBlastWave,_origin arg _sourceVis);
		private _shrapnelRays = callSelfParams(applyShrapnel,_origin arg _sourceVis);
		private _blastRadius = callSelf(getBlastRadius);
		private _debugRays = _blastRays + _shrapnelRays;
		callSelfParams(sendExplosionDebug,_origin arg _blastRadius arg _debugRays);
	};

endclass

class(GrenadeFragment) extends(Grenade)
	var(name,"Осколочная граната");
	var(model,"relicta_models\models\weapons\m21.p3d");
	var(weight,gramm(280));
endclass
