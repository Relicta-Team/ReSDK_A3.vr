// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\..\engine.hpp>
#include <..\..\..\..\oop.hpp>
#include <..\..\..\..\text.hpp>
#include <..\..\..\GameConstants.hpp>
#include <..\..\..\..\ServerRpc\serverRpc.hpp>
#include <..\..\..\..\NOEngine\NOEngine.hpp>

//Статическая дверь. Открывается сменой позиции/поворотом
class(DoorStatic) extends(IStruct)
	var(dr,2);
	getter_func(animateData,[]);//[vecbias,dir]

	getter_func(getOpenSoundParams,["doors\wooden_open" arg getRandomPitchInRange(0.6,1.3) arg null]);
	getter_func(getCloseSoundParams,["doors\wooden_close" + str pick [1 arg 2] arg getRandomPitchInRange(0.6,1.3) arg null]);

	#include "..\..\..\Interfaces\DoorBaseMethods.Interface"

	var_array(originData);

	func(animateSource) {
		objParams();

		if (!callSelf(isInWorld)) exitWith {}; //незагруженные не анимируем

		private _mode = getSelf(isOpen);
		private _src = getSelf(loc);
		
		callSelf(animateData) params ["_pos","_dir"];

		private _origin = getSelf(originData);

		if (_mode) then {
			// !!!WARNING!!! благодаря способу сохранения позиций динамических дверей они не расчитаны на пользовательское изменение позиций в открытом состоянии в данный момент.
			//private _origin = getSelf(originData);
			
			if equals(_origin,[]) then {

				if (!_mode) then {
					errorformat("Origin in object %1 is empty array. Object is closing process.",callSelf(getClassName));
				};
				_origin set [0,getPosATL _src];
				_origin set [1,getDir _src];
			};
			
			if (count _origin != 4) then {
				private _tempObj = createMesh([getSelf(model) arg [0 arg 0 arg 0] arg true]);
				_tempObj setPosAtl (_origin select 0);
				_tempObj setDir (_origin select 1);
				
				_origin set [2,_tempObj modelToWorld _pos];
				_origin set [3,_dir + (_origin select 1)];


				deleteVehicle _tempObj;
			};
			
			_src setPosAtl (_origin select 2);
			_src setDir (_origin select 3);
			
			private _ipar = [getSelf(pointer),[_origin select 2,getDir _src],["std"]];
			callSelfParams(interpolateVisual,_ipar);
			
			[_src,CHUNK_TYPE_STRUCTURE,true] call noe_replicateObject;

		} else {

			if equals(_origin,[]) exitWith {
				errorformat("Origin in object %1 is empty array.",callSelf(getClassName));
			};
			

			_src setPosAtl (_origin select 0);
			_src setDir (_origin select 1);
			
			private _ipar = [getSelf(pointer),[_origin select 0,getDir _src],["std"]];
			callSelfParams(interpolateVisual,_ipar);

			[_src,CHUNK_TYPE_STRUCTURE,true] call noe_replicateObject;

		};

	};

	getterconst_func(interpSpeed,-0.35);//negative == random offset

	//рассылка визуала
	//! вызывает проблему когда объект реплицируется в соседний чанк
	func(interpolateVisual)
	{
		objParams_1(_data);

		if (count _data < 3) then {
			_data set [2,["ispd",callSelf(interpSpeed)]];
		} else {
			(_data select 2) append ["ispd",callSelf(interpSpeed)];
		};

		{
			callFuncParams(_x,sendInfo,"nintrp" arg _data);
		} foreach callSelfParams(getNearMobs,chunkSize_structure);
	};

endclass


//for testing [obj,[-0.73,0.7,-1.365],270] call struct_door_initOpenMode;
struct_door_initOpenMode = {
	params ["_o","_vecbias","_dir"];
	if !isNull(struct_door_internal_ref) then {
		deleteVehicle struct_door_internal_ref;
	};

	private _tempObj = createMesh( [(getModelInfo _o) select 1 arg [0 arg 0 arg 0] arg true]);

	_tempObj setPosAtl getPosATL _o;
	_tempObj setdir (getdir _o);

	_tempObj setPosAtl (_tempObj modelToWorld _vecbias);
	_tempObj setDir (getdir _o + _dir);
	struct_door_internal_ref = _tempObj;
};

/*
"ml\ml_object_new\ml_object_2\l01_props\reshetka.p3d" решетка


*/
