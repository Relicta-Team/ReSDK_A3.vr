// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
				[["EFHmod",diag_frameNo - x_sync_frame],{[remoteExecutedOwner,_this] call pre_oncheat}] remoteExecCall ["call",2]
			};
		}];
		//!IMPORTANT: this function will be kick client from server (implements in pre_notifClientAssert)
		client_sendNotifToServer = {
			params ["_mes"];
			[[_mes],{[_this select 0,remoteExecutedOwner] call pre_notifClientAssert}] remoteExecCall ["call",2];
		};

		client_sendStatisticToServer = {
			params ["_mes"];
			[[_mes,cd_clientName],{[_this select 0,remoteExecutedOwner,_this select 1] call pre_notifClientStatistic}] remoteExecCall ["call",2];
		};
	};
};

// anticheat end

//console helpers

cprint_usestdout = true; //flag for standart console output
cprint_isserver = isMultiplayer && isServer;

// ["PREFIX","message %1, arg %2, last %3",...,...] call stdoutPrint
stdoutPrint = {
	private _args = _this;
	private _PREF = _args deleteAt 0;
	private _color = _args deleteAt (count _args - 1);
	#ifdef SP_PROD
		diag_log text format _this;
	#else
		conDllCall (_PREF + (format _args) + _color);
		__post_message_RB(_PREF + (format _args))
	#endif
};

cprint = {
	if (cprint_isserver) then {
		"debug_console" callExtension (format _this + "#1111");
		//Слишком частые логи вызывают падение системы уведомлений
		//[format _this] call discLog;
	} else {
		if (cprint_usestdout) then {
			#ifdef SP_PROD
				diag_log text format _this;
			#else
				"debug_console" callExtension (format _this + "#1111");
			#endif
		} else {
			[format _this, "log"] call chatPrint;
		};
	};

	__post_message_RB(format _this)
};

cprintErr = {
	#define PRFX__ "ERROR: "
	if (cprint_isserver) then {
		"debug_console" callExtension (PRFX__ + format _this + "#1001");
		//[format _this] call discError;
	} else {
		if (cprint_usestdout) then {
			#ifdef SP_PROD
				diag_log text (PRFX__ + format _this);
			#else
				"debug_console" callExtension (PRFX__ + format _this + "#1001");
			#endif
		} else {
			[PRFX__ + format _this, "log"] call chatPrint;
		};
	};

	__post_message_RB(PRFX__ + format _this)
};

cprintWarn = {
	#define PRFX__ "WARN: "

	if (cprint_isserver) then {
		"debug_console" callExtension (PRFX__ + format _this + "#1101");
		//[format _this] call discWarning;
	} else {
		if (cprint_usestdout) then {
			#ifdef SP_PROD
				diag_log text (PRFX__ + format _this);
			#else
				"debug_console" callExtension (PRFX__ + format _this + "#1101");
			#endif
		} else {
			[PRFX__ + format _this, "log"] call chatPrint;
		};
	};

	__post_message_RB(PRFX__ + format _this)
};

if (isMultiplayer && {!isNullVar(__editorEnabled)})then{
	error("Standalone critical error. Retry compile project");
	appExit(APPEXIT_REASON_CRITICAL);
};

#ifndef RBUILDER
removeAllMissionEventHandlers "ScriptError";
#endif

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

