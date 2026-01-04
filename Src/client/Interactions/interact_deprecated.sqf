// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractDeprecated,interact_)

// TODO remove this file

//позиция достаточно близка чтобы тронуть рукой
decl(bool(any;float))
interact_canHandReach = {
	OBSOLETE(interact::canHandReach);
	params ["_pos2",["_dopDist",0]];
	private _playerPos = getCenterMobPos(player);
	private _posFact = if equalTypes(_pos2,objNUll) then {getPosATL _pos2} else {_pos2};
	private _dist = _playerPos distance _posFact;

	//fix bigobjects 0.8.65
	if equalTypes(_pos2,objNUll) then {
		private _bbr = boundingBoxReal _pos2;
		_dist = _dist - ((_bbr select 2) / 2);
	};

	if (_dist <= (INTERACT_ITEM_DISTANCE + _dopDist)) exitWith {true};
	false
};

// видно ли объект
decl(bool())
interact_canSeeObject = {
	OBSOLETE(interact::canSeeObject);
	FHEADER;
	/*

	//для отладки цели
	onEachFrame {
		systemChat str (targ call interact_canSeeObject);
		drawLine3D [ASLToATL eyepos player,(getPosATL targ) ,[1,0,0,1]];
		[[targ]] call BIS_fnc_drawBoundingBox;
		drawLine3D [ASLToATL eyepos player,(getPosATL targ) vectorAdd [0,0,boundingCenter targ select 2] ,[1,0,0,1]];
		[[targ]] call BIS_fnc_drawBoundingBox;
		drawLine3D [ASLToATL eyepos player,(getPosATL targ) vectorAdd [0,0,(boundingCenter targ select 2) * 2] ,[1,0,0,1]];
		[[targ]] call BIS_fnc_drawBoundingBox;
	};

	*/
	private _target = _this;
	private _unit = player;

	private _endPos = if (typeof _target == BASIC_MOB_TYPE) then {
		if(lineIntersects [eyePos _unit, eyePos _target, _unit, _target]) exitWith {
			//logformat("(mob) 1 pass false -> %1",lineIntersectsWith [eyePos _unit arg eyePos _target arg _unit arg _target]);
			RETURN(false);
		};

		ATLToASL (getCenterMobPos(_target)) //to main scope
	} else {
		private _startPos = eyePos _unit;
		private _t1 = getposasl _target;
		private _centerZ = (boundingCenter _target) select 2;

		//debug
		/*#define nonSee(ind) _pass##ind
		_pass1 = lineIntersects [_startPos, _t1, _unit, _target];
		_pass2 = lineIntersects [_startPos, _t1 vectoradd [0,0,_centerZ], _unit, _target];
		_pass3 = lineIntersects [_startPos, _t1 vectoradd [0,0,_centerZ * 2], _unit, _target];

		if (nonSee(1) && nonSee(2) && nonSee(3)) exitWith {
			logformat("non see target - %1 : passes [%2,%3,%4]",lineIntersectsWith [eyePos _unit arg _t1 arg _unit arg _target] select 0
			arg _pass1 arg _pass2 arg _pass3);
			RETURN(false);
		};*/

		if (
			lineIntersects [_startPos, _t1, _unit, _target] &&
			lineIntersects [_startPos, _t1 vectoradd [0,0,_centerZ], _unit, _target] &&
			lineIntersects [_startPos, _t1 vectoradd [0,0,_centerZ * 2], _unit, _target]
			) exitWith {
			//logformat("(obj) 1 pass false -> %1",lineIntersectsWith [eyePos _unit arg _t1 arg _unit arg _target]);
			RETURN(false);
		};

		_t1
	};

 	//Находится в поле зрения
	if([getPosATL _unit, getdir _unit, 90, getPosATL _target] call BIS_fnc_inAngleSector) exitWith {true};

	//log("end pass false");
	//не находится
	false
};

decl(widget[])
interact_debug_viswidgets = [];
//#define useviswidgets

