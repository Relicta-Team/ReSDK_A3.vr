// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// ============================================================================
// Обновление региона
// ============================================================================
ai_nav_updateRegion = {
    params ["_pos"];
    
    private _regionKey = [_pos select 0, _pos select 1] call ai_nav_getRegionKey;
    
    ai_debug_decl(["Updating region %1" arg _regionKey] call ai_debugLog; private _tupd = tickTime;)
    
    // 1. Удаляем старые данные (если регион существует)
    private _mobs = [_regionKey] call ai_nav_invalidateRegion;
    private _restoreActors = [];
    if !isNullVar(_mobs) then {
        private _actor = objNull;
        {
            _actor = toActor(_x);
            if (!(isobjecthidden _actor)) then {
                _restoreActors pushBack _actor;
                _actor hideObject true;
            }
        } foreach _mobs;
    } else {
        _mobs = [];//если регион не существует, то мобов нет
    };
    
    // 2. Генерируем узлы и внутренние связи заново
    [_pos] call ai_nav_generateRegionNodes;
    
    // 3. Обновляем entrance points (текущего региона + соседей)
    [_regionKey] call ai_nav_updateRegionEntrances_fast;

    //4. восстанавливаем мобов в регионе
    ai_nav_regions get _regionKey set ["mobs",_mobs];
    {_x hideObject false} foreach _restoreActors;
    
    ai_debug_decl(["Region %1 updated at %2ms" arg _regionKey arg ((tickTime - _tupd)*1000)toFixed 2] call ai_debugLog;)
    
    _regionKey
};

ai_nav_createRegionIfNeed = {
    params ["_pos"];
    private _regionKey = [_pos select 0, _pos select 1] call ai_nav_getRegionKey;
    private _regionData = ai_nav_regions get _regionKey;
    if (isNullVar(_regionData)) then {
        [_pos] call ai_nav_updateRegion;
    } else {
        ""
    };
};

ai_nav_requestUpdateRegion = {nextFrameParams(ai_nav_requestUpdateRegion_internal,_this)};
ai_nav_requestUpdateRegion_internal = {
    params ["_pos"];
    private _regionKey = [_pos select 0, _pos select 1] call ai_nav_getRegionKey;
    ["request update region at %1",_regionKey] call ai_log;
    if (_regionKey in ai_regionsUpdateMap) then {
        private _iOld = ai_regionsUpdateMap get _regionKey;
        
        //регион уже в конце очереди
        if (_iOld == (count ai_regionsUpdateQueue - 1)) exitWith {};

        //здесь муваем регион в конец очереди во избежании задержек обновлений
        ai_regionsUpdateQueue deleteAt _iOld;
        private _iNew = ai_regionsUpdateQueue pushBack _regionKey;
        ai_regionsUpdateMap set [_regionKey, _iNew];
    } else {
        private _i = ai_regionsUpdateQueue pushBack _regionKey;
        ai_regionsUpdateMap set [_regionKey, _i];
    };
};

ai_nav_invalidateRegion = {
    params ["_regionKey"];
    
    private _regionData = ai_nav_regions get _regionKey;
    if (isNil "_regionData") exitWith {null};
    
    private _oldMobs = _regionData get "mobs";
    private _oldNodeIds = _regionData get "nodes";
    private _entrances = _regionData get "entrances";
    
    // ИСПРАВЛЕНИЕ: Удаляем межрегиональные связи ПЕРЕД удалением региона
    // Проходим по всем соседним регионам, с которыми были entrance points
    //TODO remove this block
    {
        private _neighborKey = _x;
        private _neighborData = ai_nav_regions get _neighborKey;
        
        if (!isNil "_neighborData") then {
            private _neighborEntrances = _neighborData get "entrances";
            private _neighborEntrancesToUs = _neighborEntrances getOrDefault [_regionKey, []];
            
            // Удаляем связи из adjacency соседних узлов, которые ведут к нашим узлам
            private _ourNodeSet = createHashMapFromArray (_oldNodeIds apply {[_x, true]});
            
            {
                private _neighborNodeId = _x;
                if (_neighborNodeId in ai_nav_adjacency) then {
                    private _adjList = ai_nav_adjacency get _neighborNodeId;
                    // Удаляем связи с нашими узлами
                    _adjList = _adjList select {!((_x select 0) in _ourNodeSet)};
                    ai_nav_adjacency set [_neighborNodeId, _adjList];
                };
            } forEach _neighborEntrancesToUs;
            
            // Удаляем entrance points соседа на нас
            _neighborEntrances deleteAt _regionKey;
        };
    } forEach (keys _entrances);
    //endremove this block
    
    // Удаляем старые узлы из глобального справочника
    {
        ai_nav_nodes deleteAt _x;
        
        // Удаляем связи этого узла
        ai_nav_adjacency deleteAt _x;
        true;
    } count _oldNodeIds;
    
    // Удаляем регион
    ai_nav_regions deleteAt _regionKey;
    
    //возвращаем мобов в регионе
    _oldMobs
};

