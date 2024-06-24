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
	def(getChunkCenterPos) {(self get(chId)) nativeCall atmos_chunkIdToPos}
	def(getChunkZoneOffset) {self get(chLPos)}
	def(getChunkAreaId) {(self get(chId)) nativeCall atmos_chunkIdToAreaId}


	def(objInside) null; //gameobjects inside this chunk
	def(flagUpdObj) true;

	def(cfg) -1;//light config effector
	
	//atmos objects inside this chunk. Used for faster enumerate
	def(aObj) null;
		def(aFire) null;
		def(aGas) null;
		def(aWater) null;

	def(hasFire) {!isNull(self get(aFire))};
	def(hasGas) {!isNull(self get(aGas))};
	def(hasWater) {!isNull(self get(aWater))};

	def(updateLight)
	{
		if (self call(hasFire)) exitWith {
			
		};
	}

	//generate packet for client
	def(getPacket)
	{
		[self get(chNum),SLIGHT_ATMOS_FIRE_1]
	}

	def(constructor)
	{
		params ["_chId"];
		
		self set(objInside) [];
		self set(aObj) [];

		self set(chId,_chId);

		//setup local position and chunk localID
		self set(chLPos,_chId nativeCall atmos_getLocalChunkIdInArea);
		self set(chNum, (self get(chLPos)) nativeCall atmos_encodeChId);

		self set(chCtr,atmos_chunks_uniqIdx);
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

	def(canActivity) {tickTime > self get(lastActivity)}

	def(onActivity) {}
	def(canPropagateTo) {}
	
endstruct

struct(AtmosAreaFire) base(AtmosAreaBase)

endstruct