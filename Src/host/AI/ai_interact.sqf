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
	[_mob,false] call ai_internal_setStop;
	_actor setDestination [_pos,"LEADER DIRECT",true];
};

ai_planMove = {
	params ["_mob","_destPos",["_srcPosIn",null]];
	FHEADER;
	private _body = toActor(_mob);
	private _srcPos = ifcheck(isNullVar(_srcPosIn),getVar(_mob,__aiagent) getv(lastvalidpos),_srcPosIn);
	if equalTypes(_destPos,nullPtr) then {
		_destPos = atltoasl callFunc(_destPos,getPos);
	};
	private _agent = getVar(_mob,__aiagent);
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

	#ifdef AI_DEBUG_TRACEPATH
		if !isNull(ai_debug_internal_drawPathObjects) then {
			deleteVehicle ai_debug_internal_drawPathObjects;
		};
		ai_debug_internal_drawPathObjects = [];
		
		{
			private _obj = "Sign_Arrow_F" createVehicle [0,0,0];
			_obj setPosASL _x;
			ai_debug_internal_drawPathObjects pushBack _obj;
		} foreach _path;
		ai_debug_internal_drawLines = [];
		for "_i" from 0 to (count _path - 2) do {
			private _p1 = _path select _i;
			private _p2 = _path select (_i + 1);
			ai_debug_internal_drawLines pushBack [asltoatl _p1, asltoatl _p2];
		};
	#endif

	_agent setv(lastvalidpos,_path select 0);
	_agent setv(curpath,_path);
	_agent setv(targetidx,0);
	_agent setv(ismoving,true);
	private _pathTask = refcreate(false);
	_agent setv(pathTask,_pathTask);
	_agent setv(_lastPathTask,_pathTask);

	_agent setv(lastPointSetup,tickTime);

	["Move planned from %1 to %2",_srcPos,_destPos] call ai_log;

	true
};

