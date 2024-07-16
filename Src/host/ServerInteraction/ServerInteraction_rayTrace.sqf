// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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

//_force - не рекомендуется больше 10
si_rayTraceProcess = {
	params ["_vobj","_pstart","_vecDirect","_force",["_precdownIn",70],["_leveldownIn",0.1]];
	
	private _c_defaultRet = [_vobj,_pstart,[0,0,1]];
	private _rtObj = si_internal_rayObject;
	
	private _model = getVar(_vobj,model);
	private _bbx = core_modelBBX get _model;
	if isNullVar(_bbx) then {
		_rtObj = createSimpleObject[_model,[50,50,50],true];
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
	#define SI_RAYTRACE_CHECK_DISTANCE 0.05

	private _ipt = 0;
	private _finalized = false;
	private _iDat = null;
	
	for "_i" from SI_RAYTRACE_CHECK_DISTANCE to _rayDist step SI_RAYTRACE_CHECK_DISTANCE do {
		_ipt = linearConversion [0,_rayDist,_i,0,1,true];
		INC(_incSaved);
		
		_newPos = _ipt bezierInterpolation _points;

		#ifdef SI_RAYTRACE_DEBUG
		_sph = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
		_sph setposatl _newPos;
		_sph setVectorUp (vectorNormalized (_oldPos vectorDiff _newPos  ) vectorMultiply 1);
		_debug_slist pushBack _sph;
		#endif

		_iDat = [_oldPos,_newPos,_rtObj] call si_getIntersectData;
		if isNullReference(_iDat select 0) then {
			{
				_iDat = [_rtObj modelToWorld _x,_newPos,_rtObj] call si_getIntersectData;
				if !isNullReference(_iDat select 0) exitWith {};
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

		_angle = _iDat select 2 select 2;
		_hasMoving = isNullReference(_iDat select 0);//(_oldPos distance _newPos) > 0.01;
		//traceformat("PRECHECK ANGLE %1 (move:%2)",_angle arg _hasMoving)
		if (_angle < 0.65 && !_hasMoving && !false) then {
			traceformat("INTERSECT ANGLE %1 [%2] -> %3",_angle arg _iDat select 0 arg allVariables (_iDat select 0))
			//отскок объекта
			
			_iDat = [_oldPos,_oldPos vectorAdd [0,0,-1000]] call si_getIntersectData;
			break;
		};

		if !isNullReference(_iDat select 0) exitWith {};

		_rtObj setPosAtl _newPos;
		_rtObj setVectorUp (vectorNormalized (_oldPos vectorDiff _newPos) vectorMultiply 1);
		_oldPos = _newPos;
	};
	
	

	#ifdef SI_RAYTRACE_DEBUG
	_sph = "Sign_Sphere10cm_F" createVehicleLocal[0,0,0];
	_sph setposatl ifcheck(!isNullVar(_iDat) && {!isNullReference(_iDat select 0)},_iDat select 1,_oldPos);
	_debug_slist pushBack _sph;

	(_debug_slist select -1) setObjectTexture [0,"#(rgb,8,8,3)color(0,1,0,1)"];
	invokeAfterDelayParams({{deletevehicle _x}foreach _this},4,_debug_slist);
	#endif
	
	if (isNullVar(_iDat) || {isNullReference(_iDat select 0)}) exitWith {_c_defaultRet};
	private _vObj = [_iDat select 0] call si_handleObjectReturnCheckVirtual;
	if isTypeOf(_vObj,BasicMob) then {
		_iDat set [1,callFunc(_vObj,getPos)];
	};
	[_vObj,_iDat select 1,_iDat select 2]
};