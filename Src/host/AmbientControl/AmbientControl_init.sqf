// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"
#include "..\text.hpp"
#include "..\GameObjects\GameConstants.hpp"
#include "..\NOEngine\NOEngine.hpp"

//chunkSize_structure
//CHUNK_TYPE_STRUCTURE

ambctrl_handle = -1;
ambctrl_calledAmbients = createHashMap;
ambctrl_nextCallMin = 60 * 1;
ambctrl_nextCallMax = 60 * 1.5;

#ifdef EDITOR
//ambctrl_nextCallMin = 5;
//ambctrl_nextCallMax = 10;
#endif

ambctrl_onUpdate = {
	//collect unical locations
	_mapUnicalPos = createHashMap;
	_chunk = null;
	_strchunk = "";
	_t = tickTime;

	{
		_chunk = [callFunc(_x,getPos),CHUNK_TYPE_STRUCTURE] call noe_posToChunk;
		_strchunk = str _chunk;
		if (!(_chunk in _mapUnicalPos)) then {
			_mapUnicalPos set [_chunk,
				callFunc(_x,getPos)
			];
		};
		//register chunk first time
		if (!(_chunk in ambctrl_calledAmbients)) then {
			ambctrl_calledAmbients set [_chunk,_t + randInt(ambctrl_nextCallMin / 2,ambctrl_nextCallMax / 2)];
		};
	} foreach (["Mob",true] call getAllMobsInWorld);

	
	_checkTime = 0;
	_semiSize = precentage(chunkSize_structure,25); //оффсет позиции звука
	_semiDist = precentage(chunkSize_structure,30); //оффсет радиуса звука
	{
		//_x chunk
		//_y nextcall

		//player in checked chunk
		if (_x in _mapUnicalPos) then {
			if (_t >= _y) then {
				ambctrl_calledAmbients set [_x,_t + randInt(ambctrl_nextCallMin,ambctrl_nextCallMax)];
				_pos = (_mapUnicalPos get _x);
				_snd = pick [
						"ambient\common\ugrndambientbanging" + str randInt(1,7),
						"ambient\common\ugrndambientmachine" + str randInt(1,4),
						"ambient\common\blowout" + str randInt(1,7)
					];
				//params ["_file","_source",["_vol",1],["_pitch",1],["_maxDist",20],["_soundExtension","ogg"],["_offset",0],["_isLocal",false],["_isRTProcess",false]];
				_ctx = [
					_snd,
					_pos vectorAdd [rand(-_semiSize,_semiSize),rand(-_semiSize,_semiSize),rand(-_semiSize,_semiSize)],
					1,
					rand(0.8,1.6),
					clamp(chunkSize_structure + rand(-_semiDist,_semiDist),0,1000)
				];//call soundGlobal_play;
				invokeAfterDelayParams(soundGlobal_play,rand(5,20),_ctx);
				trace("CALLED AMBIENT ON SERVER" + str _x + " => " + _snd)
			};
		};
	} foreach ambctrl_calledAmbients;
};

ambctrl_handle = startUpdate(ambctrl_onUpdate,5);
