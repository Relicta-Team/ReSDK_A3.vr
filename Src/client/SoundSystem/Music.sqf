// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(AudioSystem.Music,music_)

#include <Music.hpp>

/*
	Менеджер музыки (ОБНОВЛЕННЫЙ)
	
	По-умолчанию все дорожки воспроизводятся от полных путей
	При регистрации в конфигурации музыка представлена в виде:
	
	class rm_[index] {
		name = 'path'; - путь до музыки 
		sound[] = {PATHMUSICCFG(path), db+0, 1.0};  - полный путь до файла музыки
		titles[] = {0,""};
		duration = dur; - длительность в секундах
	}
	
	Позже это оборачивается макросом но суть не меняется
	Имя класса это просто указатель на композицию. Он может быть изменён. Не следует их использовать в интерфейсах
	
	-------
	Пожелания:
	- должны быть заранее подготовленные пользовательские альбомы для быстрого переключения 
		(пример вышел из города в пещеры - заиграла пещерная тема, умер - играет тема призрака)
	- внутренняя логика приоритетов:
		запущенные композиции с повышенным приоритетом перехватывают звуковой канал
	- создание звуковых объектов
		- при запуске определенной композиции возвращается хандлер музыки в котором вся необходимая информация
	
	--------
	Принцип работы компонента:
		- Инициализация
			система собирает из файла конфигурации все дорожки и генерирует двойную хэш-карту
			для понимания связей класса и дорожки
			Так же система проводит дополнительную валидацию путей чтобы не добавлять сломанные дорожки в лист
			
			Далее система генерирует карту ассоциаций категорий (папки в которых музыка) с путем до дорожек
			для быстрого запуска целого списка композиций
		- запуск, пауза и остановка
		
		- переменные звукового объекта:
			- file - путь до звукового файла
			- priority - Звуки с более высоким приоритетом могут перехватывать 
				каналы у звуков с более низким приоритетом. Максимальное значение 
				равно 255. 0 является наименьшим
			- repeat - 1 - повторяет звук после конца, 0 по умолчанию
			- volume - значение от 0 до 100 действует как аплификатор музыки
			- smooth - 0 - без плавного перехода, 1 - плавное начало, 2 плавный конец, 3 плавное начало и конец
			- wait - установите в true чтобы дождаться окончания других звуков на этом канале. в противном случае стартует немедленно
*/

//двойная ассоциация класса и пути
decl(map<string;string>)
music_internal_class2path = createHashMap;
decl(map<string;string>)
music_internal_path2class = createHashMap;
//хэш карта папок и композиций внутри них
decl(map<string;string[]>)
music_internal_folderData = createHashMap;
//карта длительности (key: musicname, val: duration)
decl(map<string;float>)
music_internal_durationMap = createHashMap;

//объект композиции который играет в данную минуту
decl(map<string;any>|NULL)
music_playedObject = null;

_cfg = missionConfigFile;
#ifndef USE_LOCAL_PATHES
_cfg = configFile;
#endif


