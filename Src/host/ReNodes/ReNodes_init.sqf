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

nodegen_debug_copyobjlibPath = "P:\Project\ReNodes\lib_obj.json";

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
    
    if (!isNull(nodegen_debug_copyobjlibPath) && {nodegen_debug_copyobjlibPath!=""}) then {
        [nodegen_debug_copyobjlibPath,nodegen_str_outputJsonData,false] call file_write;
    };

    true
};


nodegen_const_addNodeModif = {
    params ["_type"];
};

nodegen_const_getNodePortColor = {
    params ["_portName"];
    private _tempMap = createHashMapFromArray [
        ["flow","color:C7C7C7"],
        ["bool","color:A60C0C"],
        ["number","color:128500"],
        ["string","color:D95A00"],
        ["object","color:B502AF"],
        ["vector","color:D4A004"],
        ["array","color:1698B5"],
        ["hashmap","color:4C27C2"],
        ["hashset","color:871BC2"],
        ["handle","color:03CC00"],
        ["model","color:AB0330"]
    ];

    private _data = _tempMap getOrDefault [_portName,""];
    {
        (_x splitString ":")params [["_k",""],["_v",""]];
        assert(_k!="");
        assert(_v!="");
    } foreach (_data splitString ";");
};