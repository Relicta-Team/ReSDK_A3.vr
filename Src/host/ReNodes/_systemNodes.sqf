
node_system_group("internal")
	"
		node:backdrop
		name:Группа
		desc:Специальный узел для группировки нескольких узлов
		icon:data\\icons\\icon_Blueprint_Comment_16x.png
		path:Системные
	" node_system

	"   
		node:sticker
		name:Заметка
		desc:Стикер для различных пользовательских заметок
		icon:data\\icons\\icon_Blueprint_Comment_16x.png
		path:Системные
		option:""text""\: {""type""\: ""edit""}
	" node_system

node_system_group("operators")
	"
		path:Операторы
		node:if_branch
		name:Ветка
		color:Operator
		desc:Оценивает условие ветки.
		icon:data\\icons\\icon_Blueprint_Branch_16x
		code:if (@in.2) then {@out.1} else {@out.2};
		in:Exec:Вход
			opt:mul=1
		in:bool:Условие:Условие, оцениваемое веткой
		out:Exec:Истина:Выполняет подключенный узел, если условие является истиной
			opt:mul=0
		out:Exec:Ложь:Выполняет подключенный узел, если условие является ложью
			opt:mul=0
	"
	node_system

	"
		node:while
		color:Operator
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
			opt:mul=0
		out:Exec:При завершении:Узел, подключенный к этому порту будет выполнен когда цикл завершится
			opt:mul=0
	"
	node_system

	"
		node:for_loop
		color:Operator
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
			opt:mul=0
		out:int:Индекс:Этот порт владеет значением в каждой итерации цикла. Например, при диапазоне от 0 до 10 индекс при использовании в теле цикла впервые будет равен 0 а в последний раз 10.
			opt:mul=1:pathes=Тело цикла
		out:Exec:При завершении:Узел, подключенный к этому порту будет выполнен когда цикл завершится
			opt:mul=0:pathes=
	"
	node_system

	"
		node:foreach_loop
		color:Operator
		name:Цикл по списку
		namelib:Цикл по списку (перебор коллекции)
		desc:Цикл для перебора коллекций (например, массивов).
		icon:data\\icons\\icon_Blueprint_ForEach_16x
		code:private @genvar.out.2 = NIL; private @genvar.out.3 = NIL; {@locvar.out.2 = _x; @locvar.out.3 = _foreachindex; @out.1} foreach (@in.2); @out.4
		runtimeports:1
		autocoloricon:0
		in:Exec:Вход
			opt:mul=1:dname=0
		in:auto:Массив:Список элементов, которые можно обработать в цикле
			opt:typeget=array;@type
		out:Exec:Тело цикла:Этот порт вызывается для каждого элемента списка
			opt:mul=0
		out:auto:Элемент:Элемент списка
			opt:mul=1:pathes=Тело цикла|Индекс:typeget=array;@value.1
		out:int:Индекс:Индекс элемента списка. Отсчет начинается с 0. Первый элемент будет иметь индекс 0, последний имеет индекс, равный количеству элементов минус 1.
			opt:mul=1:pathes=Тело цикла|Элемент
		out:Exec:При завершении:Узел, подключенный к этому порту будет выполнен когда цикл завершится
			opt:mul=0
	"
	node_system

	"
		node:continue_loop
		color:Operator
		name:Пропустить итерацию цикла
		namelib:Пропуск итерации цикла
		desc:Пропускает текущую итерацию цикла
		code:continue
		exec:in
	" node_system

	"
		node:break_loop
		color:Operator
		name:Прервать цикл
		namelib:Прерывание цикла
		desc:Останавливает выполнение цикла
		code:break
		exec:in
	" node_system
	

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

node_system_group("function")
	"
		node:def
		name:Определить {}
		libvisible:0
		code:RUNTIME
		option:""nameid""\: {""type""\: ""hidden""}	
		exec:out
	" node_system


	"
		node:call
		name:{}
		libvisible:0
		code:RUNTIME
		option:""nameid""\: {""type""\: ""hidden""}	
		exec:all
	" node_system

