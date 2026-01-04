// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"
#include "..\Networking\Network.hpp"

mat_map_all = createHashMap;

mat_getByClass = {
	params ["_cls"];
	_cls = tolower _cls;
	private _mobj = mat_map_all get _cls;
	
	#ifdef EDITOR
	if isNullVar(_mobj) then {
		private _fmtMes = format["Null material for class %1, Context object: %2",_cls,this];
		setLastError(_fmtMes);
	};
	#endif

	_mobj
};

//инициализатор материалов. Должен вызываться после генерации таблицы эмиттеров
mat_initializeMaterialTable = {
	private _thisClass = "MatBase";
	if (_thisClass!="MatBase") exitWith {};

	private _mdata = createHashMap;
	{
		private _class = _x;
		
		private _obj = instantiate(_class);
		private _objClass = callFunc(_obj,getClassName);

		mat_map_all set [tolower _objClass,_obj];

		callFuncParams(_obj,applyStepDataForGlobalVar,_mdata);
	} foreach getAllObjectsTypeOfStr(_thisClass);

	netSetGlobal(materials_map_stepData,_mdata);
};

loadFile("src\host\Materials\Materials_base.sqf");