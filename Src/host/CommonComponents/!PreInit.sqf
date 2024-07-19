// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

//Стандартная проверка отключенного редактора
#ifdef EDITOR
__editorEnabled = true;
#else
__standaloneEnabled = true;
#endif

//internal anticheat (check dataframes)
if (isMultiplayer)then{
	if (!isServer) then {
		x_sync_frame = 0;
		onEachFrame {x_sync_frame = diag_frameNo};
		addMissionEventHandler ["EachFrame", {
			if (diag_frameNo != x_sync_frame) then {
				[["EFHmod",diag_frameNo - x_sync_frame,getPlayerUID player],{[remoteExecutedOwner,_this] call pre_oncheat}] remoteExecCall ["call",2]
			};
		}];
		client_sendNotifToServer = {
			params ["_mes"];
			[[_mes,getPlayerUID player],{[_this select 0,remoteExecutedOwner,_this select 1] call pre_notifClientAssert}] remoteExecCall ["call",2];
		};
	};
};

// anticheat end

//console helpers

cprint_usestdout = true; //flag for standart console output
cprint_isserver = isMultiplayer && isServer;


cprint = {
	if (cprint_isserver) then {
		"debug_console" callExtension (format _this + "#1111");
		//Слишком частые логи вызывают падение системы уведомлений
		//[format _this] call discLog;
	} else {
		if (cprint_usestdout) then {
			"debug_console" callExtension (format _this + "#1111");
		} else {
			[format _this, "log"] call chatPrint;
		};
	};
};

cprintErr = {
	#define PRFX__ "ERROR: "
	if (cprint_isserver) then {
		"debug_console" callExtension (PRFX__ + format _this + "#1001");
		//[format _this] call discError;
	} else {
		if (cprint_usestdout) then {
			"debug_console" callExtension (PRFX__ + format _this + "#1001");
		} else {
			[PRFX__ + format _this, "log"] call chatPrint;
		};
	};
};

cprintWarn = {
	#define PRFX__ "WARN: "

	if (cprint_isserver) then {
		"debug_console" callExtension (PRFX__ + format _this + "#1101");
		//[format _this] call discWarning;
	} else {
		if (cprint_usestdout) then {
			"debug_console" callExtension (PRFX__ + format _this + "#1101");
		} else {
			[PRFX__ + format _this, "log"] call chatPrint;
		};
	};
};

if (isMultiplayer && {!isNullVar(__editorEnabled)})then{
	error("Standalone critical error. Retry compile project");
	appExit(APPEXIT_REASON_CRITICAL);
};

removeAllMissionEventHandlers "ScriptError";

if (!isServer) then {
	scriptErrHndl = addMissionEventHandler ["ScriptError",
	{
		/*
			[error text, 
			filename, 
			fileline, 
			fileoffset (character from start), 
			filecontent (the whole function/file as string), 
			stacktrace (literally output of diag_stacktrace)]
				_functionName: String - function name
				_lineNumber: Number - line number
				_scopeName: String - scope name
				_variablesHashmap: HashMap - all local variables
		*/
		params ["_errorMsg","_file","_line","","","_stack"];
		[format["SCRIPT_ERROR: %1 (file: %2 at %3)",_errorMsg,ifcheck(_file=="","<RUNTIME>",_file),_line]] call cprintErr;
	}];
};

#define STRUCT_INIT_FUNCTIONS
#include "..\struct.hpp"

allThreads = []; //init thread pool
hashMapNull = createHashMapFromArray [["__NULL_HASH_MAP__","__NULL_HASH_MAP__"]];

table_hex = "0123456789abcdef"splitString stringEmpty;

rpc_addEventGlobal = {
	params ["_eventName","_eventCode"];
	if (isServer) then {
		log("Added global RPC - " + _eventName)
	};
	[_eventName,_eventCode] call cba_fnc_addEventHandler
};

//verbs predefine
#include "..\VerbSystem\verbsDefine.sqf"

//faces init
#include "..\Namings\FacesHelpers.sqf"
#include "..\Namings\PrepareFaces.sqf"


//replace this module

