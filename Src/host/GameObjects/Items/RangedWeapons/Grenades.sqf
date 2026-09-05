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

#define GRENADE_CONTEXT_ORIGIN "origin"
#define GRENADE_CONTEXT_SOURCE_VISUAL "sourceVisual"
#define GRENADE_CONTEXT_MOBS "mobs"

#define GRENADE_SHRAPNEL_QUEUE "impactQueue"
#define GRENADE_SHRAPNEL_OBJECTS "objectImpacts"
#define GRENADE_SHRAPNEL_DUST "dustImpacts"

// Raycasts are cheap enough to resolve together. Projectile hit processing is
// not, so confirmed impacts are consumed in small batches on later frames.
grenade_processShrapnelImpact = {
	params ["_target","_hitPos","_damage","_usr","_distance"];
	if (isNullReference(_target) || {!isExistsObject(_target)}) exitWith {};

	private _projectile = instantiate("GrenadeShrapnelProjectile");
	setVar(_projectile,shooter,_usr);
	// onBulletAct reads the impact point through its legacy _p exref and owns
	// deletion of the temporary projectile instance.
	private _p = _hitPos;
	callFuncParams(_target,onBulletAct,_damage arg DAMAGE_TYPE_PIERCING_NO arg TARGET_ZONE_RANDOM arg _usr arg _distance arg _projectile);
};

