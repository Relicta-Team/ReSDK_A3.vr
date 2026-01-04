// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"

#include "ReNode.h"
#include "ReNode_debugger.sqf"

/*
    Компонент ReNode API для генерации библиотеки узлов графа, вызова функций.
    Это прекомпилируемый файл, работающий как в редакторе, так и в симуляции
*/

//текущая версия библиотеки для генерации
nodegen_const_libversion = 1;

//Пути загрузчика скриптов
nodegen_scriptClassesFolder = "src\host\ReNode\compiled";
nodegen_scriptClassesLoader = nodegen_scriptClassesFolder + "\script_list.hpp";

//карта рабочих узлов. Ключ - системное название узла, значение - данные типа хэшкарты
if isNull(nodegen_list_library) then {
    nodegen_list_library = [];
    nodegen_list_functions = [];
};
nodegen_str_outputJsonData = ""; //сгенерированный json
nodegen_internal_generatedLibPath = ""; //сюда записывается сгенерированный json файл


nodegen_objlibPath = "ReNode\lib.obj";
nodegen_signLibExe = "ReNode\ReNode.exe";
nodegen_debug_copyobjlibPath = "P:\Project\ReNodes\lib.obj";
nodegen_debug_copyobjguidPath = "P:\Project\ReNodes\lib_guid";

#ifdef GENERATE_RENODE_BINDINGS
    private _genBindRBuilder = true;
#else
    private _genBindRBuilder = false;
#endif
nodegen_canUse = is3DEN || _genBindRBuilder;

//вызывается перед компиляцией классов
nodegen_cleanupClassData = {
    nodegen_list_library = [];
};

//регистратор метода
nodegen_addClassMethod = {
    private _ctx = _this;
    _ctx call nodegen_commonAdd;
};

nodegen_addClassField = {
    private _ctx = _this;
    _ctx call nodegen_commonAdd;
};

nodegen_addClass = {
    if (!nodegen_canUse) exitwith {};

    private _ctx = _this;
    ["c",_class,_ctx] call nodegen_registerClass;
};

nodegen_addFunction = {
    if (!nodegen_canUse) exitwith {};

    private _ctx = _this;
    private _buf = [_ctx];

    _buf pushBack (format["path:%1",__nodemodule_common_path__]);

    //other registers
    if (__nodemodule_common_icon__ != "") then {
        _buf pushBack (format["icon:%1",__nodemodule_common_icon__]);
    };
    if (__nodemodule_common_clrstyle__ != "") then {
        _buf pushBack (format["color:%1",__nodemodule_common_clrstyle__]);
    };
    if (__nodemodule_common_renderType__ != "") then {
        _buf pushBack (format["rendertype:%1",__nodemodule_common_renderType__]);
    };
    if (__nodemodule_common_exectype__ != "") then {
        _buf pushBack (format["exec:%1",__nodemodule_common_exectype__]);
    };
    if (__nodemodule_common_data__ != "") then {
        _buf pushBack (endl+__nodemodule_common_data__)
    };


    [_buf joinstring endl,"func"] call nodegen_commonSysAdd;
};

nodegen_addSystemNode = {
    private _ctx = _this;
    [_ctx,"node"] call nodegen_commonSysAdd;
};

nodegen_addEnumerator = {
    params ["_nodename","_members",["_pdata",'']];
    
    assert(!isNullVar(_members));
    assert(equalTypes(_members,[]));
    assert(count _members > 0);

    private _map = createHashMap;
    private _iter = 0;
    private _delIter = 0;
    {
        _delIter = (_x splitString ":");
        _delIter params ["_k",["_v",_iter]];
        if not_equalTypes(_v,0) then {_v = parseNumber _v};
        _map set [str _v,_k];
        _iter = _v + 1;
        //TODO check if member not contain enumval
    } foreach _members;
    missionNamespace setvariable ['enum_vToK_'+_nodename,_map];
    missionNamespace setvariable ["enum_values_"+_nodename,(keys _map) apply {parseNumber _x}];
    
    //выход из нумераторов только после выполнения действий
    if (!nodegen_canUse) exitwith {};

    private _ctx = [];
    _ctx pushBack ('node:'+_nodename);
    _ctx pushBack ("path:Перечисления");
    _ctx pushBack (_pdata);
    {_ctx pushBack ("eval:"+_x)} foreach _members;
    [_ctx joinstring endl,"enum"] call nodegen_commonSysAdd;
};

