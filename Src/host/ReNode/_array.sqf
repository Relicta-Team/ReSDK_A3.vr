// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

node_system_group("array")

"
    node:makeArray
    path:Массивы
    name:Создать массив
    namelib:Создание массива
    desc:Создает массив из указанных элементов
    icon:data\\icons\\icon_Blueprint_MakeArray_16x.png
    color:PureFunction
    exec:pure
    code:[ @genport.in.1(,) ]
    in:auto:[0]
        opt:typeget=array;@value.1
    out:auto:Массив
        opt:typeget=array;@type
    option:""makeport_in""\: {""type""\: ""makeport_in"",""src""\:""[0]"",""text_format""\:""[{index}]""}
" node_system

"
    node:makeArrayEmpty
    path:Массивы
    name:Создать пустой массив
    namelib:Создание пустого массива
    desc:Создает пустой массив для возможности заполнения пользователем.
    icon:data\\icons\\icon_Blueprint_MakeArray_16x.png
    color:PureFunction
    exec:pure
    code:[]
    out:auto:Массив
        opt:typeget=array;@type
" node_system

"
    node:clearArray
    name:Очистить
    namelib:Очистить массив
    desc:Удаляет все элементы из массива, делая его пустым.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:(@in.2) resize 0; @out.1
    in:auto:Массив:Ссылка на массив, который будет очищен.
        opt:typeget=array;@type
" node_system

"
    node:pick
    name:Случайный элемент
    namelib:Случайный элемент
    desc:Выбирает случайный элемент из массива
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:SelectRandom(@in.1)
    in:auto:Массив:Массив, из которого будет выбран случайный элемент.
        opt:typeget=array;@type
    out:auto:Элемент:Случайный элемент из массива. Размер массива должен быть больше 0, иначе вернется null-значение а поведение станет неопределенным.
        opt:typeget=array;@value.1
" node_system

"
	node:get
	name:Получить элемент
	namelib:Получение элемента массива
	desc:Получает элемент массива по указанному индексу.
	icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
	code:(@in.1)select(@in.2)
	in:auto:Массив:Ссылка на массив, из которого будет выбран элемент.
		opt:typeget=array;@type
	in:int:Индекс:Индекс элемента массива. Отсчет начинается с 0. Для получения первого элемента массива используется индекс 0, а для последнего - количество элементов минус 1.
	out:auto:Элемент:Элемент массива, хранящийся по заданному индексу. Если вы не уверены, что ваш элемент существует по указанному индексу, сделайте предварительную проверку возможности получения элемента по этому индексу.
		opt:typeget=array;@value.1
"
node_system

"
    node:isValidIndex
    name:Индекс существует
    desc:Проверяет является ли индекс существующим (валидным), возвращая @[bool ИСТИНУ], если он находится в диапазоне размера массива. Для массива [5,6,7] индекс 4 будет инвалиден, а индекс 2 - валиден.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:[@in.1,@in.2] call arrayIsValidIndex
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
    in:int:Индекс:Проверяемый индекс
    out:bool:Существует:Возвращает true, если индекс существует для массива, иначе false
"
node_system

"
    node:lastIndex
    name:Последний индекс
    desc:Возвращает индекс последнего элемента массива. Если массив пустой - возвращает -1.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:count(@in.1)-1
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
    out:int:Индекс:Индекс последнего элемента массива. -1 если массив пустой
" node_system

"
    node:shuffle
    name:Перемешать
    desc:Перемешивает элементы массива в случайном порядке.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:[@in.2] call arrayShuffleOrig; @out.1
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
" node_system

"
    node:swap
    name:Заменить
    desc:Заменяет два элемента массива местами.
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:Function
    exec:all
    code:[@in.2,@in.3,@in.4] call arraySwap; @out.1
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
    in:int:Индекс 1:Индекс первого элемента
    in:int:Индекс 2:Индекс второго элемента
"
node_system

