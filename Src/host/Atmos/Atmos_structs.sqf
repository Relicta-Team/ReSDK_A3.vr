// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\struct.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.hpp"
#include "Atmos.h"

/*
	List typedef(AtmosArea) 
		-> AtmosChunk 
			-> AtmosAreaBase

*/

struct(AtmosChunk)
	def(chCtr) 0; //chunk counter

	def(areaSR) null;//saferef to area
	def(chId) null;
	def(chNum) -1; //local chunk id
	def(chLPos) null; //local position in area 
	def(lastUpd) 0;
	def(getChunkCenterPos) {(self getv(chId)) call atmos_chunkIdToPos}
	def(getChunkZoneOffset) {self getv(chLPos)}
	def(getChunkAreaId) {(self getv(chId)) call atmos_chunkIdToAreaId}
	def(getArea)
	{
		self getv(areaSR) callv(getValue)
	}


	def(objInside) null; //gameobjects inside this chunk
	def(flagUpdObj) true;

	def(cfg) -1;//light config effector
	
	//atmos objects inside this chunk. Used for faster enumerate
	def(atmosList) null;
		def(aFire) null;
		def(aGas) null;
		def(aWater) null;

	def(hasFire) {!isNull(self getv(aFire))};
	def(hasGas) {!isNull(self getv(aGas))};
	def(hasWater) {!isNull(self getv(aWater))};

	def(updateLight)
	{
		if (self callv(hasFire)) exitWith {
			
		};
	}

	//generate packet for client
	def(getPacket)
	{
		[self getv(chNum),SLIGHT_ATMOS_FIRE_1]
	}

	def(init)
	{
		params ["_chId"];
		
		self setv(objInside, []);
		self setv(atmosList,[]);

		self setv(chId,_chId);

		//setup local position and chunk localID
		self setv(chLPos,_chId call atmos_getLocalChunkIdInArea);
		self setv(chNum, (self getv(chLPos)) call atmos_encodeChId);

		self setv(chCtr,atmos_chunks_uniqIdx);
		INC(atmos_chunks_uniqIdx);
	}

	def(getChunkUserInfo)
	{
		params ["_usr"];
	}

	def(registerArea)
	{
		params ["_aType","_fieldName","_aIdx"];
		private _p = [self getv(chId)];
		private _atr = [_aType,_p] call struct_alloc;
		self set [_fieldName,_atr];
		self getv(atmosList) set [_aIdx,_atr];
		_atr
	}

	def(str)
	{
		format["A%2Ch%1",self getv(chId),self callv(getChunkAreaId)]
	}

endstruct

struct(AtmosAreaBase)
	def(cfg) -1; //current light config
	def(isEnabled) true; //zone active
	def(chunkId) null; //vec3 to chunk id
	def(getChunk) {[self getv(chunkId)] call atmos_getChunkAtChIdUnsafe}

	def(getSpreadTimeout) {5};
	def(lastActivity) 0;

	def(canActivity) {tickTime > self getv(lastActivity)}

	def(onActivity) {}
	def(canPropagateTo) {}

	def(init)
	{
		params ["_chId"];
		self setv(chunkId,_chId);
	}
	
	def(str)
	{
		format["%1<%2>",struct_typename(self),self getv(chunkId)]
	}
endstruct

struct(AtmosAreaFire) base(AtmosAreaBase)

endstruct