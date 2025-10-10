
ai_buildNavmesh = {
	//todo
};

ai_getNavmeshArea = {
	params ["_startASL","_endASL"];
	//todo
};

ai_astar = {
	params ["_navmesh","_startASL","_endASL"];
	//todo
};

ai_calcPath = {
	params ["_startASL","_endASL"];

	//impl
	private _bounds = [_startASL,_endASL] call ai_getNavmeshArea;
	private _navmesh = [_bounds] call ai_buildNavmesh;
	private _points = [_navmesh,_startASL,_endASL] call ai_astar;

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
	//todo create navmesh area points
};

//impl
ai_buildNavmesh = {
	params ["_bounds"];
	
	private _t0 = tickTime;
	["Building navmesh for bounds %1", _bounds] call printTrace;
	
	private _min = _bounds select 0;
	private _max = _bounds select 1;
	
	private _nodePos = [];
	private _edges = [];
	
	private _gridSize = 1; // 1m grid for precision
	private _maxSlopeRad = 30 / 180 * 3.14159;
	private _levelHeight = 4; // Approximate height per level for grouping
	private _connectDist = _gridSize * 1.5; // Fixed syntax: 1.5m max horiz connect
	private _losHeight = 1.5; // Height above surface for LOS check
	private _vertMaxDist = 5; // Tight vertical connect: only small drops (stairs, not shafts)
	private _vertLOSThresh = 2; // Vertical LOS maxResults (short rays)
	
	// Calculate grid bounds
	private _startGX = floor ((_min select 0) / _gridSize);
	private _endGX = ceil ((_max select 0) / _gridSize) - 1;
	private _startGY = floor ((_min select 1) / _gridSize);
	private _endGY = ceil ((_max select 1) / _gridSize) - 1;
	private _numCols = ((_endGX - _startGX + 1) * (_endGY - _startGY + 1));
	
	["Grid: %1x%2 cols (%3 total)", (_endGX - _startGX + 1), (_endGY - _startGY + 1), _numCols] call printTrace;
	
	// Collect column nodes: hashmap key="gx_gy" value=array of node indices (sorted descending Z)
	private _colNodes = createHashMap;
	
	for "_gx" from _startGX to _endGX do {
		for "_gy" from _startGY to _endGY do {
			private _xpos = _gx * _gridSize + (_gridSize / 2); // Center for better hits
			private _ypos = _gy * _gridSize + (_gridSize / 2);
			private _lineStart = [_xpos, _ypos, (_max select 2) + 10]; // Slightly above max
			private _lineEnd = [_xpos, _ypos, (_min select 2) - 50]; // Deeper but not too much
			
			// Optimized: maxResults=5 for speed (caves rarely >3 levels), full GEOM+VIEW
			private _intersections = lineIntersectsSurfaces [_lineStart, _lineEnd, objNull, objNull, true, 5];
			
			private _hits = [];
			{
				private _pos = _x select 0;
				private _normal = _x select 1;
				if (isNULL(_x select 2)) exitWith {}; // Skip invalid (no object)
				private _slope = acos (_normal select 2);
				if (_slope <= _maxSlopeRad || {(_normal select 2) > 0.65}) then { // Your flat surface add
					_hits pushBack _pos;
				};
			} forEach _intersections;
			
			// Sort descending Z: top to bottom
			_hits sort false;
			
			private _colIdx = [];
			{
				private _pos = _x;
				private _idx = count _nodePos;
				_nodePos pushBack _pos;
				_colIdx pushBack _idx;
			} forEach _hits;
			
			private _key = format ["%1_%2", _gx, _gy];
			_colNodes set [_key, _colIdx];
		};
	};
	
	private _t1 = tickTime;
	["Generated %1 potential nodes in %2s", count _nodePos, (_t1 - _t0)] call printTrace;
	
	// Group nodes by approximate level: level -> colHash (gx_gy -> [indices]) for fast horiz lookup
	private _levels = createHashMap; // level -> colHash
	{
		private _z = _x select 2;
		private _level = round (_z / _levelHeight);
		private _gx = round ((_x select 0) / _gridSize);
		private _gy = round ((_x select 1) / _gridSize);
		private _key = format ["%1_%2", _gx, _gy];
		private _colHash = _levels getOrDefault [_level, createHashMap];
		private _levColNodes = _colHash getOrDefault [_key, []];
		_levColNodes pushBack _forEachIndex;
		_colHash set [_key, _levColNodes];
		_levels set [_level, _colHash];
	} forEach _nodePos;
	
	private _levelKeys = keys _levels;
	_levelKeys sort true;
	
	private _t2 = tickTime;
	["Grouped into %1 levels in %2s", count _levelKeys, (_t2 - _t1)] call printTrace;
	
	// Connect horizontally within each level (optimized: column-based, O(1) neighbor lookup)
	private _directions = [[1,0], [0,1], [-1,0], [0,-1], [1,1], [1,-1], [-1,1], [-1,-1]]; // 8 dir for full coverage
	private _horizEdges = []; // Temp to avoid dupes early
	private _losFailed = 0;
	{
		private _level = _x;
		private _colHash = _levels get _level;
		if (count (keys _colHash) == 0) exitWith {};
		
		private _levNodeList = []; // All nodes in level
		{ _levNodeList append (_y); } forEach _colHash;
		
		{
			private _nodeIdx = _x;
			private _pos = _nodePos select _nodeIdx;
			private _gx = round ((_pos select 0) / _gridSize);
			private _gy = round ((_pos select 1) / _gridSize);
			private _currKey = format ["%1_%2", _gx, _gy];
			private _currColNodes = _colHash get _currKey;
			if (isNil "_currColNodes" || {count _currColNodes == 0}) exitWith {};
			
			{
				private _dx = _x select 0;
				private _dy = _x select 1;
				private _nx = _gx + _dx;
				private _ny = _gy + _dy;
				private _nKey = format ["%1_%2", _nx, _ny];
				private _neighColNodes = _colHash get _nKey;
				if (!isNil "_neighColNodes" && {count _neighColNodes > 0}) then {
					// Closest in neigh col (fast: 1-2 nodes per col/level)
					private _closestIdx = -1;
					private _minDist = _connectDist;
					{
						private _nIdx = _x;
						private _nPos = _nodePos select _nIdx;
						if (_pos distance _nPos < _minDist) then {
							_minDist = _pos distance _nPos;
							_closestIdx = _nIdx;
						};
					} forEach _neighColNodes;
					
					if (_closestIdx != -1 && {_nodeIdx != _closestIdx}) then {
						private _nPos = _nodePos select _closestIdx;
						private _dist3D = _pos distance _nPos;
						if (_dist3D < _connectDist) then {
							// Single LOS at losHeight (faster, sufficient for horiz)
							private _checkStart = [(_pos select 0), (_pos select 1), (_pos select 2) + _losHeight];
							private _checkEnd = [(_nPos select 0), (_nPos select 1), (_nPos select 2) + _losHeight];
							private _obstacles = lineIntersectsSurfaces [_checkStart, _checkEnd, objNull, objNull, true, 1];
							if (count _obstacles == 0) then {
								_horizEdges pushBack [_nodeIdx, _closestIdx, _dist3D];
							} else {
								_losFailed = _losFailed + 1;
							};
						};
					};
				};
			} forEach _directions;
		} forEach _levNodeList;
	} forEach _levelKeys;
	
	private _t3 = tickTime;
	["Added %1 horiz edges, LOS failed: %2 in %3s", count _horizEdges, _losFailed, (_t3 - _t2)] call printTrace;
	
	// Connect vertically within columns: ONLY small drops WITH LOS (prevents invalid shafts)
	{
		private _key = _x;
		private _colIdx = _y;
		if (count _colIdx > 1) then {
			for "_k" from 0 to (count _colIdx - 2) do {
				private _idx1 = _colIdx select _k;
				private _idx2 = _colIdx select (_k + 1);
				private _pos1 = _nodePos select _idx1;
				private _pos2 = _nodePos select _idx2;
				private _dist = _pos1 distance _pos2;
				if (_dist < _vertMaxDist) then { // Tight: 5m max (stairs only)
					// Mandatory vertical LOS: short ray, no multi for speed
					private _vObstacles = lineIntersectsSurfaces [_pos1, _pos2, objNull, objNull, true, _vertLOSThresh];
					if (count _vObstacles == 0) then {
						_edges pushBack [_idx1, _idx2, _dist];
						_edges pushBack [_idx2, _idx1, _dist];
					};
				};
			};
		};
	} forEach _colNodes;
	
	// Merge horiz + vert, dedup
	_edges append _horizEdges;
	private _uniqueEdges = [];
	private _edgeSet = createHashMap;
	{
		private _e = [_x select 0, _x select 1] call BIS_fnc_sortNum;
		private _eKey = format ["%1_%2", _e select 0, _e select 1];
		if (isNil {_edgeSet get _eKey}) then {
			_edgeSet set [_eKey, true];
			_uniqueEdges pushBack [_e select 0, _e select 1, _x select 2]; // Restore cost
		};
	} forEach _edges;
	_edges = _uniqueEdges;
	
	private _t4 = tickTime;
	["Added vertical edges; total %1 unique in %2s", count _edges, (_t4 - _t3)] call printTrace;
	
	private _navmesh = [_nodePos, _edges];
	["Total build time: %1s", (tickTime - _t0)] call printTrace;
	
	// Debug render: lines for edges (distance-limited for FPS)
	ai_graphConnections = _navmesh;
	ai_onframecode = {
		private _camPos = getPosASL cameraOn;
		ai_graphConnections params ["_nodes", "_connections"];
		{
			_x params ["_ix", "_iy"];
			private _p1 = _nodes select _ix;
			private _p2 = _nodes select _iy;
			if ((_p1 distance _camPos > 20) || {(_p2 distance _camPos > 20)}) exitWith {}; // Limit to 20m for FPS
			drawLine3D [
				ASLtoATL _p1 vectoradd [0,0,0.1], ASLtoATL _p2 vectoradd [0,0,0.1],
				[1, 0, 0, 1],20
			];
		} forEach _connections;
	};
	if (isNil "ai_onframecode_added") then {
		ai_onframecode_added = true;
		["onFrame", { call ai_onframecode; }] call Core_addEventHandler;
	};
	
	_navmesh
};

