// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


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
		option:""text""\: {""type""\: ""edit"", ""font_size""\:15}
	" node_system

	//TODO implement
	// "
	// 	node:reroute
	// 	name:Перенаправление
	// 	namelib:Порт перенаправления
	// 	desc:Данный узел предназначен для перенаправления подключений узлов. При работе со сложными или большими графами вы можете столкнуться с ситуациями, когда ваши провода расположены повсюду, и вы хотите изменить способ их отображения на графе для визуальной ясности.
	// 	path:Системные
	// 	code:@out.1
	// 	in:auto:Вход
	// 	out:auto:Выходы
	// 	icon:data\\icons\\empty_a.png

	// 	rendertype:Reroute
	// " node_system

node_system_group("operators")
	
// lambdas and local functions
	"
		node:lambda
		name:Создать функцию
		color:Operator
		icon:data\\icons\\icon_BluePrintEditor_Function_16px
		desc:Создаёт анонимную функцию, которую можно вызывать из любого места в графе. Для создания параметров и установки возвращаемого значения нажмите ПКМ по функции.
		path:Локальные функции и события
		exec:pure
		runtimeports:1
		out:function[anon=null]:lambda_ref:Ссылка на функцию
			opt:dname=1
		out:Exec:Выполнение:Действия, выполняемые создаваемой функцией
			opt:dname=0:mul=0
		code:{@genport.out.3(paramGen) @out.2}
	" node_system

	//! not implemented, context passing is not supported
	// "
	// 	node:lambda_obj
	// 	name:Создать делегат
	// 	namelib:Создать объектную функцию (делегат)
	// 	color:Operator
	// 	icon:data\\icons\\icon_BluePrintEditor_Function_16px
	// 	desc:Создает объектную функцию. Эта функция может использовать контекст из места определения. Для добавления параметров, установки возвращаемого значения и источника (цели) функции нажмите ПКМ по функции.
	// 	exec:pure
	// 	runtimeports:1
	// 	in:auto:Объект:Владелец вызываемой функции
	// 		opt:typeget=value;@type:allowtypes=object^
	// 	out:function[obj=null=object^]:lambda_ref:Ссылка на функцию
	// 		opt:dname=1
	// 	out:Exec:Выполнение:Действия, выполняемые создаваемой функцией
	// 		opt:dname=0:mul=0
	// 	out:auto:Цель:Выполняющий владелец функции
	// 	code:[[@in.1,@context.get],{params[""_p"",""_ct""];_p @genport.out.4(paramGen) _ct @context.alloc; @out.2}]
	// " node_system

	"
		node:lambda_event
		name:Создать функцию-действие
		color:Operator
		icon:data\\icons\\icon_BluePrintEditor_Function_16px
		desc:Создает выполняемое действие над объектом. Для добавления параметров и установки возвращаемого значения нажмите ПКМ по функции.
		exec:pure
		runtimeports:1
		out:function[event=null=object^]:lambda_ref:Ссылка на функцию
			opt:dname=1
		out:Exec:Выполнение:Действия, выполняемые создаваемой функцией
			opt:dname=0:mul=0
		out:object^:Цель:Выполняющий владелец функции
		code:{@genport.out.3(paramGen) @out.2}
	" node_system

	"
		node:lambda_eventlist
		name:Создать событие
		color:Operator
		icon:data\\icons\\icon_BluePrintEditor_Function_16px
		desc:Создает выполняемое событие. Для добавления параметров и уст
		exec:pure
		runtimeports:1
		out:function[eventlist=null=object^]:lambda_ref:Ссылка на функцию
			opt:dname=1
		out:Exec:Выполнение:Действия, выполняемые создаваемой функцией
			opt:dname=0:mul=0
		out:object^:Цель:Выполняющий владелец функции
		code:{@genport.out.3(paramGen) @out.2}
	" node_system

