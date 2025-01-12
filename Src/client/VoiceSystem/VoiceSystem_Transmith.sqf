// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\Inventory\inventory.hpp>

vs_tangent_pressed = false;

vs_transmithDistance = 1000;

vs_curTransmithType = 0; //режим передачи
vs_transmithTypes = ["digital","digital_lr","airborne"];

//запускает потоковую передачу
vs_startTransmith = {
	params ["_freqAndCode",["_dist",vs_transmithDistance],["_curT","digital"]];
	
	vs_hasTransmithProcess = true;
	
	//["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _freqAndCode, 0, false, true]] call TFAR_fnc_fireEventHandlers;
	private _request = format[
		#ifdef VOICE_DEBUG
		"TANGENT"+TF_horizontal_tab+"PRESSED"+TF_horizontal_tab+"%1%2"+TF_horizontal_tab+"%3"+TF_horizontal_tab+"%4",		
		#else
		"TANGENT	PRESSED	%1%2	%3	%4",
		#endif
	_freqAndCode, ""/*code inlined in freq*/,
	_dist,
	_curT];
	
	vs_lastTransmithInfo set [1,[_freqAndCode,_dist,_curT]];
	
	"task_force_radio_pipe" callExtension _request;
	//vs_tangent_pressed = true;
	trace("Transmith started on " + _freqAndCode);
	
	//["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _freqAndCode, 0, false, true]] call TFAR_fnc_fireEventHandlers;
};

//останавливает потоковую передачу
vs_stopTransmith = {
	params ["_freqAndCode",["_dist",vs_transmithDistance],["_curT","digital"]];
	
	//["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _freqAndCode, 0, false, false]] call TFAR_fnc_fireEventHandlers;
	private _request = format[
		#ifdef VOICE_DEBUG
		"TANGENT"+TF_horizontal_tab+"RELEASED"+TF_horizontal_tab+"%1%2"+TF_horizontal_tab+"%3"+TF_horizontal_tab+"%4",		
		#else
		"TANGENT	RELEASED	%1%2	%3	%4",
		#endif
	_freqAndCode, ""/*code inlined in freq*/, 
	_dist,
	_curT];
	
	"task_force_radio_pipe" callExtension _request;
	//vs_tangent_pressed = false;
	trace("Transmith stopped on "+_freqAndCode);
		
	//["OnTangent", TFAR_currentUnit, [TFAR_currentUnit, _freqAndCode, 0, false, false]] call TFAR_fnc_fireEventHandlers;
};

#define VS_TRANSMITHINFO_DEFAULT [objNUll,["","",""]]
vs_hasTransmithProcess = false;
vs_lastTransmithInfo = VS_TRANSMITHINFO_DEFAULT; //object and radiocode

// Логика остановки передачи в радио
vs_doStopTransmith = {
	
	vs_hasTransmithProcess = false;
	
	private _tData = vs_lastTransmithInfo select 1;
	if ((_tData select 0) != "") then {_tData call vs_stopTransmith};
	vs_lastTransmithInfo = VS_TRANSMITHINFO_DEFAULT;
};

//запускаем передачу
vs_handleTransmith = {
	params ["_mode"];
	
	if equals(vs_hasTransmithProcess,_mode) exitWith {
		//warningformat("vs::handleTransmith() - already in mode %1",vs_hasTransmithProcess);
	};
	
	
	
	if (_mode) then {
		
		private _obj = call interact_cursorObject;
		if (_obj call vs_isWorldRadioObject && getRadioVar(_obj,canSpeak) && {_obj call vs_canUseIntercomObject}) then {
			vs_lastTransmithInfo set [0,_obj];
			[getRadioVar(_obj,freq),getRadioVar(_obj,waveDist),getRadioVar(_obj,radioType)] call vs_startTransmith;
		};
		// cd_activeHand
		
		//get all unit radios
		{
			_obj = [player,_x] call smd_getObjectInSlot;
			if (not_equals(_obj,objNUll) && {_obj call vs_isWorldRadioObject} && getRadioVar(_obj,canSpeak)) then {
				[getRadioVar(_obj,freq),getRadioVar(_obj,waveDist),getRadioVar(_obj,radioType)] call vs_startTransmith;
			};
		} foreach [INV_HAND_L,INV_HAND_R,INV_FACE,INV_HEAD,INV_BELT,INV_BACK];
		
	} else {
		call vs_doStopTransmith;
		
		/*private _obj = call interact_cursorObject;
		if (_obj call vs_isWorldRadioObject && getRadioVar(_obj,canSpeak)) then {
			[getRadioVar(_obj,freq),getRadioVar(_obj,ds),getRadioVar(_obj,tp)] call vs_stopTransmith;
		};
		// cd_activeHand
		
		{
			_obj = [player,_x] call smd_getObjectInSlot;
			if (not_equals(_obj,objNUll) && {_obj call vs_isWorldRadioObject}) then {
				[getRadioVar(_obj,freq),getRadioVar(_obj,ds),getRadioVar(_obj,tp)] call vs_stopTransmith;
			};
		} foreach [INV_HAND_L,INV_HAND_R,INV_FACE,INV_HEAD,INV_BELT,INV_BACK];*/
		//or maybee RELEASE_ALL_TANGENTS ??
	};
};

