// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
//#define AI_NAV_DEBUG true
//#define AI_NAV_DEBUG_DRAW true

#define AI_ENABLE_DEBUG_LOG

//дополнительные лучи для поиска незахваченных поверхностей
//#define AI_EXPERIMENTAL_NODE_HOLE_FIX

//использовать кеш spatial grid для переиспользования (на тестах не давало прироста)
//#define AI_USE_CACHE_SPATIAL_GRID

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

ai_nav_sortBy = {
	params ["_list","_algorithm",["_modeIsAscend",true]];

	private _cnt = 0;
	private _inputArray = _list apply 
	{
		_cnt = _cnt + 1; 
		[_x call _algorithm, _cnt, _x]
	};

	_inputArray sort _modeIsAscend;
	_inputArray apply {_x select 2}
	
};

// ============================================================================
// PRIORITY QUEUE (MIN-HEAP) для A*
// ============================================================================
// Бинарная куча для быстрого извлечения элемента с минимальным fScore
// Структура: массив [nodeId, fScore], где индекс 0 - минимум
// ============================================================================

// Восстановление свойств кучи вверх (после вставки)
ai_nav_heapifyUp = {
	params ["_heap", "_index"];
	
	while {_index > 0} do {
		private _parentIdx = floor((_index - 1) / 2);
		private _current = _heap select _index;
		private _parent = _heap select _parentIdx;
		
		// Если родитель меньше или равен - всё ок
		if ((_parent select 1) <= (_current select 1)) exitWith {};
		
		// Иначе меняем местами
		_heap set [_index, _parent];
		_heap set [_parentIdx, _current];
		_index = _parentIdx;
	};
};

// Восстановление свойств кучи вниз (после удаления корня)
ai_nav_heapifyDown = {
	params ["_heap", "_index"];
	private _size = count _heap;
	
	while {true} do {
		private _leftIdx = 2 * _index + 1;
		private _rightIdx = 2 * _index + 2;
		private _smallest = _index;
		
		// Проверяем левого потомка
		if (_leftIdx < _size) then {
			if (((_heap select _leftIdx) select 1) < ((_heap select _smallest) select 1)) then {
				_smallest = _leftIdx;
			};
		};
		
		// Проверяем правого потомка
		if (_rightIdx < _size) then {
			if (((_heap select _rightIdx) select 1) < ((_heap select _smallest) select 1)) then {
				_smallest = _rightIdx;
			};
		};
		
		// Если текущий элемент наименьший - всё ок
		if (_smallest == _index) exitWith {};
		
		// Иначе меняем местами и продолжаем
		private _temp = _heap select _index;
		_heap set [_index, _heap select _smallest];
		_heap set [_smallest, _temp];
		_index = _smallest;
	};
};

// Вставка элемента в кучу
ai_nav_heapInsert = {
	params ["_heap", "_nodeId", "_fScore"];
	
	_heap pushBack [_nodeId, _fScore];
	[_heap, (count _heap) - 1] call ai_nav_heapifyUp;
};

// Извлечение минимального элемента
ai_nav_heapExtractMin = {
	params ["_heap"];
	
	private _size = count _heap;
	if (_size == 0) exitWith {[-1, 999999]};
	
	private _min = _heap select 0;
	
	if (_size == 1) then {
		_heap resize 0;
	} else {
		_heap set [0, _heap select (_size - 1)];
		_heap resize (_size - 1);
		[_heap, 0] call ai_nav_heapifyDown;
	};
	
	_min
};

