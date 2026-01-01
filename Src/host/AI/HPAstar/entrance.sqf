// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


// Найти переходные точки для всех регионов
ai_nav_buildEntrancePoints = {
	ai_debug_decl(private _tTotal = tickTime;)
	
	private _totalEntrances = 0;
	
	// Для каждого региона ищем переходные точки
	{
		private _regionKey = _x;
		private _entrances = [_regionKey] call ai_nav_findEntrancePoints;
		_totalEntrances = _totalEntrances + count _entrances;
	} forEach (keys ai_nav_regions);
	
	ai_debug_decl([
		"Built entrance points: %1 total entrances in %2ms" arg 
		_totalEntrances arg 
		((tickTime - _tTotal)*1000)toFixed 2
	] call ai_debugLog);
	
	_totalEntrances
};

// Найти переходные точки для конкретного региона (ОПТИМИЗИРОВАНО)
ai_nav_findEntrancePoints = {
	params ["_regionKey"];
	
	private _regionData = ai_nav_regions get _regionKey;
	if (isNil "_regionData") exitWith {
		ai_debug_decl(["Region %1 not found" arg _regionKey] call ai_debugLog);
		[]
	};
	
	private _nodeIds = _regionData get "nodes";
	private _entrances = createHashMap;
	
	_regionKey splitString "_" params ["_rx", "_ry"];
	_rx = parseNumber _rx;
	_ry = parseNumber _ry;
	
	// Границы текущего региона
	private _regionMinX = _rx * ai_nav_regionSize;
	private _regionMaxX = _regionMinX + ai_nav_regionSize;
	private _regionMinY = _ry * ai_nav_regionSize;
	private _regionMaxY = _regionMinY + ai_nav_regionSize;
	private _borderThreshold = ai_nav_gridStep * 1.5; // Толщина границы
	
	// ОПТИМИЗАЦИЯ: Фильтруем только граничные узлы
	private _borderNodes = [];
	{
		private _nodeData = ai_nav_nodes get _x;
		private _pos = _nodeData get "pos";
		_pos params ["_px", "_py"];
		
		// Узел на границе, если близок к краю региона
		if (
			abs(_px - _regionMinX) < _borderThreshold ||
			abs(_px - _regionMaxX) < _borderThreshold ||
			abs(_py - _regionMinY) < _borderThreshold ||
			abs(_py - _regionMaxY) < _borderThreshold
		) then {
			_borderNodes pushBack [_forEachIndex, _pos];
		};
	} forEach _nodeIds;
	
	ai_debug_decl(["Region %1: %2 border nodes of %3 total" arg _regionKey arg count _borderNodes arg count _nodeIds] call ai_debugLog);
	
	// 8 направлений соседних регионов
	private _neighborOffsets = [
		[0, 1],   // North
		[0, -1],  // South
		[1, 0],   // East
		[-1, 0],  // West
		[1, 1],   // NorthEast
		[-1, 1],  // NorthWest
		[1, -1],  // SouthEast
		[-1, -1]  // SouthWest
	];
	
	// Для каждого соседнего региона
	{
		_x params ["_dx", "_dy"];
		private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
		
		if (_neighborKey in ai_nav_regions) then {
			private _neighborData = ai_nav_regions get _neighborKey;
			private _neighborNodeIds = _neighborData get "nodes";
			
			// Границы соседнего региона
			private _nMinX = (_rx + _dx) * ai_nav_regionSize;
			private _nMaxX = _nMinX + ai_nav_regionSize;
			private _nMinY = (_ry + _dy) * ai_nav_regionSize;
			private _nMaxY = _nMinY + ai_nav_regionSize;
			
			// ОПТИМИЗАЦИЯ: Фильтруем граничные узлы соседа на стороне текущего региона
			private _neighborBorderNodes = [];
			{
				private _nData = ai_nav_nodes get _x;
				private _nPos = _nData get "pos";
				_nPos params ["_nx", "_ny"];
				
				// Проверяем только узлы на стороне, обращенной к текущему региону
				private _isRelevantBorder = false;
				
				if (_dx == 1) then {
					// East neighbor - проверяем западную границу соседа
					_isRelevantBorder = abs(_nx - _nMinX) < _borderThreshold;
				};
				if (_dx == -1) then {
					// West neighbor - проверяем восточную границу соседа
					_isRelevantBorder = abs(_nx - _nMaxX) < _borderThreshold;
				};
				if (_dy == 1) then {
					// North neighbor - проверяем южную границу соседа
					_isRelevantBorder = _isRelevantBorder || abs(_ny - _nMinY) < _borderThreshold;
				};
				if (_dy == -1) then {
					// South neighbor - проверяем северную границу соседа
					_isRelevantBorder = _isRelevantBorder || abs(_ny - _nMaxY) < _borderThreshold;
				};
				
				if (_isRelevantBorder) then {
					_neighborBorderNodes pushBack [_x, _nPos];
				};
			} forEach _neighborNodeIds;
			
			// Проверяем связи только между граничными узлами
			{
				_x params ["_idx", "_nodePos"];
				private _nodeId = _nodeIds select _idx;
				
				{
					_x params ["_neighborNodeId", "_neighborPos"];
					private _dist = _nodePos distance _neighborPos;
					
					if (_dist <= (ai_nav_gridStep * 2)) then {
						private _needRaycast = true;
						private _canConnect = true;
						if (_needRaycast) then {
							private _intersections = lineIntersectsSurfaces [
								asltoatl (_nodePos vectoradd vec3(0,0,0.4)),
								asltoatl (_neighborPos vectoradd vec3(0,0,0.4)),
								objNull, objNull, true, 1, "VIEW", "GEOM"
							];
							_canConnect = count _intersections == 0;
						};
						
						if (_canConnect) then {
							if (!(_neighborKey in _entrances)) then {
								_entrances set [_neighborKey, []];
							};
							
							private _entranceList = _entrances get _neighborKey;
							if (!(_nodeId in _entranceList)) then {
								_entranceList pushBack _nodeId;
								
								// Сохраняем связь в adjacency
								if (!(_nodeId in ai_nav_adjacency)) then {
									ai_nav_adjacency set [_nodeId, []];
								};
								(ai_nav_adjacency get _nodeId) pushBackUnique [_neighborNodeId, _dist];
								
								#ifdef AI_NAV_DEBUG_DRAW
								// Визуализация переходной точки
								private _loopEntrance = struct_newp(LoopedObjectFunction,
									ai_nav_debug_drawNode arg [
										asltoatl _nodePos vectoradd vec3(0,0,0.2) arg 
										asltoatl _neighborPos vectoradd vec3(0,0,0.2) arg 
										[1 arg 0 arg 0 arg 1] arg 
										25
									] arg 
									null arg 
									ai_debug_objs select 0
								);
								ai_debug_loopDrawObjs pushback _loopEntrance;
								#endif
							};
						};
					};
				} forEach _neighborBorderNodes;
			} forEach _borderNodes;
		};
	} forEach _neighborOffsets;
	
	// Сохраняем переходные точки в регион
	_regionData set ["entrances", _entrances];
	
	ai_debug_decl([
		"Region %1: found %2 entrance connections" arg 
		_regionKey arg 
		count (keys _entrances)
	] call ai_debugLog);
	
	_entrances
};