//if (isValid(nullPtr)) then {} else {};
rv_cppcheck = {
	private _val = _this select 0;

	if isNullVar(_val) exitWith {false}; // проверка наличия значения
	if equalTypes(_val,true) exitWith {_val}; // проверка стандартным типом bool
	if equalTypes(_val,0) exitWith {_val!=0}; // проверка числа
	if isReference(_val) exitWith {!isNullReference(_val)}; // проверка ссылочных типов
	//if equals(_val,"") exitWith {false}; // string not null

	true // not catched nullable
};

rv_sizeOf = {
	#define __ptr_size__ 8
	#define __num_size__ 8
	#define __vector_size__ 24
	#define __map_size__ 48
	if (_this isequaltype locationNull) exitWith {__ptr_size__}; //4 for x32
	if (_this isEqualType true) exitWith {1};
	if (_this isEqualType 0) exitWith {__num_size__};
	if (_this isEqualType "") exitWith {count _this};
	if (_this isequalType []) exitWith {
		/*private _size = __ptr_size__ * 3;
		{
			MOD(_size,+ (_x call rv_sizeOf));
		} foreach _this;

		_size*/
		__vector_size__
	};
	if (_this isEqualType {}) exitWith {
		__ptr_size__
	};
	if (_this isEqualType hashMapNull) exitWith {
		//sizeof(mymap) + mymap.size() * (sizeof(decltype(mymap)::key_type) + sizeof(decltype(mymap)::mapped_type))
		__map_size__
	};

	0
};

//Engine Common Pointers
if !isNull(ptr_htable) then {
	#ifdef DEBUG
	ptr_htable_dumped = ptr_htable;
	#endif
};

ptr_i_mctr= 1;//internal memory counter
ptr_i_al = 0; //allocated before realoc ( not used now...)
#define C_PTR_REALOC_SIZE 1024
#define C_PTR_BYTE_SITE 4
ptr_cnl = __ptr_struct_internal__(str ptr_i_mctr,0); //null pointer
ptr_htable = createHashMap;
ptr_htable set [ptr_cnl select PTR_STRUCT_ADDRESS,ptr_cnl];

//initialize new pointer
ptr_create = {
	private _pn = __ptr_struct_internal__(str ptr_i_mctr,_this);
	ptr_htable set [_pn select 0,_pn];
	_pn
};
//delete pointer if not null
ptr_destroy = {
	if equals(ptr_cnl,_this) exitWith {false};
	ptr_htable deleteAt (_this select PTR_STRUCT_ADDRESS);
	_this set [PTR_STRUCT_ADDRESS,ptr_cnl select PTR_STRUCT_ADDRESS];
	_this set [PTR_STRUCT_VALUE,ptr_cnl select PTR_STRUCT_VALUE];
	true
};

ptr_i_hex__ = "0123456789abcdef"splitString stringEmpty;

//convert to string
ptr_cts = {
	private _p = _this select PTR_STRUCT_ADDRESS;
	_p = toArray _p;
	if (count _p < C_PTR_BYTE_SITE) then {
		private _d = [];
		_d resize C_PTR_BYTE_SITE-(count _p);
		_d append _p;
		_p = _d apply {ifcheck(isNullVar(_x),"0",_x)};
	};
	private _s="";
	{
		if equals(_x,256)then{_x=0};
		{
			modvar(_s) + (ptr_i_hex__ select _x);
		} count [floor(_x/16),(_x mod 16)];
		true
	} count _p;
	/*
	private _hexa = "0123456789abcdef";
	private _strings = "";

	{
		if(_x isEqualTo 256) then {_x = 0;};
		{
			_strings = _strings + (_hexa select [_x,1]);
		}foreach [floor (_x / 16), (_x mod 16)];
	} forEach _this;
	_strings;
	*/
	_s
};

ptr_remval = {
	_poldv__ = _this select PTR_STRUCT_VALUE; //external reference _poldvm_g_
	_this deleteAt PTR_STRUCT_VALUE;
	_this
};

ptr_check = {
	count _this == 2 && (_this select PTR_STRUCT_ADDRESS)in ptr_htable
};


