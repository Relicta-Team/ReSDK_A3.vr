// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\..\text.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\NOEngine\NOEngine_SharedTransportLevel.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>

//Динамическая дверь. Открывается через анимацию
class(DoorDynamic) extends(DynamicStruct)
	var(name,"Дверь");
	var(dr,2);
	getter_func(animateData,[]); //лист аргументов справа от animate (НЕ ДОЛЖНО СОДЕРЖАТЬ ПОКА БОЛЕЕ 1 СТЕЙТА АНИМАЦИИ)
	var(serializedAnim,[-1 arg -1 arg -1]); //подготовленная анимация (должна совпадать с количеством анимаций)

	getter_func(getOpenSoundParams,["doors\wooden_open" arg getRandomPitchInRange(0.6,1.3) arg null]);
	getter_func(getCloseSoundParams,["doors\wooden_close" + str pick [1 arg 2] arg getRandomPitchInRange(0.6,1.3) arg null]);

	#include "..\..\..\Interfaces\DoorBaseMethods.Interface"

	func(animateSource)
	{
		objParams();

		private _mode = getSelf(isOpen);
		private _src = getSelf(loc);
		private _doorData = [];
		{
			if (!callSelf(onDeanim)) then {_x set [1,0]}; //door to default state
			//форсим скорость анимации для сервера для синхронизации навигационного региона
			//upd - для рейкастов инфа обновится в следующем кадре
			_src animate [_x select 0,_x select 1,true]; //аниматор сервера

			__anass = [_x select 0] call anim_getAssoc;
			_doorData append [__anass arg _x select 1 arg _x select 2];

		} foreach callSelf(animateData);
		
		setSelf(serializedAnim,_doorData);
		
		//обновляем анимацию с изменением byteArr
		[_src,CHUNK_TYPE_STRUCTURE,true] call noe_replicateObject;
	};
	
	//Событие указывает можно ли закрыть дверь. Допускается использование спец.переменных _mode и _foreachIndex
	getter_func(onDeanim,_mode);



endclass



/*
"Land_bronedver" ["plomba1","plomba_vent1","plomba_vent2"] новая сталь крутилка
"Land_bronedwerka" ["plomba2","plombavent1","plombavent2"] рыжая ржавая крутилка
"Land_reshetow" ["reshetow"] решетка
"Land_dooor1" ["dooor","mesh_0"] рыжая ржавая с окном
"Land_traindoor" ["new selection","traindoor"] дверь вагона с бетонной аркой
"Land_traindoor2" ["traindoor"] дверь вагона
*/
