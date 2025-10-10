// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\GameObjects\GameConstants.hpp>
#include <..\Gender\Gender.hpp>
/*
	How to work new ai system?
	TODO...

*/

ai_reloadThis = {
	call compile preprocessfilelinenumbers "src\host\AI\ai_init.sqf";
};

ai_genpoints = {
	if !isNull(ai_debug_points) then {
		deletevehicle ai_debug_points;
	};
	ai_debug_points = [];

	params ["_start","_end"];
	private _tcall = tickTime;
	private _makePoint = {
		private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		ai_debug_points pushBack _o;
		_o setposatl _this;
		_o
	};
	private _lineCheck = {
		params ["_s","_e"];
		_iret = lineIntersectsSurfaces [atltoasl _s,atltoasl _e];
		count _iret == 0
	};
	private _rotateVec = {
		params ["_v","_d"];
		_v params ["_x","_y","_z"];

		[_x * cos _d - _y * sin _d,_x * sin _d + _y * cos _d,_z]
	};

	{
		(_x call _makePoint) setObjectTexture [0,"#(rgb,8,8,3)color("+(str _foreachIndex)+",1,0,1)"];
	} foreach [_start,_end];

	_cur = _start;
	_i = 0; _rot = 0;
	while {_cur distance _end > 1} do {
		INC(_i);
		if (_i > 10000) exitWith {error("ITER ERROR")};
		_dir = vectornormalized (_end vectorDiff _cur) vectorMultiply 2;
		_dir = [_dir,_rot] call _rotateVec;
		_next = _cur vectorAdd _dir;
		
		if ([_cur,_next] call _lineCheck) then {
			_next call _makePoint;
			_cur = _next;
			_rot = 0;
		} else {
			_rot = _rot + 10;
		};
	};
	traceformat("CALLED AT %1ms",((tickTime - _tcall)*1000)toFixed 6);
};

ai_cellSize = 1;  // 5м шаг — ~8 nodes/10м чанк, быстро
ai_maxClimb = 0.8;  // Макс подъём
// ai_bounds = [minX, minY, minZ, maxX, maxY, maxZ];  // Установи в init

ai_getNearestNode = {
    params ["_posASL", "_nodes"];
    if (count _nodes == 0) exitWith { -1 };
    
    private _nearestID = -1;
    private _minDistS = 1e10;
    {
        private _nodeID = _x#0;
        private _nodePos = _x#1;
        private _distS = _nodePos distanceSqr _posASL;
        if (_distS < _minDistS) then {
            _minDistS = _distS;
            _nearestID = _nodeID;
        };
    } forEach _nodes;
    
    if (_minDistS > (ai_cellSize * 5)^2) exitWith {  // Если дальше 5 шагов — warn
        [format ["No close node to %1 (dist %2m)", _posASL, sqrt _minDistS]] call printTrace;
        -1
    };
    
    _nearestID
};