nodegen_addStruct = {
    params ["_nodename","_members","_pdata"];
    if (!nodegen_canUse) exitwith {};
    assert(equalTypes(_members,[]));

    private _map = createHashMap;
    {
        (_x splitString ":") params ["_ptype","_pname","_pval"];
    } foreach _members;

    private _ctx = [];
    _ctx pushBack ('node:'+_nodename);
    _ctx pushBack ("path:Структуры");
    _ctx pushBack (_pdata);
    {_ctx pushback ("eval:"+_x)} foreach _members;
    [_ctx joinstring endl,"struct"] call nodegen_commonSysAdd;
};

nodegen_commonAdd = {
    //генерация только в редакторе
    if (!nodegen_canUse) exitwith {};

    private _ctx = _this;
    if isNullVar(_last_node_info_) then {
        _last_node_info_ = [];
    };
    _last_node_info_ pushBack _ctx;
};

nodegen_commonSysAdd = {
    if (!nodegen_canUse) exitwith {};

    params ["_ctx","_nseg"];
    private _gadd = "system";
    if !isNullVar(__nsys_grp) then {
        _gadd = __nsys_grp;
    };
    nodegen_list_functions pushBack [_gadd,_ctx,_nseg];
};

nodegen_registerFunctions = {
    call compile preprocessFileLineNumbers "src\host\ReNode\ReNode_loadBindings.sqf";
};

nodegen_registerMember = {
    params ["_t","_class","_memname","_contextList"];
    nodegen_list_library pushBack [_t,format["%1.%2",_class,_memname],_contextList];
};

nodegen_registerClass = {
    params ["_t","_class","_data"];
    nodegen_list_library pushBack [_t,_class,_data];
};

