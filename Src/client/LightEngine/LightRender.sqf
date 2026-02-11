// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! Устаревшая система скриптового отсечения света. Не используется с 0.25+

//Если пытаться зарегать источник regCustomLight с помощью initAsRenderer будет ошибка не определённого initBrightness
//так как на конфиг-объектах света нельзя изменять яркость (не скриптовый свет)
//todo doc update
#define LIGHT_RENDER_PRINT_ERROR_IF_NOT_INIT_ON_CUSTOM

// Новый алгоритм затухания и появления света. С первой легаси версии является основным способом рендеринга света
#define NEW_ALGORITHM_LIGHT_RENDERING

//как я понял расчёт по кадрам
#define BRIGHT_CHANGE_VALUE_ON_FRAME 10
//отрисовывать линии направленные вверх от локального клиента
//#define DRAW_UPPER_RENDER_LINES

// дистанция отрисовки света если локальный игрок не смотрит на него
#define LE_RENDER_DISTANCE_ONCHECK 7


#ifdef RELEASE
	#undef DRAW_UPPER_RENDER_LINES
	#undef LIGHT_RENDER_PRINT_ERROR_IF_NOT_INIT_ON_CUSTOM
#endif

//structs in type: src,lt,curview,
le_list_changevis = [];

le_initRenderer = {
	params ["_obj"];
	
	if isNull(_obj getVariable "__defBright") then {
		#ifdef LIGHT_RENDER_PRINT_ERROR_IF_NOT_INIT_ON_CUSTOM
		errorformat("le::initRenderer() - default brightness not initialized. Use initBrightness() in light config -> %1 (%2)",_obj getVariable '__config' arg _obj);
		#endif
		_obj setVariable ["__defBright",1];
	};
	
	_obj setVariable ["isRndrd",true];
	_obj setvariable ["__hasprocchangelight",false];
	le_allLights pushBack _obj;
};

le_render_findUpSide = {
	__eps = eyePos player;
	_stackZ = [];
	#define distRad 1400.5
	#define upperMax 1000
	{

		____ins = lineIntersectsSurfaces [
			__eps,
			__eps vectorAdd [_x select 0,_x select 1,upperMax],
			player,
			objNull,
			true,
			1,
			"GEOM",
			"VIEW"
		];
		if (count ____ins == 0) then {
			_stackZ pushBack ((__eps select 2) + upperMax)
		} else {
			#ifdef DRAW_UPPER_RENDER_LINES
			drawLine3D [ASLToAGL __eps, ASLToAGL (____ins select 0 select 0), [1,0,0,1]];
			#endif
			_stackZ pushBack ((ASLToATL (____ins select 0 select 0)) select 2)
		};
	} foreach [[0,0],[0,distRad],[0,-distRad],[distRad,0],[-distRad,0]];

	selectMax _stackZ;
	//if (count ____ins == 0) exitWith {__eps vectorAdd [0,0,1000]};
	//ASLToATL (____ins select 0 select 0)
};

// if _mode then do render else hide
le_addTransitionState = {
	params ["_src","_mode"];
	
	if isNullReference(_src) exitWith {};
	
	_src setvariable ["__hasprocchangelight",true];

	private __lt = _src getVariable '__light';
	private _curval = if(!_mode)then{_src getvariable "__defBright"} else {0};

	if (!isNull(_src getvariable "__procChanLtHndl")) then {
		private _idx = _src getVariable "__procChanLtHndl";
		if (isNullVar(_idx) || {_idx < 0}) exitWith {
			errorformat("le::addTransitionState() - Internal exception: (%1;%2)",isNullVar(_idx) arg _idx < 0)
		};
		//switch mode
		private _handle = le_list_changevis select _idx;
		_handle set [4,_mode];
	} else {
		//add new object listening
		private _handle = le_list_changevis pushBackUnique [_src,__lt,_curval,(_src getvariable "__defBright") / BRIGHT_CHANGE_VALUE_ON_FRAME,_mode];
		_src setvariable ["__procChanLtHndl",_handle];
	};


};

