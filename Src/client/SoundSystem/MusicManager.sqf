// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#define getStructData(var) (music_currentPlay get var)
#define setStructData(var,val) music_currentPlay set [var,val]

music_categories = hashSet_createList("ambient" arg "caveambient" arg "lobby" arg "events");
music_durations = createHashMap;
music_currentPlay = createHashMapFromArray [["type","nan"],["duration",0],["isplaying",false]];
music_volume = 1;
//music_counters = createHashMapFromArray []; //сколько конфигураций для музыки
music_mainThread_handle = -1;
music_lastPlayedTheme = "";

if (isNull(music_lobbyTheme) || !isMultiplayer) then {
	//тема реплицируется по сети. в противном случае задействуется эта
	//music_lobbyTheme = "lobby_1"; 
	//music_settedLobbyTheme = "lobby_1";
	//Не будет музыки пока сервер её не поставит
	music_lobbyTheme = "";
};	

music_settedLobbyTheme = "";

//Создаёт структуру категории музыки
music_internal_createStruct = {
	params ["_countSounds"];
	createHashMapFromArray [["count",_countSounds]]
};	

//сборс параметров музыки
music_resetCurrentPlayMemory = {
	music_currentPlay set ["type","nan"];
	music_currentPlay set ["duration",0];
	music_currentPlay set ["isplaying",false];
};
//Вызывается только внутри запускатора музыки
music_initCurrentPlayMemory = {
	params ["_t","_d"];
	music_currentPlay set ["type",_t];
	music_currentPlay set ["duration",_d];
	music_currentPlay set ["isplaying",true];
};

//Находится ли музыка в буфере
music_isStarted = {getStructData("type")!="nan"};
//играет ли музка в данный момент
music_isPlaying = {getStructData("isplaying")};

//пауза музыки
music_pause = {
	music_currentPlay set ["duration",call music_getPlayedTime];
	playMusic "";
};	

//возобновить проигрывание
music_return = {
	private _type = getStructData("type");
	if equals(_type,"nan") then {
		false;
	} else {
		playMusic [getStructData("type"),getStructData("duration")];
		true
	};
};	

//Вовзаращет текущее время с начала композиции
music_getPlayedTime = {
	getMusicPlayedTime
};

music_play = {
	params ["_config",["_startTime",0]];
	
	music_lastPlayedTheme = getStructData("type");
	
	private _dur = music_durations getOrDefault [tolower _config,-1];
	if (_dur == -1) exitWith {
		errorformat("music::play() - Cant play music %1: Duration is undefined",_config);
	};
	
	playMusic [_config,_startTime];
	
	[_config,_dur] call music_initCurrentPlayMemory;
};

music_stop = {
	params [["_fadetime",0]];
	if (_fadetime == 0) exitWith {
		playMusic "";
		call music_resetCurrentPlayMemory;
	};
	
	[0,_fadetime] call music_setVolume;
	
	private _code = {
		playMusic "";
		call music_resetCurrentPlayMemory;
		//reset
		[1] call music_setVolume;
	};	
	
	invokeAfterDelay(_code,_fadetime);
};	

//плавная смена композиции
music_changeToNew = {
	params ["_config","_startTime",["_fadeOld",5],["_fadeNew",5]];
	
	
};	

// ----- VOLUME MUSIC MANAGMENT ------
music_setVolume = {
	params ["_fade",["_time",0]];
	_time fadeMusic _fade;
};

// testing sound
music_playRandomAmbientMusic = {
	["ambient_" + str randInt(1,music_categories get "ambient" get "count")] call music_play;
};	

music_isStartedAmbientMode = false;

music_setRoundMusicMode = {
	params ["_mode"];
	
	music_isStartedAmbientMode = _mode;
	
	if (_mode) then {
		call music_playRandomAmbientMusic;
	} else {
		[0] call music_stop;
	};
};


//регулярный цикл обновления музыки
music_onUpdate = {
	
	if (call music_getPlayedTime >= (getStructData("duration"))) then {
		[0] call music_stop;
	};
	
	if (music_isStartedAmbientMode) then {
		if (call music_getPlayedTime >= (getStructData("duration") - 2)) then {
			call music_playRandomAmbientMusic;
		};
	};
	
	if (music_settedLobbyTheme != music_lobbyTheme) then {
		music_settedLobbyTheme = music_lobbyTheme;
		[music_lobbyTheme] call music_play;
	};
	
};
music_mainThread_handle = startUpdate(music_onUpdate,0);

#include "MusicManager_initialize.sqf"