// call localfunctions
	"
		node:call_lambda
		name:Вызвать функцию
		desc:Вызывает анонимную функцию, объектную или событие.
		color:Operator
		icon:data\\icons\\icon_BluePrintEditor_Function_16px
		path:Локальные функции и события.Выполнение
		exec:pure
		runtimeports:1
		code:[@genport.in.2(,)]call(@in.1)
		in:function_ref:Функция
	" node_system

	"
		node:call_lambda_list
		name:Вызвать событие
		desc:Вызывает пользовательское событие.
		color:Operator
		icon:data\\icons\\icon_BluePrintEditor_Function_16px
		exec:all
		runtimeports:1
		code:_pcl__=[@genport.in.3(,)];{_pcl__ call _x} foreach (@in.2); @out.1
		in:function_ref:Функция
	" node_system

	// delegate call is not supported
	// "
	// 	node:call_lambda_delegate
	// 	name:Вызвать делегат
	// 	desc:Вызывает делегат и возвращает значение при наличии. Если объект-владелец делегата не существует - ничего не произойдёт. В случае если делегат должен возвращать значение и объект-владелец не существует - возвращается null-значение.
	// 	color:Operator
	// 	icon:data\\icons\\icon_BluePrintEditor_Function_16px
	// 	exec:pure
	// 	runtimeports:1
	// 	code:[@in.1,[@genport.in.2(,)]] call renode_invokeDelegate
	// 	in:function_ref:Делегат
	// " node_system

	"
		node:switch_on_int
		name:Выбрать из целых чисел
		namelib:Выбрать из перечисления целых чисел
		color:EnumSwitch
		icon:data\\icons\\icon_Blueprint_Switch_16x
		desc:Перечисление по целым числам.
		path:Перечисления.Базовые
		exec:pure
		runtimeports:1
		in:Exec:Вход
			opt:mul=1
		in:int:Число
			opt:mul=0:custom=1:def=0
		out:Exec:По умолчанию:Выполняется, если не найдено ни одно из вхождений.
			opt:mul=0
		code:private __sv = @in.2; @gen_switch_on(__sv)
	" node_system

	"
		node:switch_on_float
		name:Выбрать из дробных чисел
		namelib:Выбрать из перечисления дробных чисел
		color:EnumSwitch
		icon:data\\icons\\icon_Blueprint_Switch_16x
		desc:Перечисление по дробным числам.
		path:Перечисления.Базовые
		exec:pure
		runtimeports:1
		in:Exec:Вход
			opt:mul=1
		in:float:Число
			opt:mul=0:custom=1:def=0
		out:Exec:По умолчанию:Выполняется, если не найдено ни одно из вхождений.
			opt:mul=0
		code:private __sv = @in.2; @gen_switch_on(__sv)
	" node_system

	"
		node:switch_on_string
		name:Выбрать из строк
		namelib:Выбрать из перечисления строк
		color:EnumSwitch
		icon:data\\icons\\icon_Blueprint_Switch_16x
		desc:Перечисление по строкам.
		path:Перечисления.Базовые
		exec:pure
		runtimeports:1
		in:Exec:Вход
			opt:mul=1
		in:string:Строка
			opt:mul=0:custom=1
		out:Exec:По умолчанию:Выполняется, если не найдено ни одно из вхождений.
			opt:mul=0
		code:private __sv = @in.2; @gen_switch_on(__sv)
	" node_system

	_baseOpPath = "Операторы";
	//!not need=> out:Exec:После условия:Всегда посылает импульс после выполнения ветки вне зависимости от условия ""Истина"" или ""Ложь"".
	"
		path:"+_baseOpPath+"
		node:if_branch
		name:Ветка
		color:Operator
		desc:Оценивает условие ветки. "+
		"После выполнения узел просматривает входное значение логического значения порта ""Условие"" и выводит импульс выполнения на соответствующий выходной порт.
		icon:data\\icons\\icon_Blueprint_Branch_16x
		code:if (@in.2) then {@out.1} else {@out.2};
		in:Exec:Вход
			opt:mul=1
		in:bool:Условие:Условие, оцениваемое веткой
			opt:def=true
		out:Exec:Истина:Выполняет подключенный узел, если условие является истиной.
			opt:mul=0
		out:Exec:Ложь:Выполняет подключенный узел, если условие является ложью.
			opt:mul=0
	"
	node_system

	"
		node:sequence
		name:Последовательность
		desc:Этот узел позволяет одному импульсу выполнения запускать последовательность событий по порядку. Узел может иметь любое количество выходов, все из которых вызываются, как только узел последовательности получает входные импульс выполнения. Они всегда вызываются по порядку, но без каких-либо задержек.
		icon:data\\icons\\icon_Blueprint_Sequence_16x
		exec:none
		color:Operator
		code:@genport.out.1(; )
		runtimeports:1
		in:Exec:Вход
			opt:dname=0
		out:Exec:Действие 1
			opt:mul=0
		option:""makeport_out""\: {""type""\: ""makeport_out"",""src""\:""Действие 1"",""text_format""\:""Действие {value}""}
	" node_system

	"
		node:flipflop
		name:Переключатель
		desc:Узел принимает входные данные выполнения и переключается между двумя выходными данными выполнения. При первом вызове выполняется выход A. Во второй раз Б. Потом А, потом Б и так далее. Узел также имеет логический выход, позволяющий отслеживать, когда был вызван выход A.
		icon:data\\icons\\icon_Blueprint_FlipFlop_16x
		exec:none
		color:Operator
		code:private @genvar.out.3 = this getvariable ['@thisClass_@thisName_@ff@nodeStackId',true]; this setvariable ['@thisClass_@thisName_@ff@nodeStackId',!@locvar.out.3]; if (@locvar.out.3) then {@out.1} else {@out.2};
		in:Exec:Вход
			opt:dname=0
		out:Exec:A:Выполняет подключенный узел в первый раз, третий, пятый и т.д. через 1.
			opt:mul=0
		out:Exec:B:Выполняет подключенный узел во второй раз, четвертый, шестой и т.д. через 1.
			opt:mul=0
		out:bool:Импульс А:Возвращает истину, если подан импульс выполнения на порт A, а если подан импульс выполнения на порт B, то возвращается ложь.
	" node_system


	//TODO implement (acyclic required or custom ports)
	// "
	// 	node:do_n
	// 	name:Выполнить N раз
	// 	desc:Узел ""Выполнить N раз"" вызывает импульс выполнения N раз. После достижения предела все исходящие действия будут прекращены до тех пор, пока на его вход сброса не будет отправлен импульс.
	// 	icon:data\\icons\\icon_Blueprint_DoN_16x
	// 	exec:none
	// 	color:Operator
	// 	code:private @genvar.out.1 = this getvariable ['@thisClass_@thisName_@don@nodeStackId',0]; @out.1
	// 	in:Exec:Вход
	// 		opt:dname=0
	// 	in:int:N:Количество вызовов
	// 	in:Exec:Сброс:При подаче импульса на этот порт сбрасывает счетчик количества вызовов.
	// 	out:Exec:Выход:Выполняется пока количество вызовов не достигнет N.
	// 		opt:mul=0
	// 	out:int:Счетчик:Возвращает число, отражающее количество выполненных вызовов.
	// " node_system
	//DoOnce
	//Узел, вызовет импульс выполнения только один раз. С этого момента он прекратит все исходящие действия до тех пор, пока на его вход ""Сброс"" не будет отправлен импульс. Этот узел эквивалентен узлу ""Выполнить N раз"", где N = 1.

	"
		node:while_loop
		color:Operator
		name:Цикл
		desc:Выполнение кода несколько раз пока условие истинно. При поступлении входного имульса выполняется проверка условия. Если оно истнно - выполняется тело цикла. В ином случае выполняется узел, подключенный к выходному порту ""При завершении"", если таковой подключен.\n"+
		"<span style=""color\:red"">Примечание\: </span>Обратите внимание, что узел цикла может выполнить тело цикла только 10000 раз. При достижении лимита выполнения цикл остановится. Данное ограничение является особенностью платформы.
		icon:data\\icons\\icon_Blueprint_Loop_16x
		code:while {@in.2} do {@out.1}; @out.2
		in:Exec:Вход
			opt:mul=1:dname=0
		in:bool:Условие:Оцениваемое условие. Пока это условие возвращает истину - тело цикла будет выполняться.
			opt:custom=1:def=true
		out:Exec:Тело цикла:Посылает импульс выполнения на подключенный узел пока выполняется цикл (т.е. условие - истина).
			opt:mul=0
		out:Exec:При завершении:Посылает импульс выполнения, когда цикл завершится.
			opt:mul=0
	"
	node_system

	"
		node:for_loop
		color:Operator
		name:Цикл в диапазоне
		namelib:Цикл в диапазоне
		desc:Вызывается несколько раз в зависимости от указанного диапазона значений. Диапазон задается входными числовыми параметрами ""Первый индекс"" и ""Последний индекс"".
		icon:data\\icons\\icon_Blueprint_Loop_16x
		code:for ""@genvar.out.2"" from (@in.2) to (@in.3) do {@out.1}; @out.3
		in:Exec:Вход
			opt:mul=1:dname=0
		in:int:Первый индекс:Начальное число, с которого начинается цикл.
			opt:def=0
		in:int:Последний индекс:Конечное число, до которого цикл будет выполняться. Если это число меньше первого индекса - имульс не будет послан на порт ""Тело цикла"".
			opt:def=10
		out:Exec:Тело цикла:Посылает импульс выполнения пока индекс находится в диапазоне между первым и последним индексом.
			opt:mul=0
		out:int:Индекс:Этот порт владеет значением в каждой итерации цикла и увеличивает его после каждой итерации выполнения тела цикла. Например, при диапазоне от 0 до 10 индекс при использовании в теле цикла впервые будет равен 0 а в последний раз 10. Данный порт не может быть подключен к узлам, не находящимся в теле этого цикла.
			opt:mul=1:pathes=Тело цикла
		out:Exec:При завершении:Посылает импульс выполнения, когда цикл завершится.
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
		code:{@genvar.out.2.iterator(_x)@genvar.out.3.iterator(_foreachindex) @out.1} foreach (@in.2); @out.4
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
		desc:Пропускает текущую итерацию цикла. При поступлении импульса на этот порт, цикл продолжается с следующей итерацией, если таковая возможна.
		code:continue
		exec:in
	" node_system

	"
		node:break_loop
		color:Operator
		name:Прервать цикл
		namelib:Прерывание цикла
		desc:Останавливает выполнение цикла. При поступлении импульса на этот порт, цикл прерывается.
		code:break
		exec:in
	" node_system

