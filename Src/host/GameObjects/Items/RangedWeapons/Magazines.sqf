// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(MagazinePBM) extends(IMagazineBase)
	var(name,"Магазин ПБМ");
	var(weight,gramm(15.2));
	getterconst_func(getBulletType,"AmmoPBM");
	var(model,"relicta_models2\magazine\s_pistol_magazine\s_pistol_magazine.p3d");
	var(material,"MatMetal");
endclass

	class(MagazinePBMLoaded) extends(MagazinePBM)
		getterconst_func(initialAmmo,"AmmoPBM");
	endclass
	class(MagazinePBMLoaded_BB) extends(MagazinePBM)
		getterconst_func(initialAmmo,"AmmoPBM_BB");
	endclass
	class(MagazinePBMLoaded_NonLethal) extends(MagazinePBM)
		getterconst_func(initialAmmo,"AmmoPBMNonLethal");
	endclass

class(MagazineRevolver) extends(IMagazineBase)
	getterconst_func(getBulletType,"AmmoRevolver");
	var(model,"relicta_models2\magazine\s_pistol_magazine\s_pistol_magazine.p3d");
	var(maxCount,6);
	autoref var(content,[]);
	var(currentIndex,0); //на каком индексе патрон

	getterconst_func(getLoadAmmoSound,"guns\rev_magin");
	getterconst_func(getUnloadAmmoSound,"guns\rev_magout");

	func(constructor)
	{
		objParams();

		for "_i" from 1 to getSelf(maxCount) do {
			getSelf(content) pushBack nullPtr;
		};
	};

	//Крутить барабан
	func(spinDrum)
	{
		objParams_2(_nextCount,_doPlaySpinSound);

		if (_nextCount == 0) exitWith {};

		/*private _doReverse = false;
		if (_nextCount < 0) exitWith {_doReverse = true};
		private _contentRef = getSelf(content);
		private _maxCount = count _contentRef;
		private _elem = nullPtr;
		for "_i" from 1 to _nextCount do {
			_elem = _contentRef deleteAt 0;
			_contentRef pushBack _elem;
		};
		if (_doReverse) then {reverse _contentRef};*/

		//Быстро и чётко...
		setSelf(currentindex,abs (randInt(1,_nextCount) % getSelf(maxCount)));

		if !isNullVar(_doPlaySpinSound) then {
			if (_doPlaySpinSound) then {
				callSelfParams(playSound,"guns\revolver_spin" arg rand(0.8,1.2) arg 10)
			};
		};
	};

	//Получает индексы слотов. если _hasBullet == true то ищем индекс с пулей. иначе пустой слот
	func(getFreeDrumAmmoIndex)
	{
		objParams_1(_hasBullet);
		ifcheck(_hasBullet,getSelf(content) findif {!isNullReference(_x)},getSelf(content) find nullPtr);
	};

	func(addContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeDrumAmmoIndex,false),_itm];
	};

	func(removeContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeDrumAmmoIndex,true),nullPtr];
	};

	getterconst_func(getReqBullectCaseType,"BulletCaseRevolver");

	//В револьверный барабан можно грузить даже гильзы
	func(canLoadAmmoInMagazine)
	{
		objParams_1(_ammo);
		super() || isTypeStringOf(_ammo,callSelf(getReqBullectCaseType))
	};

	getter_func(getAmmoCount,{!isNullReference(_x)} count getSelf(content));
	getter_func(getFirstAmmoInMagazine,ifcheck(callSelf(getAmmoCount)>0,getSelf(content) select (callSelfParams(getFreeDrumAmmoIndex,true)),nullPtr));

	func(canMoveInItem)
	{
		objParams_1(_itm);
		super() || isTypeStringOf(_itm,callSelf(getReqBullectCaseType))
	};

endclass

