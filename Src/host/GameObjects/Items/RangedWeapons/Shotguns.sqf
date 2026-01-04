// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

/*
	двухстволки:
		- нет фактического магазина
		- гильзы не вылетают (надо вытаскивать)
		- в магазин можно зарядить как гильзы так и патроны
*/
class(SawedOff) extends(DBShotgun)
	var(attachedWeap,weaponModule(WeapLongRangeHandle));
	var(name,"Обрез");
	var(weight,3.1);
	getter_func(getReqST,9);
	var(size,ITEM_SIZE_SMALL);
	var(model,"relicta_models\models\weapons\fireweapon\shotguns\izh43\izh43_sawedoff.p3d");
	var(basicDistance,135);

	var(allowedSlots,[INV_BACK arg INV_BELT arg INV_BACKPACK]);
endclass

//DB - double-barrel shotgun
class(DBShotgun) extends(IRangedWeapon)
	#include "ILongWeapon.Interface"
	var(attachedWeap,weaponModule(WeapLongRangeHandle));
	var(name,"Двустволка");
	var(weight,3.4);
	getter_func(getReqST,10);
	var(size,ITEM_SIZE_LARGE);
	var(basicDistance,125);
	var(halfDistance,50);
	var(shootSpeed,230);
	var(model,"relicta_models\models\weapons\fireweapon\shotguns\izh43\izh43.p3d");
	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTGUN");
	getter_func(getUsingSkill,"shotgun");
	var(basicDamage,vec2(1,2));

	getter_func(getReqMagazineType,"VirtualMagazineDBShotgun");
	getter_func(getAmmoCaliber,".12");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	//sounds
	getter_func(getLoadMagazineSound,"guns\rev_magin");
	getter_func(getUnloadMagazineSound,"guns\rev_magout");
	getter_func(getBoltSound,"guns\shotgun_reload");
	getter_func(getShootSound,soundData("guns\shotgun_fire",0.85,1.15));

	verbList("wpnopnmode dropammorev",IRangedWeapon);

	var(isOpened,false);

	getter_func(getWeapName,"Ружьё");

	//verb rename
	func(dropammorev_name)
	{
		objParams();
		"Опустошить"
	};

	func(getWeaponOpenModeChangeText)
	{
		objParams();
		ifcheck(getSelf(isOpened),"Закрыть","Открыть")
	};

	func(onWeaponOpenModeChange)
	{
		objParams_1(_usr);
		setSelf(isOpened,!getSelf(isOpened));
		private _sound = ifcheck(getSelf(isOpened),"guns\dbshotgun_open","guns\dbshotgun_close");
		callSelfParams(playSound,_sound arg rand(0.8,1.2) arg 10);
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

	getterconst_func(getVirtualInternalMagazine,"VirtualMagazineDBShotgun");

	func(constructor)
	{
		objParams();

		//Создаём магазин внутри
		private _itm = instantiate(callSelf(getVirtualInternalMagazine));
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
			callFuncParams(_usr,localSay,"Нужно сначала открыть " + lowerize(callSelf(getWeapName)) + "." arg "error");
		};
		callFuncParams(getSelf(magazine),loadAmmoToMagazine,_ammo arg _usr);
	};

	func(onItemClick)
	{
		objParams_1(_usr);

		if !getSelf(isOpened) exitWith {
			callFuncParams(_usr,localSay,"Нужно сначала открыть " + lowerize(callSelf(getWeapName)) + "." arg "error");
		};
		callFuncParams(getSelf(magazine),unloadAmmoFromMagazine,_usr);
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = super();
		if getSelf(isOpened) then {
			modvar(_txt) + sbr + "Оно открыто.";
			//только в открытом ружье можно видеть патроны
			if equals(getSelf(loc),_usr) then {
				private _ammoCount = callFunc(getSelf(magazine),getAmmoCount);
				if (_ammoCount > 0) then {
					modvar(_txt) + " Внутри видно " + str _ammoCount + " патрона.";
				};
			};
		};
		_txt
	};

	func(isCocked)
	{
		objParams();
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
		//создать гильзу в дробовике
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

endclass


class(Shotgun) extends(IRangedWeapon)
	#include "ILongWeapon.Interface"
	var(attachedWeap,weaponModule(WeapLongRangeButt));
	var(name,"Дробовик");
	var(weight,3.540);
	getter_func(getReqST,10);
	var(size,ITEM_SIZE_LARGE);
	var(basicDistance,130);
	var(halfDistance,40);
	var(shootSpeed,230);
	var(model,"relicta_models\models\weapons\fireweapon\shotguns\mp133\mp133.p3d");
	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTGUN");
	getter_func(getUsingSkill,"shotgun");
	var(basicDamage,vec2(1,1));

	getter_func(getReqMagazineType,"VirtualMagazineShotgun");
	getter_func(getAmmoCaliber,".12");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);

	func(constructor)
	{
		objParams();

		//Создаём магазин внутри
		private _itm = new(VirtualMagazineShotgun);
		setVar(_itm,loc,this);
		setSelf(magazine,_itm);
		callSelf(onWeightChanged);
	};

	getter_func(getBoltSound,"guns\shotgun_pump");
	getter_func(getShootSound,soundData("guns\shotgunp_fire",0.85,1.15));

	func(onBulletCaseInteract)
	{
		objParams_2(_ammo,_usr);
		callSelfParams(onAmmoInteract,_ammo arg _usr);
	};

	func(onAmmoInteract)
	{
		objParams_2(_ammo,_usr);
		callFuncParams(getSelf(magazine),loadAmmoToMagazine,_ammo arg _usr);
	};

	func(onItemClick)
	{
		objParams_1(_usr);

		callFuncParams(getSelf(magazine),unloadAmmoFromMagazine,_usr);
	};

	func(onCasingProcess)
	{
		objParams_2(_bulletcase,_usr);
		callFuncParams(_bulletcase,moveItem,this);
	};

	func(postShoot)
	{
		objParams_1(_usr);
		if (
			!callFuncParams(_usr,isHoldedTwoHands,this) ||
			not_equals(getSelf(loc),_usr)
			) exitWith {};
		if (callSelf(isCocked) && isTypeOf(getSelf(bullet),BulletCase)) exitWith {
			callSelfParams(cockProcess,_usr);
		};
	};

	func(prepareProjectile)
	{
		objParams_1(_usr);
		private _proj = super();
		if (callFuncParams(_usr,isHoldedTwoHands,this) || !isNullReference(_proj)) then {
			callSelfAfterParams(postShoot,rand(0.5,0.8),_usr);
		};
		_proj
	};

	func(getBullet)
	{
		objParams();
		private _bul = super();
		if isTypeOf(_bul,BulletCase) exitWith {nullPtr};
		_bul
	};

	func(canShoot)
	{
		objParams();
		super() && !isNullReference(callSelf(getBullet))
	};

	getter_func(canPrepareBulletAfterProj,false);


endclass


class(ShotgunMini) extends(DBShotgun)
	#include "IPistol.Interface"
	getter_func(getWeapName,"Кроха");
	var(name,"Кроха");
	var(model,"relicta_models\models\weapons\fireweapon\shotguns\sawedoffsmall\sawedoffsmall.p3d");
	getter_func(getTwoHandAnim,ITEM_2HANIM_PISTOL);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_PISTOL);

	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(450));
	getter_func(getReqST,9);
	var(basicDistance,60);
	var(halfDistance,20);
	var(shootSpeed,170);

	var(basicDamage,vec2(1,1));
	getterconst_func(getVirtualInternalMagazine,"VirtualMagazineShotgunMini");
	getter_func(getReqMagazineType,"VirtualMagazineShotgunMini");
	getter_func(getAmmoCaliber,".11");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK arg INV_BELT]);
	//sounds
	getter_func(getLoadMagazineSound,"guns\rev_magin");
	getter_func(getUnloadMagazineSound,"guns\rev_magout");
	getter_func(getBoltSound,"guns\shotgun_reload");
	getter_func(getShootSound,soundData("guns\revolver",0.85,1.15));

endclass
