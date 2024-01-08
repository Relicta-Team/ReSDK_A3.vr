// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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
//boolToString -> use valueToString
//(["boolToString","str(@in.1)","bool:Булево","string:Строка","Преобразование логического значения в строку"] call _convFunc) node_system

//handleToInt
(["handleToInt","@in.1","handle:Объект","int:Целое число","Преобразование handle в целое число"] call _convFunc) node_system

//vector3ToArray
(["vector3ToArray","@in.1","vector3:Вектор","array[float]:Массив","Преобразование трехмерного вектора в массив"] call _convFunc) node_system
//vector2ToArray
(["vector2ToArray","@in.1","vector2:Вектор","array[float]:Массив","Преобразование двухмерного вектора в массив"] call _convFunc) node_system
//arrayToVector3
(["arrayToVector3","(@in.1)select[0,3]","array[float]:Массив","vector3:Вектор","Преобразование массива в трехмерный вектор"] call _convFunc) node_system
//arrayToVector2
(["arrayToVector2","(@in.1)select[0,2]","array[float]:Массив","vector2:Вектор","Преобразование массива в двухмерный вектор"] call _convFunc) node_system


//colorToArray
(["colorToArray","@in.1","color:Цвет","array[float]:Массив","Преобразование цвета в массив"] call _convFunc) node_system
//arrayToColor
(["arrayToColor","(@in.1)select[0,4]","array[float]:Массив","color:Цвет","Преобразование массива в цвет"] call _convFunc) node_system
//colorToString
//!(["colorToString","@in.1","color:Цвет","string:Строка","Преобразование цвета в html-строку"] call _convFunc) node_system


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