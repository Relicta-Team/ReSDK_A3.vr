// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Реализация аудиосистемы на основе ReVoice с использованием fmod
*/

#define VS_AUDIO_NEXT_EFFECT_UPDATE 1

// использовать новый движок аудио
vs_audio_useBackend =
	#ifdef ENABLE_NEW_AUDIO_SYSTEM
		true; 
	#else
		false;
	#endif

vs_audio_updateHandle = -1;
vs_audio_updateLoopedHandle = -1;

vs_audio_loadLib = {
	((apiCmd [CMD_AUDIO_LOADLIB,[_this]]) select 0) == "True";
};

vs_audio_unloadLib = {
	((apiCmd [CMD_AUDIO_UNLOADLIB,[_this]]) select 0) == "True";
};

// получает все работающие звуки в игре
vs_audio_getAllSoundsIds = {
	//get hashset of all sounds
	apiRequest(REQ_AUDIO_GET_ALL_SOUNDS_IDS) splitString " ";
};

vs_audio_isSoundExists = {
	((apiCmd [CMD_AUDIO_IS_SOUND_EXISTS,[_this]]) select 0) == "True";
};

vs_audio_stopSound = {
	((apiCmd [CMD_AUDIO_STOP_SOUND,[_this]]) select 0) == "True";
};

vs_audio_stopAllSounds = {
	{
		_x call vs_audio_stopSound;
	} foreach (call vs_audio_getAllSoundsIds);
};

vs_audio_releaseAllSounds = {
	//global free all audio sources
	apiRequest(REQ_AUDIO_RELEASE_ALL_SOUNDS);
};

vs_audio_init = {
	if (!vs_audio_useBackend) exitWith {};
	
	#ifdef EDITOR
	call vs_audio_stopAllSounds;
	#endif

	logformat("Audio lib loaded: %1","@rlct\Addons\rel_gamecontent.pbo" call vs_audio_loadLib);
	//disable rvengine audio system
	//0.1 fadeSound 0; 
	//todo fademusic
	
	if (is3den) exitWith {};

	0 spawn
    {
        waitUntil { !isNullReference(findDisplay 46) };
        //внутри только нативный код. все функции клиента на этом этапе выгружены
        private _nativeCode = (toString vs_audio_releaseAllSounds)+";diag_log 'vs_audio_init() - internal audio system disconnect on unload game display';";
        findDisplay 46 displayAddEventHandler ["Unload",compile _nativeCode];
    };

	vs_audio_updateHandle = startUpdate(vs_audio_onUpdate,0.3);
	vs_audio_updateLoopedHandle = startUpdate(vs_audio_onUpdateLooped,0.1);

	//todo replace to onexit audio settings
	private _syncAudio = {
		if (!isGameFocused) exitWith {
			0 call vs_audio_setMasterSoundVolume;
		};
		clamp(getAudioOptionVolumes select 0,0,1) call vs_audio_setMasterSoundVolume;
	};
	startUpdate(_syncAudio,0.5);
};

vs_audio_setMasterSoundVolume = {
	apiCmd [CMD_AUDIO_SET_MASTER_SOUND_VOLUME,[_this]];
};
vs_audio_getMasterSoundVolume = {
	private _strval = (apiRequest(REQ_AUDIO_GET_MASTER_SOUND_VOLUME));
	private _clrval = _strval splitString ",." joinString "."; //fix for ReVoucer 1.5--
	parseNumber _clrval;
};