vs_canUseIntercomObject = {
	(objnull call interact_getIntersectData) params ["_obj","_pos"];
	equals(_this,_obj) && _pos distance (ASLToAGL eyepos player) <= vs_intercom_maxdist && equals(_this,call interact_cursorObject)
};

//Обработчик цикла
vs_handleProcessedTransmith = {
	if (vs_hasTransmithProcess) then {
		vs_lastTransmithInfo params ["_obj","_tData"];
		if not_equals(_obj,objnull) then {
			if (!(_obj call vs_canUseIntercomObject)) then {
				
				call vs_doStopTransmith;
			};
		};
	};
};

vs_processingRadiosList = []; //какие радио слышит клиент из ушей

//добавить радио которое внутри игрока
//В параметрах надо указать частоту и громкость передачи
vs_addProcessingRadio = {
	params ["_obj","_rParams"];
	
	_rParams params [["_dist",vs_transmithDistance],["_raType","digital"]];
	
	if equalTypes(_obj,objNUll) then {
		if isNull(getRadioVar(_obj,freq)) exitWith {
			errorformat("vs::addProcessingRadio() - Cant find data in object %1",_obj);
		};
		
		_obj setVariable ["__radio_isHeadpones",true];
		
		vs_processingRadiosList pushBack format["%1%2|%3|%4",
			getRadioVar(_obj,freq),"",
			abs getRadioVar(_obj,vol), // in range 0-10
			0 //NUMBER: Stereo setting : Range (0,2) (0 - Both, 1 - Left, 2 - Right)
		];
		
		//traceformat("Processing added %1 %2",_dist arg _raType);
	} else {
		
	};
};	

//Убирает процессироуемое радио
vs_removeProcessingRadio = {
	params ["_obj"];
	
	if equalTypes(_obj,objNUll) then {
		private _freq = getRadioVar(_obj,freq);
		private _c = [_freq,abs getRadioVar(_obj,vol),str 0] joinString "|";
		
		//stop transmith if this enabled
		if equals(vs_lastTransmithInfo select 1 select 0,_freq) then {
			call vs_doStopTransmith;
		};
		
		vs_processingRadiosList deleteAt (vs_processingRadiosList find _c);
	} else {
		warningformat("vs::removeProcessingRadio() - Cant cast type %1",tolower typeName _obj)
	};
};

vs_clearProcessingRadio = {vs_processingRadiosList = []};

//Получает все радио игрока
vs_onProcessingRadios = {
	if (count vs_processingRadiosList > 0) then {
		vs_processingRadiosList
	} else {
		["No_SW_Radio"]
	};
	
	/*if (((call TFAR_fnc_haveSWRadio) or (TFAR_currentUnit != player)) and {[TFAR_currentUnit, _isolated_and_inside, _can_speak, _depth] call TFAR_fnc_canUseSWRadio}) then {
		_freq = [];
		_radios = TFAR_currentUnit call TFAR_fnc_radiosList;
		if (TFAR_currentUnit != player) then {
			_radios = _radios + (player call TFAR_fnc_radiosList);
		};
		{
			if (!(_x call TFAR_fnc_getSwSpeakers) or {(TFAR_currentUnit != player) and (_x in (player call TFAR_fnc_radiosList))}) then {
				if ((_x call TFAR_fnc_getAdditionalSwChannel) == (_x call TFAR_fnc_getSwChannel)) then {
					_freq pushBack format ["%1%2|%3|%4", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode, _x call TFAR_fnc_getSwVolume, _x call TFAR_fnc_getAdditionalSwStereo];
				} else {
					_freq pushBack format ["%1%2|%3|%4", _x call TFAR_fnc_getSwFrequency, _x call TFAR_fnc_getSwRadioCode, _x call TFAR_fnc_getSwVolume, _x call TFAR_fnc_getSwStereo];
					if ((_x call TFAR_fnc_getAdditionalSwChannel) > -1) then {
						_freq pushBack format ["%1%2|%3|%4", [_x, (_x call TFAR_fnc_getAdditionalSwChannel) + 1] call TFAR_fnc_GetChannelFrequency, _x call TFAR_fnc_getSwRadioCode, _x call TFAR_fnc_getSwVolume, _x call TFAR_fnc_getAdditionalSwStereo];
					};
				};
			};
			true;
		} count (_radios);
	};*/
};