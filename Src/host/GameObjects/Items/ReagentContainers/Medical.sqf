// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

// medical

class(IReagentItemBag) extends(IReagentNDItem)
	var(reagents,vec2(this,120) call ms_create);
	getterconst_func(transferAmount,[0.2 arg 1 arg 2]);
	var(model,"a3\structures_f_epa\items\medical\bloodbag_f.p3d");
endclass

class(BloodPack) extends(IReagentItemBag)
	var(name,"Пакет крови");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(340));
endclass

class(IVBag) extends(IReagentItemBag)
	//for empty: "a3\props_f_orange\humanitarian\camps\intravenbag_01_empty_f.p3d"
	var(model,"a3\props_f_orange\humanitarian\camps\intravenbag_01_full_f.p3d");
	var(name,"Пакет для внутреннего переливания");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(160));
endclass

class(Syringe) extends(IReagentNDItem)
	var(name,"Шприц");
	var(model,"relicta_models\models\medical\syringe.p3d");
	var(material,"MatSynt");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(7));

	var(reagents,vec2(this,15) call ms_create);
	getterconst_func(transferAmount,[1 arg 2 arg 3 arg 5 arg 10 arg 15]);

	getter_func(canTransferTo,!isNullVar(__FLAG_SYRINGE_TRANSFER__));
	getter_func(canTransferFrom,!isNullVar(__FLAG_SYRINGE_TRANSFER__));

	var(isInject,true);//это впрыскивание. false является забором в шприц

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr + ifcheck(getSelf(isInject),"Им можно вколоть.","Им можно набирать.");
	};

	func(Prick)
	{
		objParams_3(_targ,_usr,_ctz);

		private _isSelf = equals(_targ,_usr);
		private _isInject = getSelf(isInject);
		private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
		if !callFuncParams(_targ,hasPart,_bp) exitWith {
			callFuncParams(_usr,localSay,ifcheck(_isSelf,"Я не имею","Цель не имеет") + " такой части тела." arg "error");
		};
		private __FLAG_SYRINGE_TRANSFER__ = true;
		if (_isInject) then {
			if (callSelf(getFilledSpace) == 0) exitWith {
				callFuncParams(_usr,localSay,callSelfParams(getNameFor,_usr) + " пуст." arg "error");
			};

			private _mod = 0;
			if (_isSelf) then {modvar(_mod) + 2};
			private _roll = callFuncParams(_usr,checkSkill,"healing" arg _mod);
			private _dice = getRollType(_roll);

			if (_dice in [DICE_FAIL,DICE_CRITFAIL]) exitWith {
				if (getRollAmount(_roll) <= -3) then { //провал больше чем на 2 дает боли
					callFuncParams(_targ,addPainLevel,_bp arg 1 arg true);
				};
				callFuncParams(_usr,meSay,"промахивается"+comma+" пытаясь уколоть "+ifcheck(_isSelf,"себя",callFuncParams(_targ,getNameEx,"кого")))
			};

			private _curBlood = callFuncParams(this,getReagentVolume,"Blood");
			if callSelfParams(transferReagents,getVar(_targ,reagents) arg getSelf(curTransferSize)) then {
				callFuncParams(_usr,meSay,"вкалывает " + ifcheck(_isSelf,"себе",callFuncParams(_targ,getNameEx,"кому")) + " в " + ([_ctz arg TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString) + " что-то.");
				if (_curBlood > 0) then {
					callFuncParams(getVar(_targ,reagents),removeReagent,"Blood" arg _curBlood);
				};
			};
		} else {
			if (callSelf(getFreeSpace) == 0) exitWith {
				callFuncParams(_usr,localSay,callSelfParams(getNameFor,_usr) + " полон." arg "error");
			};
			if callFuncParams(getVar(_targ,reagents),transferReagent,this arg "Blood" arg getSelf(curTransferSize)) then {
				callFuncParams(_usr,meSay,"берет кровь у " + ifcheck(_isSelf,"себя",callFuncParams(_targ,getNameEx,"кого")) + " из " + ([_ctz arg TARGET_ZONE_NAME_TO] call gurps_convertTargetZoneToString));
				private _curBlood = callFuncParams(this,getReagentVolume,"Blood");
				//возвращаем кровь
				callFuncParams(getVar(_targ,reagents),addReagent,"Blood" arg _curBlood);
			};
		};

	};

	func(onItemSelfClick)
	{
		objParams_1(_usr);
		setSelf(isInject,!getSelf(isInject));
		callFuncParams(_usr,localSay,"Теперь этим будем " + ifcheck(getSelf(isInject),"вкалывать","забирать") + "." arg "info");
	};

	func(transferProcess)
	{
		objParams_2(_src,_usr);
		private __FLAG_SYRINGE_TRANSFER__ = true;
		if getSelf(isInject) then {
			if callFuncParams(this,transferReagents,_src arg getSelf(curTransferSize)) then {
				callFuncParams(_usr,meSay,"впрыскивает содержимое шприца.");
			};
		} else {
			if callFuncParams(_src,transferReagents,this arg getSelf(curTransferSize)) then {
				callFuncParams(_usr,meSay,"набирает шприц.");
			};
		};
	};

endclass

class(GlassVial) extends(IGlassReagentCont)
	var(name,"Флакон");
	var(desc,"Маленький стеклянный флакон");
	var(model,"relicta_models\models\interier\props\kitchen\buhlo1.p3d");
	var(reagents,vec2(this,30) call ms_create);
	getterconst_func(transferAmount,[5 arg 10 arg 15 arg 30]);

	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(230));
endclass

class(spric_test) extends(Syringe)
	var(reagents,[vec2("Tovimin",15)]newReagentsFood);
endclass

//medical liquid containers
class(LiqPainkiller) extends(GlassVial)
	var(name,"Обезболивающее");
	var(desc,"Сильное обезболивающее для приёма внутривенно.");
	var(reagents,[vec2("Tamidin",30)]newReagentsFood);
endclass

class(LiqDemitolin) extends(GlassVial)
	var(name,"Демитолин");
	var(desc,"Используется для лечения внутренних органов. Вводится внутривенно.");
	var(reagents,[vec2("Demitolin",30)]newReagentsFood);
endclass

class(LiqTovimin) extends(GlassVial)
	var(name,"Товимин");
	var(desc,"Для лечения физических повреждений");
	var(reagents,[vec2("Tovimin",30)]newReagentsFood);
endclass
