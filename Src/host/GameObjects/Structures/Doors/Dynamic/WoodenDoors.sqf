// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>

class(WoodenDoor) extends(DoorDynamic)
	var(name,"Деревянная дверь");
	var(model,"Land_xlamdoor");
	var(material,"MatWood");
	var(dr,2);
	//var(keyTypes,["test"]);

	getter_func(animateData,[["xlamdoor" arg 0.7 arg 2.5]]);
	getter_func(isWoodenDoor,true);
	getter_func(canBreakDoor,true);
	var(stBreakBonus,0);
endclass

editor_attribute("EditorGenerated")
class(WoodenGridDoor) extends(WoodenDoor)
	var(model,"Land_GameProofFence_01_l_gate_F");
	var(material,"MatWood");
	var(name,"Калитка");
	var(dr,1);
	getter_func(animateData,[["door_1_rot" arg 1.5 arg 2.5]]);
endclass


class(WoodenDoubleDoor) extends(DoorDynamic)
	var(name,"Деревянная двойная дверь");
	var(model,"Land_doorvlk");
	var(material,"MatWood");
	//var(keyTypes,["test"]);
	getter_func(anmCount,animObj_count(2));
	getter_func(animateData,[vec3("doorvlk1",1.4,2.5) arg vec3("doorvlk2",1.4,2.5)]);
	var(serializedAnim,[-1 arg -1 arg -1 arg -1 arg -1 arg -1]);
	getter_func(isWoodenDoor,true);
	getter_func(canBreakDoor,true);
endclass