ai_getNavmeshArea = {
	params ["_startASL","_endASL"];
	
	// Compute padded bounds covering start and end (acts as the "region" for this path)
	private _pad = 5;
	private _min = [(_startASL select 0) min (_endASL select 0), (_startASL select 1) min (_endASL select 1), (_startASL select 2) min (_endASL select 2)];
	private _max = [(_startASL select 0) max (_endASL select 0), (_startASL select 1) max (_endASL select 1), (_startASL select 2) max (_endASL select 2)];
	_min = _min vectorDiff [_pad, _pad, _pad];
	_max = _max vectorAdd [_pad, _pad, _pad];
	
	private _bounds = [_min, _max];
	
	["Navmesh area bounds: %1", _bounds] call printTrace;
	
	_bounds
};

ai_astar = {
	params ["_navmesh","_startASL","_endASL"];
	FHEADER;
	private _nodePos = _navmesh select 0;
	private _edges = _navmesh select 1;
	private _numNodes = count _nodePos;
	
	if (_numNodes == 0) exitWith { [] };
	private _t = tickTime;
	
	// Build adj list for speed (O(E) build, O(deg) per step)
	private _adj = [];
	_adj resize _numNodes;
	{
		_adj set [_x select 0, []];
		_adj set [_x select 1, []];
	} forEach _edges;
	{
		private _from = _x select 0;
		private _to = _x select 1;
		private _cost = _x select 2;
		(_adj select _from) pushBack [_to, _cost];
		(_adj select _to) pushBack [_from, _cost];
	} forEach _edges;
	
	// Find start and goal nodes (closest to positions)
	private _startNode = 0;
	private _minDistS = (_nodePos select 0) distance _startASL;
	for "_i" from 1 to (_numNodes - 1) do {
		private _dist = (_nodePos select _i) distance _startASL;
		if (_dist < _minDistS) then {
			_minDistS = _dist;
			_startNode = _i;
		};
	};
	
	private _goalNode = 0;
	private _minDistG = (_nodePos select 0) distance _endASL;
	for "_i" from 1 to (_numNodes - 1) do {
		private _dist = (_nodePos select _i) distance _endASL;
		if (_dist < _minDistG) then {
			_minDistG = _dist;
			_goalNode = _i;
		};
	};
	
	["A* from node %1 (dist %2m) to node %3 (dist %4m)", _startNode, _minDistS, _goalNode, _minDistG] call printTrace;
	
	// A* implementation
	private _openSet = [_startNode];
	
	// Initialize arrays
	private _cameFrom = [];
	_cameFrom resize _numNodes;
	{ _cameFrom set [_forEachIndex, -1]; } forEach _cameFrom;
	
	private _gScore = [];
	_gScore resize _numNodes;
	{ _gScore set [_forEachIndex, 1e6]; } forEach _gScore;
	_gScore set [_startNode, 0];
	
	private _fScore = [];
	_fScore resize _numNodes;
	{ _fScore set [_forEachIndex, 1e6]; } forEach _fScore;
	_fScore set [_startNode, (_nodePos select _startNode) distance _endASL];
	
	while {count _openSet > 0} do {
		// Lowest fScore (naive; ok for <1k nodes)
		private _current = -1;
		private _lowestF = 1e6;
		{
			private _node = _x;
			private _f = _fScore select _node;
			if (!isNil "_f" && {_f < _lowestF}) then {
				_lowestF = _f;
				_current = _node;
			};
		} forEach _openSet;
		
		if (_current == -1) exitWith { [] };
		
		if (_current == _goalNode) exitWith {
			// Reconstruct path
			private _path = [];
			private _totalCurrent = _goalNode;
			while {_totalCurrent != _startNode} do {
				_path pushBack _totalCurrent;
				_totalCurrent = _cameFrom select _totalCurrent;
				if (_totalCurrent == -1) exitWith { RETURN([]) };
			};
			_path pushBack _startNode;
			reverse _path;
			
			private _points = [];
			{ _points pushBack (_nodePos select _x); false } forEach _path;
			["time get nodes: %1 ms", (tickTime - _t)*1000] call printTrace;
			RETURN(_points)
		};
		
		_openSet = _openSet - [_current];
		
		// Neighbors from adj
		private _neighbors = _adj select _current;
		{
			private _neighbor = _x select 0;
			private _edgeCost = _x select 1;
			
			private _tentativeG = (_gScore select _current) + _edgeCost;
			if (_tentativeG < (_gScore select _neighbor)) then {
				_cameFrom set [_neighbor, _current];
				_gScore set [_neighbor, _tentativeG];
				private _h = (_nodePos select _neighbor) distance _endASL;
				_fScore set [_neighbor, _tentativeG + _h];
				if !(_openSet find _neighbor >= 0) then {
					_openSet pushBack _neighbor;
				};
			};
		} forEach _neighbors;
	};
	
	[] // No path found
};
ai_debug_navmesharea = null;
ai_calcPath = {
	params ["_startASL","_endASL"];

	//impl
	private _bounds = [_startASL,_endASL] call ai_getNavmeshArea;
	private _navmesh = ifcheck(isNull(ai_debug_navmesharea),[_bounds] call ai_buildNavmesh,ai_debug_navmesharea);
	ai_debug_navmesharea = _navmesh;
	private _points = [_navmesh,_startASL,_endASL] call ai_astar;

	if (!isNil "ai_debug_points") then {
        { deleteVehicle _x; } forEach ai_debug_points;
        ai_debug_points = [];
    };
    ai_debug_points = [];
    private _makePoint = {
        params ["_posASL", "_progress"];
        private _o = "Sign_Arrow_F" createVehicleLocal [0,0,0];
        ai_debug_points pushBack _o;
        _o setPosASL _posASL;
        private _r = linearConversion [0,1, _progress, 0,1,true];
        private _g = 1 - _r;
        _o setObjectTexture [0, format ["#(rgb,8,8,3)color(%1,%2,0,1)", _r toFixed 2, _g toFixed 2]];
        _o
    };
	
	// Create path points visualization
	{
		private _progress = linearConversion [0, (count _points - 1), _forEachIndex, 0, 1];
		[_x, _progress] call _makePoint;
	} forEach _points;
	
	// Optional: create navmesh area points (all nodes for debug)
	if (!isNil "ai_debug_full_navmesh" && {ai_debug_full_navmesh}) then {
		private _nodePos = _navmesh select 0;
		{
			private _o = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
			_o setPosASL (_nodePos select _forEachIndex);
			_o setObjectTexture [0, "#(rgb,8,8,3)color(0,0,1,0.5)"];
			ai_debug_points pushBack _o;
		} forEach _nodePos;
		["Debug: visualized %1 full navmesh nodes", count _nodePos] call printTrace;
	};
	
	["Path calculated with %1 points", count _points] call printTrace;
	
	_points
};
