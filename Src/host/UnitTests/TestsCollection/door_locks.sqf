// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\TestFramework.h"
#include "..\..\GameObjects\GameConstants.hpp"

// Run in the loaded host environment: rb run -def TEST_DOOR_LOCKS -def DEBUG
TEST(KeyAccessSets)
{
	private _cases = [
		[["house","office","house"],["office","house"],true],
		[["house"],["house","office"],false],
		[["House"],["house"],false],
		[[],["house"],false],
		[[],[],true]
	];
	{
		_x params ["_a","_b","_expected"];
		private _actual = [_a,_b] call key_sameAccess;
		EXPECT_EQ(_actual,_expected);
		_actual = [_b,_a] call key_sameAccess;
		EXPECT_EQ(_actual,_expected);
	} foreach _cases;
}

TEST(DoorLockFaceTransformIsVerticalAndOpposed)
{
	private _front = [0,1] call doorLock_getFaceTransform;
	private _back = [0,-1] call doorLock_getFaceTransform;
	_front params ["_frontDir","_frontUp"];
	_back params ["_backDir","_backUp"];

	EXPECT(abs (_frontDir vectorDotProduct _frontUp) < 0.00001);
	EXPECT(abs (_backDir vectorDotProduct _backUp) < 0.00001);
	EXPECT(abs ((_frontDir select 2) - 1) < 0.00001);
	EXPECT(abs ((_backDir select 2) - 1) < 0.00001);
	EXPECT(vectorMagnitude (_frontUp vectorAdd _backUp) < 0.00001);

	private _rotated = [35,1] call doorLock_getFaceTransform;
	EXPECT(abs ((_rotated select 0) vectorDotProduct (_rotated select 1)) < 0.00001);
	private _rotatedDir = _rotated select 0;
	EXPECT(abs (_rotatedDir select 0) < 0.00001);
	EXPECT(abs (_rotatedDir select 1) < 0.00001);
	EXPECT(abs ((_rotatedDir select 2) - 1) < 0.00001);
}

TEST(DoorLockSelectionBasisTransformsRoundTrip)
{
	private _basis = [[1,0,0],[0,0,1]];
	private _source = [0.25,-0.5,1.5];
	private _world = [_basis,_source] call doorLock_transformVector;
	private _roundTrip = [_basis,_world] call doorLock_inverseTransformVector;
	EXPECT(vectorMagnitude (_roundTrip vectorDiff _source) < 0.00001);
	private _vertical = [_basis,[0,0,1]] call doorLock_transformVector;
	EXPECT(abs ((_vertical select 2) - 1) < 0.00001);
}

TEST(StrongLockDoesNotMakePiercingImmune)
{
	// Virtual objects only: no world meshes, targeting, sounds or animation.
	private _gate = new(GateCity);
	private _grid = new(SteelGridDoor);
	private _lock = new(StrongDoorLock);
	setVar(_grid,doorLock,_lock);
	setVar(_lock,isFastened,true);
	private _gateHP = getVar(_gate,hp);
	private _gridHP = getVar(_grid,hp);

	callFuncParams(_gate,applyDamage,10 arg DAMAGE_TYPE_PIERCING_NO);
	callFuncParams(_grid,applyDamage,10 arg DAMAGE_TYPE_PIERCING_NO);
	private _gateDamage = _gateHP - getVar(_gate,hp);
	private _gridDamage = _gridHP - getVar(_grid,hp);
	EXPECT(_gateDamage > 0);
	EXPECT(_gridDamage > 0);
	// Same fraction of total durability as the reference gate, including rounding.
	private _gateFraction = _gateDamage / getVar(_gate,hpMax);
	private _gridFraction = _gridDamage / getVar(_grid,hpMax);
	EXPECT(abs (_gateFraction - _gridFraction) < 0.00001);

	// Removing the lock from the slot must remove its damage multiplier.
	setVar(_grid,doorLock,nullPtr);
	EXPECT_EQ(callFunc(_grid,getDamageHPScale),1);
	private _before = getVar(_grid,hp);
	callFuncParams(_grid,applyDamage,10 arg DAMAGE_TYPE_PIERCING_NO);
	EXPECT((_before - getVar(_grid,hp)) > _gridDamage);

	// EXPECT keeps cleanup reachable even when the regression is detected.
	delete(_lock);
	delete(_grid);
	delete(_gate);
}

TEST(DoorLockDefaultsAndStoryProtection)
{
	private _wood = new(WoodenDoor);
	private _steel = new(SteelGridDoor);
	EXPECT_EQ(callFunc(_wood,resolveDoorLockType),0);
	setVar(_wood,keyTypes,["house"]);
	EXPECT_EQ(callFunc(_wood,resolveDoorLockType),1);
	setVar(_wood,lockType,0);
	EXPECT_EQ(callFunc(_wood,resolveDoorLockType),0);

	{
		private _story = new(StoryDoorLock);
		setVar(_story,isFastened,true);
		setVar(_story,door,_x);
		setVar(_x,doorLock,_story);
		private _hp = getVar(_x,hp);
		callFuncParams(_x,applyDamage,100 arg DAMAGE_TYPE_BLAST);
		EXPECT_EQ(getVar(_x,hp),_hp);
		EXPECT_EQ(callFunc(_x,getDoorProtectionGrade),3);
		setVar(_x,isLocked,false);
		setVar(_x,isOpen,true);
		callFuncParams(_x,applyDamage,100 arg DAMAGE_TYPE_BLAST);
		EXPECT_EQ(getVar(_x,hp),_hp);
		setVar(_x,doorLock,nullPtr);
		setVar(_story,door,nullPtr);
		delete(_story);
	} foreach [_wood,_steel];

	delete(_wood);
	delete(_steel);
}
