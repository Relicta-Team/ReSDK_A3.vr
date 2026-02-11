// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\ServerRpc\serverRpc.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>

class(SteelGridDoor) extends(DoorStatic)
	var(name,"Решётка");
	//var(model,"reshetka");
	var(model,"ml\ml_object_new\ml_object_2\l01_props\reshetka.p3d");
	var(material,"MatMetal");
	var(dr,3);
	getter_func(animateData,[vec3(0.55,0.55,-1.76488) arg 90]);

	getter_func(getOpenSoundParams,["doors\cage_open" arg getRandomPitchInRange(0.5,1.5) arg null arg 1.5]);
	getter_func(getCloseSoundParams,["doors\cage_close" arg getRandomPitchInRange(0.5,1.5) arg null arg 1.5]);
	
	var(stBreakBonus,0);
	getter_func(canBreakDoor,true);
endclass

class(SteelGreenDoor) extends(SteelGridDoor)
	var(name,"Стальная дверь");
	getter_func(animateData,[vec3(-0.73,0.7,-1.365) arg 270]);
	var(model,"ml\ml_object_new\model_14_10\dooor.p3d");
	var(stBreakBonus,-2);
endclass

class(SteelBrownDoor) extends(SteelGridDoor)
	var(name,"Стальная дверь");
	getter_func(animateData,[vec3(-0.73,0.69,-1.31) arg 270]);
	var(model,"ml\ml_object_new\model_14_10\dwerrj.p3d");
	var(stBreakBonus,-3);
endclass

class(Wicket) extends(SteelGridDoor)
	var(name,"Калитка");
	var(dr,2);
	var(model,"ml_shabut\tinfence\tinfence.p3d");
	getter_func(animateData,[vec3(0.85,-0.85,-0.85) arg 90]);
	var(stBreakBonus,0);
endclass