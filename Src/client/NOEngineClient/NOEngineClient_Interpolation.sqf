// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

noe_client_defaultInterpTime = 0.15;

noe_client_interp_processObjInterp = {
	params ["_srcObj","_fromPos","_fromTransf","_toPos","_toTransf","_time",["_scaleMode",0]];
	_srcObj disableCollisionWith player;
	traceformat("Interp process launched: %1",_this)
	
	private _onEnd = {
		params ["_src"];
		[_src] call le_unloadLight;
		{(_x select 0)call(_x select 1)} foreach (_src getvariable "_eventOnDelete");
		deleteVehicle _src;
	};
	_time = _time + rand(-0.05,0.1);

	startAsyncInvoke
	{
		params ["_src","_fp","_ft","_tp","_tt","_tStart","_dur","_scl"];
		if isNullReference(_src) exitWith {true};
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
		traceformat("POS: %1 -> %2; TRANS: %3  -> %4",_fp arg _tp arg _ft arg _tt);
		_tEnd = _tStart + _dur;
		_pos = vectorLinearConversion [_tStart,_tEnd,tickTime,_fp,_tp];
		_src setPosAtl _pos;
		
		if ((linearConversion[_tStart,_tEnd,tickTime,0,1])>=0.7) then {
			_trans = vectorLinearConversion [_tStart,_tEnd,tickTime,_ft,_tt];
			[_src,_trans] call model_SetPitchBankYaw;
		} else {
			[_src,_fp] call model_SetPitchBankYaw;
		};

		if (_scl!=0) then {
			_sFact = if (_scl>0) then {
				linearConversion [_tStart,_tEnd,tickTime,0,1]
			} else {
				linearConversion [_tStart,_tEnd,tickTime,1,0]
			};
			_src setObjectScale _sFact;
		};

		false
	},
	_onEnd,
	[_srcObj,_fromPos,_fromTransf,_toPos,_toTransf,tickTime,_time,_scaleMode],
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
noe_client_interp_start = {
	params ["_owner","_paramsT"];
	private _options = [];
	if (count _paramsT > 2) then {
		_options = _paramsT deleteAt 2;
	};
	private _argList = [_owner,_paramsT,[false,false],_options];

	private _checkConditions = {
		params ["_owner","_pList","_dList"];
		traceformat("CHECK %1",_this)
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
		_iObj setvariable ["_eventOnDelete",_tEventOnDelete];
		_objects = [_sObj,_dObj];

		if ("nhs" in _options) then {_objects set [0,objNull];};
		if ("nhd" in _options) then {_objects set [1,objNull];};
		private _scaleMode = 0;
		if ("sc-" in _options) then {_scaleMode = -1};
		if ("sc+" in _options) then {_scaleMode = 1};

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
						_o hideObject false;
						if(_lt!=-1) then {
							[_lt,_o] call le_loadLight;
						};
					}
				];
				continue;
			};
			if (([_x,true] call noe_client_getObjPtr)!="") then {
				_ppos = getposatl _x;
				_x setposatl [0,0,0];
				_tEventOnDelete pushBack [
					[_x,_ppos],{
						params ["_o","_ppos"];
						_o setposatl _ppos;
					}
				];
				continue;
			};
		} foreach _objects;

		//starting interpolation
		traceformat("STARTING INTERPOLATE OF %1; lt: %2; options: %3",_iObj arg _light arg _options)
		[_iObj,_sPos,_sTr,_dPos,_dTr,noe_client_defaultInterpTime,_scaleMode] call noe_client_interp_processObjInterp;
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
		[_obj,"AUTO_GEN",[_mSrc,_offset,_selName,[_obj] call model_getPitchBankYaw]]
	};
	//no compression, just save
	if equalTypes(_data,[]) exitWith {
		[objNull,_data select 0,_data select 1]
	};
};

//!performance issues
// noe_client_handleNetworkInterpolation = {
// 	params ["_ptr","_tfrom","_tto"];
// }; rpcAdd("nitrp",noe_client_handleNetworkInterpolation);