node_system_group("string")

"
    node:stringMake
    path:Строки
    name:Создать строку
    icon:data\\icons\\pill_16x.png
    runtimeports:1
    autocoloricon:0
    exec:pure
    code:[ @genport.in.( ,) ] joinString """"
    in:string:Строка
" node_system

//splitstring
"
    node:splitString
    name:Разбить строку
    desc:Разбивает строку на массив строк с указанным разделителем.
    icon:data\\icons\\pill_16x.png
    exec:pure
    code: (@in.1) splitString (@in.2)
    in:string:Строка
    in:string:Разделитель
    out:array[string]:Массив строк
" node_system

//joinstring
"
    node:joinString
    name:Объединить строки
    desc:Объединяет массив строк с указанным разделителем.
    icon:data\\icons\\pill_16x.png
    exec:pure
    code: (@in.1) joinString (@in.2)
    in:array[string]:Массив строк
    in:string:Комбинатор:Строка, которая будет объединять соседние элементы массива строк.
    out:string:Строка
" node_system

//count
"
    node:stringCount
    name:Количество символов
    desc:Возвращает количество символов в строке.
    icon:data\\icons\\pill_16x.png
    exec:pure
    code: [@in.1,@in.2] call stringLength
    in:string:Строка
    in:bool:Как количество:При флаге false символы кириллицы (русские буквы) считаются как 2 символа, так как занимают 2 байта. Иными словами, с флагом true считается количество символов в строке, а с false считается количество байт в строке.
    out:int:Размер
" node_system

//toArray
"
    node:stringToCharArray
    name:Строка в массив
    desc:Преобразует строку в массив чисел. Каждый элемент массива является номером символа в Юникоде.
    icon:data\\icons\\pill_16x.png
    exec:pure
    code: toArray(@in.1)
    in:string:Строка
    out:array[int]:Массив 
" node_system

//toString
"
    node:charArrayToString
    name:Массив в строку
    desc:Преобразует массив чисел в строку
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:toString(@in.1)
    in:array[int]:Массив
    out:string:Строка
" node_system

//select
"
    node:selectString
    name:Выбрать подстроку
    desc:Выбирает подстроку из строки
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:[@in.1,@in.2,@in.3] call stringSelect
    in:string:Строка
    in:int:Старт:Стартовый индекс, с которого начинается подстрока
    in:int:Длина:Длина подстроки
    out:string:Подстрока
" node_system

//toUpper
"
    node:stringToUpper
    name:Верхний регистр
    desc:Преобразует строку в верхний регистр
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:toUpper(@in.1)
    in:string:Строка
    out:string:Строка
" node_system

//toLower
"
    node:stringToLower
    name:Нижний регистр
    desc:Преобразует строку в нижний регистр
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:toLower(@in.1)
    in:string:Строка
    out:string:Строка
" node_system

//endl
"
    node:stringEndl
    name:Новая строка
    desc:Добавляет новую строку
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:endl
    out:string:Новая строка
" node_system

//format
"
    node:stringFormat
    name:Форматировать
    desc:Форматирует строку. Указанные элементы внутри строки можно получить с помощью %1, %2 и т.д.
    icon:data\\icons\\pill_16x.png
    exec:pure
    code:format[@in.1,@genport.in.( ,)]
" node_system