"
	node:set
	name:Установить элемент
	namelib:Установка элемента массива
	desc:Устанавливает элемент массива по указанному индексу.
	icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:Function
	exec:all
	code:(@in.2)set[@in.3,@in.4]; @out.1
	in:auto:Массив:Ссылка на массив, в котором будет установлен элемент по указанному индексу.
		opt:typeget=array;@type
	in:int:Индекс:Индекс элемента массива, по которому будет записан элемент. Отсчет начинается с 0. Для установки первого элемента массива используется индекс 0, а для последнего - количество элементов минус 1. Если в массиве по указанному индексу уже хранится элемент - он будет перезаписан.
	in:auto:Элемент:Элемент, который будет записан по указанному индексу. При установке элемента по индексу, который больше размера массива, он будет расширён а все промежуточные элементы будут заполнены null-значениями. Для избежания такой проблемы выполните проверку можно ли поместить элемент по заданному индексу в массив.
		opt:typeget=array;@value.1
" node_system

"
    node:copy
    name:Скопировать
    namelib:Скопировать массив
    desc:Данный узел делает полную (глубокую) копию переданного массива. После копирования при изменении копии не будет изменять исходный массив из которого выполнена копия.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    exec:pure
    code:+(@in.1)
    in:auto:Массив:Ссылка на массив, который будет скопирован.
        opt:typeget=array;@type
    out:auto:Массив:Скопированный массив. Любые изменения в этой копии не будут влиять на исходный массив.
        opt:typeget=array;@type
" node_system

//count
"
    node:count
    name:Количество элементов
    namelib:Количество элементов массива
    desc:Получает количество элементов массива. Если массив пустой, возвращает 0.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:count(@in.1)
    in:auto:Массив:Ссылка на массив с элементами.
        opt:typeget=array;@type
    out:int:Количество элементов
" node_system

//in
"
    node:in
    name:Содержит элемент
    desc:Проверяет наличие элемента в массиве.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:(@in.2)in(@in.1)
    in:auto:Массив:Проверяемый массив
        opt:typeget=array;@type
    in:auto:Элемент:Сравниваемый элемент
        opt:typeget=array;@value.1
    out:bool:Результат:Истина, если такой элемент присутствует в массиве, иначе ложь.
" node_system
//find
"
    node:find
    name:Найти элемент
    namelib:Поиск элемента
    desc:Поиск элемента в массиве.
    icon:data\\icons\\ArrayPin.png
    exec:pure
    rendertype:NoHeader
    autocoloricon:1
    code:(@in.1)find(@in.2)
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
    in:auto:Элемент:Искомый элемент. Первый элемент хранится по индексу 0, второй - по индексу 1 и т.д.
        opt:typeget=array;@value.1
    out:int:Индекс:Возвращает -1 если элемент не найден, иначе возвращает индекс элемента в массиве.
" node_system

//! всё ещё не оптимизировано. в локальной функции параметр не итерируемый
//findif
// "
//     node:findif
//     name:Найти элемент по условию
//     namelib:Найти элемент по условию
//     desc:Поиск элемента в массиве по условию."+
//     "\nПараметры анонимной функции\:"+
//     " Вход - любое значение. Выход - @[bool Условие] - был ли найден искомый элемент
//     icon:data\\icons\\icon_BluePrintEditor_Function_16px
//     exec:pure
//     rendertype:NoHeader
//     code:(((@in.1) findif (@in.2))!=-1)
//     in:auto:Массив
//         opt:typeget=array;@type
//     in:auto:Функция
//         opt:typeget=function;@value.1;function[anon=bool={}]
//     out:bool:Результат:@[bool ИСТИНА], если элемент найден в массиве, иначе @[bool ЛОЖЬ]

// " node_system
    
