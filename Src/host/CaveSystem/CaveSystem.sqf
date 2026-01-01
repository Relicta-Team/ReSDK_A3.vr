// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"
#include <CaveSystem.h>
#include <CaveSystem.hpp>

//system
gvar(grid) = [];
gvar(width) = 0;
gvar(depth) = 0;
gvar(height) = 3;

gvar(origin) = [0,0,0];
gvar(exit) = [0,0,0];

gvar(gridOrigin) = [0,0,0];
gvar(gridExit) = [0,0,0];

gvar(bias) = 0;

gvar(branchesMax) = 1; // Кол-во ответвлений от Edge
gvar(branchSizeMin) = 1; // Минимальный размер ответвления от Edge
gvar(branchSizeMax) = 5; // Максимальный размер ответвления от Edge
gvar(branchChance) = 0.05; // Шанс ответвления от Edge

gvar(branchesSideMax) = 0; // Кол-во ответвления от ответвления
gvar(branchSideSizeMin) = 0; // Минимальный размер ответвления от ответвления
gvar(branchSideSizeMax) = 0; // Максимальный размер ответвления от ответвления
gvar(branchSideChance) = 0; // Шанс ответвления от ответвления

gvar(optionSize) = 10; // Размер блока (Не менять)
gvar(optionMidwayPoints) = 2; // Количество Edge + 1 (Дополнительные вершины)
gvar(optionTurnChanceEdge) = 0.2; // Шанс повернуть для Edge
gvar(optionTurnChanceBranch) = 0.2; // Шанс повернуть для Branch

gvar(entryOrigin) = [0,0,0]; // Направление входа относительно gridOrigin
gvar(entryExit) = [0,0,0]; // Направление выхода относительно gridExit

gvar(preCreate) = {
	gvar(randPoses) = [];
};

gvar(handleCreate) = {
	
	if (_k == 0) then {
		if (_j > 10 || _i > 10) then {
			gvar(randPoses) pushBack (_vPos vectorAdd [0,0,5.5]);
		};
	};
	
	_cube = createMesh(["block_dirt" arg _vPos arg false]);
	_cube setdir pick[0,90,180,270];
	/* TODO add mushroom generator
		if (k == 0)
			{
				#if VISIBLE_MOD
					MushroomPlacer.Generate(pos,true);
				#else
					MushroomPlacer.Generate(pos,false);
				#endif
			}
			listCaveBlocks.Add(cube);

	 */
	gvar(listCaveBlocks) pushBack _cube;
};
gvar(postCreate) = {
	{
		gvar(listCaveBlocks) pushBack (createMesh(["a3\structures_f\civ\camping\fireplace_f.p3d" arg _x arg false]))
	} foreach gvar(randPoses);
};

// Lists
if (!isNIL{gvar(listCaveBlocks)}) then {
	{
		deleteVehicle _x;
	} foreach gvar(listCaveBlocks);
};
gvar(listCaveBlocks) = [];

//производит инициализацию пещерной системы
dfunc(init) = {
	params ["_origin","_exit"];

	gvar(origin) = _origin;
	gvar(exit) = _exit;
	gvar(width) = floor ((abs (get_x(gvar(exit)) - get_x(gvar(origin)))) / 10 + 3);
	gvar(depth) = floor ((abs (get_y(gvar(exit)) - get_y(gvar(origin)))) / 10 + 3);
	gvar(grid) = [false,[gvar(width),gvar(depth)],gvar(height)] cfunc(newArray);
	
	//cavelogformat("Inited caves: bool[%1 , %2 , %3]",
	//count(gvar(grid)) arg
	//count(gvar(grid) select 0) arg
	//count(gvar(grid) select 0 select 0));
};

//Создаёт многомерный массив
dfunc(newArray) = {
	params ["_defVal","_dimensions","_elCounts"];
	
	reverse _dimensions;
	
	_basearr = [];
	_basearr resize _elCounts;
	_basearr =  str (_basearr apply {_defVal});
    private _el = "";

	{
		_el = _basearr;
		for "_i" from 2 to _x do {_basearr = _basearr + "," + _el};
		_basearr = "[" + _basearr + "]";
	} count _dimensions;

	parseSimpleArray _basearr
};



