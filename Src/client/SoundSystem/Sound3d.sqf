// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\ClientRpc\clientRpc.hpp>

#include "Music.sqf"

namespace(AudioSystem.Sound,sound3d_;sound_)

#ifdef ENABLE_NEW_AUDIO_SYSTEM
	#define soundParams(x) (x) call { \
		private _spr = [_this] call vs_audio_getSoundParams; \
		if (count _spr == 0) exitWith {_spr}; \
		if equals(_spr,vec3(0,0,0)) exitWith {[]}; \
		["",_spr select 0,_spr select 2,_spr select 1,1] \
	}

	#define stopSound(x) (x) call { private _spr = _this; \
		if (count _spr == 0) exitWith {false}; \
		(_spr call vs_audio_stopSound); \
	}

#else
	#define soundParams(x) SoundParams (x)
	#define stopSound(x) StopSound (x)
#endif

// params: ["_file","_source","_vol","_pitch","_maxDist",["_soundExtension","ogg"]];
rpcAdd("soundPlayGlobal",soundGlobal_play);
rpcAdd("sl_p",soundLocal_play);
rpcAdd("sui_p",soundUI_play);

//Рантайм вычисление процессор громкости звука
decl(void(...any[]))
soundProcessor_play = {
	FHEADER;
	_this set [7,true];
	_this set [8,true];
	
	_srcObj = _this select 1;
	if equalTypes(_srcObj,"") then {
		private _srcPtr = noe_client_allPointers get _srcObj;
		if isNullVar(_srcPtr) exitWith {
			RETURN(false);
		};
		_this set [1,_srcPtr];
	//} else {
		
	};
	
	
	_this call soundGlobal_play;
}; rpcAdd("sl_p_rt",soundProcessor_play);

