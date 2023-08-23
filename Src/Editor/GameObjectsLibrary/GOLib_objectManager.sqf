// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================




function(golib_om_internal_handleTransformEvent)
{
	params ["_obj"];
	//Пока этот код не используем...
	
	// if !isNull(_obj getVariable "_internal_handleTransform") then {
	// 	_obj RemoveEventHandler ["Dragged3DEN",_obj getVariable "_internal_handleTransform"];
	// };
	// private _handleTransform = _obj AddEventHandler ["Dragged3DEN", {
	// 	params ["_object"];
	// 	if (count (get3DENSelected "" select 0) > 15) exitWith{};
	// 	//Проблемная зона
	// 	//!слишком частые вызовы
	// 	//! inspector_menuLoad need optimize
	// 	//[null] call inspector_menuLoad;
	// }];
	// _obj setVariable ["_internal_handleTransform",_handleTransform];

	if isNull(_obj getvariable "_internal_handleAttributesChanged") then {
		_handle = _obj AddEventHandler ["AttributesChanged3DEN",
		{
			_this call golib_om_onAttibutesChanged;
		}];
		_obj setvariable ["_internal_handleAttributesChanged",_handle];
	};
}

function(golib_om_onAttibutesChanged)
{
	params ["_obj"];
	[null] call inspector_menuLoad;
}

function(golib_om_generatelAssoc)
{
	private ["_cfgName","_model"];
	if (count golib_vis_assoc_ModelToConfig > 0) exitWith {};
	
	golib_om_internal_tovalidatemodels = [];
	golib_om_internal_iconsavedmodels = [];
	_restrictedModels = ["","\A3\Weapons_f\dummyweapon.p3d","\A3\Weapons_f\laserTgt.p3d","\A3\Structures_F\Mil\Helipads\HelipadEmpty_F.p3d"];
	{
		_restrictedModels set [_forEachIndex,toLower _x];
	} foreach _restrictedModels;
 	_noaddsearch = ["lasertgt.p3d","dummy","empty"];
	
	{
		_cfgName = tolower (configname _x);
		_modelNoLowered = getText(_x >> "model");
		_model = tolower gettext(_x >> "model");
		if (_model != "") then {
			if (_model in _restrictedModels) then {continue};
			if (_model in _noaddsearch) then {continue};
			
			if (_model in golib_vis_assoc_ModelToConfig) then {
				["%1 -> %2:		 Model (%3) in config already exists",__FUNC__,_cfgName,_model] call printWarning;
				golib_om_internal_tovalidatemodels pushBackUnique _model;
			} else {
				golib_vis_assoc_ModelToConfig set [_model,_cfgName];
				golib_om_internal_iconsavedmodels pushBack _model;
			};
		};

	} foreach ("true" configClasses (configFile >> "CfgVehicles"));
	
}

function(golib_om_placeObjectAtMouse)
{
	params ["_gameObject"];
	
	if ([_gameObject,"InterfaceClass"] call goasm_attributes_hasAttributeClass) exitWith {
		["Классы, помеченные атрибутом InterfaceClass не могут быть созданы в сцене."] call showWarning;
	};
	
	private _flagEffect = false;
	if ([_gameObject,"EffectClass"] call goasm_attributes_hasAttributeClass) then {
		_flagEffect = true;
	};

	private _cfg = [_gameObject] call golib_om_getConfigByGameObject;

	if (_flagEffect) then {
		_cfg = [_gameObject,_cfg] call goasm_iapi_effect_convertConfig;
	};

	if (_cfg=="") exitWith {
		["Не удалось создать объект типа "+_gameObject] call showWarning;
		["%1 - Error on create game object %2",__FUNC__,_gameObject] call printError;
	};
	["Добавление объекта", "Создан объект типа "+_gameObject, "a3\3den\data\cfg3den\history\create_ca.paa"] collect3DENHistory
	{
		_screenToWorldPos = screenToWorld getMousePosition;
		([_screenToWorldPos] call golib_om_getRayCastData) params ["_obj","_atlPos"];
		if equals(_atlPos,vec3(0,0,0)) then {
			["atl pos is zerovec"] call printTrace;
			_atlPos = _screenToWorldPos;
		};

		_obj = create3DENEntity ["Object",_cfg, _atlPos];
		_emplacedPos = _obj call golib_om_getPosition;
		if (_emplacedPos distance _atlPos >= 2) then {
			["Fixed position"] call printTrace;
			// История судя по всему не работает в этом же фрейме, в котором объект создан
			[_obj,_atlPos,false,golib_history_skippedHistoryStageFlag + " - fixpos"] call golib_om_setPosition;
		};
		[_obj,_gameObject] call golib_initHashData;
		
		[_obj] call golib_om_internal_handleTransformEvent;
		
		if (_flagEffect) then {
			[_obj,_gameObject] call goasm_iapi_effect_preparModel;
		};

		set3DENSelected [_obj];
	};
}