ai_nav_updateRegionEntrances = {
    params ["_regionKey"];
    
    // Пересоздаем entrance points текущего региона
    [_regionKey] call ai_nav_findEntrancePoints;
    
    // Обновляем entrance points 8 соседних регионов!
    _regionKey splitString "_" params ["_rx", "_ry"];
    _rx = parseNumber _rx;
    _ry = parseNumber _ry;
    
    private _neighborOffsets = [
        [0, 1], [0, -1], [1, 0], [-1, 0],
        [1, 1], [-1, 1], [1, -1], [-1, -1]
    ];
    
    {
        _x params ["_dx", "_dy"];
        private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
        
        if (_neighborKey in ai_nav_regions) then {
            // Очищаем старые entrance points соседа
            private _neighborData = ai_nav_regions get _neighborKey;
            _neighborData set ["entrances", createHashMap];
            
            // Пересоздаем entrance points соседа
            [_neighborKey] call ai_nav_findEntrancePoints;
        };
    } forEach _neighborOffsets;
};

ai_nav_updateRegionEntrances_fast = {
    params ["_regionKey"];
    
    ai_debug_decl(private _tStart = tickTime;)
    ai_debug_decl(["=== UPDATING REGION %1 ENTRANCES ===" arg _regionKey] call ai_debugLog;)
    
    _regionKey splitString "_" params ["_rx", "_ry"];
    _rx = parseNumber _rx; _ry = parseNumber _ry;
    
    private _neighborOffsets = [
        [0, 1], [0, -1], [1, 0], [-1, 0],
        [1, 1], [-1, 1], [1, -1], [-1, -1]
    ];
    
    ai_debug_decl(private _updatedCount = 0;)
    
    // Обновляем только связи с каждым соседом (16 операций вместо 72!)
    {
        _x params ["_dx", "_dy"];
        private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
        
        if (_neighborKey in ai_nav_regions) then {
            [_regionKey, _neighborKey] call ai_nav_updateEntrancesBetween;
            ai_debug_decl(_updatedCount = _updatedCount + 1;)
        };
    } forEach _neighborOffsets;
    
    ai_debug_decl(private _tEnd = tickTime;)
    ai_debug_decl([
        "=== REGION %1 UPDATE COMPLETE: %2 neighbors updated in %3ms ===" arg 
        _regionKey arg 
        _updatedCount arg 
        ((_tEnd-_tStart)*1000)toFixed 2
    ] call ai_debugLog;)
};

