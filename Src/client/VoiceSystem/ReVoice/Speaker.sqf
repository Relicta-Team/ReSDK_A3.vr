// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! deprecated section
vs_transmithDistance = 1000;
vs_curTransmithType = 0; //режим передачи
vs_transmithTypes = ["digital","digital_lr","airborne"];

//список всех спикеров (рации\динамики). ключ - указатель на объект, значение - структура radioData
vs_allRadioSpeakers = createHashMap;
//рации в руках игроков
vs_allInventoryRadios = createHashMap; //ключ - указатель на объект, значение - структура radioData

//локальная мапа кто говорит в частоты
vs_map_waveSpeakers = createHashMap; // 

//! deprecated
//сетевая переменная, публикующаяся на сервере и синхронизирующаяся с клиентами
// vs_netSpeakers = [];

vs_addRadioStream = {
	params ["_ptr"];
	(apiCmd [CMD_RADIO_ADD,[_ptr]]) params ["_r","_rcode"];
	_r == "ok";
};

vs_removeRadioStream = {
	params ["_ptr"];
	(apiCmd [CMD_RADIO_REMOVE,[_ptr]]) params ["_r","_rcode"];
	_r == "ok";
};

vs_radioSpeakProcess = {
	params ["_obj","_mode"];
	
	private _data = _obj call vs_getObjectRadioData;

	private _args = [player,_data get "ptr"];
	private _rpcName = "vssrv_spk";
	if (_mode) then {
		_rpcName = "vssrv_spk";
	} else {
		_rpcName = "vssrv_nspk";
	};

	rpcSendToServer(_rpcName,_args);
};

#define REVOICE_SPEAKER_MAKEDATA(_p,_wave) [_p,_wave]
#define REVOICE_SPEAKER_GETPTR(_data) ((_data) select 0)
#define REVOICE_SPEAKER_GETWAVEPOWER(_data) ((_data) select 1)

//вызывается когда какой-то игрок начал говорить в частоту
vs_onRadioSpeakStarted = {
	params ["_actorName","_ptr","_freq","_wavePower"];

	if (_freq in vs_map_waveSpeakers) then {
		private _playersMap = vs_map_waveSpeakers get _freq;
		_playersMap set [_actorName,REVOICE_SPEAKER_MAKEDATA(_ptr,_wavePower)];
	} else {
		private _playersMap = createHashMapFromArray [[_actorName,REVOICE_SPEAKER_MAKEDATA(_ptr,_wavePower)]];
		vs_map_waveSpeakers set [_freq,_playersMap];
	};
};

//вызывается когда какой-то игрок закончил говорить в частоту
vs_onRadioSpeakStopped = {
	params ["_actorName","_ptr","_freq"];

	private _playersMap = vs_map_waveSpeakers get _freq;
	if !isNullVar(_playersMap) then {
		_playersMap deleteAt _actorName;
		if (count _playersMap == 0) then {
			vs_map_waveSpeakers deleteAt _freq;
		};
	};
};

if (isMultiplayer) then {
	rpcAdd("vsr_onspk",vs_onRadioSpeakStarted);
	rpcAdd("vsr_onnspk",vs_onRadioSpeakStopped);
};

vs_getObjectRadioData = {
	params ["_obj"];
	_obj getVariable "__radio_data";
};

//noe functions
vs_loadWorldRadio = {
	params ["_obj","_radioData","_ptr",["_isInHand",false]];

	private _rdataInfo = [_obj,_radioData,_ptr] call vs_prepRadioDataInternal;
	if (_isInHand) then {
		_rdataInfo set ["isInHand",true];
	};

	if (_isInHand) then {
		vs_allInventoryRadios set [_ptr,_rdataInfo];
	} else {
		vs_allRadioSpeakers set [_ptr,_rdataInfo];
	};

	[_ptr] call vs_addRadioStream;
};

vs_prepRadioDataInternal = {
	params ["_obj","_radioData","_ptr"];

	_radioData params ["_freq",["_vol",1],["_dist",10],["_bias",[0,0,0]],["_wavePower",-1]];
	
	private _data = createHashMapFromArray [
		["isInHand",false], //bool - находится ли радио в руке

		["freq",_freq], //string - ключ частоты
		["vol",_vol], //float - громкость
		["dist",_dist], //float - дистанция слышимости
		["bias",_bias], //vec3 - смещение относительно источника
		["wavePower",_wavePower], //float - мощность радио
		["obj",_obj], //obj - объект радио
		["ptr",_ptr] //ptr - указатель на объект радио
	];

	_obj setVariable ["__radio_data",_data];

	_data
};

vs_unloadWorldRadio = {
	params ["_obj",["_isInHand",false]];
	private _data = _obj call vs_getObjectRadioData;
	if isNullVar(_data) exitWith {false};

	private _ptr = _data get "ptr";
	if (_isInHand) then {
		vs_allInventoryRadios deleteAt _ptr;
	} else {
		vs_allRadioSpeakers deleteAt _ptr;
	};

	[_ptr] call vs_removeRadioStream;

	_obj setVariable ["__radio_data",null];

	true;
};

vs_isWorldRadioObject = {
	params ["_obj"];
	!isNull(_obj getVariable "__radio_data");
};