function(golib_setSelectedObjects)
{
	if not_equalTypes(_this,[]) then {
		_this = [_this];
	};
	set3DENSelected _this
}

function(golib_getSelectedObjects)
{
	get3DENSelected "" select 0
}

function(golib_om_getConfigByGameObject)
{
	params ["_type",["_throwWarn",true]];
	private _mbase = [_type,"model",true] call oop_getFieldBaseValue;
	[_mbase,_throwWarn] call golib_om_getConfigByModel;
}

function(golib_om_getConfigByObject)
{
	params ["_obj",["_throwWarn",true]];
	if (TYPEOF _obj == "") then {
		[getModelInfo _obj select 1,_throwWarn] call golib_om_getConfigByModel;
	} else {
		TYPEOF _obj
	};
}

function(golib_om_getConfigByModel)
{
	params ["_mbase",["_throwWarn",true]];
	
	//Всё что для конфигов сразу подсовываем
	if !("\" in _mbase) exitWith {_mbase};
	private _m = tolower _mbase;
	if isNullVar(_m) exitWith {""};
	private _ret = core_model2cfg getVariable [_m,""];
	if equalTypes(_ret,[]) then {
		private _idx = _ret findif {_x call config_isEditorVisible};
		if (_idx == -1) exitWith {""};
		if (_throwWarn) then {
			["Модель '"+_mbase+"' содержит "+str count _ret+" конфигураций. Выбрана оптимальная модель с допустимой конфигурацией",10] call showWarning;
		};
		_ret select _idx
	} else {
		_ret
	};
}

//Получает информацию об объекте пересечения в виде: [object, intersect position as ATL,vectorUp lod]
function(golib_om_getRayCastData)
{
	params ["_toPos",["_ign1",objNUll],["_ign2",objNUll],["_fromPos",positionCameraToWorld [0,0,0]]];

	private _ins = lineIntersectsSurfaces [
  		AGLToASL _fromPos,
  		AGLToASL _toPos,
  		_ign1,
		_ign2,
		true,
		1,
		INTERACT_LODS_CHECK_STANDART
 	];
	if (count _ins == 0) exitWith {[objnull,[0,0,0],[0,0,0]]};
	_ins = lineIntersectsSurfaces [
  		AGLToASL positionCameraToWorld [0,0,0],
  		AGLToASL _toPos,
		_ign1,
		_ign2,
		true,
		1,
		INTERACT_LODS_CHECK_GEOM
 	];
	if (count _ins == 0) exitWith {[objnull,[0,0,0],[0,0,0]]};
	[_ins select 0 select 2,asltoatl (_ins select 0 select 0),_ins select 0 select 1]
}

function(golib_om_getPosition)
{
	(_this get3DENAttribute "position") select 0;
}

function(golib_om_setPosition)
{
	params ["_obj","_pos",["_addToHistory",false],["_postMes",""]];
	
	if (_addToHistory) then {
		if (_postMes!="") then {
			_postMes = ": " + _postMes;
		};
		["Инспектор"+_postMes, "Изменение трансофрмации объекта", "a3\3den\data\cfg3den\history\moveItems_ca.paa"] collect3DENHistory {
			_obj set3DENAttribute ["position",_pos];
		};
	} else {
		_obj set3DENAttribute ["position",_pos];
	};
	
}

function(golib_om_getRotation)
{
	(_this get3DENAttribute "rotation") select 0;
}


function(golib_om_setRotation)
{
	params ["_obj","_rot",["_addToHistory",false],["_postMes",""]];
	
	if (_addToHistory) then {
		if (_postMes!="") then {
			_postMes = ": " + _postMes;
		};
		["Инспектор"+_postMes, "Изменение трансофрмации объекта", "a3\3den\data\cfg3den\history\rotateItems_ca.paa"] collect3DENHistory {
			_obj set3DENAttribute ["rotation",_rot];
		};
	} else {
		_obj set3DENAttribute ["rotation",_rot];
	};
}

function(golib_om_replaceObject)
{
	params ["_worldObj","_newConfig"];
	
	//подмена сразу модели на конфиг
	if ("\" in _newConfig) then {
		_newConfig = [_newConfig] call golib_om_getConfigByModel;
	};
	
	if (_worldObj call golib_isVirtualObject) exitwith {
		private _args = [_worldObj,_newConfig];
		private _code = {
			params ["_worldObj","_newConfig"];
			_dummyObj = "_dummyObj" call Core_getContextVar;
			if isNullVar(_dummyObj) exitwith {
				["Context var _dummyObj not found"] call printError;
			};
			if not_equals(_dummyObj,_worldObj) exitwith {
				["Context var _dummyObj not equal to _worldObj"] call printError;
			};
			_mapVars = [];
			{
				_mapVars pushBack [_x, _dummyObj getvariable _x];
			} foreach (allVariables _dummyObj);
			
			deleteVehicle _dummyObj;
			//create new object
			_dummyObj = createSimpleObject [_newConfig,[0,0,0]];
			["_dummyObj",_dummyObj] call Core_addContext;
			// _dummyObj setVariable ["observedIndex",_idx];
			// _dummyObj setVariable ["observedContent",_refContent];
			// _dummyObj setVariable ["observedData",_curItem];

			//? Просто копируем все переменные с объекта и обновляем инспектор
			{_dummyObj setvariable _x} foreach _mapVars;
			
			call golib_cs_syncMarks;

			[[_dummyObj]] call inspector_menuLoad;
		};
		nextFrameParams(_code,_args);
	};

	private _args = [_worldObj,_newConfig];
	private _code = {
		params ["_worldObj","_newConfig"];

		["!!! Замена модели !!!", "Замена конфига объекта", "a3\3den\data\cfg3den\history\changeattributes_ca.paa"] collect3DENHistory
		{
			private _pos = _worldObj call golib_om_getPosition;
			
			_obj = create3DENEntity ["Object",_newConfig, _pos];
			
			if ((format["%1",_obj]) == "<null>") exitWith {
				["Не удалось заменить модель. Для подробностей смотрите лог-консоль"] call showWarning;
				["Cant create eden entity by config %1. It is recommended to cancel the last actions.",_newConfig] call printError;
			};
			
			
			
			private _rot = _worldObj call golib_om_getRotation;
			private _data = [_worldObj,true] call golib_getHashData;
			delete3DENEntities [_worldObj];
			
			[_obj,_data] call golib_setHashData;
			[_obj,_pos] call golib_om_setPosition;
			[_obj,_rot] call golib_om_setRotation;
			
			[_obj] call golib_om_internal_handleTransformEvent;
			
			call golib_cs_syncMarks;

			set3DENSelected [_obj];
		};
	};
	
	nextFrameParams(_code,_args);
}