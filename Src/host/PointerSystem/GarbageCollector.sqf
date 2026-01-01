// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\thread.hpp>

/*
	Очистка мусора
*/

gc_onUpdate = {
	_lastCount = 0;
	_curCount = 0;
	_t = 0;
	while {true} do {
		_curCount = count pointerList;
		if (_curCount != _lastCount) then {
			_t = tickTime;
			call gc_collect;
			_lastCount = _curCount;
			logformat("GC::ONUPDATE -> Collect process %1 objects by %2 sec",_curCount arg tickTime - _t);
			threadSleep(30);
		};
	};
};

gc_collect = {
	private _remList = [];
	private _varname = 'qdel_isdeleted';
	{
		if !isNull(_y getVariable _varname) then {
			_remList pushBack _x;
			delete(_y);
			continue;
		};
		if equals(_y,nullPtr) then {
			_remList pushBack _x;
		};
	} foreach pointerList;

	{
		pointerList deleteAt _x
	} foreach _remList;
};




// starting thread update
threadStart(threadNew(gc_onUpdate));
