// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(classValidator_init)
{
	if isNull(classValidator_internal_validated) then {
		call classValidator_process;
	};
}

function(classValidator_process)
{
	private _class = null;
	private _erroredClasses = [];
	private _erroredObjects = [];
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
	};

	classValidator_internal_validated = true;
}