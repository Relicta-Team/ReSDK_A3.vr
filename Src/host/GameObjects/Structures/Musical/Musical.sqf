// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")

class(MusicStruct) extends(IStruct)
	var(name,"Музыкальный инструмент");
	getter_func(isMovable,true);
	var(material,"MatWood");
	var(dr,1);
endclass

class(Piano) extends(MusicStruct) 
	var(name,"Пианина");
	var(desc,"Жмёшь на кнопки и играет!");
	var(model,"ml\ml_object_new\model_14_10\royal.p3d");
	getterconst_func(getCoefAutoWeight,50);
endclass

class(Gramophone) extends(MusicStruct)
	var(name,"Граммофон");
	var(model,"relicta_models\models\interier\props\patefon.p3d");
	getter_func(isMovable,true);
endclass