//обработчик движения и корректировка пути (восстановление пути, если сущность зашла в препятствие)
ai_handleMove = {
	params ["_mob"];
	private _body = toActor(_mob);
	private _agent = getVar(_mob,__aiagent);
	
	// ПРОВЕРКА ПАУЗЫ НА РЕЗКОМ ПОВОРОТЕ
	private _pauseUntil = _agent getOrDefault ["pauseUntil", -1];
	if (tickTime < _pauseUntil) exitWith {};
	
	private _curidx = _agent getv(targetidx);
	private _targetPos = (_agent getv(curpath)) select _curidx;
	private _prevPos = if (_curidx > 0) then {
		(_agent getv(curpath)) select (_curidx - 1)
	} else {
		getposasl _body // Для первого сегмента используем текущую позицию
	};
	
	private _curpos = getposasl _body;
	
	// ЖЕСТКИЙ КОНТРОЛЬ ДВИЖЕНИЯ: AI должен строго следовать по пути
	private _adaptiveTarget = _targetPos;
	
	// Коррекция применяется только если есть валидный сегмент (prevPos != targetPos)
	if (_prevPos distance _targetPos > 0.1) then {
		// Находим ближайшую точку на отрезке prevPos -> targetPos
		private _closestPoint = [_prevPos, _targetPos, _curpos] call ai_getClosestPointOnSegment;
		
		// Расстояние от текущей позиции до ближайшей точки на отрезке
		private _deviation = _curpos distance _closestPoint;
		
		// ОБНОВЛЯЕМ lastvalidpos на основе прогресса по пути
		// Если отклонение разумное - используем проекцию на путь как валидную позицию
		if (_deviation < 2.0) then {
			_agent setv(lastvalidpos,_closestPoint);
		};
		
		// Пороги отклонения
		private _maxSoftDeviation = 0.4; // Начало коррекции направления
		private _maxCriticalDeviation = 2.5; // Критическое отклонение - переустановка пути
		
		if (_deviation > _maxSoftDeviation && _deviation <= _maxCriticalDeviation) then {
			// Мягкая коррекция: направляем AI к точке НА ЛИНИИ пути
			// Находим точку впереди по пути для плавного возврата на траекторию
			private _pathVector = _targetPos vectorDiff _prevPos;
			private _pathLength = vectorMagnitude _pathVector;
			
			if (_pathLength > 0.1) then {
				// Вычисляем прогресс вдоль пути (от 0 до 1)
				private _progressVector = _curpos vectorDiff _prevPos;
				private _progress = ((_progressVector select 0) * (_pathVector select 0) + 
				                     (_progressVector select 1) * (_pathVector select 1) + 
				                     (_progressVector select 2) * (_pathVector select 2)) / (_pathLength * _pathLength);
				
				// Ограничиваем прогресс в диапазоне [0, 1]
				_progress = (_progress max 0) min 1;
				
				// Целимся немного вперёд по пути (на 30% дальше от текущего прогресса к цели)
				private _targetProgress = (_progress + 0.3) min 1;
				private _correctionTarget = _prevPos vectorAdd (_pathVector vectorMultiply _targetProgress);
				_correctionTarget set [2, (_correctionTarget select 2) + 0.01];
				
				_adaptiveTarget = _correctionTarget;
				["Deviation %1m, correcting to path (progress: %2)", (_deviation toFixed 2), (_targetProgress toFixed 2)] call ai_log;
			};
		};
		
		// Критическое отклонение - полная переустановка движения
		if (_deviation > _maxCriticalDeviation) then {
			["Critical deviation %1m! Resetting movement to target", (_deviation toFixed 2)] call ai_log;
			[_mob] call ai_internal_setStop;
			// Не телепортируем, просто сбрасываем команду движения и даём новую
			_adaptiveTarget = _targetPos;
		};
	};
	
	// Применяем движение к адаптивной цели
	[_mob,_adaptiveTarget] call ai_moveTo;

	//fix nonmoving bug
	if (
		(speed _body == 0)
		&& {((_agent getv(lastPointSetup)) + 4) < tickTime}
	) then {
		["nonmoving bug detected, teleporting to targetpos"] call ai_log;
		_body setPosASL _targetPos;
	};

	// Увеличенный радиус достижения точки для предотвращения кружения
	private _reachRadius = 1.2; // было 0.6
	
	if (((getposasl _body) distance _targetPos) <= _reachRadius) then {
		#ifdef AI_DEBUG_TRACEPATH
			(ai_debug_internal_drawPathObjects select _curidx) setObjectTextureGlobal [0,"#(rgb,8,8,3)color(0,1,0,1)"];
		#endif
		INC(_curidx);
		_agent setv(lastPointSetup,tickTime);
		_agent setv(targetidx,_curidx);
		//конец пути или переход к следующей точке
		if (_curidx >= count (_agent getv(curpath))) then {
			[_mob] call ai_stopMove;
			refset(_agent getv(_lastPathTask),true); //последний путь был достигнут
			#ifdef AI_DEBUG_TRACEPATH
			_agent set ["nextPlanTime",tickTime + 3];
			#endif
			["TARGET REACHED"] call ai_log;
		} else {
			_agent setv(lastvalidpos,_targetPos);
			
			// ПРОВЕРКА РЕЗКОГО ПОВОРОТА: если следующая точка под большим углом - стопим
			private _path = _agent getv(curpath);
			
			if (_curidx < (count _path)) then {
				// После INC: _curidx указывает на следующую цель
				private _reachedPoint = _targetPos; // Только что достигнутая точка
				private _nextPoint = _path select _curidx; // Следующая цель
				
				// Вектор подхода к достигнутой точке (от предыдущей к достигнутой)
				private _vec1 = _reachedPoint vectorDiff _prevPos;
				// Вектор ухода от достигнутой точки (от достигнутой к следующей)
				private _vec2 = _nextPoint vectorDiff _reachedPoint;
				
				private _len1 = vectorMagnitude _vec1;
				private _len2 = vectorMagnitude _vec2;
				
				// Вычисляем угол между векторами
				if (_len1 > 0.1 && _len2 > 0.1) then {
					private _dot = (_vec1 select 0) * (_vec2 select 0) + 
					               (_vec1 select 1) * (_vec2 select 1) + 
					               (_vec1 select 2) * (_vec2 select 2);
					private _cosAngle = (_dot / (_len1 * _len2)) max -1 min 1;
					private _angle = acos _cosAngle;
					
					// Если угол больше 40 градусов - останавливаем и ставим на паузу
					if (_angle >= 90) then {
						["Sharp turn detected (%1°), stopping for 0.3s", (_angle toFixed 1)] call ai_log;
						[_mob] call ai_internal_setStop;
						_agent set ["pauseUntil", tickTime + 0.4]; // Пауза 300ms
					};
				};
			};
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

//внутренняя функция установки остановки сущности
ai_internal_setStop = {
	params ["_mob"];
	private _actor = toActor(_mob);
	_actor setDestination [[0,0,0],"DoNotPlan",true];
};

//высокоуровневая функция остановки сущности
ai_stopMove = {
	params ["_mob"];
	private _restoreSpeed = false;
	private _speedMode = callFunc(_mob,getSpeedMode);
	private _actor = toActor(_mob);
	// if (_speedMode >= SPEED_MODE_RUN) then {
		
	// 	//инактивные мобы не могут двигаться 
	// 	if !callFunc(_mob,isActive) exitWith {};

	// 	private _nowpnAnims = ["amovppnemstpsnonwnondnon","amovpknlmstpsnonwnondnon","amovpercmstpsnonwnondnon"];
	// 	private _wpnAnims = ["amovppnemstpsraswpstdnon","amovpknlmstpsraswpstdnon","amovpercmstpsraswpstdnon"];
	// 	private _curAnims = ifcheck(getVar(_mob,isCombatModeEnable),_wpnAnims,_nowpnAnims);
	// 	private _stances = ["PRONE","CROUCH","STAND"];
	// 	private _idxStance = _stances find (stance _actor);
	// 	if (_idxStance == -1) then {_idxStance = 0};
	// 	_actor switchmove (_curAnims select _idxStance);
	// };
	[_mob] call ai_internal_setStop;
	private _agent = getVar(_mob,__aiagent);
	_agent setv(ismoving,false);
	_agent setv(pathTask,null);

	_agent setv(lastvalidpos,getposasl _actor);
};

ai_isMovedByEngine = {
	params ["_mob"];
	private _actor = toActor(_mob);
	private _anm = animationstate _actor;
	if ("wlks" in _s)exitWith{true};
	if ("tacs" in _anm || "runs" in _anm)exitWith{true};
	if ("evas" in _anm || "sprs" in _anm)exitWith{true};
	false
};

// ============================================================================
// AI HIGH-LEVEL MOVEMENT FUNCTIONS
// ============================================================================

/*
	Отступить от цели на указанную дистанцию
	
	Параметры:
		_mob - моб который отступает
		_fromTarget - цель от которой отступаем (объект или позиция [x,y,z])
		_distance - дистанция отступления в метрах (по умолчанию 10)
	
	Возвращает:
		Позицию отступления [x,y,z]
	
	Пример:
		private _retreatPos = [_mob, _enemy, 15] call ai_retreatFrom;
		if !(_retreatPos isEqualTo []) then {
			[_mob, _retreatPos] call ai_planMove;
		};
*/
ai_retreatFrom = {
	params ["_mob","_fromTarget",["_distance",10]];
	FHEADER;
	
	private _myPos = getPosASL toActor(_mob);
	
	// Определяем позицию цели
	private _targetPos = if (typeName _fromTarget == "ARRAY") then {
		_fromTarget
	} else {
		if (equalTypes(_fromTarget,objNull)) then {
			getPosASL _fromTarget
		} else {
			// Это наш GameObject
			atltoasl callFunc(_fromTarget,getPos)
		};
	};
	
	// Вектор от цели к мобу (направление отступления)
	private _direction = _myPos vectorDiff _targetPos;
	
	// Если моб стоит прямо на цели - выбираем случайное направление
	if (vectorMagnitude _direction < 0.1) then {
		private _angle = random 360;
		_direction = [sin _angle, cos _angle, 0];
	} else {
		_direction = vectorNormalized _direction;
	};
	
	// Позиция отступления
	private _retreatPos = _myPos vectorAdd (_direction vectorMultiply _distance);
	
	RETURN(_retreatPos);
};

/*
	Найти валидную позицию для движения (ближайшую или случайную)
	
	Валидная позиция - это узел навигационного графа, который имеет соседей (связан с другими узлами)
	
	Параметры:
		_mob - моб для которого ищем позицию
		_centerPos - центральная позиция поиска [x,y,z] (опционально, по умолчанию позиция моба)
		_maxDistance - максимальная дистанция поиска в метрах (по умолчанию 30)
		_minDistance - минимальная дистанция от центра (по умолчанию 5)
		_selectRandom - выбрать случайную точку вместо ближайшей (по умолчанию false)
	
	Возвращает:
		Позицию [x,y,z] или [] если не найдено
	
	Примеры:
		// Найти ближайшую валидную точку
		private _pos = [_mob] call ai_findNearestValidPosition;
		
		// Найти СЛУЧАЙНУЮ точку в радиусе 10-50м (для патрулирования)
		private _pos = [_mob, [], 50, 10, true] call ai_findNearestValidPosition;
*/
ai_findNearestValidPosition = {
	params [
		"_mob",
		["_centerPos",[]],
		["_maxDistance",30],
		["_minDistance",5],
		["_selectRandom",false]
	];
	FHEADER;
	
	private _actor = toActor(_mob);
	
	// Если не указана центральная позиция - берём текущую позицию моба
	if (_centerPos isEqualTo []) then {
		_centerPos = getPosASL _actor;
	};
	
	// 1. Получаем текущий регион
	private _currentRegionKey = [_centerPos select 0, _centerPos select 1] call ai_nav_getRegionKey;
	
	// 2. Вычисляем сколько регионов проверять (в зависимости от maxDistance)
	// Размер региона обычно 50м, расширяем поиск
	private _regionRadius = ceil(_maxDistance / 50); // сколько регионов в каждую сторону
	
	// 3. Собираем доступные регионы в радиусе
	private _availableRegions = [];
	_currentRegionKey splitString "_" params ["_rx", "_ry"];
	_rx = parseNumber _rx; 
	_ry = parseNumber _ry;
	
	for "_dx" from -_regionRadius to _regionRadius do {
		for "_dy" from -_regionRadius to _regionRadius do {
			private _neighborKey = format ["%1_%2", _rx + _dx, _ry + _dy];
			if (_neighborKey in ai_nav_regions) then {
				_availableRegions pushBack _neighborKey;
			};
		};
	};
	
	// Fallback если нет регионов
	if (count _availableRegions == 0) exitWith {
		["No navigation regions found near position %1", _centerPos] call ai_log;
		RETURN([]);
	};
	
	// 4. Собираем все связанные узлы из всех регионов
	private _connectedNodes = [];
	{
		private _regionKey = _x;
		private _regionData = ai_nav_regions get _regionKey;
		private _nodeIds = _regionData get "nodes";
		
		// Фильтруем только узлы с соседями (связанные)
		{
			private _nodeId = _x;
			private _neighbors = ai_nav_adjacency getOrDefault [_nodeId, []];
			if (count _neighbors > 0) then {
				_connectedNodes pushBack _nodeId;
			};
		} forEach _nodeIds;
	} forEach _availableRegions;
	
	// Нет связанных узлов
	if (count _connectedNodes == 0) exitWith {
		["No connected nodes found in navigation mesh (radius: %1m)", _maxDistance] call ai_log;
		RETURN([]);
	};
	
	// 5. Выбираем узел (случайный или ближайший)
	if (_selectRandom) then {
		// СЛУЧАЙНЫЙ выбор из всех валидных узлов
		private _validNodes = [];
		
		{
			private _nodeId = _x;
			private _nodeData = ai_nav_nodes get _nodeId;
			private _nodePos = _nodeData get "pos";
			private _dist = _centerPos distance _nodePos;
			
			if (_dist >= _minDistance && _dist <= _maxDistance) then {
				_validNodes pushBack _nodePos;
			};
		} forEach _connectedNodes;
		
		if (count _validNodes == 0) exitWith {RETURN([])};
		
		RETURN(selectRandom _validNodes);
	} else {
		// БЛИЖАЙШИЙ выбор
		private _bestNode = -1;
		private _bestDist = _maxDistance + 1;
		
		{
			private _nodeId = _x;
			private _nodeData = ai_nav_nodes get _nodeId;
			private _nodePos = _nodeData get "pos";
			private _dist = _centerPos distance _nodePos;
			
			if (_dist >= _minDistance && _dist <= _maxDistance && _dist < _bestDist) then {
				_bestDist = _dist;
				_bestNode = _nodeId;
			};
		} forEach _connectedNodes;
		
		if (_bestNode == -1) exitWith {RETURN([])};
		
		private _targetNodeData = ai_nav_nodes get _bestNode;
		private _targetPos = _targetNodeData get "pos";
		
		RETURN(_targetPos);
	};
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

ai_rotateTo = {
	params ["_mob","_posOrTarget"];
	private _actor = toActor(_mob);
	if equals(_posOrTarget,nullPtr) exitWith { //!может вызывать баги анимации при сбросе
		_actor lookat objnull;
	};
	private _targetPos = if equalTypes(_posOrTarget,nullPtr) then {
		callFunc(_posOrTarget,getPos);
	} else {
		_posOrTarget;
	};
	//только если стоп не включается это будет работать
	_actor lookat _targetPos; //этой команды хватает для поворота
	// _actor glanceAt _targetPos;
	// _actor dowatch _targetPos;
};

ai_internal_stances_names = createHashMapFromArray [
	[STANCE_DOWN,"PlayerProne"], //dosent work
	[STANCE_MIDDLE,"PlayerCrouch"],
	[STANCE_UP,"PlayerStand"]
];

ai_setStance = {
	params ["_mob","_stance"];
	if equals(_stance,STANCE_DOWN) exitWith {}; //найти способ заставить моба лежать не вставая
	private _actor = toActor(_mob);
	_actor playActionNow (ai_internal_stances_names get _stance);
};

//=========================================================
// AI Low-level action functions
//=========================================================

// Атака цели
ai_attackTarget = {
	params ["_mob","_target"];
	
	if (isNullReference(_target)) exitWith {};
	
	// Включаем боевой режим если не включен
	if (!getVar(_mob,isCombatModeEnable)) then {
		callFuncParams(_mob,setCombatMode,true);
	};
	
	// Атакуем цель
	if (callFunc(_target,isMob)) then {
		callFuncParams(_mob,attackOtherMob,_target);
	} else {
		callFuncParams(_mob,attackOtherObj,_target);
	};
};

// Подобрать предмет
ai_pickupItem = {
	params ["_mob","_item"];
	
	if (isNullReference(_item)) exitWith {false};
	if (!callFunc(_item,canPickup)) exitWith {false};
	callFunc(_mob,generateLastInteractOnServer);
	callFuncParams(_mob,__setLastInteractDistance,0); //bypass check distance inside pickupitem()
	callFuncParams(_mob,pickupItem,_item);

	equals(_mob,getVar(_item,loc));
};

// Выбросить предмет
ai_dropItem = {
	params ["_mob","_item"];
	
	if (isNullReference(_item)) exitWith {false};
	//сначала проверим что предмет в активной руке
	if not_equals(callFunc(_mob,getItemInActiveHandRedirect),_item) exitWith {false};
	// Удаляем предмет из инвентаря
	callFuncParams(_mob,dropItem,getVar(_mob,activeHand));

	callFunc(_item,isInWorld)
};

// Использовать предмет 
//! пока не решено как будет использоваться
ai_useItem = {
	params ["_mob","_item"];
	
	if (isNullReference(_item)) exitWith {};
	
	// Вызываем onItemSelfClick
	callFuncParams(_item,onItemSelfClick,_mob);
};

// Занять укрытие (пока простая реализация - лечь)
ai_takeCover = {
	params ["_mob", ["_coverPos", []]];
	
	private _actor = toActor(_mob);
	
	// TODO: принять позу "лёжа" через setUnitPos или playAction
	// _actor setUnitPos "DOWN";
};

// Установить боевой режим
ai_setCombatMode = {
	params ["_mob","_enabled"];
	
	callFuncParams(_mob,setCombatMode,_enabled);
};

//todo 
/*
	putdownItem - is really needed?
	setStealth - ? maybee later
	throwItem - not now
*/