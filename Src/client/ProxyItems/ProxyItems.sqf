// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\oop.hpp>

namespace(ProxyItems,proxIt_)

decl(object)
proxIt_configData = createObj;
decl(vector3)
proxIt_vec = [0,0,0];
decl(vector3[])
proxIt_def = [proxIt_vec,proxIt_vec];
decl(string[])
proxIt_list_selections = ["spine3","spine3","head","rightshoulder","spine3","head","lefthand","pelvis","righthand"];

decl(bool)
proxIt_canUseRProx = false; // переопределяется если скомпилирован RProx

//Подготавливает имя если указан класснейм
decl(string(string))
proxIt_prepName = {
	FHEADER;
	private _modelPath = _this;
	if !(".p3d" in _modelPath) then {
		private _probModel = getText (configFile >> "CfgVehicles" >> _modelPath >> "model");
		if !(".p3d" in _probModel) then {
			errorformat("[PIT]:	Cant load model by classname %1. Finded result is '%2'",_modelPath arg _probModel);
			private _errored = format["ERROR[NONEXISTSCLASS]-%1-%2",_modelPath,_probModel];
			RETURN(_errored);
		};
		_modelPath = _probModel;
	};

	//используется нативный поиск пути
	if (!fileExists(_modelPath)) then {
		errorformat("[PIT]:	Cant find model path - %1",_modelPath);
		private _errored = format["ERROR[PATHNOTFOUND]-%1",_modelPath];
		RETURN(_errored);
	};

	_modelPath
};

decl(void(actor;mesh;int))
proxIt_updateModel = {
	params ["_mob","_object","_newselection"];

	if (proxIt_canUseRProx && {[_modelPathOrClass] call rprox_hasConfigForModel}) exitWith {
		_this call rprox_updateModel;
	};

	private _model = (getModelInfo _object) select 1;
	if (_model select [0,1] != "\") then {
		_model = "\" + _model;
	};
	private _map = proxIt_configData getVariable _model;
	if (isNull(_map)) exitWith {};
	private _posData = (_map get _newselection);
	if (isNullVar(_posData)) exitWith {};	
	//copied from proxit::loadConfig()
	_object attachTo [_mob,_posData select 0,proxIt_list_selections select _newselection,true];
	[_object,_posData select 1] call BIS_fnc_setObjectRotation;
	
	//fix lagvector after 0.8.147
	_object attachTo [_mob,_posData select 0,proxIt_list_selections select _newselection,true];
	_object setvariable ["_pit_lastAttachData",[_mob,_posData select 0,proxIt_list_selections select _newselection,true]];
	_object setvariable ["_pit_slotId",_newselection];

	_object setPhysicsCollisionFlag false;
};

decl(mesh(actor;string;int))
proxIt_loadConfig = {
	params ["_mob","_modelPathOrClass","_selectionId"];
	
	if (proxIt_canUseRProx && {[_modelPathOrClass] call rprox_hasConfigForModel}) exitWith {
		_this call rprox_loadConfig;
	};

	FHEADER;
	private _baseModel = _modelPathOrClass;
	if !(".p3d" in _modelPathOrClass) then {
		private _probModel = getText (configFile >> "CfgVehicles" >> _modelPathOrClass >> "model");
		if !(".p3d" in _probModel) then {
			errorformat("Cant find model path by classname %1. Finded result is '%2'",_modelPathOrClass arg _probModel);
			RETURN(objNUll);
		};
		_modelPathOrClass = _probModel;
	};

	if (_modelPathOrClass select [0,1] != "\") then {
		_modelPathOrClass = "\" + _modelPathOrClass;
	};

	private _map = proxIt_configData getVariable _modelPathOrClass;
	if (isNull(_map)) then {
		errorformat("Cant find data on path %1",_modelPathOrClass);
		_object = createSimpleObject [_baseModel,[0,0,0],true];
		_object setPhysicsCollisionFlag false;
		_object attachTo [_mob,[0,0,0],proxIt_list_selections select _selectionId,true];
		_object setvariable ["_pit_lastAttachData",[_mob,[0,0,0],proxIt_list_selections select _selectionId,true]];
		RETURN(_object);
		//RETURN(objNUll);
	};

	private _posData = (_map get _selectionId);

	if (isNullVar(_posData)) exitWith {objNUll}; //селекшон не аттачится

	_object = createSimpleObject [_baseModel,[0,0,0],true];

	//_object setVectorDirAndUp [[0,0,1],[0,0,1]];
	_object attachTo [_mob,_posData select 0,proxIt_list_selections select _selectionId,true];
	[_object,_posData select 1] call BIS_fnc_setObjectRotation;

	//fix lagvector after 0.8.147
	_object attachTo [_mob,_posData select 0,proxIt_list_selections select _selectionId,true];
	_object setvariable ["_pit_lastAttachData",[_mob,_posData select 0,proxIt_list_selections select _selectionId,true]];
	_object setvariable ["_pit_slotId",_selectionId];

	_object setPhysicsCollisionFlag false;
	
	_object
};

//must_be_native
#include "ConfigProxyItemsLoader.h"

traceformat("[PIT]:	Loaded %1 configs",count (allvariables proxIt_configData));
