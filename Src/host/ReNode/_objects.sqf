node_system_group("objects")

nodeModule_setPath("Объекты")
nodeModule_setIcon("data\\icons\\icon_Blueprint_Node_16x")
nodeModule_setColorStyle("Function")
nodeModule_setExecType("all")

"
    node:null_check
    name:Объект существует
    namelib:Объект существует (не null)
    desc:Проверяет существование (валидность) объекта. Если ссылка на объект пригоден для использования (не удален и существует) - возвращает ИСТИНУ.
    icon:data\\icons\\icon_BluePrintEditor_Function_16px
    color:PureFunction
    exec:pure
    code:(!ISNULL(@in.1))
    in:object^:Объект:Ссылка на проверяемый объект.
    out:bool:Результат:Возвращает ИСТИНУ, если объект существует. Если ссылка на объект не существует или объект был удален - возвращает ЛОЖЬ.
" node_system

["createObject","Создать объект",'new(@in.1)',"classname:Имя класса","object^:Объект:Созданный объект","Выполняет создание объекта. Если вам нужно создать игровой объект используйте узел для создания игровых объектов"] reg_unary
["deleteObject","Удалить объект",'delete(@in.1)',"object^:Объект:Ссылка на объект","","Выполняет удаление объекта"] reg_unary

//TODO reflection category
//["createObjectByString","Создать объект",'instantiate(@in.1)']

