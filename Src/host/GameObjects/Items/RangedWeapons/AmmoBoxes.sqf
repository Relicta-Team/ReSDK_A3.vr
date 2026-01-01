// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
//for big boxes "a3\structures_f_epb\items\military\ammobox_rounds_f.p3d"
//small opened box "ml\ml_object_new\model_24\patroni.p3d"
class(AmmoBoxBase) extends(Item)
	var(name,"Коробка");
	getter_func(specialAmmoName,"");
	getter_func(getCaliberName,getFieldBaseValueWithMethod(callSelf(createdType),"", "getCaliber"));
	var(model,"ml\ml_object_new\model_24\patroni.p3d");
	var(material,"MatPaper");
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(dr,1);
	func(getName)
	{
		objParams();
		private _sn = callSelf(specialAmmoName);
		if (_sn == "") then {
			getSelf(name) + " (" + callSelf(getCaliberName)+")";
		} else {
			_sn
		};
	};
	var(weight,gramm(130));

	var(content,[]); //bullets storage

	func(constructor)
	{
		objParams();
		private _content = getSelf(content);
		private _item = nullPtr;
		private _type = callSelf(createdType);
		for "_i" from 1 to callSelf(initialCount) do {
			_item = instantiate(_type);
			//faster without call each iteration
			setVar(_item,loc,this);
			_content pushBack _item;
		};
	};

	//Расчёт веса с использованием рефлексии
	func(getWeight)
	{
		objParams();
		private _wBullets = 0;
		{
			modvar(_wBullets) + callFunc(_x,getWeight)
		} count getSelf(content);
		super() + _wBullets;
	};

	getter_func(createdType,"IAmmoBase");
	getter_func(initialCount,16); //реальное количество
	getter_func(getAmmoCount,count getSelf(content));

	getter_func(canUseMainAction,callSelf(getAmmoCount) > 0 && super());
	var(isReadyToGive,false);
	getter_func(getMainActionName,ifcheck(getSelf(isReadyToGive),"Закрыть","Открыть"));
	func(onMainAction)
	{
		objParams_1(_usr);
		setSelf(isReadyToGive,!getSelf(isReadyToGive));
		private _newmes = ifcheck(getSelf(isReadyToGive),"открывает","закрывает");
		callFuncParams(_usr,meSay,_newmes + " " + lowerize(callSelfParams(getNameFor,_usr)) + ".");
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _post = "Под калибр " + callSelf(getCaliberName)+".";
		if getSelf(isReadyToGive) then {
			_post = _post + sbr + "Коробка открыта" + ifcheck(callSelf(getAmmoCount)>0,
			" и внутри "+(pick["видно" arg "есть" arg "ещё" arg "лежит"])+" " + (vec3(callSelf(getAmmoCount),vec3("патрон","патрона","патронов"),true) call toNumeralString),
			" и внутри "+(pick["ничего нет" arg "пусто" arg "не осталось патронов"])+"."
			)
		};
		super() + sbr + _post;
	};

	getter_func(canPickup,super() && !getSelf(isReadyToGive));

	//Вызывается при невозможности поднять предмет
	func(onCantPickup)
	{
		objParams_1(_usr);
		if getSelf(isReadyToGive) then {
			private _m = pick["Рассыпется же!","Надо сначала закрыть коробочку.","Коробку нужно закрыть! Всё рассыпется!","Это небезопасно. Надо закрыть коробку."];
			callFuncParams(_usr,localSay,_m arg "error");
		} else {
			callFuncParams(_usr,localSay,"Просто не вышло..." arg "error");
		};
	};

	func(onClick)
	{
		objParams_1(_usr);
		if getSelf(isReadyToGive) then {
			callSelfParams(giveAmmo,_usr);
		} else {
			super();
		};
	};
	func(onItemClick)
	{
		objParams_1(_usr);
		if getSelf(isReadyToGive) then {
			callSelfParams(giveAmmo,_usr);
		} else {
			callSelfParams(onMainAction,_usr); //логика авто-открытия
		};
	};

	func(onMoveOutItem)
	{
		objParams_1(_item);
		private _list = getSelf(content);
		_list deleteAt (_list find _item);
	};
	func(canMoveOutItem)
	{
		objParams_1(_item);
		array_exists(getSelf(content),_item)
	};
	func(onMoveInItem)
	{
		objParams_1(_item);
		setVar(_item,loc,this);
		getSelf(content) pushBackUnique _item;
	};
	func(canMoveInItem)
	{
		objParams_1(_item);
		!array_exists(getSelf(content),_item) && callSelf(getAmmoCount) < callSelf(initialCount)
	};

	func(giveAmmo)
	{
		objParams_1(_usr);

		if !callFunc(_usr,isEmptyActiveHand) exitWith {
			callFuncParams(_usr,localSay,"Рука не пустая." arg "error");
		};
		private _delegate_onEndAmmo = {
			//setSelf(isReadyToGive,false);
			private _m = pick["Вот и всё.","Больше нету.","Закончилось всё.","Там пусто.","Ничего не осталось."];
			callFuncParams(_usr,localSay,_m arg "error");
		};
		if (callSelf(getAmmoCount)<=0) exitWith {
			call _delegate_onEndAmmo;
		};

		private _item = getSelf(content) select ((count getSelf(content)) - 1);
		if callFuncParams(_item,moveItem,_usr) then {
			if (callSelf(getAmmoCount)<=0) then {
				call _delegate_onEndAmmo;
			};
		} else {
			//не должно происходить
			errorformat("%1::giveAmmo() - undefined behaviour catched",callSelf(getClassName));
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if !isTypeOf(_ammo,IAmmoBase) exitWith {};
		callSelfParams(insertAmmo,_with arg _usr);
	};

	func(insertAmmo)
	{
		objParams_2(_ammo,_usr);
		if (callSelf(getAmmoCount)>=callSelf(initialCount)) exitWith {
			callFuncParams(_usr,localSay,"Нет места." arg "error");
		};
		if !isTypeStringOf(_ammo,callSelf(createdType)) exitWith {
			callFuncParams(_usr,localSay,"Это другие патроны." arg "error");	
		};
		if !getSelf(isReadyToGive) exitWith {
			callFuncParams(_usr,localSay,"Надо сначала открыть коробку." arg "error");	
		};
		if callFunc(_ammo,canDestack) then {
			callFuncParams(_ammo,destackItemToLoc,1 arg this arg _usr);
		} else {
			callFuncParams(_ammo,moveItem,this);
		};
	};

endclass


class(AmmoBoxPBM) extends(AmmoBoxBase)
	getter_func(createdType,"AmmoPBM");
	getter_func(initialCount,16);
	var(model,"relicta_models2\ammo_box\s_ammo_box_pistol\s_ammo_box_pistol.p3d");
endclass

	class(AmmoBoxPBM_BB) extends(AmmoBoxPBM)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" бронебойные)");
		getter_func(createdType,"AmmoPBM_BB");
	endclass

	class(AmmoBoxPBMNonLethal) extends(AmmoBoxPBM)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" защитные)");
		getter_func(createdType,"AmmoPBMNonLethal");
	endclass

	class(AmmoBoxPBMBlank) extends(AmmoBoxPBM)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" холостые)");
		getter_func(createdType,"AmmoPBMBlank");
	endclass