//инициализация
_idxMax = getNumber(_cfg >> "cfgMusic" >> "maxRMIndex");
for "_i" from 0 to _idxMax do {
	_class = (_cfg >> "cfgMusic" >> "rm_"+str _i);
	_className = tolower(configName _class);
	_musicName = tolower getText(_class >> "name");
	
	music_internal_class2path set [_className,_musicName];
	music_internal_path2class set [_musicName,_className];
	
	music_internal_durationMap set [_musicName,getNumber(_class >> "duration")];
	
	_dat = (_musicName splitString "\");
	if (count _dat > 1) then {
		_list = music_internal_folderData getOrDefault [_dat select 0,[]];
		_list pushBack _musicName;
		music_internal_folderData set [_dat select 0,_list];
	} else {
		_list = music_internal_folderData getOrDefault ["",[]];
		_list pushBack _musicName;
		music_internal_folderData set ["",_list];
	};
};
macro_const(music_BUFFER_PRIORITY_MAX)
#define BUFFER_PRIORITY_MAX 32

macro_def(music_debugMode)
#define MUSIC_DEBUG

#ifdef RELEASE
#undef MUSIC_DEBUG
#endif

#ifdef MUSIC_DEBUG
	inline_macro
	#define mlog(text) log("[MUSIC::DEBUG]: " + text);
	inline_macro
	#define mlogformat(text,args) logformat("[MUSIC::DEBUG]: " + text,args);
#else
	#define mlog(text) 
	#define mlogformat(text,args) 
#endif

//reset vars
playMusic "";
0 fadeMusic 1;

decl(any[]) music_internal_priority = [];
decl(any[]) music_internal_paused = [];
decl(int) music_internal_lastPriority = -1;

_buffer = [];
_buffer resize (BUFFER_PRIORITY_MAX+1);
music_internal_priority = _buffer apply {[]};
music_internal_paused = _buffer apply {false};
music_internal_lastPriority = -1;

// воспроизведение музыки: ["testmusic.ogg",0,[["repeat",true]]] call music_play
/*
	Параметры (_params): 
	- repeat - true - повторяет звук после конца, false по умолчанию. В <Music.hpp> макросы
	- volume - значение от 0 до 100 действует как аплификатор музыки
	- smooth - 0 - без плавного перехода, 1 - плавное начало, 2 плавный конец, 3 плавное начало и конец. 
		для удобства используйте макросы в <Music.hpp> (прим. MUSIC_SMOOTH_FULL)
		- smoothdelay - время задержки затухания, по умолчанию MUSIC_SMOOTH_TIME_DEFAULT
	- wait - установите в true чтобы дождаться окончания других звуков на этом канале. в противном случае стартует немедленно
	- start - стартовая позиция трека. по умолчанию 0
*/
decl(void(string;int;any[]))
music_play = {
	params ["_file",["_priority",0],["_params",[]]];
	
	_file = tolower _file;
	
	if !(".ogg" in _file) then {
		modvar(_file) + ".ogg";
	};
	
	private _class = music_internal_path2class getOrDefault [_file,"NULLCLASS"];
	if (_class == "NULLCLASS") exitWith {
		errorformat("music::play() - cannot find class for music %1",_file);
	};
	
	if !inRange(_priority,0,BUFFER_PRIORITY_MAX) then {
		errorformat("music::play() - priority error %1 - new priority is 0",_priority);
		_priority = 0;
	};
	
	private _uniqueParams = [];
	private _countParams = count _params;
	
	private _repeat = MUSIC_REPEAT_NO;
	private _volume = 100;
	private _smooth = 0;
	private _wait = false;
	private _start = 0;
	private _smoothdelay = MUSIC_SMOOTH_TIME_DEFAULT;
	
	private _dur = music_internal_durationMap getOrDefault [_file,0];
	if (_dur == 0) exitWith {
		errorformat("music::play() - duration getting process failed %1",_file);
	};
	
	//handler params
	{
		_x params ["_key","_val"];
		_key = tolower _key;
		call {
			if (_key in _uniqueParams) exitWith {
				errorformat("music::play() - duplicate param %1",_key);
				continue;
			};
			if (_key == "repeat") exitWith {
				if equalTypes(_val,true) then {_val = ifcheck(_val,MUSIC_REPEAT_YES,MUSIC_REPEAT_NO)};
				_repeat = _val;
			};
			if (_key == "volume") exitWith {
				_volume = _val;
			};
			if (_key == "smooth") exitWith {
				_smooth = _val;
			};
			if (_key == "smoothdelay") exitWith {
				if !inRange(_val,0,_dur) exitWith {
					errorformat("music::play() - smooth delay out of range: value %1, duration %2",_val arg _dur);
					continue;
				};
				_smoothdelay = _val;
			};
			if (_key == "wait") exitWith {
				_wait = _val;
			};
			if (_key == "start") exitWith {
				if (_val >= _dur) exitWith {
					errorformat("music::play() - start position is too much: value %1, duration %2",_val arg _dur);
					continue;
				};
				_start = _val;
			};
		};

		_uniqueParams pushBack _key;
	} foreach _params;
	
	private _mmap = createHashMapFromArray [
		["file",_file],
		["repeat",_repeat],
		["smooth",_smooth],
		["smoothdelay",_smoothdelay],
		["volume",linearConversion[0,100,_volume,0,1,true]],
		["wait",_wait],
		["start",_start],
		//internal vars
		["class",music_internal_path2class get _file], 
		["duration",_dur],
		["tickstart",0], //отметка запуска
		["curtime",_start], //сколько уже отыграло
		["priority",_priority], //в каком канале этот трек
		["isplayed",false]
	];
	
	//Получаем текущий уровень
	private _buf = music_internal_priority;
	private _cur = _buf select _priority;
	//если не пусто то
	if (count _cur > 0) then {
		mlog("count more than 0")
		//если мы не ждем то сразу очищаем всё это
		if (!_wait) then {
			mlogformat("await disabled - cleanup priority %1",_priority)
			_cur resize 0;
		};
	};
	//добавление в очередь
	_cur pushBack _mmap;
	mlogformat("Added new music %1 on layer %2",_file arg _priority)
	
}; rpcAdd("mpl",music_play);

//строковая карта всех каналов
decl(map<string;int>)
music_internal_map_chanToEnum = createHashMapFromArray MUSIC_MAP_INTERNAL_ALLCHANNELS;

decl(void(...any[]))
music_internal_mproc = {
	_t = _this deleteAt 0;
	
	private _chanToEnum = {music_internal_map_chanToEnum getOrDefault [_this,MUSIC_CHANNEL_BASE]};
	
	//play
	if (_t == 0) exitWith {
		_this params ["_fileorlist","_chan","_settings"];
		
		if equalTypes(_chan,"") then {_chan = _chan call _chanToEnum};
		
		if equals(_settings,"stdlist") then {
			_settings = [
				["wait",true],
				["repeat",MUSIC_REPEAT_AND_BACKWARD],
				["smooth",MUSIC_SMOOTH_FULL]
			];
		};
		
		if equalTypes(_fileorlist,[]) then {
			{
				[_x,_chan,_settings] call music_play;
			} foreach _fileorlist;
		} else {
			if (_fileorlist select [0,1] == "!") then {
				private _l = music_internal_folderData get (_fileorlist select [1,count _fileorlist]);
				if isNullVar(_l) exitWith {};
				{[_x,_chan,_settings] call music_play} foreach array_shuffle(_l);
			} else {
				[_fileorlist,_chan,_settings] call music_play;
			};
		};
	};
	//pause
	if (_t == 1) exitWith {
		_this params ["_chan","_ispause","_smooth"];
		
		if equalTypes(_chan,"") then {_chan = _chan call _chanToEnum};
		
		[_chan,_ispause,_smooth] call music_setPause;
	};
	//stop
	if (_t == 2) exitWith {
		_this params ["_chan"];
		
		if equalTypes(_chan,"") then {_chan = _chan call _chanToEnum};
		
		[_chan] call music_stop;
	};
}; 

rpcAdd("mproc",music_internal_mproc);

decl(void(int;bool;bool))
music_setPause = {
	params ["_chan","_mode",["_smooth",false]];
	if !inRange(_chan,-1,BUFFER_PRIORITY_MAX) exitWith {
		errorformat("music::setPause() - priority error %1 - out of range",_chan);
	};
	if equals(_chan,-1) then {
		{
			music_internal_paused set [_forEachIndex,_mode];
		} foreach music_internal_paused;
	} else {
		music_internal_paused set [_chan,_mode];
	};
	if !isNull(music_playedObject) then {
		if (music_playedObject get "priority" in [_chan,-1]) then {
			music_playedObject set ["isplayed",false];
			
			mlogformat("Stopped music (ON PAUSE) %1 at %2",music_playedObject get "class" arg music_playedObject get "curtime")
			if (_smooth) then {
				_obj = music_playedObject;
				//мы можем тут делать затухание при любом режиме плавной музыки
				//if (_obj get "smooth" >= MUSIC_SMOOTH_END) then {
					//TODO: тут можно помозговать маленько
					[0,_obj get "smoothdelay"] call music_internal_setFade;
				//} else {
					//playMusic "";
				//};
			} else {
				playMusic "";
			};
			music_playedObject = null;
		};
	};
};

//принудительная остановка музыки на данном канале и очистка канала. параметр -1 чистит все каналы
decl(void(int))
music_stop = {
	params [["_chan",-1]];
	FHEADER;
	if (_chan == -1) then {
		{
			music_internal_priority set [_forEachIndex,[]];
		} foreach music_internal_priority;
		
		music_playedObject = null;
		playMusic "";
	} else {
		if !inRange(_chan,0,BUFFER_PRIORITY_MAX) then {
			errorformat("music::stop() - priority error %1 - out of range",_chan);
			RETURN(0);
		};
		music_internal_priority set [_chan,[]];
		
		if !isNull(music_playedObject) then {
			if (music_playedObject get "priority" == _chan && music_playedObject get "isplayed") then {
				music_playedObject = null;
				playMusic "";
			};
		};
	};
};

decl(void(float;float))
music_internal_setFade = {
	params ["_fade",["_time",-1]];
	_time fadeMusic _fade;
};

decl(void())
music_internal_onUpdate = {
	
	_buf = music_internal_priority;
	_paused = music_internal_paused;
	_curcha = null;
	//находим текущий слой
	for "_i" from BUFFER_PRIORITY_MAX+1 to 0 step -1 do {
		if (_paused select _i) then {continue};
		if (count (_buf select _i) > 0) exitWith {
			_curcha = _buf select _i;
			music_internal_lastPriority = _i;
		};
	};
	//ничего не играет
	if isNullVar(_curcha) exitWith {music_internal_lastPriority = -1};
	_obj = _curcha select 0;
	//музыка не играет - запускаем
	if !(_obj get "isplayed") then {
		if !isNull(music_playedObject) then {
			music_playedObject set ["isplayed",false];
			playMusic "";
			mlogformat("Stopped prev music %1 at %2",music_playedObject get "class" arg music_playedObject get "curtime")
		};
		
		mlogformat("Played music %1 at %2",_obj get "class" arg _obj get "curtime")
		music_playedObject = _obj;
		_obj set ["isplayed",true];
		_obj set ["tickstart",tickTime];
		_smooth = _obj get "smooth";
		_canSmooth = _smooth in [MUSIC_SMOOTH_START,MUSIC_SMOOTH_FULL];
		if (_canSmooth) then {
			[0] call music_internal_setFade;
		};	
		playMusic [_obj get "class",_obj get "curtime"];
		[_obj get "volume",ifcheck(_canSmooth,_obj get "smoothdelay",-1)] call music_internal_setFade;
	} else {
		//хандлер запущенной музыки
		_obj set ["curtime",(_obj get "start") + tickTime - (_obj get "tickstart")];
		_dur = _obj get "duration";
		_cur = _obj get "curtime";
		_canSmoothEnd = (_obj get "smooth") >= MUSIC_SMOOTH_END;
		
		//это плавный конец
		if (_cur >= (_dur - (_obj get "smoothdelay")) && _canSmoothEnd) then {
			if !("_flag_smoothend" in _obj) then {
				mlogformat("Music started smooth %1 at position %2",_obj get "class" arg _obj get "curtime")
				_obj set ["_flag_smoothend",true];
				[0,_obj get "smoothdelay"] call music_internal_setFade;
			};
		};
		
		//это конец дорожки
		if (_cur >= _dur) then {
			_obj deleteAt "_flag_smoothend";
			_repeatMode = _obj get "repeat";
			call {
				if (_repeatMode == MUSIC_REPEAT_NO) exitWith {
					mlogformat("Music ended %1",_obj get "class")
					_curcha deleteAt 0;
				};
				if (_repeatMode == MUSIC_REPEAT_YES) exitWith {
					mlogformat("Music ended and will be repeated %1",_obj get "class")
					_obj set ["isplayed",false];
					_obj set ["curtime",_obj get "start"];
				};
				if (_repeatMode == MUSIC_REPEAT_AND_BACKWARD) exitWith {
					mlogformat("Music ended and emplaced back %1",_obj get "class")
					_obj set ["isplayed",false];
					_obj set ["curtime",_obj get "start"];
					_curcha deleteAt 0;
					_curcha pushBack _obj;
				};
			};
			music_playedObject = null;
			playMusic "";
		};
	};
	
};

decl(int)
music_internal_handleOnUpdate = -1;

music_internal_handleOnUpdate = startUpdate(music_internal_onUpdate,0);
