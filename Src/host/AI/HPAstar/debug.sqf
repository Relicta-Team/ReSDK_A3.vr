// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
/*
for debugging regions use:

call compile preprocessFileLineNumbers "src\host\AI\ai_init.sqf";
call ai_nav_clearDebugObjects;
_t = diag_tickTime;
_p = getposasl cameraon;
_key = _p call ai_nav_getregionkey;
_key splitString "_" apply {parsenumber _x} params ["_xp","_yp"];
_ctrupd = 0; 

_cnt = 1;
_icnt=2;

for "_i" from 1 to _cnt do {
for "_xd" from _xp-_icnt to _xp+_icnt do {
for "_yd" from _yp-_icnt to _yp+_icnt do {
_pd = [format["%1_%2",_xd,_yd]] call ai_nav_regionToPos; _ctrupd=_ctrupd+1;
[_pd] call ai_nav_updateregion;
}
}

};
_t2 = diag_tickTime-_t;
[_t2/_cnt * 1000/_ctrupd,_ctrupd];


//test in MP
_nodes= ai_nav_regions get([3787.83,3789.09,24.3677] call ai_nav_getregionkey) get "nodes";
objs = [];
{
_pos = ai_nav_nodes get _x get "pos";
{
_p2 = ai_nav_nodes get (_x select 0) get "pos";
objs pushback [asltoatl _pos,asltoatl _p2,[1,0,0,1],20];
} foreach (ai_nav_adjacency get _x);

} foreach _nodes;
publicVariable "objs"

*/

if isNull(ai_debug_objs) then {
	ai_debug_objs = [];
};

// Функция логирования для отладки
// Работает как в редакторе (3DEN), так и в игре
ai_debugLog = {
	#ifdef AI_ENABLE_DEBUG_LOG
	if (is3den) then {
		_this call printTrace; // Внутренняя функция редактора
	} else {
		trace(format _this); // Макрос из engine.hpp
	};
	#endif
};

// Очистка отладочных объектов
ai_nav_clearDebugObjects = {
	{
		if (!isNullReference(_x)) then {
			deleteVehicle _x;
		};
	} forEach ai_debug_objs;
	ai_debug_objs = [];
	["Debug objects cleared"] call ai_debugLog;
};

ai_nav_debug_createObj = {
	params ["_pos", ["_color",[1,1,1]],["_size",1],["_isSphere",false],["_list",ai_debug_objs]];
	private _cls = "Sign_Arrow_F";
	if (_isSphere) then {
		_cls = "Sign_Sphere10cm_F";
	};
	private _arrow = _cls createVehicle [0,0,0];
	_arrow setPosASL _pos;
	_arrow setObjectTextureGlobal [0, format["#(rgb,8,8,3)color(%1,%2,%3,1)",_color select 0,_color select 1,_color select 2]];
	_arrow setObjectScale _size;
	_list pushBack _arrow;
	_arrow
};

ai_nav_debug_drawNode = {
	params ["_pos","_pos2",["_color",[1,0,0,1]],["_wdt",1]];
	drawLine3D [_pos, _pos2, _color,_wdt];
};

// ============================================================================
// ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ДЛЯ ТЕСТИРОВАНИЯ
// ============================================================================

// Быстрая инициализация навигации вокруг позиции
ai_nav_quickInit = {
	params ["_pos", ["_radius", 50]];
	
	// Очищаем предыдущие данные
	call ai_nav_clearAllRegions;
	private _t = tickTime;
	// Генерируем регионы
	private _regions = [_pos, _radius] call ai_nav_generateRegions;
	
	["Navigation initialized: %1 regions generated around %2" arg count _regions arg _pos] call ai_debugLog;
	
	//Строим переходные точки между регионами
	private _entrances = call ai_nav_buildEntrancePoints;
	
	["Built %1 entrance connections between regions" arg _entrances] call ai_debugLog;
	["TOTAL TIME: %1ms" arg ((tickTime - _t)*1000)toFixed 2] call ai_debugLog;
	
	_regions
};

// Получить информацию о системе навигации
ai_nav_getStats = {
	private _totalNodes = count (keys ai_nav_nodes);
	private _totalRegions = count (keys ai_nav_regions);
	private _totalEdges = 0;
	
	{
		private _regionData = _y;
		_totalEdges = _totalEdges + count (_regionData get "edges");
	} forEach ai_nav_regions;
	
	private _stats = createHashMap;
	_stats set ["regions", _totalRegions];
	_stats set ["nodes", _totalNodes];
	_stats set ["edges", _totalEdges];
	
	_stats
};