vs_processRadios = {
	
	private _allSpeakers = vs_map_waveSpeakers; //map<freq:string,players:map<string:name,float:wavePower>>
	
	private _iterator = {
		private _rdata = _y;
		private _radioObj = _rdata get "obj";
		private _freq = _rdata get "freq";

		//можем слышать радио
		if (_freq in _allSpeakers) then {
			private _playersMap = _allSpeakers get _freq;
			
			[_rdata,_playersMap] call vs_handleRadioRetranslateStreamInternal;
			
			//синхронизируем позицию и громкость радио
			[_rdata] call vs_handleRadioSpeakInternal;
		};
	}; 
	_iterator foreach vs_allRadioSpeakers;
	_iterator foreach vs_allInventoryRadios;
};

//активирует ретрансляцию радио с клиентов на указанный источник. автоматически подписывается на событие радиопередачи
vs_handleRadioRetranslateStreamInternal = {
	params ["_rdata","_usersMap"];

	private _ptr = _rdata get "ptr";

	// Фильтруем игроков, которые говорят в эту же рацию - исключаем их имена из подписки
	private _filteredKeys = [];
	{
		private _playerName = _x;
		private _playerData = _y;
		private _playerPtr = REVOICE_SPEAKER_GETPTR(_playerData);
		
		// Если игрок говорит в эту же рацию, не добавляем его в список подписки
		if (_playerPtr != _ptr) then {
			_filteredKeys pushBack _playerName;
		};
	} foreach _usersMap;

	// создает стримы на каналгруппе. стримы будут удалены когда источник будет уничтожен
	apiCmd [CMD_RADIO_SUBSCRIBE_RADIOSTREAM,[_ptr,_filteredKeys joinString ";"]] params ["_r","_rcode"];
	
	if (_r != "ok") exitWith {};

	//определяем радиоэффект в зависимости от мощности радио
	private _playerDistMap = createHashMapFromArray (
		#ifdef REDITOR_VOICE_DEBUG
		vs_reditor_procObjList
		#else
		cm_allInGamePlayerMobs 
		#endif
		apply {
			[_x getvariable "rv_name",
				#ifdef REDITOR_VOICE_DEBUG
				get3dencamera distance _x
				#else
				player distance _x
				#endif
			]
		}
	);

	//применяем шум радио в зависимости от дистанции до игрока
	{
		if !(_x in _filteredKeys) then {continue};
		
		private _targetDist = _playerDistMap get _x;
		private _data = _y;
		private _waveDist = REVOICE_SPEAKER_GETWAVEPOWER(_data);
		private _filterValue = if (_waveDist == -1) then {
			//это устройство без ограничений на дистанцию (телефония, интеркомы и т.п.)
			0;
		} else {
			_targetDist / _waveDist; //normalized value from 0 to 1
		};
		
		(apiCmd [CMD_RADIO_APPLY_WAVE_FILTER,[_ptr,_x,_filterValue]]) params ["_r","_rcode"];
		
	} foreach _usersMap;
};

//синхронизируем позицию радио и эффекты
vs_handleRadioSpeakInternal = {
	params ["_rdata"];

	private _obj = _rdata get "obj";
	private _params = [_rdata get "ptr"];
	_params append (_obj modelToWorldVisual (_rdata get "bias"));
	_params append (vectorDir _obj);
	_params pushback (_rdata get "dist");
	private _vol = _rdata get "vol";
	_params pushback _vol;

	private _result = apiCmd [CMD_SYNC_REMOTE_RADIO,_params];

	if ((_result select 0) == "ok") then {
		private _params = [_obj] call vs_calcLowpassEffect;
		_params set [0,_rdata get "ptr"];
		apiCmd [CMD_SYNC_REMOTE_RADIO_LOWPASS,_params];

		_params = [_obj] call vs_calcReverbEffect;
		_params set [0,_rdata get "ptr"];
		apiCmd [CMD_SYNC_REMOTE_RADIO_REVERB,_params];
	};
};

//возвращает ближайшие радио которые могут слышать игрока
vs_getNearReceiverRadioObjects = {
	
	private _ppos = player modeltoworldvisual (player selectionposition "head");
	private _nearRadios = [];
	private _maxDist = 2;
	private _iterator = {
		private _rdata = _y;
		private _obj = _rdata get "obj";
		private _dist = _ppos distance _obj;
		if (_dist < _maxDist) then {
			_nearRadios pushback _obj;
		};
	}; 
	_iterator foreach vs_allRadioSpeakers;

	_maxDist = 1; //для раций в руках максимальная дистанция 1 метр
	_iterator foreach vs_allInventoryRadios;

	_nearRadios;
};

vs_localReceivers = [];
vs_hasTalkingOnRadio = {count vs_localReceivers > 0};

//обработчик общения по рации. вызывается внутри апи обычного войса
vs_handleMicRadioObjects = {
	params ["_mode"];
	if equals(_mode,call vs_hasTalkingOnRadio) exitWith {};
	if (_mode) then {
		vs_localReceivers = call vs_getNearReceiverRadioObjects;
		{
			[_x,true] call vs_radioSpeakProcess;
		} foreach vs_localReceivers;
	} else {
		{
			[_x,false] call vs_radioSpeakProcess;
		} foreach vs_localReceivers;
		vs_localReceivers = [];
	};
};