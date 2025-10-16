// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// ============================================================================
// HPA* NAVIGATION SYSTEM
// ============================================================================
// Иерархическая навигационная система для AI с поддержкой 3D навигации,
// многоуровневых структур и динамической генерации навигационной сетки.
// 
// Система использует региональный подход (10×10м регионы) для оптимизации
// производительности и поддержки карт любого размера.
// 
// ============================================================================
// БЫСТРЫЙ СТАРТ:
// ============================================================================
// 1. Инициализация навигации:
//    [getPosASL player, 50] call ai_nav_quickInit;
//
// 2. Поиск пути:
//    private _path = [getPosASL player, _targetPos] call ai_nav_findPath;
//
// 3. Тестирование с визуализацией:
//    [getPosASL player, _targetPos] call ai_nav_testPath;
//
// 4. Получить статистику:
//    call ai_nav_getStats;
//
// ============================================================================
// ВИЗУАЛИЗАЦИЯ:
// ============================================================================
// 🟢 Зеленые сферы    - узлы навигации
// 🟡 Желтые линии     - границы регионов
// 🔵 Голубые линии    - связи внутри региона
// 🔴 Красные линии    - переходные точки между регионами
// 🟣 Фиолетовые линии - найденный путь
// ============================================================================

// ============================================================================
// ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ И КОНФИГУРАЦИЯ
// ============================================================================
#define AI_NAV_DEBUG true
//#define AI_NAV_DEBUG_DRAW true


// Навигационные данные
ai_nav_regions = createHashMap;      // regionKey -> region data
ai_nav_nodes = createHashMap;        // nodeId -> node data  
ai_nav_adjacency = createHashMap;    // nodeId -> [[neighborId, cost], ...]

// Конфигурация генерации сетки
ai_nav_regionSize = 10;              // Размер региона 10×10м
ai_nav_gridStep = 1;                 // Шаг сетки 1м
ai_nav_maxSlope = 45;                // Максимальный угол склона в градусах
ai_nav_raycastHeight = 300;          // Высота начала raycast
ai_nav_minDistZ = 0.7;				// Минимальное расстояние по Z построения узлов по z

ai_nav_nodeIdCounter = 0;

#ifdef AI_NAV_DEBUG
	#define ai_debug_decl(linedecl) linedecl
#else
	#define ai_debug_decl(linedecl) 
#endif


// Генерация уникального ID для узла
ai_nav_generateNodeId = {
	ai_nav_nodeIdCounter = ai_nav_nodeIdCounter + 1;
	ai_nav_nodeIdCounter
};

ai_nav_getSlopeAngleVec = {
	params ["_pos1","_pos2"];
	private _dir = _pos2 vectorDiff _pos1;
	private _dirNorm = vectorNormalized _dir;

	// Горизонтальный вектор (проекция на XY плоскость)
	private _horDir = [_dirNorm select 0, _dirNorm select 1, 0];
	private _horDirNorm = vectorNormalized _horDir;

	// Угол между векторами через скалярное произведение
	private _dotProduct = _dirNorm vectorDotProduct _horDirNorm;
	private _slopeAngle = acos _dotProduct; // В градусах
	_slopeAngle
};

// БЫСТРАЯ проверка наклона (без векторных операций)
ai_nav_checkSlopeFast = {
	params ["_pos1", "_pos2", "_dist", "_maxSlope"];
	
	// Вычисляем deltaZ
	private _deltaZ = abs((_pos2 select 2) - (_pos1 select 2));
	
	// Простая проверка: если Z больше определенного процента от distance
	// tan(45°) = 1.0, tan(60°) = 1.732, tan(75°) = 3.732
	private _slopeTan = tan _maxSlope;
	
	// Горизонтальное расстояние (приближенно)
	// Для малых углов можно использовать _dist как приближение
	if (_deltaZ / _dist > _slopeTan) exitWith {false};
	
	true
};

