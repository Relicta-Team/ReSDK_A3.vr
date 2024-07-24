// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\struct.hpp>
#include <..\..\host\oop.hpp>
#include <..\Inventory\inventory.hpp>

/*
	RProx is improvement proxy system for inventory slots
*/

proxIt_canUseRProx = true; //переопределение

rprox_const_vec = [0,0,0];
rprox_const_vdu = [rprox_const_vec,rprox_const_vec];
rprox_const_selections = ["spine3","spine3","head","rightshoulder","spine3","head","lefthand","pelvis","righthand"];

rprox_map_configs = createHashMap; //ключ - путь до модели (без префикса \), значение - карта селекшонов

//загрузка модели на моба. Возвращает приаттаченный объект, objNull если не удалось создать
rprox_loadConfig = {
	params ["_mob","_modelPathOrClass","_selectionId"];
	private _model = _modelPathOrClass;
	private _baseModel = _modelPathOrClass;
	if !(".p3d" in _modelPathOrClass) then {
		_model = core_cfg2model getVariable _modelPathOrClass;
	};
	if isNullReference(_model) exitWith {
		errorformat("[RProx]:	Cant load model by classname %1.",_modelPathOrClass);
		objNull
	};

	_model = tolower _model;

	private _map = rprox_map_configs get _model;
	if isNullVar(_map) exitWith {
		errorformat("[RProx]:	Cant find model path - %1",_model);
		_object = createSimpleObject [_baseModel,[0,0,0],true];
		_object disableCollisionWith player;
		_object attachTo [_mob,[0,0,0],rprox_const_selections select _selectionId,true];
		_object setvariable ["_pit_lastAttachData",[_mob,[0,0,0],rprox_const_selections select _selectionId,true]];
		_object
	};

	private _posData = (_map get _selectionId);

	//селекшон не аттачится
	if isNullVar(_posData) exitWith {objNull};

	_posData params ["_pos","_offs","_vdir","_vup"];

	_object = createSimpleObject [_baseModel,[0,0,0],true];

	_object attachTo [_mob,_posData select 0,proxIt_list_selections select _selectionId,true];
	[_object,_posData select 1] call BIS_fnc_setObjectRotation;

	//fix lagvector
	_object attachTo [_mob,_posData select 0,proxIt_list_selections select _selectionId,true];
	_object setvariable ["_pit_lastAttachData",[_mob,_posData select 0,proxIt_list_selections select _selectionId,true]];

	_object disableCollisionWith player;
	
	_object	
};

rprox_hasConfigForModel = {
	params ["_modOrCfg"];
	if !(".p3d" in _modOrCfg) then {
		_modOrCfg = core_cfg2model getVariable _modOrCfg;
	};
	_modOrCfg = tolower _modOrCfg;
	_modOrCfg in rprox_map_configs;
};

rprox_updateModel = {
	params ["_mob","_object","_newselection"];
	setLastError("Not implemented");
};

//загрузчик конфигураций
rprox_init = {
	private _mvdata = null;
	private _rprox_preload = [];
	#include "RProx_cfg.h"
	;

	{
		_x param ["_cfg","_data"];
		rprox_map_configs set [tolower _cfg,createHashMapFromArray _data];
	} foreach _rprox_preload;
};

call rprox_init;