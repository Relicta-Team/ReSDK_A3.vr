// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


node_system_group("math")

_op = {
    params ["_sysname","_namelib","_code","_rez","_desc",["_rvvals","auto"],["_alwTps","int|float"]];
    (_namelib splitString ":")params ["_nlTex","_nlDesc"];

    _ctypes = "";
    if (_rvvals == "auto") then {
        _ctypes = ":custom=1:custom_type=float:require=-1"; //require=-1 for off nil emplace for non-connected ports
    };
    
    _nlDesc = format["%1 (%2)",_nlDesc,_nlTex];
    if ("&lt;" in _nlTex) then {
        _nlDesc = [_nlDesc,"&lt;","<"] call stringReplace;
    };
    if ("&gt;" in _nlTex) then {
        _nlDesc = [_nlDesc,"&gt;",">"] call stringReplace;
    };

    format["
        node:%1
        name:%2
        namelib:%3
        path:Математика
        rendertype:NoHeaderText
        exec:pure
        desc:%4
        code:%5
        in:%7:Число 1
            opt:typeget=value;@type:allowtypes=%8%9
        in:%7:Число 2
            opt:typeget=value;@type:allowtypes=%8%9
        out:%6:Результат
            opt:typeget=value;@type:allowtypes=%8
    ",_sysname,_nlTex,_nlDesc,_desc,_code,_rez,_rvvals,_alwTps,_ctypes]
};

"
    node:makeLiteralInt
    name:Создать буквальное целое число
    desc:Создает значение типа целое число
    path:Математика
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:@in.1
    in:int:Значение
        opt:dname=0
    out:int:Значение
        opt:dname=0
" node_system

"
    node:makeLiteralFloat
    name:Создать буквальное число
    desc:Создает значение типа дробное число
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:@in.1
    in:float:Значение
        opt:dname=0
    out:float:Значение
        opt:dname=0
" node_system

// +
(["add","+:Сложение","(@in.1)+(@in.2)","auto","Сложение двух чисел"] call _op) node_system
// -
(["sub","-:Вычитание","(@in.1)-(@in.2)","auto","Вычитание двух чисел"] call _op) node_system
// *
(["mul","*:Умножение","(@in.1)*(@in.2)","float","Умножение двух чисел"] call _op) node_system
// /
(["div","/:Деление","(@in.1)/(@in.2)","float","Деление двух чисел"] call _op) node_system
// %
(["mod","MOD:Остаток от деления","(@in.1)%(@in.2)","int","Остаток от деления двух чисел. 5 % 2 равно 1 (2 * 2 + 1)"] call _op) node_system
// ^ (pow)
(["pow","POW:Степень","(@in.1)^(@in.2)","float","Возведение числа 1 в степень числа 2","int"] call _op) node_system
// abs
"
    node:absnum
    name:ABS
    desc:Абсолютное значение числа. -3 будет 3, -3.5 будет 3.5, 3 будет 3
    exec:pure
    rendertype:NoHeaderText
    code:abs(@in.1)
    in:auto:Число
        opt:typeget=value;@type:allowtypes=int|float
    out:auto:Абсолютное значение
        opt:typeget=value;@type:allowtypes=int|float
" node_system

//comp operations

// <
(["lessthannum","&lt;:Меньше","(@in.1)<(@in.2)","bool","Сравнение двух чисел",nil,"int|float|*enum"] call _op) node_system
// >
(["greaterthannum","&gt;:Больше","(@in.1)>(@in.2)","bool","Сравнение двух чисел",nil,"int|float|*enum"] call _op) node_system
// <=
(["lessthanorequalnum","&lt;=:Меньше или равно","(@in.1)<=(@in.2)","bool","Сравнение двух чисел",nil,"int|float|*enum"] call _op) node_system
// >=
(["greaterthanorequalnum","&gt;=:Больше или равно","(@in.1)>=(@in.2)","bool","Сравнение двух чисел",nil,"int|float|*enum"] call _op) node_system
// ==
(["equalnum","==:Равно","(@in.1)==(@in.2)","bool","Сравнение двух чисел",nil,"int|float|*enum"] call _op) node_system
// !=
(["notequalnum","!=:Не равно","(@in.1)!=(@in.2)","bool","Сравнение двух чисел",nil,"int|float|*enum"] call _op) node_system

// others

//min
(["min","MIN:Меньшее из двух","(@in.1)Min(@in.2)","auto","Выбирает меньшее из двух чисел"] call _op) node_system
//max
(["max","MAX:Большее из двух","(@in.1)Max(@in.2)","auto","Выбирает большее из двух чисел"] call _op) node_system

//random
(["random","Rand:Случайное число","[@in.1,@in.2]call randomFloat","float","Случайное число в диапазоне"] call _op) node_system
//random int
(["randomInt","RandInt:Случайное целое число","[@in.1,@in.2]call randomInt","int","Случайное целое число в диапазоне"] call _op) node_system
//clamp
"
        node:clamp
        name:Ограничение
        namelib:Ограничение числа
        rendertype:NoHeaderText
        exec:pure
        desc:Ограничивает входное число диапазоном между нижней и верхней границей
        code:[@in.1,@in.2,@in.3]call clampNumber
        in:auto:Число
            opt:typeget=value;@type:allowtypes=int|float:def=0:custom=1:custom_type=float:require=0
        in:auto:Нижняя граница
            opt:typeget=value;@type:allowtypes=int|float:def=0:custom=1:custom_type=float:require=0
        in:auto:Верхняя граница
            opt:typeget=value;@type:allowtypes=int|float:def=1:custom=1:custom_type=float:require=0
        out:float:Результат
            opt:typeget=value;@type:allowtypes=int|float
" node_system

//precentage
"
        node:percentage
        name:Процент от
        namelib:Процент от числа
        rendertype:NoHeaderText
        exec:pure
        desc:Получает процент от числа. Например, 50 процентов от числа 42 равно 21.
        code:[@in.1,@in.2] call getPrecentage
        in:auto:Число:Базовое число, от которого получаем процент.
            opt:typeget=value;@type:allowtypes=int|float:def=1:custom=1:custom_type=float:require=0
        in:auto:Процент:Процент от базового числа
            opt:typeget=value;@type:allowtypes=int|float:def=100:custom=1:custom_type=float:require=0
        out:float:Результат
            opt:typeget=value;@type:allowtypes=int|float
" node_system

//вероятность
"
        node:probably
        name:Prob
        namelib:Вероятность (Prob)
        rendertype:NoHeaderText
        exec:pure
        desc:Случайная вероятность в процентах. Если выпало значение, меньше указанной вероятности - возвращает истину.
        code:[@in.1] call randomProbably
        in:auto:Число:Значение процентов для вероятности. Значения, выше 100 всегда будут возвращать истину.
            opt:typeget=value;@type:allowtypes=int|float:def=50:custom=1:custom_type=float:require=0
        out:bool:Результат:Сработала ли вероятность
" node_system

// single operation
_opSingle = {
    params ["_sysname","_namelib","_code","_rez","_desc",["_val","auto"]];
    (_namelib splitString ":")params ["_nlTex","_nlDesc"];

    format["
        node:%1
        name:%2
        namelib:%3 (%2)
        path:Математика
        rendertype:NoHeaderText
        exec:pure
        desc:%4
        code:%5
        in:%7:Число
            opt:typeget=value;@type:allowtypes=int|float
        out:%6:Результат
            opt:typeget=value;@type:allowtypes=int|float
    ",_sysname,_nlTex,_nlDesc,_desc,_code,_rez,_val]
};

//floor 
(["floor","Целое вниз:Округление вниз","floor(@in.1)","int","Округление числа вниз до целого"] call _opSingle) node_system
//ceil
(["ceil","Целое вверх:Округление вверх","ceil(@in.1)","int","Округление числа вверх до целого"] call _opSingle) node_system
//round
(["round","Целое:Округление","round(@in.1)","int","Округление числа до целого"] call _opSingle) node_system


//pi
"
    node:piNumber
    name:Число Пи
    rendertype:NoHeaderText
    exec:pure
    desc:Константное (постоянное) число Пи (3.141592653589...)
    code:PI
    out:float:Число Пи
" node_system

//sqrt
(["sqrt","Квадратный корень:√","sqrt(@in.1)","float","Квадратный корень числа"] call _opSingle) node_system
//sin
(["sin","Синус:Sin","sin(@in.1)","float","Синус числа"] call _opSingle) node_system
//cos
(["cos","Косинус:Cos","cos(@in.1)","float","Косинус числа"] call _opSingle) node_system
//tg
(["tg","Тангенс:Tg","tg(@in.1)","float","Тангенс числа"] call _opSingle) node_system
//rad
(["rad","Градусы в радианы:Rad","rad(@in.1)","float","Градусы в радианы"] call _opSingle) node_system
//deg
(["deg","Радианы в градусы:Deg","deg(@in.1)","float","Радианы в градусы"] call _opSingle) node_system
//acos
(["acos","Арккосинус:Acos","acos(@in.1)","float","Арккосинус числа"] call _opSingle) node_system
//asin
(["asin","Арксинус:Asin","asin(@in.1)","float","Арксинус числа"] call _opSingle) node_system
//atan
(["atan","Арктангенс:Atan","atan(@in.1)","float","Арктангенс числа"] call _opSingle) node_system
//atan2
(["atan2","Арктангенс:Atan2","(@in.1)atan2(@in.2)","float","a = atan (L1/L2) -> a = L1 atan2 L2. Подробнее [community.bistudio.com/wiki/atan2 по ссылке]"] call _op) node_system
