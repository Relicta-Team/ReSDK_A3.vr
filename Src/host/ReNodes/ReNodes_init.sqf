// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"

/*
    !Устаревшая информация
    Компонент ReNodes API для генерации библиотеки узлов графа, вызова функций  

    Общие параметры регистрации
    cat - категория, например operators, По умолчанию: functions
    path - путь до узла в поисковике, По умолчанию: NoCategory
    name - выводимое имя узла, По умолчанию: имя функции или имя метода
    desc - выводимое описание, По умолчанию: -
    color - цвет узла; html, type. По умолчанию: определяется из категории
    disabled - выключает доступность узла в генерацию
    
    __basename - проброшенное имя узла (дефолтное имя)

    in - список точек входа
    out - список точек выхода
        name - имя точки, по умолчанию -
        showname - показывать имя точки, по умолчанию да
        multi - указывает что узел мультиконнектный, по умолчанию выходы только один, входы мульти
        types - типы ReNodes которые могут объединять эти узлы. От первого типа указывается стиль и цвет коннектора

    opt - спиcок опций
        type - тип опции: bool,input,spin,fspin,edit,list,vec2,vec3,rgb,rgba,file
        text - стандартное текстовое описание опции, по умолчанию нет
        label (для bool) - вписанный текст в чекбокс (по умолчанию нет)
        default - значение по умолчанию (по умолчанию нет)
        range (для spin,fspin) - 2 значения с нижним и верхним пределом
        fspindata (для fspin) - 2 значения: размер шага и количество символов после запятой
        values (для list) - список элементов

        title (для file) - плейсхолдер текст инпута пути
        ext (для file) - GLOB-паттерн файлов
        root (для file) - дочерняя директория, которая открывается при выборе файла

    inout: Создает вход и выход по типу: ["in","name:Flow","types:Flow"],["out","name:Flow","types:Flow"]

    Минимальный пример: ["cat:functions","name:Тестовая функция","inout:Flow"]

    Порядок сборки:
    1. Запускается симуляция
    2. Гененрируется библиотека lib.json (для редактора) и bindings.nodes (для платформы)

    Генерация биндинга
        Для генерации вызываемой функции в неё должны подставиться параметры

    Регистрация функций:
        В файле биндингов есть общие свойства. Раздел общих свойств с префиксом @

        "@sect_control_operators":{
		"path":"Операторы", //общее
		"name":"Тест имя", //общее
		"cat": "operators", //общее
		"list": { //список узлов в категории operators
			"if_branch": {
				"name": "Ветка", //переопределенное свойство
				"desc": "Ветка"
			},
			"while": {
				"desc": "Цикл"
			}
		}
	}
*/

/*
    Компонент ReNodes API для генерации библиотеки узлов графа, вызова функций  
*/

//текущая версия библиотеки для генерации
nodegen_const_libversion = 1;
//карта рабочих узлов. Ключ - системное название узла, значение - данные типа хэшкарты
if isNull(nodegen_list_library) then {
    nodegen_list_library = [];
    nodegen_list_functions = [];
};
nodegen_str_outputJsonData = ""; //сгенерированный json
nodegen_internal_generatedLibPath = ""; //сюда записывается сгенерированный json файл

nodegen_objlibPath = "src\host\ReNodes\lib.obj";

nodegen_debug_copyobjlibPath = "P:\Project\ReNodes\lib.obj";

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
    #ifdef _SQFVM
    if (true) exitwith {};
    #endif
    if (!is3DEN) exitwith {};

    private _ctx = _this;
    ["c",_class,_ctx] call nodegen_registerClass;
};

nodegen_addFunction = {
    private _ctx = _this;
    _ctx call nodegen_commonSysAdd;
};

nodegen_addSystemNode = {
    private _ctx = _this;
    _ctx call nodegen_commonSysAdd;
};

nodegen_commonAdd = {
    #ifdef _SQFVM
    if (true) exitwith {};
    #endif

    //генерация только в редакторе
    if (!is3DEN) exitwith {};

    private _ctx = _this;
    if isNullVar(_last_node_info_) then {
        _last_node_info_ = [];
    };
    _last_node_info_ pushBack _ctx;
};

nodegen_commonSysAdd = {
    #ifdef _SQFVM
    if (true) exitwith {};
    #endif

    if (!is3DEN) exitwith {};

    private _ctx = _this;
    private _gadd = "system";
    if !isNullVar(__nsys_grp) then {
        _gadd = __nsys_grp;
    };
    nodegen_list_functions pushBack [_gadd,_ctx];
};

nodegen_registerFunctions = {
    //Сюда вставляются пути до функций, которые должны быть регистрированы в библиотеке
    //внутри файлов с функциями составляются определения через node_func
    
    #include "ReNodes_bindingHelpers.sqf"

    //тут зарегистрированы узлы общего назначения (работа с типами, операторы)
    #include "_systemNodes.sqf"
    #include "_array.sqf"
    #include "_string.sqf"
    #include "_conversions.sqf"
    #include "_math.sqf"
    #include "_math.logical.sqf"
    #include "_model.sqf"
    #include "_hashmap.sqf"
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
    if (!is3DEN) exitwith {
        setLastError("NodeGen cannot generate library outside ReEditor");
        false
    };
    
    //промежуточная библиотека
    ["Starting generating intermediate library (ver %1)",nodegen_const_libversion] call printLog;

    ["Generating common nodes"] call printLog;
    nodegen_list_functions = [];
    call nodegen_registerFunctions;
    ["Common nodes generated!"] call printLog;

    private _output = "v" + (str nodegen_const_libversion)+endl;
    
    //Регистрация функций и узлов общего назначения
    ["Generating functions"] call printLog;
    private _data = "" + endl;
    modvar(_output) + "$REGION:FUNCTIONS" + endl;
    
    private _funcdata = [];
    private _tempfunc = "";
    {
        _x params ["_cat","_data"];
        _tempfunc = format['def:node:%1',_cat] + endl + _data + endl;
        _funcdata pushBack _tempfunc;
    } foreach nodegen_list_functions;
    modvar(_output) + (_funcdata joinString endl);
    modvar(_output) + "$ENDREGION:FUNCTIONS" + endl;

    //Регистрация членов классов
    ["Generating class members"] call printLog;
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
    ["Generating class metadata"] call printLog;
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
            ["Generated %1/%2",_foreachIndex+1,_lastIndex+1] call printLog;
        };
    } foreach (_typeList);
    
    modvar(_output) + (_tempList joinString "");

    modvar(_output) + "}" + endl + "$ENDREGION:CLASSMETA" + endl;

    nodegen_str_outputJsonData = _output;

    [nodegen_objlibPath,nodegen_str_outputJsonData] call file_write;
    
    if (!isNull(nodegen_debug_copyobjlibPath) && {nodegen_debug_copyobjlibPath!=""}) then {
        [nodegen_debug_copyobjlibPath,nodegen_str_outputJsonData,false] call file_write;
    };

    true
};