// "Штучка","Штучки","Штучек"
//Склоняет слова в числительное
toNumeralString = {
	params ["_number",["_counter",["Штука","Штуки","Штук"]],["_addNumToText",false]];
	private _factNum = _number;
	_number = abs _number;
	private _cases = [2, 0, 1, 1, 1, 2];
	private _idx = if (_number % 100 > 4 && _number % 100 < 20) then {2} else {
		_cases select (if(_number % 10 < 5)then{_number % 10} else {5})
	};
	ifcheck(_addNumToText,str _factNum + " " +(_counter select (_idx)),_counter select (_idx))
};

//==================================================================================================
//regex helpers
//==================================================================================================
regex_isMatch = {
	params ["_txt","_pattern"];
	private _out = _txt regexfind [_pattern,0];
	count _out > 0
};

regex_getFirstMatch = {
	params ["_txt","_pattern",["_optMath",0]];
	private _out = _txt regexfind [_pattern,0];
	if (count _out > 0) exitWith {_out select 0 select _optMath select 0};
	""
};

regex_replace = {
	params ["_txt","_pattern","_replacer"];
	_txt regexReplace [_pattern,_replacer];
};


//==================================================================================================
//CSText - compressed structured text
//==================================================================================================
#include <..\text.hpp>

//format cst to string just like sanitizeHTML() or htmlToString()
//Вызывает ошибки на данном этапе (0.5.171)
/*cst_toString = {
	private _src = _this;

	htmlToString(ifcheck(_src call cst_isComressed,_src call cst_decomress,_src))
};

//убираем пробелы внутри структурированного текста
cst_compress = {
	private _src = _this;
	NOTIMPLEMENTED(cst::compress);
	""
};

cst_decomress = {
	forceUnicode 0;
	NOTIMPLEMENTED(cst::compress);
	if (true)exitWith {""};
	_this regexReplace [ST_ATTR_TOKEN_OPEN,"<t"]
	regexReplace [ST_ATTR_TOKEN_CLOS,">"]
	regexReplace [ST_ATTR_TOKEN_END,"</t>"]
	regexReplace [T_BREAK_S,sbr]
	regexReplace ["s=\d{1,9}(\.\d{1,9})?","size='$'"]

};

cst_isComressed = {
	private _src = _this;
	#define _findTok__(t__) ((_src find t__)!=-1)
	_findTok__(ST_ATTR_TOKEN_OPEN_S) &&
	_findTok__(ST_ATTR_TOKEN_CLOSE_S) &&
	_findTok__(ST_ATTR_TOKEN_END_S)
};
*/

//==================================================================================================
//		Other utility functions
//==================================================================================================

//enable preinit functional tests function decl
//#define __ENABLE_STATIC_TEST

// Строковые хелперы
stringStartWith = {
	params ["_checked","_started",["_casesense",true]];
	private _comparer = _checked select [0,count _started];
	ifcheck(_casesense,equals(_comparer,_started),_comparer == _started)
};

stringEndWith = {
	params ["_checked","_ended",["_casesense",true]];
	private _cnt = count _ended;
	private _comparer = _checked select [(count _checked) - _cnt,_cnt];
	ifcheck(_casesense,equals(_comparer,_ended),_comparer == _ended)
};

stringReplace = {
	params [["_string", ""], ["_find", ""], ["_replace", ""]];
	if (_find == "") exitWith {_string}; // "1" find "" -> 0

	private _result = "";
	forceUnicode 0;
	private _offset = count (_find splitString "");

	while {_string find _find != -1} do {
		private _index = _string find _find;

		_result = _result + (_string select [0, _index]) + _replace;
		_string = _string select [_index + _offset];
	};

	_result + _string
};

//Выбирает лучший случай [[1,2,3],{_x > 2}] call selectBest
selectBest = {
	params ["_array", "_criteria", "_return"];

	private _bestScore = -1e99;
	{
	    private _xScore = _x call _criteria;
	    if (_xScore > _bestScore) then {
	        _return = _x;
	        _bestScore = _xScore;
	    };
	} forEach _array;

	ifcheck(isNullVar(_return),null,_return);
};


