// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include "..\engine.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "Atmos.hpp"
#include "Atmos.h"

struct(AtmosChunk)
	def(chCtr) 0; //chunk counter

	def(area) null;//reference to area
	def(chId) null;
	def(chNum) -1; //local chunk id
	def(chLPos) null; //local position in area 
	def(lastUpd) 0;
	def(getChunkCenterPos) {(self getv(chId)) call atmos_chunkIdToPos}
	def(getChunkZoneOffset) {self getv(chLPos)}
	def(getChunkAreaId) {(self getv(chId)) call atmos_chunkIdToAreaId}


	def(objInside) null; //gameobjects inside this chunk
	def(flagUpdObj) true;

	def(cfg) -1;//light config effector
	
	//atmos objects inside this chunk. Used for faster enumerate
	def(aObj) null;
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
		
		self setv(objInside) [];
		self setv(aObj) [];

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

endstruct

struct(AtmosAreaBase)
	def(cfg) -1; //current light config
	def(isEnabled) true; //zone active
	def(chunk) null;
	def(getSpreadTimeout) 5;
	def(lastActivity) 0;

	def(canActivity) {tickTime > self getv(lastActivity)}

	def(onActivity) {}
	def(canPropagateTo) {}
	
endstruct

struct(AtmosAreaFire) base(AtmosAreaBase)

endstruct