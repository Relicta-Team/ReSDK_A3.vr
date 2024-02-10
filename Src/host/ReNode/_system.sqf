node_system_group("system")

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
//TODO iseditor, isrelease, isdebug


// nodeModule_setExecType("all")
// nodeModule_setColorStyle("Function")
// ["assert","Утверждение",'assert_str(@in.1,@in.2); @out.1',"float:Значение" opt 'dname=0:mul=1',"Проверяет выражение"] reg_binary