// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
   Atmos system for area effects
*/

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "Atmos.h"

atmos_map_chunks = createHashMap; //key:str(chunkloc) -> value(object:AtmosChunk)
atmos_handle_update = -1;

atmos_hasIntersect = {
   params ["_fromCh","_toCh"];
   private _fromPos = _fromCh call atmos_chunkIdToPos;
   private _toPos = _toCh call atmos_chunkIdToPos;

   private _tRez = ([_fromPos,_toPos] call si_getIntersectData) select 2;
   if (isNullReference(tRez)) exitWith {false};
   _tRez = ([_fromPos vectorAdd [],_toPos] call si_getIntersectData) select 2;
};

atmos_updateAll = {
   private __destr__ = false;
   private _reqDestr = [];
   private _atmosList = [];
   private _chPos = null;
   private _canTransfer = false;
   
   private _cachedMobList = [];
   private _cachedObjList = [];
   private _generatedCacheMobs = false;
   private _generatedCacheObjects = false;
   
   private _atmObj = nullPtr;

   private _spChunkIdList = null;

   _getMobList = {
      if (_generatedCacheMobs) then {
         _cachedMobList
      } else {
         _cachedMobList = ["BasicMob",_chPos,ATMOS_SIZE * 3,true,true] call getGameObjectOnPosition;
         //sorting
         private _delMobs = true;
         {
            if (!ATMOS_POS_INSIDE_CHUNK(callFunc(_x,getPos),_chPos)) then {
               _cachedMobList set [_forEachIndex,objNull];
            };
         } foreach _cachedMobList;
         if (_delMobs) then {
            _cachedMobList = _cachedMobList - [objNull];
         };
         _generatedCacheMobs = true;
         _cachedMobList
      };
   };

   _getObjList = {
      if (_generatedCacheObjects) then {
         _cachedObjList
      } else {
         _cachedObjList = ["IDestructible",_chPos,ATMOS_SIZE * 3,true,true] call getGameObjectOnPosition;
         //sorting
         private _delObjs = true;
         {
            if (!ATMOS_POS_INSIDE_CHUNK(callFunc(_x,getModelPosition),_chPos)) then {
               _cachedObjList set [_forEachIndex,objNull];
            };
         } foreach _cachedObjList;
         if (_delObjs) then {
            _cachedObjList = _cachedObjList - [objNull];
         };
         _generatedCacheObjects = true;
         _cachedObjList
      };
   };

   _getSpreadChunks = {
      //TODO, return always in random sorting
      []
   };

   {
      _atmosList = getVar(_y,aObj);
      if (count _atmosList == 0) continueWith{}; //no area inside atmos chunk
      _canTransfer = false;
      _chPos = getVar(_y,realPos); //center position

      /*
         Main update atmos object processes
      */
      _cachedMobList = [];
      _cachedObjList = [];
      _generatedCacheMobs = false;
      _generatedCacheObjects = false;
      //TODO refactoring
      {
         _atmObj = _x;

         //common atmos updater
         callFunc(_atmObj,onUpdate);
      
         // handle contact mobs in chunk
         if callFunc(_atmObj,canContactOnMob) then {
            {
               callFuncParams(_atmObj,onMobContact,_x); true
            } count (call _getMobList);
         };

         //handle contact objects in chunk
         if callFunc(_atmObj,canContactOnObjects) then {
            {
               callFuncParams(_atmObj,onObjectContact,_x); true
            } count (call _getObjList);
         };

         //spread atmos
         _spChunkIdList = call _getSpreadChunks;
         {
            
         } count foreach (_spChunkIdList select [0,randInt(1,ATMOS_SPREAD_MAX_COUNT)]);
         
      } foreach _atmosList;

   } foreach atmos_map_chunks;
};

//convert world postion to virtual chunk id
atmos_chunkPosToId = {
   params ["_x","_y","_z"];
   
   [
		floor(_x / ATMOS_SIZE) + ATMOS_START_INDEX,
		floor(_y / ATMOS_SIZE) + ATMOS_START_INDEX,
      floor(_z / ATMOS_SIZE) + ATMOS_START_INDEX
	]
};

atmos_chunkIdToPos = {
   params ["_iX","_iY","_iZ"];

   [
      (_iX - ATMOS_START_INDEX) * ATMOS_SIZE,
      (_iY - ATMOS_START_INDEX) * ATMOS_SIZE,
      (_iZ - ATMOS_START_INDEX) * ATMOS_SIZE   
   ]
};

/*
   get list of chunks around

   z+1:
      -------
      | | | |
      | |x| |
      | | | |
      -------
   z:
      -------
      | |x| |
      |x|v|x| <- "v" is optional
      | |x| |
      -------
   z-1:
      -------
      | | | |
      | |x| |
      | | | |
      -------
*/
atmos_chunkIdGetAround = {
   params ["_chunk",["_addCurrent",false]];
   private _loadList = [];
   if (_addCurrent) then {

	   _loadList pushBack _chunk;
   };
   //5*3 => 15 - 1(current)
	//no iteration - faster

   //upper z
   _loadList pushBack (_chunk vectorAdd [0,0,1]);
   //down z
   _loadList pushBack (_chunk vectorAdd [0,0,-1]);
   //middle z
   _loadList pushBack (_chunk vectorAdd [1,0,0]);
   _loadList pushBack (_chunk vectorAdd [-1,0,0]);
   _loadList pushBack (_chunk vectorAdd [0,1,0]);
   _loadList pushBack (_chunk vectorAdd [0,-1,0]);
   
   _loadList
}; 

//run thread updater
atmos_init = {
   error("Atmos system disabled");
   //atmos_handle_update = startUpdate(atmos_updateAll,ATMOS_MAIN_THREAD_UPDATE_DELAY);
};