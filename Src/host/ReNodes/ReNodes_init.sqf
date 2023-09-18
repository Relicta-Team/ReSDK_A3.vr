// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"

/*
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

//текущая версия библиотеки для генерации
nodegen_const_libversion = 1;
//карта рабочих узлов. Ключ - системное название узла, значение - данные типа хэшкарты
if isNull(nodegen_map_library) then {
    nodegen_map_library = createHashMap;
};
nodegen_str_outputJsonData = ""; //сгенерированный json
nodegen_internal_generatedLibPath = ""; //сюда записывается сгенерированный json файл

nodegen_bindingsPath = "src\host\ReNodes\ReNodes_bindings.json";
nodegen_objlibPath = "src\host\ReNodes\lib_obj.json";

//регистратор метода
nodegen_addClassMethod = {
    private _ctx = _this;
    _ctx call nodegen_commonAdd;
};

nodegen_addClassField = {
    private _ctx = _this;
    _ctx call nodegen_commonAdd;
};

nodegen_commonAdd = {
    #ifdef _SQFVM
    if (true) exitwith {};
    #endif

    //генерация только в редакторе
    if (!is3DEN) exitwith {};

    private _ctx = _this;
    _last_node_info_ = _ctx;
};

nodegen_registerMember = {
    params ["_t","_class","_memname","_context"];
    _context = "{" + _context;

    _context = _context + "}";
    nodegen_map_library set [format["%1.%3_%2",_class,_memname,_t],_context];
};


nodegen_generateLib = {
    if (!is3DEN) exitwith {
        setLastError("NodeGen cannot generate library outside ReEditor");
        false
    };

    ["Start generating library (ver %1)",nodegen_const_libversion] call printLog;

    private _output = "v" + (str nodegen_const_libversion)+endl;

    ["Generating functions"] call printLog;
    private _data = ([nodegen_bindingsPath] call file_read);
    modvar(_output) + "$REGION:FUNCTIONS" + endl;
    modvar(_output) + _data + endl;
    modvar(_output) + "$ENDREGION:FUNCTIONS" + endl;

    ["Generating class members"] call printLog;
    modvar(_output) + "$REGION:CLASSMEM" + endl + "{" + endl;
    {
        modvar(_output) + format["%1 : %2",str _x,_y];
    } foreach nodegen_map_library;
    
    modvar(_output) + "}" + endl + "$ENDREGION:CLASSMEM" + endl;

    ["Generating class metadata"] call printLog;
    modvar(_output) + "$REGION:CLASSMETA" + endl + "{" + endl + """object"" : [""object""]" + endl;
    {
        modvar(_output) + format[",%1 : %2",str _x,str([_x,"__inhlist"] call oop_getTypeValue)] + endl;
    } foreach (["object",true] call oop_getinhlist);
    
    modvar(_output) + "}" + endl + "$ENDREGION:CLASSMETA" + endl;

    nodegen_str_outputJsonData = _output;

    [nodegen_objlibPath,nodegen_str_outputJsonData] call file_write;

    true
};

//https://github.com/CBATeam/CBA_A3/blob/7ff35f7544493ca93c4d0047245333a720245163/addons/hashes/fnc_encodeJSON.sqf
nodegen_toJson = {
    params ["_object"];

    if (isNil "_object") exitWith { "null" };

    switch (typeName _object) do {
        case "SCALAR";
        case "BOOL": {
            str _object;
        };

        case "STRING": {
            {
                _object = [_object, _x select 0, _x select 1] call CBA_fnc_replace;
            } forEach [
                ["\", "\\"],
                ["""", "\"""],
                [toString [8], "\b"],
                [toString [12], "\f"],
                [endl, "\n"],
                [toString [10], "\n"],
                [toString [13], "\r"],
                [toString [9], "\t"]
            ];
            // Stringify without escaping inter string quote marks.
            """" + _object + """"
        };

        case "ARRAY": {
            if ([_object] call CBA_fnc_isHash) then {
                private _json = (([_object] call CBA_fnc_hashKeys) apply {
                    private _name = _x;
                    private _value = [_object, _name] call CBA_fnc_hashGet;

                    format ["%1: %2", [_name] call nodegen_toJson, [_value] call nodegen_toJson]
                }) joinString ", ";
                "{" + _json + "}"
            } else {
                private _json = (_object apply {[_x] call nodegen_toJson}) joinString ", ";
                "[" + _json + "]"
            };
        };

        case "HASHMAP": {
            private _json = ((_object toArray false) apply {
                _x params ["_key", ["_value", objNull]];

                if !(_key isEqualType "") then {
                    _key = str _key;
                };

                format ["%1: %2", [_key] call nodegen_toJson, [_value] call nodegen_toJson]
            }) joinString ", ";
            "{" + _json + "}"
        };

        default {
            if !(typeName _object in (supportInfo "u:allVariables*" apply {_x splitString " " select 1})) exitWith {
                [str _object] call nodegen_toJson
            };

            if (isNull _object) exitWith { "null" };

            private _json = ((allVariables _object) apply {
                private _name = _x;
                private _value = _object getVariable [_name, objNull];

                format ["%1: %2", [_name] call nodegen_toJson, [_value] call nodegen_toJson]
            }) joinString ", ";
            "{" + _json + "}"
        };
    };
};

//https://github.com/CBATeam/CBA_A3/blob/7ff35f7544493ca93c4d0047245333a720245163/addons/hashes/fnc_parseJSON.sqf
nodegen_fromJson = {
    params ["_json"];

    // Wrappers for creating "objects" and setting values on them
    // private _createObject = { createHashMap };
    // private _objectSet = {
    //         params ["_obj", "_key", "_val"];
    //         _obj set [_key, _val];
    // };
    

    //ordered dict
    private _createObject = CBA_fnc_hashCreate;
    private _objectSet = CBA_fnc_hashSet;

    // Handles escaped characters, except for unicode escapes (\uXXXX)
    private _unescape = {
        params ["_char"];

        switch (_char) do {
            case """": { """" };
            case "\": { "\" };
            case "/": { "/" };
            case "b": { toString [8] };
            case "f": { toString [12] };
            case "n": { endl };
            case "r": { toString [13] };
            case "t": { toString [9] };
            default { "" };
        };
    };

    // Splits the input string into tokens
    // Tokens can be numbers, strings, null, true, false and symbols
    // Strings are prefixed with $ to distinguish them from symbols
    private _tokenize = {
        params ["_input"];

        // Split string into chars, works with unicode unlike splitString
        _input = toArray _input apply {toString [_x]};

        private _tokens  = [];
        private _numeric = "+-.0123456789eE" splitString "";
        private _symbols = "{}[]:," splitString "";
        private _consts  = "tfn" splitString "";

        while {count _input > 0} do {
            private _c = _input deleteAt 0;

            switch (true) do {
                // Symbols ({}[]:,) are passed directly into the tokens
                case (_c in _symbols): {
                    _tokens pushBack _c;
                };

                // Number parsing
                // This can fail with some invalid JSON numbers, like e10
                // Those would require some additional logic or regex
                // Valid numbers are all parsed correctly though
                case (_c in _numeric): {
                    private _numStr = _c;
                    while { _c = _input deleteAt 0; !isNil "_c" && {_c in _numeric} } do {
                        _numStr = _numStr + _c;
                    };
                    _tokens pushBack parseNumber _numStr;

                    if (!isNil "_c") then {
                        _input = [_c] + _input;
                    };
                };

                // true, false and null
                // Only check first char and assume JSON is valid
                case (_c in _consts): {
                    switch (_c) do {
                        case "t": {
                            _input deleteRange [0, 3];
                            _tokens pushBack true;
                        };
                        case "f": {
                            _input deleteRange [0, 4];
                            _tokens pushBack false;
                        };
                        case "n": {
                            _input deleteRange [0, 3];
                            _tokens pushBack objNull;
                        };
                    };
                };

                // String parsing
                case (_c == """"): {
                    private _str = "$";

                    while {true} do {
                        _c = _input deleteAt 0;

                        if (_c == """") exitWith {};

                        if (_c == "\") then {
                            _str = _str + ((_input deleteAt 0) call _unescape);
                        } else {
                            _str = _str + _c;
                        };
                    };

                    _tokens pushBack _str;
                };
            };
        };

        _tokens
    };

    // Appends the next token to the parsing stack
    // Returns true unless no more tokens left
    private _shift = {
        params ["_parseStack", "_tokens"];

        if (count _tokens > 0) then {
            _parseStack pushBack (_tokens deleteAt 0);
            true
        } else {
            false
        };
    };

    // Tries to reduce the current parsing stack (collect arrays or objects)
    // Returns true if parsing stack could be reduced
    private _reduce = {
        params ["_parseStack", "_tokens"];

        // Nothing to reduce
        if (count _parseStack == 0) exitWith { false };

        // Check top of stack
        switch (_parseStack#(count _parseStack - 1)) do {

            // Reached end of array, time to collect elements
            case "]": {
                private _array = [];

                // Empty arrays need special handling
                if (_parseStack#(count _parseStack - 2) isNotEqualTo "[") then {
                    // Get next token, if [ beginning is reached, otherwise assume
                    // valid JSON and that the token is a comma
                    while {_parseStack deleteAt (count _parseStack - 1) != "["} do {
                        private _element = _parseStack deleteAt (count _parseStack - 1);

                        // Remove $ prefix from string
                        if (_element isEqualType "") then {
                            _element = _element select [1];
                        };

                        _array pushBack _element;
                    };

                    reverse _array;
                } else {
                    _parseStack resize (count _parseStack - 2);
                };

                _parseStack pushBack _array;
                true
            };

            // Reached end of array, time to collect elements
            // Works very similar to arrays
            case "}": {
                private _object = [] call _createObject;
               
                // Empty objects need special handling
                if (_parseStack#(count _parseStack - 2) isNotEqualTo "{") then {
                    // Get next token, if { beginning is reached, otherwise assume
                    // valid JSON and that token is comma
                    while {_parseStack deleteAt (count _parseStack - 1) != "{"} do {
                        private _value = _parseStack deleteAt (count _parseStack - 1);
                        private _colon = _parseStack deleteAt (count _parseStack - 1);
                        private _name  = _parseStack deleteAt (count _parseStack - 1);
                        ["checkkeyp %1 -> %2",_name,typename _value] call printWarning;
                        // Remove $ prefix from strings
                        if (_value isEqualType "") then {
                            _value = _value select [1];
                        };
                        _name = _name select [1];

                        [_object, _name, _value] call _objectSet;

                        reverse (_object select 1);
                        reverse (_object select 2);
                    };
                } else {
                    _parseStack resize (count _parseStack - 2);
                };

                _parseStack pushBack _object;
                true
            };

            default {
                false
            };
        };
    };

    // Simple shift-reduce parser
    private _parse = {
        params ["_tokens"];
        private _parseStack = [];
        private _params = [_parseStack, _tokens];

        while { _params call _reduce || {_params call _shift} } do {};

        if (count _parseStack != 1) then {
            nil
        } else {
            private _object = _parseStack#0;

            // If JSON is just a string, remove $ prefix from it
            if (_object isEqualType "") then {
                _object = _object select [1];
            };

            _object
        };
    };

    [_json call _tokenize] call _parse
};