node_system_group("control")

   "
	node:return
	name:Вернуть значение
	namelib:Вернуть значение (выход из функции)
	desc:Возвращает значение из функции
	icon:data\\icons\\icon_Blueprint_Node_16x
	runtimeports:1
	autocoloricon:0
	code:(@in.2) BREAKOUT ""exec""
	exec:in
	in:auto:Возвращаемое значение:Значение, которое вернет функция.
    	opt:typeget=ANY;@type
	" node_system

	"
		node:supercall
		name:Вызов базового метода
		namelib:Вызов базового метода
		desc:Вызов базового метода.
		icon:data\\icons\\icon_Blueprint_OverrideableFunction_16x
		runtimeports:1
		autocoloricon:0
		code:private @genvar.out.2 = super(); @out.1
		exec:all
		out:auto:Значение:Значение, которое может вернуть базовый метод. Если базовый метод не возвращает значений, то оставьте этот порт пустым.
			opt:typeget=ANY;@type
	" node_system

	"
		node:castto
		name:Преобразовать тип
		namelib:Преобразование типа
		desc:Преобразует входной тип к другому указанному типу.
		icon:data\\icons\\icon_Blueprint_Cast_16x
		code: if !((tolower (object)) in ((@in.2) getvariable PROTOTYPE_VAR_NAME getvariable (""__inhlist_map""))) then {@out.2}; @out.1 
		runtimeports:1
		autocoloricon:0
		exec:in
		in:auto:Входной объект:Объект, который будет преобразован.
			opt:typeget=value;@type
		out:Exec:Успешное преобразование:Выполняется если преобразование прошло успешно.
		out:Exec:Невозможное преобразование:Выполняется если преобразование не удалось.
		out:auto:Объект:Объект, преобразованный к новому типу.
			opt:typeget=value;@type
	" node_system

	"
		node:callafter
		name:Таймер
		namelib:Вызов по таймеру
		color:Operator
		icon:data\\icons\\icon_Blueprint_Timeline_16x
		desc:Выполняет код через указанный промежуток времени
		code: __callafterCode = {SCOPENAME ""exec""; @context.alloc; @out.1}; __prs = @context.get; invokeAfterDelayParams(__callafterCode,@in.2,__prs); 
		exec:none
		in:Exec:Вход
			opt:mul=1
		in:float:Время:Время в секундах, через которое будет вызван код таймера.
		out:Exec:Вызов:Код, который будет вызван через указанный промежуток времени.
			opt:mul=0
	" node_system

	"
		node:callaftercond
		name:Условный таймер
		namelib:Вызов по таймеру с условием
		desc:Выполняет код через указанный промежуток времени, если условие истино.
		color:Operator
		icon:data\\icons\\icon_ClockwiseRotation_16x
		code: startAsyncInvoke {@context.alloc; @in.2}, {SCOPENAME ""exec""; @context.alloc; @out.1 },@context.get,@in.3,{SCOPENAME ""exec""; @context.alloc; @out.2} endAsyncInvoke
		exec:none
		in:Exec:Вход
			opt:mul=1
		in:bool:Условие:Оцениваемое условие
		in:float:Таймаут:Время в секундах, через которое будет вызван код по таймауту
		out:Exec:Вызов:Код, который будет вызван, если условие истино.
			opt:mul=0
		out:Exec:При таймауте:Код, который будет вызван при таймауте.
			opt:mul=0
	" node_system

	"
		node:messageBox
		name:Сообщение в окне
		namelib:Сообщение в окне
		desc:Выводит сообщение в окне (только в режиме отладки).
		code: \n#ifdef DEBUG\n[@in.2,@in.3] call messageBox_Node;\n#endif\n @out.1
		runtimeports:1
		autocoloricon:0
		exec:all
		in:string:Сообщение:Выводимое сообщение. Для вывода данных в строке сообщения укажите %1.
		in:auto:Данные:Дополнительные данные для вывода.
			opt:typeget=ANY;@type:require=0
	" node_system



//регистратор сравнений
private __comparator = {
	params ["_str","_compTex","_left","_right"];
};