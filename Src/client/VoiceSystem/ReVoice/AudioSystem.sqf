// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Реализация аудиосистемы на основе ReVoice с использованием fmod
*/

vs_audio_useBackend = true; // использовать новый движок аудио

// получает все работающие звуки в игре
vs_audio_getAllSoundsIds = {
	//get hashset of all sounds
	apiRequest(REQ_AUDIO_GET_ALL_SOUNDS_IDS) splitString " " apply {parseNumber _x};
};

vs_audio_isSoundExists = {
	((apiCmd [CMD_AUDIO_IS_SOUND_EXISTS,[_this]]) select 0) == "True";
};

vs_audio_stopSound = {
	((apiCmd [CMD_AUDIO_STOP_SOUND,[_this]]) select 0) == "True";
};

vs_audio_stopAllSounds = {
	{
		_this call vs_audio_stopSound;
	} foreach (call vs_audio_getAllSoundsIds);
};

vs_audio_releaseAllSounds = {
	//global free all audio sources
	apiRequest(REQ_AUDIO_RELEASE_ALL_SOUNDS);
};

vs_audio_init = {
	if (!vs_audio_useBackend) exitWith {};


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
				_pos = atltoasl((_obj call vs_audio_internal_getSourceObj) modeltoworldvisual _offset);
			};
		} else {
			_pos = getPosASL (_source call vs_audio_internal_getSourceObj);
		};
	};

	private _soundParams = [_soundPath];
	_soundParams append _pos;
	_soundParams append [_distance,_pitch,_offset,_vol,_is2d,_loop];

	private _id = (apiCmd [CMD_AUDIO_PLAY_SOUND,_soundParams]) select 0;
	if (_useEffects) then {
		//TODO: set effects
	};

	if (_doFollow) then {
		private _asyncParams = [_id];
		_asyncParams append _sourceParams;

		startAsyncInvoke
		{
			params ["_id","_obj","_offset"];
			if !(_id call vs_audio_isSoundExists) exitWith {true};
			
			if isNullReference(_obj call vs_audio_internal_getSourceObj) exitWith {
				_id call vs_audio_stopSound;
				true;
			};
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