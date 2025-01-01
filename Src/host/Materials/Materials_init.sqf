// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"

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

loadFile("src\host\Materials\Materials_base.sqf");