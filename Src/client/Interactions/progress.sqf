// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\lang.hpp"

namespace(InteractProgress,interact_progress_)

//#define PROGRESS_DEBUG
macro_const(interact_progress_sizeProgress)
#define SIZEPROG 15
macro_const(interact_progress_onePercentSize)
#define ONEPERCENTSIZE 10

macro_const(interact_progress_progressRadiusPercent)
#define PROGRADIUSPERCENT 40

macro_const(interact_progress_maxDistanceFalldown)
#define PROGRESS_MAX_DISTANCE_FALLDOWN 0.2
macro_const(interact_progress_distanceTargetFallDown)
#define PROGRESS_DISTANCE_TARGET_FALLDOWN 0.01

macro_const(interact_progress_timeToOutfadeProgress)
#define TIME_TO_OUTFADE_PROGRESS 0.000006
macro_const(interact_progress_timeToSuccessProgress)
#define TIME_TO_SUCCESS_PROGRESS 0.00003
macro_const(interact_progress_timeToAbortProgress)
#define TIME_TO_ABORT_PROGRESS 0.00001

macro_const(interact_progress_roundStep)
#define ROUNDSTEP 10
macro_func(interact_progress_getRoundCount,int())
#define ROUNDCOUNT (360 / ROUNDSTEP)

macro_func(interact_progress_override_setpos_precent_w,void(float))
#define override_setpos_precent_w(h_value) transformSizeByAR(h_value)

#ifndef DEBUG
	#undef PROGRESS_DEBUG
#endif

decl(bool)
interact_progress_hasProcessed = false;
//interact_progress_curItmIndex = 0;
	decl(int)
	interact_progress_countItms = 0; //use inline interact_progress_countItms
	//#define interact_progress_countItms 90
decl(int)
interact_progress_handleUpdate = -1;
//interact_progress_lastDelta = 0;
decl(float)
interact_progress_tick = 0;
decl(any[])
interact_progress_pData = ["",objnull]; //ref to player, and ptr to target
decl(vector3)
interact_progress_lastTargetPos = vec3(0,0,0);
decl(vector3)
interact_progress_lastPlayerPos = vec3(0,0,0);
decl(vector3)
interact_progress_lastScreenPoint = vec3(0,0,0);
//interact_progress_lastPlayerDir = 0;
	macro_const(interact_progress_maxAllowDistanceCamOffset)
	#define MAX_ALLOW_DISTANCE_CAM_OFFSET 0.01
	decl(vector3)
	interact_progress_renderPos = vec3(0,0,0);
decl(float)
interact_progress_lastProgressType = -1;

/*
	TODO:
	1. remove send to server cancel action (progress work on client only)
	2. reload progress if already processed
	3. progress token crypt
*/

//Запуск процедуры прогресса
decl(void(any;any;int;float))
interact_progress_startProg = {
	params ["_ptrPlayer","_target","_checkType","_duration"];

	/*
		_typeCheck:
		manual check: target not null, target pos not changed
			0 - dropped on moving, rotation or click client
			1 - dropped on moving or click client
			2 - dropped on moving
	*/

	interact_progress_pData = [_ptrPlayer,_target];
	if equalTypes(_target,"") then {
		_oj = noe_client_allPointers getOrDefault [_target,objNull];
		if isNullReference(_oj) then {
			//по сути не ошибка но лучше последить за условием
			warning("startProg<RPC>() - null ref target");
			_target = player;
		} else {
			_target = _oj;
		};
		interact_progress_pData set [1,_target];
	};
	interact_progress_lastTargetPos = getPosATL _target;
	interact_progress_lastPlayerPos = getPosATL player;
	//interact_progress_lastPlayerDir = getDir player;
	interact_progress_renderPos = array_copy(cam_renderpos);
	interact_progress_lastProgressType = _checkType;
		interact_progress_lastScreenPoint = positionCameraToWorld [0,0,1]; //front 1 m

	[_duration] call interact_progress_start;

}; rpcAdd("startProg",interact_progress_startProg);