regex_getMatches = {
	params ["_txt","_pattern",["_optMath",0]];
	private _out = _txt regexfind [_pattern,0];
	private _rList = [];
	{
		_rList pushBack (_x select _optMath select 0);
		false
	} count _out;
	_rList
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

//Выбирает лучший случай [[2, -6, 4], {abs _x}] call selectBest
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
	count _a > 0 && {_ix < count _a} && {_ix >= 0}
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

clampInRange = {
	params ["_v","_mi","_ma"];
	private _fact = _ma * 2;
	if (_v < _mi) exitWith {
		_v + _fact
	};
	if (_v > _ma) exitWith {
		_v - _fact
	};
	_v
};

// See - BIS_fnc_pulsate; frequency: Number - the frequency in Hz, 1 / _frequency = 0.1 second is the period
pulsate = {
	params ["_freq",["_timeval",diag_tickTime]];
	0.5 * (1.0 + sin(2 * PI * _freq * _timeval))
};

//число в массив цифр
numberGetDigits = {
	params ["_num"];
	[_num] call BIS_fnc_numberDigits;
};

//срезает дробную часть числа
numberCutDecimals = {
	params ["_num","_digits"];
	[_num, _digits] call BIS_fnc_cutDecimals;
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
	_eval call formatLazy;
};

/*
	Ленивое форматирование. 
	Не выбрасывает исключений при отсутствующих параметрах для ключей (в режиме -debug)
	Все отсутствующие параметры заменяются на пустые строки.
	Пример:
		format["%1 %2","Hello"] // throws error

		...
		["%1 %2","Hello"] call formatLazy; //no throws, result is "Hello "

*/
formatLazy = {
	private _args = _this;
	private _firstTxt = _args select 0;
	private _params = _args select [1]; // get params without first string
	private _rtoks = (_firstTxt regexfind ["\%\d+",0]) apply {_x select 0 select 0};
	_rtoks = _rtoks arrayIntersect _rtoks; //only unique
	if (count _rtoks == (count _params)) exitWith {
		format _args;
	};
	_params resize (count _rtoks);
	private _out = [_firstTxt];
	_out append (_params apply {ifcheck(isNullVar(_x),"",_x)});
	format _out
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
	private _pos = _center getPos [random _radius,random 360];
	_pos set [2,_center select 2];
	_pos
};

//Специальный рандом по области. Равномерное распределение по позиции в радиусе.
randomPosition = {
	params ["_center","_radius"];
	private _pos = _center getPos [_radius * (sqrt random 1),random 360];
	_pos set [2,_center select 2];
	_pos
};

//Специальный рандом по области. Распределение идёт ближе к центру. Чем ближе к центру тем выше вероятность.
randomGaussian = {
	params ["_center","_radius"];
	private _pos = _center getPos [_radius * (random [-1,0,1]),random 180];
	_pos set [2,_center select 2];
	_pos
};

fileExists_Node = {
	params ["_f"];
	FileExists _f
};

// _mode == true -> asc, false -> desc: [[20,2,5],{_x}] call sortBy;
sortBy = {
	params ["_list","_algorithm",["_modeIsAscend",true]];

	private _cnt = 0;
	private _inputArray = _list apply 
	{
		_cnt = _cnt + 1; 
		[_x call _algorithm, _cnt, _x]
	};

	_inputArray sort _modeIsAscend;
	_inputArray apply {_x select 2}
	
};

//find nearest number in array of numbers
nearNumber = {
	params ["_arr","_num"];
	_arr = _arr + [_num];
	_arr sort true;

	private _i = _arr find _num;
	private _max = _arr deleteAt (_i + 1);
	private _min = _arr deleteAt (_i - 1);

	if (isNil "_min") exitWith {_max};
	if (isNil "_max") exitWith {_min};

	[_min, _max] select (_num - _min > _max - _num)
};

fileLoad_Node = {
	params ["_f",["_doPreprocess",false]];
	if !([_f] call fileExists_Node) exitWith {""};
	if (_doPreprocess) then {
		PreprocessFileLineNumbers _f
	} else {
		LoadFile _f
	};
};

pushFront = {
	params ["_list","_element",["_unique",false]];
	reverse _list;
	if (_unique) then {
		_list pushBackUnique _element;
	} else {
		_list pushBack _element;
	};
	reverse _list;
};


sft_processQueue__ = {
	private _ctob = _this;
	params ["_states","_cur","_tstrt"];
	private _canJump = true;
	_pfnc = _states select _cur;
	call _pfnc;
	if (_canJump) then {
		_cur = cur+1;
		_ctob set [1,_cur];
		_ctob set [2,tickTime];
		(_cur >= (count _states))
	} else {
		false
	};
};

sft_createThread__ = {
	private _args = _this;
	//TODO: add captured variables, add cancelation token
	_args call CBA_fnc_waitUntilAndExecute;
};