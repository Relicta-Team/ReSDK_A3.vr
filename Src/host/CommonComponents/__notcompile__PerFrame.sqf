// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

pf_hash = createHashMap;

#define PF_IND_CODE 0
#define PF_IND_DELAY 1
#define PF_IND_ARGS 2
#define PF_IND_DISPOSE 3
/*
	PF_IND_CALLCOUNTS 4 (для вызовов единожды или n раз)
	PF_IND_META 5 (creationTime)


*/


#define sizeofnum 1
#define fixed(num) (num toFixed sizeofnum)
#define fixnum(num) (parseNumber fixed(num))


__onPerFrameCode = {
	pf_tick = fixnum(tickTime);

	_toDispos = [];

	#define _mapval _y
	{
		_delta = _x;
		if (tickTime > _delta) then {
			{
				_nt = _delta + (_x select PF_IND_DELAY);
				(_x select PF_IND_ARGS) call (_x select PF_IND_CODE);

				_ndat = pf_hash get _nt;
				if isNullVar(_ndat) then {
					//pf_hash insert [[_nt,[_x]]];
					pf_hash set [_nt,[_x]];
				} else {
					pf_hash pushback _x;
				};
			} foreach _mapval;

			_toDispos pushBack _delta;
		};
	} foreach pf_hash;

	if (count _toDispos > 0) then {
		{
			pf_hash deleteAt _x
		} foreach _toDispos;
	};

/* // Числа с высокой точностью вызывают ошибку с переполнением стека
	if (!isNullVar(_tdat)) then {
		{
			if (!(_x select PF_IND_DISPOSE)) then {


				_nt = tickTime + (_x select PF_IND_DELAY);
				_ndat = pf_hash get _nt;

				// обновляем стек следующего кадра
				if isNullVar(_ndat) then {
					pf_hash set [_nt,[_x]];
				} else {
					_ndat pushBack _x;
				};

				(_x select PF_IND_ARGS) call (_x select PF_IND_CODE);
			};
		} foreach _tdat;

		pf_hash deleteAt _t;
	};
*/
	//todo start thread for checking all keys (less than tickTime)
};
onEachFrame __onPerFrameCode;

pf_addTimer = {
	params ["_code","_delay","_args"];

	private _stamp = tickTime;
	private _seg = pf_hash get _stamp;

	private _struct = [_code,_delay,_args,false];
	if (isNullVar(_seg)) then {
		_seg = [_struct];
		pf_hash set [_stamp,_seg];
	} else {
		_seg pushback _struct
	};
};

pf_removeTimer = {
	private _handle = _this;

	_handle set [PF_IND_DISPOSE,true];
};


pf_changeTimerInterval = {
	params ["_handle","_newDelay"];
	_handle set [PF_IND_DELAY,_newDelay];
};

pf_performanceTest = {
	params [["_isPF",false],["_amounter",1000],["_delay",0.1]];

	if (_isPF) then {

		[{pf_debug_starttime = tickTime},_delay] call pf_addTimer;

		for "_i" from 0 to _amounter do {
			[{systemChat str 9999999999},_delay] call pf_addTimer;
		};

		[{traceformat("PERFORMANCE NEWPF - %1 sec",tickTime - pf_debug_starttime)},_delay] call pf_addTimer;

	} else {

		startUpdate({pf_debug_starttime = tickTime},_delay);

		for "_i" from 0 to _amounter do {
			startUpdate({systemChat str 9999999999},_delay);
		};

		startUpdate({traceformat("PERFORMANCE OLDPF - %1 sec",tickTime - pf_debug_starttime)},_delay);

	};

};
if (true) exitWith {};
////============ NEW IMPL FOR REGULAR TICK=============
/*
	1. queue checkout (main queue):

		adding(code,delay)
			if (hashmap get delay == null)
				hashmap set [delay,[code]]
			else
				(hashmap get delay) push [code]

		Результат - потеря производительности при добавлении обработчиков с одинаковым временем задержки.

	2. gobj rnd shuffle


		adding(code,delay)

			deltatime = [sqf]ticktime + [prep]rand(0,2);

			if (hashmap get delay == null)
				hashmap set [deltatime,[code,delay]]
			else
				(hashmap get deltatime) push [code,delay]


		onframe()




*/



