// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\GameConstants.hpp"
#include "..\..\..\..\client\Inventory\inventory.hpp"

editor_attribute("InterfaceClass")
class(Backpack) extends(Container)
	var(name,"Рюкзак");
	var(desc,"Отлично подходит для таскания всякого барахла.");
	var(model,"a3\props_f_enoch\military\decontamination\deconkit_01_f.p3d");
	var(weight,gramm(600));
	var(allowedSlots,[INV_BACKPACK]);

	var_exprval(countSlots,DEFAULT_BACKPACK_STORAGE);
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_LARGE);

	getterconst_func(getExamine3dItemType,"backpack");

	var(icon,"\A3\weapons_f\ammoboxes\bags\data\ui\icon_B_C_Gorod_khk_ca.paa");

	func(onEquip)
	{
		objParams_1(_usr);

		callSuper(Container,onEquip);
		private _mob = getVar(_usr,owner);
		[_mob,"addBackpack",[_mob, getSelf(armaClass)]] call repl_doLocal;
	};

	func(onUnequip)
	{
		objParams_1(_usr);

		callSuper(Container,onUnequip);
		private _mob = getVar(_usr,owner);
		[_mob,"removeBackpack",_mob] call repl_doLocal;
	};
endclass

//Отдельный от рюкзаков
class(CoinBag) extends(Container)

	var(name,"Мешочек");
	var(desc,"Маленький мешочек для хранения звяков и бряков.");
	var(model,"relicta_models\models\interier\props\bagforgold.p3d");
	var(icon,invicon(meshochek));
	var(weight,gramm(130));
	var(allowedSlots,[INV_BELT]);

	var_exprval(countSlots,BASE_STORAGE_CAPACITY(1.4));
	var(size,ITEM_SIZE_SMALL);
	var(maxSize,ITEM_SIZE_SMALL);
endclass

class(KeyChain) extends(Container)
	var(name,"Связка ключей");
	var(material,"MatMetal");
	var(desc,"Кусок проволоки для хранения ключей.");
	var(model,"a3\structures_f_epa\items\tools\metalwire_f.p3d");
	var(weight,gramm(20));
	var(allowedSlots,[INV_BELT]);
	getter_func(allowedItemClasses,["Key"]);
	var_exprval(countSlots,BASE_STORAGE_CAPACITY(3));
	var(size,ITEM_SIZE_SMALL);
	var(maxSize,ITEM_SIZE_SMALL);
	var(isPuttableContainer,true);
	var(keyOwners,[]);
	var(handcuffs,[]);

	getter_func(getDropSound,"dropping\keydrop");
	getter_func(getPickupSound,"updown\keyring_up");
	getter_func(getPutdownSound,"updown\keyring_up");

	// Обновляет массивы ключей которых держит связка
	func(updateKeyOwners)
	{
		objParams();
		
		private _content = getSelf(content);
		private _newOwners = [];
		private _newHandcuffs = [];
		
		{	
			private _keyOwner = getVar(_x,keyOwner);
			_newOwners append _keyOwner;
			if isImplementVar(_x,handcuffs) then {
				private _handcuffs = getVar(_x,handcuffs) splitString ";| ,";
				_newHandcuffs append _handcuffs;
			}
		} forEach _content;
		
		setSelf(keyOwners,_newOwners);
		setSelf(handcuffs,_newHandcuffs);
	};

	func(addItem)
	{
		objParams_1(_item);
		private _result = super();
		callSelf(updateKeyOwners);
		_result
	};

	func(removeItem)
	{
		objParams_3(_item,_newLoc,_slot);
		private _result = super();
		callSelf(updateKeyOwners);
		// Если остался только один ключ, то вытаскиваем его из связки и удаляем связку
		if (getSelf(currentsize) == 1) then {
			private _isInWorld = callSelf(isInWorld);
			private _loc = getSelf(loc);
			private _key = getSelf(content) select 0;

			if (_isInWorld) then {
				callFuncParams(_key,dropItemToWorld,callSelf(getPos) arg 0 arg random 360 arg this arg true);
			} else {
				private _keyChainSlot = getSelf(slot);
				callFuncParams(_loc,removeItem,this);
				if (_keyChainSlot == INV_BELT) then {
					callFuncParams(_key,dropItemToWorld,callSelf(getPos) arg 0 arg random 360 arg this arg true);
				} else {
					callFuncParams(_loc,addItem,_key arg _keyChainSlot);
				};
			};
			getSelf(content) deleteAt 0;
			callSelf(onContainerContentUpdate);
			setSelf(countSlots,0);
			setSelf(openedBy,[]);
			if (_isInWorld) then {
				callSelf(unloadModel);
			};
			callFuncParams(this,playSound,"updown\keyring_up" arg getRandomPitchInRange(0.9,1.1));
		};

		_result;
	};
endclass

