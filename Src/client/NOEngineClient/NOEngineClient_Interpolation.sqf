// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.Interpolation,noe_client_interp_;noe_client_)

decl(float)
noe_client_defaultInterpTime = 0.15;

decl(void(mesh;vector3;vector3;vector3;vector3;float;int;int;bool))
noe_client_interp_processObjInterp = {
	params ["_srcObj","_fromPos","_fromTransf","_toPos","_toTransf","_time",["_scaleMode",0],["_stdMode",0],["_emuMode",false]];
	_srcObj setPhysicsCollisionFlag false;
	traceformat("Interp process launched: %1",_this)
	
	private _onEnd = {
		params ["_src"];
		[_src] call le_unloadLight;
		{(_x select 0)call(_x select 1)} foreach (_src getvariable "_eventOnDelete");
		deleteVehicle _src;
	};

	startAsyncInvoke
	{
		params ["_src","_fp","_ft","_tp","_tt","_tStart","_dur","_scl","_stdMode","_emuMode"];
		if isNullReference(_src) exitWith {true};
		
		{(_x select 0)call(_x select 1)} foreach (_src getvariable "_eventOnFrame");

		//auto_gen: transform data params; [_mSrc,_offset,_selName,[_obj] call model_getPitchBankYaw]
		if equals(_fp,"AUTO_GEN") then {
			_ft params ["_m","_of","_sl","_pby"];
			_fp = _m modelToWorldVisual (_m selectionPosition (_sl)vectoradd _of);
			_ft = _pby;
		};
		if equals(_tp,"AUTO_GEN") then {
			_tt params ["_m","_of","_sl","_pby"];
			_tp = _m modelToWorldVisual (_m selectionPosition (_sl)vectoradd _of);
			_tt = _pby;
		};
		//traceformat("POS: %1 -> %2; TRANS: %3  -> %4",_fp arg _tp arg _ft arg _tt);
		_tEnd = _tStart + _dur;
		if (_emuMode) then {
			_tval = linearConversion [_tStart,_tEnd,tickTime,0,1];
			_pointList = [
				_fp,
				([[_fp,_tp]] call getPosListCenter)vectorAdd [0,0,_fp distance _tp],
				_tp
			];
			_pos = _tval bezierInterpolation _pointList;
			_src setPosAtl _pos;
		} else {
			_pos = vectorLinearConversion [_tStart,_tEnd,tickTime,_fp,_tp];
			_src setPosAtl _pos;
		};
		
		_canApplyTransf = true;
		
		_normAngle = {
			private _r = _this % 360;
			if (_r>=180) then {
				_r = _r - 360;
			} else {
				if (_r<=-180) then {
					_r = _r + 360;
				};
			};
			_r
		};

		if (_canApplyTransf) then {
			if equalTypes(_ft,0) then {
				if not_equalTypes(_tt,0) then {
					_tt = _tt select 2;
				};
				_src setDir (linearConversion[_tStart,_tEnd,tickTime,_ft,_tt]);
			} else {
				if not_equalTypes(_tt,[]) then {
					_tt = [0,0,_tt];
				};
				
				// Нормализация углов векторов
				_ft set [2, (_ft select 2) call _normAngle];
				_tt set [2, (_tt select 2) call _normAngle];

				// Коррекция углов для кратчайшего пути
				private _startAngle = _ft select 2;
				private _endAngle = _tt select 2;

				if ((_endAngle - _startAngle) > 180) then {
					_endAngle = _endAngle - 360;
				} else {
					if ((_endAngle - _startAngle) < -180) then {
						_endAngle = _endAngle + 360;
					};
				};

				_tt set [2, _endAngle];

				_transf = vectorLinearConversion [_tStart,_tEnd,tickTime,_ft,_tt];
				
				// Нормализация результирующего угла для предотвращения артефактов
				_transf set [2, (_transf select 2) call _normAngle];

				[_src,_transf] call model_SetPitchBankYaw;
			};
		} else {
			if equalTypes(_ft,0) exitWith {_src setDir _ft}; 
			[_src,_ft] call model_SetPitchBankYaw;
		};
		

		if (_scl!=0) then {
			_sFact = if (_scl>0) then {
				linearConversion [_tStart,_tEnd,tickTime,0.3,1]
			} else {
				linearConversion [_tStart,_tEnd,tickTime,1,0.3]
			};
			_src setObjectScale _sFact;
		};

		false
	},
	_onEnd,
	[_srcObj,_fromPos,_fromTransf,_toPos,_toTransf,tickTime,_time,_scaleMode,_stdMode,_emuMode],
	_time,
	_onEnd
	endAsyncInvoke
};