ai_nav_generateRegionNodes = {
	params ["_pos", ["_autoSave", true]];
	
	// Получаем ключ региона
	private _regionKey = _pos call ai_nav_getRegionKey;
	
	// Проверяем, не существует ли регион уже
	if (_regionKey in ai_nav_regions) exitWith {
		ai_debug_decl(["Region %1 already exists, skipping generation" arg _regionKey] call ai_debugLog);
		_regionKey
	};
	
	private _regionStartX = floor((_pos select 0) / ai_nav_regionSize) * ai_nav_regionSize;
	private _regionStartY = floor((_pos select 1) / ai_nav_regionSize) * ai_nav_regionSize;
	private _regionEndX = _regionStartX + ai_nav_regionSize - ai_nav_gridStep; // Исключаем правую границу
	private _regionEndY = _regionStartY + ai_nav_regionSize - ai_nav_gridStep; // Исключаем верхнюю границу
	private _queryPos = [];
	
	ai_debug_decl(private _t = tickTime;)
	for "_x" from _regionStartX to _regionEndX step ai_nav_gridStep do {
		for "_y" from _regionStartY to _regionEndY step ai_nav_gridStep do {
			_queryPos pushBack [
				[_x,_y,ai_nav_raycastHeight],
				[_x,_y,0],
				objNull,
				objNull,
				true,
				-1,
				"ROADWAY", //когда игроки смогут ходить по любым поверхностям и мобы смогут
				"ROADWAY",
				false //ret unique
			];
		};
	};

	private _nodes = [];

	//постройка сетки
	private _hits = lineIntersectsSurfaces [_queryPos];
	{
		private _prevpos = [0,0,99999];
		{
			_x params ["_pos","_norm","_obj"];
			//пропускаем самый верхний слой (это крыша потолка) 
			//проверка дает перф буст на 49% меньше точек, и общий перф выше на 30% при условии что потолок ходибельный
			if (_forEachIndex == 0) then {
				private _hitUp = lineIntersectsSurfaces [
					_pos,
					_pos vectoradd vec3(0,0,ai_nav_raycastHeight),
					objNull,
					objNull,
					true,
					1,
					"VIEW",
					"GEOM"
				];
				if (count _hitUp == 0) then {
					continue;
				};
			};
			
			//поверхность карты пропускаем
			if (isNullReference(_obj)) then {continue};

			//если с предыдущей точки расстояние меньше минимального, то пропускаем
			if (((_prevpos select 2)-(_pos select 2)) < ai_nav_minDistZ) then {
				continue
			};

			_nodes pushBack _pos;

			#ifdef AI_NAV_DEBUG_DRAW
			[_pos,[0,1,0],3,true] call ai_nav_debug_createObj;
			#endif

			_prevpos = _pos;
		} foreach _x;
	} foreach _hits;
	ai_debug_decl(["    generateRegionNodes time %1ms" arg ((tickTime - _t)*1000)toFixed 6] call ai_debugLog);

	#ifdef AI_NAV_DEBUG_DRAW
		ai_debug_loopDrawObjs = [];
		//debug draw region
		private _height =( _pos select 2)-3;
		private _corner1 = asltoatl[_regionStartX, _regionStartY, _height];
		private _corner2 = asltoatl[_regionEndX, _regionStartY, _height];
		private _corner3 = asltoatl[_regionEndX, _regionEndY, _height];
		private _corner4 = asltoatl[_regionStartX, _regionEndY, _height];
		
		// Рисуем 4 линии границ региона
		private _loopRegion1 = struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg [_corner1 arg _corner2 arg [1 arg 1 arg 0 arg 1] arg 20] arg null arg ai_debug_objs select 0);
		private _loopRegion2 = struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg [_corner2 arg _corner3 arg [1 arg 1 arg 0 arg 1] arg 20] arg null arg ai_debug_objs select 0);
		private _loopRegion3 = struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg [_corner3 arg _corner4 arg [1 arg 1 arg 0 arg 1] arg 20] arg null arg ai_debug_objs select 0);
		private _loopRegion4 = struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg [_corner4 arg _corner1 arg [1 arg 1 arg 0 arg 1] arg 20] arg null arg ai_debug_objs select 0);
		
		ai_debug_loopDrawObjs pushback _loopRegion1;
		ai_debug_loopDrawObjs pushback _loopRegion2;
		ai_debug_loopDrawObjs pushback _loopRegion3;
		ai_debug_loopDrawObjs pushback _loopRegion4;
		
		{
			//! отключено
			//private _loop = struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg [asltoatl _x arg asltoatl _x vectoradd vec3(0,0,10) arg null arg 15] arg null arg ai_debug_objs select 0);
			//ai_debug_loopDrawObjs pushback _loop;
		} foreach _nodes;
	#endif

	//постройка связей
	ai_debug_decl(private _tEdges = tickTime;)
	private _maxConnectionDist = ai_nav_gridStep * 2; // Максимальное расстояние связи (по диагонали)
	private _edgesList = [];
	_queryPos = [];

	
	private _connectionData = [];
	
	{
		private _currentNode = _x;
		private _currentIdx = _forEachIndex;
		
		// Ищем соседние узлы для связи
		for "_i" from (_currentIdx + 1) to (count _nodes - 1) do {
			private _neighborNode = _nodes select _i;
			private _dist = _currentNode distance _neighborNode;
			
			// Если узел в пределах дистанции связи
			if (_dist <= _maxConnectionDist) then {
				//по z расстояние не может быть больше 1м (быстрая проверка первой)
				private _deltaZ = abs((_currentNode select 2) - (_neighborNode select 2));
				if (_deltaZ > 1) exitWith {};
				
				// БЫСТРАЯ проверка наклона (вместо getSlopeAngleVec)
				if !([_currentNode, _neighborNode, _dist, ai_nav_maxSlope] call ai_nav_checkSlopeFast) exitWith {};

				// Проверяем, нет ли препятствий между узлами
				_queryPos pushBack [
					_currentNode vectoradd vec3(0,0,0.4),
					_neighborNode vectoradd vec3(0,0,0.4),
					objNull,
					objNull,
					true,
					1,
					"VIEW",
					"GEOM"
				];
				
				_connectionData pushBack [_currentNode, _neighborNode, _dist];
				
			};
		};
	} forEach _nodes;
	
	
	_hits = lineIntersectsSurfaces [_queryPos];
	
	{
		if (count _x == 0) then {
			(_connectionData select _forEachIndex) params ["_currentNode","_neighborNode","_dist"];
			_edgesList pushBack ([_currentNode, _neighborNode, _dist]);
			#ifdef AI_NAV_DEBUG_DRAW
				
				private _loopEdge = struct_newp(LoopedObjectFunction,ai_nav_debug_drawNode arg [
					asltoatl _currentNode vectoradd vec3(0,0,0.15) arg 
					asltoatl _neighborNode vectoradd vec3(0.1,0,0.15) arg 
					[0 arg 0.5 arg 1 arg 0.8] arg 
					15
				] arg null arg ai_debug_objs select 0);
				ai_debug_loopDrawObjs pushback _loopEdge;
			#endif
		};
	} foreach _hits;
	
	ai_debug_decl(["    generateRegionEdges time %1ms, edges count: %2" arg ((tickTime - _tEdges)*1000)toFixed 6 arg count _edgesList] call ai_debugLog);
	
	// Автоматически сохраняем регион, если включено
	if (_autoSave) then {
		[_regionKey, _nodes, _edgesList] call ai_nav_saveRegion;
	};
	
	// Возвращаем ключ региона
	_regionKey
};