dfunc(generate) = {
	
	//cavelog("Start generating caves");
	FHEADER;
	gvar(timer) = tickTime + 15;
	
	// Расставление начальной и конечной точки
	if (get_x(gvar(origin)) - get_x(gvar(exit)) < 0) then {
		// Если выход правее входа
		set_x(gvar(gridOrigin), 1);
		set_x(gvar(gridExit), gvar(width) - 2);
	} else {
		// Если выход левее входа
		set_x(gvar(gridOrigin), gvar(width) - 2);
		set_x(gvar(gridExit), 1);
	};

	if (get_y(gvar(origin)) - get_y(gvar(exit)) < 0) then {
		// Если выход ниже входа
		set_y(gvar(gridOrigin),1);
		set_y(gvar(gridExit), gvar(depth) - 2);
	} else {
		set_y(gvar(gridOrigin), gvar(depth) - 2);
		set_y(gvar(gridExit), 1);
	};

	if (get_y(gvar(origin)) - get_y(gvar(exit)) < 0) then {
		gvar(bias) = get_y(gvar(origin)) - get_y(gvar(exit));
	};

	private _listTracePoints = [];

	_listTracePoints pushback gvar(gridOrigin);

	private _midwayX = 0;
	private _midwayY = 0;
	private _midway = [];
	
	//cavelogformat("Done prep generator. optionMidwayPoints - %1",gvar(optionMidwayPoints));
	
	for "_i" from 0 to gvar(optionMidwayPoints) - 1 do {
		_midwayX = round (rand(2,gvar(width) - 3));
		_midwayY = round (rand(2,gvar(depth) - 3));

		_midway = vector(_midwayX,_midwayY,0);

		_listTracePoints pushback _midway;
	};

	_listTracePoints pushback gvar(gridExit);

	
	//cavelogformat("List trace points - %1",count _listTracePoints);
	
	private _vecStart = [];
	private _vecExit = [];

	for "_i" from 0 to (count _listTracePoints) - 2 do {
		_vecStart = _listTracePoints select _i;
		_vecExit = _listTracePoints select (_i + 1);
		
		//_params = [_vecStart,_vecExit,gvar(branchesMax),gvar(branchSizeMin),gvar(branchSizeMax),gvar(branchChance),gvar(optionTurnChanceEdge),0];
		//cavelogformat("Iteration %1",_i);
		[_vecStart,_vecExit,gvar(branchesMax),gvar(branchSizeMin),gvar(branchSizeMax),gvar(branchChance),gvar(optionTurnChanceEdge),0] cfunc(generateBranch);
	};

	[0] cfunc(processFloor);


	cfunc(InstantiateGrid);

	cfunc(PrintOutGrid);

};


dfunc(generateBranch) = {

	params ["_start","_exit","_branchesMaxF","_branchSizeMinF","_branchSizeMaxF","_branchChanceF","_optionTurnChanceBranchF","_signature"];
	
	//cavelogformat("Start gen branch %1",_this);
	
	private _alg = +_start;
	private _canTurn = true;

	private _dirToExitX = math_sign(get_x(_exit) - get_x(_alg));
	private _dirToExitY = math_sign(get_y(_exit) - get_y(_alg));
	private _dirX = 0;
	private _dirY = 0;

	private _branchesLeft = _branchesMaxF;
	
	// Задаем изначальное направление
	if (_dirToExitX != 0 && _dirToExitY != 0) then {
		if (random(1) < 0.5) then {
			_dirX = _dirToExitX;
			_dirY = 0;
		} else {
			_dirX = 0;
			_dirY = _dirToExitY;
		};
	} else {
		_dirX = _dirToExitX;
		_dirY = _dirToExitY;
		_canTurn = false;
	};

	private _currentDirection = 0;

	private _resultTurn = 0;
	private _resultSide = 0;
	
	while {not_equals(_alg,_exit)} do {
		
		if (tickTime >= gvar(timer)) exitWith {
			error("TOO MUCH ITERATION ON GENERATE BRANCH");
			//RETURN(0);
		};
		//cavelogformat("Alg and Exit: %1 || %2",_alg arg _exit);
		
		gvar(grid) select get_x(_alg) select get_y(_alg) set [get_z(_alg),true];
		INC(_currentDirection);
		
		//Изменить направление
		_resultTurn = random 1;
		if ((_resultTurn < _optionTurnChanceBranchF || _currentDirection >= 3) && _canTurn) then {
			if (_dirX == 0) then {
				_dirY = 0;
				_dirX = _dirToExitX;
			} else {
				_dirX = 0;
				_dirY = _dirToExitY;
			};
			_currentDirection = 0;
		};
		
		//Запустить Side-ветку
		_resultSide = random 1;
		if (_resultSide < _branchChanceF && _branchesLeft > 0 && _signature < 2) then {
			private _set = [-1,1];

			private _biasX = (round math_rand(_branchSizeMinF,_branchSizeMaxF)) * (pick _set);
			private _biasY = (round math_rand(_branchSizeMinF,_branchSizeMaxF)) * (pick _set);
			private _deadWayX = floor math_max(math_min(get_x(_alg) + _biasX,gvar(width) - 3),2);
			private _deadWayY = floor math_max(math_min(get_y(_alg) + _biasY,gvar(depth) - 3),2);

			[_alg,vector(_deadWayX,_deadWayY,0),gvar(branchesSideMax),gvar(branchSideSizeMin),gvar(branchSideSizeMax),gvar(branchSideChance),gvar(optionTurnChanceBranch),_signature + 1] cfunc(generateBranch);
			
			DEC(_branchesLeft);
		};

		if (_dirX != 0) then {
			if not_equals(get_x(_alg),get_x(_exit)) then {
				_old = get_x(_alg);
				set_x(_alg,_old + _dirX);
			} else {
				_dirX = 0;
				_dirY = _dirToExitY;
				if not_equals(get_y(_alg),get_y(_exit)) then {
					_old = get_y(_alg);
					set_y(_alg,_old + _dirY);
				};
			};
		} else {
			if not_equals(get_y(_alg),get_y(_exit)) then {
				_old = get_y(_alg);
				set_y(_alg,_old + _dirY);
			} else {
				_dirY = 0;
				_dirX = _dirToExitX;
				if not_equals(get_x(_alg),get_x(_exit)) then {
					_old = get_x(_alg);
					set_x(_alg,_old + _dirX);
				};
			};
		};
	
	}; //end while


	gvar(grid) select get_x(_alg) select get_y(_alg) set [get_z(_alg),true];
	
	//cavelogformat("END gen branch %1",_this);
};