// Обновить entrance points между двумя конкретными регионами (С ПРОФИЛИРОВАНИЕМ)
ai_nav_updateEntrancesBetween = {
    params ["_regionKey1", "_regionKey2"];
    
    ai_debug_decl(private _tStart = tickTime;)
    
    // Удаляем старые связи между этими регионами
    private _region1Data = ai_nav_regions get _regionKey1;
    private _region2Data = ai_nav_regions get _regionKey2;
    
    if (isNil "_region1Data" || isNil "_region2Data") exitWith {};
    
    private _entrances1 = _region1Data get "entrances";
    private _entrances2 = _region2Data get "entrances";
    
    ai_debug_decl(private _t1 = tickTime;)
    
    // Удаляем старые entrance points друг на друга
    private _oldEntrances1 = _entrances1 getOrDefault [_regionKey2, []];
    private _oldEntrances2 = _entrances2 getOrDefault [_regionKey1, []];
    
    ai_debug_decl(private _t2 = tickTime;)
    
    // Удаляем старые связи из adjacency (ОПТИМИЗИРОВАНО O(n) вместо O(n²))
    // Создаем HashSet узлов второго региона для быстрой проверки
    private _node2IdsSet = createHashMapFromArray (
        (_region2Data get "nodes") apply {[_x, true]}
    );
    
    {
        private _nodeId = _x;
        if (_nodeId in ai_nav_adjacency) then {
            private _adjList = ai_nav_adjacency get _nodeId;
            // Удаляем связи с узлами второго региона (один проход!)
            _adjList = _adjList select {!((_x select 0) in _node2IdsSet)};
            ai_nav_adjacency set [_nodeId, _adjList];
        };
    } forEach _oldEntrances1;
    
    ai_debug_decl(private _t3 = tickTime;)
    
    // То же для второго региона (ОПТИМИЗИРОВАНО)
    // Создаем HashSet узлов первого региона для быстрой проверки
    private _node1IdsSet = createHashMapFromArray (
        (_region1Data get "nodes") apply {[_x, true]}
    );
    
    {
        private _nodeId = _x;
        if (_nodeId in ai_nav_adjacency) then {
            private _adjList = ai_nav_adjacency get _nodeId;
            // Удаляем связи с узлами первого региона (один проход!)
            _adjList = _adjList select {!((_x select 0) in _node1IdsSet)};
            ai_nav_adjacency set [_nodeId, _adjList];
        };
    } forEach _oldEntrances2;
    
    ai_debug_decl(private _t4 = tickTime;)
    
    // Очищаем старые entrances
    _entrances1 deleteAt _regionKey2;
    _entrances2 deleteAt _regionKey1;
    
    ai_debug_decl(private _t5 = tickTime;)
    
    // Пересоздаем связи между ТОЛЬКО этими двумя регионами
    [_regionKey1, _regionKey2] call ai_nav_buildEntrancesBetween;
    
    ai_debug_decl(private _t6 = tickTime;)
    
    ai_debug_decl([
        "updateEntrancesBetween %1↔%2: init=%3ms, get=%4ms, del1=%5ms, del2=%6ms, clear=%7ms, build=%8ms | TOTAL=%9ms" arg 
        _regionKey1 arg _regionKey2 arg
        ((_t1-_tStart)*1000)toFixed 2 arg 
        ((_t2-_t1)*1000)toFixed 2 arg 
        ((_t3-_t2)*1000)toFixed 2 arg 
        ((_t4-_t3)*1000)toFixed 2 arg 
        ((_t5-_t4)*1000)toFixed 2 arg 
        ((_t6-_t5)*1000)toFixed 2 arg
        ((_t6-_tStart)*1000)toFixed 2
    ] call ai_debugLog);
};

