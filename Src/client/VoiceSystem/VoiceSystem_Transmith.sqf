// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


#include <..\Inventory\inventory.hpp>

#include <..\..\host\lang.hpp>

namespace(VoiceSystem.Transmith,vs_)

decl(bool)
vs_tangent_pressed = false;

decl(float)
vs_transmithDistance = 1000;

decl(int)
vs_curTransmithType = 0; //режим передачи
decl(string[])
vs_transmithTypes = ["digital","digital_lr","airborne"];

//запускает потоковую передачу
decl(void(any;float;string))
vs_startTransmith = {
	params ["_freqAndCode",["_dist",vs_transmithDistance],["_curT","digital"]];
	
	vs_hasTransmithProcess = true;
	
	//["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _freqAndCode, 0, false, true]] call TFAR_fnc_fireEventHandlers;
	private _request = format[
		#ifdef VOICE_DEBUG
		"TANGENT"+vs_horizontal_tab+"PRESSED"+vs_horizontal_tab+"%1%2"+vs_horizontal_tab+"%3"+vs_horizontal_tab+"%4",		
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
decl(void(any;float;string))
vs_stopTransmith = {
	params ["_freqAndCode",["_dist",vs_transmithDistance],["_curT","digital"]];
	
	//["OnBeforeTangent", TFAR_currentUnit, [TFAR_currentUnit, _freqAndCode, 0, false, false]] call TFAR_fnc_fireEventHandlers;
	private _request = format[
		#ifdef VOICE_DEBUG
		"TANGENT"+vs_horizontal_tab+"RELEASED"+vs_horizontal_tab+"%1%2"+vs_horizontal_tab+"%3"+vs_horizontal_tab+"%4",		
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

macro_func(vs_getTransmithDefaultSettings,any[]())
#define VS_TRANSMITHINFO_DEFAULT [objNUll,["","",""]]
decl(bool)
vs_hasTransmithProcess = false;
decl(any[])
vs_lastTransmithInfo = VS_TRANSMITHINFO_DEFAULT; //object and radiocode

// Логика остановки передачи в радио
decl(void())
vs_doStopTransmith = {
	
	vs_hasTransmithProcess = false;
	
	private _tData = vs_lastTransmithInfo select 1;
	if ((_tData select 0) != "") then {_tData call vs_stopTransmith};
	vs_lastTransmithInfo = VS_TRANSMITHINFO_DEFAULT;
};

//запускаем передачу
decl(void(bool))
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
		//or maybee RELEASE_ALL_TANGENTS ??
	};
};

decl(bool(mesh))
vs_canUseIntercomObject = {
	(objnull call interact_getIntersectData) params ["_obj","_pos"];
	equals(_this,_obj) && _pos distance (ASLToAGL eyepos player) <= vs_intercom_maxdist && equals(_this,call interact_cursorObject)
};

//Обработчик цикла
decl(void())
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

decl(string[])
vs_processingRadiosList = []; //какие радио слышит клиент из ушей

//добавить радио которое внутри игрока
//В параметрах надо указать частоту и громкость передачи
decl(void(mesh;any[]))
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
decl(void(mesh))
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

decl(void())
vs_clearProcessingRadio = {vs_processingRadiosList = []};

//Получает все радио игрока
decl(string[]())
vs_onProcessingRadios = {
	if (count vs_processingRadiosList > 0) then {
		vs_processingRadiosList
	} else {
		["No_SW_Radio"]
	};
};