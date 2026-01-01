// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(PistolPBM) extends(IRangedWeapon)
	#include "IPistol.Interface"
	var(name,"Пистолет ""ПБМ 70""");
	var(model,"relicta_models\models\weapons\fireweapon\pistols\type94\type94.p3d");
	getter_func(getTwoHandAnim,ITEM_2HANIM_PISTOL);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_PISTOL);
	getter_func(getAttackVisualData,"BFX_BULLET_PISTOL");
	getter_func(getUsingSkill,"pistol");

	var(basicDistance,700);
	var(halfDistance,50);
	var(shootSpeed,200);
	var(basicDamage,vec2(2,2));
	getter_func(getReqMagazineType,"MagazinePBM");
	getter_func(getAmmoCaliber,"9мм");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BELT]);
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(730));
	var(dr,4);
	getter_func(getReqST,8);

endclass

class(Revolver) extends(IRangedWeapon)
	#include "IPistol.Interface"
	var(name,"Револьвер ""Малыш""");
	var(basicDistance,600);
	var(halfDistance,70);
	var(shootSpeed,250);
	var(model,"relicta_models\models\weapons\fireweapon\pistols\nagan\nagan.p3d");
	getter_func(getTwoHandAnim,ITEM_2HANIM_PISTOL);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_PISTOL);
	getter_func(getAttackVisualData,"BFX_BULLET_PISTOL");
	getter_func(getUsingSkill,"pistol");
	var(basicDamage,vec2(2,-1));
	getter_func(getAmmoCaliber,".38");
	getter_func(getReqMagazineType,"MagazineRevolver");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BELT]);
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(750));
	getter_func(getReqST,8);
	//sounds
	getter_func(getLoadMagazineSound,"guns\rev_magin");
	getter_func(getUnloadMagazineSound,"guns\rev_magout");
	getter_func(getBoltSound,"guns\rev_bolt");
	getter_func(getShootSound,soundData("guns\revolver_fire",0.85,1.15));

	verbList("wpnopnmode spinrev dropammorev",IRangedWeapon);

	var(isOpened,false);

	func(getWeaponOpenModeChangeText)
	{
		objParams();
		ifcheck(getSelf(isOpened),"Закрыть","Открыть")
	};

	func(onWeaponOpenModeChange)
	{
		objParams_1(_usr);
		setSelf(isOpened,!getSelf(isOpened));
		private _sound = ifcheck(getSelf(isOpened),"guns\rev_open","guns\rev_close");
		callSelfParams(playSound,_sound arg rand(0.8,1.2) arg 10);
	};

	func(spinDrum)
	{
		objParams_1(_usr);
		if callSelf(hasMagazine) then {
			callFuncParams(getSelf(magazine),spinDrum,randInt(1,6) arg true);
			callFuncParams(_usr,meSay,"крутит барабан револьвера.");
		};
	};

	func(freeDrum)
	{
		objParams_1(_usr);
		if (!callSelf(hasMagazine) || !getSelf(isOpened)) exitWith {};

		{
			if !isNullReference(_x) then {
				callFuncParams(getSelf(magazine),onMoveOutItem,_x);
				setVar(_x,loc,objnull);
				callFuncAfterParams(_x,dropItemToWorld,rand(0.3,0.55),getPosATL getVar(_usr,owner) arg null arg null arg _usr arg true);
			};
		} foreach getVar(getSelf(magazine),content);

	};

	func(constructor)
	{
		objParams();

		//Создаём магазин внутри
		private _itm = new(MagazineRevolver);
		setVar(_itm,loc,this);
		setSelf(magazine,_itm);
		callSelf(onWeightChanged);
	};

	func(onBulletCaseInteract)
	{
		objParams_2(_ammo,_usr);
		callSelfParams(onAmmoInteract,_ammo arg _usr);
	};

	func(onAmmoInteract)
	{
		objParams_2(_ammo,_usr);
		if !getSelf(isOpened) exitWith {
			callFuncParams(_usr,localSay,"Нужно сначала открыть барабан." arg "error");
		};
		if !callSelf(hasMagazine) exitWith {
			callFuncParams(_usr,localSay,"Нет барабана." arg "error");
		};
		callFuncParams(getSelf(magazine),loadAmmoToMagazine,_ammo arg _usr);
	};

	func(onItemClick)
	{
		objParams_1(_usr);

		if callSelf(hasMagazine) exitWith {
			if !getSelf(isOpened) exitWith {
				callFuncParams(_usr,localSay,"Нужно сначала открыть барабан." arg "error");
			};
			callFuncParams(getSelf(magazine),unloadAmmoFromMagazine,_usr);
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = super();
		if getSelf(isOpened) then {
			modvar(_txt) + sbr + "Он открыт.";
		};
		if equals(getSelf(loc),_usr) then {
			if callSelf(hasMagazine) then {
				private _ammoCount = callFunc(getSelf(magazine),getAmmoCount);
				if (_ammoCount > 0) then {
					modvar(_txt) + sbr + "Заряжено патронов: " + str _ammoCount;
				};
			};
		};
		_txt
	};

	func(isCocked)
	{
		objParams();
		if !callSelf(hasMagazine) exitWith {false};
		private _mag = getSelf(magazine);
		private _curItm = getVar(_mag,content) select getVar(_mag,currentIndex);
		!isNullReference(_curItm) && !getSelf(isOpened)
	};

	func(prepareBullet)
	{
		objParams();
		if !getSelf(isOpened) then {
			private _mag = getSelf(magazine);
			private _newValue = (getVar(_mag,currentIndex) + 1) % getVar(_mag,maxCount);
			setVar(_mag,currentIndex,_newValue);
		};
	};

	func(handlePreCockProcess)
	{
		objParams_1(_usr);
	};

	func(onCasingProcess)
	{
		objParams_2(_bulletcase,_usr);
		//создать гильзу в барабане
		callFuncParams(getSelf(magazine),loadAmmoToMagazine,_bulletcase arg _usr);
	};

	//Возвращает активную пулю. если гильза то nullPtr
	func(getBullet)
	{
		objParams();
		private _mag = getSelf(magazine);
		private _curItm = getVar(_mag,content) select getVar(_mag,currentIndex);
		if isTypeOf(_curItm,BulletCase) exitWith {nullPtr};
		_curItm
	};

	func(removeLoadedBullet)
	{
		objParams();
		private _mag = getSelf(magazine);
		getVar(_mag,content) set [getVar(_mag,currentIndex),nullPtr];
	};

	func(canShoot)
	{
		objParams();
		super() && !isNullReference(callSelf(getBullet))
	};

	func(onCantShoot)
	{
		objParams_1(_usr);
		super();
		callSelf(prepareBullet);
	};

	/*
		Изменённые моменты в револьвере:
			(БЕСПОЛЕЗНО.) - барабан можно как вытащить так и заряжать патроны в револьвер
			+ в барабан револьвера можно грузить гильзы
			- выстреленные пули превращаются в гильзы внутри магазина.
			+ для доступа к магазину револьвер должен быть раскрыт
			+ барабан работает по принципу рулетки а не стека. его можно спинить (крутить)
			-
	*/


endclass


class(PistolHandmade) extends(IRangedWeapon)
	#include "IPistol.Interface"
	var(name,"Пистолет ""Дудатрёп""");
	var(model,"relicta_models\models\weapons\fireweapon\handmade\newarmypistol\newarmypistol.p3d");

	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(820));
	getter_func(getReqST,8);
	var(basicDistance,150);
	var(halfDistance,70);
	var(shootSpeed,300);

	getter_func(getTwoHandAnim,ITEM_2HANIM_PISTOL);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_PISTOL);
	getter_func(getAttackVisualData,"BFX_BULLET_PISTOL");
	getter_func(getUsingSkill,"pistol");
	var(basicDamage,vec2(2,5));

	getter_func(getReqMagazineType,"MagazinePistolHandmade");
	getter_func(getAmmoCaliber,".340");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK arg INV_BELT]);

	getter_func(getLoadMagazineSound,"guns\hpistol_magin");
	getter_func(getUnloadMagazineSound,"guns\hpistol_magout");
	getter_func(getBoltSound,"guns\hpistol_cock");
	getter_func(getShootSound,soundData("guns\hpistol_fire",0.85,1.15));
endclass

class(PistolOneShoot) extends(DBShotgun)
	#include "IPistol.Interface"
	var(name,"Самопал");
	var(model,"relicta_models\models\weapons\fireweapon\handmade\pistolsmall\pistolsmall.p3d");

	getter_func(getWeapName,"Самопал");

	getterconst_func(getVirtualInternalMagazine,"VirtualMagazinePistolOneShoot");

	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(510));
	getter_func(getReqST,8);
	var(basicDistance,90);
	var(halfDistance,20);
	var(shootSpeed,170);

	getter_func(getTwoHandAnim,ITEM_2HANIM_PISTOL);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_PISTOL);
	getter_func(getAttackVisualData,"BFX_BULLET_PISTOL");
	getter_func(getUsingSkill,"pistol");
	var(basicDamage,vec2(2,-1));

	getter_func(getReqMagazineType,"VirtualMagazinePistolOneShoot");
	getter_func(getAmmoCaliber,".38");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_LA);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK arg INV_BELT]);

	getter_func(getShootSound,soundData("guns\pistoln"+str randInt(1,2),0.85,1.15));
	getter_func(getBoltSound,"guns\pistolhm_cock");

endclass