// Построить entrance points между двумя конкретными регионами (С ПРОФИЛИРОВАНИЕМ)
ai_nav_buildEntrancesBetween = {
    params ["_regionKey1", "_regionKey2"];
    
    ai_debug_decl(private _tStart = tickTime;)
    
    private _region1Data = ai_nav_regions get _regionKey1;
    private _region2Data = ai_nav_regions get _regionKey2;
    
    if (isNil "_region1Data" || isNil "_region2Data") exitWith {};
    
    _regionKey1 splitString "_" params ["_rx1", "_ry1"];
    _regionKey2 splitString "_" params ["_rx2", "_ry2"];
    _rx1 = parseNumber _rx1; _ry1 = parseNumber _ry1;
    _rx2 = parseNumber _rx2; _ry2 = parseNumber _ry2;
    
    // Вычисляем направление (_dx, _dy)
    private _dx = _rx2 - _rx1;
    private _dy = _ry2 - _ry1;
    
    ai_debug_decl(private _t1 = tickTime;)
    
    // Строим граничные узлы только для этой конкретной границы
    private _border1 = [_regionKey1, _dx, _dy] call ai_nav_getBorderNodes;
    private _border2 = [_regionKey2, -_dx, -_dy] call ai_nav_getBorderNodes;
    
    ai_debug_decl(private _t2 = tickTime;)
    
    private _entrances1 = _region1Data get "entrances";
    private _entrances2 = _region2Data get "entrances";
    
    ai_debug_decl(private _raycastCount = 0;)
    ai_debug_decl(private _raycastTime = 0;)
    ai_debug_decl(private _connectionsMade = 0;)
    ai_debug_decl(private _distChecks = 0;)
    
    // ОПТИМИЗАЦИЯ: Spatial partitioning для избежания O(n²) перебора
    private _maxDist = ai_nav_gridStep * 2;
    private _gridSize = _maxDist;
    
    #ifndef AI_USE_CACHE_SPATIAL_GRID
        private _spatialGrid = createHashMap;
    #else
        // Пытаемся использовать готовый spatial grid из региона 2
        private _spatialGrid = _region2Data getOrDefault ["spatialGrid", createHashMap];
        private _gridWasReused = (count _spatialGrid > 0);
    #endif

    ai_debug_decl(private _tGrid = tickTime;)

    #ifndef AI_USE_CACHE_SPATIAL_GRID
        // Строим пространственную сетку для border2
        {
            _x params ["_idx2", "_pos2"];
            _pos2 params ["_px", "_py"];
            
            // Вычисляем ключ ячейки сетки
            private _gridX = floor(_px / _gridSize);
            private _gridY = floor(_py / _gridSize);
            private _gridKey = str [_gridX, _gridY];
            
            if (!(_gridKey in _spatialGrid)) then {
                _spatialGrid set [_gridKey, []];
            };
            (_spatialGrid get _gridKey) pushBack [_idx2, _pos2];
        } forEach _border2;
    #else
        // Если grid пустой или его нет - строим заново (только для border2!)
        if !(_gridWasReused) then {
            // Строим ПОЛНЫЙ spatial grid для региона 2
            private _allNodes2 = _region2Data get "nodes";
            {
                private _nodeId = _x;
                private _nodeData = ai_nav_nodes get _nodeId;
                private _pos2 = _nodeData get "pos";
                _pos2 params ["_px", "_py"];
                
                private _gridX = floor(_px / _gridSize);
                private _gridY = floor(_py / _gridSize);
                private _gridKey = str [_gridX, _gridY];
                
                if (!(_gridKey in _spatialGrid)) then {
                    _spatialGrid set [_gridKey, []];
                };
                (_spatialGrid get _gridKey) pushBack [_forEachIndex, _pos2];
            } forEach _allNodes2;
        } else {
            // Grid переиспользован - нужно пересчитать индексы для border2
            // (т.к. в сохранённом grid индексы относятся ко всем узлам региона)
        };
    #endif
    
    ai_debug_decl(private _tGridEnd = tickTime;)
    
    private _query = [];
    private _queryData = [];

    #ifdef AI_USE_CACHE_SPATIAL_GRID
        // Если grid переиспользован - фильтруем только border узлы из полного grid
        private _border2Map = createHashMap;
        if (_gridWasReused) then {
            // Создаём быстрый lookup для border узлов
            {
                _x params ["_idx2", "_pos2"];
                _border2Map set [_idx2, _pos2];
            } forEach _border2;
        };
    #endif

    private _cellOffsets = [
        [-1,-1],[-1,0],[-1,1],
		[0,-1], [0,0], [0,1],
		[1,-1], [1,0], [1,1]
    ];

    // Проверяем связи только между близкими узлами (spatial partitioning)
    {
        _x params ["_idx1", "_pos1"];
        private _nodeId1 = (_region1Data get "nodes") select _idx1;
        _pos1 params ["_px", "_py"];
        
        private _gridX = floor(_px / _gridSize);
        private _gridY = floor(_py / _gridSize);
        
        // Проверяем только 9 соседних ячеек (3×3 grid)
        {
        //for "_dgx" from -1 to 1 do {
            //for "_dgy" from -1 to 1 do {
                _x params ["_dgx", "_dgy"];
                private _checkKey = str [_gridX + _dgx, _gridY + _dgy];
                private _nearbyNodes = _spatialGrid getOrDefault [_checkKey, []];
                
                // Проверяем только узлы в этой ячейке
                {
                    _x params ["_idx2", "_pos2"];
                    
                    #ifdef AI_USE_CACHE_SPATIAL_GRID
                        // Если grid переиспользован - проверяем что узел в border2
                        if (_gridWasReused && {!(_idx2 in _border2Map)}) then {continue};
                    #endif

                    private _nodeId2 = (_region2Data get "nodes") select _idx2;
                    
                    ai_debug_decl(_distChecks = _distChecks + 1;)
                    private _dist = _pos1 distance _pos2;
                    
                    if (_dist <= _maxDist) then {
                        ai_debug_decl(private _tRaycast = tickTime;)
                        // private _intersections = lineIntersectsSurfaces [
                        //     _pos1 vectoradd vec3(0,0,0.4),
                        //     _pos2 vectoradd vec3(0,0,0.4),
                        //     objNull, objNull, true, 1, "VIEW", "GEOM"
                        // ];
                        _query pushback [
                            (_pos1 vectoradd vec3(0,0,0.4)),
                            (_pos2 vectoradd vec3(0,0,0.4)),
                            objNull, objNull, true, 1, "VIEW", "GEOM"
                        ];
                        _queryData pushback [
                            _nodeId1,_nodeId2,_dist
                        ];

                        ai_debug_decl(_raycastCount = _raycastCount + 1;)
                        ai_debug_decl(_raycastTime = _raycastTime + (tickTime - _tRaycast);)
                    };
                } forEach _nearbyNodes;
            //};
        //};
        } forEach _cellOffsets;
    } forEach _border1;
    private _r = lineIntersectsSurfaces [_query];
    {
        if (count _x == 0) then {

            (_queryData select _forEachIndex) params ["_nodeId1","_nodeId2","_dist"];
           
            ai_debug_decl(_connectionsMade = _connectionsMade + 1;)

            // Создаем связь
            if (!(_regionKey2 in _entrances1)) then {
                _entrances1 set [_regionKey2, []];
            };
            (_entrances1 get _regionKey2) pushBackUnique _nodeId1;

            if (!(_regionKey1 in _entrances2)) then {
                _entrances2 set [_regionKey1, []];
            };
            (_entrances2 get _regionKey1) pushBackUnique _nodeId2;

            // Adjacency
            if (!(_nodeId1 in ai_nav_adjacency)) then {
                ai_nav_adjacency set [_nodeId1, []];
            };
            (ai_nav_adjacency get _nodeId1) pushBackUnique [_nodeId2, _dist];

            if (!(_nodeId2 in ai_nav_adjacency)) then {
                ai_nav_adjacency set [_nodeId2, []];
            };
            (ai_nav_adjacency get _nodeId2) pushBackUnique [_nodeId1, _dist];

            #ifdef AI_NAV_DEBUG_DRAW
                private _pos1 = ai_nav_nodes get _nodeId1 get "pos";
                private _pos2 = ai_nav_nodes get _nodeId2 get "pos";
                // Визуализация переходной точки
                private _loopEntrance = struct_newp(LoopedObjectFunction,
                    ai_nav_debug_drawNode arg [
                        asltoatl _pos1 vectoradd vec3(0,0,0) arg 
                        asltoatl _pos2 vectoradd vec3(0,0,0) arg 
                        [1 arg 0 arg 0 arg 1] arg 
                        25*2
                    ] arg 
                    null arg 
                    ai_debug_objs select 0
                );
                ai_debug_loopDrawObjs pushback _loopEntrance;
            #endif

        };
    } foreach _r;
    
    ai_debug_decl(private _t3 = tickTime;)
    
    ai_debug_decl([
        "  buildEntrancesBetween: init=%1ms, borders=%2ms (b1=%3 b2=%4), grid=%5ms, checks=%6ms [distChecks=%7 vs naive=%8, raycasts=%9 avgRaycastAddtask=%10ms] connections=%11 | TOTAL=%12ms" arg 
        ((_t1-_tStart)*1000)toFixed 2 arg 
        ((_t2-_t1)*1000)toFixed 2 arg 
        count _border1 arg count _border2 arg
        ((_tGridEnd-_tGrid)*1000)toFixed 2 arg
        ((_t3-_tGridEnd)*1000)toFixed 2 arg
        _distChecks arg
        (count _border1 * count _border2) arg
        _raycastCount arg
        (if (_raycastCount > 0) then {(_raycastTime / _raycastCount * 1000)toFixed 3} else {"N/A"}) arg
        _connectionsMade arg
        ((_t3-_tStart)*1000)toFixed 2
    ] call ai_debugLog);
};

