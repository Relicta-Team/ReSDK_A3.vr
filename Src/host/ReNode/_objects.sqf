// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


node_system_group("objects")

nodeModule_setPath("Объекты")
nodeModule_setIcon("data\\icons\\icon_Blueprint_Node_16x")
nodeModule_setColorStyle("Function")
nodeModule_setExecType("all")

"
    node:null_check
    name:Объект существует
    namelib:Объект существует (не null)
    path:Объекты
    desc:Проверяет существование (валидность) объекта. Если ссылка на объект пригоден для использования (не удален и существует) - возвращает @[bool ИСТИНУ].
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:(!ISNULL(@in.1))
    in:object^:Объект:Ссылка на проверяемый объект.
    out:bool:Результат:Возвращает @[bool ИСТИНУ], если объект существует. Если ссылка на объект не существует или объект был удален - возвращает @[bool ЛОЖЬ].
" node_system

"
    node:makeLiteralClassName
    name:Создать буквальное имя класса
    desc:Создает значение типа @[classname]
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:@in.1
    in:classname:Имя класса:Класснейм
    out:classname:Имя класса:Возвращаемое значение
" node_system


//TODO fix bug - stackgen error
["createObject","Создать объект",'private @genvar.out.2 = new(@in.1); @out.1',"classname:Имя класса" opt "typeset_out=Объект","object^:Объект:Созданный объект","Выполняет базовое создание объекта. Если вам нужно создать игровой объект используйте узел для создания игровых объектов"] reg_unary
["deleteObject","Удалить объект",'delete(@in.1); @out.1',"object^:Объект:Ссылка на объект","","Выполняет базовое удаление объекта. Обратите внимание, что для удаления игровых объектов необходимо использовать узел для удаления игровых объектов."] reg_unary

nodeModule_setColorStyle("PureFunction")
nodeModule_setExecType("pure")


["thisObject","Этот объект:Объект этого графа (этот объект)",'this',"thisClassname:thisName","Возвращает ссылку на экземпляр (объект) текущего графа."] reg_nular

["getChildTypes","Унаследованные классы","[@in.1,@in.2] call oop_getinhlist","classname:Тип","bool:Глобально:Выполняет глобальный поиск не только прямых наследников, а вообщех всех объектов прямо или косвенно унаследовавших свойства проверяемого типа"
    opt "def=false", "array[classname]:Массив типов",
"Данный узел предназначен для получения массива типов, унаследованных от указанного типа."
] reg_binary

["isTypeOf","Унаследован от",'isTypeStringOf(@in.1,@in.2)',"object^:Объект","classname:Имя класса","bool:Результат","Проверяет, является ли проверяемый объект дочерним типом от указанного класса."] reg_binary

//istypeof

//TODO reflection category (e.g. reflection, injection, member info, attributes, etc.)
//!injection not must be added
//["createObjectByString","Создать объект",'instantiate(@in.1)']

