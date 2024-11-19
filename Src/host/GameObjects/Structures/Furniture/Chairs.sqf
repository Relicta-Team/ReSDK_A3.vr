// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


editor_attribute("InterfaceClass")
editor_attribute("TemplatePrefab")
class(IChair) extends(Furniture)
	var(name,"Сиденье");
	var(material,"MatWood");
	var(dr,2);

	#include "..\..\Interfaces\ISeat.Interface"

	getterconst_func(getChairOffsetPos,vec3(0,0,0));
	getterconst_func(getChairOffsetDir,0);
	getterconst_func(getCoefAutoWeight,10);
endclass

editor_attribute("EditorGenerated")
class(Wheelchair) extends(IChair)
	var(model,"ml_exodusnew\virusbratan.p3d");
	var(material,"MatSynt");
	var(dr,1);
	var(name,"Коляска");
	var(desc,"Поговаривают если долго на ней сидеть, то можно подцепить вирус...");
	getter_func(getChairOffsetPos,[0 arg -0.05 arg -0.65]);
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getCoefAutoWeight,40);
endclass

editor_attribute("EditorGenerated")
class(Wheelchair2) extends(Wheelchair)
	var(model,"relicta_models\models\nocategory\wheelchair2.p3d");
	getter_func(getChairOffsetPos,[0 arg 0 arg -0.73]);
	getterconst_func(getChairOffsetDir,180);
endclass

editor_attribute("EditorGenerated")
class(Wheelchair1) extends(Wheelchair)
	var(model,"relicta_models\models\nocategory\wheelchair1.p3d");
	getter_func(getChairOffsetPos,[0 arg 0.09 arg -0.45]);
	getterconst_func(getChairOffsetDir,180);
endclass

editor_attribute("EditorGenerated")
class(OldGreenToiletBowl) extends(IChair)
	var(model,"ml\ml_object_new\model_24\tolchek.p3d");
	var(material,"MatMetal");
	var(name,"Туалет");
	getter_func(isMovable,false);
	getter_func(getChairOffsetPos,[-0.0479994 arg -0.0999994 arg -1.1]);
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getCoefAutoWeight,20);
endclass

editor_attribute("EditorGenerated")
class(BrownOldArmchair) extends(IChair)
	var(model,"ml\ml_object_new\model_14_10\kreslo.p3d");
	getter_func(getChairOffsetPos,[0 arg 0.3 arg -0.5]);
	getterconst_func(getCoefAutoWeight,20);
endclass


class(HeadThrone) extends(IChair)
	var(name,"Трон");
	getterconst_func(getChairOffsetPos,vec3(0,-0.15,-1.1));
	getterconst_func(getChairOffsetDir,180);
	var(model,"relicta_models\models\interier\throne.p3d");
	var(dr,3);
endclass

//kresla

class(RedLuxuryChair) extends(IChair)
	getterconst_func(getChairOffsetDir,90);
	getterconst_func(getChairOffsetPos,vec3(0.2,0,-0.7));
	var(model,"ml_shabut\kryslo\kryslo.p3d");
endclass

class(ArmChair) extends(IChair)
	getterconst_func(getChairOffsetPos,vec3(0,0,-0.5));
	getterconst_func(restBias,vec3(0,0.68,0));
	var(model,"a3\props_f_orange\furniture\armchair_01_f.p3d");
endclass

class(ArmChairBrown) extends(IChair)
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getChairOffsetPos,vec3(0,-0.1,0));
	var(model,"ca\buildings\furniture\armchair.p3d");
endclass

class(LobbyChair) extends(IChair)
	getterconst_func(getChairOffsetDir,180);
	getterconst_func(getChairOffsetPos,vec3(0,-0.1,0));
	var(model,"ca\structures\furniture\chairs\lobby_chair\lobby_chair.p3d");
endclass

editor_attribute("Deprecated" arg "Заменить на BrownLeatherChair. Будет удален с редактором 1.20")
class(BumArmChair) extends(IChair)
	getterconst_func(getChairOffsetPos,vec3(0,0.2,-0.5));
	getterconst_func(restBias,vec3(0,0.8,0));
	var(model,"smg_metro_building\drugoe\smg_bomjkreslo.p3d");
	var(dr,1);
endclass
	class(BrownLeatherChair) extends(BumArmChair)
		var(model,"smg_metro_building\drugoe\smg_bomjkreslo.p3d");
	endclass

class(GreenArmChair) extends(IChair)
	getterconst_func(getChairOffsetPos,vec3(0,-0.25,-0.4));
	getterconst_func(getChairOffsetDir,180);
	var(model,"ml\ml_object_new\model_14_10\diwan.p3d");
endclass
	//EQUALS
	editor_attribute("Deprecated" arg "Заменить на GreenArmChair. Будет удален с редактором 1.20")
	class(GreenChair) extends(GreenArmChair)
		var(model,"ml\ml_object_new\model_14_10\diwan.p3d");
	endclass