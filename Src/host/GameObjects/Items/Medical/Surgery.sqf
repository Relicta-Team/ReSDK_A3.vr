// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(SurgicalSaw) extends(Item)
	var(name,"Хирургическая пила");
	var(desc,"Для отрезания лишних конечностей.");
	var(model,"ml_shabut\rabochiystol\pila.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(weight,gramm(480));
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	
endclass

class(SurgicalExpander) extends(Item)
	var(name,"Хирургический расширитель");
	var(model,"ml_shabut\rabochiystol\lobzik.p3d");
	var(material,"MatMetal");
	var(dr,2);
	var(weight,gramm(540));
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	
	getterconst_func(canUseInteractToMethod,true);
	func(interactTo)
	{
		objParams_2(_targ,_usr);
		private _part = callFunc(_usr,getLastinteractToBodyPart);
		if isNullReference(_part) exitWith {};
		if !isTypeOf(_part,Body) exitWith {};
		if !getVar(_part,isIncised) exitWith {
			callFuncParams(_usr,localSay,"Нужно сделать надрез" arg "error");
		};
		if callFunc(_part,isOpened) exitWith {};
		
		if callFuncParams(_part,openBodyWithExpander,this) then {
			callFuncParams(_usr,meSay,"вскрывает грудную клетку " +callFuncParams(_targ,getNameEx,"кого"));
		};
	};
	
endclass

class(Stethoscope) extends(Item)
	var(name,"Стетоскоп");
	var(desc,"Лекарская прослушка.");
	var(weight,gramm(60));
	var(dr,1);
	var(size,ITEM_SIZE_SMALL);
	var(model,"a3\props_f_orange\humanitarian\camps\stethoscope_01_f.p3d");
	var(material,"MatSynt");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
endclass

class(BoneStraightener) extends(Item)
	var(name,"Костоправ");
	var(desc,"Поправит неисправимое.");
	var(weight,gramm(170));
	var(size,ITEM_SIZE_MEDIUM);
	var(model,"ml_shabut\rabochiystol\kleshni.p3d");
	var(material,"MatMetal");
	var(dr,2);
	
	func(straightBone)
	{
		objParams_2(_targ,_usr);
		if !callFunc(_targ,isMob) exitWith {};
		private _ctz = getVar(_usr,curTargZone);
		private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
		if !callFuncParams(_targ,hasPart,_bp) exitWith {
			callFuncParams(_usr,localSay,"Нет такой части" arg "error");
		};
		private _part = callFuncParams(_targ,getPart,_bp);
		
		callFuncParams(_targ,playSound,"mob\bones" arg getRandomPitch);
		if equals(_targ,_usr) then {
			callFuncParams(_usr,meSay,"вправляет себе кость");
		} else {
			callFuncParams(_usr,meSay,"вправляет кость " + callFuncParams(_targ,getNameEx,"кому"));
		};
		
		if !callFunc(_part,isAttached) then {
			callFuncParams(_targ,setDamageArtery,getVar(_part,bodyPartIndex) arg true);
		};
		setVar(_part,isWrenched,false);
		
		callFunc(_targ,syncBodyParts);
		callFuncParams(_targ,adjustPain,getVar(_part,bodyPartIndex) arg randInt(500,1700));
	};
	
endclass

class(Forceps) extends(Item)
	var(name,"Щипцы");
	var(desc,"Лекарский инструмент для сшивания органов и конечностей.");
	var(model,"a3\structures_f\items\tools\pliers_f.p3d");
	var(material,"MatMetal");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(weight,gramm(40));
	var(size,ITEM_SIZE_SMALL);
	getterconst_func(canUseInteractToMethod,true);
	func(interactTo)
	{
		objParams_2(_targ,_usr);
		private _flagStartForecps = true;
		callSelfParams(attachPart,_targ arg _usr);
	};
	
	func(attachPart)
	{
		objParams_2(_targ,_usr);
		if !callFunc(_targ,isMob) exitWith {};
		private _ctz = getVar(_usr,curTargZone);
		private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
		if !callFuncParams(_targ,hasPart,_bp) exitWith {
			callFuncParams(_usr,localSay,"Нет такой части" arg "error");
		};
		private _part = callFuncParams(_targ,getPart,_bp);
		if getVar(_part,isAttached) exitWith {
			callFuncParams(_usr,localSay,"Там всё в порядке..." arg "error");
		};
		if !isNullVar(_flagStartForecps) exitWith {
			callFuncParams(_usr,meSay,"начинает операцию по соединению сосудов");
			callFuncParams(_usr,startProgress,_targ arg "item.attachPart" arg getVar(_usr,rta) * 5 arg INTERACT_PROGRESS_TYPE_FULL arg this);
		};
		if equals(_targ,_usr) then {
			callFuncParams(_usr,meSay,"соединяет сосуды у себя в "+callFunc(_part,getName));
		} else {
			callFuncParams(_usr,meSay,"соединяет сосуды в " +callFunc(_part,getName)+" "+ callFuncParams(_targ,getNameEx,"кого"));
		};
		setVar(_part,isAttached,true);
		callFunc(_targ,syncBodyParts);
	};
	
endclass

class(Crutch) extends(Item)
	var(name,"Костыль");
	var(desc,"Безногим?!");
	var(model,"relicta_models2\medicine\s_crutch\s_crutch.p3d");
	var(material,"MatWood");
	var(dr,2);
	var(weight,gramm(800));
	var(size,ITEM_SIZE_LARGE);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	
	getter_func(getHandAnim,ITEM_HANDANIM_LOWERONLYHAND); //анимация в состоянии покоя
	getter_func(getCombAnim,ITEM_COMBATANIM_SHORT); //анимация в состоянии комбата
	getter_func(getTwoHandAnim,ITEM_2HANIM_LOWER); //Анимация двуручного хвата
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_LOWER); //анимация двуручного хвата в боевом режиме
	
	
	func(onPickup)
	{
		objParams_1(_usr);
		super();
		callFunc(_usr,syncBodyParts);
	};
	func(onPutdown)
	{
		objParams_1(_usr);
		super();
		callFunc(_usr,syncBodyParts);
	};
	func(onDrop)
	{
		objParams_1(_usr);
		super();
		callFunc(_usr,syncBodyParts);
	};
	func(onEquip) {
		objParams_1(_usr);
		super();
		callFunc(_usr,syncBodyParts);
	};
	func(onUnequip) {
		objParams_1(_usr);
		super();
		callFunc(_usr,syncBodyParts);
	};
	
endclass