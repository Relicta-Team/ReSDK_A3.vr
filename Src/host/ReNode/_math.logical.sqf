// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


node_system_group("math.logical")

"
    node:makeLiteralBool
    name:Создать буквальное булево
    desc:Создает значение типа булево
    path:Математика.Логические
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:@in.1
    in:bool:Значение
        opt:dname=0
    out:bool:Значение
        opt:dname=0
" node_system

"
    node:notBool
    name:НЕ
    namelib:Отрицание
    desc:Логическое отрицание. Не ИСТИНА - ЛОЖЬ. НЕ ЛОЖЬ - ИСТИНА
    rendertype:NoHeaderText
    exec:pure
    code:!(@in.1)
    in:bool:Значение
    out:bool:Равно
" node_system

"
    node:boolAnd
    name:И
    desc:Логическое ""И"". Возвращает ЛОЖЬ, если хотя бы одно из значений является ложью. В противоположных случаях возвращает ИСТИНА.\n"+
    "ИСТИНА И ЛОЖЬ = ЛОЖЬ, ЛОЖЬ И ЛОЖЬ = ЛОЖЬ, ИСТИНА И ИСТИНА = ИСТИНА, ЛОЖЬ И ИСТИНА = ЛОЖЬ
    rendertype:NoHeaderText
    exec:pure
    code:(@in.1)&&(@in.2)
    in:bool:Значение 1
    in:bool:Значение 2
    out:bool:Результат
" node_system

"
    node:boolOr
    name:ИЛИ
    desc:Логическое ""ИЛИ"". Возвращает ИСТИНА, если хотя бы одно из значений является истиной. В противоположных случая возвращает ЛОЖЬ.\n"+
    "ИСТИНА ИЛИ ЛОЖЬ = ИСТИНА, ЛОЖЬ ИЛИ ЛОЖЬ = ЛОЖЬ, ИСТИНА ИЛИ ИСТИНА = ИСТИНА, ЛОЖЬ ИЛИ ИСТИНА = ИСТИНА
    rendertype:NoHeaderText
    exec:pure
    code:(@in.1)||(@in.2)
    in:bool:Значение 1
    in:bool:Значение 2
    out:bool:Результат
" node_system

"
    node:valuesEqual
    name:==
    namelib:Равны
    desc:Сравнивает два значения. Если они равны - возвращает ИСТИНУ. В иных случая возвращает ЛОЖЬ.
    rendertype:NoHeaderText
    exec:pure
    code:(@in.1)isequalto(@in.2)
    in:auto:Значение 1
    in:auto:Значение 2
    out:bool:Равно
" node_system

"
    node:valuesNotEqual
    name:!=
    namelib:Не равны
    desc:Сравнивает два значения. Если они не равны - возвращает ИСТИНУ. В инных случая возвращает ЛОЖЬ.
    rendertype:NoHeaderText
    exec:pure
    code:(@in.1)isnotequalto(@in.2)
    in:auto:Значение 1
    in:auto:Значение 2
    out:bool:Равно
" node_system

// refchecks

"
    node:equalRefs
    name:Ссылки равны
    desc:Сравнивает два значения. Если их ссылки равны - возвращает ИСТИНУ. В иных случая возвращает ЛОЖЬ.
    rendertype:NoHeaderText
    exec:pure
    code:(@in.1)isEqualRef(@in.2)
    in:auto:Значение 1
    in:auto:Значение 2
    out:bool:Результат
" node_system

// "
//     node:notEqualRefs
//     name:Ссылки не равны
//     desc:Сравнивает два значения
//     rendertype:NoHeaderText
//     exec:pure
//     code:(@in.1)isNotEqualRef(@in.2)
//     in:auto:Значение 1
//     in:auto:Значение 2
//     out:bool:Результат
// " node_system


// "
//     node:typesEqual
//     name:Типы равны
//     desc:Сравнивает два типа данных. Если их типы равны - возвращает ИСТИНУ. В иных случая возвращает ЛОЖЬ. При сравнении двух объектов всегда возвращается истина.
//     rendertype:NoHeaderText
//     exec:pure
//     code:(@in.1)isequaltype(@in.2)
//     in:auto:Значение 1
//     in:auto:Значение 2
//     out:bool:Результат
// " node_system

// "
//     node:typesNotEqual
//     name:Типы не равны
//     desc:Сравнивает два типа данных
//     rendertype:NoHeaderText
//     exec:pure
//     code:!((@in.1)isequaltype(@in.2))
//     in:auto:Значение 1
//     in:auto:Значение 2
//     out:bool:Результат
// " node_system
