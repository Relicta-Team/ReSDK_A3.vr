// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Реализация аудиосистемы на основе ReVoice с использованием fmod
*/

vs_audio_useBackend = true; // использовать новый движок аудио

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
	parseNumber (apiRequest(REQ_AUDIO_GET_MASTER_SOUND_VOLUME));
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
		private _asyncParams = [_id];
		_asyncParams append _sourceParams;
		_asyncParams pushBack _distance;

		startAsyncInvoke
		{
			params ["_id","_obj","_offset","_distance"];
			if !(_id call vs_audio_isSoundExists) exitWith {true};
			
			if isNullReference(_obj call vs_audio_internal_getSourceObj) exitWith {
				_id call vs_audio_stopSound;
				true;
			};
			private _pos = ((_obj call vs_audio_internal_getSourceObj) modeltoworldvisual _offset);
			[_id,_pos] call vs_audio_setSoundPos;
			private _lowp = [_pos,true,_id] call vs_calcLowpassEffect;
			private _reverb = [_pos,true,_id,_distance] call vs_calcReverbEffect;
			
			_lowp call vs_audio_setLowpassEffect;
			_reverb call vs_audio_setReverbEffect;
			traceformat("[%3] lowp: %1, reverb: %2",_lowp arg _reverb arg _obj);
			false
		},
		{},
		_asyncParams
		endAsyncInvoke
	};

	_id
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

vs_audio_getSoundParams = {
	params ["_id"];
	if !(_id call vs_audio_isSoundExists) exitWith {[]};
	((apiCmd [CMD_AUDIO_GET_SOUND_PARAMS,[_id]]) select 0) splitString " " apply {parseNumber _x};
};