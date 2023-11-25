
node_system_group("internal")
"
	node:backdrop
	name:Группа
	desc:Специальный узел для группировки нескольких узлов
	icon:data\\icons\\icon_Blueprint_Comment_16x.png
	path:Системные
"
node_system


node_system_group("operators")
"
	path:Операторы
	node:if_branch
	name:Ветка
	desc:Оценивает условие ветки.
	icon:data\\icons\\icon_Blueprint_Branch_16x
	code:if (@in.2) then {@out.1} else {@out.2};
	in:Exec:Вход
		opt:mul=1
	in:bool:Условие:Условие, оцениваемое веткой
	out:Exec:Истина:Выполняет подключенный узел, если условие является истиной
	out:Exec:Ложь:Выполняет подключенный узел, если условие является ложью
"
node_system

"
	node:while
	name:Цикл
	desc:Выполнение кода несколько раз пока условие истинно.\n"+
	"Обратите внимание, что этот цикл может выполняться только 10000 раз. При достижении лимита выполнения цикл остановится.
	icon:data\\icons\\icon_Blueprint_Loop_16x
	code:while {@in.2} do {@out.1}; @out.2
	in:Exec:Вход
		opt:mul=1:dname=0
	in:bool:Условие:Оцениваемое условие. Пока это условие возвращает истину - цикл будет выполняться
		opt:custom=1
	out:Exec:Тело цикла:Узел, подключенный к этому порту будет выполнен пока выполняется цикл (т.е. условие - истина)
	out:Exec:При завершении:Узел, подключенный к этому порту будет выполнен когда цикл завершится
"
node_system

"
	node:for_loop
	name:Цикл в диапазоне
	namelib:Цикл в диапазоне
	desc:Вызывается несколько раз. Диапазон задается входными параметрами ""Первый индекс"" и ""Последний индекс""
	icon:data\\icons\\icon_Blueprint_Loop_16x
	code:for ""@genvar.out.2"" from (@in.2) to (@in.3) do {@out.1}; @out.3
	in:Exec:Вход
		opt:mul=1:dname=0
	in:int:Первый индекс:Начальное число, с которого начинается цикл
	in:int:Последний индекс:Конечное число, до которого цикл будет выполняться
	out:Exec:Тело цикла:Этот порт вызывается пока индекс находится в диапазоне между первым и последним индексом
	out:int:Индекс:Этот порт владеет значением в каждой итерации цикла. Например, при диапазоне от 0 до 10 индекс при использовании в теле цикла впервые будет равен 0 а в последний раз 10.
		opt:mul=1:pathes=Тело цикла
	out:Exec:При завершении:Узел, подключенный к этому порту будет выполнен когда цикл завершится
		opt:pathes=
"
node_system

"
	node:foreach_loop
	name:Цикл по списку
	namelib:Цикл по списку (перебор коллекции)
	desc:Цикл для перебора коллекций (например, массивов).
	icon:data\\icons\\icon_Blueprint_ForEach_16x
	code:private @genvar.out.2 = NIL; private @genvar.out.3 = NIL; {@locvar.out.2 = _x; @locvar.out.3 = _foreachindex; @out.1} foreach (@in.2); @out.4
	runtimeports:1
	in:Exec:Вход
		opt:mul=1,dname=0
	in:auto:Массив:Список элементов, которые можно обработать в цикле
		opt:typeget=array;@type
	out:Exec:Тело цикла:Этот порт вызывается для каждого элемента списка
	out:auto:Элемент:Элемент списка
		opt:mul=1:pathes=Тело цикла|Индекс:typeget=array;@value.1
	out:int:Индекс:Индекс элемента списка. Отсчет начинается с 0. Первый элемент будет иметь индекс 0, последний имеет индекс, равный количеству элементов минус 1.
		opt:mul=1:pathes=Тело цикла|Элемент
	out:Exec:При завершении:Узел, подключенный к этому порту будет выполнен когда цикл завершится
"
node_system

//variables
node_system_group("variable")

"
	node:get
	name:Получить {}
	namelib:Получение значения переменной
	desc:Получает значение переменной
	libvisible:0
	code:RUNTIME
	defcode:var(@thisName,@propvalue);
	option:""nameid""\: {""type""\: ""hidden""}
"
node_system

"
	node:set
	name:Установить {}
	namelib:Установка значения переменной
	desc:Устанавливает значение переменной
	libvisible:0
	code:RUNTIME
	option:""nameid""\: {""type""\: ""hidden""}	
	exec:all
"
node_system

node_system_group("array")

"
	node:get
	name:Получить элемент
	namelib:Получение элемента массива
	desc:Получает элемент массива
	icon:data\\icons\\ArrayPin.png
	runtimeports:1
	code:(@in.1) select (@in.2)
	in:auto:Массив
		opt:typeget=array;@type
	in:int:Индекс:Индекс элемента массива. Отсчет начинается с 0. Для получения первого элемента массива используется индекс 0, а для последнего - количество элементов минус 1.
	out:auto:Элемент
		opt:typeget=array;@value.1
"
node_system

//регистратор сравнений
private __comparator = {
	params ["_str","_compTex","_left","_right"];
};