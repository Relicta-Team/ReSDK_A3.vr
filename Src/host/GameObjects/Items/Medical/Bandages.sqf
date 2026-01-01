// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

// blood protect
class(Bandage) extends(Item)
	var(name,"Бинт");
	var(model,"a3\structures_f_epa\items\medical\bandage_f.p3d");
	var(material,"MatCloth");
	var(weight,gramm(40));
	var(allowedSlots,[INV_FACE]);

	func(bandageProcess)
	{
		objParams_3(_targ,_usr,_isAdding);

		private _isSelf = equals(_targ,_usr);
		if isNullVar(_isAdding) then {_isAdding = true};

		if (_isAdding) then {
			if callSelfParams(onBandage,_targ arg _usr arg true) then {
				callFuncParams(_usr,meSay,"начинает бинтовать "+ifcheck(_isSelf,"себя",callFuncParams(_targ,getNameEx,"вин")));
				callFuncParams(_usr,startProgress,_targ arg "item.onBandage" arg getVar(_usr,rta)*5 arg INTERACT_PROGRESS_TYPE_MEDIUM arg this);
			};
		} else {
			if callSelfParams(onBandageRemove,_targ arg _usr arg true) then {
				callFuncParams(_usr,meSay,"начинает разбинтовывать "+ifcheck(_isSelf,"себя",callFuncParams(_targ,getNameEx,"вин")));
				callFuncParams(_usr,startProgress,_targ arg "item.onBandageRemove" arg getVar(_usr,rta)*5 arg INTERACT_PROGRESS_TYPE_MEDIUM arg this);
			};
		};


	};

	func(onBandage)
	{
		objParams_3(_targ,_usr,_precheck);

		if isNullVar(_precheck) then {_precheck = false};

		private _ctz = getVar(_usr,curTargZone);
		private _isSelf = equals(_targ,_usr);

		private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
		if !callFuncParams(_targ,hasPart,_bp) exitWith {
			if (_precheck) then {
				callFuncParams(_usr,localSay,"Нет такой части тела..." arg "error");
			};
			false
		};

		//проверка на одежду
		private _zoneSlot = [_ctz] call gurps_convertTargetZoneToSlot;
		if (_zoneSlot in [INV_HAND_L,INV_HAND_R,INV_BELT]) then {_zoneSlot = INV_CLOTH};
		if !callFuncParams(_targ,isEmptySlot,_zoneSlot) exitWith {
			if (_precheck) then {
				callFuncParams(_usr,localSay,"Надо сначала снять "+callFuncParams(callFuncParams(_targ,getItemInSlot,_zoneSlot),getNameFor,_usr)+"." arg "error");
			};
			false
		};

		private _part = callFuncParams(_targ,getPart,_bp);
		if callFunc(_part,isBandaged) exitWith {
			if (_precheck) then {
				callFuncParams(_usr,localSay,"Надо сначала старый бинт снять." arg "error");
			};
			false
		};

		if (_precheck) exitWith {true};

		private _bonus = 4;

		//если персонаж без сознания его проще зашить
		if !callFunc(_targ,isActive) then {
			modvar(_bonus) + 1;
		};
		//плохое освещение
		if (callFunc(_targ,getLighting)<LIGHT_LOW) then {
			modvar(_bonus) - 2;
		};
		if callFunc(_targ,isConnected) then {
			modvar(_bonus) + 2;
		};

		private _roll = callFuncParams(_usr,checkSkill,"healing" arg _bonus);
		private _result = getRollType(_roll);

		if (_result in [DICE_SUCCESS,DICE_CRITSUCCESS]) exitWith {
			callFuncParams(_usr,removeItem,this);
			callFuncParams(_part,addBandage,this);
			private _act = format[ifcheck(_isSelf,"%1 бинтует себе %2","%1 бинтует %2 %3"),
				callFuncParams(_usr,getNameEx,"кто"),
				[_ctz,TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString,
				callFuncParams(_targ,getNameEx,"кого")];
			callFuncParams(_usr,worldSay,_act arg "act");
		};
		if (_result == DICE_FAIL) exitWith {
			callFuncParams(_usr,meSay,"проваливает попытку бинтования." arg "act");
		};

		callFuncParams(_usr,meSay,"рвет "+lowerize(callFunc(this,getName))+"." arg "act");
		delete(this);

	};

	func(onBandageRemove)
	{
		objParams_3(_targ,_usr,_precheck);

		private _ctz = getVar(_usr,curTargZone);
		private _isSelf = equals(_targ,_usr);
		if isNullVar(_precheck) then {_precheck = false};

		private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
		if !callFuncParams(_targ,hasPart,_bp) exitWith {
			if (_precheck) then {
				callFuncParams(_usr,localSay,"Нет такой части тела..." arg "error");
			};
			false
		};

		//проверка на одежду
		private _zoneSlot = [_ctz] call gurps_convertTargetZoneToSlot;
		if (_zoneSlot in [INV_HAND_L,INV_HAND_R,INV_BELT]) then {_zoneSlot = INV_CLOTH};
		if !callFuncParams(_targ,isEmptySlot,_zoneSlot) exitWith {
			if (_precheck) then {
				callFuncParams(_usr,localSay,"Надо сначала снять "+callFuncParams(callFuncParams(_targ,getItemInSlot,_zoneSlot),getNameFor,_usr)+"." arg "error");
			};
			false
		};

		private _part = callFuncParams(_targ,getPart,_bp);
		if !callFunc(_part,isBandaged) exitWith {
			if (_precheck) then {
				callFuncParams(_usr,localSay,"А бинта уже и нет." arg "error");
			};
			false
		};

		//бинт кладется в активную руку от BodyPart::removeBandage()
		if !callFunc(_usr,isEmptyActiveHand) exitWith {false};

		if (_precheck) exitWith {true};

		private _bonus = 5; //снять-то легче полюбому

		//если персонаж без сознания его проще зашить
		if !callFunc(_targ,isActive) then {
			modvar(_bonus) + 4;
		};
		//плохое освещение
		if (callFunc(_targ,getLighting)<LIGHT_LOW) then {
			modvar(_bonus) - 1;
		};
		if callFunc(_targ,isConnected) then {
			modvar(_bonus) + 4;
		};

		private _roll = callFuncParams(_usr,checkSkill,"healing" arg _bonus);
		private _result = getRollType(_roll);

		if (_result in [DICE_SUCCESS,DICE_CRITSUCCESS,DICE_FAIL]) then {
			callFuncParams(getSelf(loc),removeBandage,_usr);

			private _isdest = (_result == DICE_FAIL);

			private _mes = if (_isSelf) then {
				" разбинтовывает себе " +
				([_ctz arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString)
			} else {
				" разбинтовывает " +
				([_ctz arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString) +" "+
				callFuncParams(_targ,getNameEx,"кого");
			};

			if (_isdest) then {modvar(_mes) + ", разрывая "+callFunc(this,getName)};

			callFuncParams(_usr,meSay,_mes);

			if (_isdest) then {
				delete(this);
			};
		} else {
			callFuncParams(_usr,meSay,"не может снять бинт.");
		};

	};

endclass

class(Rag) extends(Bandage)
	var(name,"Тряпка");
	var(model,"relicta_models\models\cloth\littlerag.p3d");
	var(material,"MatCloth");
	var(weight,gramm(35));
endclass


class(NeedleWithThreads) extends(Item)
	var(name,"Иголка с нитками");
	var(desc,"Только не урони её...");
	var(weight,gramm(0.15));
	var(dr,1);
	var(model,"relicta_models\models\interier\props\spichka.p3d");
	var(material,"MatMetal");
	var(allowedSlots,[INV_FACE]);
	var(countUses,10);

	func(getWeight)
	{
		objParams();
		getSelf(countUses) * super();
	};

	func(sewUpArtery)
	{
		objParams_2(_targ,_usr);

		private _ctz = getVar(_usr,curTargZone);
		private _isSelf = equals(_usr,_targ);

		private _art = getVar(_targ,bodyArtery);
		private _bpIdx = [_ctz] call gurps_convertTargetZoneToBodyPart;

		private _canAct = (_bpIdx in _art && {_art get _bpIdx});

		private _bonus = 0;

		//если персонаж без сознания его проще зашить
		if !callFunc(_targ,isActive) then {
			modvar(_bonus) + 1;
		};
		//плохое освещение
		if (callFunc(_targ,getLighting)<LIGHT_MEDIUM) then {
			modvar(_bonus) - 5;
		};
		if callFunc(_targ,isConnected) then {
			modvar(_bonus) + 2;
		};

		private _roll = callFuncParams(_usr,checkSkill,"healing" arg _bonus);
		private _result = getRollType(_roll);

		private _decVal = 1;
		private _isSuccess = _result in [DICE_SUCCESS,DICE_CRITSUCCESS];
		if (_result == DICE_CRITFAIL) exitWith {
			callFuncParams(_targ,addPainLevel,_bpIdx);
			callFuncParams(_usr,meSay,"ломает иглу"+comma+" пытаясь зашить рану...");
			delete(this);
		};
		if (_result == DICE_FAIL) then {
			callFuncParams(_usr,meSay,"проводит неудачную операцию по зашиванию...");
			modvar(_decVal) + 1;

		};

		if (_isSuccess) then {
			callFuncParams(_targ,setDamageArtery,_bpIdx arg false);

			private _prefixMes = "";
			if (_result == DICE_CRITSUCCESS) then {
				_prefixMes = pick["мастерски ","очень успешно "];
				_decVal = 0;
			};

			if (_canAct) then {
				callFuncParams(_usr,meSay,_prefixMes+"сшивает артерию у " + ifcheck(_isSelf,"себя",callFuncParams(_targ,getNameEx,"кого"))+" на "+([_ctz arg TARGET_ZONE_NAME_TO] call gurps_convertTargetZoneToString)+".");
			} else {
				callFuncParams(_usr,meSay,_prefixMes+"зашивает " + ifcheck(_isSelf,"себе",callFuncParams(_targ,getNameEx,"кому"))+" "+([_ctz arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString)+".");
			};
		};


		modSelf(countUses, - _decVal);
		if (getSelf(countUses)<=0) then {
			delete(this);
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr + "Тут можно "+(pick["ещё ","аж ","целых "]) + ([getSelf(countUses),["раз","раза","раз"],true] call toNumeralString) + " использовать.";
	};

endclass