nodegen_generateLib = {
    if (!nodegen_canUse) exitwith {
        setLastError("NodeGen cannot generate library outside ReEditor or RBuilder");
        false
    };
    
    params [["_savePath",nodegen_objlibPath]];

    private _printLog = ifcheck(is3DEN,printLog,cprint);

    if (_savePath == "") exitwith {
        ["Save path not defined"] call printError;
        false
    };

    //промежуточная библиотека
    ["Starting generating intermediate library (ver %1)",nodegen_const_libversion] call _printLog;

    ["Generating common nodes"] call _printLog;
    nodegen_list_functions = [];
    call nodegen_registerFunctions;

    if (count nodegen_list_functions == 0) exitwith {
        ["Empty function list"] call printError;
        false
    };
    if (count nodegen_list_library == 0) exitwith {
        ["Empty class list"] call printError;
        false
    };

    ["Common nodes generated!"] call _printLog;

    private _output = "v" + (str nodegen_const_libversion)+endl;
    
    //Регистрация функций и узлов общего назначения
    ["Generating functions"] call _printLog;
    private _data = "" + endl;
    modvar(_output) + "$REGION:FUNCTIONS" + endl;
    
    private _funcdata = [];
    private _tempfunc = "";
    {
        _x params ["_cat","_data","_ncat"]; //_ncat - enum,node etc...
        _tempfunc = format['def:%2:%1',_cat,_ncat] + endl + _data + endl;
        _funcdata pushBack _tempfunc;
    } foreach nodegen_list_functions;
    modvar(_output) + (_funcdata joinString endl);
    modvar(_output) + "$ENDREGION:FUNCTIONS" + endl;

    //Регистрация членов классов
    ["Generating class members"] call _printLog;
    modvar(_output) + "$REGION:CLASSMEM" + endl;
    {
        _x params ["_type","_member","_dataList"];
        if equalTypes(_dataList,[]) then {
            {
                modvar(_output) + format["def:%1:%2_%3%4%5",_type,_member,_foreachIndex,endl,_x] + endl;
            } foreach _dataList;
        } else {
            modvar(_output) + format["def:%1:%2%3%4",_type,_member,endl,_dataList] + endl
        };

    } foreach nodegen_list_library;
    
    modvar(_output) + endl + "$ENDREGION:CLASSMEM" + endl;
    //Сбор мета-данных о классе
    /*
        Сюда попадают словари, содержащие информацию о классах
        Также тут вычисляются типы данных
    */
    ["Generating class metadata"] call _printLog;
    private _typeList = (["object",true] call oop_getinhlist) + ["object"];
    private _lastIndex = count _typeList - 1;
    private _missionPath = getMIssionPath "";
    private _calculateFieldValue = {
        private _val = _this;
        private _ntype = null;
        if not_equalTypes(_val,"") then {
            //["Field %1 in class %2 not serialized; Value type: %3",_x select 0,_class,typename _val] call printWarning;
            _ntype = _val;
            //__VAL = str _val;
        } else {
            //__VAL = str _val;
            if ([_val,"\bcall\b"] call regex_isMatch) exitWith {
                if ('"__instance"' in _val) exitWith {
                    "object"
                };
                "runtime_error_type"
            };
            _ntype = call compile _val;
        };
       // __VAL = [__VAL,"""","'"] call regex_replace;

        if equalTypes(_ntype,0) exitWith {
            if (floor _ntype == _ntype) exitWith {"int"};
            "float"
        };
        if isNullVar(_ntype) exitWith {"null"};
        if equalTypes(_ntype,true) exitwith {"bool"};
        if equalTypes(_ntype,"") exitwith {
            //__VAL = _val; 
            "string"};
        if equalTypes(_ntype,[]) exitwith {"null_array"};
        if equalTypes(_ntype,objNull) exitwith {"model"};
        if equalTypes(_ntype,locationNull) exitWith {"object"};

        if (typename _ntype == "hashmap") exitwith {"null_hashmap"};

        // _estring = "Unknown type for "+ (_class) + " " + typeName _ntype;
        // stackval = format["%1 val",_ntype];
        // [_estring] call printError;
        
        "unknown_type"
    };
    
    private ["_decl","_allfields","_fields","_methods","_defPath","_class","_motherClass"];
    modvar(_output) + "$REGION:CLASSMETA" + endl + "{" + endl ;//+ """object"" : [""object""]" + endl;
    _tempList = [];
    //__VAL = """null""";
    _el = "";
    {
        _class = [_x,"classname"] call oop_getTypeValue;
        _motherClass = [_class,"__motherClass"] call oop_getTypeValue;

        if ([_class,"NodeClass"] call goasm_attributes_hasAttributeClass) then {
            continue;
        };

        _fields = [_x,"__fields"] call oop_getTypeValue;
        _methods = [_x,"__methods"] call oop_getTypeValue;
        _decl = [_x,"__decl_info__"] call oop_getTypeValue;
        _defPath = [_decl select 0,_missionPath] call stringReplace;
        _defPath = [_defPath,"\","\\"] call stringReplace;

        
        _el = str(_class) + ": {" + endl + //start defclass
        
        //baselist
        //!Собирается внутри редактора
        //format["    ""baseList"" : %1,",str([_x,"__inhlistCase"] call oop_getTypeValue)] + endl +
        
        //baseclass ref
        format["    ""baseClass"" : %1,",str(_motherClass)] + endl +

        //declare info (file,path)
        format["    ""defined"" : {""file"":%1,""line"":%2},",str(_defPath),(_decl select 1)] + endl +
        //fields info
        "   ""fields"": { ""defined"": {" + endl +
            //all members case sensitivity

                ((_fields apply {
                    //__VAL = """null"""; emplace "value": %3
                    format['%1:{"return": %2}',str(_x select 0),str((_x select 1) call _calculateFieldValue)]
                    })
                    joinString ",") +
        "}   }," + endl + //close defined, close fields

        //methods info
        "   ""methods"": { ""defined"": {" + endl +
            //with case sensitivity
                ((_methods apply {
                    format['%1:{"return": "<undefined>"}',str(_x select 0)]
                })
                    joinString ","
                ) + endl +
        "}   }" + endl + //close defined, close methods
        
        "}"+ endl; //end defclass
        if (_foreachIndex != _lastIndex) then {
            modvar(_el) + ",";
        };
        _tempList pushBack _el;
        if (_foreachIndex % 200 == 0) then {
            ["Generated %1/%2",_foreachIndex+1,_lastIndex+1] call _printLog;
        };
    } foreach (_typeList);
    
    modvar(_output) + (_tempList joinString "");

    modvar(_output) + "}" + endl + "$ENDREGION:CLASSMETA" + endl;

    nodegen_str_outputJsonData = _output;

    [_savePath,nodegen_str_outputJsonData] call file_write;
    //sign code
    private _retCode = [nodegen_signLibExe,true,"-sign_lib"] call file_openReturn;
    ["Library guid generated result: %1",_retCode] call _printLog;
    if (_retCode != 0) exitWith {false};
    
    if ([nodegen_debug_copyobjlibPath,false] call file_exists) then {
        if (!isNull(nodegen_debug_copyobjlibPath) && {nodegen_debug_copyobjlibPath!=""}) then {
            ["Copy object lib for debugger directory: " + nodegen_debug_copyobjlibPath] call _printLog;
            private _r1 = [_savePath,nodegen_debug_copyobjlibPath,[true,false],true] call file_copy;
            
            private _np = core_path_renode_folder + "/lib_guid";
            ["Copy guid lib for debugger directory %1",_np] call _printLog;
            private _r2 = [_np,nodegen_debug_copyobjguidPath,[true,false],true] call file_copy;
            ["Debug copy results: obj - %1, guid - %2",_r1,_r2] call _printLog;
        };
    } else {
        ["Skip copy object lib for debugger directory"] call _printLog;
    };
    

    true
};

nodegen_loadClasses = {
    private _logger = ifcheck(is3DEN,printLog,cprint);

    if (!(fileExists(nodegen_scriptClassesLoader))) exitwith {
        ["Scripted class loader not found: %1",nodegen_scriptClassesLoader] call _logger;
    };

    private _pathes = preprocessFile nodegen_scriptClassesLoader splitString endl;
    ["Loading scripted classes "] call _logger;

    {
        private _pts = (_x splitString "\/");
        
        private _filename = _pts select -1;

        private _fullname = nodegen_scriptClassesFolder + "\" + _filename;
        // if (_fullname != _x) then {
        //     ["!!! ERROR ON LOADING - Invalid path: ""%1"" (%2);",_x,_filename] call _logger;
        //     continue;
        // };
        ["  Loading scripted class ""%1""",_filename] call _logger;
        call compile preprocessFileLineNumbers _fullname;
    } foreach _pathes;

    ["Scripted classes loading done"] call _logger;
};

//spec-funcs

//call delegate; _fref - vec2: vec2:(object,context), code(params:args,context)
renode_invokeDelegate = {
    //! NOT IMPLEMENTED
    setLastError("invoke delegate not implemented yet on ReNode editor side");
    
    //param input example: [[nullPtr,[]],{}]
    params ["_fref__","_args"];
    assert_str(count _fref__ == 2,"Invalid function ref datastructure");
    _fref__ params ["_oct__","_cd__"];
    assert_str(count _oct__ == 2,"Invalid object ref datastructure");
    assert_str(equalTypes(_cd__,{}),"Invalid code type instructions");
    
    //check nullobject
    if (isNullReference(_oct__ select 0 select 0)) exitWith {null};
    
    //args: [[obj],ctx]
    private _p__ = [[_oct__ select 0],_oct__ select 1];
    //args: [[obj,...],ctx]
    (_p__ select 0) apply _args;
    //call code and return
    _p__ call _cd__
};

//generic function for print messages into console
renode_print = {
    params ["_m","_ch","_ft"];
    private _msg = [_m];
    if not_equalTypes(_ft,[]) then {_ft = [_ft]};
    _msg append _ft;
    _msg = format _msg;

    if (_ch == RENODE_MSG_TYPE_LOG) exitWith {log(_msg)};
    if (_ch == RENODE_MSG_TYPE_WARNING) exitWith {warning(_msg)};
    if (_ch == RENODE_MSG_TYPE_ERROR) exitWith {error(_msg)};
    if (_ch == RENODE_MSG_TYPE_TRACE) exitWith {trace(_msg)};
};