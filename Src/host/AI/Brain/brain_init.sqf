// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Инициализация системы ИИ

	ИИ принимает решение на основе стоимости действий. 
	Действие с самой низкой стоимостью выбирается для выполнения.

	Когда запускается цикл обновления AI - выполняется следующий алгоритм:
	1. выполняются все счетчики стоимости (baseScore + getScore) для всех действий
	2. выбирается действие с самой низкой стоимостью
	3. выбранное действие исполняет execute пока возможно
*/


//получает массив строк всех типов действий
ai_brain_getAllActionTypes = {
	["BABase"] call struct_getAllTypesOf;
};

// ============================================================================
// UTILITY AI - УПРАВЛЕНИЕ ПОВЕДЕНИЕМ
// ============================================================================

/*
	Главная функция обновления Utility AI
	Вызывается каждый кадр для каждого агента
*/
ai_brain_update = {
	params ["_mob","_agent"];

	// Обновление сенсоров
	if (tickTime >= (_agent getv(nextSensorUpdate))) then {
		_agent callv(updateSensors);
		private _sensorDelay = _agent getv(sensorUpdateDelay);
		_agent setv(nextSensorUpdate,tickTime + _sensorDelay);
	};

	// Обновление действий
	if (tickTime >= (_agent getv(nextActionUpdate))) then {
		// обновляем контекстные данные
		_agent callv(updateContext);

		private _updateDelay = _agent getv(updateDelay);
		_agent setv(nextActionUpdate,tickTime + _updateDelay);

		// Выбираем лучшее действие
		private _bestAction = [_agent,_mob] call ai_brain_selectBestAction;

		// Проверяем нужно ли переключиться
		private _currentAction = _agent getv(currentAction);
		private _needSwitch = false;

		if (isNullVar(_currentAction)) then {
			_needSwitch = true;
		} else {
			// проверяем что текущее действие не завершено/провалено
			private _state = _currentAction getv(state);
			if (_state in ["completed","failed"]) then {
				_needSwitch = true;
			} else {
				// если текущее действие running - проверяем нужно ли переключиться на лучшее
				if (!isNullVar(_bestAction) && {not_equals(_bestAction,_currentAction)}) then {
					private _currentScore = _currentAction getv(_lastScore);
					private _bestScore = _bestAction getv(_lastScore);
					// переключаемся только если новое действие значительно лучше
					if (_bestScore > (_currentScore + 10)) then {
						_needSwitch = true;
					};
				};
			};
		};

		// Переключение действия
		if (_needSwitch && !isNullVar(_bestAction)) then {
			[_agent,_mob,_currentAction,_bestAction] call ai_brain_switchAction;
			_agent setv(currentAction,_bestAction);
			_currentAction = _bestAction;
		};

		// Обновляем текущее действие
		if (!isNullVar(_currentAction)) then {
			private _state = _currentAction getv(state);
			if (_state == "running") then {
				private _result = _currentAction callp(onUpdate,_agent);
				
				// UPDATE_STATE_COMPLETED (1) - действие успешно завершено
				if (_result == UPDATE_STATE_COMPLETED) then {
					_currentAction setv(state,"completed");
					_currentAction callp(onCompleted,_agent);
				};
				
				// UPDATE_STATE_FAILED (-1) - действие провалено
				if (_result == UPDATE_STATE_FAILED) then {
					_currentAction setv(state,"failed");
					_currentAction callp(onFailed,_agent);
				};
				
				// UPDATE_STATE_CONTINUE (0) - продолжаем выполнение (ничего не делаем)
			};
		};
	};
};

/*
	Выбирает лучшее действие на основе score
	Возвращает действие с максимальным score или null
*/
ai_brain_selectBestAction = {
	params ["_agent","_mob"];

	private _possibleActions = _agent getv(possibleActions);
	if (count _possibleActions == 0) exitWith {null};

	private _bestAction = null;
	private _bestScore = -999999;

	{
		private _action = _x;
		
		if !(_action callp(isAvailable,_agent)) then {continue};

		private _baseScore = _action getv(baseScore);
		private _modifier = _action callp(getScore,_agent);
		private _totalScore = _baseScore + _modifier;

		_action setv(_lastScore,_totalScore);

		if (_totalScore > _bestScore) then {
			_bestScore = _totalScore;
			_bestAction = _action;
		};
	} foreach _possibleActions;

	_bestAction
};

/*
	Переключает действие со старого на новое
	Вызывает соответствующие события
*/
ai_brain_switchAction = {
	params ["_agent","_mob","_oldAction","_newAction"];

	// Завершаем старое действие
	if (!isNullVar(_oldAction)) then {
		// private _state = _oldAction getv(state);
		// if (_state == "running") then {
		// 	_oldAction setv(state,"completed");
		// 	_oldAction callp(onCompleted,_agent arg _mob);
		// } else {
		// 	if (_state == "failed") then {
		// 		_oldAction callp(onFailed,_agent arg _mob);
		// 	};
		// };
		_oldAction setv(state,"idle");
	};

	// Запускаем новое действие
	if (!isNullVar(_newAction)) then {
		_newAction setv(state,"running");
		_newAction callp(onStart,_agent);
	};
};