//воспроизводит объектный звук. Источник
//функция локальна
decl(mesh(mesh;string;float;float;float))
sound3d_playOnObject = {
	params ["_source","_class","_dist",["_pitch",1],["_offset",0]];

#ifdef ENABLE_NEW_AUDIO_SYSTEM
	private _cfgObj = configFile;
	private _soundPath = (getArray(_cfgObj >> "CfgSounds" >> _class >> "sound")) select 0;
	_soundPath = [_soundPath,"rel_gamecontent\","rel_gamecontent.pbo\"] call stringReplace;
	[[_source,true,[0,0,0]],_soundPath,_dist,_pitch,_offset] call vs_audio_playSound3d;
#else

/*	if (typeOf _source == BASIC_MOB_TYPE) then {
		private _dummy = "#particlesource" createVehicleLocal [0,0,0];
		_dummy attachto [player,[0,0,0],"head"];
	};*/
	if ("\" in _class || ".ogg" in _class) exitWith {
		errorformat("sound3d::playOnObject() - Wrong type sound class - path (%1). Expected class",_class);
	};
	if equalTypes(_pitch,[]) then {
		_pitch = rand(_pitch select 0,_pitch select 1);
	};
	private _sound = _source say3d [_class,_dist,_pitch,false,_offset];

	//TODO autodelete timing

	/*
	obj = [player, player] say3D ["test", 100, 1, false, 0];

	[{deleteVehicle obj},[],0.2] call cba_fnc_waitAndExecute
	*/

	//just returning sound source
	_sound
#endif
}; rpcAdd("soundPlayOnObject",sound3d_playOnObject);

//функция локальна
decl(void(mesh|mesh[];any[];float))
sound3d_playOnObjectLooped = {
	params ["_additionalObjects","_3dSoundData",["_soundDuration",-1]];

	if (_soundDuration <= 0) exitWith {
		error("sound3d:playOnObjectLooped() - Duration is undefined or less than zero");
	};
	if (not_equalTypes(_additionalObjects,objNUll) && not_equalTypes(_additionalObjects,[])) then {
		errorformat("sound3d:playOnObjectLooped() - Source object wrong type - %1",tolower typename _additionalObjects);
	};

	_3dSoundData call sound3d_playOnObject;

	private _postCode = {
		params ["_additionalObjects","_3dSoundData","_soundDuration"];

		FHEADER;

		getThisCodeInTimeEvent(_postCode);

		if equalTypes(_additionalObjects,objNUll) then {
			if (isNullReference(_additionalObjects)) exitWith {RETURN(0)};
		} else {
			{
				if (isNullReference(_x)) exitWith {RETURN(0)};
			} foreach _additionalObjects;
		};

		[_additionalObjects,_3dSoundData,_soundDuration] call sound3d_playOnObjectLooped;
	};

	invokeAfterDelayParams(_postCode,_soundDuration,_this);

};

//Проигрывает локальный звук
//! this doesn't used
decl(void(string;float))
sound_selfPlay = {
	params ["_path",["_offset",0]];
	playSound [_path, false, _offset]
}; rpcAdd("soundSelfPlay",sound_selfPlay);



// проигрывание локальных звуков
//from say3D [sound, maxDistance, pitch, isSpeech, offset]
//! this function is not used
decl(mesh(mesh;string;float;float;float))
sound3d_playLocal = {
	params ["_obj","_clsSound",["_pitch",1],["_distance",10],["_offset",0]];
	
	_obj say3D [_clsSound,_distance,_pitch,false,_offset];
}; rpcAdd("soundPlayLocal",sound3d_playLocal);

/*
	запускает локальный звук в цикле. 
	Параметр _preendbuf - отвечает за смещение повтороного запуска. 
	звук располагается статично и не перемещается за объектом. при удалении источника звук автоматически остановится
	Возвращает указатель зацикленного звука
*/
decl(int(string;mesh;float;float;float;float;float))
sound3d_playLocalOnObjectLooped = {
	params ["_file","_src",["_pitch",1],["_dist",10],["_offset",0],["_preendbuf",0],["_vol",1]];
	//? private _refParams = _this; //never used
	
	if equalTypes(_pitch,[]) then {
		_pitch = rand(_pitch select 0,_pitch select 1);
	};
	//params ["_file","_source",["_vol",1],["_pitch",1],["_maxDist",20],["_soundExtension","ogg"],["_offset",0],["_isLocal",false],["_isRTProcess",false]];
	private _playSoundParams = [_file,
	#ifdef ENABLE_NEW_AUDIO_SYSTEM
	[_src,true,[0,0,0]],
	#else
	_src,
	#endif
	_vol,_pitch,_dist,null,_offset,true,false];
	private _pspFT = array_copy(_playSoundParams);
	_pspFT set [6,_preendbuf];
	private _sid = _pspFT call soundGlobal_play;
	private _spar = soundParams(_sid);
	if equals(_spar,[]) exitWith {
		setLastError("Sound params empty; Args: " + str _this);
		warningformat("sound3d::playLocalOnObjectLooped() - Sound params empty; Args: %1",_this);
		null
	};
	private _params = [_src,_sid,_preendbuf,_playSoundParams];
	sound3d_internal_list_soundBuff pushBack _params;
};

decl(bool(int))
sound3d_stopLocalLopped = {
	params ["_soundPtr"];
	if (_soundPtr >= (count sound3d_internal_list_soundBuff)) exitWith {false};
	private _params = sound3d_internal_list_soundBuff select _soundPtr;
	private _spar = soundParams(_params select 1);
	if equals(_spar,[]) exitWith {false};
	stopSound(_params select 1);
	sound3d_internal_list_soundBuff select _soundPtr set [0,objNull];
	true
};


//hotreload cleanup sounds
#ifdef EDITOR_OR_SP_MODE
if !isNullVar(sound3d_internal_list_soundBuff) then {
	{
		stopSound(_x select 1);
	} foreach sound3d_internal_list_soundBuff;
};
#endif

decl(any[])
sound3d_internal_list_soundBuff = [];
sound3d_internal_handle3dSounds = -1;
decl(void())
sound3d_internal_localHandler = {
	private _slist = sound3d_internal_list_soundBuff;
	private _needDel = false;
	{
		_x params ["_src","_sid","_preend","_psParams"];
		//traceformat("check sound %1",_psParams)
		private _spar = soundParams(_sid);
		//this stop event
		if isNullReference(_src) then {
			stopSound(_sid);
			_slist set [_foreachindex,objNull];
			_needDel = true;
			continue; //next iter
		};

		private _doRestart = false;
		if equals(_spar,[]) then {
			_doRestart = true;
		} else {
			private _maxLen = _spar select 2;
			private _time = _spar select 3;
			_doRestart = _time>=(_maxLen-_preend);
		};
		//traceformat("	curtime: %1, maxlen %2, preend %3",_spar select 3 arg _spar select 2 arg _preend)

		if (_doRestart) then {
			private _newSid = _psParams call soundGlobal_play;
			if isNullVar(_newSid) exitWith {
				_slits set [_foreachindex,objNull];
				_needDel = true;
			};
			(_slist select _foreachindex) set [1,_newSid];
		};
	} foreach _slist;

	if (_needDel) then {
		_slist = _slist - [objNull];
		sound3d_internal_list_soundBuff = _slist;
		
	};
}; 


sound3d_internal_handle3dSounds = startUpdate(sound3d_internal_localHandler,0.1);