node_system_group("math")

_op = {
    params ["_sysname","_namelib","_code","_rez","_desc",["_rvvals","auto"]];
    (_namelib splitString ":")params ["_nlTex","_nlDesc"];

    format["
        node:%1
        name:%2
        namelib:%3 (%2)
        path:Математика
        exec:pure
        desc:%4
        code:%5
        in:%7:Число 1
            opt:typeget=value;@type:allowtypes=int|float:dname=0
        in:%7:Число 2
            opt:typeget=value;@type:allowtypes=int|float:dname=0
        out:%6:Результат
            opt:typeget=value;@type:allowtypes=int|float:dname=0
    ",_sysname,_nlTex,_nlDesc,_desc,_code,_rez,_rvvals]
};

// +
(["add","Сложение:+","(@in.1)+(@in.2)","auto","Сложение двух чисел"] call _op) node_system
// -
(["sub","Вычитание:-","(@in.1)-(@in.2)","auto","Вычитание двух чисел"] call _op) node_system
// *
(["mul","Умножение:*","(@in.1)*(@in.2)","float","Умножение двух чисел"] call _op) node_system
// /
(["div","Деление:/","(@in.1)/(@in.2)","float","Деление двух чисел"] call _op) node_system
// %
(["mod","Остаток от деления:%","(@in.1)%(@in.2)","int","Остаток от деления двух чисел"] call _op) node_system
// ^ (pow)
(["pow","Степень:^","(@in.1)^(@in.2)","float","Возведение числа 1 в степень числа 2","int"] call _op) node_system
// abs
"
    node:absnum
    name:Абсолютное значение
    desc:Абсолютное значение числа. -3 будет 3, -3.5 будет 3.5, 3 будет 3
    exec:pure
    code:abs(@in.1)
    in:auto:Число
        opt:typeget=value;@type:allowtypes=int|float:dname=0
    out:auto:Абсолютное значение
        opt:typeget=value;@type:allowtypes=int|float:dname=0
" node_system

//comp operations

// <
(["lessthannum","Меньше:<","(@in.1)<(@in.2)","bool","Сравнение двух чисел"] call _op) node_system
// >
(["greaterthannum","Больше:>","(@in.1)>(@in.2)","bool","Сравнение двух чисел"] call _op) node_system
// <=
(["lessthanorequalnum","Меньше или равно:<=","(@in.1)<=(@in.2)","bool","Сравнение двух чисел"] call _op) node_system
// >=
(["greaterthanorequalnum","Больше или равно:>=","(@in.1)>=(@in.2)","bool","Сравнение двух чисел"] call _op) node_system
// ==
(["equalnum","Равно:==","(@in.1)==(@in.2)","bool","Сравнение двух чисел"] call _op) node_system
// !=
(["notequalnum","Не равно:!=","(@in.1)!=(@in.2)","bool","Сравнение двух чисел"] call _op) node_system

// others

//min
(["min","Минимум:Min","(@in.1)Min(@in.2)","auto","Выбирает меньшее из двух чисел"] call _op) node_system
//max
(["max","Максимум:Max","(@in.1)Max(@in.2)","auto","Выбирает большее из двух чисел"] call _op) node_system

/*
#define rand(_beg,_end) (linearConversion [0,1,random 1,_beg,_end])
#define randInt(_beg,_end) (FLOOR linearConversion [0,1,random 1,(_beg)min(_end),(_end)max(_beg)+1])
*/

//random
(["random","Случайное число:Rand","[@in.1,@in.2]call randomFloat","float","Случайное число в диапазоне"] call _op) node_system
//random int
(["randomInt","Случайное целое число:RandInt","[@in.1,@in.2]call randomInt","int","Случайное целое число в диапазоне"] call _op) node_system
//clamp
"
        node:clamp
        name:Ограничение
        namelib:Ограничение числа
        exec:pure
        desc:Ограничивает входное число диапазоном между нижней и верхней границей
        code:[@in.1,@in.2,@in.3]call clampNumber
        in:auto:Число
            opt:typeget=value;@type:allowtypes=int|float:dname=0
        in:auto:Нижняя граница
            opt:typeget=value;@type:allowtypes=int|float:dname=0
        in:auto:Верхняя граница
            opt:typeget=value;@type:allowtypes=int|float:dname=0
        out:float:Результат
            opt:typeget=value;@type:allowtypes=int|float:dname=0
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
        exec:pure
        desc:%4
        code:%5
        in:%7:Число
            opt:typeget=value;@type:allowtypes=int|float:dname=0
        out:%6:Результат
            opt:typeget=value;@type:allowtypes=int|float:dname=0
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
    exec:pure
    desc:Постоянное число Пи (3.141592653589...)
    code:PI
    out:float:Число Пи
" node_system

//sqrt
(["sqrt","Квадратный корень:Квадратный корень","sqrt(@in.1)","float","Квадратный корень числа"] call _opSingle) node_system
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
(["atan2","Арктангенс:Atan2","(@in.1)atan2(@in.2)","float","a = atan (L1/L2) -> a = L1 atan2 L2. Подробнее <a href=\""https\://community.bistudio.com/wiki/atan2"">по ссылке</a>"""] call _op) node_system