/* Запуск интерполяции. 
	типы параметров трансофрмов:
		ptr - указатель на объект в мире
			находит объект за отведенное время. берет его информацию позиций
			при интерполяции скрывает указатель на который ссылается этот объект
		slot - слот инвентаря
			получает данные по позиции этой модели в слоте
		transform - позиция и поворот
*/
decl(void(actor;any[]))
noe_client_interp_start = {
	params ["_owner","_paramsT"];
	private _options = [];
	if (count _paramsT > 2) then {
		_options = _paramsT deleteAt 2;
	};
	private _argList = [_owner,_paramsT,[false,false],_options];

	private _checkConditions = {
		params ["_owner","_pList","_dList"];
		traceformat("INTERP CHECK %1",_this)
		{
			if !(_x) then {
				_pCur = _pList select _foreachIndex;
				_dat = [_owner,_pCur] call noe_client_interp_determineTransform;
				if !isNullVar(_dat) then {
					_pList set [_foreachIndex,_dat];
					_dList set [_foreachIndex,true];
				};
			};
		} foreach _dList;

		all_of(_dList)
	};

	private _onFound = {
		params ["_o","_pList","","_options"];
		(_pList select 0) params ["_sObj","_sPos","_sTr"];
		(_pList select 1) params ["_dObj","_dPos","_dTr"];
		private _objTargetInfo = _sObj;
		if isNullReference(_sObj) then {
			_objTargetInfo = _dObj;
		};
		if ("udo" in _options) then {
			if !isNullReference(_dObj) then {
				_objTargetInfo = _dObj;
			};
		};

		_srcModel = getModelInfo _objTargetInfo select 1;
		_light = [_objTargetInfo] call le_getLoadedLightCfg;
		
		_iObj = createSimpleObject[_srcModel,[0,0,0],true];
		if (_light!=-1) then {
			[_light,_iObj] call le_loadLight;
		};
		//temporary hidding objects (checks smd_isSMDObjectInSlot)
		_tEventOnDelete = [];
		_tEventOnFrame = []; //TODO implement onframe for fix bug when object updated with recreated (changed pos at new chunk)
		_iObj setvariable ["_eventOnDelete",_tEventOnDelete];
		_iObj setvariable ["_eventOnFrame",_tEventOnFrame];
		_objects = [_sObj,_dObj];

		//setup interpolation speed
		_ispdIdx = _options find "ispd";
		private _interpSpeed = -noe_client_defaultInterpTime;
		if (_ispdIdx!=-1) then {
			assert((_ispdIdx+1) < count _options);
			_interpSpeed = _options select (_ispdIdx+1);
		};
		if (_interpSpeed < 0) then {
			_interpSpeed = (abs _interpSpeed) + rand(-0.05,0.1);
		};

		if ("nhs" in _options) then {_objects set [0,objNull];};
		if ("nhd" in _options) then {_objects set [1,objNull];};
		private _scaleMode = 0;
		if ("sc-" in _options) then {_scaleMode = -1};
		if ("sc+" in _options) then {_scaleMode = 1};
		if (_scaleMode!=0) then {
			_interpSpeed = _interpSpeed * 2;
		};
		private _stdMode = 0;
		if ("std" in _options) then {_stdMode = 1};
		private _emuMode = false;
		if ("emuf" in _options) then {_emuMode = true};
		
		

		{
			if isNullReference(_x) then {continue};

			if (_x call smd_isSMDObjectInSlot) then {
				_x hideObject true;
				_ltX = [_x] call le_getLoadedLightCfg;
				if (_ltX!=-1) then {
					[_x] call le_unloadLight;
				};
				_tEventOnDelete pushBack [
					[_x,_ltX],{
						params ["_o","_lt"];
						//? по непонятным причинам в списке объектов оказывается null объект. возможно это нормальное поведение
						if !isNullReference(_o) then {						
							_o hideObject false;
							if(_lt!=-1) then {
								[_lt,_o] call le_loadLight;
							};
						};
					}
				];
				continue;
			};
			if (([_x,true] call noe_client_getObjPtr)!="") then {
				// _ppos = getposatl _x;
				// _x setposatl [0,0,0]; //! raise position error
				_x hideObject true;
				_tEventOnDelete pushBack [
					[_x,_ppos],{
						params ["_o","_ppos"];
						//_o setposatl _ppos;
						_o hideObject false;
					}
				];
				continue;
			};
		} foreach _objects;

		//starting interpolation
		traceformat("STARTING INTERPOLATE OF %1; lt: %2; options: %3",_iObj arg _light arg _options)
		[_iObj,_sPos,_sTr,_dPos,_dTr,_interpSpeed,_scaleMode,_stdMode,_emuMode] call noe_client_interp_processObjInterp;
	};

	if (_argList call _checkConditions) exitWith {
		_argList call _onFound
	};

	startAsyncInvoke
		_checkConditions,
		_onFound,
		_argList,
		#ifdef EDITOR
		0.1 //timeout check
		#else
		1
		#endif
	endAsyncInvoke
};

//returns [srcobj,pos,trans]
decl(any(actor;any))
noe_client_interp_determineTransform = {
	params ["_owner","_data"];
	//is pointer
	if equalTypes(_data,"") exitWith {
		private _obj = noe_client_allPointers get _data;
		if isNullVar(_obj)exitWith {};
		if isNullReference(_obj) exitWith {};
		[_obj,getPosAtl _obj,[_obj] call model_getPitchBankYaw]
	};
	if equalTypes(_data,0) exitWith {
		private _obj = [_owner,_data] call smd_getObjectInSlot;
		if isNullVar(_obj)exitWith {};
		if isNullReference(_obj) exitWith {};
		(_obj getvariable "_pit_lastAttachData") params ["_mSrc","_offset","_selName"];
		
		if isNullVar(_offset) exitWith {};

		[_obj,"AUTO_GEN",[_mSrc,_offset,_selName,[_obj] call model_getPitchBankYaw]]
	};
	//no compression, just save
	if equalTypes(_data,[]) exitWith {
		[objNull,_data select 0,_data select 1]
	};
};

decl(void(any;any;any))
noe_client_interp_interpNet = {
	params ["_f","_t","_opt"];

	[player,[_f,_t,_opt]] call noe_client_interp_start;

}; rpcAdd("nintrp",noe_client_interp_interpNet);