// Найти ближайший узел к позиции
ai_nav_findNearestNode = {
	params ["_pos", ["_maxDistance", 50]];
	
	private _regionKey = _pos call ai_nav_getRegionKey;
	private _regionData = ai_nav_regions get _regionKey;
	
	// Если регион не существует, ищем в ближайших регионах
	if (isNil "_regionData") then {
		private _bestNode = -1;
		private _bestDist = 999999;
		
		{
			private _nodeData = _y;
			private _nodePos = _nodeData get "pos";
			private _dist = _pos distance _nodePos;
			
			if (_dist < _bestDist && _dist <= _maxDistance) then {
				_bestDist = _dist;
				_bestNode = _x;
			};
		} forEach ai_nav_nodes;
		
		if (_bestNode == -1) exitWith {-1};
		_bestNode
	};
	
	// Ищем в текущем регионе
	private _nodeIds = _regionData get "nodes";
	private _bestNode = -1;
	private _bestDist = 999999;
	
	{
		private _nodeId = _x;
		private _nodeData = ai_nav_nodes get _nodeId;
		private _nodePos = _nodeData get "pos";
		private _dist = _pos distance _nodePos;
		
		if (_dist < _bestDist) then {
			_bestDist = _dist;
			_bestNode = _nodeId;
		};
	} forEach _nodeIds;
	
	if (_bestDist > _maxDistance) then {
		-1
	} else {
		_bestNode
	}
};