//Вызов отмены прогресса
decl(void())
interact_progress_cancelProgress = {
	[false] call interact_progress_stop;
}; rpcAdd("cnclprg",interact_progress_cancelProgress);

//Проверка активности для определенных типов прогресса
/*interact_progress_checkActivity = {
	interact_progress_hasProcessed && interact_progress_lastProgressType <= 1
};*/

//if return true then falldown
decl((()=>bool)[])
interact_progress_checkDelegates = [
	{
		//INTERACT_PROGRESS_TYPE_FULL
		(getPosATL player) distance interact_progress_lastPlayerPos > PROGRESS_MAX_DISTANCE_FALLDOWN ||
		{getPosATL (interact_progress_pData select 1) distance interact_progress_lastTargetPos > PROGRESS_DISTANCE_TARGET_FALLDOWN} ||
		{interact_progress_renderPos distance (cam_renderPos) > MAX_ALLOW_DISTANCE_CAM_OFFSET}
		//{getDir player != interact_progress_lastPlayerDir}
	},
	{
		//INTERACT_PROGRESS_TYPE_MEDIUM
		(getPosATL player) distance interact_progress_lastPlayerPos > PROGRESS_MAX_DISTANCE_FALLDOWN ||
		{!(interact_progress_lastScreenPoint call interact_inScreenView)}
	},
	{
		//INTERACT_PROGRESS_TYPE_LAZY
		(getPosATL player) distance interact_progress_lastPlayerPos > PROGRESS_MAX_DISTANCE_FALLDOWN
	}
];


//Запуск функции прогресса
decl(void(float))
interact_progress_start = {
	params ["_duration"];

	if (interact_progress_hasProcessed) then {
		[false] call interact_progress_stop;
		#ifdef DEBUG
		warning("interact::progress::start() - attempt to start new progress on already existen");
		#endif
	};

	interact_progress_tick = tickTime;
	interact_progress_tickEnd = tickTime + _duration;
	//interact_progress_lastDelta = _duration / interact_progress_countItms;
	//interact_progress_curItmIndex = 0;
	interact_progress_hasProcessed = true;
	
	#ifdef PROGRESS_DEBUG
	interact_progress_debug_timestart = [tickTime,0,"<COMARE>",tickTime + _duration,_duration];
	#endif
};

decl(void())
interact_progress_onUpdate = {
	if (!interact_progress_hasProcessed) exitWith {};

	if (call (interact_progress_checkDelegates select interact_progress_lastProgressType)) exitWith {
		[true,TIME_TO_ABORT_PROGRESS] call interact_progress_stop;
	};

	_curItm = interact_progress_allItems select (linearConversion [
		interact_progress_tick,
		interact_progress_tickEnd,
		tickTime,
		0,
		interact_progress_countItms-1,
		true
	]);//interact_progress_allItems select interact_progress_curItmIndex;
	widgetFadeout(_curItm,TIME_TO_OUTFADE_PROGRESS);
	
	if (tickTime >= interact_progress_tickEnd) then {
		
		call interact_progress_success;
		#ifdef PROGRESS_DEBUG
		interact_progress_debug_timestart set [5,tickTime-(interact_progress_debug_timestart select 0)];
		interact_progress_debug_timestart set [1,tickTime];
		#endif
		
	};
};

//Прогресс выполнен
decl(void())
interact_progress_success = {
	[false,TIME_TO_SUCCESS_PROGRESS] call interact_progress_stop;
	rpcSendToServer("stprg",vec2(interact_progress_pData select 0,true));
};

//Остановка прогресса
decl(void(bool;float))
interact_progress_stop = {
	params [["_sendToServerCancellationToken",false],["_fadeValue",0]];

	if (!interact_progress_hasProcessed) exitWith {
		if (_sendToServerCancellationToken) then {
			error("interact::progress:stop() - progress already stopped");
		};
	};
	interact_progress_hasProcessed = false;
	{
		widgetFadein(_x,_fadeValue);
	} forEach interact_progress_allItems;

	if (_sendToServerCancellationToken) then {
		rpcSendToServer("stprg",vec2(interact_progress_pData select 0,false));
	};
};

