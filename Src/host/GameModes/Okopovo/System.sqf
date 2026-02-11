// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\GameMode.h"
#include "Okopovo.h"

class(OkopovoSergantesSquad) extends(IGamemodeSpecificClass)
	var(side,"na");
	var(squadName,"");
	var(commander,nullPtr);
	var(soldiers,[]);

	var(maxSoldiers,4);

	func(onMakeSquad)
	{
		objParams_2(_leader,_side);

		setSelf(side,_side);

		if (getSelf(side)=="na") then {
			_m = ["Азирь","Босля","Вурток","Гандаш","Дорба"];
			_ms = format["%1-%2",_m select (getVar(gm_currentMode,basenumNA) % 5),getVar(gm_currentMode,basenumNA)];
			setSelf(squadName,_ms);
			modVar(gm_currentmode,basenumNA,+1);
		} else {
			_m = ["Ватага Хаоса","Ватага Дранка","Ватага Гнилостоя","Ватага Оторвы","Ватага Бездны"];
			private _newpostfix = "";
			for "_i" from 1 to randInt(3,5) do {
				modvar(_newpostfix) + (
					pick["а","б","з","к","в","у","с","г","я"]
				);
			};
			_ms = format["%1 %2",_m select (getVar(gm_currentMode,basenumIZ) % 5),capitalize(_newpostfix)];
			setSelf(squadName,_ms);
			modVar(gm_currentmode,basenumIZ,+1);
		};

		setSelf(commander,_leader);
		(getVar(gm_currentMode,sergantesInSide) get getSelf(side)) pushBack this;
	};

	func(onAddMob)
	{
		objParams_2(_mob,_side);
		getSelf(soldiers) pushBack _mob;
		setVar(_mob,__gmokopovo_mysquad,this);
	};

	func(getActiveSoldiers)
	{
		objParams();
		private _l = [];
		{
			if isNullReference(_x) then {continue};
			if callFunc(_x,isActive) then {_l pushBack _x};
		} foreach getSelf(soldiers);
		_l
	};

	func(canAddNewMob)
	{
		objParams();
		if getVar(getSelf(commander),isDead) exitWith {false};
		private _count = count getSelf(soldiers);
		_count < getSelf(maxSoldiers);
	};
endclass


global_function_rOkopovo_createDocs = {
	objParams_2(_cl,_mob);
	if (getSelf(side)=="na") then {

		

		private _p = ["Paper",_cl] call createItemInContainer;
		setVar(_p,model,"a3\structures_f\items\documents\file1_f.p3d");
		setVar(_p,name,"Билет Новой Армии");

		_t = format["<t size='1.5' color='#212121' font='RobotoCondensed'>Военный билет Новой Армии #%5%1Имя: %2%1Возраст: %3%1Специальность: %4%1</t>"
			,sbr
			,callFuncParams(_mob,getNameEx,"кто")
			,[getVar(_mob,age),["год","года","лет"],true] call toNumeralString
			,getVar(getVar(_mob,basicRole),name)
			,randInt(2000,8000)
		];
		setVar(_p,content,_t);

		callFuncParams(_mob,generateNaming,getVar(getVar(_mob,basicRole),name) arg callFunc(_mob,getSecondName));
	} else {
		private _m = "a3\props_f_orange\civilian\constructions\brick_01_f.p3d";
		private _p = ["GMOkopovoItemInfoRock",_cl] call createItemInContainer;
		setVar(_p,model,_m);
		setVar(_p,size,ITEM_SIZE_TINY);
		setVar(_p,weight,gramm(200));
		setVar(_p,name,"Обозвалец " + callFuncParams(_mob,getNameEx,"кого"));
		private _ds = format[
			"Небольшой плоский камень с высеченными буквами: '%1'"
			,getVar(getVar(_mob,basicRole),name)
		];
		setVar(_p,desc,_ds);

		callFuncParams(_mob,generateNaming,getVar(getVar(_mob,basicRole),name) arg callFunc(_mob,getFirstName));
	};
	if prob(50) then {
		for "_i" from 1 to randInt(1,3) do {
			["SigaretteDisabled",_cl] call createItemInContainer;
		};
		["MatchBox",_cl] call createItemInContainer;
	};

};

class(GMOkopovoItemInfoRock) extends(Item)
	var(model,"a3\props_f_orange\civilian\constructions\brick_01_f.p3d");
endclass