// Восстановить путь из массива родителей
ai_nav_reconstructPath = {
	params ["_cameFrom", "_current"];
	
	private _path = [_current];
	
	while {_current in _cameFrom} do {
		_current = _cameFrom get _current;
		_path pushBack _current;
	};
	
	reverse _path;
	_path
};

// Эвристическая функция (расстояние по прямой)
ai_nav_heuristic = {
	params ["_nodeId1", "_nodeId2"];
	
	private _pos1 = (ai_nav_nodes get _nodeId1) get "pos";
	private _pos2 = (ai_nav_nodes get _nodeId2) get "pos";
	//?можно потом сделать что чем дальше идти до цели тем выше коэф (быстрее посчитается)
	(_pos1 distance _pos2) * 1.3 //с агрессивным коэффициентом вычисляется в ~10 раз быстрее
};

// Получить соседей узла
ai_nav_getNeighbors = {
	params ["_nodeId"];
	
	private _neighbors = ai_nav_adjacency getOrDefault [_nodeId, []];
	_neighbors
};

// A* алгоритм поиска пути между двумя узлами (ОПТИМИЗИРОВАННЫЙ)
ai_nav_findPathNodes = {
	params ["_startNodeId", "_goalNodeId"];
	FHEADER;
	
	if (_startNodeId == -1 || _goalNodeId == -1) exitWith {
		ai_debug_decl(["Invalid node IDs: start=%1, goal=%2" arg _startNodeId arg _goalNodeId] call ai_debugLog);
		[]
	};
	
	ai_debug_decl(private _tStart = tickTime;)
	
	// Инициализация
	private _openSet = [_startNodeId];
	private _closedSet = createHashMap; // ← КРИТИЧНО: множество посещенных узлов
	private _cameFrom = createHashMap;
	
	private _gScore = createHashMap;
	_gScore set [_startNodeId, 0];
	
	private _fScore = createHashMap;
	_fScore set [_startNodeId, [_startNodeId, _goalNodeId] call ai_nav_heuristic];
	
	private _iterations = 0;
	private _maxIterations = 10000;
	
	ai_debug_decl(private _minSearchTime = 0;)
	ai_debug_decl(private _neighborsTime = 0;)
	ai_debug_decl(private _maxOpenSetSize = 0;)
	ai_debug_decl(private _totalNeighborsChecked = 0;)
	
	while {count _openSet > 0 && _iterations < _maxIterations} do {
		_iterations = _iterations + 1;
		
		ai_debug_decl(if (count _openSet > _maxOpenSetSize) then {_maxOpenSetSize = count _openSet};)
		
		// Найти узел с минимальным fScore (ОПТИМИЗИРОВАНО)
		ai_debug_decl(private _tMin = tickTime;)
		
		// Быстрый поиск минимума без повторных HashMap запросов
		private _minIdx = 0;
		private _current = _openSet select 0;
		private _minF = _fScore getOrDefault [_current, 999999];
		
		for "_i" from 1 to (count _openSet - 1) do {
			private _nodeId = _openSet select _i;
			private _f = _fScore getOrDefault [_nodeId, 999999];
			if (_f < _minF) then {
				_minF = _f;
				_current = _nodeId;
				_minIdx = _i;
			};
		};
		
		ai_debug_decl(_minSearchTime = _minSearchTime + (tickTime - _tMin);)
		
		// Достигли цели
		if (_current == _goalNodeId) exitWith {
			private _path = [_cameFrom, _current] call ai_nav_reconstructPath;
			
			ai_debug_decl([
				"Path found: %1 nodes, %2 iterations, maxOpenSet=%3, minSearch=%4ms, neighbors=%5ms (%6 checked) | TOTAL=%7ms" arg 
				count _path arg 
				_iterations arg 
				_maxOpenSetSize arg
				(_minSearchTime*1000)toFixed 2 arg
				(_neighborsTime*1000)toFixed 2 arg
				_totalNeighborsChecked arg
				((tickTime - _tStart)*1000)toFixed 2
			] call ai_debugLog);
			
			RETURN(_path);
		};
		
		// Удаляем текущий из openSet и добавляем в closedSet
		_openSet deleteAt _minIdx; // ← Используем сохраненный индекс вместо поиска!
		_closedSet set [_current, true]; // ← Помечаем как посещенный
		
		// Проверяем соседей
		ai_debug_decl(private _tNeighbors = tickTime;)
		private _neighbors = [_current] call ai_nav_getNeighbors;
		
		{
			_x params ["_neighborId", "_cost"];
			
			// ← ПРОПУСКАЕМ УЖЕ ПОСЕЩЕННЫЕ УЗЛЫ!
			if (_neighborId in _closedSet) then {continue};
			
			ai_debug_decl(_totalNeighborsChecked = _totalNeighborsChecked + 1;)
			
			private _tentativeGScore = (_gScore getOrDefault [_current, 999999]) + _cost;
			
			if (_tentativeGScore < (_gScore getOrDefault [_neighborId, 999999])) then {
				_cameFrom set [_neighborId, _current];
				_gScore set [_neighborId, _tentativeGScore];
				_fScore set [_neighborId, _tentativeGScore + ([_neighborId, _goalNodeId] call ai_nav_heuristic)];
				
				if (!(_neighborId in _openSet)) then {
					_openSet pushBack _neighborId;
				};
			};
		} forEach _neighbors;
		ai_debug_decl(_neighborsTime = _neighborsTime + (tickTime - _tNeighbors);)
	};
	
	ai_debug_decl([
		"Path not found after %1 iterations (max: %2), maxOpenSet=%3" arg 
		_iterations arg 
		_maxIterations arg
		_maxOpenSetSize
	] call ai_debugLog);
	
	[]
};