le_onupdrender = {
	//basic alg
	//#define inline_canSee(ob) (!lineIntersects [eyePos player, (ATLToASL getPosATL ob), player, ob] || (eyePos player) distance (getPosASL ob) <= 5)

	//#define inline_canSee(ob) (count (lineIntersectsSurfaces [eyePos player, ATLToASL getPosATL ob,player,ob,true,10,"VIEW","FIRE",false]) <= 4 || eyePos player distance getPosASL ob <= 4)

	//z-pos check need var _zpot, and checking LoS lights 
	//&& ((_dir > 225 && _dir <= 135) ) || player distance ob <= 8
	#define inline_canSee(ob) ((_zpot) >= ((getPosATL ob select 2)-constbias) && ((_dir > 290 || _dir <= 70) || player distance2d ob <= LE_RENDER_DISTANCE_ONCHECK))

	//range alg
	//#define __getrender(v,i) (v getvariable "rnglt" select i)
	//#define inline_canSee(ob) (_eyeZ >= __getrender(ob,0) && _eyeZ <= __getrender(ob,1))

	//simplex pos comparer
	//#define inline_canSee(ob) ((getPosATL player select 2) <= (getPosATL ob select 2))

	//algorithm checking vectorup
	//#define inline_canSee(ob) (!(call _isPotolokFinded))
/*	_isPotolokFinded = {
		__eps = eyePos player;
		____ins = lineIntersectsSurfaces [
			__eps,
			getPosASL _x,
			player,
			objNull,
			true,
			1,
			"GEOM",
			"VIEW"
		];

		if (count ____ins == 0) exitWith {false};
		_vup = ____ins select 0 select 1;
		_posasl = getPosASL _x select 2;//____ins select 0 select 0 select 2;
		_ppos = __eps select 2;
		if ((_vup select 2 )<=0 && _ppos<=_posasl) then {true} else {false}

	};*/

	//_npos = getPosATL player;
	//if equals(_npos,lastpos_cached) exitWith {};

	//lastpos_cached = _npos;

	#define constbias 0.1

	_zpot = call le_render_findUpSide;

	//если расстояние между потолком и глазами плеера меньше 0.4 то сброс рендера
	if (_zpot-(asltoatl(eyepos player) select 2) < 0.4) exitWith {};
	if (floor (_zpot-constbias) <= floor ((asltoatl eyepos player select 2))) exitWith{};
	//_eyeZ = eyepos player select 2;

	#define gvar(obj,val) (obj getvariable #val)
	#define gvardef(obj,val,def) (obj getvariable [#val,def])
	#define svar(obj,var,val) obj setvariable [#var,val]
	#define timetofadelight 0.05

	//warning("ADD check -> lightobject back to player and distance > 20");//prob can use hasObjectInScene
	// back = player getdirto object in range [100,200]
	/*
	//где стоти this по отношению к цели (this спереди _target, this за спиной у target)
		objParams_1(_target);

		private _dir = getVar(_target,owner) getRelDir getSelf(owner);

		if (_dir > 315 || _dir <= 45) exitWith {DIR_FRONT};
		if (_dir > 45 && _dir <= 135) exitWith {DIR_RIGHT};
		if (_dir > 135 && _dir <= 225) exitWith {DIR_BACK};
		if (_dir > 225 && _dir <= 315) exitWith {DIR_LEFT};

	*/
	// __defBright
	{
		_dir = player getRelDir _x;

		#ifndef NEW_ALGORITHM_LIGHT_RENDERING
		if inline_canSee(_x) then {
			if (!(_x getvariable "isRndrd")) then {
				_lt = _x getVariable "__light";
				if (!gvar(_x,__hasProcChangeLight)) then {
					svar(_x,__hasProcChangeLight,true);
					_lt attachTo [_x,[0,0,0]];
					_fadein = {
						params ["_src","_lt","_brilvl","_perFrame","_fadecode"];

						_defLt = gvar(_src,__defBright);
						_brilvl = (_brilvl + _perFrame) min _defLt;

						if (_brilvl >= _defLt) exitWith {
							_lt setLightBrightness _brilvl;

							_src setVariable ["isRndrd",true];
							svar(_src,__hasProcChangeLight,false);
						};

						_lt setLightBrightness _brilvl;

						_this set [2,_brilvl];
						invokeAfterDelayParams(_fadecode,timetofadelight / 2,_this);
					};

					invokeAfterDelayParams(_fadein,timetofadelight / 2,[_x arg _lt arg 0 arg timetofadelight / (gvar(_x,__defBright)) arg _fadein]);
				};
			};
		} else {
			if (_x getvariable ["isRndrd",true]) then {
				_lt = _x getVariable "__light";
				if (!gvar(_x,__hasProcChangeLight)) then {
					svar(_x,__hasProcChangeLight,true);
					_fadein = {
						params ["_src","_lt","_brilvl","_perFrame","_fadecode","_tick"];

						_brilvl = _brilvl - _perFrame;

						if (_brilvl < 0) exitWith {
							_lt attachTo [_src,[1000,1000,-500]];
							_src setVariable ["isRndrd",false];
							svar(_src,__hasProcChangeLight,false);
							//traceformat("changed in %1 sec max(%2)",tickTime - _tick arg gvar(_src,__defBright))
						};

						_lt setLightBrightness _brilvl;

						_this set [2,_brilvl];
						invokeAfterDelayParams(_fadecode,timetofadelight / 2,_this);
					};

					invokeAfterDelayParams(_fadein,timetofadelight / 2,[_x arg _lt arg gvar(_x,__defBright) arg timetofadelight / (gvar(_x,__defBright)) arg _fadein arg tickTime]);
				};

			};
		};
		#else


		if inline_canSee(_x) then {
			if (!(_x getvariable "isRndrd") && !(_x getvariable "__hasprocchangelight")) then {
				[_x,true] call le_addTransitionState;
			}
		} else {
			if (_x getvariable "isRndrd" && !(_x getvariable "__hasprocchangelight")) then {
				[_x,false] call le_addTransitionState;
			}
		}

		#endif
	} foreach +le_allLights;
};