grenade_processShrapnelQueue = {
	params ["_queue","_batchSize"];
	private _count = (count _queue) min _batchSize;
	for "_i" from 1 to _count do {
		(_queue deleteAt 0) call grenade_processShrapnelImpact;
	};
	if (count _queue > 0) then {
		private _nextFrameArgs = [_queue,_batchSize];
		nextFrameParams(grenade_processShrapnelQueue,_nextFrameArgs);
	};
};

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
	var(name,"Разрывная осколочная граната");
	var(desc,"Тяжёлая ручная граната с предохранительной чекой и рычагом. Говорят, что одна из таких десяти может иметь сырую воду в своем составе.");
	var(model,"relicta_models\models\weapons\rgd5.p3d");
	var(weight,gramm(310));
	var(size,ITEM_SIZE_SMALL);
	var(dr,4);
	getterconst_func(processInventoryTransitions,true);

	verbList("replacegrenadepin",Item);

	var(grenadeState,GRENADE_STATE_SAFE);
	var(fuseDuration,5);
	var(isDud,false);
	var(fuseGeneration,0);
	var(resolveOnStopFlying,false);
	var(activator,nullPtr);

	// Container damage must not delete the grenade during its own explosion.
	// resolveFuse owns deletion after all explosion processing has finished.
	getter_func(canApplyDamage,getSelf(grenadeState) != GRENADE_STATE_DETONATED);

	getterconst_func(activateSound,"guns\pin_pull");
	getterconst_func(leverSound,"electronics\click");
	getterconst_func(replacePinSound,"updown\keyring_up");
	getterconst_func(getThrowSkillModifier,3);
	getterconst_func(getBlastRadius,5);
	getterconst_func(getShrapnelRadius,20);
	getterconst_func(getConcussionRadius,8);
	getterconst_func(getBlastShakeRadius,20);
	getterconst_func(getBlastShakeCenterPositionPower,0.22);
	getterconst_func(getBlastShakeCenterDirectionPower,10);
	getterconst_func(getBlastShakeEdgeFactor,0.2);
	getterconst_func(getBlastShakeFrequency,0.02);
	getterconst_func(getBlastShakeDuration,1.4);
	getterconst_func(getExplosionRecipientRadius,35);
	getterconst_func(getExplosionSoundDistance,120);
	getterconst_func(getShrapnelCount,50);
	getterconst_func(getShrapnelSectorCount,12);
	getterconst_func(getShrapnelMinElevation,1);
	getterconst_func(getShrapnelMaxElevation,16);
	getterconst_func(getShrapnelHitsPerFrame,3);
	getterconst_func(getBlastDamageDice,7);
	getterconst_func(getBlastEdgeDamageFactor,0.1);
	getterconst_func(getBlastObjectDamageMultiplier,3);
	getterconst_func(getShrapnelDamageDice,2);

	region(state_and_interaction)

	func(constructor)
	{
		objParams();
		setSelf(fuseDuration,rand(4,6));
		setSelf(isDud,prob_new(10));
	};

	getter_func(canReplacePin,getSelf(grenadeState) == GRENADE_STATE_PIN_PULLED);
	func(canUseGrenadeAction)
	{
		objParams_1(_usr);
		getSelf(grenadeState) in [GRENADE_STATE_SAFE,GRENADE_STATE_PIN_PULLED]
			&& {callSelf(isInWorld) || {equals(getSelf(loc),_usr)}}
	};
	getter_func(canUseMainAction,callSelfParams(canUseGrenadeAction,_usr) && super());
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
		if !callSelfParams(canUseGrenadeAction,_usr) exitWith {false};
		if (getSelf(grenadeState) == GRENADE_STATE_SAFE) exitWith {
			callSelfParams(pullPin,_usr);
		};
		callSelfParams(releaseLever,_usr)
	};

	// E works both in the world and on a grenade directly owned by the user.
	// LMB inventory interaction is routed through onInventoryClick below.
	func(onMainAction)
	{
		objParams_1(_usr);
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
		if (equalTypes(_loc,objNull) || {isNullReference(_loc)} || {!isExistsObject(_loc)}) exitWith {nullPtr};
		private _owner = callFunc(_loc,getSourceLoc);
		if (isNullReference(_owner) || {!isExistsObject(_owner)} || {!isTypeOf(_owner,Mob)}) exitWith {nullPtr};
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
		callSelfParams(releaseLever,_usr);
	};

	func(onPutdown)
	{
		objParams_1(_usr);
		callSelfParams(releaseLever,_usr);
		callSuper(Item,onPutdown);
	};

	func(onDrop)
	{
		objParams_2(_usr,_isDropFromFly);
		callSelfParams(releaseLever,_usr);
		callSuper(Item,onDrop);
	};

	endregion

	region(explosion)

	func(hasBlastLine)
	{
		objParams_4(_origin,_targetPos,_sourceVis,_targetVis);
		private _hits = [
			_origin,
			_targetPos,
			_sourceVis,
			_targetVis,
			8,
			true,
			false,
			false
		] call si_getIntersectObjects;
		private _blockingIndex = _hits findIf {
			private _hitTarget = [_x] call si_handleObjectReturnCheckVirtual;
			isNullReference(_hitTarget) || {not_equals(_hitTarget,this)}
		};
		_blockingIndex == -1
	};

	// Spatial queries are rooted at the explosion, not at the grenade's current
	// inventory/world owner. The latter made an in-hand grenade see its holder
	// while a thrown grenade could miss every mob around the detonation point.
	func(getExplosionMobs)
	{
		objParams_2(_origin,_radius);
		["BasicMob",_origin,_radius,true,true] call getMobsOnPosition
	};

	func(createExplosionContext)
	{
		objParams_2(_origin,_sourceVis);
		createHashMapFromArray [
			[GRENADE_CONTEXT_ORIGIN,_origin],
			[GRENADE_CONTEXT_SOURCE_VISUAL,_sourceVis],
			[GRENADE_CONTEXT_MOBS,callSelfParams(getExplosionMobs,_origin arg callSelf(getExplosionRecipientRadius))]
		]
	};

	func(getExplosionMobPosition)
	{
		objParams_1(_mob);
		private _owner = getVar(_mob,owner);
		_owner modelToWorldVisual (_owner selectionPosition "spine3")
	};

	func(getMobSelectionPosition)
	{
		objParams_2(_mob,_selection);
		private _owner = getVar(_mob,owner);
		_owner modelToWorldVisual (_owner selectionPosition _selection)
	};

	// Select the body region nearest to the detonation using actual animated
	// model selections. Object origins are not reliable indicators of whether a
	// grenade is above, below, or beside a person.
	func(getBlastMobTargetData)
	{
		objParams_2(_mob,_origin);
		private _candidates = [
			[TARGET_ZONE_HEAD,callSelfParams(getMobSelectionPosition,_mob arg "head")],
			[TARGET_ZONE_TORSO,callSelfParams(getMobSelectionPosition,_mob arg "spine3")],
			[TARGET_ZONE_ABDOMEN,callSelfParams(getMobSelectionPosition,_mob arg "pelvis")],
			[TARGET_ZONE_LEG_L,callSelfParams(getMobSelectionPosition,_mob arg "leftleg")],
			[TARGET_ZONE_LEG_R,callSelfParams(getMobSelectionPosition,_mob arg "rightleg")]
		];
		private _best = _candidates select 0;
		private _bestDistance = _origin distance (_best select 1);
		private _candidateDistance = 0;
		{
			_candidateDistance = _origin distance (_x select 1);
			if (_candidateDistance < _bestDistance) then {
				_best = _x;
				_bestDistance = _candidateDistance;
			};
		} foreach _candidates;

		private _zone = callFuncParams(_mob,redirectZoneInExistingParts,_best select 0);
		private _selection = [_zone] call gurps_convertTargetZoneToArmaSelection;
		[_zone,callSelfParams(getMobSelectionPosition,_mob arg _selection)]
	};

	func(getBlastSecondaryZone)
	{
		objParams_2(_mob,_primaryZone);
		private _zone = TARGET_ZONE_TORSO;
		if (_primaryZone == TARGET_ZONE_TORSO) then {_zone = TARGET_ZONE_ABDOMEN};
		if (_primaryZone == TARGET_ZONE_LEG_L) then {_zone = TARGET_ZONE_LEG_R};
		if (_primaryZone == TARGET_ZONE_LEG_R) then {_zone = TARGET_ZONE_LEG_L};
		callFuncParams(_mob,redirectZoneInExistingParts,_zone)
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

	func(addBlastWaveTarget)
	{
		objParams_3(_targets,_visual,_preferredPos);
		private _target = [_visual] call si_handleObjectReturnCheckVirtual;
		if isNullReference(_target) exitWith {};
		if equals(_target,this) exitWith {};
		if callFunc(_target,isMob) exitWith {};
		if !callFunc(_target,canApplyDamage) exitWith {};

		private _key = getVar(_target,pointer);
		private _stored = _targets getOrDefault [_key,[]];
		if (count _stored == 0 || {_visual call noe_server_isNGO} || {count _preferredPos > 0}) then {
			_targets set [_key,[_target,_visual,_preferredPos]];
		};
	};

	// One spatial set for blast damage. Mobs use their authoritative owner model;
	// other damageable objects retain the nearby visual that was discovered. A
	// downward probe also catches broad floors and structures whose object origin
	// lies outside the radius even though their geometry is directly below it.
	func(getBlastWaveTargets)
	{
		objParams_2(_context,_radius);
		private _origin = _context get GRENADE_CONTEXT_ORIGIN;
		private _sourceVis = _context get GRENADE_CONTEXT_SOURCE_VISUAL;
		private _targets = createHashMap;
		private _key = "";
		{
			if (_origin distance (callSelfParams(getExplosionMobPosition,_x)) > _radius) then {continue};
			_key = getVar(_x,pointer);
			_targets set [_key,[_x,getVar(_x,owner),[]]];
		} foreach (_context get GRENADE_CONTEXT_MOBS);

		{
			callSelfParams(addBlastWaveTarget,_targets arg _x arg []);
		} foreach (_origin nearObjects _radius);

		private _downHits = [
			_origin,
			_origin vectorAdd [0,0,-_radius],
			_sourceVis,
			objNull,
			8,
			true,
			false,
			true
		] call si_getIntersectObjects;
		private _probeResolved = false;
		{
			if (_probeResolved) exitWith {};
			_x params ["_downVisual","_downPos"];
			private _downTarget = [_downVisual] call si_handleObjectReturnCheckVirtual;
			if (!isNullReference(_downTarget) && {equals(_downTarget,this)}) then {continue};
			_probeResolved = true;
			callSelfParams(addBlastWaveTarget,_targets arg _downVisual arg _downPos);
		} foreach _downHits;
		values _targets
	};

	// Returns [impact-or-center position, unobstructed]. A hit on another visual
	// belonging to the same virtual object is still a valid blast path.
	func(getBlastObjectTargetData)
	{
		objParams_4(_origin,_target,_sourceVis,_targetVis);
		private _center = callSelfParams(getVisualCenter,_targetVis);
		private _hits = [
			_origin,
			_center,
			_sourceVis,
			objNull,
			8,
			true,
			false,
			true
		] call si_getIntersectObjects;
		private _result = [_center,true];
		private _rayResolved = false;
		{
			if (_rayResolved) exitWith {};
			_x params ["_hitVisual","_hitPos"];
			private _hitTarget = [_hitVisual] call si_handleObjectReturnCheckVirtual;
			if (!isNullReference(_hitTarget) && {equals(_hitTarget,this)}) then {continue};
			_result = [_hitPos,equals(_hitTarget,_target)];
			_rayResolved = true;
		} foreach _hits;
		_result
	};

	// Returns [target, position, unobstructed, is-mob, target-zone].
	func(getBlastTargetData)
	{
		objParams_3(_origin,_sourceVis,_targetRecord);
		_targetRecord params ["_target","_targetVis","_preferredPos"];
		// Earlier blast hits can destroy other entries in the captured target set.
		if isNullReference(_target) exitWith {[]};
		if equals(_target,this) exitWith {[]};

		private _isMob = callFunc(_target,isMob);
		if (!_isMob && {!callFunc(_target,canApplyDamage)}) exitWith {[]};
		if (_isMob) exitWith {
			private _mobData = callSelfParams(getBlastMobTargetData,_target arg _origin);
			private _targetZone = _mobData select 0;
			private _targetPos = _mobData select 1;
			[
				_target,
				_targetPos,
				callSelfParams(hasBlastLine,_origin arg _targetPos arg _sourceVis arg _targetVis),
				true,
				_targetZone
			]
		};

		if (count _preferredPos > 0) exitWith {
			[_target,_preferredPos,true,false,TARGET_ZONE_TORSO]
		};
		private _objectData = callSelfParams(getBlastObjectTargetData,_origin arg _target arg _sourceVis arg _targetVis);
		[_target,_objectData select 0,_objectData select 1,false,TARGET_ZONE_TORSO]
	};

	func(applyBlastDamage)
	{
		objParams_6(_target,_targetPos,_targetZone,_isMob,_damage,_distance);
		if (_isMob) exitWith {
			callFuncParams(_target,applyDamage,_damage arg DAMAGE_TYPE_BLAST arg _targetZone arg DIR_RANDOM arg di_grenade);
			if (_distance <= (callSelf(getBlastRadius) * 0.35)) then {
				private _secondaryZone = callSelfParams(getBlastSecondaryZone,_target arg _targetZone);
				callFuncParams(_target,applyDamage,round ((_damage * 0.5) max 1) arg DAMAGE_TYPE_BLAST arg _secondaryZone arg DIR_RANDOM arg di_grenade);
			};
		};

		private _objectDamage = round (_damage * callSelf(getBlastObjectDamageMultiplier));
		callFuncParams(_target,applyDamage,_objectDamage arg DAMAGE_TYPE_BLAST arg _targetPos arg di_grenade);
	};

	func(applyBlastWave)
	{
		objParams_1(_context);
		private _origin = _context get GRENADE_CONTEXT_ORIGIN;
		private _sourceVis = _context get GRENADE_CONTEXT_SOURCE_VISUAL;
		private _radius = callSelf(getBlastRadius);
		#ifdef DEBUG_GRENADES
		private _debugRays = [];
		#endif
		private _baseDamage = callSelf(getBlastDamageDice) call gurps_throwdices;

		{
			private _targetData = callSelfParams(getBlastTargetData,_origin arg _sourceVis arg _x);
			if (count _targetData == 0) then {continue};
			_targetData params ["_target","_targetPos","_hasLine","_isMob","_targetZone"];
			private _distance = _origin distance _targetPos;
			#ifdef DEBUG_GRENADES
			private _rayColor = [1,0,0,0.85];
			if (_hasLine) then {_rayColor = [0,1,0,0.85]};
			_debugRays pushBack [_origin,_targetPos,_rayColor];
			#endif
			if (_distance > _radius || {!_hasLine}) then {continue};
			private _factor = linearConversion [0,_radius,_distance,1,callSelf(getBlastEdgeDamageFactor),true];
			private _damage = round ((_baseDamage * _factor) max 1);
			callSelfParams(applyBlastDamage,_target arg _targetPos arg _targetZone arg _isMob arg _damage arg _distance);
		} foreach callSelfParams(getBlastWaveTargets,_context arg _radius);
		#ifdef DEBUG_GRENADES
		_debugRays
		#endif
	};

	func(sendShrapnelDust)
	{
		objParams_2(_context,_impacts);
		if (count _impacts == 0) exitWith {};
		private _recipients = _context get GRENADE_CONTEXT_MOBS;
		{
			_x params ["_hitPos","_normal","_effectId"];
			{
				if (isNullReference(_x) || {!isExistsObject(_x)}) then {continue};
				// Match the ordinary melee impact lifetime. Holding the emitter open
				// for 0.35 seconds turned each fragment strike into a smoke cloud.
				callFuncParams(_x,sendInfo,"do_fe" arg [_hitPos arg _effectId arg _normal]);
			} foreach _recipients;
		} foreach _impacts;
	};

	func(getHeldArmTarget)
	{
		objParams();
		if !callSelf(isHeldByMob) exitWith {[]};
		private _holder = getSelf(loc);
		private _bodyPart = ifcheck(equals(getSelf(slot),INV_HAND_L),BP_INDEX_ARM_L,BP_INDEX_ARM_R);
		[_holder,_bodyPart]
	};

	func(annihilateHeldArm)
	{
		objParams_1(_heldArmTarget);
		if (count _heldArmTarget == 0) exitWith {};
		_heldArmTarget params ["_holder","_bodyPart"];
		if (isNullReference(_holder) || {!isExistsObject(_holder)}) exitWith {};
		if callFuncParams(_holder,hasPart,_bodyPart) then {
			callFuncParams(_holder,destroyLimb,_bodyPart);
		};
	};

	func(getShrapnelImpactEffect)
	{
		objParams_2(_target,_fallbackEffect);
		if isNullReference(_target) exitWith {_fallbackEffect};
		private _material = callFunc(_target,getMaterial);
		if isNullReference(_material) exitWith {_fallbackEffect};
		callFunc(_material,getDamageEffect)
	};

	func(rollShrapnelDamage)
	{
		objParams_3(_distance,_radius,_diceMultiplier);
		private _factor = linearConversion [0,_radius,_distance,1,0.25,true];
		private _dice = callSelf(getShrapnelDamageDice) * _diceMultiplier;
		round (((_dice call gurps_throwdices) * _factor) max 1)
	};

	// Returns [intersection data, unobstructed ray end]. Random calls stay here so
	// each ray retains the original azimuth/elevation consumption order.
	func(traceShrapnelRay)
	{
		objParams_2(_traceConfig,_rayIndex);
		_traceConfig params ["_origin","_sourceVis","_radius","_sectorCount","_sectorWidth","_sectorOffset","_minElevation","_maxElevation"];
		private _sector = (_sectorOffset + (_rayIndex - 1)) mod _sectorCount;
		private _azimuth = (_sector * _sectorWidth) + random _sectorWidth;
		private _elevation = rand(_minElevation,_maxElevation);
		private _direction = [sin _azimuth * cos _elevation,cos _azimuth * cos _elevation,sin _elevation];
		private _endPos = _origin vectorAdd (_direction vectorMultiply _radius);
		[[_origin,_endPos,_sourceVis] call si_getIntersectData,_endPos]
	};

	func(collectShrapnelHit)
	{
		objParams_6(_origin,_radius,_usr,_fallbackImpactEffect,_hitData,_accumulator);
		private _hitObj = _hitData select 0;
		if isNullReference(_hitObj) exitWith {};

		private _hitPos = _hitData select 1;
		private _target = [_hitObj] call si_handleObjectReturnCheckVirtual;
		private _dustImpacts = _accumulator get GRENADE_SHRAPNEL_DUST;
		if (isNullReference(_target) || {(!callFunc(_target,isMob) && {!callFunc(_target,canApplyDamage)})}) exitWith {
			private _impactEffect = callSelfParams(getShrapnelImpactEffect,_target arg _fallbackImpactEffect);
			_dustImpacts pushBack [_hitPos,_hitData select 2,_impactEffect];
		};

		private _distance = _origin distance _hitPos;
		private _impactQueue = _accumulator get GRENADE_SHRAPNEL_QUEUE;
		if callFunc(_target,isMob) exitWith {
			private _damage = callSelfParams(rollShrapnelDamage,_distance arg _radius arg 1);
			_impactQueue pushBack [_target,_hitPos,_damage,_usr,_distance];
		};

		private _objectImpacts = _accumulator get GRENADE_SHRAPNEL_OBJECTS;
		private _targetKey = getVar(_target,pointer);
		private _storedImpact = _objectImpacts getOrDefault [_targetKey,[]];
		if (count _storedImpact == 0) exitWith {
			_objectImpacts set [_targetKey,[_target,_hitPos,_distance,1]];
		};

		_storedImpact set [3,(_storedImpact select 3) + 1];
		_objectImpacts set [_targetKey,_storedImpact];
		private _impactEffect = callSelfParams(getShrapnelImpactEffect,_target arg _fallbackImpactEffect);
		_dustImpacts pushBack [_hitPos,_hitData select 2,_impactEffect];
	};

	func(finalizeShrapnelImpacts)
	{
		objParams_4(_context,_radius,_usr,_accumulator);
		private _impactQueue = _accumulator get GRENADE_SHRAPNEL_QUEUE;
		{
			_x params ["_objectTarget","_objectHitPos","_objectDistance","_hitCount"];
			private _damage = callSelfParams(rollShrapnelDamage,_objectDistance arg _radius arg _hitCount);
			_impactQueue pushBack [_objectTarget,_objectHitPos,_damage,_usr,_objectDistance];
		} foreach values (_accumulator get GRENADE_SHRAPNEL_OBJECTS);

		callSelfParams(sendShrapnelDust,_context arg (_accumulator get GRENADE_SHRAPNEL_DUST));
		if (count _impactQueue > 0) then {
			private _queueArgs = [_impactQueue,callSelf(getShrapnelHitsPerFrame)];
			nextFrameParams(grenade_processShrapnelQueue,_queueArgs);
		};
	};

	func(applyShrapnel)
	{
		objParams_1(_context);
		private _origin = _context get GRENADE_CONTEXT_ORIGIN;
		private _sourceVis = _context get GRENADE_CONTEXT_SOURCE_VISUAL;
		private _radius = callSelf(getShrapnelRadius);
		#ifdef DEBUG_GRENADES
		private _debugRays = [];
		#endif
		private _usr = getSelf(activator);
		private _sectorCount = callSelf(getShrapnelSectorCount);
		private _traceConfig = [
			_origin,
			_sourceVis,
			_radius,
			_sectorCount,
			360 / _sectorCount,
			randInt(0,_sectorCount - 1),
			callSelf(getShrapnelMinElevation),
			callSelf(getShrapnelMaxElevation)
		];
		private _fallbackImpactEffect = "SLIGHT_DAM_BETON" call lightSys_getConfigIdByName;
		private _accumulator = createHashMapFromArray [
			[GRENADE_SHRAPNEL_QUEUE,[]],
			[GRENADE_SHRAPNEL_OBJECTS,createHashMap],
			[GRENADE_SHRAPNEL_DUST,[]]
		];

		for "_i" from 1 to callSelf(getShrapnelCount) do {
			private _rayData = callSelfParams(traceShrapnelRay,_traceConfig arg _i);
			_rayData params ["_hitData","_endPos"];
			#ifdef DEBUG_GRENADES
			private _rayEnd = _endPos;
			private _hitObj = _hitData select 0;
			if !isNullReference(_hitObj) then {_rayEnd = _hitData select 1};
			_debugRays pushBack [_origin,_rayEnd,[1,0.65,0,0.85]];
			#endif
			callSelfParams(collectShrapnelHit,_origin arg _radius arg _usr arg _fallbackImpactEffect arg _hitData arg _accumulator);
		};

		callSelfParams(finalizeShrapnelImpacts,_context arg _radius arg _usr arg _accumulator);
		#ifdef DEBUG_GRENADES
		_debugRays
		#endif
	};

	func(sendExplosionPresentation)
	{
		objParams_1(_context);
		private _origin = _context get GRENADE_CONTEXT_ORIGIN;
		private _concussionRadius = callSelf(getConcussionRadius);
		private _shakeRadius = callSelf(getBlastShakeRadius);
		private _effectId = "SLIGHT_FX_GRENADE_1" call lightSys_getConfigIdByName;
		private _effectUp = vec3(0,0,1);
		private _distance = 0;
		private _intensity = 0;
		private _shakeFactor = 0;
		{
			if (isNullReference(_x) || {!isExistsObject(_x)}) then {continue};
			_distance = _origin distance (callSelfParams(getExplosionMobPosition,_x));
			callFuncParams(_x,sendInfo,"do_fe" arg [_origin arg _effectId arg _effectUp arg 0.55]);
			if (_distance <= _shakeRadius) then {
				_shakeFactor = linearConversion [
					0,
					_shakeRadius,
					_distance,
					1,
					callSelf(getBlastShakeEdgeFactor),
					true
				];
				callFuncParams(_x,addCamShake,callSelf(getBlastShakeCenterPositionPower) * _shakeFactor arg callSelf(getBlastShakeCenterDirectionPower) * _shakeFactor arg callSelf(getBlastShakeFrequency) arg callSelf(getBlastShakeDuration));
			};
			if (_distance <= _concussionRadius) then {
				_intensity = linearConversion [0,_concussionRadius,_distance,1,0.05,true];
				callFuncParams(_x,sendInfo,"grenade_concussion" arg [_origin arg _intensity]);
			};
		} foreach (_context get GRENADE_CONTEXT_MOBS);
	};

	#ifdef DEBUG_GRENADES
	func(sendExplosionDebug)
	{
		objParams_3(_context,_radius,_rays);
		private _origin = _context get GRENADE_CONTEXT_ORIGIN;
		{
			if (isNullReference(_x) || {!isExistsObject(_x)}) then {continue};
			callFuncParams(_x,sendInfo,"grenade_debug" arg [_origin arg _radius arg _rays]);
		} foreach (_context get GRENADE_CONTEXT_MOBS);
	};
	#endif

	// A ray aimed at the model origin can be stopped by the grenade itself.
	// Put a world grenade's detonation point just above its rotated visual bounds
	// so neither blast nor client visibility depends on which end faces the mob.
	func(getExplosionOrigin)
	{
		objParams_1(_sourceVis);
		if !callSelf(isInWorld) exitWith {
			private _holder = callSelfParams(getMobOwnerFromLoc,getSelf(loc));
			if !isNullReference(_holder) exitWith {
				private _selection = "spine3";
				if (getSelf(slot) == INV_HAND_L) then {_selection = "lefthand"};
				if (getSelf(slot) == INV_HAND_R) then {_selection = "righthand"};
				callSelfParams(getMobSelectionPosition,_holder arg _selection)
			};
			getPosATL _sourceVis vectorAdd [0,0,0.15]
		};

		private _bounds = boundingBoxReal _sourceVis;
		private _min = _bounds select 0;
		private _max = _bounds select 1;
		private _centerWorld = callSelfParams(getVisualCenter,_sourceVis);
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
		private _heldArmTarget = callSelf(getHeldArmTarget);
		private _sourceVis = ifcheck(callSelf(isInWorld),getSelf(loc),callSelf(getBasicLoc));
		private _origin = callSelfParams(getExplosionOrigin,_sourceVis);
		// The grenade is deleted immediately after this method. A world position is
		// stable on clients; the grenade pointer is not.
		callSelfParams(playSound,"atmos\grenade-explosion-" + str randInt(1,3) arg rand(0.8,1.2) arg callSelf(getExplosionSoundDistance) arg 1 arg _origin);
		private _context = callSelfParams(createExplosionContext,_origin arg _sourceVis);
		callSelfParams(sendExplosionPresentation,_context);
		#ifdef DEBUG_GRENADES
		private _blastRays =
		#endif
		callSelfParams(applyBlastWave,_context);
		#ifdef DEBUG_GRENADES
		private _shrapnelRays =
		#endif
		callSelfParams(applyShrapnel,_context);
		callSelfParams(annihilateHeldArm,_heldArmTarget);
		#ifdef DEBUG_GRENADES
		private _blastRadius = callSelf(getBlastRadius);
		private _debugRays = _blastRays + _shrapnelRays;
		callSelfParams(sendExplosionDebug,_context arg _blastRadius arg _debugRays);
		#endif
	};

	endregion

endclass

class(GrenadeFragment) extends(Grenade)
	var(name,"Осколочная граната");
	var(model,"relicta_models\models\weapons\m21.p3d");
	var(weight,gramm(280));
endclass
