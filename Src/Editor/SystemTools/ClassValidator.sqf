// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

function(classValidator_init)
{
	if isNull(classValidator_internal_validated) then {
		[true] call classValidator_process;
	};
}

function(classValidator_process)
{
	params [["_validateDeprecated",false]];
	private _class = null;
	private _erroredClasses = [];
	private _erroredObjects = [];
	private _mapClassToDesc = createHashMap;
	{
		if (_x call golib_hasHashData) then {
			if not_equals(golib_com_object,_x) then {
				_class = [_x] call golib_getClassName;
				if isNullVar(_class) exitwith {
					["Критическая ошибка. Объект не найден - %1 (класс %2)",_x,_class] call messageBox;
				};
				if !([_class] call oop_isImplementClass) exitwith {
					_erroredObjects pushBack _x;
					_erroredClasses pushBackUnique _class;
				};

				if (_validateDeprecated) then {
					private _isDeprecated = [_class,"Deprecated"] call goasm_attributes_getClassValues;
					if !isNullVar(_isDeprecated) then {
						if !(_class in _mapClassToDesc) then {
							_mapClassToDesc set [_class,_isDeprecated select 0];
						};
					};
				};
				
			};
		};
	} foreach (all3DENEntities select 0);

	private _mpath = "";
	private _hd = null; private _custom = null;
	private _deadClassesCount = count _erroredObjects;
	private _curClass = null;
	private _needRegenerateMarks = false;
	if (_deadClassesCount > 0) then {
		{
			_mpath = (getModelInfo _x) select 1;
			if (isNullVar(_mpath) || {equals(_mpath,"")}) exitwith {
				["Критическая ошибка при замене модели объекта %1 (%2)",_x,typename _x] call messageBox;
			};
			_hd = [_x] call golib_getHashData;
			_custom = _hd get "customProps";
			if isNullVar(_custom) exitwith {
				["Критическая ошибка при исправлении информации объекта %1 (%2)"] call messageBox;
			};

			_hd set ["class","IStruct"];
			if (count keys _custom > 0 && { not_equals((keys _custom)apply{tolower _x},["model"]) } ) then {
				_needRegenerateMarks = true;
				_custom = createHashMap;
				_hd set ["customProps",_custom];
			};

			_custom set ["model",_mpath];
			[_x,_hd] call golib_setHashData;

		} foreach _erroredObjects;

		if (_needRegenerateMarks) then {
			call golib_cs_syncMarks;
			["Метки объектов проверены"] call messageBox;
		};

		["Найдено %1 несуществующих классов. Все они были заменены на IStruct;%3%3Список несуществующих классов: %2",
			_deadClassesCount,_erroredClasses joinString (", "),endl] call messageBox;
	} else {
		["%1 - No dead classes found",__FUNC__] call printLog;
		if (classValidator_internal_validated) then {
			["Все классы в порядке"] call showInfo;
		};
	};

	classValidator_internal_validated = true;

	if (_validateDeprecated) then {
		if (count _mapClassToDesc > 0) then {
			private _text = format["На карте '%1' найдены устаревшие классы, которые будут удалены в будущем:","missionName" call golib_getCommonStorageParam];
			modvar(_text) + endl;
			{
				modvar(_text) + endl + format["%1 - %2",_x,_y];
			} foreach (_mapClassToDesc);

			[_text] call printWarning;
			[_text] call messageBox;
		};
	};
}


function(classValidator_validateModels)
{
	["Start %1",__FUNC__] call printLog;
	private _ignoredDir = ["Cloth"] apply {tolower _x};
	private _matches = 0;
	private _mapModelToClass = createHashMap;
	{
		private _class = _x;
		private _isIgnored = false;
		if ([_class,"InterfaceClass"] call goasm_attributes_hasAttributeClass) then {continue};
		if ([_class,"HiddenClass"] call goasm_attributes_hasAttributeClass) then {continue};
		if ([_class,"TemplatePrefab"] call goasm_attributes_hasAttributeClass) then {continue};
		{
			if ([_class,_x] call oop_isTypeOf) exitwith {_isIgnored = true};
		} foreach _ignoredDir;
		if _isIgnored then {continue};

		private _model = tolower ([_class,"model",true] call oop_getFieldBaseValue);
		if isNullVar(_model) then {continue};
		if (_model in _mapModelToClass) then {
			(_mapModelToClass get _model) pushBack _class;
		} else {
			_mapModelToClass set [_model,[_class]];
		};
	} foreach (["GameObject",true] call oop_getinhlist);

	{
		if (count _y > 1) then {
			INC(_matches);
			["Model %1: classes %2",_x, _y joinString ", "] call printWarning;
		};
	} foreach (_mapModelToClass);

	["Validation done. Found %1 probably duplicated classes",_matches] call printLog;
	["Work done. See console",20] call showInfo;
}