/*
	plays sound in 3d or 2d
	_source - source of sound 
		must be (position | object | vec3<object,bool,vec3> | null):
			position - position of sound
			object - object of sound
			vec3<object,bool,vec3> where:
				object - object of sound
				bool - boolean if need follow
				vec3 - position offset from object
			null - sound will be played in 2d
	_soundPath - path to sound (absolute or inside pbo)
	_distance - distance of sound (if -1, sound will be played in 2d)
	_pitch - pitch of sound
	_offset - start offset in seconds
	_vol - volume of sound
	_useEffects - use effects (lowpass, reverb, etc.)
	_loop - loop sound

	[[player,true,[0,0,0]],"testsound.ogg",30,1] call vs_audio_playSound3d;
*/
vs_audio_playSound3d = {
	params ["_source","_soundPath","_distance",["_pitch",1],["_offset",0],["_vol",1],["_useEffects",true],["_loop",false]];

	private _is2d = isNullVar(_source);
	private _pos = [0,0,0];
	private _doFollow = false;
	private _sourceParams = [];

	if (!_is2d) then {
		if equalTypes(_source,[]) then {
			if equalTypes(_source select 0,0) exitWith {
				_pos = _source;
			};
			if equalTypes(_source select 0,objNull) exitWith {
				_source params ["_obj",["_followSrc",false],["_offset",[0,0,0]]];
				_doFollow = _followSrc;
				_sourceParams = [_obj,_offset];
				_pos = ((_obj call vs_audio_internal_getSourceObj) modeltoworldvisual _offset);
			};
		} else {
			_pos = getPosATL (_source call vs_audio_internal_getSourceObj);
		};
	};

	if !([_soundPath,".ogg"] call stringEndWith) then {
		_soundPath = _soundPath + ".ogg";
	};

	private _soundParams = [_soundPath];
	_soundParams append _pos;
	_soundParams append [_distance,_pitch,_offset,_vol,_is2d,_loop];

	private _id = (apiCmd [CMD_AUDIO_PLAY_SOUND,_soundParams]) select 0;

	if (_useEffects) then {
		if (_is2d) exitWith {};
		private _lowp = [_pos,true,_id] call vs_calcLowpassEffect;
		private _reverb = [_pos,true,_id,_distance] call vs_calcReverbEffect;
		
		_lowp call vs_audio_setLowpassEffect;
		_reverb call vs_audio_setReverbEffect;
	};

	[_id,false] call vs_audio_setPaused; //звук готов - можно воспроизводить
	traceformat("[%1] sound played: %2; follow: %3; distance: %4; src: %5",_id arg _soundPath arg _doFollow arg _distance arg _source);
	
	if (_doFollow) then {
		if (_is2d) exitWith {}; //2d sounds has no effects 
		private _asyncParams = [_id];
		_asyncParams append _sourceParams;
		_asyncParams pushBack _distance;
		_asyncParams pushback (tickTime + VS_AUDIO_NEXT_EFFECT_UPDATE);

		vs_audio_followedData pushBack _asyncParams;
	};

	_id
};


vs_audio_playSound3dDynamicLooped = {
	params ["_file","_src",["_pitch",1],["_dist",10],["_preendbuf",0],["_vol",1]];

	//params ["_source","_soundPath","_distance",["_pitch",1],["_offset",0],["_vol",1],["_useEffects",true],["_loop",false]];

	private _sdata = [_src,PATH_SOUND(_file),_dist,_pitch,null,_vol,true];
	private _sdataEmplace = array_copy(_sdata);
	if equalTypes(_pitch,[]) then {
		_pitch = rand(_pitch select 0,_pitch select 1);
		_sdataEmplace set [3,_pitch];
	};
	private _shndl = _sdataEmplace call vs_audio_playSound3d;

	if (_shndl == "0") exitWith {null};

	private _params = [_src,_shndl,_preendbuf,_sdata];
	vs_audio_loopedSoundsData pushBack _params;
	_shndl
};

vs_audio_loopedSoundsData = []; //looped sounds
vs_audio_followedData = []; //followed sounds

