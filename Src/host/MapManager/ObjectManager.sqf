// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//todo Replace to NOEngine

//Алгоритм симуляции падения объектов.
simulatePhysicsOnVisualObject = {
	params ["_src"];

	#define doPhisicsLog
	//#define enablePhisics

	#ifdef doPhisicsLog
		#define simlog(data) trace("[simulatePhysics]:	"+ data)
		#define simlogf(data,ft) traceformat("[simulatePhysics]:	"+ data,ft)
	#else
		#define simlog(data)
		#define simlogf(data,ft)
	#endif

	#ifndef enablePhisics
		if (true) exitWith {};
	#endif

	private _dia = 2/*(boundingBoxReal _src) select 2*/; simlogf("dia is %1",_dia)
	//собираем ближайшие объекты
	private _list = (_src nearObjects (_dia * 0.5)) - [_src]; simlogf("obj list %1",_list)

	//Делаем простую проверку пересекается ли объект
	private _doSimList = [];
	private _posStart = getPosATL _src;
	private _posEnd = vec3(0,0,0);
	private _posEndDown = vec3(0,0,0);
	private _zCheck = _dia * 3;
	private _itscRes = [];
	{
		if (callFunc(_x getVariable ["link" arg nullPtr],isItem)) then {
			_posEnd = getPosATL _x;
			_itscRes = lineIntersects [ATLToASL _posEnd,(ATLToASL _posEnd) vectorDiff [0,0,_zCheck]]; simlogf("object %1 intersect result: %2",_x arg _itscRes)
			if (_itscRes) then {
				simlogf("Find new pos for object %1",_x)
				private _ins = lineIntersectsSurfaces [ATLToASL _posEnd,(ATLToASL _posEnd) vectorDiff vec3(0,0,200),_src,_x,true,1,"VIEW","FIRE"]; simlogf("INTERSECT DATA %1",_ins)
				if (count _ins > 0) then {
					simlogf("NEW POSITION CATCHED FOR %4!: Pos:%1 (old:%2); Vec%3",ASLToATL(_ins select 0 select 0) arg getPosATL _x arg _ins select 0 select 1 arg _x)
					(_ins select 0) params ["_pos","_vecup","_targ"];
					//[ASLToATL _pos,getDir _x,_vecup];
					//_x setPosAtl (ASLToATL _pos);
					//_x setVectorUp _vecup;


					//TODO MP SYNC
					nextFrameParams({(_this select 0) setposatl (_this select 1); (_this select 0) setVectorUp (_this select 2)},vec3(_x,ASLToATL _pos,_vecup))
				};
			};
		};
	} foreach _list;
	//если пересекается то бросаем трейс исключая источник

	//для полученной позиции нужно перерегистрировать объект
	 	//выгружаем модель
		//загружаем модель на новой позиции с поворотами


};
