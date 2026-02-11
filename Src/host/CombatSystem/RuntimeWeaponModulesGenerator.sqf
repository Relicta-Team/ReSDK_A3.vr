// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include <..\text.hpp>
/*
	Внимание!
	Данный файл инициализируется перед созданием классов для возможности использования cs_runtime_internal_generate

	Это рантайм генератор нодов.
	Если указанный нод уже существует пересоздавать он его не будет и выдаст исключение

	Использование:
	runtimeGenerateWeapon("nodeName","base")
	{
		var(someProperty,false);
		varpair(somehashmap, pair("one",1); pair("two",2); pair("five",5));
		getter_func(getSomeConstantValue,"");
	};
*/

cs_runtime_map_modules = hashMapNew;


//внутренняя реализация генератора узлов
cs_runtime_internal_generate = {
	params ["_typeName","_inherited",["_decl_file","<NULL_FILE>"],["_decl_line","<NaN>"]];
	private _node = tolower _typeName;
	if array_exists(cs_runtime_map_modules,_node) exitWith {
		errorformat("[cs::runtime::internal::generate()]: Error at generate node %1. Compilation process aborted",_node);
		appExit(APPEXIT_REASON_DOUBLEDEF);
	};
	private _segment = [_decl_file,_decl_line,_inherited];
	cs_runtime_map_modules set [_node,_segment];
	_segment
};


cs_runtime_internal_makeAll = {
	log("[cs::runtime::internal::makeAll]: Start generating weapon modules...");

	{
		(cs_runtime_map_modules get _x)params ["_file__","_line__","_inherited___","_initcode___"];

		//iterate class creator
		class_runtime(_x) extends_runtime(_inherited___)
			_decl_info___ = [_file__,_line__];
			call _initcode___;
		endclass

		logformat("[cs::runtime::internal::makeAll]: Generated class %1:%2 (%3 at %4)",_x arg _inherited___ arg _file__ arg _line__);

	} foreach (keys cs_runtime_map_modules);

	logformat("[cs::runtime::internal::makeAll]: Generating done. Created classes: %1",count cs_runtime_map_modules);
};