// Найти путь между двумя позициями
ai_nav_findPath = {
	params ["_startPos", "_endPos",["_optimize",true]];
	
	ai_debug_decl(["Finding path from %1 to %2" arg _startPos arg _endPos] call ai_debugLog);
	
	// Находим ближайшие узлы
	private _startNode = [_startPos] call ai_nav_findNearestNode;
	private _endNode = [_endPos] call ai_nav_findNearestNode;
	
	if (_startNode == -1) exitWith {
		ai_debug_decl(["No start node found near %1" arg _startPos] call ai_debugLog);
		[]
	};
	
	if (_endNode == -1) exitWith {
		ai_debug_decl(["No end node found near %1" arg _endPos] call ai_debugLog);
		[]
	};
	
	// Запускаем A*
	private _pathNodes = [_startNode, _endNode] call ai_nav_findPathNodes;
	
	if (count _pathNodes == 0) exitWith {[]};
	
	// Конвертируем узлы в позиции
	private _pathPositions = [];
	{
		private _nodeData = ai_nav_nodes get _x;
		private _pos = _nodeData get "pos";
		_pathPositions pushBack _pos;
	} forEach _pathNodes;
	
	// Оптимизируем путь (убираем лишние промежуточные точки)
	private _optimizedPath = if (_optimize) then {[_pathPositions] call ai_nav_smoothPath_fast} else {_pathPositions};
	
	_optimizedPath
};

