// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\..\..\client\Interactions\interact.hpp>
#include <..\..\GameConstants.hpp>

//Кровеносная система
class(InternalReagents) extends(IReagentItem)
	var(reagents,[[vec2("Blood",BLOOD_MAX_VALUE_OZ)] arg 1000]newReagents);
endclass

editor_attribute("InterfaceClass")
class(IReagentItem) extends(Item)

	verbList("doempty",Item);

	var(material,"MatSynt");
	
	getterconst_func(isDrink,true);
	
	#include "..\..\Interfaces\IReagentContainer.Interface"
	var(reagents,vec2(this,INFINITY) call ms_create);
	
	//Можно ли перелить из контейнера
	getter_func(isTransferize,!isNull(callSelf(transferAmount)));
	getterconst_func(transferAmount,null); //если не null то указывает по сколько можно перемещать
	var(curTransferSize,0);
	
	getterconst_func(contentReagents,[]); //что будет создано в контейнере
	
	//Пока не разобрался с весом жидкостей
/*	func(getWeight)
	{
		objParams();
		private _w = callSuper(Item,getWeight);
		private _ms = getSelf(reagents);
		if isNullVar(_ms) exitWith {_w};
		_w + gramm(OZ(callSelf(getFilledSpace))) //28.35
	};*/

	func(getDescFor)
	{
		objParams_1(_usr);
		private _postTempInfo = "";
		
		callSuper(Item,getDescFor) 
		#ifdef EDITOR
		+ sbr + format["Заполнено на %1 из %2",callSelf(getFilledSpace),callSelf(getCapacity)] + _postTempInfo
		#endif
	};

	func(constructor)
	{
		objParams();
		if callSelf(isTransferize) then {
			if (getSelf(curTransferSize) == 0) then {
				setSelf(curTransferSize,callSelf(transferAmount) select 0);
			};
		};
		
		{
			callSelfParams(addReagent,_x select 0 arg _x select 1);
		} count callSelf(contentReagents);
	};

	func(transferTo)
	{
		objParams_1(_targ);

		callSelfParams(transferReagents,_targ arg getSelf(curTransferSize));
	};

	//опустошить содержимое
	func(pourOutReagents)
	{
		objParams();
		callSelfParams(removeReagents,getSelf(curTransferSize));
		callSelfParams(playSound,"reagents\water_land" arg getRandomPitchInRange(0.8,1.2));
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
	};

endclass

class(IReagentNDItem) extends(IReagentItem)
	#include "..\..\Interfaces\INetDisplay.Interface"

	var(ndName,"TransferLiquid");
	var(ndInteractDistance,INTERACT_DISTANCE);

	func(getNDInfo) {
		objParams();
		private _trAm = callSelf(transferAmount);
		if isNullVar(_trAm) exitWith {[callSelf(getName),[]]};

		//[callSelf(getName),LIST<getSelf(transferAmount)>]

		[callSelf(getName),getSelf(curTransferSize),_trAm]
	};

	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);
		if !array_exists(callSelf(transferAmount),_inp) exitWith {};

		setSelf(curTransferSize,_inp);
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		callSuper(IReagentItem,onInteractWith);
		
		if isTypeOf(_with,Syringe) exitWith {
			callFuncParams(_with,transferProcess,this arg _usr);
		};
		if callFunc(_with,isReagentContainer) exitWith {
			if callFuncParams(_with,transferTo,this) then {
				callFuncParams(_usr,meSay,
					"переливает содержимое из " + 
					lowerize(callFuncParams(_with,getNameFor,_usr)) + " в " + 
					lowerize(callFuncParams(this,getNameFor,_usr))
				);
			} else {
				private _m = ["Ничего не произошло.","Ничего не вышло","Из этого ничего не получилось."];
				callFuncParams(_usr,localSay,pick _m arg "error");
			};
		};
	};

	func(doExtinguish)
	{
		objParams_2(_targ,_pos);
		if isNullReference(_targ) exitWith {false};
		private _size = getSelf(curTransferSize);
		private _rvals = callSelfParams(removeReagentsAndReturn,_size);
		
		traceformat("doExitinguish() - matters: %1",_rvals);

		if (count _rvals > 0) then {
			callSelfParams(playSound,"reagents\water_land" arg getRandomPitchInRange(0.8,1.2));
			//TODO: done this fucking code...

			private _chid = _pos call atmos_chunkPosToId;

			private _sizeFactor = round(_size/30) min 1;
			for "_x" from -_sizeFactor to _sizeFactor do {
				for "_y" from -_sizeFactor to _sizeFactor do {
					for "_z" from -1 to 1 do {
						private _myCh = _chid vectorAdd [_x,_y,_z];
						
						private _chObj = [_myCh] call atmos_getChunkAtChIdUnsafe;
						if isNullVar(_chObj) then {continue};
						private _f = _chObj get "aFire";
						private _hasFire = !isNullVar(_f);
						private _fitems = [];
						{
							if callFunc(_x,isFireLight) then {
								if getVar(_x,lightIsEnabled) then {
									_fitems pushBack _x;
								};
							};
						} foreach (_chObj call ["getObjectsInChunk"]);

						{
							_x params ["_m","_n"];
							if (_m=="Water" && _n >= 1) then {
								if (_hasFire) then {
									_f call ["adjustForce",-5];
								};
								{callFuncParams(_x,lightSetMode,false)} foreach _fitems;
							};
							if (_m=="Spirt" && _n>=0.5) then {
								if (_hasFire) then {
									_f call ["adjustForce",7];
								};
								if (count _fitems > 0) then {
									_f = [_chObj call ["getChunkCenterPos"],"AtmosAreaFire",true] call atmos_createProcess;
									_hasFire = !isNullVar(_f);
									_f call ["adjustForce",5];
								};
							} else {
								if (_n >= 2) then {
									if (_hasFire) then {
										_f call ["adjustForce",-1];
									};
								};
							};
						} foreach _rvals;
					}
				}
			};

			//prob more size for transsize
			
		};
		count _rvals > 0;
	};

	getter_func(getMainActionName,"Объём переливания");
	func(onMainAction)
	{
		objParams_1(_usr);
		if callSelf(isInWorld) then {
			callFuncParams(this,openNDisplay,_usr);
		} else {
			callFuncParams(this,openNDisplayInternal,_usr arg getVar(_usr,owner))
		};
	};
	
	
	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = callSuper(IReagentItem,getDescFor);
		private _contInfo = "";
		private _cap = callSelf(getCapacity);
		/*if(istype(M,/mob/human/) && M:get_alchemy() >= 5)
			mytext += "Кажется, ты различаешь, что внутри находится:"
			for(var/datum/reagent/R in reagents.reagent_list) mytext += " [R.title]!"*/
		private _filled = callSelf(getFilledSpace);
		if (_filled > 0) then {
			if (_filled >= _cap) exitWith {_contInfo = sbr + "Полностью заполнено.";};
			if (_filled >= _cap/2) exitWith {_contInfo = sbr + "Заполнено на половину."};
			_contInfo = sbr + "Осталось меньше половины.";
		} else {
			_contInfo = sbr + "Внутри пусто.";
		};
		_txt + _contInfo
	};

	func(onChangeLoc)
	{
		objParams();
		callSelf(closeNDisplayForAllMobs);
	};

endclass