// Обновление fScore существующего элемента в куче
ai_nav_heapUpdateKey = {
	params ["_heap", "_nodeId", "_newFScore"];
	
	// Найти индекс элемента (O(n), но редкая операция)
	private _index = -1;
	{
		if ((_x select 0) == _nodeId) exitWith {
			_index = _forEachIndex;
		};
	} forEach _heap;
	
	if (_index == -1) exitWith {false};
	
	private _oldFScore = (_heap select _index) select 1;
	_heap set [_index, [_nodeId, _newFScore]];
	
	// Если уменьшили - heapifyUp, если увеличили - heapifyDown
	if (_newFScore < _oldFScore) then {
		[_heap, _index] call ai_nav_heapifyUp;
	} else {
		[_heap, _index] call ai_nav_heapifyDown;
	};
	
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
	for "_xp" from _regionStartX to _regionEndX step ai_nav_gridStep do {
		for "_yp" from _regionStartY to _regionEndY step ai_nav_gridStep do {
			_queryPos pushBack [
				[_xp,_yp,ai_nav_raycastHeight],
				[_xp,_yp,0],
				objNull,
				objNull,
				true,
				-1,
				"ROADWAY", //когда игроки смогут ходить по любым поверхностям и мобы смогут
				"ROADWAY",
				false //ret unique
			];

			#ifdef AI_EXPERIMENTAL_NODE_HOLE_FIX
			private _offsetPoints = [
				[0.2,0,0],    // Смещения на 20см
				[-0.2,0,0],
				[0,0.2,0],
				[0,-0.2,0]
			];
			
			{
				_queryPos pushBack [
					[_xp,_yp,ai_nav_raycastHeight] vectoradd _x,
					[_xp,_yp,0] vectoradd _x,
					objNull,
					objNull,
					true,
					-1,
					"ROADWAY",
					"ROADWAY",
					false
				];
			} foreach _offsetPoints;
			#endif
		};
	};

	private _nodes = [];

	// === SPATIAL GRID OPTIMIZATION ===
	// Делим пространство на ячейки 2×2м
	private _maxConnectionDist = ai_nav_gridStep * 2; // Максимальное расстояние связи (по диагонали)
	private _gridSize = _maxConnectionDist; // 2m
	private _spatialGrid = createHashMap;

	private _cellOffsets = [
		[-1,-1],[-1,0],[-1,1],
		[0,-1], [0,0], [0,1],
		[1,-1], [1,0], [1,1]
	];
	
	//постройка сетки
	private _hits = lineIntersectsSurfaces [_queryPos];

	private _connectionData = [];
	_queryPos = [];
	
	#ifdef AI_EXPERIMENTAL_NODE_HOLE_FIX
	private _filteredHits = []; private _otherside = [];
	{
		if (_foreachindex %5 == 0) then {
			//_otherside append (_hits select [_foreachindex + 1,4]);
			private _cur = _x;
			private _others = (_hits select [_foreachindex + 1,4]);
			private _otherflat = []; {_otherflat append _x} foreach _others;
			
			[_otherflat,{_x select 0 select 2},false] call ai_nav_sortBy;
			// {_cur append _x} foreach _others;
			//_cur = [_cur,{_x select 0 select 2},false] call ai_nav_sortBy;
			//_filteredHits pushBack _cur;

			// УМНОЕ ЗАПОЛНЕНИЕ ДЫР в _cur с оптимизацией
			private _patchedCur = [];
			private _prevZ = 999999;
			private _sizecheck = 0.7;
			
			{
				private _curPos = _x select 0;
				private _curZ = _curPos select 2;
				
				// Если есть дыра между предыдущей и текущей точкой
				if ((_prevZ-_curZ) > _sizecheck) then {
					
					// Ищем дополнительные точки, которые попадают в эту дыру
					private _foundInGap = [];
					private _remIndexLast = -1;
					private _curZOffset = _curZ + _sizecheck;
					{
						private _otherPos = _x select 0;
						private _otherZ = _otherPos select 2;
						//! Работает криво. надо долго и упорно тестить и искать подходы
						if ( _otherZ < _curZOffset) exitWith {
							
							_foundInGap = _otherflat select (_forEachIndex-1);
                			_remIndexLast = _forEachIndex-1;
						};
					} foreach _otherflat;
					// Добавляем найденные точки в дыру
					if (_remIndexLast != -1) then {
            		_patchedCur insert [(count _patchedCur)-1-1,[_foundInGap]];
					_otherflat deleteRange [0,_remIndexLast+1];
					};
				};
				
				_patchedCur pushBack _x; // Добавляем основную точку
				_prevZ = _curZ;
			} foreach _cur;
			
			_filteredHits pushBack _patchedCur; // Используем пропатченный _cur
		};
	} foreach _hits; //выбор элемента с пропуском 4 тест точек
	_hits = _filteredHits;
	#endif

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

			// === ОПТИМИЗАЦИЯ: Строим связи СРАЗУ при добавлении узла ===
			private _currentIdx = count _nodes;
			_pos params ["_px", "_py", "_pz"];
			private _gridX = floor(_px / _gridSize);
			private _gridY = floor(_py / _gridSize);
			
			// Проверяем связи с УЖЕ ДОБАВЛЕННЫМИ узлами в соседних ячейках
			private _neighborsToCheck = []; // кеш узлов для проверки

			{
				private _checkKey = str [_gridX + (_x select 0), _gridY + (_x select 1)];
				private _cellNodes = _spatialGrid getOrDefault [_checkKey, []];
				_neighborsToCheck append _cellNodes; // собираем все узлы в один массив
			} forEach _cellOffsets;

			// Теперь ОДИН forEach вместо вложенных
			_doExit = false;
			{
				//private _checkKey = str [_gridX + (_x select 0), _gridY + (_x select 1)];
				//private _cellNodes = _spatialGrid getOrDefault [_checkKey, []];
				
				//{
					_x params ["_neighborIdx", "_neighborNode"];
					
					private _dist = _pos distance _neighborNode;
					
					if (_dist <= _maxConnectionDist) then {
						private _deltaZ = abs((_pz) - (_neighborNode select 2));
						if (_deltaZ > 1) then {_doExit = true; continue};
						
						if !([_pos, _neighborNode, _dist, ai_nav_maxSlope] call ai_nav_checkSlopeFast) then {_doExit = true; continue};
						
						_queryPos pushBack [
							_pos vectoradd vec3(0,0,0.4),
							_neighborNode vectoradd vec3(0,0,0.4),
							objNull, objNull, true, 1, "VIEW", "GEOM"
						];
						
						_connectionData pushBack [_pos, _neighborNode, _dist];
					};
				//} forEach _cellNodes;
			} forEach _neighborsToCheck;
			//if (_doExit) then {continue};
			
			// Теперь добавляем узел в массив и spatial grid
			_nodes pushBack _pos;
			
			#ifdef AI_NAV_DEBUG_DRAW
				[_pos,[0,1,0],3,true] call ai_nav_debug_createObj;
			#endif
			
			// Добавляем узел в spatial grid для будущих проверок
			private _gridKey = str [_gridX, _gridY];
			if (!(_gridKey in _spatialGrid)) then {
				_spatialGrid set [_gridKey, []];
			};
			(_spatialGrid get _gridKey) pushBack [_currentIdx, _pos];
			
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

	private _edgesList = [];
	//_queryPos = [];	

	ai_debug_decl([
		"    Spatial grid: %1 cells, %2 nodes" arg 
		count _spatialGrid arg 
		count _nodes
	] call ai_debugLog;)
	
	ai_debug_decl([
		"    Checked pairs: %1 (total candidates: %2)" arg 
		count _connectionData arg
		(count _nodes * (count _nodes - 1) / 2)
	] call ai_debugLog;)
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
	
		#ifdef AI_USE_CACHE_SPATIAL_GRID
			// Сохраняем spatial grid для переиспользования
			private _regionData = ai_nav_regions get _regionKey;
			_regionData set ["spatialGrid", _spatialGrid];
		#endif
	};
	
	// Возвращаем ключ региона
	_regionKey
};