//resize
"
    node:resize
    name:Изменить размер
    namelib:Изменить размер массива
    desc:Изменяет размер исходного массива.
    icon:data\\icons\\ArrayPin.png
    exec:all
    rendertype:NoHeader
    autocoloricon:1
    code: (@in.2)resize(@in.3); @out.1
    in:auto:Массив:Ссылка на массив, размер которого будет изменён
        opt:typeget=array;@type
    in:int:Размер:Новый размер массива. Если указанный размер меньше текущего, то массив будет уменьшён. Если указанный размер больше текущего, то размер будет увеличен, а по новым индексам будут помещены null-значения.
" node_system
//pushback
"
    node:pushBack
    name:Добавить
    namelib:Добавить элемент в массив
    desc:Добавляет элемент в конец массива.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:(@in.2)pushback(@in.3); @out.1
    in:auto:Массив:Ссылка на массив, в который будет добавлен новый элемент.
        opt:typeget=array;@type
    in:auto:Элемент:Добавляемый элемент
        opt:typeget=array;@value.1
" node_system

//pushbackunique
"
    node:pushBackUnique
    name:Добавить уникальный
    namelib:Добавить уникальный элемент в массив
    desc:Добавляет элемент в конец массива если в нем нет такого элемента.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:(@in.2)pushbackunique(@in.3); @out.1
    in:auto:Массив:Ссылка на массив, в который будет добавлен новый элемент.
        opt:typeget=array;@type
    in:auto:Элемент:Добавляемый элемент.
        opt:typeget=array;@value.1
" node_system

//pushfront
"
    node:pushFront
    name:Добавить в начало
    namelib:Добавить элемент в начало массива
    desc:Добавляет элемент в начало массива. Новый элемент будет доступен по индексу 0
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:[@in.2,@in.3,@in.4] call pushFront; @out.1
    in:auto:Массив:Ссылка на массив, в который будет добавлен новый элемент.
        opt:typeget=array;@type
    in:auto:Элемент:Добавляемый элемент
        opt:typeget=array;@value.1
    in:bool:Уникальный:Если true то добавляется только уникальный элемент (если такого элемента нет в массиве).
        opt:def=False
" node_system

//reverse
"
    node:reverse
    name:Развернуть
    namelib:Развернуть массив
    desc:Инвертирует (отражает) порядок элементов массива. Первый элемент станет последним, последний первым и тд.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:reverse(@in.2); @out.1
    in:auto:Массив:Ссылка на массив, который будет развёрнут.
        opt:typeget=array;@type
" node_system

//remove (deleteAt)
"
    node:deleteAt
    name:Удалить по индексу
    namelib:Удалить элемент из массива по индексу
    desc:Удаляет элемент из массива по указанному индексу
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:(@in.2) deleteAt (@in.3); @out.1
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
    in:int:Индекс:Индекс удаляемого элемента
" node_system

//removeItem
"
    node:deleteArrayItem
    name:Удалить элемент
    namelib:Удалить элемент из массива
    desc:Удаляет элемент из массива если он есть в массиве.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:private @genvar.out.2 = [@in.2,@in.3] call arrayDeleteItem; @out.1
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type
    in:auto:Элемент:Удаляемый элемент
    out:bool:Удалён:Возвращает true если элемент был удалён
" node_system

//deleteRange
"
    node:deleteRange
    name:Удалить диапазон
    namelib:Удалить диапазон элементов
    desc:Удаляет диапазон элементов из массива. Например, при для удаления последних трех элементов массива [3,4,5,6,7,8,9]"+
    " нужно в индексе указать 4, а в количестве указать 3. В итоге получится [3,4,5,6]
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:(@in.2) deleteRange [@in.3,@in.4]; @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:int:Индекс:Индекс, с которого начинается удаление элементов массива
    in:int:Количество:Количество элементов для удаления
" node_system

//sort
"
    node:sort
    name:Сортировать
    namelib:Сортировать массив
    desc:Изменяет исходный массив, сортируя его элементы. Допускается сортировка массивов чисел и строк.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:(@in.2) sort (@in.3); @out.1
    in:auto:Массив:Массив чисел или строк, который будет отсортирован
        opt:typeget=array;@type:allowtypes=array[string]|array[int]|array[float]
    in:bool:По возрастанию:Порядок сортировки. При true элементы массива сортируются по возрастанию, а при false - по убыванию.
        opt:def=true
