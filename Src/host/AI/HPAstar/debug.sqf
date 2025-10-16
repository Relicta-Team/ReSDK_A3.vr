// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Функция логирования для отладки
// Работает как в редакторе (3DEN), так и в игре
ai_debugLog = {
	if (is3den) then {
		_this call printTrace; // Внутренняя функция редактора
	} else {
		trace(format _this); // Макрос из engine.hpp
	};
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
	_arrow setObjectTexture [0, format["#(rgb,8,8,3)color(%1,%2,%3,1)",_color select 0,_color select 1,_color select 2]];
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
	params ["_startPos", "_endPos",["_optimize",true],["_fnc","autogen"],["_args",[]]];
	
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