// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

class(AmmoPBM) extends(IAmmoBase)
	getterconst_func(getCasingType,"BulletCasePBM");
	getterconst_func(getCaliber,"9мм");
	var(model,"\A3\Weapons_f\ammo\cartridge_small.p3d");
endclass
	class(AmmoPBM_BB) extends(AmmoPBM)
		var(additionalDamage,+1);
	endclass

	class(AmmoPBMNonLethal) extends(AmmoPBM)
		getterconst_func(isNonLethalAmmo,true);
		var(name,"Патрон (защитный)");
		var(stackName,"Патроны (защитные)");
		var(desc,"Нелетальные патроны. Используются при самообороне.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
			_dam = floor(_dam / 5);
			_type = DAMAGE_TYPE_CRUSHING;
			callFuncParams(_targ,applyDamage,_dam arg _type arg _sel arg _dir);
			callFuncParams(_targ,addPainLevel,[_sel] call gurps_convertTargetZoneToBodyPart arg 1);
			callFuncParams(_targ,Stun, randInt(4,6));
		};
	endclass

	class(AmmoPBMBlank) extends(AmmoPBMNonLethal)
		var(name,"Холостой патрон");
		var(stackName,"Холостые патроны");
		var(desc,"Холостые патроны. Не содержат пули и прочих опасных соединений.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
		};
	endclass



class(BulletCasePBM) extends(BulletCase)
	getterconst_func(getCaliber,"9мм");
endclass


class(AmmoRevolver) extends(IAmmoBase)
	getterconst_func(getCasingType,"BulletCaseRevolver");
	getterconst_func(getCaliber,".38");
endclass

	class(AmmoRevolverBlank) extends(AmmoRevolver)
		getterconst_func(isNonLethalAmmo,true);
		var(name,"Холостой патрон");
		var(stackName,"Холостые патроны");
		var(desc,"Холостые патроны. Не содержат пули и прочих опасных соединений.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
		};
	endclass

	class(BulletCaseRevolver) extends(BulletCase)
		getterconst_func(getCaliber,".38");
	endclass

class(AmmoShotgun) extends(IAmmoBase)
	getter_func(getProjectileName,"Дробь");
	var(model,"\A3\Weapons_f\ammo\cartridge_slug.p3d");
	getterconst_func(getCasingType,"BulletCaseShotgun");
	getter_func(getDropSound,vec2("guns\shotgun_fall",getRandomPitchInRange(.85,1.3)));
	getterconst_func(getCaliber,".12");
	//сколько дробин вылетает из оружия
	getterconst_func(getFractionModifier,9);
endclass

	class(AmmoShotgunNonLethal) extends(AmmoShotgun)
		getterconst_func(isNonLethalAmmo,true);
		var(name,"Патрон (защитный)");
		var(stackName,"Патроны (защитные)");
		var(desc,"Нелетальные патроны. Используются при самообороне.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
			_dam = floor(_dam / 5);
			_type = DAMAGE_TYPE_CRUSHING;
			callFuncParams(_targ,applyDamage,_dam arg _type arg _sel arg _dir);
			callFuncParams(_targ,addPainLevel,[_sel] call gurps_convertTargetZoneToBodyPart arg 1);
			callFuncParams(_targ,Stun, randInt(5,7));
		};
	endclass

	class(AmmoShotgunBlank) extends(AmmoShotgunNonLethal)
		var(name,"Холостой патрон");
		var(stackName,"Холостые патроны");
		var(desc,"Холостые патроны. Не содержат пули и прочих опасных соединений.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
		};
	endclass

	class(BulletCaseShotgun) extends(BulletCase)
		var(model,"\A3\Weapons_f\ammo\cartridge_slug.p3d");
		getter_func(getDropSound,vec2("guns\shotgun_fall",getRandomPitchInRange(.85,1.3)));
		getterconst_func(getCaliber,".12");
	endclass


class(AmmoShotgunMini) extends(IAmmoBase)
	getter_func(getProjectileName,"Дробь");
	var(model,"\A3\Weapons_f\ammo\cartridge_slug.p3d");
	getterconst_func(getCasingType,"BulletCaseShotgunMini");
	getter_func(getDropSound,vec2("guns\shotgun_fall",getRandomPitchInRange(.85,1.3)));
	var(weight,gramm(50));
	getterconst_func(getCaliber,".11");
	//сколько дробин вылетает из оружия
	getterconst_func(getFractionModifier,9);
endclass

	class(AmmoShotgunMiniBlank) extends(AmmoShotgunMini)
		getterconst_func(isNonLethalAmmo,true);
		var(name,"Холостой патрон");
		var(stackName,"Холостые патроны");
		var(desc,"Холостые патроны. Не содержат пули и прочих опасных соединений.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
		};
	endclass

	class(BulletCaseShotgunMini) extends(BulletCase)
		var(model,"\A3\Weapons_f\ammo\cartridge_slug.p3d");
		getter_func(getDropSound,vec2("guns\shotgun_fall",getRandomPitchInRange(.85,1.3)));
		getterconst_func(getCaliber,".11");
	endclass

class(AmmoRifle) extends(IAmmoBase)
	var(model,"\A3\Weapons_f\ammo\cartridge_65.p3d");
	var(weight,gramm(22.7));
	getterconst_func(getCaliber,"7.62мм");
	getterconst_func(getCasingType,"BulletCaseRifle");
endclass

	class(AmmoRifleBlank) extends(AmmoRifle)
		getterconst_func(isNonLethalAmmo,true);
		var(name,"Холостой патрон");
		var(stackName,"Холостые патроны");
		var(desc,"Холостые патроны. Не содержат пули и прочих опасных соединений.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
		};
	endclass

	class(BulletCaseRifle) extends(BulletCase)
		var(model,"\A3\Weapons_f\ammo\cartridge_65.p3d");
		getterconst_func(getCaliber,"7.62мм");
	endclass

class(AmmoPistolHandmade) extends(IAmmoBase)
	var(model,"\A3\Weapons_f_enoch\ammo\cartridge_762x39.p3d");
	getterconst_func(getCaliber,".340");
	getterconst_func(getCasingType,"BulletCasePistolHandmade");
endclass

	class(AmmoPistolHandmadeBlank) extends(AmmoPistolHandmade)
		getterconst_func(isNonLethalAmmo,true);
		var(name,"Холостой патрон");
		var(stackName,"Холостые патроны");
		var(desc,"Холостые патроны. Не содержат пули и прочих опасных соединений.");
		func(onDamageBulletProcess)
		{
			objParams_5(_targ,_dam,_type,_sel,_dir);
		};
	endclass

	class(BulletCasePistolHandmade) extends(BulletCase)
		var(model,"\A3\Weapons_f_enoch\ammo\cartridge_762x39.p3d");
		getterconst_func(getCaliber,".340");
	endclass
