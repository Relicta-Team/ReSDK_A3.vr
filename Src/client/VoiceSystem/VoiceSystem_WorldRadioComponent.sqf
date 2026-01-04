// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(VoiceSystem.WorldRadio,vs_)

decl(mesh[])
vs_allWorldRadios = [];

//Загружает в мир всю инфу о радио. Последний параметр указывает использовать ли радио как наушник
decl(void(mesh;any[];string;bool))
vs_loadWorldRadio = {
	params ["_obj","_radioData","_ptr",["_isHeadpones",false]];
	
	if isNullReference(_obj) exitWith {
		error("vs::loadWorldRadio() - Cant load world radio: object is null");
	};
	
	//parametrize: [int freq, float volume,float canHearUnits, vec3 bias, vec2 [wavedist,radiotype]]
	if !isNull(_obj getvariable "__radio_freq") then {
		traceformat("vs::loadWorldRadio() - Reloading radio data for object <%1>",_obj);
	};
	_radioData params ["_freq","_vol","_canHear","_bias","_trsStruct"];
	
	traceformat("vs::loadWorldRadio() - radio init: %1",_radioData);
	
	_obj setvariable ["__radio_freq",str _freq];
	_obj setvariable ["__radio_vol",_vol];
	_obj setvariable ["__radio_canHear",_canHear];
	_obj setvariable ["__radio_bias",_bias];
	_obj setvariable ["__radio_ptr",_ptr];
	
	private _canSpeak = !isNullVar(_trsStruct);
	
	if (_canSpeak) then {
		_obj setVariable ["__radio_waveDist",_trsStruct select 0];
		_obj setVariable ["__radio_radioType",vs_transmithTypes select (_trsStruct select 1)];
	};
	
	if (_isHeadpones) then {
		[_obj,_trsStruct] call vs_addProcessingRadio; //процессируемое радио действует как наушник
	} else {
		_obj setVariable ["__radio_isHeadpones",false];
	};
	
	_obj setVariable ["__radio_canSpeak",_canSpeak]; // Может ли быть радио использовано как интерком или ручное
	
	vs_allWorldRadios pushBackUnique _obj;
};

//выгружает мировое радио
decl(void(mesh))
vs_unloadWorldRadio = {
	params ["_obj"];
	
	if isNull(_obj getvariable "__radio_freq") exitWith {false};
	
	private _idx = vs_allWorldRadios find _obj;
	
	if (_idx == -1) then {
		warningformat("vs::unloadWorldRadio() - Cant unload radio on object %1 - pointer not found",_obj);
		false
	} else {
		
		traceformat("vs::unloadWorldRadio() - Radio unloaded %1",_obj);
		
		if getRadioVar(_obj,isHeadpones) then {
			[_obj] call vs_removeProcessingRadio;
		};
		
		vs_allWorldRadios deleteat _idx;
		_obj setvariable ["__radio_freq",null];
		_obj setvariable ["__radio_vol",null];
		_obj setvariable ["__radio_canHear",null];
		_obj setvariable ["__radio_bias",null];
		_obj setvariable ["__radio_ptr",null];
		
		_obj setVariable ["__radio_waveDist",null];
		_obj setVariable ["__radio_radioType",null];
		_obj setvariable ["__radio_isHeadpones",null];
		
		_obj setVariable ["__radio_canSpeak",null];
		
		true
	};
};

//Является ли объект земным радио
decl(bool(mesh))
vs_isWorldRadioObject = { !isNull(_this getVariable "__radio_ptr") };

//Обрабатывает мировые радио записывая их в vs_speakerRadios
decl(void())
vs_processWorldRadios = {
	inline_macro
	#define _eyePosAgl _ep
	inline_macro
	#define _currentVolume _cv
	
	private ["_pos","_p"];
	private _br = vs_new_line;
	private _currentVolume = null;
	private _eyePosAgl = ASLToAGL (eyepos player);
	
	{		
		_pos = _x modelToWorld getRadioVar(_x,bias);
		
		//todo distance with vs_speakerDistance
		
		_currentVolume = getRadioVar(_x,vol);
		
		//Все рации, чья громкость меньше нуля не будут процессится на земле
		if (_currentVolume >= 0) then {
			vs_speakerRadios pushBack (format ["%1%2%3%4%5%6%7%8%9%10%11%12%13", 
				getRadioVar(_x,ptr), _br,
				getRadioVar(_x,freq), _br,  
				"", _br, //empty str == inworld radio
				AGLToASL (_pos vectordiff _eyePosAgl), _br, 
				[_x,_currentVolume] call vs_calcSpeakerIntersection, _br,
				"no", _br, //vehicle
				AGLToASL(_pos) select 2
				]);
		};		
		
		true;
	} count vs_allWorldRadios;
	
};

//Тушит громкость от пересечений
decl(float(mesh;float))
vs_calcSpeakerIntersection = {
	params ["_obj","_curVol"];
	__rv = getRadioVar(_obj,vol);
	__vs_cvio_ = lineIntersectsSurfaces [
	    eyepos player,
	    getPosASL _obj,
	    player,
	    _obj,
	    true,
	    10,
	    "FIRE",
	    "NONE"
	];
	
	//TODO checking bounding box of objects
	
	//
	//_curVol / ((count __vs_cvio_) max 1);
	
	_curVol / ((((count __vs_cvio_)  max 1) / 1.6))min __rv
};