// Визуализация найденного пути
ai_nav_debugDrawPath = {
	params ["_path", ["_color", [1,0,1,1]], ["_width", 30]];
	
	if (count _path < 2) exitWith {
		ai_debug_decl(["Path too short to draw: %1 nodes" arg count _path] call ai_debugLog);
	};
	
	private _pathLoops = [];
	
	for "_i" from 0 to (count _path - 2) do {
		private _p1 = _path select _i;
		private _p2 = _path select (_i + 1);
		
		private _loop = struct_newp(LoopedObjectFunction,
			ai_nav_debug_drawNode arg [
				asltoatl _p1 vectoradd vec3(0,0,0.3) arg 
				asltoatl _p2 vectoradd vec3(0,0,0.3) arg 
				_color arg 
				_width
			] arg 
			null arg 
			ai_debug_objsPath select 0
		);
		
		_pathLoops pushBack _loop;
	};
	
	ai_debug_decl(["Draw path with %1 segments" arg count _pathLoops] call ai_debugLog);
	
	_pathLoops
};

// Тест: найти и визуализировать путь между двумя позициями
ai_nav_testPath = {
	params ["_startPos", "_endPos",["_optimize",true],["_fnc","part"],["_args",[]]];
	
	// Находим путь
	private _argv = [_startPos, _endPos, _optimize]+_args;
	private _path = call {
		if (_fnc == "autogen") exitWith {_argv call ai_nav_findPath_autoGenerate};
		if (_fnc == "part") exitWith {_argv call ai_nav_findPartialPath};
		[]
	};
	
	if (count _path == 0) exitWith {
		["No path found between positions!"] call ai_debugLog;
		[]
	};
	
	// Визуализируем путь (фиолетовый цвет)
	deleteVehicle ai_debug_objsPath;
	ai_debug_objsPath = [];

	// Визуализируем старт и конец (зеленый и красный маркеры)
	[_startPos, [0,1,0], 5, true,ai_debug_objsPath] call ai_nav_debug_createObj; // Зеленый старт
	[_endPos, [1,0,0], 5, true,ai_debug_objsPath] call ai_nav_debug_createObj;   // Красный конец
	
	private _loops = [_path, [1,0,1,1], 30] call ai_nav_debugDrawPath;
	{
		[_x, [1,0,0,1],2,false,ai_debug_objsPath] call ai_nav_debug_createObj;
	} foreach _path;
	
	["Path found: %1 waypoints, distance: %2m" arg count _path arg (_startPos distance _endPos)toFixed 2] call ai_debugLog;
	
	_path
};



ai_nav_debug_testPathOnline = {
	params ["_startPos", "_endPos"];

	if isNull(ai_nav_debug_internal_obsOnline) then {
		ai_nav_debug_internal_obsOnline = [];
	};

	deleteVehicle ai_nav_debug_internal_obsOnline;
	ai_nav_debug_internal_obsOnline = [];

	private _p = [_startPos,_endPos,false] call ai_nav_findPartialPath;
	{
		[_x, [0,1,0], 5, true,ai_nav_debug_internal_obsOnline] call ai_nav_debug_createObj
	} foreach _p;

	_p
};


ai_nav_debug_clientDrawRegionInfo = {
	private _pos = getposasl player;
	private _key = _pos call ai_nav_getRegionKey;
	private _region = ai_nav_regions get _key;
	if (isNullVar(_region)) exitWith {};
	private _nodes = _region get "nodes";
	private _drawInfo = [];
	{
		private _node = ai_nav_nodes get _x;
		_pos1 = _node get "pos";
		_connections = _node get "neighbors";
		{
			_pos2 = ai_nav_nodes get (_x select 0) get "pos";
			_drawInfo pushback [(asltoatl _pos1)vectoradd vec3(0,0,0.1),(asltoatl _pos2)vectoradd vec3(0,0,0.1), [0,1,0,1], 50];
		} foreach (ai_nav_adjacency get _x);
	} foreach _nodes;
	
	{
		struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg _x arg null arg player);
	} foreach _drawInfo;
	_drawInfo
};

