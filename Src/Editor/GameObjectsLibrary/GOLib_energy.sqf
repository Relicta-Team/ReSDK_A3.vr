// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



init_function(golib_en_init)
{
	golib_en_internal_const_perCall = 1;
	golib_en_internal_nextCallTime = 0;
	golib_en_internal_list_buffer = [];
		/*
			renderbuffer struct:
			vec3
			[from_object, to_object, to_object_energy_use]
		*/
	["onFrame",{
		if (tickTime >= golib_en_internal_nextCallTime) then {
			golib_en_internal_nextCallTime = tickTime + golib_en_internal_const_perCall;
			call golib_en_internal_updateRenderBuffer;
		};
		call golib_en_internal_doRender;
	}] call Core_addEventHandler;
}


function(golib_en_obj_getReqPower)
{
	[_this,"edReqPower"] call golib_getActualDataValue;
}

function(golib_en_obj_isEnergyObject)
{
	private _hd = [_this,false] call golib_getHashData;
	if (count _hd == 0) exitWith {false};
	[_hd get "class","edOwner","EditorVisible"] call goasm_attributes_hasAttributeField
}

function(golib_en_obj_getConnectedMarks)
{
	[_this,"edConnected"] call golib_getActualBasicValue;
}

function(golib_en_obj_getMark)
{
	private _hd = [_this,false] call golib_getHashData;
	_hd getOrDefault ["mark",""]
}

function(golib_en_obj_getMotherEnergyObject)
{
	private _mark = _this call golib_en_obj_getMark;
	if (_mark == "") exitWith {objnull};
	private _obj = objnull;
	{
		if (_mark in _y) exitWith {
			_obj = _x call golib_cs_getObjectByMark;
		};
	} foreach golib_internal_map_connected;
	_obj
}

function(golib_en_internal_updateRenderBuffer)
{
	golib_en_internal_list_buffer = [];
	golib_en_internal_map_referenceHash = createHashMap;
	golib_en_internal_enValues = createHashMap;

	golib_en_internal_listObjects = [];

	_so = call golib_getSelectedObjects;

	_deepCopy = {
		params ["_obj","_deep","_col"];
		if (_obj call golib_en_obj_isEnergyObject) then {
			private _marks = _obj call golib_en_obj_getConnectedMarks;
			private _baseObj = _obj;
			
			golib_en_internal_map_referenceHash set [str _baseObj,_baseObj];

			golib_en_internal_listObjects pushBackUnique _baseObj;

			if !isNullVar(_marks) then {
				
				{
					private _mobj = _x call golib_cs_getObjectByMark;
					if !isNullReference(_mobj) then {
						
						golib_en_internal_list_buffer pushback [
							_mobj,
							_baseObj,
							_mobj call golib_en_obj_getReqPower,
							_col
						];

						golib_en_internal_map_referenceHash set [str _mobj,_mobj];


						golib_en_internal_listObjects pushBackUnique _mobj;

						if (_deep) then {
							[_mobj,true,_col] call _deepCopy;
						};
					};
					
				} foreach _marks;
			};
		};
	};

	private _m = objnull;
	{
		[_x,true,[0,1,0,1]] call _deepCopy;
		_m = _x call golib_en_obj_getMotherEnergyObject;
		if !isNullReference(_m) then {
			[_m,false,[0,0,1,1]] call _deepCopy
		};
	} foreach _so;

	_getNodeReqPower = {
		private _obj = _this;
		private _needAmount = _obj call golib_en_obj_getReqPower;
		private _marks = _obj call golib_en_obj_getConnectedMarks;
		if isNullVar(_marks) exitWith {
			_needAmount
		};
		private _omark = objnull;
		{
			_omark = _x call golib_cs_getObjectByMark;
			if !isNullReference(_omark) then {
				_needAmount = _needAmount + (_omark call _getNodeReqPower);
			};
		} foreach _marks;

		_needAmount
	};

	{
		_rp = _x call _getNodeReqPower;
		golib_en_internal_enValues set [str _x,_rp];

	} foreach golib_en_internal_listObjects;
}

