// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\ServerRpc\serverRpc.hpp>

/*
playSound3D [filename, soundSource, isInside, soundPosition, volume, soundPitch, distance, offset]
Parameters:
	filename: String - see Arma 3: SoundFiles for available filenames or Example 3 to use mission files.
	soundSource: Object - the object emitting the sound. If "sound position" is specified this parameter is ignored
	isInside: Boolean - (Optional, default false)
	soundPosition: PositionASL - (Optional, default [0,0,0]) position for sound emitter, will override "sound source" position.
	volume: Number - (Optional, default 1) Maximum value: 5 (limited since A3 v1.91.145537)
	soundPitch: Number - (Optional, default 1) 1: Normal, 0.5: Darth Vader, 2: Chipmunks, etc.
	distance: Number - (Optional, default 0) How far is sound audible (0 = no max distance)
	offset: Scalar - (Optional, default 0) Offset in seconds. Same as with playMusic
*/
//динамический источник звука, удаление невозможно. Публикуется по сети
soundGlobal_play = {
	params ["_file","_source",["_vol",1],["_pitch",1],["_maxDist",20],["_soundExtension","ogg"],["_offset",0],["_isLocal",false],["_isRTProcess",false]];
#ifdef ENABLE_NEW_AUDIO_SYSTEM
	if (!_isLocal) exitWith {
		//todo refactoring network sounds
		private _args = _this;
		private _pos = [0,0,0];
		//replication
		if equalTypes(_source,[]) then {
			if equalTypes(_source select 0,0) exitWith {
				_pos = _source;
			};
			if equalTypes(_source select 0,objNull) exitWith {
				_source params ["_obj",["_followSrc",false],["_offset",[0,0,0]]];
				_pos = ((_obj call vs_audio_internal_getSourceObj) modeltoworldvisual _offset);
			};
		} else {
			_pos = getPosATL (_source call vs_audio_internal_getSourceObj);
		};
		private _playerList = if equals(_pos,vec3(0,0,0)) then {
			allPlayers - [player]
		} else {
			((_pos nearEntities _maxDist) - [player]) select {isPlayer _x};
		};
		
		_args set [7,true];
		{
			["repl_psound3d",_args,_x] call CBA_fnc_targetEvent; 
		} foreach _playerList;

		if (!isServer) then {
			[
				_source,
				PATH_SOUND(_file),
				_maxDist,
				_pitch,
				_offset,
				_vol
			] call vs_audio_playSound3d;
		};
	};

	[
		_source,
		PATH_SOUND(_file),
		_maxDist,
		_pitch,
		_offset,
		_vol
	] call vs_audio_playSound3d;

	
#else
	FHEADER;

	//Упрощённый режим симуляции звуков
	#define SIMPLE_RUNTIME_PROCESS_SOUNDS
	private _pos = null;

	if (_source isEqualType []) then {
		//error("Source param not implemented array type TODO this");
		//RETURN(false);
		//_pos = _source; // flow error
		_pos = ATLToASL _source;
		_source = objNull;
	} else {
		_pos = getPosASL _source;
	};

	if equalTypes(_source,locationNull) exitWith {
		error("Source param is wrong data type - rslobj");
		RETURN(false);
	};

	if not_equalTypes(_source,objNUll) then {
		if not_equalTypes(_source,"") exitWith {
			errorformat("sound3d::play() - Unknown type source object %1",tolower typename _source);
			RETURN(false);
			_source = player;
		};
		private _srcPtr = noe_client_allPointers get _source;
		if isNullVar(_srcPtr) exitWith {
			errorformat("sound3d::play() - Null pointer %1",criptPtr(_source));
			RETURN(false);
			_source = player;
		};
		_source = _srcPtr;
	};



	if (!("." in _file)) then {
		MOD(_file,+"."+_soundExtension);
	} else {
		warningformat("sound3d::play() - sound extension already inside in path: %1",_file);
	};

	_file = PATH_SOUND(_file);
	//Отладка трейсов
	//#define DEBUG_SOUND_TRACE
	
	if (_isRTProcess) then {
		private _curPoint = eyepos player;
		#ifdef DEBUG_SOUND_TRACE
		if isNull(soundengine_internal_debug_list_objs) then {soundengine_internal_debug_list_objs = []};
		{deleteVehicle _x} foreach soundengine_internal_debug_list_objs;
		soundengine_internal_debug_list_objs = [];
		#endif
		private _its = lineIntersectsSurfaces [
			_curPoint,
			_pos,
			player,
			_source,
			true,
			30,
			"VIEW",
			"NONE",
			true
		];
		//no collision
		if (count _its == 0) exitWith {};
		private __itscDists = _maxDist;
		private _objCheck = objNUll;
		private _srcDist = 0;
		private __distAll = _curPoint distance _pos;
		//private _curVol = _vol;
		//private __volDists = 0;
		{
			if (__itscDists<=0) exitWith {true};
			_objCheck = _x select 2;
			//!traceformat("CHECKING OBJECT %1",_objCheck)

			([_objCheck] call vs_internal_getObjBBXData) params ["_h","_plosh"];
			//!traceformat("	POST CHECK DIST: %1; BBX:[%2 | %3]",_curPoint distance _objCheck arg _h arg _plosh)
			_srcDist = _curPoint distance (_x select 0); //гашение от точки до цели
			_curPoint = _x select 0;
			#ifdef DEBUG_SOUND_TRACE
			__arr = "Sign_Arrow_F" createVehicle [0,0,0];
			__arr setPosAtl (asltoatl _curPoint);
			__arr setVectorUp (_x select 1);
			soundengine_internal_debug_list_objs pushBack __arr;
			#endif
			if (_h >= 1) then {
				//modvar(__itscDists) - (linearConversion[0,150,_plosh,0,_maxDist,true]);//_srcDist;
				#ifdef SIMPLE_RUNTIME_PROCESS_SOUNDS
				//вне зависимости от размера и площади объекта
				modvar(__itscDists) - precentage(__itscDists,17);
				#else
				modvar(__itscDists) - _srcDist;
				#endif
				//modvar(__volDists) + _srcDist;
				//!traceformat("CHECK DIST FOR OBJ %1 - NOW %2; NEW VOL %3",_objCheck arg __itscDists arg __volDists)
			};

			true
		} count _its;

		_maxDist = __itscDists;

		//if (__volDists == 0) then {_curVol = _curVol max 0};
		//_vol = ((linearConversion [__distAll,0,__volDists,_curVol,0,true]))max 0;
	};
	if (_maxDist<0) exitWith {};

	playSound3D [_file,_source,false,_pos,_vol,_pitch,_maxDist,_offset,_isLocal];

	//playSound3D [getMissionPath "\sounds\mob\trauma" +str selectRandom [1,2,3] + ".ogg", vasya,false,getposasl vasya,1,1 + random [-.3,0,.3],100 / (player distance vasya)];
#endif
};

rpcAddGlobal("repl_psound3d",soundGlobal_play);

//Аналог soundGlobal::play() но без репликации по сети
soundLocal_play = {
	_this set [7,true];
	_this call soundGlobal_play;
};


soundUI_play = {
	params ["_file", ["_volume",1], ["_soundPitch",1], ["_isEffect",false],["_soundExtension","ogg"],["_offset",0]];
	#ifdef ENABLE_NEW_AUDIO_SYSTEM
	[PATH_SOUND(_file),_soundPitch,_offset,_volume,false] call vs_audio_playSound2d;
	#else
	if (!("." in _file)) then {
		MOD(_file,+"."+_soundExtension);
	} else {
		warningformat("soundUI::play() - sound extension already inside in path: %1",_file);
	};

	_file = PATH_SOUND(_file);
	
	playSoundUI[_file,_volume,_soundPitch,_isEffect,_offset];
	#endif
};
