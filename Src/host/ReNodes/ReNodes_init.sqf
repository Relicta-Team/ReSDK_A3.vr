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


*/

//текущая версия библиотеки для генерации
nodegen_const_libversion = 1;
//карта рабочих узлов. Ключ - системное название узла, значение - данные типа хэшкарты
nodegen_map_library = createHashMap;

nodegen_internal_generatedLib = ""; //сюда записывается сгенерированный json файл

//регистратор функции
nodegen_addFunctionToLib = {
    private _ctx = _this;
    _ctx call nodegen_commonAdd;
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

nodegen_commonAdd = {
    private _ctx = _this;
    private _arr = null;
    call {
        _arr = parseSimpleArray _ctx;
    };
    assert(!isNullVar(_arr));
    private _map = createHashMapFromArray _arr;
    
};

nodegen_generateLib = {
    if (!is3DEN) exitwith {
        setLastError("NodeGen cannot generate library outside ReEditor");
        false
    };

    true
};