editor_attribute("HiddenClass")
//vitual type of magazine for shotguns
class(VirtualMagazineDBShotgun) extends(IMagazineBase)
	var(weight,0);
	getterconst_func(getBulletType,"AmmoShotgun");

	var(maxCount,2);
	autoref var(content,[]);
	var(currentIndex,0); //на каком индексе патрон

	getterconst_func(getLoadAmmoSound,"guns\shotgun_insert");
	getterconst_func(getUnloadAmmoSound,"guns\shotgun_insert");

	func(constructor)
	{
		objParams();

		for "_i" from 1 to getSelf(maxCount) do {
			getSelf(content) pushBack nullPtr;
		};
	};

	func(getFreeMagAmmoIndex)
	{
		objParams_1(_hasBullet);
		ifcheck(_hasBullet,getSelf(content) findif {!isNullReference(_x)},getSelf(content) find nullPtr);
	};

	func(addContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeMagAmmoIndex,false),_itm];
	};

	func(removeContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeMagAmmoIndex,true),nullPtr];
	};

	getterconst_func(getReqBullectCaseType,"BulletCaseShotgun");

	//В револьверный барабан можно грузить даже гильзы
	func(canLoadAmmoInMagazine)
	{
		objParams_1(_ammo);
		super() || isTypeStringOf(_ammo,callSelf(getReqBullectCaseType))
	};

	getter_func(getAmmoCount,{!isNullReference(_x)} count getSelf(content));
	getter_func(getFirstAmmoInMagazine,ifcheck(callSelf(getAmmoCount)>0,getSelf(content) select (callSelfParams(getFreeMagAmmoIndex,true)),nullPtr));

	func(canMoveInItem)
	{
		objParams_1(_itm);
		super() || isTypeStringOf(_itm,callSelf(getReqBullectCaseType))
	};

endclass

editor_attribute("HiddenClass")
class(VirtualMagazineShotgun) extends(IMagazineBase)
	var(weight,0);
	getterconst_func(getBulletType,"AmmoShotgun");
	getterconst_func(getReqBullectCaseType,"BulletCaseShotgun");
	var(maxCount,8);
	var(content,[]);

	getterconst_func(getLoadAmmoSound,"guns\shell_insert" + str randInt(1,2));
	getterconst_func(getUnloadAmmoSound,"guns\shotgun_insert");

	func(canLoadAmmoInMagazine)
	{
		objParams_1(_ammo);
		super() || isTypeStringOf(_ammo,callSelf(getReqBullectCaseType))
	};

	func(canMoveInItem)
	{
		objParams_1(_itm);
		super() || isTypeStringOf(_itm,callSelf(getReqBullectCaseType))
	};

endclass

editor_attribute("HiddenClass")
class(VirtualMagazineShotgunMini) extends(IMagazineBase)
	var(weight,0);
	getterconst_func(getBulletType,"AmmoShotgunMini");

	var(maxCount,2);
	var(content,[]);
	var(currentIndex,0); //на каком индексе патрон

	getterconst_func(getLoadAmmoSound,"guns\shotgun_insert");
	getterconst_func(getUnloadAmmoSound,"guns\shotgun_insert");

	func(constructor)
	{
		objParams();

		for "_i" from 1 to getSelf(maxCount) do {
			getSelf(content) pushBack nullPtr;
		};
	};

	func(getFreeMagAmmoIndex)
	{
		objParams_1(_hasBullet);
		ifcheck(_hasBullet,getSelf(content) findif {!isNullReference(_x)},getSelf(content) find nullPtr);
	};

	func(addContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeMagAmmoIndex,false),_itm];
	};

	func(removeContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeMagAmmoIndex,true),nullPtr];
	};

	getterconst_func(getReqBullectCaseType,"BulletCaseShotgunMini");

	//В револьверный барабан можно грузить даже гильзы
	func(canLoadAmmoInMagazine)
	{
		objParams_1(_ammo);
		super() || isTypeStringOf(_ammo,callSelf(getReqBullectCaseType))
	};

	getter_func(getAmmoCount,{!isNullReference(_x)} count getSelf(content));
	getter_func(getFirstAmmoInMagazine,ifcheck(callSelf(getAmmoCount)>0,getSelf(content) select (callSelfParams(getFreeMagAmmoIndex,true)),nullPtr));

	func(canMoveInItem)
	{
		objParams_1(_itm);
		super() || isTypeStringOf(_itm,callSelf(getReqBullectCaseType))
	};

endclass