" node_system

//parseSimpleArray //!Unsafe node
// "
//     node:parseSimpleArray
//     name:Строку в массив
//     desc:Преобразует строку в массив, если та содержит разделители для массива. Например можно преобразовать строку ""[1,2,3,4]"". Будьте осторожны при использовании этого узла.
//     icon:data\\icons\\ArrayPin.png
//     exec:pure
//     code:parseSimpleArray (@in.1)
//     in:string:Строка:Строка для преобразования в массив
//     out:auto:Массив:Результат преобразования
//         opt:typeget=array;@type
// " node_system

//selectmax
"
    node:selectMax
    name:Максимальный элемент
    namelib:Найти максимальный элемент
    desc:Находит наибольший элемент массива. Допускаются только массивы чисел.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:selectMax(@in.1)
    in:auto:Массив:Ссылка на массив
        opt:typeget=array;@type:allowtypes=array[int]|array[float]
    out:auto:Элемент:Наибольший элемент
        opt:typeget=array;@value.1
" node_system

//selectmin
"
    node:selectMin
    name:Минимальный элемент
    namelib:Найти минимальный элемент
    desc:Находит наименьший элемент массива. Допускаются только массивы чисел.
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:pure
    code:selectMin(@in.1)
    in:auto:Массив
        opt:typeget=array;@type:allowtypes=array[int]|array[float]
    out:auto:Элемент
        opt:typeget=array;@value.1
" node_system

//append
"
    node:append
    name:Объединить
    namelib:Объединить массивы
    desc:Изменяет первый массив, добавляя к нему второй. 
    icon:data\\icons\\ArrayPin.png
    rendertype:NoHeader
    autocoloricon:1
    exec:all
    code:private @genvar.out.2 = (@in.2); @locvar.out.2 append (@in.3); @out.1
    in:auto:Источник:Первый массив, к котрому будут добавлены все элементы из второго.
        opt:typeget=array;@type
    in:auto:Добавляемый:Второй массив, элементы которого будут добавлены в первый массив.
        opt:typeget=array;@type
    out:auto:Источник:Ссылка на массив-источник
        opt:typeget=array;@type
" node_system

//apply //!unsafe
// "
//     node:apply
//     name:Применить к массиву
//     namelib:Применить к массиву
//     desc:Применяет операцию (анонимную функцию) к каждому элементу массива и возвращает новый массив с обновленными элементами
//     icon:data\\icons\\ArrayPin.png
//     rendertype:NoHeader
//     autocoloricon:1
//     exec:all
//     code:private @genvar.out.2 = (@in.1) apply {@in.2}; @out.1
//     in:auto:Массив
//         opt:typeget=array;@type
//     in:Exec:Функция элемента:Обработчик элемента массива
//     in:auto:Элемент
//         opt:typeget=array;@value.1
//     out:Новый массив
//         opt:typeget=array;@type
// " node_system

//abstract array
//! not really need now...
// "
//     node:listToArray
//     name:Лист в массив
//     desc:Преобразует лист (абстрактный массив) в массив
//     icon:data\\icons\\ArrayPin.png
//     rendertype:NoHeader
//     autocoloricon:1
//     exec:pure
//     code:@in.1
//     in:list:Лист:Лист со значениями
//     option:""Тип""\:{""type""\: ""typeselect""}
// " node_system

// "
//     node:arrayToList
//     name:Массив в лист
//     desc:Преобразует массив в лист (абстрактный массив)
//     icon:data\\icons\\ArrayPin.png
//     exec:pure
//     code:@in.1
//     runtimeports:1
//     in:auto:Массив
//         opt:typeget=array;@type
//     out:list:Лист
// " node_system