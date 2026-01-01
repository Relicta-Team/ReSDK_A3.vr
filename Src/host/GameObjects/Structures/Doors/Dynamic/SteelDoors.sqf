// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>


//DO NOT CREATE THIS CLASS
class(SteelWindowDoor) extends(DoorDynamic)
	var(model,"Land_traindoor2");
	var(material,"MatMetal");
	getter_func(animateData,[["traindoor" arg 1.5 arg 3]]);
	
	var(stBreakBonus,-4);
	getter_func(canBreakDoor,true);
endclass

class(SteelDoorThinSmall) extends(DoorDynamic)
	var(name,"Стальная дверь");
	var(model,"Land_door_solar");
	var(material,"MatMetal");
	//"zashelka","zamok"
	getter_func(animateData,[["door_solar" arg 1.5 arg 3]]);
	
	var(stBreakBonus,-4);
	getter_func(canBreakDoor,true);
endclass

class(SteelArmoredDoor) extends(DoorDynamic)
	var(stBreakBonus,-6);
	getter_func(canBreakDoor,true);
	var(name,"Бронированная дверь");
	var(desc,"Эта массивная дверь за долгие годы успела полностью заржаветь. А вот решётка внутри выглядит вроде неплохо");
	var(model,"Land_doub_bronedwerks");
	var(material,"MatMetal");
	var(dr,4);
	
	getter_func(anmCount,animObj_count(2));
	getter_func(animateData,[["plomba5" arg 2.5 arg 5] arg vec3("reshotks",1.78,5)]);
	var(serializedAnim,[-1 arg -1 arg -1 arg -1 arg -1 arg -1]);

	func(constructor)
	{
		objParams();
		//след.кадр чтобы избежать спама проблем (анимация до создания модели)
		nextFrameParams({callFunc(_this,animateSource)},this);
	};
	
	func(onDeanim)
	{
		objParams();
		if (_forEachindex == 0) then {true} else {_mode}
	};
	/*
		Условие отмены действия:
			
		
		Условие открытия/закрытия бронедвери
			персонаж находится спереди (от 120 до 250 через проверку) getSelf(loc) getRelDir getVar(_usr,owner)
		или
			отмена анимации
		
		Условие открытия/закрытия решетки:
			бронедверь открыта или находится в (от 60 до 290 через ) getSelf(loc) getRelDir getVar(_usr,owner)
		или
			отмена анимации
	*/
	
endclass

class(SteelArmoredDoor2) extends(SteelArmoredDoor)
	var(desc,"Массивная стальная дверь");
	getter_func(animateData,[["reshotks" arg 2.5 arg 5] arg vec3("plomba5",1.78,1.4)]);
endclass

class(SteelLatticeGate) extends(DoorDynamic)
	var(name,"Стальные ворота");
	var(model,"Land_PipeFence_01_m_gate_v2_closed_F");
	getter_func(anmCount,animObj_count(2));
	getter_func(animateData,[["door_1_rot" arg 2.5 arg ifcheck(!getSelf(isOpen),1.5,0.5)] arg ["door_2_rot" arg 2.5 arg ifcheck(!getSelf(isOpen),1.5,0.5)]]);
	var(serializedAnim,[-1 arg -1 arg -1 arg -1 arg -1 arg -1]);
	var(material,"MatMetal");
endclass

class(TinGate) extends(DoorDynamic)
	var(name,"Железные ворота");
	var(model,"land_tinwall_01_m_gate_v2_closed_f");
	getter_func(anmCount,animObj_count(2));
	getter_func(animateData,[["door_1_rot" arg 2.5 arg ifcheck(!getSelf(isOpen),0.7,0.7)] arg ["door_2_rot" arg 2.5 arg ifcheck(!getSelf(isOpen),0.7,0.7)]]);
	var(serializedAnim,[-1 arg -1 arg -1 arg -1 arg -1 arg -1]);
	var(material,"MatMetal");
endclass

class(GreenAmbarWithDoors) extends(DoorDynamic)
	getter_func(canUseMainAction,false); //В амбаре нельзя юзать такие дейсвтия
	getter_func(canApplyDamage,false);
	var(model,"Land_Barn_W_02");
	var(material,"MatBeton");
	var(name,"Амбар");
	func(onDeanim)
	{
		objParams();
		true
	};
	
	func(constructor)
	{
		objParams();
		//callSelf(animateSource);
		nextFrameParams({callFunc(_this,animateSource)},this);
	};
	
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
	};
	func(onClick)
	{
		objParams_1(_usr);
	};
	
	getter_func(anmCount,animObj_count(2));
	getter_func(animateData,[["door_3_rot" arg 1 arg 5] arg vec3("door_1_rot",1,5)]);
	var(serializedAnim,[-1 arg -1 arg -1 arg -1 arg -1 arg -1]);
endclass