editor_attribute("HiddenClass")
class(VirtualMagazinePistolOneShoot) extends(IMagazineBase)
	var(weight,0);
	getterconst_func(getBulletType,"AmmoRevolver");

	var(maxCount,1);
	var(content,[nullPtr]);
	var(currentIndex,0); //на каком индексе патрон

	getterconst_func(getLoadAmmoSound,"guns\mag_load");
	getterconst_func(getUnloadAmmoSound,"guns\mag_unload");

	func(getFreeMagAmmoIndex)
	{
		objParams_1(_hasBullet);
		ifcheck(_hasBullet,getSelf(content) findif {!isNullReference(_x)},getSelf(content) find nullPtr);
	};

	func(addContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeMagAmmoIndex,false),_itm];
	};

	func(removeContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) set [callSelfParams(getFreeMagAmmoIndex,true),nullPtr];
	};

	getterconst_func(getReqBullectCaseType,"BulletCaseRevolver");

	//В револьверный барабан можно грузить даже гильзы
	func(canLoadAmmoInMagazine)
	{
		objParams_1(_ammo);
		super() || isTypeStringOf(_ammo,callSelf(getReqBullectCaseType))
	};

	getter_func(getAmmoCount,{!isNullReference(_x)} count getSelf(content));
	getter_func(getFirstAmmoInMagazine,ifcheck(callSelf(getAmmoCount)>0,getSelf(content) select (callSelfParams(getFreeMagAmmoIndex,true)),nullPtr));

	func(canMoveInItem)
	{
		objParams_1(_itm);
		super() || isTypeStringOf(_itm,callSelf(getReqBullectCaseType))
	};
endclass

class(MagazineFinisher) extends(IMagazineBase)
	var(name,"Магазин Навертыша");
	var(material,"MatMetal");
	var(weight,gramm(35.4));
	getterconst_func(getBulletType,"AmmoRifle");
	var(maxCount,5);
endclass

	class(MagazineFinisherLoaded) extends(MagazineFinisher)
		getterconst_func(initialAmmo,"AmmoRifle");
	endclass

class(MagazineSVT) extends(IMagazineBase)
	var(name,"Магазин СВТ");
	var(model,"relicta_models2\magazine\s_svt_magazine\s_svt_magazine.p3d");
	var(material,"MatMetal");
	var(weight,gramm(32.7));
	getterconst_func(getBulletType,"AmmoRifle");
	var(maxCount,6);
endclass

	class(MagazineSVTLoaded) extends(MagazineSVT)
		getterconst_func(initialAmmo,"AmmoRifle");
	endclass

class(MagazineAuto) extends(IMagazineBase)
	var(name,"Магазин ""Товарища""");
	var(model,"relicta_models2\magazine\s_rifleauto_magazine\s_rifleauto_magazine.p3d");
	var(weight,gramm(230));
	getterconst_func(getBulletType,"AmmoRifle");
	var(maxCount,30);
endclass

	class(MagazineAutoLoaded) extends(MagazineAuto)
		getterconst_func(initialAmmo,"AmmoRifle");
	endclass

class(MagazineBastard) extends(IMagazineBase)
	var(name,"Магазин ""Мерзавца""");
	var(model,"relicta_models2\magazine\s_bastard_magazine\s_bastard_magazine.p3d");
	var(material,"MatMetal");
	var(weight,gramm(180));
	getterconst_func(getBulletType,"AmmoRifle");
	var(maxCount,20);
endclass
	class(MagazineBastardLoaded) extends(MagazineBastard)
		getterconst_func(initialAmmo,"AmmoRifle");
	endclass

class(MagazinePistolHandmade) extends(IMagazineBase)
	var(name,"Магазин ""Дудатрёпа""");
	var(model,"relicta_models2\magazine\s_pistol_magazine\s_pistol_magazine.p3d");
	var(material,"MatMetal");
	var(weight,gramm(47));
	getterconst_func(getBulletType,"AmmoPistolHandmade");
	var(maxCount,7);
endclass

	class(MagazinePistolHandmadeLoaded) extends(MagazinePistolHandmade)
		getterconst_func(initialAmmo,"AmmoPistolHandmade");
	endclass
