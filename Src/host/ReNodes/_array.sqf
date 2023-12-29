
node_system_group("array")

"
    node:makeArray
    path:Массивы
    name:Создать массив
    namelib:Создание массива
    desc:Создает массив из указанных элементов
    icon:data\\icons\\ArrayPin.png
    runtimeports:1
    autocoloricon:0
    exec:pure
    code:[ @genport.in.( ,) ]
    in:auto:Элемент
        opt:typeget=array;@value.1
    out:auto:Массив
        opt:typeget=array;@type
" node_system

"
    node:clearArray
    name:Очистить массив
    desc:Удаляет все элементы из массива, делая его пустым.
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.2) resize 0; @out.1
    in:auto:Массив:Ссылка на массив, который будет очищен.
        opt:typeget=array;@type
" node_system

"
    node:pick
    name:Случайный элемент
    desc:Выбирает случайный элемент из массива
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:SelectRandom(@in.1)
    in:auto:Массив
        opt:typeget=array;@type
    out:auto:Элемент
        opt:typeget=array;@value.1
" node_system

"
	node:get
	name:Получить элемент
	namelib:Получение элемента массива
	desc:Получает элемент массива
	icon:data\\icons\\ArrayPin.png
	runtimeports:1
	autocoloricon:0
    exec:pure
	code:(@in.1)select(@in.2)
	in:auto:Массив
		opt:typeget=array;@type
	in:int:Индекс:Индекс элемента массива. Отсчет начинается с 0. Для получения первого элемента массива используется индекс 0, а для последнего - количество элементов минус 1.
	out:auto:Элемент
		opt:typeget=array;@value.1
"
node_system

"
	node:set
	name:Установить элемент
	namelib:Установка элемента массива
	desc:Получает элемент массива
	icon:data\\icons\\ArrayPin.png
	runtimeports:1
	autocoloricon:0
	exec:all
	code:(@in.2)set[@in.3,@in.4]; @out.1
	in:auto:Массив
		opt:typeget=array;@type
	in:int:Индекс:Индекс элемента массива. Отсчет начинается с 0. Для получения первого элемента массива используется индекс 0, а для последнего - количество элементов минус 1.
	in:auto:Элемент
		opt:typeget=array;@value.1
" node_system

//count
"
    node:count
    name:Количество элементов
    namelib:Получить количество элементов массива
    desc:Получает количество элементов массива
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:count(@in.1)
    in:auto:Массив
        opt:typeget=array;@type
    out:int:Количество элементов
" node_system

//in
"
    node:in
    name:Элемент в массиве
    namelib:Проверка наличия элемента в массиве
    desc:Проверяет наличие элемента в массиве.
    icon:data\\icons\\ArrayPin.png
    exec:pure
    runtimeports:1
    autocoloricon:0
    code:(@in.2)in(@in.1)
    in:auto:Массив
        opt:typeget=array;@type
    in:auto:Элемент
        opt:typeget=array;@value.1
    out:bool:Результат:Истина, если элемент в массиве, иначе ложь
" node_system
//find
"
    node:find
    name:Найти элемент
    namelib:Поиск элемента
    desc:Поиск элемента в массиве
    icon:data\\icons\\ArrayPin.png
    exec:pure
    runtimeports:1
    code:(@in.1)find(@in.2)
    in:auto:Массив
        opt:typeget=array;@type
    in:auto:Элемент
        opt:typeget=array;@value.1
    out:int:Индекс:Возвращает -1 если элемент не найден, иначе возвращает индекс элемента в массиве.
" node_system

//findif
// "
//     node:findif
//     name:Найти элемент по условию
//     namelib:Поиск элемента по условию
//     desc:Поиск элемента в массиве по условию
//     icon:data\\icons\\ArrayPin.png
//     exec:pure
//     runtimeports:1
//     autocoloricon:0
//     code:call{__fi = 0; (@in.1) findif {__fi = _x; (@out.2)}}
//     in:auto:Массив
//         opt:typeget=array;@type
//     out:bool:Условие
//     out:auto:Проверяемый элемент
//         opt:typeget=array;@value.1
//     out:bool:Результат:Истина, если элемент найден в массиве, иначе ложь

// " node_system
    
//resize
"
    node:resize
    name:Изменить размер
    namelib:Изменить размер массива
    desc:Изменяет размер исходного массива.
    icon:data\\icons\\ArrayPin.png
    exec:all
    code: (@in.1)resize(@in.2); @out.1
    in:auto:Массив:Ссылка на массив, размер которого будет изменён
        opt:typeget=array;@type
    in:int:Размер:Новый размер массива