// Найти ближайший узел к позиции
ai_nav_findNearestNode_old = {
	params ["_pos", ["_maxDistance", 50]];
	
	private _regionKey = _pos call ai_nav_getRegionKey;
	private _regionData = ai_nav_regions get _regionKey;
	
	// Если регион не существует, ищем в ближайших регионах
	if (isNil "_regionData") exitWith {
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

ai_nav_internal_list_regionOffsets = [
	[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,1], [1,-1], [-1,-1]
];

//ускорение поиска узла 21.3x быстрее чем ai_nav_findNearestNode_old
ai_nav_findNearestNode = {
	params ["_pos", ["_maxDistance", 50]];
	
	private _regionKey = _pos call ai_nav_getRegionKey;
	private _regionData = ai_nav_regions get _regionKey;
	
	private _bestNode = -1;
	private _bestDist = 999999;
	
	// Если текущий регион существует - начинаем с него
	if (!isNil "_regionData") then {
		private _nodeIds = _regionData get "nodes";
		
		{
			private _nodeData = ai_nav_nodes get _x;
			private _nodePos = _nodeData get "pos";
			private _dist = _pos distance _nodePos;
			
			if (_dist < _bestDist && {_dist <= _maxDistance}) then {
				_bestDist = _dist;
				_bestNode = _x;
				if (_dist < 0.5) then {break};
			};
		} forEach _nodeIds;
		
	};
	// Если нашли близкий узел в текущем регионе - возвращаем
	if (_bestNode != -1 && {_bestDist < 0.5}) exitWith {_bestNode};
	
	// Ищем в соседних 8 регионах вместо перебора всех узлов
	_regionKey splitString "_" params ["_rx", "_ry"];
	_rx = parseNumber _rx;
	_ry = parseNumber _ry;
	private _regionOffsetList = ai_nav_internal_list_regionOffsets;
	private _doReturn = false;
	{
		private _neighborKey = format ["%1_%2", _rx + (_x select 0), _ry + (_x select 1)];
		private _neighborData = ai_nav_regions get _neighborKey;
			
		if (!isNil "_neighborData") then {
			private _nodeIds = _neighborData get "nodes";
			
			{
				private _nodeData = ai_nav_nodes get _x;
				private _nodePos = _nodeData get "pos";
				private _dist = _pos distance _nodePos;
				
				if (_dist < _bestDist && {_dist <= _maxDistance}) then {
					_bestDist = _dist;
					_bestNode = _x;
					if (_dist < 0.5) then {
						_doReturn = true;
						break;
					};
				};
			} forEach _nodeIds;
			if (_doReturn) exitWith {break};
		};
	} foreach _regionOffsetList;
	
	_bestNode
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

// Эвристическая функция с позицией вместо ID узла
ai_nav_heuristicPos = {
	params ["_nodeId", "_targetPos"];
	
	private _nodePos = (ai_nav_nodes get _nodeId) get "pos";
	(_nodePos distance _targetPos) * 1.3 //с агрессивным коэффициентом
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
	
	while {count _openSet > 0 && _iterations < _maxIterations} do {
		_iterations = _iterations + 1;
		
		// Найти узел с минимальным fScore (ОПТИМИЗИРОВАНО)
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
		
		// Достигли цели
		if (_current == _goalNodeId) exitWith {
			private _path = [_cameFrom, _current] call ai_nav_reconstructPath;
			RETURN(_path);
		};
		
		// Удаляем текущий из openSet и добавляем в closedSet
		_openSet deleteAt _minIdx; // ← Используем сохраненный индекс вместо поиска!
		_closedSet set [_current, true]; // ← Помечаем как посещенный
		
		// Проверяем соседей
		private _neighbors = [_current] call ai_nav_getNeighbors;
		
		{
			_x params ["_neighborId", "_cost"];
			
			// ← ПРОПУСКАЕМ УЖЕ ПОСЕЩЕННЫЕ УЗЛЫ!
			if (_neighborId in _closedSet) then {continue};
			
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
	};
	
	ai_debug_decl([
		"Path not found after %1 iterations (max: %2)" arg 
		_iterations arg 
		_maxIterations
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
	private _optimizedPath = if (_optimize) then {[_pathPositions] call ai_nav_smoothPath_aggressive} else {_pathPositions};
	
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

// Более агрессивное сглаживание для устранения "лесенок"
ai_nav_smoothPath_aggressive = {
    params ["_path"];
    
    if (count _path < 3) exitWith {_path};
    
    private _result = [_path select 0];
    
    for "_i" from 1 to (count _path - 2) do {
        private _prev = _path select (_i - 1);
        private _curr = _path select _i;
        private _next = _path select (_i + 1);
        
        private _v1 = _curr vectorDiff _prev;
        private _v2 = _next vectorDiff _curr;
        
        // Вычисляем угол между векторами
        private _len1 = vectorMagnitude _v1;
        private _len2 = vectorMagnitude _v2;
        
        if (_len1 > 0.1 && _len2 > 0.1) then {
            private _dot = (_v1 select 0) * (_v2 select 0) + 
                           (_v1 select 1) * (_v2 select 1) + 
                           (_v1 select 2) * (_v2 select 2);
            private _cosAngle = (_dot / (_len1 * _len2)) max -1 min 1;
            private _angle = acos _cosAngle;
            
            // Порог: сохраняем точку только если угол > 20 градусов
            // Это уберёт большинство "лесенок" (мелкие зигзаги)
            if (_angle > 20) then {
                _result pushBack _curr;
            };
        };
    };
    
    _result pushBack (_path select (count _path - 1));
    _result
};

//автогенерация через писк пути
// Добавить после ai_nav_findPath (после строки 625)
// Добавить новую функцию после ai_nav_findPath (после строки 625)

// Найти путь с автогенерацией регионов
ai_nav_findPath_autoGenerate = {
	params ["_startPos", "_endPos", ["_optimize", true], ["_maxRegionsToGenerate", 5], ["_pathWidth", 1]];
	
	ai_debug_decl(["Finding path (auto-generate) from %1 to %2 (width=%3)" arg _startPos arg _endPos arg _pathWidth] call ai_debugLog);
	ai_debug_decl(private _tTotal = tickTime;)
	
	// Находим стартовый узел
	private _startNode = [_startPos] call ai_nav_findNearestNode;
	
	if (_startNode == -1) then {
		// Генерируем новый регион со связями
		[_startPos] call ai_nav_updateRegion;
		_startNode = [_startPos] call ai_nav_findNearestNode;
	};
	
	// Проверяем конечный узел
	private _endNode = [_endPos] call ai_nav_findNearestNode;
	
	// Если конечный узел не найден - генерируем регионы на пути
	if (_endNode == -1) then {
		ai_debug_decl(["End node not found, generating regions on path..." ] call ai_debugLog);
		
		// Получаем ключи регионов от старта к концу
		private _startRegionKey = [_startPos select 0, _startPos select 1] call ai_nav_getRegionKey;
		private _endRegionKey = [_endPos select 0, _endPos select 1] call ai_nav_getRegionKey;
		
		// Если регионы совпадают - генерируем только конечный
		if (_startRegionKey == _endRegionKey) then {
			[_endPos] call ai_nav_updateRegion;
			ai_debug_decl(["Updated end region %1" arg _endRegionKey] call ai_debugLog);
		} else {
			// Генерируем регионы по линии от старта к концу с заданной шириной
			[_startPos, _endPos, _maxRegionsToGenerate, _pathWidth] call ai_nav_generateRegionsOnLine_withInit;
		};
		
		// Повторно ищем конечный узел
		_endNode = [_endPos] call ai_nav_findNearestNode;
		
		if (_endNode == -1) exitWith {
			ai_debug_decl(["Still no end node after generation" ] call ai_debugLog);
			[]
		};
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
	
	// Оптимизируем путь
	private _optimizedPath = if (_optimize) then {[_pathPositions] call ai_nav_smoothPath_fast} else {_pathPositions};
	
	ai_debug_decl(["Path found with auto-generation in %1ms" arg ((tickTime - _tTotal)*1000)toFixed 2] call ai_debugLog);
	
	_optimizedPath
};

// Генерация регионов вдоль линии С ИНИЦИАЛИЗАЦИЕЙ (включая entrance points)
// _pathWidth - количество регионов в стороны от центральной линии (по умолчанию 1)
ai_nav_generateRegionsOnLine_withInit = {
	params ["_startPos", "_endPos", "_maxRegions", ["_pathWidth", 1]];
	
	ai_debug_decl(private _tTotal = tickTime;)
	
	private _direction = _endPos vectorDiff _startPos;
	private _distance = vectorMagnitude _direction;
	private _dirNorm = vectorNormalized _direction;
	
	// Вычисляем перпендикулярное направление для ширины пути
	private _perpDir = [
		-(_dirNorm select 1),
		_dirNorm select 0,
		0
	];
	
	private _generatedCount = 0;
	
	// Шагаем вдоль линии с шагом размера региона
	private _stepSize = ai_nav_regionSize;
	private _steps = ceil(_distance / _stepSize) min _maxRegions;
	
	ai_debug_decl(["Generating regions with init: steps=%1, pathWidth=%2" arg _steps arg _pathWidth] call ai_debugLog);
	
	for "_i" from 0 to _steps do {
		private _centerPos = _startPos vectorAdd (_dirNorm vectorMultiply (_i * _stepSize));
		
		// Генерируем регионы в "коридоре" вокруг центральной линии
		// Если _pathWidth = 1, генерируем только центральный регион
		// Если _pathWidth = 2, генерируем центр + 1 регион в каждую сторону
		for "_w" from (-(_pathWidth - 1)) to (_pathWidth - 1) do {
			private _offsetPos = _centerPos vectorAdd (_perpDir vectorMultiply (_w * ai_nav_regionSize));
			
			// Обновляем регион (работает и для новых, и для существующих)
			[_offsetPos] call ai_nav_updateRegion;
			_generatedCount = _generatedCount + 1;
		};
	};
	
	ai_debug_decl(["Generated %1 regions in corridor in %2ms" arg _generatedCount arg ((tickTime - _tTotal)*1000)toFixed 2] call ai_debugLog);
	
	_generatedCount
};

// ============================================================================
// ЧАСТИЧНЫЙ ПУТЬ (Partial Path) - для динамической навигации AI
// ============================================================================

// Найти частичный путь к ближайшей доступной точке к целевой позиции
// Использует модифицированный A* с ранним выходом для оптимизации
ai_nav_findPartialPath = {
	params ["_startPos", "_endPos", ["_optimize", true],["_refPathNodes",null]];
	
	ai_debug_decl(["Finding partial path from %1 to %2" arg _startPos arg _endPos] call ai_debugLog);
	ai_debug_decl(private _tTotal = tickTime;)
	
	// Находим стартовый узел
	private _startNode = [_startPos] call ai_nav_findNearestNode;
	
	if (_startNode == -1) exitWith {
		ai_debug_decl(["No start node found near %1" arg _startPos] call ai_debugLog);
		[]
	};
	
	// Всегда используем модифицированный A* с ранним выходом
	// Он быстро находит прямой путь (если цель достижима)
	// Или находит ближайший узел (если цель недостижима)
	private _pathNodes = [_startNode, _endPos, 2] call ai_nav_findPathToClosestNode;
	
	if (count _pathNodes == 0) exitWith {
		ai_debug_decl(["No path found"] call ai_debugLog);
		[]
	};
	
	if !isNullVar(_refPathNodes) then {
		refset(_refPathNodes,_pathNodes);
	};
	
	
	// Конвертируем узлы в позиции
	private _pathPositions = [];
	{
		private _nodeData = ai_nav_nodes get _x;
		private _pos = _nodeData get "pos";
		_pathPositions pushBack _pos;
	} forEach _pathNodes;
	
	// Оптимизируем путь
	private _optimizedPath = if (_optimize) then {[_pathPositions] call ai_nav_smoothPath_fast} else {_pathPositions};
	
	// Проверяем, достигли ли мы реальной цели
	private _actualEnd = _pathPositions select (count _pathPositions - 1);
	private _distToTarget = _actualEnd distance _endPos;
	private _isPartial = _distToTarget > 5;
	
	ai_debug_decl([
		"Path found in %1ms: %2 waypoints, distance to target=%3m (partial=%4)" arg 
		((tickTime - _tTotal)*1000)toFixed 2 arg
		count _optimizedPath arg
		_distToTarget toFixed 2 arg
		_isPartial
	] call ai_debugLog);
	
	_optimizedPath
};

// Модифицированный A* - находит путь к ближайшему достижимому узлу к целевой позиции
// Вместо поиска конкретного узла, ищет среди всех достижимых узлов ближайший к позиции
// С оптимизацией раннего выхода для достижимых целей
// АДАПТИВНАЯ СТРАТЕГИЯ: линейный поиск для малых openSet, heap для больших
ai_nav_findPathToClosestNode = {
	params ["_startNodeId", "_targetPos", ["_earlyExitDistance", 2]];
	FHEADER;
	
	ai_debug_decl(private _tStart = tickTime;)
	
	// Инициализация
	private _openSet = []; // Будет использоваться как heap ИЛИ массив
	private _useHeap = false; // Флаг использования heap
	private _inOpenSet = createHashMap; // Для проверки наличия в openSet
	private _closedSet = createHashMap;
	private _cameFrom = createHashMap;
	
	private _gScore = createHashMap;
	_gScore set [_startNodeId, 0];
	
	private _fScore = createHashMap;
	private _startPos = (ai_nav_nodes get _startNodeId) get "pos";
	private _startF = [_startNodeId, _targetPos] call ai_nav_heuristicPos;
	_fScore set [_startNodeId, _startF];
	
	// Добавляем стартовый узел
	_openSet pushBack [_startNodeId, _startF];
	_inOpenSet set [_startNodeId, true];
	
	private _iterations = 0;
	private _maxIterations = 500; // Жесткий лимит
	
	// Отслеживание ближайшего узла к целевой позиции
	private _closestNode = _startNodeId;
	private _closestDist = _startPos distance _targetPos;
	
	ai_debug_decl(private _maxOpenSetSize = 0;)
	ai_debug_decl(private _earlyExit = false;)
	ai_debug_decl(private _minSearchTime = 0;)
	ai_debug_decl(private _neighborsTime = 0;)
	ai_debug_decl(private _totalNeighborsChecked = 0;)
	ai_debug_decl(private _heapUsed = 0;)
	ai_debug_decl(private _linearUsed = 0;)
	
	while {count _openSet > 0 && {_iterations < _maxIterations}} do { 
		_iterations = _iterations + 1;

		// Увеличить distance по мере роста итераций
		if (_iterations > 200 && _earlyExitDistance < 5) then {
			_earlyExitDistance = 5; // Более грубый путь для сложных случаев
		};

		if (_iterations > 400 && _earlyExitDistance < 10) then {
			_earlyExitDistance = 10; // Совсем грубый
		};
		
		ai_debug_decl(if (count _openSet > _maxOpenSetSize) then {_maxOpenSetSize = count _openSet};)
		
		ai_debug_decl(private _tMin = tickTime;)
		
		private _current = -1;
		private _minIdx = 0;
		
		// АДАПТИВНЫЙ ВЫБОР: heap для больших openSet (>25), линейный поиск для малых
		if (count _openSet > 25) then {
			// HEAP MODE: O(log n) извлечение
			ai_debug_decl(_heapUsed = _heapUsed + 1;)
			
			if (!_useHeap) then {
				// Первый раз переходим на heap - конвертируем массив в кучу
				_useHeap = true;
				// Простая heapify - вставляем все элементы заново
				private _tempSet = +_openSet;
				_openSet resize 0;
				{
					[_openSet, _x select 0, _x select 1] call ai_nav_heapInsert;
				} forEach _tempSet;
			};
			
			private _minNode = [_openSet] call ai_nav_heapExtractMin;
			_current = _minNode select 0;
			
		} else {
			// LINEAR MODE: O(n) но быстрее на малых массивах
			ai_debug_decl(_linearUsed = _linearUsed + 1;)
			
			// Линейный поиск минимума
			_minIdx = 0;
			private _minF = (_openSet select 0) select 1;
			
			for "_i" from 1 to (count _openSet - 1) do {
				private _f = (_openSet select _i) select 1;
				if (_f < _minF) then {
					_minF = _f;
					_minIdx = _i;
				};
			};
			
			_current = (_openSet select _minIdx) select 0;
			_openSet deleteAt _minIdx;
		};
		
		ai_debug_decl(_minSearchTime = _minSearchTime + (tickTime - _tMin);)
		
		// Удаляем из inOpenSet и добавляем в closedSet
		_inOpenSet deleteAt _current;
		_closedSet set [_current, true];
		
		// Обновляем ближайший узел к цели
		private _currentPos = (ai_nav_nodes get _current) get "pos";
		private _distToTarget = _currentPos distance _targetPos;
		
		if (_distToTarget < _closestDist) then {
			_closestDist = _distToTarget;
			_closestNode = _current;
			
			// ОПТИМИЗАЦИЯ: Ранний выход если нашли узел очень близко к цели
			if (_distToTarget <= _earlyExitDistance) then {
				ai_debug_decl(_earlyExit = true;)
				break;
			};
		};
		
		// Проверяем соседей - ОПТИМИЗИРОВАНО
		ai_debug_decl(private _tNeighbors = tickTime;)
		private _neighbors = ai_nav_adjacency getOrDefault [_current, []];
		
		{
			_x params ["_neighborId", "_cost"];
			
			if (_neighborId in _closedSet) then {continue};
			
			ai_debug_decl(_totalNeighborsChecked = _totalNeighborsChecked + 1;)
			
			private _tentativeGScore = (_gScore getOrDefault [_current, 999999]) + _cost;
			
			if (_tentativeGScore < (_gScore getOrDefault [_neighborId, 999999])) then {
				_cameFrom set [_neighborId, _current];
				_gScore set [_neighborId, _tentativeGScore];
				
				// Эвристика = расстояние до целевой позиции
				private _h = [_neighborId, _targetPos] call ai_nav_heuristicPos;
				private _newF = _tentativeGScore + _h;
				_fScore set [_neighborId, _newF];
				
				if (!(_neighborId in _inOpenSet)) then {
					if (_useHeap) then {
						[_openSet, _neighborId, _newF] call ai_nav_heapInsert;
					} else {
						_openSet pushBack [_neighborId, _newF];
					};
					_inOpenSet set [_neighborId, true];
				};
			};
		} forEach _neighbors;
		ai_debug_decl(_neighborsTime = _neighborsTime + (tickTime - _tNeighbors);)
	};
	
	// Восстанавливаем путь к ближайшему узлу
	private _path = [_cameFrom, _closestNode] call ai_nav_reconstructPath;
	
	ai_debug_decl([
		"=== PARTIAL PATH PROFILING ===%1Path: %2 nodes, %3 iters, closest=%4m, maxOpenSet=%5, earlyExit=%6%1MinSearch: %7ms (heap=%8, linear=%9) | Neighbors: %10ms (%11 checked) | TOTAL: %12ms" arg
		endl arg
		count _path arg
		_iterations arg
		(_closestDist toFixed 2) arg
		_maxOpenSetSize arg
		_earlyExit arg
		(_minSearchTime*1000)toFixed 2 arg
		_heapUsed arg
		_linearUsed arg
		(_neighborsTime*1000)toFixed 2 arg
		_totalNeighborsChecked arg
		((tickTime - _tStart)*1000)toFixed 2
	] call ai_debugLog);
	
	RETURN(_path);
};

// Найти ближайший узел в направлении целевой позиции
// ОПТИМИЗИРОВАНО: ищет только в регионах в направлении цели
ai_nav_findNearestNodeTowards = {
	params ["_startPos", "_targetPos", ["_maxSearchDistance", 100]];
	
	ai_debug_decl(private _tStart = tickTime;)
	
	private _direction = _targetPos vectorDiff _startPos;
	private _dirNorm = vectorNormalized _direction;
	private _targetDistance = (vectorMagnitude _direction) min _maxSearchDistance;
	
	// Собираем регионы в направлении цели (вдоль луча)
	private _regionsToCheck = [];
	private _stepSize = ai_nav_regionSize;
	private _steps = ceil(_targetDistance / _stepSize);
	
	ai_debug_decl(private _totalRegions = 0;)
	
	// Идем вдоль линии к цели и собираем регионы
	for "_i" from 0 to _steps do {
		private _checkPos = _startPos vectorAdd (_dirNorm vectorMultiply (_i * _stepSize));
		private _regionKey = [_checkPos select 0, _checkPos select 1] call ai_nav_getRegionKey;
		
		// Добавляем регион и его соседей (для расширения зоны поиска)
		if (_regionKey in ai_nav_regions) then {
			_regionsToCheck pushBackUnique _regionKey;
			ai_debug_decl(_totalRegions = _totalRegions + 1;)
			
			// Добавляем 4 прямых соседа для расширения зоны
			_regionKey splitString "_" params ["_rx", "_ry"];
			_rx = parseNumber _rx; _ry = parseNumber _ry;
			
			{
				_x params ["_dx", "_dy"];
				private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
				if (_neighborKey in ai_nav_regions) then {
					_regionsToCheck pushBackUnique _neighborKey;
				};
			} forEach [[0,1], [0,-1], [1,0], [-1,0]]; // Только прямые соседи
		};
	};
	
	ai_debug_decl(["Searching in %1 regions towards target" arg count _regionsToCheck] call ai_debugLog);
	
	// Если нет регионов в направлении - ищем в ближайших от старта
	if (count _regionsToCheck == 0) then {
		private _startRegionKey = [_startPos select 0, _startPos select 1] call ai_nav_getRegionKey;
		if (_startRegionKey in ai_nav_regions) then {
			_regionsToCheck pushBack _startRegionKey;
			
			// Добавляем всех 8 соседей
			_startRegionKey splitString "_" params ["_rx", "_ry"];
			_rx = parseNumber _rx; _ry = parseNumber _ry;
			{
				_x params ["_dx", "_dy"];
				private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
				if (_neighborKey in ai_nav_regions) then {
					_regionsToCheck pushBackUnique _neighborKey;
				};
			} forEach [[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,1], [1,-1], [-1,-1]];
		};
		ai_debug_decl(["No regions in direction, using %1 regions around start" arg count _regionsToCheck] call ai_debugLog);
	};
	
	private _bestNode = -1;
	private _bestScore = -999999;
	
	ai_debug_decl(private _checkedNodes = 0;)
	
	// Ищем только среди узлов выбранных регионов
	{
		private _regionKey = _x;
		private _regionData = ai_nav_regions get _regionKey;
		private _nodeIds = _regionData get "nodes";
		
		{
			private _nodeId = _x;
			private _nodeData = ai_nav_nodes get _nodeId;
			private _nodePos = _nodeData get "pos";
			
			ai_debug_decl(_checkedNodes = _checkedNodes + 1;)
			
			// Вектор от старта к узлу
			private _toNode = _nodePos vectorDiff _startPos;
			private _distToNode = vectorMagnitude _toNode;
			
			if (_distToNode > 0.1) then {
				private _toNodeNorm = vectorNormalized _toNode;
				
				// Скалярное произведение - насколько узел в направлении цели
				private _dotProduct = _dirNorm vectorDotProduct _toNodeNorm;
				
				// Только узлы в направлении цели (dot > 0.3 = угол < 72°)
				if (_dotProduct > 0.3) then {
					private _distanceToTarget = _nodePos distance _targetPos;
					
					// Формула оценки:
					// - Высокий приоритет узлам в направлении (+100 * dot)
					// - Штраф за расстояние от старта (-0.5 * dist)
					// - Бонус за близость к цели (-0.3 * distToTarget)
					private _score = (_dotProduct * 100) - (_distToNode * 0.5) - (_distanceToTarget * 0.3);
					
					if (_score > _bestScore) then {
						_bestScore = _score;
						_bestNode = _nodeId;
					};
				};
			};
		} forEach _nodeIds;
	} forEach _regionsToCheck;
	
	ai_debug_decl(private _tEnd = tickTime;)
	
	if (_bestNode != -1) then {
		private _bestNodeData = ai_nav_nodes get _bestNode;
		private _bestNodePos = _bestNodeData get "pos";
		ai_debug_decl([
			"Found best node: nodeId=%1, pos=%2, score=%3 | Checked %4 nodes in %5 regions in %6ms" arg 
			_bestNode arg 
			_bestNodePos arg 
			(_bestScore toFixed 2) arg
			_checkedNodes arg
			count _regionsToCheck arg
			((_tEnd - _tStart)*1000)toFixed 2
		] call ai_debugLog);
	} else {
		ai_debug_decl([
			"No suitable node found | Checked %1 nodes in %2 regions in %3ms" arg 
			_checkedNodes arg 
			count _regionsToCheck arg
			((_tEnd - _tStart)*1000)toFixed 2
		] call ai_debugLog);
	};
	
	_bestNode
};

