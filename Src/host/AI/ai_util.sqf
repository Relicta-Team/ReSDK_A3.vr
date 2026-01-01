// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// ================================================
// === AI Utility Helper Functions ===============
// ================================================

/**
 * Ограничение значения в диапазон [min, max]
 */
ai_clamp = {
    params ["_val","_min","_max"];
    if (_val < _min) exitWith {_min};
    if (_val > _max) exitWith {_max};
    _val
};

/**
 * Нормализация значения из диапазона [min,max] в [0..1]
 */
ai_normalize = {
    params ["_val","_min","_max"];
    private _res = (_val - _min) / ((_max - _min) max 0.00001);
    [_res,0,1] call ai_clamp
};

/**
 * Инвертированная нормализация (1 - normalize)
 */
ai_invNorm = {
    params ["_val","_min","_max"];
    1 - ([_val,_min,_max] call ai_normalize)
};

/**
 * Простая степенная кривая (x^power)
 * При power<1 усиливает чувствительность, >1 — сглаживает.
 */
ai_powCurve = {
    params ["_x","_power"];
    private _v = (_x max 0) min 1;
    _v ^ _power
};

/**
 * Sigmoid (S-образная) кривая.
 * k > 1 делает резче, < 1 — плавнее.
 */
ai_sigmoid = {
    params ["_x","_k"];
    private _v = ((_x max 0) min 1) * 12 - 6; // диапазон -6..6
    1 / (1 + exp(-_v * _k))
};

/**
 * Линейная интерполяция между A и B по t (0..1)
 */
ai_lerp = {
    params ["_a","_b","_t"];
    _a + (_b - _a) * (([_t,0,1] call ai_clamp) select 0)
};

/**
 * Комбинация множества факторов (весовое среднее)
 * пример: [[staminaN,0.5],[distN,0.3],[aggro,0.2]]
 */
ai_weightedBlend = {
    params ["_factors"];
    private _sumVal = 0;
    private _sumW = 0;
    {
        _x params ["_val","_w"];
        _sumVal = _sumVal + (_val * _w);
        _sumW = _sumW + _w;
    } forEach _factors;
    if (_sumW == 0) exitWith {0};
    _sumVal / _sumW
};

/**
 * Быстрое вычисление вероятностного выбора по softmax (мягкий максимум)
 * _temp = "температура" (0.1 = почти детерминированно, 1 = рандомно)
 */
ai_softmaxSelect = {
    params ["_values","_temp"];
    private _exp = _values apply {exp(_x / (_temp max 0.01))};
    private _sum = 0; { _sum = _sum + _x } forEach _exp;
    private _r = random _sum;
    private _acc = 0;
	private _ret = 0;
    {
        _acc = _acc + _x;
        if (_acc >= _r) exitWith {_ret = _forEachIndex};
    } forEach _exp;
    _ret
};

/**
 * Вычисляет позицию подхода к цели на заданном расстоянии
 * Параметры:
 *   _sourcePos - [x,y,z] позиция источника (откуда идём)
 *   _targetPos - [x,y,z] позиция цели (куда идём)
 *   _approachDist - число, на каком расстоянии остановиться от цели
 * Возвращает:
 *   [x,y,z] позиция для подхода
 */
ai_getApproachPosition = {
    params ["_sourcePos","_targetPos","_approachDist"];
    
    // Вектор от цели к источнику
    private _dirVector = _sourcePos vectorDiff _targetPos;
    
    // Если уже рядом - возвращаем текущую позицию цели
    private _dist = vectorMagnitude _dirVector;
    if (_dist < _approachDist) exitWith {_targetPos};
    
    // Нормализуем направление
    private _dirVectorNorm = vectorNormalized _dirVector;
    
    // Позиция на расстоянии подхода от цели
    _targetPos vectorAdd (_dirVectorNorm vectorMultiply _approachDist)
};

/**
 * Предсказывает будущую позицию движущейся цели
 * Параметры:
 *   _target - GameObject или unit (цель для предсказания)
 *   _predictionTime - число секунд для предсказания (по умолчанию 1.0)
 * Возвращает:
 *   [x,y,z] предсказанная позиция ASL
 */
ai_predictTargetPosition = {
    params ["_target",["_predictionTime",1.0]];
    
    private _actor = toActor(_target);
    private _currentPos = getposasl _actor;
    private _velocity = velocity _actor;
    
    // Если цель стоит на месте - возвращаем текущую позицию
    private _speed = vectorMagnitude _velocity;
    if (_speed < 0.1) exitWith {_currentPos};
    
    // Предсказываем позицию: текущая + (скорость × время)
    _currentPos vectorAdd (_velocity vectorMultiply _predictionTime)
};