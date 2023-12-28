node_system_group("logical")

"
    node:notBool
    name:Отрицание
    desc:Логическое отрицание
    path:Логические
    exec:pure
    code:!(@in.1)
    in:bool:Значение
    out:bool:Равно
" node_system

"
    node:boolAnd
    name:И
    desc:Логическое И
    exec:pure
    code:(@in.1)&&(@in.2)
    in:bool:Значение 1
    in:bool:Значение 2
    out:bool:Результат
" node_system

"
    node:boolOr
    name:ИЛИ
    desc:Логическое ИЛИ
    exec:pure
    code:(@in.1)||(@in.2)
    in:bool:Значение 1
    in:bool:Значение 2
    out:bool:Результат
" node_system

"
    node:valuesEqual
    name:Равны
    desc:Сравнивает два значения
    exec:pure
    code:(@in.1)isequalto(@in.2)
    in:auto:Значение 1
    in:auto:Значение 2
    out:bool:Равно
" node_system

"
    node:valuesNotEqual
    name:Не равны
    desc:Сравнивает два значения
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
    desc:Сравнивает два значения
    exec:pure
    code:(@in.1)isEqualRef(@in.2)
    in:auto:Значение 1
    in:auto:Значение 2
    out:bool:Результат
" node_system

"
    node:nullref
    name:Объект удален
    namelib:Объект удален (null)
    desc:Проверяет существование объекта
    exec:pure
    code:ISNULL (@in.1)
    in:object^:Ссылка на объект
    out:bool:Результат
" node_system

// "
//     node:notEqualRefs
//     name:Ссылки не равны
//     desc:Сравнивает два значения
//     exec:pure
//     code:(@in.1)isNotEqualRef(@in.2)
//     in:auto:Значение 1
//     in:auto:Значение 2
//     out:bool:Результат
// " node_system


"
    node:typesEqual
    name:Типы равны
    desc:Сравнивает два типа данных
    exec:pure
    code:(@in.1)isequaltype(@in.2)
    in:auto:Значение 1
    in:auto:Значение 2
    out:bool:Результат
" node_system

// "
//     node:typesNotEqual
//     name:Типы не равны
//     desc:Сравнивает два типа данных
//     exec:pure
//     code:!((@in.1)isequaltype(@in.2))
//     in:auto:Значение 1
//     in:auto:Значение 2
//     out:bool:Результат
// " node_system