decl(bool(actor))
interact_canSeeMob_handReach = {
	OBSOLETE(interact::canSeeMob_handReach);
	private _target = _this;
	private _unit = player;

	inline_macro
	#define mlp(selection) #selection

	private _selectionsNames= [
		mlp(neck),
		mlp(head),
		mlp(spine3),
		mlp(spine2),
		mlp(pelvis),
		//right side
		mlp(rightshoulder),
		mlp(rightforearmroll),
		mlp(rightforearm),
		mlp(rightupleg),
		mlp(rightleg),
		mlp(rightfoot),
		//left side
		mlp(leftshoulder),
		mlp(leftforearmroll),
		mlp(leftforearm),
		mlp(leftupleg),
		mlp(leftleg),
		mlp(leftfoot)
	];
	private _selectionsOnScreen = [];

	private _pos = 0;
	{
		_pos = _target modelToWorld (_target selectionPosition _x);
		_selectionsOnScreen pushBack [worldToScreen _pos,(ASLToAGL eyepos _unit) distance _pos];
	} foreach _selectionsNames;

	#ifdef useviswidgets
		{ctrlDelete _x} foreach interact_debug_viswidgets;
		interact_debug_viswidgets = [];
	#endif

	private _canEscape = -1;
	private ["_h","_w","_npos","_distCheck"];
	{
		if (!((_x select 0) isequalto [])) then {
			_npos = ((_x select 0) call convertScreenCoords);

		#ifdef useviswidgets
			_h = 20 / (_x select 1);
			_w = getWidthByHeightToSquare(_h);
			_npos append [_w, _h];
			MODARR(_npos,0,-_w / 2);
			MODARR(_npos,1,-_h /2);


			_wd = [getDisplay,TEXT,_npos] call createWidget;
			_wd setBackgroundColor [1,0,0,1];
			[_wd,format["<t size='0.7'>%1</t>",(_x select 1)]] call widgetSetText;

			interact_debug_viswidgets pushback _wd;

			if (_wd call isMouseInsideWidget) exitWith {
				_canEscape = _forEachindex;
			};
		#else

			_h = (20 / (_x select 1));
			_w = getWidthByHeightToSquare(_h);
			_npos append [_w, _h];
			MODARR(_npos,0,-_w / 2);
			MODARR(_npos,1,-_h /2);
			_npos set [2,(_npos select 0) + _w];
			_npos set [3,(_npos select 1) + _h];

			if (_npos call isMouseInsidePosition) exitWith {
				_canEscape = _forEachindex;
				_distCheck = _x select 1;
			};

		#endif
		};
		if (_canEscape != -1) exitWith {};

	} foreach _selectionsOnScreen;

	if (_canEscape != -1) exitWith {

		//post check intersections
		if(lineIntersects [eyePos _unit, AGLToASL (_target modelToWorld (_target selectionPosition (_selectionsNames select _canEscape))), _unit, _target]) then {
			false;
		} else {
			//logformat("Dist check %1; NEED %2",_distCheck arg INTERACT_MOB_DISTANCE);
			if (_distCheck <= INTERACT_MOB_DISTANCE) then {true} else {false}
		};
	};

	false
};

decl(vector3(actor))
interact_findNearPosMob = {
	OBSOLETE(interact::findNearPosMob);
	inline_macro
	#define mlp(selection) #selection

	//TODO переименовать функцию и сделать выборку из самых ближайших позиций к центру экрана через worldToScreen

	private _target = _this;

	private _selectionsNames= [
		mlp(nvg),
		mlp(neck),
		mlp(head),
		mlp(spine3),
		mlp(spine2),
		mlp(pelvis),
		//right side
		mlp(rightshoulder),
		mlp(rightforearmroll),
		mlp(rightforearm),
		mlp(righthandmiddle3),
		mlp(rightupleg),
		mlp(rightleg),
		mlp(rightfoot),
		//left side
		mlp(leftshoulder),
		mlp(leftforearmroll),
		mlp(leftforearm),
		mlp(lefthandmiddle3),
		mlp(leftupleg),
		mlp(leftleg),
		mlp(leftfoot)
	];

	private _dist = 0;
	private _pos = [0,0,0];
	private _posList = [];
	private _selList = [];
	private _unitPos = ASLToATL eyePos player;
	{
		_pos = _target modelToWorld (_target selectionPosition _x);

		((worldToScreen _pos) call convertScreenCoords) params ["_mx","_my"];

		if ((_mx >= 0 && _mx < 100) && (_my >= 0 && _my < 100)) then {
			_selList pushBack _pos;
			// дополнительно можно искать ближайшую к центру экрана точку
			_posList pushBack (_unitPos distance _pos); //([_mx,_my] distance2D [50,50])
		};

	} foreach _selectionsNames;

	private _nearDist = selectMin _posList;
	private _index = _posList find _nearDist;
	if (_index == -1) exitWith {[0,0,0]};
	_selList select _index
};

//Отладочная отрисовка геометрии (снижает производительность в несколько раз)
//#define DEBUG_ALLOW_DRAW_BBX
macro_const(interact_debugFlag_drawBBX)
#define DEBUG_DRAW_BBX_DISTANCE 10

#ifndef DEBUG
	#undef DEBUG_ALLOW_DRAW_BBX
#endif

#ifdef DEBUG_ALLOW_DRAW_BBX
decl(void())
interact_debug_drawBBX = {
	{
		_x call interact_debug_internal_drawBBXObject;
	} foreach (player nearObjects DEBUG_DRAW_BBX_DISTANCE);
};
decl(any[]())
interact_debug_unboxDecal = {
	_o = call interact_cursorobject;
	[_o,_o getVariable "ngo_src"];
};

decl(void(mesh))
interact_debug_internal_drawBBXObject = {
	_obj = _this;
	_bbxGlob = boundingBoxReal _obj;
	_bbx = [_bbxGlob select 0 select 0, _bbxGlob select 1 select 0];
	_bby = [_bbxGlob select 0 select 1, _bbxGlob select 1 select 1];
	_bbz = [_bbxGlob select 0 select 2, _bbxGlob select 1 select 2];
	_arr = [];
	0 = {
		_y = _x;
		0 = {
			_z = _x;
			0 = {
				0 = _arr pushBack (_obj modelToWorld [_x,_y,_z]);
			} count _bbx;
		} count _bbz;
		reverse _bbz;
	} count _bby;
	_arr pushBack (_arr select 0);
	_arr pushBack (_arr select 1);
	//_arr
	for "_i" from 0 to 7 step 2 do {
		drawLine3D [
			_arr select _i,
			_arr select (_i + 2),
			[0,1,0,1]
		];
		drawLine3D [
			_arr select (_i + 2),
			_arr select (_i + 3),
			[0,1,0,1]
		];
		drawLine3D [
			_arr select (_i + 3),
			_arr select (_i + 1),
			[0,1,0,1]
		];
	};
};

#endif
#ifdef DEBUG_ALLOW_DRAW_BBX
startUpdate(interact_debug_drawBBX,0);
#endif