le_onchangeview = {
	_hasRem = false;
	{
		_x params ["_src","_lt","_curval","_modif","_mode"];

		if (_mode) then {
			_defbr = _src getvariable ["__defBright",1];
			_curval = (_curval + _modif) min _defbr;
			_x set [2,_curval];

			_lt setLightBrightness _curval;

			if (_curval >= _defbr) exitWith {
				le_list_changevis set [_forEachIndex,objnull];
				_hasRem = true;
				_src setVariable ["isRndrd",true];
				_src setvariable ["__hasProcChangeLight",false];
				_src setvariable ["__procChanLtHndl",null];
				
				//_src hideObject false;
				//_lt hideObject false;
			};
		} else {
			_curval = _curval - _modif;
			_x set [2,_curval];
			_lt setLightBrightness _curval;

			if (_curval <= 0) exitWith {
				le_list_changevis set [_forEachIndex,objnull];
				_hasRem = true;
				_src setVariable ["isRndrd",false];
				_src setvariable ["__hasProcChangeLight",false];
				_src setvariable ["__procChanLtHndl",null];
				
				//_src hideObject true;
				//_lt hideObject true;
			};
		};
	} foreach le_list_changevis;

	if (_hasRem) then {
		le_list_changevis = le_list_changevis - [objnull];
	};
};

// initialize light renderer

#ifdef NEW_ALGORITHM_LIGHT_RENDERING
le_render_handleState = startUpdate(le_onchangeview,0);
#endif

le_render_handleUpdate = startUpdate(le_onupdrender,0);

log("LightEngine: Light renderer loaded");