//widget components and initializers
decl(vector4)
interact_progress_startColor = [0,0.427,0.298,1];
decl(vector4)
interact_progress_endColor = [0.11,0.161,0.043,1];
decl(widget[])
interact_progress_widgets = [widgetNull,widgetNull]; //ctg,text
decl(widget[])
interact_progress_allItems = [];



//initializer progress
decl(void())
interact_progress_init = {
	private _picture = PATH_PICTURE("progress\round.paa");
	private _gui = getGUI;
	_offsetW = transformSizeByAR(SIZEPROG);
	_xPos = 50 - _offsetW / 2;
	_yPos = 50 - SIZEPROG / 2;
	_ctg = [_gui,WIDGETGROUP,[_xPos,_yPos,_offsetW,SIZEPROG]] call createWidget;
	//Работа с цветами. Пояснение CT где
	//C - цвет, T - тип (s - start;e - end,c - current,p - precent)
	/*interact_progress_startColor params ["_rs","_gs","_bs"];
	interact_progress_endColor params ["_re","_ge","_be"];
	_rp = (_rs/ROUNDCOUNT)+(_re/ROUNDCOUNT);//сколько составит 1 %
	_rc = _rp; //текущее
	_gp = (_gs/ROUNDCOUNT)+(_ge/ROUNDCOUNT);
	_gc = _gp;
	_bp = (_bs/ROUNDCOUNT)+(_be/ROUNDCOUNT);
	_bc = _bp;*/
	for "_i" from 0 to 360 step ROUNDSTEP do {
		_ic = [_gui,PICTURE,WIDGET_FULLSIZE,_ctg] call createWidget;
		_xPos = 50 - ONEPERCENTSIZE/2+PROGRADIUSPERCENT*sin(_i);
		_yPos = 50 - ONEPERCENTSIZE/2+PROGRADIUSPERCENT*-cos(_i);
		[_ic,[_xPos,_yPos,/*override_setpos_precent_w <- с этим не будет кружков*/(ONEPERCENTSIZE),ONEPERCENTSIZE]] call widgetSetPosition;
		_ic ctrlSetText _picture;
		/*_ic ctrlSetTextColor vec4(_rc,_gc,_bc,1);
		modvar(_rc)+_rp;
		modvar(_gc)-_gp;
		modvar(_bc)-_bp;*/
		interact_progress_allItems pushBack _ic;
		#ifndef interact_progress_countItms
			INC(interact_progress_countItms);
		#endif
		//setfade
		widgetFadein(_ic,0);
	};

	//now text not created
	interact_progress_widgets set [0,_ctg];

	//private __supressReloadProgColors__ = true;
	//apply progress theme first time
	call interact_progress_applyColorTheme;

	interact_progress_handleUpdate = startUpdate(interact_progress_onUpdate,0);
};

decl(void())
interact_progress_applyColorTheme = {
	if !isNullVar(__supressReloadProgColors__) then {
		interact_progress_startColor = ["prog_start"] call ct_getValue;
		interact_progress_endColor = ["prog_end"] call ct_getValue;
	};
	
	//Работа с цветами. Пояснение CT где
	//C - цвет, T - тип (s - start;e - end,c - current,p - precent)
	interact_progress_startColor params ["_rs","_gs","_bs"];
	interact_progress_endColor params ["_re","_ge","_be"];
/*	_rp = (_rs/ROUNDCOUNT)+(_re/ROUNDCOUNT);//сколько составит 1 %
	_rc = _rp; //текущее
	_gp = (_gs/ROUNDCOUNT)+(_ge/ROUNDCOUNT);
	_gc = _gp;
	_bp = (_bs/ROUNDCOUNT)+(_be/ROUNDCOUNT);
	_bc = _bp;*/
	private __itm = 0;
	for "_i" from 0 to 360 step ROUNDSTEP do {
		(interact_progress_allItems select __itm) ctrlSetTextColor [
			linearConversion [360,0,_i,_rs,_re],
			linearConversion [360,0,_i,_gs,_ge],
			linearConversion [360,0,_i,_bs,_be],
			1
		];
		INC(__itm);
	};

};

call interact_progress_init;