function(golib_en_internal_doRender)
{
	_uniReq = [];	
	{
		[_x,_y] params ["_fObj","_fEn"];
		_fObj = golib_en_internal_map_referenceHash get _fObj;
		_fObj setvariable ["___last_onframe_goenbuf",_fEn];
		_uniReq pushBackUnique _fObj;
	} foreach golib_en_internal_enValues;

	{
		_x params ["_fObj","_tObj","_fEn","_fCol"];
		_add = ((boundingBoxReal _fObj select 1 select 2) / 2);
		_add2 = ((boundingBoxReal _tObj select 1 select 2) / 2);
		drawLine3D [(getPosAtl _fObj) vectorAdd [0,0,_add], (getPosAtl _tObj) vectorAdd [0,0,_add2], _fCol, 20];

	} foreach golib_en_internal_list_buffer;

	{
		_fObj = _x;
		_t = format["Требует энергии: %1",_fObj getvariable ["___last_onframe_goenbuf",0]];
		drawIcon3D ["", [0,1,0,1], getposatl _fObj, 0, 0, 0, _t, 1, 0.05, "PuristaMedium"];

		_fObj setvariable ["___last_onframe_goenbuf",0];
	} foreach _uniReq;
}

function(golib_en_connectObjects)
{
	params [["_fromObj",objnull],["_toObj",objnull]];
	
	if (isNullReference(_fromObj) || isNullReference(_toObj)) exitWith {

	};
	if equals(_fromObj, _toObj) exitWith {};

	if !(_fromObj call golib_en_obj_isEnergyObject) exitWith {
		["Источник " + str _fromObj + " не является электронным объектом"] call showWarning;
	};
	if !(_toObj call golib_en_obj_isEnergyObject) exitWith {
		["Цель "+str _toObj+" не является электронным объектом"] call showWarning;
	};
	["Connect %1 to %2",_fromObj,_toObj] call printTrace;
	private _marks = _toObj call golib_en_obj_getConnectedMarks;
	private _thisMark = [_fromObj,"mark"] call golib_getActualBasicValue;
	private _prevMother = _fromObj call golib_en_obj_getMotherEnergyObject;
	
	if (isNull(vec2(_fromObj,"mark") call golib_getActualBasicValue)) then {
		_cls = [_fromObj,"class"] call golib_getActualBasicValue;
		_thisMark = _cls + " G:"+hashvalue((systemtime joinString "") + str randInt(1,999999));
		[_fromObj,"mark",_thisMark] call golib_setActualBasicValue;
		
	};
	if (isNull(vec2(_toObj,"mark") call golib_getActualBasicValue)) then {
		_cls = [_toObj,"class"] call golib_getActualBasicValue;
		[_toObj,"mark",_cls + " G:"+hashvalue((systemtime joinString "") + str randInt(1,999999))] call golib_setActualBasicValue;
	};

	private _isNodeTo = [_toObj,"edIsNode"] call golib_getActualDataValue;
	if isNullVar(_isNodeTo) then {
		_isNodeTo = false;
	};
	if (!_isNodeTo) exitWith {
		["Источник не явлется узлом"] call showWarning;
	};

	
	//если в целевом объекте есть марка подключаемой - выходим
	//означает что всё уже подключено
	if (_thisMark in _marks) exitwith {};

	private _allMotherMarks = [];
	_mot = _toObj;
	while {
		_mot = _mot call golib_en_obj_getMotherEnergyObject;
		
		if isNullReference(_mot) exitWith {false};

		if (_mot call golib_en_obj_isEnergyObject) then {
			_allMotherMarks pushback (_mot call golib_en_obj_getMark);
		};
		true
	} do {};

	//["%2 >>>>>>> %1",(
	//	_thisMark
	//) in (_allMotherMarks),_allMotherMarks] call printTrace;

	//если цикл - выходим
	if ((
		_thisMark
	) in _allMotherMarks
	) exitwith {
		[
			format["%1: Циклическая зависимость",
				__FUNC__
			]
		] call showWarning;
	};

	//remove prev
	if !isNullReference(_prevMother) then {
		private _mHash = [_prevMother,false] call golib_getHashData;
		if (count _mHash == 0) exitWith {};
		private _list = _mHash getOrDefault ["edConnected",[]];
		_list deleteAt (_list find _thisMark);
		if (count _list == 0) then {
			_mHash deleteAt "edConnected";
		} else {
			_mHash set ["edConnected",_list];
		};
		[_prevMother,_mHash] call golib_setHashData;
	};

	//set to new
	private _newHash = [_toObj,false] call golib_getHashData;
	if (count _newHash == 0) exitWith {
		["(%1) - Task failed",__FUNC__] call printError;
	};
	_newHash set ["edConnected",(_newHash getOrDefault ["edConnected",[]]) + [_thisMark]];
	[_toObj,_newHash] call golib_setHashData;

	call golib_cs_syncMarks;

	["(%1) - Task success",__FUNC__] call printLog;
}


