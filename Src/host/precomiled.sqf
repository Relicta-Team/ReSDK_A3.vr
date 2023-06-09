// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Этот файл компилируется в редакторе и отладочной сборке в самую первую очередь
	и используется для условной компиляции в объектной системе

	Избыточные проверки внутри кода исключены из соображений производительности
*/
#include <engine.hpp>

/* ------------------------------------------------------
	Region: generic class info
------------------------------------------------------ */

//функция декларатор атрибутов класса
pc_oop_declareClassAttr = {
	if (isnil '_editor_next_attr') exitwith {};

	if (count _editor_next_attr > 0) then {
		_editor_attrs_cls append _editor_next_attr;
		_editor_next_attr = [];
	};
};

//декларатор конца класса
pc_oop_declareEOC = {
	if (is3DEN) then {
		_pt_obj setvariable ["__decl_info_end__",_this];
	};
};

//константные типы объектов. 0 - обычные называния типов, 1 - названия в редакторе
pc_oop_carr_tntps = ["<Type::%1>","<EDITOR_Type::%1>"];

//функция привязки атрибутов к типу
pc_oop_declareMemAttrs = {
	if (is3DEN) then {
		_pt_obj setVariable ["__ed_attr_class",_editor_attrs_cls];
		_pt_obj setVariable ["__ed_attr_fields",_editor_attrs_f];
		_pt_obj setVariable ["__ed_attr_methods",_editor_attrs_m];
	};
};

//завершающая иницализация класса.
pc_oop_postInitClass = {

	if (is3DEN) then {
		_class = nil;
	} else {
		{
			_x params ["_name","_code"]; 
			
			__sc = toString _code;

			//в редакторе для видимости методов при помощи отладчика добавляем информацию о методах в тело функций
			#ifdef EDITOR
				__sc = (format["private ___fn___ = ""%1::%2"";private ___fd___ = ""%3"";",_class,_name,_classmet_declinfo get _name]) + __sc;
			#endif

			if ("__BASECALLFLAG__" in __sc) then {
				_methods set [_forEachIndex,
					[
						_name,
						compile([
							__sc,
							"__BASECALLFLAG__",
							format["call(pt_%1 getVariable '%2')",_mother,_name]
						] call regex_replace)
					]
				];
			} else {
				//просто компилируем код со встроенной информации о члене (где нет ключевого слова super)
				#ifdef EDITOR
					_methods set [_forEachIndex,[_name,compile __sc]]
				#endif 
			};true
		
		} foreach _methods;

		_class = nil;
	};
};


/* ------------------------------------------------------
	Region: generic class members info
------------------------------------------------------ */

#define __on_editor_attribute(membername,membertype) if (count _editor_next_attr > 0) then { \
	membertype pushBack [membername,_editor_next_attr]; \
	_editor_next_attr = []; \
};

//обработчик атрибутов поля
pc_oop_handleAttrF = {
	if (!isnil '_netuse') then {(_fields select _lastIndex) set [2,"netuse"]; _netuse = nil};
	if (!isnil '_isAutoRefUse') then {_autoref pushBack _mem_name; _isAutoRefUse = nil};
	if (!isnil '_isConstant') then {_pt_obj setvariable ['cst_##var',val]; _isAutoRefUse = nil};
	if (isnil '_editor_next_attr') exitwith {};
	__on_editor_attribute(_mem_name,_editor_attrs_f);
};

//обработчик атрибутов метода
pc_oop_handleAttrM = {
	if (isnil '_editor_next_attr') exitwith {};
	__on_editor_attribute(_mem_name,_editor_attrs_m);
};