class(AmmoBoxRevolver) extends(AmmoBoxBase)
	getter_func(createdType,"AmmoRevolver");
	getter_func(initialCount,16);
	var(model,"relicta_models2\ammo_box\s_ammo_box_revolver\s_ammo_box_revolver.p3d");
endclass

	class(AmmoBoxRevolverBlank) extends(AmmoBoxRevolver)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" холостые)");
		getter_func(createdType,"AmmoRevolverBlank");
	endclass

class(AmmoBoxShotgun) extends(AmmoBoxBase)
	getter_func(createdType,"AmmoShotgun");
	getter_func(initialCount,25);
	var(model,"relicta_models2\ammo_box\s_ammo_box_shotgun\s_ammo_box_shotgun.p3d");
endclass

	class(AmmoBoxShotgunNonLethal) extends(AmmoBoxShotgun)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" защитные)");
		getter_func(createdType,"AmmoShotgunNonLethal");
		getter_func(initialCount,25);
	endclass

	class(AmmoBoxShotgunBlank) extends(AmmoBoxShotgun)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" холостые)");
		getter_func(createdType,"AmmoShotgunBlank");
	endclass

class(AmmoBoxShotgunMini) extends(AmmoBoxShotgun)
	getter_func(createdType,"AmmoShotgunMini");
	getter_func(initialCount,25);
	var(model,"relicta_models2\ammo_box\s_ammo_box_shotgun\s_ammo_box_shotgun.p3d");
endclass

	class(AmmoBoxShotgunMiniBlank) extends(AmmoBoxShotgunMini)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" холостые)");
		getter_func(createdType,"AmmoShotgunMiniBlank");
	endclass

class(AmmoBoxPistolHandmade) extends(AmmoBoxBase)
	getter_func(createdType,"AmmoPistolHandmade");
	getter_func(initialCount,16);
	var(model,"relicta_models2\ammo_box\s_ammo_box_pistol\s_ammo_box_pistol.p3d");
endclass

	class(AmmoBoxPistolHandmadeBlank) extends(AmmoBoxPistolHandmade)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" холостые)");
		getter_func(createdType,"AmmoPistolHandmadeBlank");
	endclass

class(AmmoBoxRifle) extends(AmmoBoxBase)
	getter_func(createdType,"AmmoRifle");
	getter_func(initialCount,20);
	var(model,"relicta_models2\ammo_box\s_ammo_box_rifle\s_ammo_box_rifle.p3d");
endclass

	class(AmmoBoxRifleBlank) extends(AmmoBoxRifle)
		getter_func(specialAmmoName,"Коробка ("+callSelf(getCaliberName)+" холостые)");
		getter_func(createdType,"AmmoRifleBlank");
	endclass
