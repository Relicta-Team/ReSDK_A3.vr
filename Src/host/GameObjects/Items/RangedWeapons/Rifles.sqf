// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>


class(RifleFinisher) extends(IRangedWeapon)
	/*
		Моменты:
			- функционал как у дробовика но гильзы вылетают
			- нужно вручную дозарядить патрон в патронник
	*/
	#include "ILongWeapon.Interface"
	var(attachedWeap,weaponModule(WeapLongRangeButt));
	var(name,"Винтовка ""Навертыш""");
	var(model,"relicta_models\models\weapons\fireweapon\handmade\premosin\premosin.p3d");
	var(weight,4.6);
	getter_func(getReqST,10);
	var(size,ITEM_SIZE_LARGE);
	var(basicDistance,1500);
	var(halfDistance,750);
	var(shootSpeed,860);
	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTRIFLE");
	getter_func(getUsingSkill,"rifle");
	var(basicDamage,vec2(7,0));

	getter_func(getReqMagazineType,"MagazineFinisher");
	getter_func(getAmmoCaliber,"7.62мм");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	//sounds
	getter_func(getLoadMagazineSound,"guns\ltrifle_magin");
	getter_func(getUnloadMagazineSound,"guns\ltrifle_magout");
	getter_func(getBoltSound,"guns\la_cock");
	getter_func(getShootSound,soundData("guns\la_fire"+str randInt(1,4),0.85,1.15));

	/*func(getBullet)
	{
		objParams();
		private _bul = super();
		if isTypeOf(_bul,BulletCase) exitWith {nullPtr};
		_bul
	};*/
	//fix unload
	func(canShoot)
	{
		objParams();
		private _weap = callSelf(getBullet);
		super() && !isNullReference(_weap) && {!isTypeOf(_weap,BulletCase)}
	};


	getter_func(canPrepareBulletAfterProj,false);

	func(onCasingProcess)
	{
		objParams_2(_bulletcase,_usr);
		callFuncParams(_bulletcase,moveItem,this);
	};

	func(onBulletCaseInteract)
	{
		objParams_2(_ammo,_usr);
		if isTypeOf(_ammo,BulletCaseRifle) exitWith {
			callFuncParams(_ammo,moveItem,this);
		};
	};

	//auto reload
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

endclass

class(RifleFinisherSmall) extends(RifleFinisher)
	var(model,"relicta_models\models\weapons\fireweapon\handmade\premosin\premosin_sawn.p3d");
	var(name,"Укороченная винтовка ""Навертыш""");
	var(weight,4.1);
	getter_func(getReqST,9);
	var(size,ITEM_SIZE_LARGE);
	var(basicDistance,1000);
	var(halfDistance,550);
	var(shootSpeed,860);
	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTRIFLE");
	getter_func(getUsingSkill,"rifle");
	var(basicDamage,vec2(6,2));
	getter_func(getAmmoCaliber,"7.62мм");
endclass

class(RifleSVT) extends(IRangedWeapon)
	#include "ILongWeapon.Interface"
	var(attachedWeap,weaponModule(WeapLongRangeButt));
	var(name,"Винтовка ""СВТ""");
	//var(desc,"Самозарядная Винтовка Титькина.");
	var(model,"relicta_models\models\weapons\fireweapon\marksman\sks\sks.p3d");
	var(weight,3.75);
	getter_func(getReqST,11);
	var(size,ITEM_SIZE_LARGE);
	var(basicDistance,900);
	var(halfDistance,400);
	//var(shootSpeed,735);
	var(shootSpeed,367);
	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTRIFLE");
	getter_func(getUsingSkill,"rifle");
	var(basicDamage,vec2(5,0));

	getter_func(getReqMagazineType,"MagazineSVT");
	getter_func(getAmmoCaliber,"7.62мм");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	//sounds
	getter_func(getLoadMagazineSound,"guns\ltrifle_magin");
	getter_func(getUnloadMagazineSound,"guns\ltrifle_magout");
	getter_func(getBoltSound,"guns\batrifle_cock");
	getter_func(getShootSound,soundData("guns\ltrifle_fire",0.85,1.15));
endclass

class(RifleAuto) extends(IRangedWeapon)
	#include "ILongWeaponAuto.Interface"
	func(canShoot)
	{
		objParams();
		private _weap = callSelf(getBullet);
		super() && !isNullReference(_weap) && {!isTypeOf(_weap,BulletCase)}
	};
	var(attachedWeap,weaponModule(WeapLongRangeHandle));
	var(shootCount,1);

	var(name,"Автомат ""Товарищ""");
	var(model,"relicta_models\models\weapons\fireweapon\handmade\akhandmade\akhandmade.p3d");
	var(weight,4.8);
	var(dr,6);
	getter_func(getReqST,12);
	var(size,ITEM_SIZE_MEDIUM);
	var(basicDistance,800);
	var(halfDistance,300);
	var(shootSpeed,715);

	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTRIFLE");
	getter_func(getUsingSkill,"rifle");
	var(basicDamage,vec2(5,0));

	getter_func(getReqMagazineType,"MagazineAuto");
	getter_func(getAmmoCaliber,"7.62мм");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	//sounds
	getter_func(getLoadMagazineSound,"guns\ak_magin");
	getter_func(getUnloadMagazineSound,"guns\ak_magout");
	getter_func(getBoltSound,"guns\ak_cock");
	getter_func(getShootSound,soundData("guns\ak_fire",0.85,1.15));
endclass

class(RifleBastard) extends(IRangedWeapon)
	#include "ILongWeaponAuto.Interface"
	func(canShoot)
	{
		objParams();
		private _weap = callSelf(getBullet);
		super() && !isNullReference(_weap) && {!isTypeOf(_weap,BulletCase)}
	};
	var(attachedWeap,weaponModule(WeapLongRangeButt));
	var(shootCount,1);

	var(name,"Автомат ""Мерзавец""");
	var(model,"relicta_models\models\weapons\fireweapon\marksman\svd\svd.p3d");
	var(weight,4.5);
	var(dr,5);
	getter_func(getReqST,12);
	var(size,ITEM_SIZE_LARGE);
	var(basicDistance,1300);
	var(halfDistance,450);
	var(shootSpeed,820);

	getter_func(getTwoHandAnim,ITEM_2HANIM_RIFLE);
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_RIFLE);
	getter_func(getAttackVisualData,"BFX_BULLET_SHOTRIFLE");
	getter_func(getUsingSkill,"rifle");
	var(basicDamage,vec2(7,0));

	getter_func(getReqMagazineType,"MagazineBastard");
	getter_func(getAmmoCaliber,"7.62мм");
	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);
	var(allowedSlots,[INV_BACK arg INV_BACKPACK]);
	//sounds
	getter_func(getLoadMagazineSound,"guns\bar_magin");
	getter_func(getUnloadMagazineSound,"guns\bar_magout");
	getter_func(getBoltSound,"guns\bar_cock");
	getter_func(getShootSound,soundData("guns\bar_fire",0.85,1.15));
endclass
