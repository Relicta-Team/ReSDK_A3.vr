// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Генерация ключа региона по позиции
ai_nav_getRegionKey = {
	params ["_x","_y"];
	private _rx = floor((_x ) / ai_nav_regionSize);
	private _ry = floor((_y) / ai_nav_regionSize);
	format ["%1_%2", _rx, _ry]
};

// Сохранение данных региона в глобальные структуры
ai_nav_saveRegion = {
	params ["_regionKey", "_nodes", "_edges"];
	
	// Создаем структуру данных региона
	private _regionData = createHashMap;
	_regionData set ["lastUpdate", tickTime];
	_regionData set ["nodes", []];      // Массив ID узлов
	_regionData set ["edges", _edges];  // Связи остаются как есть
	_regionData set ["entrances", createHashMap];  // Переходные точки (пока пустые)
	_regionData set ["mobs",[]]; // список мобов в регионе
	
	private _nodeIds = [];
	private _posToIdMap = createHashMap; // Временная карта для связывания позиций с ID
	
	// Создаем ID для каждого узла и сохраняем в глобальный справочник
	{
		private _nodeId = call ai_nav_generateNodeId;
		private _nodeData = createHashMap;
		_nodeData set ["pos", _x];
		_nodeData set ["region", _regionKey];
		_nodeData set ["neighbors", []]; // Соседние узлы будут добавлены позже
		
		ai_nav_nodes set [_nodeId, _nodeData];
		_nodeIds pushBack _nodeId;
		
		// Сохраняем маппинг позиции к ID
		_posToIdMap set [str _x, _nodeId];
		
	} forEach _nodes;
	
	_regionData set ["nodes", _nodeIds];
	
	// Сохраняем связи внутри региона в ai_nav_adjacency
	{
		_x params ["_pos1", "_pos2", "_cost"];
		
		private _nodeId1 = _posToIdMap get (str _pos1);
		private _nodeId2 = _posToIdMap get (str _pos2);
		
		// Двунаправленные связи
		if (!isNil "_nodeId1" && !isNil "_nodeId2") then {
			// Связь 1 -> 2
			if (!(_nodeId1 in ai_nav_adjacency)) then {
				ai_nav_adjacency set [_nodeId1, []];
			};
			private _adjList1 = ai_nav_adjacency get _nodeId1;
			_adjList1 pushBackUnique [_nodeId2, _cost];
			
			// Связь 2 -> 1
			if (!(_nodeId2 in ai_nav_adjacency)) then {
				ai_nav_adjacency set [_nodeId2, []];
			};
			private _adjList2 = ai_nav_adjacency get _nodeId2;
			_adjList2 pushBackUnique [_nodeId1, _cost];
		};
	} forEach _edges;
	
	// Сохраняем регион
	ai_nav_regions set [_regionKey, _regionData];
	
	ai_debug_decl(["Region %1 saved: %2 nodes, %3 edges" arg _regionKey arg count _nodeIds arg count _edges] call ai_debugLog);
	
	_regionKey
};

// Получение данных региона
ai_nav_getRegion = {
	params ["_regionKey"];
	ai_nav_regions getOrDefault [_regionKey, nil]
};

// Проверка существования региона
ai_nav_hasRegion = {
	params ["_pos"];
	private _key = _pos call ai_nav_getRegionKey;
	_key in ai_nav_regions
};

ai_nav_regionToPos = {
	params ["_regionKey"];
	_regionKey splitString "_" params ["_rx", "_ry"];
	_rx = parseNumber _rx; _ry = parseNumber _ry;
	[
		_rx * ai_nav_regionSize + ai_nav_regionSize/2, 
		_ry * ai_nav_regionSize + ai_nav_regionSize/2, 
		0
	]
};

// Получить узлы в текущем и соседних регионах
// Используется для оптимизированного поиска ближайших узлов
ai_nav_getNodesInRegionArea = {
	params ["_pos", ["_includeNeighbors", true]];
	
	private _regionKey = [_pos select 0, _pos select 1] call ai_nav_getRegionKey;
	private _regionsToCheck = [_regionKey];
	
	// Добавляем соседние регионы (8 направлений)
	if (_includeNeighbors) then {
		_regionKey splitString "_" params ["_rx", "_ry"];
		_rx = parseNumber _rx; _ry = parseNumber _ry;
		{
			_x params ["_dx", "_dy"];
			private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
			if (_neighborKey in ai_nav_regions) then {
				_regionsToCheck pushBack _neighborKey;
			};
		} forEach [[0,1], [0,-1], [1,0], [-1,0], [1,1], [-1,1], [1,-1], [-1,-1]];
	};
	
	// Собираем все узлы из выбранных регионов
	private _allNodes = [];
	{
		private _regionData = ai_nav_regions get _x;
		if (!isNil "_regionData") then {
			private _nodeIds = _regionData get "nodes";
			_allNodes append _nodeIds;
		};
	} forEach _regionsToCheck;
	
	_allNodes
};

// Генерация сетки регионов в радиусе от центральной точки
ai_nav_generateRegions = {
	params ["_centerPos", "_radius"];
	
	ai_debug_decl(private _tTotal = tickTime;)
	
	private _regionRadius = ceil(_radius / ai_nav_regionSize);
	private _centerRegionX = floor((_centerPos select 0) / ai_nav_regionSize);
	private _centerRegionY = floor((_centerPos select 1) / ai_nav_regionSize);
	
	private _generatedRegions = [];
	private _skippedRegions = 0;
	
	for "_rx" from (_centerRegionX - _regionRadius) to (_centerRegionX + _regionRadius) do {
		for "_ry" from (_centerRegionY - _regionRadius) to (_centerRegionY + _regionRadius) do {
			private _regionPos = [
				_rx * ai_nav_regionSize + ai_nav_regionSize/2,
				_ry * ai_nav_regionSize + ai_nav_regionSize/2,
				_centerPos select 2
			];
			
			// Проверяем расстояние от центра (генерируем только в радиусе)
			if ((_regionPos distance2D _centerPos) <= _radius) then {
				private _regionKey = [_regionPos] call ai_nav_generateRegionNodes;
				
				// Если регион успешно сгенерирован (не был пустым)
				if (!isNil "_regionKey" && {_regionKey in ai_nav_regions}) then {
					_generatedRegions pushBack _regionKey;
				} else {
					_skippedRegions = _skippedRegions + 1;
				};
			};
		};
	};
	
	// ai_debug_decl([
	// 	"Generated %1 regions in %2ms (skipped %3 empty regions)" arg 
	// 	count _generatedRegions arg 
	// 	((tickTime - _tTotal)*1000)toFixed 2 arg 
	// 	_skippedRegions
	// ] call ai_debugLog);
	
	_generatedRegions
};

// Очистка всех регионов
ai_nav_clearAllRegions = {
	ai_nav_regions = createHashMap;
	ai_nav_nodes = createHashMap;
	ai_nav_adjacency = createHashMap;
	ai_nav_nodeIdCounter = 0;
	
	// Очищаем визуализацию
	call ai_nav_clearDebugObjects;
	
	ai_debug_decl(["All regions cleared"] call ai_debugLog);
};
