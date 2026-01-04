// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
    desc:Логическое отрицание. Инвертирует истину в ложь а ложь - в истину:"+
    "\n@[bool Не ИСТИНА] => @[bool ЛОЖЬ]."+
    "\n@[bool Не ЛОЖЬ] => @[bool ИСТИНА]
    rendertype:NoHeaderText
    exec:pure
    code:!(@in.1)
    in:bool:Значение
    out:bool:Равно
" node_system

"
    node:boolAnd
    name:И
    desc:Логическое ""И"". Возвращает @[bool ЛОЖЬ], если хотя бы одно из значений является ложью. В противоположных случаях возвращает @[bool ИСТИНА].\n"+
    "@[bool ИСТИНА] И @[bool ЛОЖЬ] => @[bool ЛОЖЬ]"
    +"\n@[bool ЛОЖЬ] И @[bool ЛОЖЬ] => @[bool ЛОЖЬ]"+
    "\n@[bool ИСТИНА] И @[bool ИСТИНА] => @[bool ИСТИНА]"+
    "\n@[bool ЛОЖЬ] И @[bool ИСТИНА] => @[bool ЛОЖЬ]
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
    desc:Логическое ""ИЛИ"". Возвращает @[bool ИСТИНА], если хотя бы одно из значений является истиной. В противоположных случая возвращает @[bool ЛОЖЬ].\n"+
    "@[bool ИСТИНА] ИЛИ @[bool ЛОЖЬ] => @[bool ИСТИНА]"+
    "\n@[bool ЛОЖЬ] ИЛИ @[bool ЛОЖЬ] => @[bool ЛОЖЬ]"+
    "\n@[bool ИСТИНА] ИЛИ @[bool ИСТИНА] => @[bool ИСТИНА]"+
    "\n@[bool ЛОЖЬ] ИЛИ @[bool ИСТИНА] => @[bool ИСТИНА]
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
    desc:Сравнивает два значения. Если они равны - возвращает @[bool ИСТИНУ]. В иных случая возвращает @[bool ЛОЖЬ].
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
    desc:Сравнивает два значения. Если они не равны - возвращает @[bool ИСТИНУ]. В инных случая возвращает @[bool ЛОЖЬ].
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
    desc:Сравнивает два значения. Если их ссылки равны - возвращает @[bool ИСТИНУ]. В иных случая возвращает @[bool ЛОЖЬ].
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
//     desc:Сравнивает два типа данных. Если их типы равны - возвращает @[bool ИСТИНУ]. В иных случая возвращает @[bool ЛОЖЬ]. При сравнении двух объектов всегда возвращается истина.
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
