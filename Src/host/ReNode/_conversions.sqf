// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


node_system_group("conversion")

//toString
"
    node:valueToString
    name:В строку
    path:Преобразования
    desc:Преобразует значение в строку
    rendertype:NoHeaderText
    exec:pure
    code:format[""%1"",@in.1]
    in:auto:Значение
        opt:typeget=ANY;@type
    out:string:Строка
" node_system

"
    node:anyToBool
    name:В булево
    path:Преобразования
    desc:Преобразует любое значение в булево. Любые числа, равные нулю, инвалидные объекты (null-ссылки) преобразуются в @[bool ЛОЖЬ]. Во всех остальных случаях выполняется преобразование в @[bool ИСТИНА].
    rendertype:NoHeaderText
    exec:pure
    code:[@in.1]call rv_cppcheck
    in:auto:Значение
        opt:typeget=ANY;@type
    out:bool:Результат
" node_system

_convFunc = {
    params ["_name","_code","_in","_out",["_desc","Преобразование"]];
    (_in splitString ":")params ["_intype","_inname"];
    (_out splitString ":")params ["_outtype","_outname"];
format["
    node:%1
    name:•
    namelib:%3 -> %4
    desc:%5
    rendertype:NoHeaderText
    exec:pure
    code:%2
    in:%6
        opt:custom=0
    out:%7
" ,_name,_code,_inname,_outname,_desc,_in,_out]
};
//stringToInt
(["stringToInt","floor parseNumber (@in.1)","string:Строка","int:Целое число","Операция преобразования строки в целое число. Дробная часть будет отброшена при наличии."] call _convFunc) node_system
//stringToFloat
(["stringToFloat","parseNumber (@in.1)","string:Строка","float:Число","Операция преобразования строки в дробное число."] call _convFunc) node_system
//floatToInt
(["floatToInt","floor (@in.1)","float:Число","int:Целое число","Преобразование дробного числа в целое число. Дробная часть будет отброшена."] call _convFunc) node_system
//intToFloat
(["intToFloat","@in.1","int:Целое число","float:Число","Преобразование целого числа в дробное число."] call _convFunc) node_system

//intToBool
(["intToBool","(@in.1)==0","int:Целое число","bool:Булево","Преобразование целого числа в логическое значение"] call _convFunc) node_system
//floatToBool
(["floatToBool","(@in.1)==0","float:Число","bool:Булево","Преобразование дробного числа в логическое значение"] call _convFunc) node_system
//boolToInt
(["boolToInt","[0,1]select(@in.1)","bool:Булево","int:Целое число","Преобразование логического значения в целое число"] call _convFunc) node_system
//boolToFloat
(["boolToFloat","[0,1]select(@in.1)","bool:Булево","float:Число","Преобразование логического значения в дробное число"] call _convFunc) node_system
//stringToBool
(["stringToBool","(trim(@in.1)==""true"")","string:Строка","bool:Булево","Преобразование строки в логическое значение"] call _convFunc) node_system
//arrayToBool
(["arrayToBool","(count (@in.1) > 0)","auto:Массив" opt "typeget=array;@type","bool:Булево","Преобразование массива в логическое значение. Пустой массив является @[bool ЛОЖЬЮ], не пустой - @[bool ИСТИНОЙ]."] call _convFunc) node_system
//objectToBool
(["objectToBool","!ISNULL(@in.1)","object^:Объект","bool:Булево","Преобразование объекта в логическое значение. Валидный (существующий) объект является @[bool ИСТИНОЙ], несуществующий (удаленный) - @[bool ЛОЖЬЮ]."] call _convFunc) node_system

//boolToString -> use valueToString
//(["boolToString","str(@in.1)","bool:Булево","string:Строка","Преобразование логического значения в строку"] call _convFunc) node_system

//handleToInt
(["handleToInt","@in.1","handle:Объект","int:Целое число","Преобразование handle в целое число"] call _convFunc) node_system

//vector3ToArray
(["vector3ToArray","@in.1","vector3:Вектор 3D","array[float]:Массив","Преобразование трехмерного вектора в массив из трех элементов."] call _convFunc) node_system
//vector2ToArray
(["vector2ToArray","@in.1","vector2:Вектор 2D","array[float]:Массив","Преобразование двухмерного вектора в массив из двух элементов."] call _convFunc) node_system
//arrayToVector3
(["arrayToVector3","(@in.1)select[0,3]","array[float]:Массив","vector3:Вектор 3D","Преобразование массива в трехмерный вектор."] call _convFunc) node_system
//arrayToVector2
(["arrayToVector2","(@in.1)select[0,2]","array[float]:Массив","vector2:Вектор 2D","Преобразование массива в двухмерный вектор"] call _convFunc) node_system


//colorToArray
(["colorToArray","@in.1","color:Цвет","array[float]:Массив","Преобразование цвета в массив"] call _convFunc) node_system
//arrayToColor
(["arrayToColor","(@in.1)select[0,4]","array[float]:Массив","color:Цвет","Преобразование массива в цвет"] call _convFunc) node_system
//colorToString
//!(["colorToString","@in.1","color:Цвет","string:Строка","Преобразование цвета в html-строку"] call _convFunc) node_system

//string to classname
"
    node:stringToClassname
    name:Строку в имя класса
    path:Преобразования
    desc:Преобразует строку в имя класса. Если полученная строка не является валидным именем класса - вернет имя класса по умолчанию.
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:"+'[@in.1,@in.2] call oop_checkTypeSafe'+"
    in:string:Строка:Строчное представление имени класса, которое будет преобразовано
    in:classname:По умолчанию:Возвращаемое значение в случае возникновения ошибки (когда указанный класс не найден)
    out:classname:Имя класса:Имя класса полученное из строки или из значения по умолчанию в случае ошибки.
" node_system

"
    node:classnameToType
    name:Имя класса в класс
    desc:Получает класс по имени. Если имя класса не существует - функция вернет null объект.
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:missionnamespace getvariable [@in.1,nullPtr]
    in:classname:Имя
    out:class:Тип
" node_system

//enum helpers
(["enumToInt","@in.1","auto:Перечилсение" opt "allowtypes=*enum","int:Число","Преобразование значения перечисления в целое число"] call _convFunc) node_system
(["enumToString","enum_vToK_@gettype.in.1 get str(@in.1)","auto:Перечисление" opt "allowtypes=*enum","string:Имя","Преобразование значения перечисления в его название"] call _convFunc) node_system

(["structToList","@in.1","auto:Структура"+endl+"opt:allowtypes=*struct","list:Лист"]call _convFunc) node_system

//voidToValue
(
    (["voidToValue","@in.1","void:Любое","auto:Значение
        opt:typeget=ANY;@type","Преобразование любого значения в значение"] call _convFunc)
) node_system
//valueToVoid
(
    (["valueToVoid","@in.1","auto:Значение
        opt:typeget=ANY;@type","void:Любое","Преобразование значения в любое значение"] call _convFunc)
) node_system