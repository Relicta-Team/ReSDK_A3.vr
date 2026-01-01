// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Модуль ассоциаций моделей и классов. Нужен для проверки привязок моделей к временным шаблонам и обновлению моделей
*/

function(golib_massoc_generate)
{
	params ["_class","_model"];
	_model = call compile _model;
	if isNullVar(_model) exitWith {};

	//для всех НОРМАЛЬНЫХ моделей действует правило начального символа
	[_class,"\"+_model] call golib_massoc_makeAssoc;
}

function(golib_massoc_makeAssoc)
{
	params ["_class","_model"];
	_class = tolower _class;
	_model = tolower _model;
	if (_model in golib_massoc_map_modelToClass) then {
		(golib_massoc_map_modelToClass get _model) pushBack _class;
	} else {
		golib_massoc_map_modelToClass set [_model,[_class]];
	};
}

function(golib_massoc_getClassByObject)
{
	params ["_obj"];
	[(getModelInfo _obj) select 1] call golib_massoc_getClassByModel;
}

function(golib_massoc_getClassByModel)
{
	params ["_model"];
	if (_model select [0,1]!="\") then {
		_model = "\"+_model;
	};
	golib_massoc_map_modelToClass getOrDefault [_model,[]]
}

function(golib_massoc_updateAllObjectsAtClassAndModel)
{
	params ["_type","_model"];
	if isNullVar(_model) then {
		_model = [_type,"model",true,"getModel"] call oop_getFieldBaseValue;
	};

	//["%1 - Start processing of type %2 with model %3",__FUNC__,_type,_model] call printLog;

	private _listProblems = [];

	//get all objects
		//foreach if x has data
		// and model equal current
		// and type not equals current
		// update (if not proto type then notification or add queue)
	private _objList = [];
	{
		if (_x call golib_hasHashData) then {
			if not_equals(golib_com_object,_x) then {
				_objList pushBack _x;
			};
		};
	} foreach (all3DENEntities select 0);

	//["Collected %1 objects",count _objList] call printLog;

	private _prepareModelPath = {
		private _modelPath = _this;
		if !(".p3d" in _modelPath) then {
			private _srcModel = _modelPath;
			_modelPath = getText(configFile >> "CfgVehicles" >> _srcModel >> "model" );
			if (_modelPath=="") exitWith {
				["%1 - error on select model (class %2)",_srcModel,_clsName] call messageBox;
				["%1 - error on select model",_srcModel] call printError;
				""
			};
		};
		if ((_modelPath select [0,1]) != "\") then {
			_modelPath = "\"+_modelPath;
		};
		_modelPath;
	};

	//prepare this model
	_model = _model call _prepareModelPath;
	private _increment = 0;
	private _skippedIncrement = 0;
	private _conflicts = 0;
	private _conflictsList = [];
	private _clsName = null;
	
	{
		_clsName = [_x] call golib_getClassName;
		
		_mdl = ((getModelInfo _x) select 1) call _prepareModelPath;
		
		if (_model == _mdl && _clsName != _type) then {
			if !((tolower _clsName) in ["istruct","decor"]) exitWith {
				//["Is not proto type - %1, model %2",_clsName,_mdl] call printLog;
				INC(_skippedIncrement);
			};
			_lval = [_x] call golib_massoc_getClassByObject;
			if (count _lval > 1) exitWith {
				private _cstring = _lval joinString ", ";
				
				if !(_cstring in _conflictsList) then {
					["Неоднозначность в определении отношения класса к модели.%2%2Используется в:%1;%2%2Будет запущено принудительное обновление с разрешением конфликта.",_cstring,endl] call messageBox;
					_conflictsList pushBack _cstring;
				};
				["Ambiguity in defining the relationship of a class to a model. Used in:%1; A forced update with conflict resolution will be launched.",_cstring] call printWarning;
				
				INC(_conflicts);
			};
			_data = [_x,false] call golib_getHashData;
			_data set ["class",_type];

			//fix actual model at new class
			private _props = _data get "customProps";
			if ("model" in _props) then {
				private _defModel = [_type,"model",true,"getModel"] call oop_getFieldBaseValue;
				if (_defModel == (_props get "model")) then {
					_props deleteAt "model";
				};
			};
			
			[_x,_data,true,"Синхронизация объекта "+_type] call golib_setHashData;
			//[_x] call golib_setSelectedObjects;
			INC(_increment);
		};

	} foreach _objList;

	["(%3) Changed %1 objects (skipped %2, conflicts %5)   %4",_increment,_skippedIncrement,_type,_model,_conflicts] call printLog;
	if (_increment > 0 && _conflicts == 0) then {
		["Объекты были обновлены. Сохраните карту в .bin файл"] call showInfo;
	};
	if (_conflicts > 0) then {
		["Обнаружены конфликты. Запускается автоматическое обновление с функцией разрешения конфликтов"] call showInfo;
		nextFrame(golib_massoc_syncAllObjects);
	};
}

//! не использовать эту функцию. Она не оптимизирована.
function(golib_massoc_syncAndUpdateAllObjects)
{
	{
		[_x] call golib_massoc_updateAllObjectsAtClassAndModel;
	} foreach (["IDestructible",true] call oop_getinhlist);
}

//низкоуровневое обновление класса объекта
function(golib_massoc_auto_lowLevelUpdateClass)
{
	params ["_obj","_type",["_doLogs",false]];
	private _data = [_obj,false] call golib_getHashData;
	_data set ["class",_type];

	private _props = _data get "customProps";
	if ("model" in _props) then {
		private _defModel = [_type,"model",true,"getModel"] call oop_getFieldBaseValue;
		if (_defModel == (_props get "model")) then {
			_props deleteAt "model";
		};
	};

	if (_doLogs) then {
		[_obj,_data,true,"Синхронизация объекта "+_type] call golib_setHashData;
	} else {
		[_obj,_data,false] call golib_setHashData;
	};
}

function(golib_massoc_syncAllObjects)
{
	//работает от golib_massoc_map_modelToClass
	/*

		1. Собираем все объекты. 
		2. Проходим по их массиву
		3. проверяем если это istruct или Decor
			4. проверяем сколько классов ссылаются на эту модель. если 1 то назначаем.
			5. если несколько то сохраняем объект в unresolved
		и так пока не пройдем по всем объектам

		после проверки открываем лист нерешенных - клик тп к нему. и после выбор модели.
		после выбора модели заново открываем лист и так пока он не закончится
	*/

	golib_massoc_sync_unresolvedObjects = [];
	golib_massoc_sync_unresolvedMapAutomatics = createHashMap;

	private _cls = "";
	private _classList = null;
	private _changed = 0;
	{
		if (_x call golib_hasHashData) then {
			if not_equals(golib_com_object,_x) then {
				_cls = [_x] call golib_getClassName;
				_classList = [_x] call golib_massoc_getClassByObject;
				
				//не занесена в список (скриптовая залупа)
				if (count _classList == 0) exitWith {};

				//не прототипы скипаем
				if !((tolower _cls) in ["istruct","decor"]) exitwith {};

				if (count _classList > 1) then {
					golib_massoc_sync_unresolvedObjects pushBack _x;
				} else {
					["Changed from %1 to %2 (mdl:%3)",_cls,_classList select 0,getModelInfo _x select 1] call printTrace;
					[_x,[_classList select 0,"classname"] call oop_getTypeValue,true] call golib_massoc_auto_lowLevelUpdateClass;
					INC(_changed);
				};
			};
		};
	} foreach (all3DENEntities select 0);

	["%1 - Task done: Changed %2 objects, Unresolved conflicts %3",__FUNC__,_changed,count golib_massoc_sync_unresolvedObjects] call printLog;
	if (count golib_massoc_sync_unresolvedObjects > 0) then {
		call golib_massoc_resolveConflictsProcess;
	};
}

function(golib_massoc_resolveConflictsProcess)
{
	if (isNull(golib_massoc_sync_unresolvedObjects) || {count golib_massoc_sync_unresolvedObjects == 0}) exitWith {
		["%1 - no conflicts founded",__FUNC__] call printLog;
		["Конфликты не обнаружены"] call showInfo;
	};
	private _list = golib_massoc_sync_unresolvedObjects apply {
		[
			format["%1 at %3 (%2)",((str _x)splitString "#") select 0,([_x] call golib_massoc_getClassByObject) joinString ", ",getPosATL _x],
			str _x,
			(getModelInfo _x) select 1
		]
		
	};
	[_list,
		//select
		{
			_obj = golib_massoc_sync_unresolvedObjects deleteAt _index;
			call golib_vis_resetLockNativeCamera;

			[_obj] call golib_massoc_resolveConflictsProcess_pickClass;
		},
		//close
		{
			["Процедуру можно повторно вызвать через функцию golib_massoc_resolveConflictsProcess"] call showInfo;
			call golib_vis_resetLockNativeCamera;
		},
		{
			_obj = golib_massoc_sync_unresolvedObjects select _index;
			[_obj] call golib_setSelectedObjects;
			_obj call golib_vis_lockNativeCamera;
			call golib_vis_jumpToSelected;
		},
		format["(%1 конфл.) Нажмите на неразрешенный объект для перемещения к нему и выбора класса",count _list],
		{
			//_ctg
			(_ctg call widgetGetPosition)params ["_x","_y"];
			[_ctg,[_x+25,_y]] call widgetSetPositionOnly;
			if (!call nativePanels_isHiddenRight) then {
				call nativePanels_onToggleRight;
			};
			if (golib_vis_isexpanded) then {
				[!golib_vis_isexpanded] call golib_vis_onChangeRightPanelState;
			};
		}
	] call control_createList;
}

function(golib_massoc_resolveConflictsProcess_pickClass)
{
	params ["_obj"];
	[_obj] call golib_setSelectedObjects;
	call golib_vis_jumpToSelected;
	_obj call golib_vis_lockNativeCamera;
	
	private _classList = [_obj] call golib_massoc_getClassByObject;
	_classList = array_copy(_classList);
	_classList sort true;

	if (count _classList == 1) exitWith {
		["%1 - class list count equals 1 (%2)",__FUNC__,_classList] call printError;
	};
	private _list = _classList apply {
		private _name = [_x,"name",true,"getName"] call oop_getFieldBaseValue;
		if isNullVar(_name) then {_name = "NULL-NAME"};
		
		[
		format["%1 (%2)",[_x,"classname"] call oop_getTypeValue,_name],
			[_x,"classname"] call oop_getTypeValue
		]
	};

	{
		_x params ["_sysname","_syscls"];
		_list pushBack [
			format["%1 (ГЛОБАЛЬНАЯ ЗАМЕНА)",_sysname],
			"+" + _syscls,
			format["Выбрав этот элемент все последующие конфликтные модели типа:\n\n%2\n\nбудут преобразованы в %1 сразу",_syscls,getModelInfo _obj select 1]
		]
	} foreach (+_list);
	
	golib_massoc_resolveConflicts_internal_lastObjectRef = _obj;
	
	[_list,
		{
			//Для всех этого случая
			if (_data select [0,1] == "+") then {
				_data = _data select [1,count _data];
				private _unresRef = golib_massoc_sync_unresolvedObjects;
				{
					if (((getModelInfo _x) select 1) == 
						((getModelInfo golib_massoc_resolveConflicts_internal_lastObjectRef select 1))
					) then {
						if (count ([_x] call golib_massoc_getClassByObject) > 1) then {
							_unresRef deleteAt (_unresRef find _x);
							[_x,_data,true] call golib_massoc_auto_lowLevelUpdateClass;
						};
					};
				} foreach +_unresRef;
			};
			[golib_massoc_resolveConflicts_internal_lastObjectRef,_data,true] call golib_massoc_auto_lowLevelUpdateClass;
			
			if (count golib_massoc_sync_unresolvedObjects > 0) then {
				nextFrame(golib_massoc_resolveConflictsProcess);
			} else {
				["Все конфликты разрешены"] call showInfo;
			};

			call golib_vis_resetLockNativeCamera;
			[] call golib_setSelectedObjects;
		},
		{
			call golib_vis_resetLockNativeCamera;
			[] call golib_setSelectedObjects;
			["Разрешение конфликтов отклонено пользователем. Повторный вызов возможен через golib_massoc_resolveConflictsProcess"] call showWarning;
		},
		null,
		"Выберите какой класс будет сопоставлен с выбранным объектом"
	] call control_createList;
}