//variables
node_system_group("variable")

	"
		node:get
		name:Получить {}
		namelib:Получение значения переменной
		desc:Получает значение переменной, созданной пользователем.
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
		desc:Устанавливает значение переменной, созданной пользователем.
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
		desc:Возвращает значение из функции. При поступлении импульса на этот порт, выполнение функции прерывается.
		icon:data\\icons\\icon_Blueprint_Node_16x
		color:Operator
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
		desc:Вызов базового метода. Этот узел вызывает функцию из родительского класса. "+
		"Например, в некотором классе ""А"" есть функция ""Действие"". При создании собственного класса ""Б"", унаследованного от ""А"" и переопределяющего логику функции ""Действие"" мы можем выполнить ""Действие"" от родительского класса ""А"" с помощью этого узла ""Вызов базового метода"".
		icon:data\\icons\\icon_Blueprint_OverrideableFunction_16x
		color:Operator
		runtimeports:1
		autocoloricon:0
		code:private @genvar.out.2 = super(); @out.1
		exec:all
		out:auto:Значение:Значение, которое возвращает базовый метод. Если базовый метод не возвращает значений, то оставьте этот порт пустым.
			opt:typeget=ANY;@type
	" node_system

	"
		node:castto
		name:Преобразовать тип
		namelib:Преобразование типа объекта
		desc:Преобразует входной тип к другому указанному типу.
		icon:data\\icons\\icon_Blueprint_Cast_16x
		color:Operator
		code:if "+'!isTypeStringOf(@in.2,"@gettype.out.3.clear_type()")'+" exitWith {@out.2}; private @genvar.out.3 = @in.2; @out.1
		exec:in
		in:object:Входной объект:Объект, который будет преобразован.
			opt:typeget=value;@type
		out:Exec:Успешное преобразование:Выполняется если преобразование прошло успешно.
			opt:mul=0
		out:Exec:Невозможное преобразование:Выполняется если преобразование не удалось.
			opt:mul=0
		out:auto_object_type:Объект:Объект, преобразованный к новому типу.
			opt:typeget=value;@type
		option:""Преобразование""\: {""text""\:""Преобразование"",""type""\:""typeselect"",""default""\:""object"",""typeset_out""\:""Объект"",""port_rename""\:""Объект как {}""}
	" node_system

	"
		node:messageBox
		path:"+_baseOpPath+"
		name:Сообщение на экране
		namelib:Сообщение на экране (Message box)
		desc:Выводит сообщение в отдельном окне поверх окна Платформы. Пока открыто окно сообщения симуляция не будет выполняться. Данный узел работает только для режима отладки.
		code: @IFDEF_DEBUG [@in.2,@in.3] call messageBox_Node; @ENDIF @out.1
		color:Function
		icon:data\\icons\\icon_BluePrintEditor_Function_16px
		runtimeports:1
		autocoloricon:0
		exec:all
		in:string:Сообщение:Выводимое сообщение. Для вывода данных в строке сообщения укажите %1.
		in:auto:Данные:Дополнительные данные для вывода.
			opt:typeget=ANY;@type:require=0
	" node_system

	//todo implement
	// "
	// 	node:consolePrint
	// 	path:"+_baseOpPath+"
	// 	name:Сообщение в консоли
	// 	desc:Выводит сообщение в консоли.

	// " node_system

	"
		node:callafter
		path:"+_baseOpPath+".Асинхронные"+"
		name:Таймер
		namelib:Вызов по таймеру
		color:Operator
		icon:data\\icons\\icon_Blueprint_Timeline_16x
		desc:Узел ""Таймер"" предназначен для исполнения задержек (пауз) между действиями внутри функции. При поступлении входного импульса выполнение приостанавливается на время, указанное во входном порту ""Пауза"" и после этого пошлёт импульс на выходной порт ""Вызов"". "+
		"Данный узел имеет некоторые накладные расходы при выполнении, поэтому не гарантируется задежрка с указанной точностью времени до миллисекунды.
		code: __callafterCode = {SCOPENAME ""exec""; @context.alloc; @out.1}; __prs = @context.get; invokeAfterDelayParams(__callafterCode,@in.2,__prs); 
		exec:none
		in:Exec:Вход
			opt:mul=1
		in:float:Пауза:Время в секундах, через которое будет послан импульс на выходной порт ""Вызов"".
		out:Exec:Вызов:Исполняетя один раз после истечения времени, указанного во входном порту ""Пауза"".
			opt:mul=0
	" node_system

	"
		node:callaftercond
		name:Условный таймер
		namelib:Вызов по таймеру с условием
		desc:Узел ""Условный таймер"" предназначен для исполнения задержек (пауз) между действиями внутри функции. При поступлении входного импульса выполнение приостанавливается до тех пор, пока условие, вычисляемое каждый кадр не будет истинно. "+
		"Как только условие станет истинно таймер будет остановлен и пошлётся импульс на выходной порт ""Вызов"".
		color:Operator
		icon:data\\icons\\icon_ClockwiseRotation_16x
		code: startAsyncInvoke {@context.alloc; @in.2}, {SCOPENAME ""exec""; @context.alloc; @out.1 },@context.get,@in.3,{SCOPENAME ""exec""; @context.alloc; @out.2} endAsyncInvoke
		exec:none
		in:Exec:Вход
			opt:mul=1
		in:bool:Условие:Оцениваемое условие. Каждый кадр вычисляет результат условия. Если оно истинно, то посылается импульс на выходной порт ""Вызов"".
		in:float:Таймаут:Время в секундах, через которое будет послан импульс на выходной порт ""При таймауте"". Если указано значение -1, то таймаута не будет.
			opt:def=-1
		out:Exec:Вызов:Когда условие стало истинным, посылается импульс выполнения на этот порт и таймер завершается.
			opt:mul=0
		out:Exec:При таймауте:Если прошло время таймаута и условие не стало истинным, посылается импульс выполнения на этот порт и таймер завершается.
			opt:mul=0
	" node_system
