// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Здесь описаны все функции взаимодействия AI с другими объектами, в том числе движение

	Текущие ограничения:
	1. комбат с бегом приведет к незамедлительному провалу под текстуры
	2. в комбате при ходьбе персонаж не может быть уложен или посажен
	3. вращение и таргетирование не работает
*/

//=========================================================
//lowlewel functions for moving
//=========================================================

ai_moveTo = {
	params ["_mob","_pos"];
	private _actor = toActor(_mob);
	[_mob,false] call ai_setStop;
	_actor setDestination [_pos,"LEADER DIRECT",true];
};

ai_planMove = {
	params ["_mob","_destPos"];
	FHEADER;
	private _body = toActor(_mob);
	private _srcPos = getposasl _body;
	private _mapdata = getVar(_mob,__aiagent);
	private _refp = refcreate([]);
	private _path = [_srcPos,_destPos,true,_refp] call ai_nav_findPartialPath;
	if (count _path == 0) exitWith {false};

	// ПРОВЕРКА ИЗОЛИРОВАННОГО УЗЛА
	// Если путь состоит из 1 точки, проверяем, изолирован ли стартовый узел
	if (count _path == 1) then {
		private _pathNodes = refget(_refp);
		if (count _pathNodes > 0) then {
			private _startNodeId = _pathNodes select 0;
			private _neighbors = ai_nav_adjacency getOrDefault [_startNodeId, []];
			
			// Если у узла нет соседей - он изолирован
			if (count _neighbors == 0) then {
				["ISOLATED NODE DETECTED! Teleporting to nearest connected node..."] call ai_log;
				
				// Ищем ближайший узел с соседями (только в текущем и соседних регионах)
				private _bestNode = -1;
				private _bestDist = 999999;
				
				private _nearbyNodes = [_srcPos, true] call ai_nav_getNodesInRegionArea;
				
				{
					private _nodeId = _x;
					private _nodeNeighbors = ai_nav_adjacency getOrDefault [_nodeId, []];
					
					// Пропускаем изолированные узлы
					if (count _nodeNeighbors > 0) then {
						private _nodeData = ai_nav_nodes get _nodeId;
						private _nodePos = _nodeData get "pos";
						private _dist = _srcPos distance _nodePos;
						
						if (_dist < _bestDist) then {
							_bestDist = _dist;
							_bestNode = _nodeId;
						};
					};
				} forEach _nearbyNodes;
				
				// Телепортируем к ближайшему подключенному узлу
				if (_bestNode != -1) then {
					private _targetNodeData = ai_nav_nodes get _bestNode;
					private _targetPos = _targetNodeData get "pos";
					
					// Телепортация с небольшим смещением вверх
					_targetPos set [2, (_targetPos select 2) + 0.05];
					_body setPosASL _targetPos;
					
					["Teleported from isolated node to nearest connected node (dist: %1m)", (_bestDist toFixed 2)] call ai_log;
					
					// Пересчитываем путь с новой позиции
					_srcPos = getposasl _body;
					_path = [_srcPos,_destPos,true,_refp] call ai_nav_findPartialPath;
					if (count _path == 0) exitWith {RETURN(false)};
				} else {
					["ERROR: No connected nodes found in navigation mesh!"] call ai_log;
					RETURN(false);
				};
			};
		};
	};

	_mapdata set ["lastvalidpos",_path select 0];
	_mapdata set ["curpath",_path];
	_mapdata set ["targetidx",0];
	_mapdata set ["ismoving",true];

	[_mob,false] call ai_setStop;

	true
};

