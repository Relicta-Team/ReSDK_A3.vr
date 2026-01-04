// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//Получение смещения времени
gm_getTimeOffset = {
	params [["_utcOffset", 0, [0, []], [2]], ["_utcTime", systemTime, [[]], [7]]];
	private _time = _utcTime;

	// Add Offset
	if (_utcOffset isEqualType 0) then {
		if (_utcOffset < 0) then {
			_utcOffset = abs _utcOffset;
		};
		_time set [3, _time # 3 + floor _utcOffset];
		_time set [4, _time # 4 + (_utcOffset % 1.0) * 60];
	}
	else {
		_time set [3, _time # 3 + _utcOffset # 0];
		_time set [4, _time # 4 + _utcOffset # 1];
	};

	// Minutes overflow
	_time set [3, _time # 3 + floor (_time # 4 / 60)];
	_time set [4, (_time # 4 + 60) % 60];

	// Hours overflow
	_time set [2, _time # 2 + floor (_time # 3 / 24)];
	_time set [3, (_time # 3 + 24) % 24];

	// Days overflow
	if (_time # 2 < 1) then {
		if (_time # 1 == 1) then {
			_time set [0, _time # 0 - 1];
			_time set [1, 12];
			_time set [2, 31];
		}
		else {
			_time set [1, _time # 1 - 1];
			_time set [2, call {
				if (_time # 1 in [1, 3, 5, 7, 8, 10, 12]) exitWith {31};
				if (_time # 1 in [4, 6, 9, 11]) exitWith {30};
				[28, 29] select ((_time # 0 % 4 == 0) and {(_time # 0 % 100 != 0) or (_time # 0 % 400 == 0)});
			}];
		};
	}
	else {
		if (_time # 2 > call {
			if (_time # 1 in [1, 3, 5, 7, 8, 10, 12]) exitWith {31};
			if (_time # 1 in [4, 6, 9, 11]) exitWith {30};
			[28, 29] select ((_time # 0 % 4 == 0) and {(_time # 0 % 100 != 0) or (_time # 0 % 400 == 0)});
		}) then {
			if (_time # 1 == 12) then {
				_time set [0, _time # 0 + 1];
				_time set [1, 1];
				_time set [2, 1];
			}
			else {
				_time set [1, _time # 1 + 1];
				_time set [2, 1];
			};
		};
	};

	_time;
};


gm_internal_auto_timeLoad = [__DATE_ARR__];