vs_audio_onUpdate = {
	private _idxDel = [];
	private _pos = null;
	private _lowp = null;
	private _reverb = null;
	{
		_x params ["_id","_obj","_offset","_distance","_nextEffectUpd"];
		if !(_id call vs_audio_isSoundExists) then {
			_idxDel pushback _foreachIndex;
			continue
		};
		if isNullReference(_obj call vs_audio_internal_getSourceObj) then {
			_id call vs_audio_stopSound;
			_idxDel pushBack _foreachIndex;
			continue;
		};
		
		_pos = ((_obj call vs_audio_internal_getSourceObj) modeltoworldvisual _offset);
		[_id,_pos] call vs_audio_setSoundPos;

		if (tickTime >= _nextEffectUpd) then {
			_lowp = [_pos,true,_id] call vs_calcLowpassEffect;
			_reverb = [_pos,true,_id,_distance] call vs_calcReverbEffect;
			
			_lowp call vs_audio_setLowpassEffect;
			_reverb call vs_audio_setReverbEffect;
			
			_x set [4,tickTime + VS_AUDIO_NEXT_EFFECT_UPDATE];
		};

	} foreach vs_audio_followedData;

	if (count _idxDel > 0) then {
		vs_audio_followedData deleteAt _idxDel;
	};
};

vs_audio_onUpdateLooped = {

	private _del = [];
	private _spar = [];
	private _doRestart = false;
	{
		_x params ["_src","_shndl","_preend","_sdata"];
		if isNullReference(_src) then {
			_shndl call vs_audio_stopSound;
			_del pushBack _foreachIndex;
			continue;
		};

		_spar = [_shndl] call vs_audio_getSoundParams;

		_doRestart = false;
		if (count _spar == 0) then {
			_doRestart = true;
		} else {
			private _maxLen = _spar select 2;
			private _time = _spar select 1;
			if (_maxLen > 0) then {
				_doRestart = _time >= (_maxLen - _preend);
			};
		};

		if (_doRestart) then {
			private _pitch = _sdata select 3;
			private _sdataEmplace = array_copy(_sdata);
			if equalTypes(_pitch,[]) then {
				_pitch = rand(_pitch select 0,_pitch select 1);
				_sdataEmplace set [3,_pitch];
			};
			private _newHndl = _sdataEmplace call vs_audio_playSound3d;
			if (_newHndl == "0") then {
				_del pushBack _foreachIndex;
				continue;
			};
			_x set [1,_newHndl];
		};
	} foreach vs_audio_loopedSoundsData;

	if (count _del > 0) then {
		vs_audio_loopedSoundsData deleteAt _del;
	};
};

vs_audio_playSound2d = {
	params ["_soundPath",["_pitch",1],["_offset",0],["_vol",1],["_useEffects",true],["_loop",false]];
	[null,_soundPath,-1,_pitch,_offset,_vol,_useEffects,_loop] call vs_audio_playSound3d;
};

vs_audio_internal_getSourceObj = {
	if equalTypes(_this,objNull) exitWith {_this};
	noe_client_allPointers getOrDefault [_this,objNull];
};

vs_audio_setSoundPos = {
	params ["_id","_pos"];
	private _params = [_id];
	_params append _pos;
	apiCmd [CMD_AUDIO_SET_SOUND_POS,_params];
};

vs_audio_setPaused = {
	params ["_id","_paused"];
	apiCmd [CMD_AUDIO_SET_PAUSED,[_id,_paused]];
};

vs_audio_setLowpassEffect = {
    params ["_id",["_cut",22000],["_res",10]];
    apiCmd [CMD_AUDIO_SETLOWPASS,[_id,_cut,_res]];
};

vs_audio_setReverbEffect = {
    params ["_id",["_dec",1200],["_edel",20],["_ldel",40],["_hcut",8000],["_wet",-80],["_dry",0]];
    apiCmd [CMD_AUDIO_SETREVERB,[_id,_dec,_edel,_ldel,_hcut,_wet,_dry]];
};

// Returns [progress 0..1, current time seconds, duration seconds].
vs_audio_getSoundParams = {
	params ["_id"];
	if !(_id call vs_audio_isSoundExists) exitWith {[]};
	((apiCmd [CMD_AUDIO_GET_SOUND_PARAMS,[_id]]) select 0) splitString " " apply {parseNumber _x};
};

vs_audio_setLoopPoints = {
	params ["_id","_startMs","_endMs"];
	apiCmd [CMD_AUDIO_SET_LOOP_POINTS,[_id,_startMs,_endMs]];
};