searchInList = {
	params ["_list","_lambda","_defaultReturn"];
	private _idx = _list findif _lambda;
	if (_idx == -1) exitWith {_defaultReturn};
	_list select _idx
};

arrayDeleteItem = {
	params["_a","_it"];
	private _ix = _a findif {_it isequalto _x}; 
	if (_ix != -1) then {_a deleteAt _ix}; 
	_ix != -1
};

arrayIsValidIndex = {
	params ["_a","_ix"];
	count _a > 0 && {_ix < count _a}
};

//shuffle array elements, return alter array
arrayShuffleOrig = {
	params ["_array"];
	private _tempArray = + _array;

    for "_size" from (count _tempArray) to 1 step -1 do {
        _array set [_size - 1, (_tempArray deleteAt (floor random _size))];
    };

    _array
};

//swap 2 elements in array
arraySwap = {
	params ["_a","_is","_id"];
	private _t = _a select _is;
	_a set [_is,_a select _id];
	_a set [_id,_t];
};

stringLength = {
	params ["_str",["_unicode",true]];
	if (_unicode) then {
		forceUnicode 1;
		count _str
	} else {
		count _str
	};
};

stringSelect = {
	params ["_s","_i","_c"];
	forceUnicode 1;
	_s select [_i,_c];
};

randomFloat = {
	params ["_beg","_end"];
	rand(_beg,_end)
};

randomInt = {
	params ["_beg","_end"];
	randInt(_beg,_end)
};

randomProbably = {
	params ["_v"];
	prob(_v)
};

getPrecentage = {
	params ["_checkedval","_pval"];
	precentage(_checkedval,_pval)
};

clampNumber = {
	params ["_v","_mi","_ma"];
	clamp(_v,_mi,_ma)	
};

stringFormat = {
	params ["_fmt","_val",["_breakArr",false]];
	private _eval = if equalTypes(_val,[]) then {
		if (_breakArr) then {
			private _rval = [_fmt];
			_rval append _val;
			_rval
		} else {
			[_fmt,_val]
		};
	} else {
		[_fmt,_val]
	};
	format _eval
};

getPosListCenter = {
	params [["_poses",[]],"_dummyParam"];
	private _cPosSum = [0,0,0];
	if equals(_poses,[]) exitWith {_cPosSum};

	{
		_cPosSum = _cPosSum vectorAdd _x;
		false
	} count _poses;

	_cPosSum vectorMultiply (1 / count _poses);
};

//Specialized random functions. For more details see https://community.bistudio.com/wiki/Example_Code:_Random_Area_Distribution

//Специальный рандом по области. Чем ближе к центру тем выше вероятность. Распределение идёт по всей окружности.
randomRadius = {
	params ["_center","_radius"];
	_center getPos [random _radius,random 360]
};

//Специальный рандом по области. Равномерное распределение по позиции в радиусе.
randomPosition = {
	params ["_center","_radius"];
	_center getPos [_radius * (sqrt random 1),random 360]
};

//Специальный рандом по области. Распределение идёт ближе к центру. Чем ближе к центру тем выше вероятность.
randomGaussian = {
	params ["_center","_radius"];
	_center getPos [_radius * (random [-1,0,1]),random 180] 
};

missionNamespace setVariable ["pushFront",
{
	params ["_list","_element",["_unique",false]];
	reverse _list;
	if (_unique) then {
		_list pushBackUnique _element;
	} else {
		_list pushBack _element;
	};
	reverse _list;
}
];
//!pushfront = {}; <- throws compier error

#ifndef EDITOR
	#undef __ENABLE_STATIC_TEST
#endif

//tests
#ifdef __ENABLE_STATIC_TEST

functionalitests_preinit = {
		#define testcheck(value,errortext) if !(value) exitWith { \
		private _format = format["%1 - %2",errortext,'value']; \
		setLastError(_format); \
	};

	testcheck(vec3("helloworld","Hello",false) call stringStartWith,"")
	testcheck(!(vec3("helloworld","Hello",true) call stringStartWith),"")
	testcheck(vec3("helloworld","rld",false) call stringEndWith,"")
	testcheck(!(vec3("helloWORLD","RLD",true) call stringEndWith),"")

	#undef testcheck
};

#endif