function(golib_en_connectObjectsList)
{
	params ["_objList",["_toObj",objNull]];
	private _fromObj = null;
	if isNullReference(_toObj) exitWith {};
	if !(_toObj call golib_en_obj_isEnergyObject) exitWith {
		["Цель "+str _toObj+" не является электронным объектом"] call showWarning;
	};

	//dest validate node type
	private _isNodeTo = [_toObj,"edIsNode"] call golib_getActualDataValue;
	if isNullVar(_isNodeTo) exitWith {_isNodeTo = false};
	if (!_isNodeTo) exitWith {
		["Цель не явлется узлом"] call showWarning;
	};

	["Подключение электроники", "Подключение электрических устройств", "a3\3den\data\cfg3den\history\changeAttributes_ca.paa"] collect3DENHistory
	{
		
		{
			_fromObj = _x;
			if isNullReference(_fromObj) then {continue};
			if equals(_fromObj, _toObj) then {continue};

			if !(_fromObj call golib_en_obj_isEnergyObject) then {continue};
			
			["Connect %1 to %2",_fromObj,_toObj] call printTrace;

			private _marks = _toObj call golib_en_obj_getConnectedMarks;
			private _thisMark = [_fromObj,"mark"] call golib_getActualBasicValue;
			private _prevMother = _fromObj call golib_en_obj_getMotherEnergyObject;

			if isNullVar(_thisMark) then {
				private _cls = [_fromObj,"class"] call golib_getActualBasicValue;
				_thisMark = _cls + " G:"+hashvalue((systemtime joinString "") + str randInt(1,999999));
				[_fromObj,"mark",_thisMark] call golib_setActualBasicValue;
			};

			if isNull(vec2(_toObj,"mark") call golib_getActualBasicValue) then {
				private _cls = [_toObj,"class"] call golib_getActualBasicValue;
				[_toObj,"mark",_cls + " G:"+hashvalue((systemtime joinString "") + str randInt(1,999999))] call golib_setActualBasicValue;
			};

			//already set in dest object
			if (_thisMark in _marks) then {continue};

			private _allMotherMarks = [];
			private _mot = _toObj;
			while {
				_mot = _mot call golib_en_obj_getMotherEnergyObject;

				if isNullReference(_mot) exitWith {false};

				if (_mot call golib_en_obj_isEnergyObject) then {
					_allMotherMarks pushback (_mot call golib_en_obj_getMark);
				};
				true
			} do {};

			if (_thisMark in _allMotherMarks) then {
				["%1: circular dependency found at mark %2",__FUNC__,_thisMark] call printWarning;
				continue;
			};

			//remove prev
			if !isNullReference(_prevMother) then {
				private _mHash = [_prevMother,false] call golib_getHashData;
				if (count _mHash == 0) exitWith {};
				private _list = _mHash getOrDefault ["edConnected",[]];
				_list deleteAt (_list find _thisMark);
				if (count _list == 0) then {
					_mHash deleteAt "edConnected";
				} else {
					_mHash set ["edConnected",_list];
				};
				[_prevMother,_mHash] call golib_setHashData;
			};

			//set to new
			private _newHash = [_toObj,false] call golib_getHashData;
			if (count _newHash == 0) exitWith {
				["(%1) - Task failed",__FUNC__] call printError;
			};

			_newHash set ["edConnected",(_newHash getOrDefault ["edConnected",[]]) + [_thisMark]];
			[_toObj,_newHash] call golib_setHashData;
			
		} foreach _objList;

		call golib_cs_syncMarks;
	};

}