// Функция генерации графа (nodes + connections)
ai_generateGraph = {
    params ["_bounds"];  // [minX,minY,minZ, maxX,maxY,maxZ] ASL
    private _tstart = tickTime;
    
    private _minX = _bounds#0; private _minY = _bounds#1; private _minZ = _bounds#2;
    private _maxX = _bounds#3; private _maxY = _bounds#4; private _maxZ = _bounds#5;
    
    private _cxLocal = ceil ((_maxX - _minX) / ai_cellSize);
    private _cyLocal = ceil ((_maxY - _minY) / ai_cellSize);
    private _czLocal = ceil ((_maxZ - _minZ) / ai_cellSize);
    
    // Nodes: [ID, posASL]
    private _nodes = [];
    private _grid = [];  // Для быстрого индекса: grid[z*cy*cx + y*cx + x] = ID or -1
    private _nodeId = 0;
    for "_z" from 0 to _czLocal - 1 do {
        for "_y" from 0 to _cyLocal - 1 do {
            for "_x" from 0 to _cxLocal - 1 do {
                private _posASL = [
                    _minX + _x * ai_cellSize + ai_cellSize / 2,
                    _minY + _y * ai_cellSize + ai_cellSize / 2,
                    _minZ + _z * ai_cellSize + ai_cellSize / 2
                ];
                private _idx = _z * (_cxLocal * _cyLocal) + _y * _cxLocal + _x;
                _grid pushBack -1;
				
                // if (count (lineIntersectsSurfaces [_posASL, _posASL vectorAdd [0, 0, -ai_cellSize / 2]])>0 ) then {
                //     _grid set [_idx, _nodeId];
                //     _nodes pushBack [_nodeId, +_posASL];
                //     INC(_nodeId);
                // };
                private _rayStart = _posASL vectorAdd [0, 0, 1];  // Старт выше
                private _rayEnd = _posASL vectorAdd [0, 0, -1];   // Конец ниже
                private _intersects = lineIntersectsSurfaces [_rayStart, _rayEnd, objNull, objNull, true, 1, "GEOM", "VIEW"];
                if (count _intersects > 0) then {
                    private _hitPos = (_intersects#0)#0;  // Позиция удара
                    private _hitDist = _rayStart distance _hitPos;
                    if (_hitDist <= 2) then {  // На поверхности, не в яме
                        _posASL set [2, (_hitPos#2) + 0.1];  // Чуть над поверхностью
                        _grid set [_idx, _nodeId];
                        _nodes pushBack [_nodeId, +_posASL];
                        INC(_nodeId);
                    };
                };
            };
        };
    };
    
    // Connections: [[fromID, toID]]
    private _connections = [];
    private _gridSize = count _grid;
    for "_iIdx" from 0 to _gridSize - 1 do {
        private _iId = _grid#_iIdx;
        if (_iId == -1) then {continue};
        private _iZ = floor (_iIdx / (_cxLocal * _cyLocal));
        private _iY = floor ((_iIdx % (_cxLocal * _cyLocal)) / _cxLocal);
        private _iX = _iIdx % _cxLocal;
        private _iPos = _nodes#_iId #1;
        
        for "_dx" from -1 to 1 do {
            for "_dy" from -1 to 1 do {
                for "_dz" from -1 to 1 do {
                    if (_dx == 0 && _dy == 0 && _dz == 0) then {continue};
                    
                    private _nX = _iX + _dx; private _nY = _iY + _dy; private _nZ = _iZ + _dz;
                    if (_nX < 0 || _nX >= _cxLocal || _nY < 0 || _nY >= _cyLocal || _nZ < 0 || _nZ >= _czLocal) then {continue};
                    
                    private _nIdx = _nZ * (_cxLocal * _cyLocal) + _nY * _cxLocal + _nX;
                    private _nId = _grid#_nIdx;
                    if (_nId == -1 || _nId <= _iId) then {continue};  // Undirected, higher ID only
                    
                    private _nPos = _nodes#_nId #1;
                    private _hDiff = ((_nPos#2) - (_iPos#2));

                    //if (abs _hDiff > ai_maxClimb) then {continue};
					if (abs _dz > 0 && abs (_dz * ai_cellSize) > 1.5) then { continue; };  // Limit vertical to 1.5м, force horizontal

                    private _intersects = lineIntersectsSurfaces [_iPos, _nPos,objNull,objNull,true,1,"GEOM","VIEW"];
                    if (count _intersects == 0 || { private _normal = (_intersects#0)#1; (_normal#2) > 0.65 }) then {
                        //это позволит подниматься по лестницам
                        if (abs _hDiff > ai_maxClimb && count _intersects > 0) then {continue};
						_connections pushBack [_iId, _nId];
                    };
                };
            };
        };
    };
    
    private _timeMs = ((tickTime - _tstart) * 1000) toFixed 2;
    [format ["Graph gen: %1 nodes, %2 conns in %3ms", count _nodes, count _connections, _timeMs]] call printTrace;
    
	// ai_graphConnections = [_nodes,_connections];
	// ai_onframecode = {
	// 	ai_graphConnections params ["_nodes", "_connections"];
	// 		{
	// 			_x params ["_from","_to"];
	// 			if ((_nodes select _from select 1) distance (getposasl cameraon) > 5) then{continue};
	// 			drawLine3d [
	// 				asltoatl (_nodes select _from select 1) vectoradd [0,0,-0.5], asltoatl(_nodes select _to select 1) vectoradd [0,0,-0.5],
	// 				[1, 0, 0, 1],8
	// 			];
	// 		} forEach _connections;
	// };
	// if isNull(ai_onframecode_added) then {
	// 	ai_onframecode_added = true;
	// 	["onFrame",{
	// 		call ai_onframecode;
	// 	}] call Core_addEventHandler;
	// };

    [_nodes, _connections]  // Возврат
};

// Функция A* pathfinding (обёртка кода Sarogahtyp, с фиксами)
ai_findPath = {
    params ["_startID", "_endID", "_nodes", "_connections"];
    private _tstart = tickTime;
    
    // Проверка типов (фикс)
    if ((typeName _startID != "SCALAR") || (typeName _endID != "SCALAR") || (typeName _nodes != "ARRAY") || (typeName _connections != "ARRAY")) exitWith {
        trace("Invalid params types");
        false
    };
    
    // Проверка формата (первый node [ID, pos], conn [from, to])
    if (count _nodes == 0 || { count (_nodes#0) != 2 } || { count _connections == 0 || { count (_connections#0) != 2 } }) exitWith {
        trace("Invalid format");
        false
    };
    
    // Сортировка nodes по ID (если не отсортировано)
    _nodes sort true;
    
    // Свап start/end если нужно (код предполагает start < end? но не обязательно)
    // Убираем свап, код работает без
    
#ifndef SQRT2
 #define SQRT2 1.41421
#endif
    
    private _maxDist = (worldSize * SQRT2)^2;
    private _maxDistDoubl = 2 * _maxDist;
    
    // openList: [f (g+h sqr), predID, g sqr, nodeID]  // Нет pos, т.к. не нужно
    private _openList = [[0, _maxDist, 0, _startID]]; 
    
    private _closedList = [];  // [nodeID, predID]
    private _currentNode = _maxDist;
    
    scopeName "main";
    private _solutionFound = false;
    
    while {true} do {
        private _shortestHeuristic = _maxDistDoubl;
        private _shortestReal = _maxDist;
        
        // Get best f
        {
            if ((_x#0) < _shortestHeuristic) then {
                _shortestHeuristic = _x#0;
                _currentNode = _x;
            };
        } forEach _openList;
        
        private _openNum = count _openList;
        
        if (_openNum == 0) exitWith { breakTo "main"; };
        
        private _currID = _currentNode#3;
        
        // Delete from open
        private _idx = _openList findIf { _x#3 == _currID };
        if (_idx != -1) then { _openList deleteAt _idx; };
        
        _closedList pushBack [_currID, _currentNode#1];  // pred from open
        
        if (_currID == _endID) exitWith {
            _solutionFound = true;
            breakTo "main";
        };
        
        // Neighb conns
        private _neighbConns = _connections select {
            (_x#0 == _currID) || (_x#1 == _currID)
        };
        
        // Neighb nodes not closed and connected
        private _neighbNodes = [];
        {
            private _connFrom = _x#0; private _connTo = _x#1;
            private _neighbID = if (_connFrom == _currID) then { _connTo } else { _connFrom };
            private _closedIdx = _closedList findIf { _x#0 == _neighbID };
            if (_closedIdx == -1) then {
                private _already = _neighbNodes findIf { _x == _neighbID };
                if (_already == -1) then { _neighbNodes pushBack _neighbID; };
            };
        } forEach _neighbConns;
        
        {
            private _neighbID = _x;
            
            private _tentative_g = (_currentNode#2) + ((_nodes select _currID)#1 distanceSqr (_nodes select _neighbID)#1);
            private _neighInOListIndex = _openList findIf { _x#3 == _neighbID };
            private _heurDist = ((_nodes select _endID)#1 distanceSqr (_nodes select _neighbID)#1);
            
            if (_neighInOListIndex > -1) then {
                if (_tentative_g < (_openList select _neighInOListIndex)#2) then {
                    _openList set [_neighInOListIndex, [(_tentative_g + _heurDist), _currID, _tentative_g, _neighbID]];
                };
            } else {
                _openList pushBack [(_tentative_g + _heurDist), _currID, _tentative_g, _neighbID];
            };
        } forEach _neighbNodes;
    };
    
    if (!_solutionFound) exitWith {
        trace("No solution");
        true  // Как в коде
    };
    
    // Build path IDs
    private _path = [];
    private _currNodeIndex = _closedList findIf { _x#0 == _endID };
    private _currNode = _closedList select _currNodeIndex;
    
    _path pushBack (_currNode#0);
    
    while { (_currNode#0) != _startID } do {
        private _predID = _currNode#1;
        _currNodeIndex = _closedList findIf { _x#0 == _predID };
        if (_currNodeIndex == -1) exitWith { trace("Path build error"); };
        _currNode = _closedList select _currNodeIndex;
        _path pushBack (_currNode#0);
    };
    
    reverse _path;
    
    private _timeMs = ((tickTime - _tstart) * 1000) toFixed 2;
    [format ["A* find: %1 nodes in %2ms", count _path, _timeMs]] call printTrace;
    
    _path  // Массив ID пути
};

ai_findPathSLOW = {
    params ["_startID", "_endID", "_nodes", "_connections"];
    private _tstart = tickTime;
    
    // Проверки (как было)
    if ((typeName _startID != "SCALAR") || (typeName _endID != "SCALAR") || (typeName _nodes != "ARRAY") || (typeName _connections != "ARRAY")) exitWith {
        trace("Invalid params types");
        false
    };
    if (count _nodes == 0 || { count (_nodes#0) != 2 } || { count _connections == 0 || { count (_connections#0) != 2 } }) exitWith {
        trace("Invalid format");
        false
    };
    _nodes sort true;
    
#ifndef SQRT2
 #define SQRT2 1.41421
#endif
    
    private _maxDist = (worldSize * SQRT2)^2;
    private _maxDistDoubl = 2 * _maxDist;
    
    // OpenList: sorted by f [f, predID, g sqr, nodeID] — insert sorted
    private _openList = [];  
    private _gScores = createHashMap;  // ID -> best g (для check updates)
    private _cameFrom = createHashMap;  // ID -> predID (для пути)
    
    // Init
    _gScores set [_startID, 0];
    private _hStart = ((_nodes select _endID)#1 distanceSqr (_nodes select _startID)#1);
    private _fStart = 0 + _hStart;
    _openList pushBack [_fStart, -1, 0, _startID];  // pred -1 init
    _cameFrom set [_startID, -1];
    
    private _closedSet = createHashMapFromArray [];  // Просто keys для O(1) check
    private _solutionFound = false;
    private _currentID = -1;
    
    scopeName "main";
    
    while {count _openList > 0} do {
        // Pop min: первый, т.к. sorted
        private _currentEntry = _openList deleteAt 0;
        private _currF = _currentEntry#0;
        private _currPred = _currentEntry#1;
        private _currG = _currentEntry#2;
        _currentID = _currentEntry#3;
        
        // Skip if outdated (lazy delete: worse g)
        private _bestG = _gScores get _currentID;
        if (_currG > _bestG) then { continue; };
        
        // Close it
        _closedSet set [_currentID, true];
        
        if (_currentID == _endID) exitWith {
            _solutionFound = true;
            _cameFrom set [_currentID, _currPred];  // Update pred
            breakTo "main";
        };
        
        // Neighbors (кэшируй в _adjList если можно, но пока select)
        private _neighbConns = _connections select {
            (_x#0 == _currentID) || (_x#1 == _currentID)
        };
        private _neighbIDs = [];
        {
            private _neighbID = if (_x#0 == _currentID) then { _x#1 } else { _x#0 };
            if (!(_closedSet getOrDefault [_neighbID, false])) then {
                private _already = _neighbIDs find _neighbID;
                if (_already == -1) then { _neighbIDs pushBack _neighbID; };
            };
        } forEach _neighbConns;
        
        {
            private _neighbID = _x;
            private _neighPos = (_nodes select _neighbID)#1;
            private _currPos = (_nodes select _currentID)#1;
            private _tentativeG = _currG + (_currPos distanceSqr _neighPos);
            
            private _currentBestG = _gScores getOrDefault [_neighbID, _maxDistDoubl];
            if (_tentativeG < _currentBestG) then {
                // Update
                _gScores set [_neighbID, _tentativeG];
                _cameFrom set [_neighbID, _currentID];
                private _heurDist = _neighPos distanceSqr (_nodes select _endID)#1;
                private _tentativeF = _tentativeG + _heurDist;
                
                // Insert/update in open: binary search pos
                private _insertIdx = -1;
                private _low = 0; private _high = count _openList - 1;
                while {_low <= _high} do {
                    private _mid = floor ((_low + _high) / 2);
                    
                    if ((_openList#_mid)#0 >= _tentativeF) then {
                        _high = _mid - 1;
                    } else {
                        _low = _mid + 1;
                    };
                };
                _insertIdx = _low;  // Pos для insert (sorted asc by f)
                
                // Check if already in open (lazy: insert new, old ignore при попе)
                private _alreadyInOpen = false;
                {
                    if (_x#3 == _neighbID) exitWith { _alreadyInOpen = true; };
                } forEach _openList;
                if (!_alreadyInOpen) then {
                    _openList insert [_insertIdx, [[_tentativeF, _currentID, _tentativeG, _neighbID]]];
                };
            };
        } forEach _neighbIDs;
    };
    
    if (!_solutionFound) exitWith {
        trace("No solution");
        true
    };
    
    // Build path (backtrack via cameFrom)
    private _path = [];
    private _curr = _endID;
    while {_curr != _startID} do {
        _path pushBack _curr;
        _curr = _cameFrom get _curr;
        if (isNil "_curr") exitWith { trace("Path build error"); };
    };
    _path pushBack _startID;
    reverse _path;
    
    private _timeMs = ((tickTime - _tstart) * 1000) toFixed 2;
    [format ["A* find (opt): %1 nodes in %2ms", count _path, _timeMs]] call printTrace;
    
    _path
};

// Функция сглаживания пути (удаление коллинеарных + LOS check с fallback)
ai_smoothPath = {
    params ["_pathPos", "_nodes", "_connections"];  // Path pos ATL, graph for fallback
    private _original = +_pathPos;  // Keep for fallback
    
    // Шаг 1: Убираем коллинеарные (убирание лишних)
    private _collinear = [_original, 0.05];  // Tol 0.05 для ~3° angle
    {
        private _prev = _collinear #(_forEachIndex - 1);
        private _curr = _x;
        private _next = if (_forEachIndex < count _collinear - 1) then { _collinear #(_forEachIndex + 1) } else { nil };
        
        if (!isNil "_next") then {
            private _v1 = _curr vectorDiff _prev;
            private _v2 = _next vectorDiff _curr;
            private _cross = vectorMagnitude (_v1 vectorCrossProduct _v2);
            private _mag1 = vectorMagnitude _v1;
            private _mag2 = vectorMagnitude _v2;
            private _cosAngle = if (_mag1 > 0 && _mag2 > 0) then { ((_v1 vectorDotProduct _v2) / (_mag1 * _mag2)) } else { 0 };
            if (abs (1 - _cosAngle) < 0.05) then { continue; };  // Collinear, skip
        };
        _smoothed pushBack _curr;
    } forEach _collinear;
    
    // Шаг 2: LOS check и insert fallback
    private _final = [_smoothed#0];
    for "_i" from 1 to (count _smoothed - 1) do {
        private _p1 = _final #(count _final - 1);
        private _p2 = _smoothed#_i;
        private _segDist = _p1 distance _p2;
        if (_segDist < ai_cellSize) then {
            _final pushBack _p2;
            continue;
        };
        
        // Check LOS
        private _asl1 = ATLtoASL _p1; private _asl2 = ATLtoASL _p2;
        private _intersects = lineIntersectsSurfaces [_asl1, _asl2];
        if (count _intersects == 0) then {
            _final pushBack _p2;
            continue;
        };
        
        // Hit: check if climbable
        private _hit = _intersects#0;
        private _normal = _hit#1;
        if (abs (_normal#2) > 0.7) then {  // Climb ok
            _final pushBack _p2;
            continue;
        };
        
        // Not climbable: fallback — insert nearest from original or graph node
        private _insert = [_p1, _original] call BIS_fnc_nearestPosition;  // Arma func для nearest in array
        if (isNil "_insert" || { _insert distance _p1 < 1 }) then {
            // Or nearest graph node
            private _midASL = ATLtoASL (_p1 vectorAdd ((_p2 vectorDiff _p1) vectorMultiply 0.5));
            private _midID = [_midASL, _nodes] call ai_getNearestNode;
            if (_midID != -1) then { _insert = ASLtoATL ((_nodes select _midID)#1); };
        };
        if (!isNil "_insert") then {
            _final pushBack _insert;
        };
        _final pushBack _p2;  // Keep end
    };
    
    // Удаляем дубликаты (если dist <0.5)
    private _unique = [_final#0];
    {
        private _last = _unique #(count _unique - 1);
        if (_x distance _last > 0.5) then { _unique pushBack _x; };
    } forEach _final;
    
    _unique
};

// Основная функция для пути (новая, удобная: auto nearest + extract pos)
ai_genpoints = {
    params ["_startASL", "_endASL", ["_bounds", []], ["_debug", false]];
    
    if (count _bounds == 0) then {
        //[ "Bounds required if not global" ] call printTrace;
        _startASL params ["_sX", "_sY", "_sZ"];
        _endASL params ["_eX", "_eY", "_eZ"];
        _bounds = [
            (_sX min _eX) - 10,
            (_sY min _eY) - 10,
            (_sZ min _eZ) - 5,
            (_sX max _eX) + 10,
            (_sY max _eY) + 10,
            (_sZ max _eZ) + 5
        ]
        //nil
    };
    
    // private _graph = ifcheck(isNull(ai_debug_graph),[_bounds] call ai_generateGraph, ai_debug_graph);
    // ai_debug_graph = _graph;
    private _graph = [_bounds] call ai_generateGraph;
    private _nodes = _graph#0;
    private _connections = _graph#1;
    
    if (count _nodes == 0) exitWith { [ "No nodes generated" ] call printTrace; nil; };
    
    private _startID = [_startASL, _nodes] call ai_getNearestNode;
    private _endID = [_endASL, _nodes] call ai_getNearestNode;
    
    if (_startID == -1 || _endID == -1) exitWith { [ "No nearest nodes" ] call printTrace; nil; };
    
    [format ["Nearest: startID %1, endID %2", _startID, _endID]] call printTrace;
    
    private _pathIDs = [_startID, _endID, _nodes, _connections] call ai_findPath;
    if (typeName _pathIDs != "ARRAY") exitWith { [ "A* failed" ] call printTrace; nil; };
    
    // Extract pos ATL
    private _pathPos = [];
    {
        private _node = _nodes select _x;
        _pathPos pushBack (ASLtoATL (_node#1));
    } forEach _pathIDs;

	// private _smoothedPath = [_pathPos] call ai_smoothPath;
	// private _timeSmooth = ((tickTime - _tstartSmooth) * 1000) toFixed 2;  // Если добавил _tstartSmooth = tickTime перед smooth
	// [format ["Smoothed: %1 -> %2 points in %3ms", count _pathPos, count _smoothedPath, _timeSmooth]] call printTrace;
    
    // Debug points
    if (_debug) then {
        if (!isNil "ai_debug_points") then {
            { deleteVehicle _x; } forEach ai_debug_points;
            ai_debug_points = [];
        };
        ai_debug_points = [];
        private _makePoint = {
            params ["_posATL", "_progress"];
            private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
            ai_debug_points pushBack _o;
            _o setPosATL (_posATL);
            private _r = linearConversion [0,1, _progress, 0,1,true];
            private _g = 1 - _r;
            _o setObjectTexture [0, format ["#(rgb,8,8,3)color(%1,%2,0,1)", _r toFixed 2, _g toFixed 2]];
            _o
        };
        private _totalDist = _startASL distance _endASL;
        {
            private _prog = (_x distance _endASL) / _totalDist;
            [_x, _prog] call _makePoint;
        } forEach _pathPos;

		// Синие для smoothed
		// private _makeBluePoint = {
		// 	params ["_posATL"];
		// 	private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
		// 	ai_debug_points pushBack _o;
		// 	_o setPosATL _posATL;
		// 	_o setObjectTexture [0, "#(rgb,8,8,3)color(0,0,1,1)"];  // Синий
		// 	_o
		// };
		// {
		// 	[_x] call _makeBluePoint;
		// } forEach _smoothedPath;
    };
    
    [format ["Path ready: %1 points", count _pathPos]] call printTrace;
    
    _pathPos  // Возврат ATL позиций пути
};

ai_map_chunks = createHashMap;
ai_smartPathGet = {
    params ["_startASL", "_endASL"];
    
    _startASL params ["_sX", "_sY", "_sZ"];
    _endASL params ["_eX", "_eY", "_eZ"];
    
    private _chunkSizeXY = 10;
    private _chunkSizeZ = 1;
    //private _buffer = ai_cellSize * 3;  // Маленький запас ~3м, вместо full chunkSize
    
    private _bufferXY = _chunkSizeXY / 2;  // 10м для XY
    private _bufferZ = _chunkSizeZ / 2;    // 2.5м для Z
    // Bounds без over-expansion
    private _minX = floor((_sX min _eX - _bufferXY) / _chunkSizeXY) * _chunkSizeXY;
    private _maxX = ceil ((_sX max _eX + _bufferXY) / _chunkSizeXY) * _chunkSizeXY;
    private _minY = floor((_sY min _eY - _bufferXY) / _chunkSizeXY) * _chunkSizeXY;
    private _maxY = ceil ((_sY max _eY + _bufferXY) / _chunkSizeXY) * _chunkSizeXY;
    private _minZ = floor((_sZ min _eZ - _bufferZ) / _chunkSizeZ) * _chunkSizeZ;
    private _maxZ = ceil ((_sZ max _eZ + _bufferZ) / _chunkSizeZ) * _chunkSizeZ;
    
    private _relevantChunks = [];
    private _fnc_inBounds1d = {
        params ["_zStart", "_zEnd", "_intervalMin"];
        private _intervalMax = _intervalMin + 5;  // Твой _chunkSizeZ=5, хардкод или param
        private _zMin = _zStart min _zEnd; private _zMax = _zStart max _zEnd;
        (_zMin <= _intervalMax) && (_zMax >= _intervalMin)
    };
    private _fnc_inBounds2d = {
        params ["_lineStart", "_lineEnd", "_bboxMin", "_bboxMax"];
        _lineStart params ["_sx", "_sy"]; _lineEnd params ["_ex", "_ey"];
        _bboxMin params ["_minX", "_minY"]; _bboxMax params ["_maxX", "_maxY"];
        private _dx = _ex - _sx; private _dy = _ey - _sy;
        private _t0 = 0; private _t1 = 1;
        
        // X clip
        if (_dx == 0) then {
            if (_sx < _minX || _sx > _maxX) exitWith { false };
        } else {
            private _p = -_dx; private _qXmin = _sx - _minX; private _qXmax = _maxX - _sx;
            private _rXmin = _qXmin / _p; private _rXmax = _qXmax / _p;
            if (_p < 0) then { swap_lvars(_rXmin,_rXmax); };
            if (_rXmin > _rXmax) then { private _temp = _rXmin; _rXmin = _rXmax; _rXmax = _temp; };
            _t0 = _t0 max _rXmin;
            _t1 = _t1 min _rXmax;
            if (_t0 > _t1) exitWith { false };
        };
        
        // Y clip
        if (_dy == 0) then {
            if (_sy < _minY || _sy > _maxY) exitWith { false };
        } else {
            private _p = -_dy; private _qYmin = _sy - _minY; private _qYmax = _maxY - _sy;
            private _rYmin = _qYmin / _p; private _rYmax = _qYmax / _p;
            if (_rYmin > _rYmax) then { private _temp = _rYmin; _rYmin = _rYmax; _rYmax = _temp; };
            _t0 = _t0 max _rYmin;
            _t1 = _t1 min _rYmax;
            if (_t0 > _t1) exitWith { false };
        };
        
        (_t0 <= _t1) && (_t1 >= 0)
    };
    // Собери с intersect
    for "_cx" from _minX to _maxX step _chunkSizeXY do {
        for "_cy" from _minY to _maxY step _chunkSizeXY do {
            for "_cz" from _minZ to _maxZ step _chunkSizeZ do {
                private _chunkMin = [_cx, _cy];
                private _chunkMax = [_cx + _chunkSizeXY, _cy + _chunkSizeXY];
                private _intersectsXY = [_startASL, _endASL, _chunkMin, _chunkMax] call _fnc_inBounds2d;
                private _intersectsZ = [_sZ, _eZ, _cz] call _fnc_inBounds1d;  // Pass cz as intervalMin
                [format ["      XY=%1 | Z=%2", _intersectsXY, _intersectsZ]] call printTrace;
                if (_intersectsXY && _intersectsZ) then {
                    [format ["      *** ADDED chunk [%1,%2,%3] ***", _cx, _cy, _cz]] call printTrace;
                    _relevantChunks pushBack [_cx, _cy, _cz];
                } else {
                    [format ["      --- SKIPPED (XY or Z false) ---"]] call printTrace;
                };
            };
        };
    };
    
    [format ["Bounds: X[%1-%2] Y[%3-%4] Z[%5-%6], relevant chunks: %7", _minX,_maxX, _minY,_maxY, _minZ,_maxZ, count _relevantChunks]] call printTrace;
    {
        [format ["Chunk added: %1", _x]] call printTrace;
    } forEach _relevantChunks;

    if (count _relevantChunks == 0 ) exitWith { ["No relevant chunks"] call printTrace; nil; };
    
    [format ["Processing %1 chunks", count _relevantChunks]] call printTrace;
    
    // Merge graphs
    private _mergedNodes = [];
    private _mergedConnections = [];
    private _globalNodeOffset = 0;  // Для unique ID across chunks
    
    {
        _x params ["_cx", "_cy", "_cz"];
        private _chunkKey = format ["%1_%2_%3", _cx, _cy, _cz];
        
        private _chunkBounds = [_cx - _chunkSizeXY, _cy - _chunkSizeXY, _cz - _chunkSizeZ, _cx + _chunkSizeXY, _cy + _chunkSizeXY, _cz + _chunkSizeZ];
        
        if !(_chunkKey in ai_map_chunks) then {
            private _graph = [_chunkBounds] call ai_generateGraph;
            if (count (_graph#0) == 0) then { continue; };  // Skip empty
            ai_map_chunks set [_chunkKey, _graph];
            [format ["Generated chunk %1: %2 nodes", _chunkKey, count (_graph#0)]] call printTrace;
        };
        
        private _graph = ai_map_chunks get _chunkKey;
        private _chunkNodes = +(_graph#0);  // Copy
        private _chunkConns = +(_graph#1);
        
        // Offset IDs in nodes and conns
        {
            _x set [0, _x#0 + _globalNodeOffset];  // ID += offset
        } forEach _chunkNodes;
        {
            _x set [0, _x#0 + _globalNodeOffset];
            _x set [1, _x#1 + _globalNodeOffset];
        } forEach _chunkConns;
        
        _mergedNodes append _chunkNodes;
        _mergedConnections append _chunkConns;
        _globalNodeOffset = _globalNodeOffset + count _chunkNodes;
        
    } forEach _relevantChunks;
    
    if (count _mergedNodes == 0) exitWith { ["No nodes after merge"] call printTrace; nil; };
    
    [format ["Merged: %1 nodes, %2 conns", count _mergedNodes, count _mergedConnections]] call printTrace;
    
    // Global nearest
    private _startID = [_startASL, _mergedNodes] call ai_getNearestNode;
    private _endID = [_endASL, _mergedNodes] call ai_getNearestNode;
    
    if (_startID == -1 || _endID == -1) exitWith { 
        [format ["No nearest in merged: start dist %1, end dist %2", 
            sqrt(((_mergedNodes select _startID)#1 distanceSqr _startASL)), 
            sqrt(((_mergedNodes select _endID)#1 distanceSqr _endASL)) ]] call printTrace; 
        nil; 
    };
    
    [format ["Global nearest: startID %1, endID %2", _startID, _endID]] call printTrace;
    
    private _pathIDs = [_startID, _endID, _mergedNodes, _mergedConnections] call ai_findPath;
    if (typeName _pathIDs != "ARRAY") exitWith { ["A* failed on merged"] call printTrace; nil; };
    
    // Extract pos
    private _pathPos = [];
    {
        private _node = _mergedNodes select _x;
        _pathPos pushBack (ASLtoATL (_node#1));
    } forEach _pathIDs;
    
    // Debug points (как было, но на _pathPos)
    if (!isNil "ai_debug_points") then {
        { deleteVehicle _x; } forEach ai_debug_points;
        ai_debug_points = [];
    };
    ai_debug_points = [];
    private _makePoint = {
        params ["_posATL", "_progress"];
        private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
        ai_debug_points pushBack _o;
        _o setPosATL _posATL;
        private _r = linearConversion [0,1, _progress, 0,1,true];
        private _g = 1 - _r;
        _o setObjectTexture [0, format ["#(rgb,8,8,3)color(%1,%2,0,1)", _r toFixed 2, _g toFixed 2]];
        _o
    };
    private _totalDist = _startASL distance _endASL;
    {
        private _prog = (_x distance _endASL) / _totalDist;
        [_x, _prog] call _makePoint;
    } forEach _pathPos;
    
    [format ["Full path: %1 points from %2 chunks", count _pathPos, count _relevantChunks]] call printTrace;
    
    _pathPos
};

/* * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * * 
    NAV MESH VARIANT
 * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * *  * * */

// ============================================
// NavMesh-based Pathfinding for Arma 3 AI
// Simplified: Heightmap + Flood-fill regions + Convex polys + Triangulate stubs
// Gen per chunk ~1-2s with cell=5m. A* on verts ~50ms.
// Integrate: Replace ai_generateGraph calls with ai_generateNavMesh
// ============================================

// Globals
ai_cellSize = 5;
ai_maxClimb = 0.8;

// Helper: Height at XY
ai_getHeightAt = {
    params ["_posXYASL"];  // [x,y, highZ]
    private _rayStart = [_posXYASL#0, _posXYASL#1, _posXYASL#2 + 10];
    private _rayEnd = [_posXYASL#0, _posXYASL#1, _posXYASL#2 - 20];
    private _hits = lineIntersectsSurfaces [_rayStart, _rayEnd, objNull, objNull, true, 1, "GEOM", "VIEW"];
    if (count _hits > 0) exitWith { ((_hits#0)#0)#2 + 0.1 };
    -999
};

// Centroid
vectorMean = {
    params ["_positions"];
    if (count _positions == 0) exitWith { [0,0,0] };
    private _sumX = 0; private _sumY = 0; private _sumZ = 0;
    { _sumX = _sumX + _x#0; _sumY = _sumY + _x#1; _sumZ = _sumZ + _x#2; } forEach _positions;
    private _count = count _positions;
    [ _sumX / _count, _sumY / _count, _sumZ / _count ]
};

// Gen NavMesh
ai_generateNavMesh = {
    params ["_bounds"];
    private _tstart = diag_tickTime;
    
    private _minX = _bounds#0; private _minY = _bounds#1; private _minZ = _bounds#2;
    private _maxX = _bounds#3; private _maxY = _bounds#4; private _maxZ = _bounds#5;
    
    private _gridW = ceil ((_maxX - _minX) / ai_cellSize);
    private _gridH = ceil ((_maxY - _minY) / ai_cellSize);
    
    // Flat heightmap: scalars (height or -1 blocked)
    private _heightmap = [];
    private _freeCells = [];  // Indices of free: [_x, _y]
    for "_y" from 0 to _gridH - 1 do {
        for "_x" from 0 to _gridW - 1 do {
            private _cellCenter = [
                _minX + _x * ai_cellSize + ai_cellSize / 2,
                _minY + _y * ai_cellSize + ai_cellSize / 2,
                _maxZ + 10
            ];
            private _height = [_cellCenter] call ai_getHeightAt;
            private _isFree = (_height > -500) && { abs (_height - _cellCenter#2) < 2 };
            _heightmap pushBack _height;  // Always scalar
            if (_isFree) then { _freeCells pushBack [_x, _y]; };
        };
    };
    
    [format ["Heightmap: %1 free cells", count _freeCells]] call printTrace;
    
    // Flood-fill: connected free regions
    private _regions = [];  // [[ [x1,y1], [x2,y2], ... ], ...]
    private _visited = []; for "_i" from 0 to (count _heightmap - 1) do { _visited pushBack false; };
    {
        _x params ["_fx", "_fy"];
        private _fIdx = _fy * _gridW + _fx;
        if (_visited#_fIdx) then { continue; };
        
        private _region = [];
        private _queue = [_fIdx];
        _visited set [_fIdx, true];
        
        while {count _queue > 0} do {
            private _cIdx = _queue deleteAt 0;
            private _cx = _cIdx % _gridW; private _cy = floor (_cIdx / _gridW);
            _region pushBack [_cx, _cy];
            
            // 4-neigh
            {
                private _nx = _cx + _x#0; private _ny = _cy + _x#1;
                if (_nx >= 0 && _nx < _gridW && _ny >= 0 && _ny < _gridH) then {
                    private _nIdx = _ny * _gridW + _nx;
                    if (!(_visited#_nIdx) && { (_heightmap#_nIdx) != -1 }) then {
                        _visited set [_nIdx, true];
                        _queue pushBack _nIdx;
                    };
                };
            } forEach [[0,1],[0,-1],[1,0],[-1,0]];
        };
        
        if (count _region > 2) then { _regions pushBack _region; };
    } forEach _freeCells;
    
    [format ["Regions: %1", count _regions]] call printTrace;
    
    // Polys: verts from region cells
    private _polys = [];  // [ [pos1, pos2, ...], ... ]
    {
        private _polyVerts = [];
        {
            _x params ["_rx", "_ry"];
            private _hIdx = _ry * _gridW + _rx;
            private _h = _heightmap#_hIdx;
            if (_h == -1) exitWith {};  // Safety
            _polyVerts pushBack [
                _minX + _rx * ai_cellSize + ai_cellSize / 2,
                _minY + _ry * ai_cellSize + ai_cellSize / 2,
                _h
            ];
        } forEach _x;
        
        if (count _polyVerts > 2) then {
            // Approx hull: sort by angle from center
            private _center = [_polyVerts] call vectorMean;
            private _sorted = [+_polyVerts];
            _sorted sort true;
            _polys append _sorted;
        };
    } forEach _regions;
    
    // Triangulate stub (fan for convex approx)
    private _triangles = [];  // [ [[id1,id2,id3]], ... ] — later remap
    {
        private _poly = _x;
        private _n = count _poly;
        if (_n < 3) exitWith {error("count :" + (str _poly))};
        for "_i" from 1 to _n - 2 do {
            _triangles pushBack [[0, _i, _i + 1]];  // Fan from vert 0
        };
    } forEach _polys;
    
    [format ["Triangles: %1", count _triangles]] call printTrace;
    
    // Unique verts
    private _allVerts = [];
    {
        {
            _allVerts pushback _x;  // Flatten: single pos per push
        } forEach _x;
    } forEach _polys;  // Nested [pos, pos, ...]
    //traceformat("VERTS %1", _allVerts);
    private _uniqueVerts = []; private _vertMap = createHashMap; private _nodeId = 0;
    {
        private _key = format ["%1_%2_%3", (_x#0 toFixed 1), (_x#1 toFixed 1), (_x#2 toFixed 1)];
        if !(_vertMap getOrDefault [_key, false]) then {
            _vertMap set [_key, _nodeId];
            _uniqueVerts pushBack [_nodeId, +_x];  // +_x copies [3-elem]
            INC(_nodeId);
        };
    } forEach _allVerts;
    
    // Remap tris to global IDs
    private _globalTris = [];
    {
        _x params ["_a", "_b", "_c"];  // Local 0-based in poly
        private _polyVerts = _polys # _forEachIndex;  // Get original poly
        errorformat("POLY: %1 x: %2", _polyVerts arg _triangles);
        private _globalA = _vertMap get (format ["%1_%2_%3", (_polyVerts#_a)#0 toFixed 1, (_polyVerts#_a)#1 toFixed 1, (_polyVerts#_a)#2 toFixed 1]);
        private _globalB = _vertMap get (format ["%1_%2_%3", (_polyVerts#_b)#0 toFixed 1, (_polyVerts#_b)#1 toFixed 1, (_polyVerts#_b)#2 toFixed 1]);
        private _globalC = _vertMap get (format ["%1_%2_%3", (_polyVerts#_c)#0 toFixed 1, (_polyVerts#_c)#1 toFixed 1, (_polyVerts#_c)#2 toFixed 1]);
        _globalTris pushBack [_globalA, _globalB, _globalC];
    } forEach _triangles;
    
    // Conns from tris edges (undirected)
    private _connections = [];
    {
        _x params ["_a", "_b", "_c"];
        {
            private _u = _x#0; private _v = _x#1;
            if !(_connections findIf { (_y#0 == _u && _y#1 == _v) || (_y#0 == _v && _y#1 == _u) } != -1) then {
                trace("LOS")
                // LOS check
                private _posU = (_uniqueVerts#_u)#1; private _posV = (_uniqueVerts#_v)#1;
                private _hDiff = abs ((_posV#2) - (_posU#2));
                    
                if (_hDiff <= ai_maxClimb ) then {
                    private _intersects = lineIntersectsSurfaces [_posU, _posV, objNull, objNull, true, 1, "GEOM", "VIEW"];
                    if (count _intersects == 0 || { ((_intersects#0)#1)#2 > 0.65 }) then {
                        _connections pushBack [_u, _v];
                    };
                };
            };
        } forEach [[_a,_b], [_b,_c], [_c,_a]];
    } forEach _globalTris;
    
    private _time = (diag_tickTime - _tstart) * 1000;
    [format ["NavMesh: %1 verts, %2 conns in %3ms", count _uniqueVerts, count _connections, _time]] call printTrace;
    
    [_uniqueVerts, _connections]
};

// Update ai_genpoints (replace graph gen)
ai_genpoints = {
    params ["_startASL", "_endASL", ["_bounds", []], ["_debug", false]];
    
    if (count _bounds == 0) then {
        _startASL params ["_sX", "_sY", "_sZ"];
        _endASL params ["_eX", "_eY", "_eZ"];
        _bounds = [
            (_sX min _eX) - 10, (_sY min _eY) - 10, (_sZ min _eZ) - 5,
            (_sX max _eX) + 10, (_sY max _eY) + 10, (_sZ max _eZ) + 5
        ];
    };
    
    private _graph = [_bounds] call ai_generateNavMesh;  // New!
    private _nodes = _graph#0;
    private _connections = _graph#1;
    
    if (count _nodes == 0) exitWith { ["No navmesh"] call printTrace; nil; };
    
    private _startID = [_startASL, _nodes] call ai_getNearestNode;
    private _endID = [_endASL, _nodes] call ai_getNearestNode;
    
    if (_startID == -1 || _endID == -1) exitWith { ["No nearest verts"] call printTrace; nil; };
    
    private _pathIDs = [_startID, _endID, _nodes, _connections] call ai_findPath;
    if (count _pathIDs == 0) exitWith { ["A* failed"] call printTrace; nil; };
    
    private _pathPos = [];
    { _pathPos pushBack (ASLtoATL ((_nodes select _x)#1)); } forEach _pathIDs;
    
    // Debug as before...
    if (_debug) then { /* your points code */ };
    
    _pathPos
};

#include "WIP.sqf"


ai_createMob = {
	params ["_pos",["_stats",[10,10,10,10]]];

	private _gMob = _pos call gm_createMob;
	private _mob = new(Mob);
	callFuncParams(_mob,initAsActor,_gMob);
	[_mob,8,10,8,12] call gurps_initSkills;
	setVar(_mob,name,"Существо");
	([GENDER_MALE] call naming_getRandomName) params ["_f_","_s_"];
	[_mob,_f_,_s_] call naming_generateName;

	smd_allInGameMobs pushBackUnique _gMob;
	callFuncParams(_mob,setMobFace,pick faces_list_man);
	setVar(_mob,curTargZone,TARGET_ZONE_RANDOM);

	[_gMob,_mob] call ai_startSM;
};

ai_startSM = {
	params ["_visual","_virtual"];

	_visual setVariable ["ai_mode","stop"];
	_visual setVariable ["ai_lastact",tickTime];
	_visual setVariable ["ai_state","idle"];
	_visual setVariable ["ai_target",nullPtr];

	private _h = startUpdateParams(ai_mob_onUpdate,0.01,vec2(_visual,_virtual));
	_visual setVariable ["ai_handle",_h];
};

ai_mob_onUpdate = {
	(_this select 0) params ["_vis","_virt"];
	if (tickTime < (_vis getVariable "ai_lastact")) exitWith {};
	_state = _vis getVariable "ai_state";
	#define checkState(name) if equals(_state,name) exitWith
	#define gv(name) (_vis getVariable 'ai_##name')
	#define sv(name,val) _vis setVariable ['ai_##name',val]

	checkState(idle) {
		//find target
		_l = callFuncParams(_virt,getNearMobs,5 arg false);
		if (count _l > 0) exitWith {
			//set target
			_visual setVariable ["ai_target",_l select 0];
			_visual setVariable ["ai_state","moveto"];
		};

	};
	checkState(moveto) {
		__canmoveto = {
			private _its = lineIntersectsSurfaces [(getPosASL _vis)vectorAdd[0,0,0.5],_vis modelToWorld [0,0.9,0.5],_vis,objNull,true,1,"GEOM","VIEW"];
			(count _its == 0)
		};
		if (call __canmoveto) then {
			if (gv(mode) != "stop") then {
				_vis playAction "WalkF";
				sv(mode,"move");
			};
		} else {
			if (gv(mode)=="move") then {
				_vis playAction "stop";
				sv(mode,"stop");
			};
		};
	};
};