class(FabricBagBig1) extends(Container)
	var(name,"Мешок");
	var(allowedSlots,[INV_BACKPACK]);
	var_exprval(countSlots,DEFAULT_BOX_STORAGE);
	var(maxSize,ITEM_SIZE_BIG);
	var(size,ITEM_SIZE_HUGE);
	var(weight,gramm(800));
	var(model,"ml_shabut\meshok\meshok1.p3d");
	var(icon,invicon(bigsack));
	
endclass

class(FabricBagBig2) extends(FabricBagBig1)
	var(model,"ml_shabut\meshok\meshok2.p3d");
endclass


// Новые рюкзами 24.05.25

//Рюкзаки из кожи
editor_attribute("InterfaceClass")
class(LeatherBackpack) extends(Backpack)
	var(weight,gramm(1000));
	var(size,ITEM_SIZE_MEDIUM);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(LeatherBackpackBrown) extends(LeatherBackpack)
	var(name,"Рюкзак из кожи");
	var(armaClass,"Backpack_brn");
endclass

editor_attribute("Deprecated" arg "Этот рюкзак будет удалён в будущем.")
class(SmallBackpack) extends(LeatherBackpackBrown)
endclass

class(LeatherBackpackRed) extends(LeatherBackpack)
	var(name,"Рюкзак из красной кожи");
	var(armaClass,"Backpack_red");
endclass

class(LeatherBackpackSand) extends(LeatherBackpack)
	var(name,"Рюкзак из жёлтой кожи");
	var(armaClass,"Backpack_snd");
endclass

class(LeatherBackpackWhite) extends(LeatherBackpack)
	var(name,"Рюкзак из белой кожи");
	var(armaClass,"Backpack_wht");
endclass

class(LeatherBackpackBlack) extends(LeatherBackpack)
	var(name,"Рюкзак из чёрной кожи");
	var(armaClass,"Backpack_blk");
endclass

class(LeatherBackpackGreen) extends(LeatherBackpack)
	var(name,"Рюкзак из зелёной кожи");
	var(armaClass,"Backpack_grn");
endclass

class(LeatherBackpackKhaki) extends(LeatherBackpack)
	var(name,"Рюкзак из светло-зелёной кожи");
	var(armaClass,"Backpack_khk");
endclass

// Большие рюкзаки из кожи
editor_attribute("InterfaceClass")
class(BigLeatherBackpack) extends(Backpack)
	var(weight,gramm(1500));
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(BigLeatherBackpackBrown) extends(BigLeatherBackpack)
	var(name,"Большой рюкзак из кожи");
	var(armaClass,"lambert1_brn");
endclass

class(BigLeatherBackpackRed) extends(BigLeatherBackpack)
	var(name,"Большой рюкзак из красной кожи");
	var(armaClass,"lambert1_red");
endclass

class(BigLeatherBackpackBlack) extends(BigLeatherBackpack)
	var(name,"Большой рюкзак из чёрной кожи");
	var(armaClass,"lambert1_blk");
endclass

class(BigLeatherBackpackSand) extends(BigLeatherBackpack)
	var(name,"Большой рюкзак из жёлтой кожи");
	var(armaClass,"lambert1_snd");
endclass

//Портфели
editor_attribute("InterfaceClass")
class(BackpackBriefcase) extends(Backpack)
	var(weight,gramm(1000));
	var(size,ITEM_SIZE_MEDIUM);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(Satchel) extends(BackpackBriefcase)
	var(name,"Ранец");
	var(armaClass,"Backpack_04");

endclass

class(SoldierSatchel) extends(BackpackBriefcase)
	var(name,"Солдатский ранец");
	var(armaClass,"pouch_black");
	var(weight,gramm(2000));
	var(size,ITEM_SIZE_LARGE);
	var(maxSize,ITEM_SIZE_LARGE);
endclass

//Мешки
editor_attribute("InterfaceClass")
class(BackpackBag) extends(Backpack)
	var(weight,gramm(1000));
	var(size,ITEM_SIZE_MEDIUM);
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

class(Kitbag) extends(BackpackBag)
	var(name,"Мешок на верёвочке");
	var(armaClass,"prospectors_02_backpack");
	var(weight,gramm(500));
endclass

class(WaistBag) extends(BackpackBag)
	var(name,"Поясной мешок");
	var(armaClass,"republican_bag_01");
		var(weight,gramm(200));
	var(size,ITEM_SIZE_SMALL);
	var(maxSize,ITEM_SIZE_SMALL);
endclass

class(GuitarBackpackHandmadeBlack) extends(Backpack)
	var(name,"Гитаный рюкзак");
	var(armaClass,"guitar_black");
	var(weight,2.8);
	var(size,ITEM_SIZE_MEDIUM);
	var(maxSize,ITEM_SIZE_MEDIUM);
	var(material,"MatWood");
endclass

class(GuitarBackpackHandmadeBrown) extends(GuitarBackpackHandmadeBlack)
	var(armaClass,"guitar_brown");
endclass

class(GuitarBackpackHandmadeLightBrown) extends(GuitarBackpackHandmadeBlack)
	var(armaClass,"guitar_co");
endclass