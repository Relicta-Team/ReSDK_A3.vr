// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

nodeModule_register("system")

nodeModule_setPath("Система")
nodeModule_setIcon("data\\icons\\icon_BluePrintEditor_Function_16px")
nodeModule_setColorStyle("PureFunction")
nodeModule_setExecType("pure")

nodeModule_addPath("Время")
["tickTime","Время работы Платформы",'tickTime',"float:Значение" opt 'dname=0:mul=1',"Получает время в секундах, прошедшее с момента запуска платформы"] reg_nular
["netTickTime","Время симуляции",'netTickTime',"float:Значение" opt 'dname=0:mul=1',"Получает время в секундах, прошедшее с момента начала симуляции"] reg_nular
["deltaTime","Время карда",'deltaTime',"float:Значение" opt 'dname=0:mul=1',"Возвращает длительность предыдущего кадра в секундах"] reg_nular
["frameNumber","Номер кадра","diag_frameNo","float:Значение" opt 'dname=0:mul=1',"Возвращает номер кадра, отображаемого в данный момент."] reg_nular

["fps","Средний FPS","diag_fps","float:Значение" opt 'dname=0:mul=1',"Возвращает среднюю частоту кадров, рассчитанную за последние 16 кадров.."] reg_nular
["fpsMin","Минимальный FPS","diag_fpsMin","float:Значение" opt 'dname=0:mul=1',"Возвращает минимальную частоту кадров. Рассчитывается по самому длинному кадру за последние 16 кадров.."] reg_nular

nodeModule_popPath(1)
nodeModule_addPath("Отладка")


["isEditor","Это редактор","__GLOBAL_MACRO_RESDK_EDITOR__","bool:Редактор" opt "mul=1","Возвращает @[bool ИСТИНУ], если текущий граф выполняется в редакторе."] reg_nular
["isDebug","Это дебаг","__GLOBAL_MACRO_RESDK_DEBUG__","bool:Дебаг" opt "mul=1","Возвращает @[bool ИСТИНУ], если текущий граф выполняется в отладочной сборке."] reg_nular
["isRelease","Это релиз","__GLOBAL_MACRO_RESDK_RELEASE__","bool:Релиз" opt "mul=1","Возвращает @[bool ИСТИНУ], если текущий граф выполняется в релизной сборке."] reg_nular

nodeModule_setExecType("all")
nodeModule_setColorStyle("Function")
["assert","Утверждение",'assert_str(@in.1,@in.2); @out.1',"bool:Значение:Проверяемое выражение, которое должно возвращать истину.",
"string:Сообщение:Текст сообщение при неудачной проверке.",
null, //noreturn
"Проверяет выражение. Если оно не истинно - выдает исключение. Утверждения автоматически выключаются в режиме сервера (не редактор и не отладка)."] reg_binary

nodeModule_popPath(1)
nodeModule_addPath("Консоль")

nodeModule_setExecType("all")
nodeModule_setColorStyle("Function")

["consoleLogGeneric","Лог в консоль","[@in.2,@in.3,[@genport.in.4(,)]] call renode_print; @out.1",
	"string:Сообщение:Текст сообщения. Для отображения данных используйте '%1' в сообщении. Например, для переменной, подключенной в данные 3 вставьте в строку '%3'.",
	"enum.ConsoleLogType:Тип:Тип сообщения, характеризующий внешний вид сообщения - цвет, префикс. Обратите внимание, что в релизной сборке трассировочные сообщения не выводятся в консоли." + endl +
	"in:void:Данные 1:Любые дополнительные данные для вывода." 
		opt "typeget=ANY;@type:require=0" + endl +
	"option:""makeport_in""\: {""type""\: ""makeport_in"",""src""\:""Данные 1"",""text_format""\:""Данные {value}""}"+endl+
	"runtimeports:1"
	,
	null, "Выводит сообщение в консоль."
] reg_binary


nodeModule_popPath(1)
nodeModule_addPath("Файлы")

nodeModule_setColorStyle("PureFunction")
nodeModule_setExecType("pure")
["fileExists","Файл существует","[@in.1] call fileExists_Node",
	"string:Файл:Путь к файлу.",
	"bool:Существует:Существует ли файл. Возвращает @[bool ИСТИНУ], если файл существует.", 
	"Проверяет существование файла."
] reg_unary

["fileLoad","Загрузить файл","[@in.1,@in.2] call fileLoad_Node",
	"string:Файл:Путь к файлу.",
	"bool:Препроцесс:Возвращает @[bool ИСТИНУ], если файл загружен."
		opt "def=false:require=-1",
	"string:Содержимое:Содержимое файла. Возвращает пустую строку, если файл не загружен.",
	"Загружает файл в в переменную. Возвращает пустую строку, если файл не загружен."
] reg_binary