// ============================================================================
// PATH SMOOTHING - Оптимизация пути
// ============================================================================

// Упрощение пути методом Line-of-Sight
// Убирает промежуточные точки, если можно пройти напрямую
ai_nav_smoothPath = {
	params ["_path"];
	
	if (count _path < 3) exitWith {_path}; // Нечего оптимизировать
	
	ai_debug_decl(private _tStart = tickTime;)
	
	private _smoothPath = [_path select 0]; // Начинаем со стартовой точки
	private _currentIdx = 0;
	
	while {_currentIdx < (count _path - 1)} do {
		private _fromPos = _path select _currentIdx;
		private _farthestIdx = _currentIdx + 1;
		
		// Ищем самую дальнюю точку, до которой можно дойти по прямой
		for "_i" from (_currentIdx + 2) to (count _path - 1) do {
			private _toPos = _path select _i;
			
			// Проверяем line-of-sight (нет ли препятствий)
			if ([_fromPos, _toPos] call ai_nav_hasLineOfSight) then {
				_farthestIdx = _i; // Можем дойти до этой точки напрямую
			} else {
				break; // Препятствие - дальше не проверяем
			};
		};
		
		// Добавляем самую дальнюю доступную точку
		_smoothPath pushBack (_path select _farthestIdx);
		_currentIdx = _farthestIdx;
	};
	
	ai_debug_decl([
		"Path smoothing: %1 → %2 waypoints in %3ms" arg 
		count _path arg 
		count _smoothPath arg 
		((tickTime - _tStart)*1000)toFixed 2
	] call ai_debugLog);
	
	_smoothPath
};

// Проверка line-of-sight между двумя точками
ai_nav_hasLineOfSight = {
	params ["_pos1", "_pos2"];
	
	// Проверяем, нет ли препятствий между точками
	private _intersections = lineIntersectsSurfaces [
		_pos1 vectoradd vec3(0,0,0.4),
		_pos2 vectoradd vec3(0,0,0.4),
		objNull,
		objNull,
		true,
		1,
		"VIEW",
		"GEOM"
	];
	
	// Если нет пересечений - есть line of sight
	count _intersections == 0
};

ai_nav_smoothPath_fast = {
    params ["_path"];
    
    if (count _path < 3) exitWith {_path};
    
	ai_debug_decl(private _tStart = tickTime;)

    private _result = [_path select 0];
    
    for "_i" from 1 to (count _path - 2) do {
        private _v1 = (_path select _i) vectorDiff (_path select (_i - 1));
        private _v2 = (_path select (_i + 1)) vectorDiff (_path select _i);
        
        // Если векторы не сонаправлены - это поворот
        if (vectorMagnitude (_v1 vectorCrossProduct _v2) > 0.1) then {
            _result pushBack (_path select _i);
        };
    };
    
    _result pushBack (_path select (count _path - 1));
    ai_debug_decl([
        "Path smoothing: %1 → %2 waypoints in %3ms" arg 
        count _path arg 
        count _result arg 
        ((tickTime - _tStart)*1000)toFixed 2
    ] call ai_debugLog);
    _result
};