dfunc(processFloor) = {
	params ["_floor"];

	for "_j" from 1 to gvar(depth) - 2 do {
		for "_i" from 1 to gvar(width) - 2 do {
			if (gvar(grid) select _i select _j select _floor) then //потолок
			{
				gvar(grid) select _i select _j set [_floor + 2,true];

				if (!getGrid(_i + 1,_j,_floor)) then {
					setGrid(_i + 1,_j,_floor + 1,true);
				};
				if (!getGrid(_i,_j + 1,_floor)) then {
					setGrid(_i,_j + 1,_floor + 1,true);
				};
				if (!getGrid(_i - 1,_j,_floor)) then {
					setGrid(_i - 1,_j,_floor + 1,true);
				};
				if (!getGrid(_i,_j - 1,_floor)) then {
					setGrid(_i,_j - 1,_floor + 1,true);
				};

			}
		};
	};


	if (_floor == get_z(gvar(gridOrigin))) then {
		private _tempOrigin = gvar(gridOrigin) vectorAdd gvar(entryOrigin);
		setGrid(get_x(_tempOrigin),get_y(_tempOrigin),get_z(_tempOrigin) + 1,false);

		if (get_x(gvar(entryOrigin)) != 0) then {
			setGrid(get_x(_tempOrigin),get_y(_tempOrigin) + 1,get_z(_tempOrigin) + 1,false);
			setGrid(get_x(_tempOrigin),get_y(_tempOrigin) - 1,get_z(_tempOrigin) + 1,false);
		} else {
			if (get_y(gvar(entryOrigin)) != 0) then {
				setGrid(get_x(_tempOrigin) + 1,get_y(_tempOrigin),get_z(_tempOrigin) + 1,false);
				setGrid(get_x(_tempOrigin) - 1,get_y(_tempOrigin),get_z(_tempOrigin) + 1,false);
			};
		};
	};

	if (_floor == get_z(gvar(gridExit))) then {
		private _tempExit = gvar(gridExit) vectorAdd gvar(entryExit);
		setGrid(get_x(_tempExit),get_y(_tempExit),get_z(_tempExit) + 1,false);

		if (get_x(gvar(entryExit)) != 0) then {
			setGrid(get_x(_tempExit),get_y(_tempExit) + 1,get_z(_tempExit) + 1,false);
			setGrid(get_x(_tempExit),get_y(_tempExit) - 1,get_z(_tempExit) + 1,false);
		} else {
			if (get_y(gvar(entryExit)) != 0) then {
				setGrid(get_x(_tempExit) + 1,get_y(_tempExit),get_z(_tempExit) + 1,false);
				setGrid(get_x(_tempExit) - 1,get_y(_tempExit),get_z(_tempExit) + 1,false);
			};
		};

		
	};

};


