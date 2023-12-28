node_system_group("conversion")

//toString
"
    node:valueToString
    name:В строку
    path:Преобразования
    desc:Преобразует значение в строку
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:format[""%1"",@in.1]
    in:auto:Значение
        opt:typeget=ANY;@type
    out:string:Строка
" node_system

_convFunc = {
    params ["_name","_code","_in","_out",["_desc","Преобразование"]]
    (_in splitString ":")params ["_intype","_inname"];
    (_out splitString ":")params ["_outtype","_outname"];
format["
    node:%1
    name:%3 -> %4
    desc:%5
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:%2
    in:%6
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
(["intToBool","(@in.1) > 0","int:Целое число","bool:Булево","Преобразование целого числа в логическое значение"] call _convFunc) node_system
//floatToBool
(["floatToBool","(@in.1) > 0","float:Число","bool:Булево","Преобразование дробного числа в логическое значение"] call _convFunc) node_system
//boolToInt
(["boolToInt","if(@in.1)then{1}else{0}","bool:Булево","int:Целое число","Преобразование логического значения в целое число"] call _convFunc) node_system
//boolToFloat
(["boolToFloat","if(@in.1)then{1}else{0}","bool:Булево","float:Число","Преобразование логического значения в дробное число"] call _convFunc) node_system
//stringToBool
(["stringToBool","(trim(@in.1)==""true"")","string:Строка","bool:Булево","Преобразование строки в логическое значение"] call _convFunc) node_system
//boolToString -> use valueToString
//(["boolToString","str(@in.1)","bool:Булево","string:Строка","Преобразование логического значения в строку"] call _convFunc) node_system