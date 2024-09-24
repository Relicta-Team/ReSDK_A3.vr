// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define CRAFT_PARSER_HEAD private ["_val__","_mes__","_par_output__"]

#define value _val__
#define message _mes__

#define GETVAL(dict,key,types) _par_output__ = ([dict,key,types] call csys_validateType); value = _par_output__ select 0; message = _par_output__ select 1
#define GETVAL_STR(dict,key) GETVAL(dict,key,"")
#define GETVAL_FLOAT(dict,key) GETVAL(dict,key,0)
#define GETVAL_INT(dict,key) GETVAL(dict,key,"int")
#define GETVAL_BOOL(dict,key) GETVAL(dict,key,false)
#define GETVAL_ARRAY(dict,key) GETVAL(dict,key,[ [] ])
#define GETVAL_DICT(dict,key) GETVAL(dict,key,hashMapNull)

#define FAIL_CHECK if (_mes__ != "") exitWith 
#define FAIL_CHECK_PRINT FAIL_CHECK { [_mes__] call csys_errorMessage; false }
#define FAIL_CHECK_REFSET(ref__) FAIL_CHECK { refset(ref__,_mes__); }
#define FAIL_CHECK_EMPTY FAIL_CHECK {}

// enable for more verbose logging
#define CRAFT_DEBUG_LOAD