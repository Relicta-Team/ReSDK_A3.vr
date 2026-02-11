// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define nodeModule_register(_name) node_system_group(_name) \
__nodemodule_common_path__ = "undefined."+_name; \
__nodemodule_common_icon__ = ""; \
__nodemodule_common_clrstyle__ = ""; \
__nodemodule_common_renderType__ = ""; \
__nodemodule_common_exectype__ = ""; \
__nodemodule_common_data__ = "";

#define nodeModule_setPath(_path) __nodemodule_common_path__ = _path;
#define nodeModule_addPath(_path) __nodemodule_common_path__ = __nodemodule_common_path__ + "." + _path;
#define nodeModule_popPath(_lvl) __prvd_path_splited = (__nodemodule_common_path__ splitString "."); \
if ((count __prvd_path_splited)-_lvl > 0) then { \
    reverse __prvd_path_splited; \
    for "_i__" from 1 to _lvl do {__prvd_path_splited deleteAt 0}; \
    reverse __prvd_path_splited; \
    __nodemodule_common_path__ = __prvd_path_splited joinString "."; \
};

#define nodeModule_setIcon(_icoPath) __nodemodule_common_icon__ = _icoPath;
#define nodeModule_setColorStyle(_clr) __nodemodule_common_clrstyle__ = _clr;
#define nodeModule_setRenderType(_rndr) __nodemodule_common_renderType__ = _rndr;
#define nodeModule_setExecType(_et) __nodemodule_common_exectype__ = _et;
#define nodeModule_commonData __nodemodule_common_data__ = 

#define reg_binary call _reg_binary_function;
#define reg_unary call _reg_unary_function;
#define reg_nular call _reg_nular_function;

#define opt + endl + "    opt:"+

private __nodemodule_common_path__ = "";
private __nodemodule_common_icon__ = "";
private __nodemodule_common_clrstyle__ = "";
private __nodemodule_common_renderType__ = "";
private __nodemodule_common_data__ = "";


_reg_function_common_provider = {
    params ["_pCtx","_sysname","_text","_code","_desc"];
    (_text splitString ":") params ["_nodename",["_libname",""]];

    _pCtx pushBack (format["node:%1",_sysname]);
    _pCtx pushBack (format["name:%1",_nodename]);
    if (_libname!="") then {
        _pCtx pushBack (format["namelib:%1",_libname]);
    };
    _pCtx pushBack (format["path:%1",__nodemodule_common_path__]);
    _pCtx pushBack (format["code:%1",_code]);
    if (_desc!="") then {
        _pCtx pushBack (format["desc:%1",_desc]);
    };

    //other registers
    if (__nodemodule_common_icon__ != "") then {
        _pCtx pushBack (format["icon:%1",__nodemodule_common_icon__]);
    };
    if (__nodemodule_common_clrstyle__ != "") then {
        _pCtx pushBack (format["color:%1",__nodemodule_common_clrstyle__]);
    };
    if (__nodemodule_common_renderType__ != "") then {
        _pCtx pushBack (format["rendertype:%1",__nodemodule_common_renderType__]);
    };
    if (__nodemodule_common_exectype__ != "") then {
        _pCtx pushBack (format["exec:%1",__nodemodule_common_exectype__]);
    };
    if (__nodemodule_common_data__ != "") then {
        _pCtx pushBack (endl+__nodemodule_common_data__)
    };
};

// ["systemNodeName","Имя:Библиотечное имя","nil","void:Любое значение" opt "dname=0:mul=1"] reg_nular
_reg_nular_function = {
    params ["_sysname","_text","_code","_rezInfo",["_desc",""]];
    private _paramsContext = [];
    
    [_paramsContext,_sysname,_text,_code,_desc] call _reg_function_common_provider;

    _paramsContext pushBack (format["out:%1",_rezInfo]);
    
    (_paramsContext joinString endl) node_system 
};

// ["systemNodeName","Имя:Библиотечное имя","nil","void:Входное знач.","void:Выходное знач."] reg_unary
_reg_unary_function = {
    params ["_sysname","_text","_code","_inInfo",["_rezInfo",""],["_desc",""]];
    private _paramsContext = [];
    
    [_paramsContext,_sysname,_text,_code,_desc] call _reg_function_common_provider;

    _paramsContext pushBack (format["in:%1",_inInfo]);
    //optional output
    if (_rezInfo != "") then {
        _paramsContext pushBack (format["out:%1",_rezInfo]);
    };
    
    (_paramsContext joinString endl) node_system
};

// ["systemNodeName","Имя:Библиотечное имя","nil","void:Входное знач.1","void:Входное знач.2","void:Выходное знач."] reg_binary
_reg_binary_function = {
    params ["_sysname","_text","_code","_inInfo1","_inInfo2",["_rezInfo",""],["_desc",""]];
    private _paramsContext = [];

    [_paramsContext,_sysname,_text,_code,_desc] call _reg_function_common_provider;

    _paramsContext pushBack (format["in:%1",_inInfo1]);
    _paramsContext pushBack (format["in:%1",_inInfo2]);
    //optional output
    if (_rezInfo != "") then {
        _paramsContext pushBack (format["out:%1",_rezInfo]);
    };
    
    (_paramsContext joinString endl) node_system
};