// 	CUSTOM PERFRAME (DO NOT COMPILE)


#define PF_IND_CODE 0
#define PF_IND_DELAY 1
#define PF_IND_ARGS 2
#define PF_IND_DISPOS 3

#define pointfloat 2
#define fixefize(numb) (numb toFixed pointfloat)
#define fixefize(numb) numb

pf_hash = createHashMap;


__onframe = {
	/*_t = fixefize(tickTime);
	_ht = pf_hash get _t;
	//trace("pass" +str fixefize(tickTime))
	if (!isNullVar(_ht)) then {
		//trace("nonnull")
		_narr = [];
		{
			if (!(_x select PF_IND_DISPOS)) then {
				(_x select PF_IND_ARGS) call (_x select PF_IND_CODE);
				
				_t_nw = fixefize(tickTime + (_x select PF_IND_DELAY));
				_ht_nw = pf_hash get _t_nw;
				
				if (isNullVar(_ht_nw)) then {
					pf_hash set [_t_nw,[_x]];
				} else {
					_ht_nw pushBack _x;
				};
				
			};
		} forEach _ht;
		
		pf_hash deleteAt _t;
	};*/
	pf_debug_time = tickTime;
	_disposList = []; _tempHM =createHashMap;
	{
		if (_x >= tickTime) then {
			_disposList pushBack _x;
			_curTime = _x;
			
			{
				if (!(_x select PF_IND_DISPOS)) then {
					(_x select PF_IND_ARGS) call (_x select PF_IND_CODE);
					
					_t_nw = fixefize(tickTime + (_x select PF_IND_DELAY));
					_ht_nw = _tempHM get _t_nw;
					
					if (isNullVar(_ht_nw)) then {
						//pf_hash set [_t_nw,[_x]];
						_tempHM set [_t_nw,[_x]];
					} else {
						_ht_nw pushBack _x;
					};
					
				};
			} forEach _y;
		};
	} foreach pf_hash;
	
	{
		pf_hash deleteAt _x;
	} foreach _disposList;
	if (count _tempHM > 0) then {
		pf_hash merge _tempHM;
	};
	//if (count _disposList > 0) then {warningformat("Disposed %1 objects",count _disposList)};
	
}; onEachFrame __onframe;

pf_add = {
	params ["_code","_delay",["_args",0]];
	
	private _t = fixefize(tickTime + _delay);
	private _ht = pf_hash get _t;
	
	if (isNullVar(_ht)) then {
		pf_hash set [_t,[[_code,_delay,_args,false]]];
	} else {
		_ht pushBack [_code,_delay,_args,false];
	};
};

pf_getworks = {
	_c = 0;
	{
		_c = _c + (count(pf_hash get _x));
	} foreach (keys pf_hash);
	
	_c
};

pf_test = {
	params ["_isHashed","_counter"];
	#define maxtime 5
	if (_isHashed) then {
		[{pf_debug_time = tickTime},0.1] call pf_add;
		
		for "_i" from 0 to _counter do {
			[{a = 1; b = 2; c = 3;},rand(1,maxtime)] call pf_add;
		};
		//[{systemChat ("timing PF - " + str (tickTime - pf_debug_time))},1] call pf_add;
		[{traceformat("timing PF - %1",tickTime - pf_debug_time)},1] call pf_add;
	} else {
		[{pf_debug_time = tickTime},0.1] call CBA_fnc_addPerFrameHandler;
		
		for "_i" from 0 to _counter do {
			[{a = 1; b = 2; c = 3;},rand(1,maxtime)] call CBA_fnc_addPerFrameHandler;
		};
		[{traceformat("timing PF - %1",tickTime - pf_debug_time)},1] call CBA_fnc_addPerFrameHandler;
	};
};