//обработчик движения и корректировка пути (восстановление пути, если сущность зашла в препятствие)
ai_handleMove = {
	params ["_mob"];
	private _body = toActor(_mob);
	private _mapdata = getVar(_mob,__aiagent);
	private _curidx = _mapdata get "targetidx";
	private _targetPos = (_mapdata get "curpath") select _curidx;
	private _prevPos = (_mapdata get "curpath") select ((_curidx - 1)max 0);
	[_mob,_targetPos] call ai_moveTo;

	//коррекция пути если персонаж сбился
	private _curpos = getposasl _body;
	// КОРРЕКЦИЯ ПУТИ: проверяем отклонение от отрезка
	private _maxDeviation = 0.8; // Максимальное отклонение в метрах
	
	// Находим ближайшую точку на отрезке prevPos -> targetPos
	private _closestPoint = [_prevPos, _targetPos, _curPos] call ai_getClosestPointOnSegment;
	
	// Расстояние от текущей позиции до ближайшей точки на отрезке
	private _deviation = _curPos distance _closestPoint;
	
	// Если отклонение слишком большое - телепортируем обратно на путь
	if (_deviation > _maxDeviation) then {
		// Небольшое смещение вверх чтобы не застрять в геометрии
		_closestPoint set [2, (_closestPoint select 2) + 0.01];
		_body setPosASL _closestPoint;
		
		["PATH CORRECTION: deviation %1m, teleported to segment", (_deviation toFixed 2)] call ai_log;
	};

	//todo если сущность залезла в замкнутую ноду - откатить её на предыдущую нормальную

	if (((getposasl _body) distance _targetPos) < 0.6) then {
		INC(_curidx);
		_mapdata set ["targetidx",_curidx];
		//конец пути или переход к следующей точке
		if (_curidx >= count (_mapdata get "curpath")) then {
			_mapdata set ["ismoving",false];
			[_mob,true] call ai_setStop;
			_mapdata set ["nextPlanTime",tickTime + 3];
			["TARGET REACHED"] call ai_log;
		} else {
			_mapdata set ["lastvalidpos",_targetPos];
		};
	};
};

// Вспомогательная функция: найти ближайшую точку на отрезке AB к точке P
ai_getClosestPointOnSegment = {
	params ["_pointA", "_pointB", "_pointP"];
	
	// Вектор от A к B
	private _AB = _pointB vectorDiff _pointA;
	
	// Вектор от A к P
	private _AP = _pointP vectorDiff _pointA;
	
	// Скалярное произведение AP · AB
	private _dotAP_AB = (_AP select 0) * (_AB select 0) + 
	                    (_AP select 1) * (_AB select 1) + 
	                    (_AP select 2) * (_AB select 2);
	
	// Скалярное произведение AB · AB (длина AB в квадрате)
	private _dotAB_AB = (_AB select 0) * (_AB select 0) + 
	                    (_AB select 1) * (_AB select 1) + 
	                    (_AB select 2) * (_AB select 2);
	
	// Избегаем деления на ноль (A и B совпадают)
	if (_dotAB_AB < 0.0001) exitWith {_pointA};
	
	// Параметр проекции t = (AP · AB) / (AB · AB)
	private _t = _dotAP_AB / _dotAB_AB;
	
	// Ограничиваем t в диапазоне [0, 1] чтобы остаться на отрезке
	_t = (_t max 0) min 1;
	
	// Ближайшая точка на отрезке: C = A + t * AB
	private _closestPoint = _pointA vectorAdd (_AB vectorMultiply _t);
	
	_closestPoint
};


ai_setStop = {
	params ["_mob","_stop"];
	private _actor = toActor(_mob);
	_actor stop _stop;
};

// константа режимов движения сущности
ai_internal_speedModes_names = createHashMapFromArray [
	[SPEED_MODE_WALK,"SLOW"],
	[SPEED_MODE_RUN,"NORMAL"],
	[SPEED_MODE_SPRINT,"FAST"]
];

ai_setSpeed = {
	params ["_mob","_speedMode"];
	private _actor = toActor(_mob);
	_actor forceSpeed (_actor getSpeed (ai_internal_speedModes_names get _speedMode));
};

//todo 
/*
	rotateTo
	setStance (see setUnitPos desk as playAction)

	pickupItem
	dropItem
	putdownItem
	
	setCombatMode
	setStealth

	attackTarget
	throwItem

*/