ai_nav_debug_nativeTest = {
	params [["_native",true]];
	if (!is3den) exitWith {
		error("ai_nav_debug_nativeTest can only be used in editor");
	};

	ai_nav_debug_nativeTest_flags = createhashmapfromarray [
		// сравнивает время выполнения скриптовой и нативной функции
		["comparescript",false],
		// логирует время выполнения поиска пути
		["logpathtime",false],
		//отладочная отрисовка узлов
		["debugdraw",true]
	];
	
	if !isNull(ai_nav_debug_internal_nativeTestObjects) then {
		delete3denentities ai_nav_debug_internal_nativeTestObjects;
		ai_nav_debug_internal_nativeTestObjects = [];
	};
	private _cfg = "Sign_Arrow_F";
	// ([screenToWorld getMousePosition,ai_nav_debug_internal_targetCursor] call golib_om_getRayCastData)params["_obj","_pos","_vecup"];
	private _atlPos = getposatl get3dencamera;
	ai_nav_debug_internal_nativeTestObjects = [
		create3DENEntity ["Object",_cfg, _atlPos],
		create3DENEntity ["Object",_cfg, _atlPos]
	];
	
	call compile preprocessFileLineNumbers "src\host\RVEngine\init.sqf";
	["rv_client"] call rve_loadlib;
	call ai_nav_clearDebugObjects;
	_t = tickTime;
	_p = getposasl get3dencamera;
	_key = _p call ai_nav_getregionkey;
	_key splitString "_" apply {parsenumber _x} params ["_xp","_yp"];
	private _ctrupd = 0;

	_cnt = 1;
	_icnt=1;
	if (!_native) then {
		ai_nav_useNative = {false};
	};
	for "_i" from 1 to _cnt do {
		for "_xd" from _xp-_icnt to _xp+_icnt do {
			for "_yd" from _yp-_icnt to _yp+_icnt do {
			_pd = [format["%1_%2",_xd,_yd]] call ai_nav_regionToPos; _ctrupd=_ctrupd+1;
			[_pd] call ai_nav_updateregion;
			}
		}
	};

	_t2 = tickTime-_t;
	[_t2/_cnt * 1000/_ctrupd,_ctrupd];
	["Generated %1 regions in %2ms, avg %3ms/region", _ctrupd, _t2*1000,((_t2/_cnt * 1000)/_ctrupd) toFixed 2] call printLog;
	
	if (ai_nav_debug_nativeTest_flags get "debugdraw") then {
		{
			_pos = _y get "pos";
			[_pos, [0,1,0,1], 5, true] call ai_nav_debug_createObj;
		} foreach ai_nav_nodes;
	};
	
	if !isNull(ai_nav_debug_internal_handleOnFrame) then {
		["onFrame",ai_nav_debug_internal_handleOnFrame] call Core_removeEventHandler;
		ai_nav_debug_internal_handleOnFrame = null;
	};
	
	ai_nav_debug_internal_handleOnFrame = ["onFrame",{
		if (!isgamefocused) exitWith {};
		
		ai_nav_debug_internal_nativeTestObjects params ["_startObj","_endObj"];
		
		private _ref = refcreate([]);
		_t = tickTime;
		_p = [getposasl _startObj,getposatl _endObj,true,_ref] call ai_nav_findPartialPath;
		_t2 = tickTime-_t;

		_perfboost = "disabled";
		if (ai_nav_debug_nativeTest_flags get "comparescript") then {
			//override native func
			_canusefncptr = ai_nav_useNative;
			ai_nav_useNative = {false};

			_tscr = tickTime;
			_p = [getposasl _startObj,getposatl _endObj,true,_ref] call ai_nav_findPartialPath_sqf;
			_tscr2 = tickTime-_tscr;

			//restore native func
			ai_nav_useNative = _canusefncptr;
			_perfboost = (_tscr2-_t2)*1000;
		};

		{
			if (_foreachindex == 0) then {continue};
			drawline3d [asltoagl(_p select (_foreachindex-1)),asltoagl(_p select _foreachindex),[1,0,0,1],50];
		} foreach _p;

		if (ai_nav_debug_nativeTest_flags get "logpathtime") then {
			["path time %1 (%2/%3); perf boost %4ms",_t2*1000,count _p,count refget(_ref),_perfboost] call printLog;
		};
	}] call Core_addEventHandler;
};