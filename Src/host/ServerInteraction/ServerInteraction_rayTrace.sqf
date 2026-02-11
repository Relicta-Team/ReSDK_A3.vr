// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"

/* 
	Бросок луча от текущего объекта и возвращение информации о первом пересечении. 
	Процесс просчитывается моментально без задержек.
	Возвращает: [GameObject, intersect position as ATL,vectorUp lod]
		Никогда не возвращает нулевые координаты. Если результат трейса неуспешен - вернёт начальную позицию/объект
	Примеры использования:
		- фрагменты осколков разрыва гранаты
		- разлет осколков при разрушении объекта
*/
//#define SI_RAYTRACE_DEBUG

//#define SI_RAYTRACE_DEBUG_LINES

#ifndef EDITOR
	#undef SI_RAYTRACE_DEBUG_LINES
	#undef SI_RAYTRACE_DEBUG
#endif

#ifdef SI_RAYTRACE_DEBUG
	#define rtdbg(val,arg_) traceformat("RTDBG: %1", format[val arg arg_])
#else
	#define rtdbg(val,arg_)
#endif


//_force - не рекомендуется больше 10
si_rayTraceProcess = {
	params ["_vobj","_pstart","_vecDirect","_force",["_precdownIn",70],["_leveldownIn",0.1],["_ignoredObjects",[]]];
	
	private _c_defaultRet = [_vobj,_pstart,[0,0,1]];
	private _ignoredObjectsReal = [];

	{
		if callFunc(_x,isInWorld) then {
			_ignoredObjectsReal pushBack getVar(_x,loc);
		};
		;false
	} count _ignoredObjects;

	traceformat("REAL IGNORED OBJECTS: %1",_ignoredObjectsReal);

	private _rtObj = si_internal_rayObject;
	
	private _model = getVar(_vobj,model);
	private _bbx = core_modelBBX get _model;
	if isNullVar(_bbx) then {
		_rtObj = createMesh([_model arg [50 arg 50 arg 50] arg true]);
		#ifndef EDITOR
		_rtObj hideObject true;
		#endif
		_bbx = boundingBoxReal _rtObj;
		warningformat("si::rayTraceProcess() - Cant find bbx data for model %1",_model)
	};

	_rtObj setPosAtl _pstart;
	// 						[(-90,90),0,0-360]
	_rtObj setVectorDirAndUp ([_vecDirect select 0,0,_vecDirect select 1] call model_convertPithBankYawToVec);
	private _rayDist = _force;
	private _precdown = _precdownIn;//через какое расстояние объект потеряет направление
	private _leveldown = _leveldownIn;//на сколько сильно отклонится объект при потере направления
	
	(_bbx select 0) params ["_b1","","_b2"];
	private _bbxCheck = [[_b1,0,_b2],[-_b1,0,_b2],[_b1,0,-_b2],[-_b1,0,-_b2]];
	
	#ifdef SI_RAYTRACE_DEBUG
	private _debug_slist = [];
	private _allIntersections_debug = [];
	private _sph = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
	_sph setposatl _pstart;
	_debug_slist pushBack _sph;
	#endif

	private _oldPos = _pstart;
	private _newPos = null;

	//функция генерации точек
	private _buildPoints = {
		params ["_bpos"];
		private _ep = _rtObj modelToWorld [0,_rayDist,0];
		MODARR(_ep,2,/_precdown);
		#ifdef SI_RAYTRACE_DEBUG
		private _r = 
		#endif
		[
			_rtObj modelToWorld [0,0,0],
			_rtObj modelToWorld [0,_rayDist*_precdown/100,_leveldown],
			_ep
		];
		#ifdef SI_RAYTRACE_DEBUG
		{
			_sph = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
			_sph setposatl _x;
			_sph setObjectTexture [0,"#(rgb,8,8,3)color(1,0,1,1)"];
			_debug_slist pushBack _sph;
		} foreach _r;
		_r
		#endif
	};

	private _points = call _buildPoints;
	//? (0-1) bezierInterpolation _points

	//проверка каждые SI_RAYTRACE_CHECK_DISTANCE метров
	#define SI_RAYTRACE_CHECK_DISTANCE 0.01

	private _ipt = 0;
	private _finalized = false;
	private _iDat = null;
	private _iDatObj = objNull;
	
	#ifdef SI_RAYTRACE_DEBUG_LINES
		private _batcher_debug = [];
		private _lineSize_dbg = 7;
		#define linesize(newsize) _lineSize_dbg = newsize;
		#define addline(p1,p2,clr) _a_dbg = [0,0,0,1]; _a_dbg set [clr,1];_batcher_debug pushBack [p1,p2,_a_dbg,_lineSize_dbg]; _lineSize_dbg = 7;
	#else
		#define addline(p1,p2,clr)
		#define linesize(n)
	#endif

	for "_i" from SI_RAYTRACE_CHECK_DISTANCE to _rayDist step SI_RAYTRACE_CHECK_DISTANCE do {
		_ipt = linearConversion [0,_rayDist,_i,0,1,true];
		//INC(_incSaved);
		
		rtdbg("[%1] pass start",_i)

		_newPos = _ipt bezierInterpolation _points;

		#ifdef SI_RAYTRACE_DEBUG
		_sph = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		_sph setposatl _newPos;
		_sph setVectorUp (vectorNormalized (_oldPos vectorDiff _newPos  ) vectorMultiply 1);
		_debug_slist pushBack _sph;
		#endif
		
		

		_iDat = [_oldPos,_newPos,_rtObj] call si_getIntersectData;

		addline(_oldPos,_newPos,ifcheck(isNullReference(_iDat select 0),1,0));
		if isNullReference(_iDat select 0) then {
			rtdbg("	[%1] null idat. check bounds",_i)
			private _prePos = _oldPos vectorDiff _newPos;
			{
				_iDat = [
					_newPos,
					_rtObj modelToWorld _x,
					//_rtObj modelToWorld (_x vectorAdd _prePos),
					_rtObj
				] call si_getIntersectData;
				_iDatObj = _iDat select 0;

				#ifdef EDITOR
				_allIntersections_debug pushBackUnique _iDatObj;
				//remove clientside objects
				if !isNull(_iDatObj getvariable "ref") then {_iDatObj = pointerList get (_iDatObj getvariable "ref") getvariable "loc"; _iDat set [0,_iDatObj];};
				#endif
				if (count _ignoredObjectsReal > 0 && {array_exists(_ignoredObjectsReal,_iDatObj)}) then {
					_iDatObj = objNull;
					_iDat set [0,objNull];
					_iDat select 2 set [2,1];
				};

				rtdbg("	[%1] bound check null:%2 vars:%3",_i arg isNullReference(_iDatObj) arg allVariables _iDatObj)

				if !isNullReference(_iDatObj) exitWith {
					linesize(10)
					addline(_rtObj modelToWorld _x,_newPos,0)
				};
				addline(_rtObj modelToWorld _x,_newPos,1)
			} foreach _bbxCheck;
		};

		// #ifdef EDITOR
		// if !isNullReference(_iDat select 0) then {
		// 	if !isNull(_iDat select 0 getvariable "ref") then {
		// 		traceformat("Skipped clientside object ref %1",_iDat select 0 getvariable "ref")
		// 		_o = _iDat select 0;
		// 		_o hideObject true;
		// 		_iDat set [0,objNull];
		// 		_iDat set [2,[0,0,1]];
		// 		invokeAfterDelayParams({(_this select 0) hideObject false},0.01,[_o]);
		// 	};
		// };
		// #endif
		_iDatObj = _iDat select 0;

		#ifdef EDITOR
		//remove clientside objects
		if !isNull(_iDatObj getvariable "ref") then {_iDatObj = pointerList get (_iDatObj getvariable "ref") getvariable "loc"; _iDat set [0,_iDatObj];};
		#endif
		if (count _ignoredObjectsReal > 0 && {array_exists(_ignoredObjectsReal,_iDatObj)}) then {
			_iDatObj = objNull;
			_iDat set [0,objNull];
			_iDat select 2 set [2,1];
		};

		rtdbg("	[%1] lagcheck null:%2 vars:%3; idatref:%4 | varref:%5",_i arg isNullReference(_iDatObj) arg allVariables _iDatObj arg _iDat select 0 arg _iDatObj)

		//_angle = (vectorNormalized (_oldPos vectorFromTo _newPos)) select 2;//_iDat select 2 select 2;
		_hasMoving = isNullReference(_iDatObj);//(_oldPos distance _newPos) > 0.01;
		_angle = ((vectorNormalized (_oldPos vectorFromTo _newPos)) select 2);//-1 because inversed
		//traceformat("PRECHECK ANGLE %1 (move:%2)",_angle arg _hasMoving)
		if (_angle < 0.65 && !_hasMoving) then {
			traceformat("INTERSECT ANGLE %1 [%2] -> %3",_angle arg _iDat select 0 arg allVariables (_iDat select 0))
			traceformat("POSESE (from start to end): %1 %2 (%3)",_oldPos arg _newPos arg _iDat select 1)
			
			linesize(18) addline(_oldPos,_newPos,2)
			//отскок объекта
			
			_iDat = [_oldPos,_oldPos vectorAdd [0,0,-1000]] call si_getIntersectData;
			break;
		};
		
		if !isNullReference(_iDatObj) exitWith {}; //todo replace before angle check
		
		rtdbg("	[%1] no intersect <<<",_i)
		
		_rtObj setPosAtl _newPos;
		_rtObj setVectorUp (vectorNormalized (_oldPos vectorDiff _newPos) vectorMultiply 1);
		_oldPos = _newPos;
	};
	
	

	#ifdef SI_RAYTRACE_DEBUG
	traceformat("Intersections: %1",_allIntersections_debug)
	si_raytrace_internal_debug_itObjects = _allIntersections_debug;
	_sph = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
	_sph setposatl ifcheck(!isNullVar(_iDat) && {!isNullReference(_iDat select 0)},_iDat select 1,_oldPos);
	_debug_slist pushBack _sph;

	(_debug_slist select -1) setObjectTexture [0,"#(rgb,8,8,3)color(0,1,0,1)"];
	invokeAfterDelayParams({{deletevehicle _x}foreach _this},4,_debug_slist);
	#endif

	#ifdef SI_RAYTRACE_DEBUG_LINES
	startAsyncInvoke
	{ 
		{drawLine3d _x} foreach (_this select 0);
		false
	},{},[_batcher_debug],6,{}
	endAsyncInvoke
	#endif
	
	if (isNullVar(_iDat) || {isNullReference(_iDat select 0)}) exitWith {_c_defaultRet};
	private _vObj = [_iDat select 0] call si_handleObjectReturnCheckVirtual;
	if isTypeOf(_vObj,BasicMob) then {
		_iDat set [1,callFunc(_vObj,getPos)];
	};
	traceformat("Latest intersection: %1 (%2)",_vObj arg _iDat select 0)
	[_vObj,_iDat select 1,_iDat select 2]
};