// Получить граничные узлы региона в конкретном направлении
ai_nav_getBorderNodes = {
    params ["_regionKey", "_dx", "_dy"];
    
    private _regionData = ai_nav_regions get _regionKey;
    if (isNil "_regionData") exitWith {[]};
    
    _regionKey splitString "_" params ["_rx", "_ry"];
    _rx = parseNumber _rx; _ry = parseNumber _ry;
    
    private _regionMinX = _rx * ai_nav_regionSize;
    private _regionMaxX = _regionMinX + ai_nav_regionSize;
    private _regionMinY = _ry * ai_nav_regionSize;
    private _regionMaxY = _regionMinY + ai_nav_regionSize;
    private _threshold = ai_nav_gridStep * 1.5;
    
    private _borderNodes = [];
    private _nodeIds = _regionData get "nodes";
    
    {
        private _nodeData = ai_nav_nodes get _x;
        private _pos = _nodeData get "pos";
        _pos params ["_px", "_py"];
        
        private _isBorder = false;
        
        // Проверяем только нужную границу по направлению
        if (_dx == 1 && abs(_px - _regionMaxX) < _threshold) then {_isBorder = true};  // East
        if (_dx == -1 && abs(_px - _regionMinX) < _threshold) then {_isBorder = true}; // West
        if (_dy == 1 && abs(_py - _regionMaxY) < _threshold) then {_isBorder = true};  // North
        if (_dy == -1 && abs(_py - _regionMinY) < _threshold) then {_isBorder = true}; // South
        
        if (_isBorder) then {
            _borderNodes pushBack [_forEachIndex, _pos];
        };
    } forEach _nodeIds;
    
    _borderNodes
};