dfunc(instantiateGrid) = {
	
	call gvar(preCreate);
	
	FOR(_k,0,gvar(height) - 1)
	{
		FOR(_j,0,gvar(depth) - 1)
		{
			FOR(_i,0,gvar(width) - 1)
			{
				if (gvar(grid) select _i select _j select _k) then {
					_vPos = vector(
						get_x(gvar(origin)) + (_i - 1) * gvar(optionSize),
						get_y(gvar(origin)) + (_j - 1) * gvar(optionSize) - gvar(bias),
						get_z(gvar(origin)) + _k * gvar(optionSize));
					
					call gvar(handleCreate);
				};
			}
		}
	};
	
	call gvar(postCreate);
};


dfunc(printOutGrid) = {

	#define _print(mes) conDllCall ((mes) + "#0100")

	FOR(_k,0,gvar(height) - 1)
	{
		if (_k == 1) then {
			
		_print("((( Current Z Level: " + str _k + " )))");
		private _final = "					";
		FOR(_j,0,gvar(depth) - 1)
		{
			
			FOR(_i,0,gvar(width) - 1)
			{
				if (gvar(grid) select _i select _j select _k) then {
					MOD(_final,+ "#");
				} else {
					MOD(_final,+ "*");
				};
			};
			
			MOD(_final,+ endl + "					");
		};
		
		
		_print(_final);
		
		};
	};
	_print("*** Print our finished ***");
};

/*
	GROUP: SETTINGS
*/


/// <summary>
/// Задает основные параметры CaveGenerator
/// </summary>
/// <param name="optionMidwayPoints">Количество дополнительных точек между входом и выходом</param>
/// <param name="optionSize">Размер строительного материала (10 - не изменять)</param>
/// <param name="optionTurnChanceEdge">Шанс поворота для основного пути</param>
/// <param name="optionTurnChanceBranch">Шанс поворота для веток</param>
dfunc(setOptionGeneral) = {
	params ["_midPoints","_optSize","_optTurnChanceEdge","_optTurnChanceBranch"];

	gvar(optionMidwayPoints) = _midPoints;
	gvar(optionSize) = _optSize;
	gvar(optionTurnChanceEdge) = _optTurnChanceEdge;
	gvar(optionTurnChanceBranch) = _optTurnChanceBranch;
};

/// <summary>
/// Задает параметры для веток первого поколения
/// </summary>
/// <param name="branchesMax">Максимум веток на одной Edge</param>
/// <param name="branchSizeMin">Минимальный размер веток</param>
/// <param name="branchSizeMax">Максимальный размер веток</param>
/// <param name="branchChance">Шанс заспавнить ветку</param>
dfunc(setOptionBranches) = {
	params ["_branchesMax","_branchSizeMin","_branchSizeMax","_branchChance"];

	gvar(branchesMax) = _branchesMax;
	gvar(branchSizeMin) = _branchSizeMin;
	gvar(branchSizeMax) = _branchSizeMax;
	gvar(branchChance) = _branchChance;

};


/// <summary>
/// Задает параметры для веток второго поколения
/// </summary>
/// <param name="branchesSideMax">Максимум веток на главной ветке</param>
/// <param name="branchSideSizeMin">Минимальный размер веток</param>
/// <param name="branchSideSizeMax">Максимальный размер веток</param>
/// <param name="branchSideChance">Шанс заспавнить ветку</param>
dfunc(setOptionSideBranches) = {
	//(int branchesSideMax,int branchSideSizeMin,int branchSideSizeMax,float branchSideChance)
	gvar(branchesSideMax) = _this select 0;
	gvar(branchSideSizeMin) = _this select 1;
	gvar(branchSideSizeMax) = _this select 2;
	gvar(branchSideChance) = _this select 3;
};

/// <summary>
/// Ставит входы и выходы для пещеры (нужно указать направление с помощьтю вектора)
/// </summary>
/// <param name="entryOrigin">Вход начала пещеры</param>
/// <param name="entryExit">Вход конца пещеры</param>
dfunc(setOptionEntry) = {
	//(Vector entryOrigin,Vector entryExit
	gvar(entryOrigin) = _this select 0;
	gvar(entryExit) = _this select 1;
};








// init system only after init all functions
#include "CaveSystemInit.sqf"