" node_system
//pushback
"
    node:pushBack
    name:Добавить в конец
    namelib:Добавить элемент в конец массива
    desc:Добавляет элемент в конец массива
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.1)pushback(@in.2); @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:auto:Элемент
        opt:typeget=array;@value.1
" node_system

//pushbackunique
"
    node:pushBackUnique
    name:Добавить в конец (уникальный)
    namelib:Добавить уникальный элемент в конец массива
    desc:Добавляет элемент в конец массива если в нем нет такого элемента.
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.1)pushbackunique(@in.2); @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:auto:Элемент
        opt:typeget=array;@value.1
" node_system

//pushfront
"
    node:pushFront
    name:Добавить в начало
    namelib:Добавить элемент в начало массива
    desc:Добавляет элемент в начало массива. Новый элемент будет доступен по индексу 0
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:[@in.1,@in.2,@in.3] call pushFront; @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:auto:Элемент
        opt:typeget=array;@value.1
    in:bool:Уникальный:Если true то добавляется только уникальный элемент (если такого элемента нет в массиве).
" node_system

//reverse
"
    node:reverse
    name:Отразить массив
    desc:Инвертирует (отражает) порядок элементов массива. Первый элемент станет последним, последний первым и тд.
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:reverse(@in.1); @out.1
    in:auto:Массив
        opt:typeget=array;@type
" node_system

//remove (deleteAt)
"
    node:deleteAt
    name:Удалить по индексу
    namelib:Удалить элемент из массива по индексу
    desc:Удаляет элемент из массива по указанному индексу
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.1) deleteAt (@in.2); @out.1
    in:auto:Массив
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
    exec:all
    code:private @genvar.out.2 = [@in.2,@in.3] call arrayDeleteItem; @out.1
    in:auto:Массив
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
    " нужно в индексе указать 4, а в количестве указать 3.
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.1) deleteRange [@in.2,@in.3]; @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:int:Индекс:Индекс, с которого начинается удаление элементов массива
    int:int:Количество:Количество элементов для удаления
" node_system

//sort
"
    node:sort
    name:Сортировать
    namelib:Сортировать массив
    desc:Изменяет исходных массив, сортируя его элементы. Допускается сортировка массивов чисел и строк.
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.1) sort (@in.2); @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:bool:По возрастанию:Порядок сортировки. При true элементы массива сортируются по возрастанию, а при false - по убыванию.
" node_system

//parseSimpleArray
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
    desc:Находит наибольший элемент массива
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:selectMax (@in.1)
    in:auto:Массив
        opt:typeget=array;@type
    out:auto:Элемент
        opt:typeget=array;@value.1
" node_system

//selectmin
"
    node:selectMin
    name:Минимальный элемент
    namelib:Найти минимальный элемент
    desc:Находит наименьший элемент массива
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:selectMin (@in.1)
    in:auto:Массив
        opt:typeget=array;@type
    out:auto:Элемент
        opt:typeget=array;@value.1
" node_system

//append
"
    node:append
    name:Объединить
    namelib:Объединить массивы
    desc:Изменяет первый массив, добавляя к нему второй
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:(@in.1) append (@in.2); @out.1
    in:auto:Массив источник
        opt:typeget=array;@type
    in:auto:Добавляемый массив
        opt:typeget=array;@type
" node_system

//apply
"
    node:apply
    name:Применить к массиву
    namelib:Применить к массиву
    desc:Применяет операцию к каждому элементу массива и возвращает новый массив с обновленными элементами
    icon:data\\icons\\ArrayPin.png
    exec:all
    code:private @genvar.out.2 = (@in.1) apply {@in.2}; @out.1
    in:auto:Массив
        opt:typeget=array;@type
    in:Exec:Функция элемента:Обработчик элемента массива
    in:auto:Элемент
        opt:typeget=array;@value.1
    out:Новый массив
        opt:typeget=array;@type
" node_system

//abstract array

"
    node:listToArray
    name:Лист в массив
    desc:Преобразует лист (абстрактный массив) в массив
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:@in.1
    in:list:Лист:Лист со значениями
    option:""Тип""\:{""type""\: ""typeselect""}
" node_system

"
    node:arrayToList
    name:Массив в лист
    desc:Преобразует массив в лист (абстрактный массив)
    icon:data\\icons\\ArrayPin.png
    exec:pure
    code:@in.1
    runtimeports:1
    in:auto:Массив
        opt:typeget=array;@type
    out:list:Лист
" node_system