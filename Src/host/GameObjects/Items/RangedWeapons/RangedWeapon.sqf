// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass")
class(IRangedWeapon) extends(Item)

	"
		name:Дистанционное оружие
		desc:Оружие для дальнего боя (огнестрельное оружие)
		path:Игровые объекты.Оружие.Дистанционное
	" node_class

	//TODO implement verbs
	verbList("cockweapon safemodeweapon",Item);

	var(material,"MatMetal");

	var(dr,4);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);

	var(basicDistance,100); //базовая дистанция
	var(halfDistance,100); //1/2 дистанции
	var(basicAccuracy,0);//точность. чем ниже значение тем лучше
	var(basicDamage,vec2(0,0));//кубик + модификатор
	var(shootSpeed,2); //2 м/с

	var(rateOfFire,0.2);//каждые 0.2 секунды можно стрелять

	var(shootCount,1); //сколько выстрелов будет сделано за 1 активацию

	getter_func(isCocked,!isNullReference(getSelf(bullet))); //во взведённом оружии в патроннике есть патрон
	autoref var(bullet,nullPtr);
	autoref var(magazine,nullPtr); //ссылка на магазин

	getter_func(getReqST,1); //минимальная сила с которой можно стрелять из оружия одной рукой

	//Базовые геттеры. юзера отправляем для корректировки значений и лука
	func(getBasicDistance)
	{
		objParams_1(_usr);
		getSelf(basicDistance)
	};
	func(getHalfDistance)
	{
		objParams_1(_usr);
		getSelf(halfDistance)
	};
	func(getBasicAccuracy)
	{
		objParams_1(_usr);
		getSelf(basicAccuracy)
	};
	func(getBasicDamage)
	{
		objParams_1(_usr);
		getSelf(basicDamage)
	};
	func(getShootSpeed)
	{
		objParams_1(_usr);
		getSelf(shootSpeed);
	};

	func(getLevelDown) //на сколько сильно отклонится пуля при потере направления
	{
		objParams_1(_usr);
		rand(0.001,0.005)
	};
	func(getPrecDown) //через какое расстояние пуля потеряет направление
	{
		objParams_1(_usr);
		rand(90,99)
	};

	func(getShootDamageData)
	{
		objParams_2(_bullet,_usr);

		//[(_dices call gurps_throwdices) + _mod,DAMAGE_TYPE_CRUSHING,getVar(_mob,curTargZone),_mob];
		callSelfParams(getBasicDamage,_usr) params ["_dices","_mod"];
		modvar(_mod) + getVar(_bullet,additionalDamage);

		[
			(_dices call gurps_throwdices) + _mod,
			callSelf(getShootDamageType),
			getVar(_usr,curTargZone),
			_usr,
			this
		]
	};

	getter_func(getUsingSkill,"pistol");

	var(isSafeMode,false);//предохранитель для огнестрела
	var(reloadTime,0.4); //время перезарядки

	var(isShootMode,true); //выключенный режим -удар прикладом

	getter_func(getShootDamageType,DAMAGE_TYPE_PIERCING_NO);

	getter_func(getHandAnim,ITEM_HANDANIM_LOWERONLYHAND);
	getter_func(getCombAnim,ITEM_COMBATANIM_GUN);

	getter_func(getAmmoLoadType,"");//mag,bullet,arrow

	//звуки вставки магазина и вытаскиывания его
	getter_func(getLoadMagazineSound,"guns\pistol_magin");
	getter_func(getUnloadMagazineSound,"guns\pistol_magout");
	//звук передёргивания затвора
	getter_func(getBoltSound,"guns\pistol_bolt");
	//звук выстрела. должна быть зарегистрирована асоциация в interact_map_shassoc_keyint
	getter_func(getShootSound,soundData("guns\pistol_fire"+str randInt(1,2),0.9,1.1));

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + ifcheck(callSelf(isCocked),
			sbr + "Заряжено.",
			""
		)
		#ifdef EDITOR
		+ sbr + "Выстрелов осталось: " + str ifcheck(callSelf(hasMagazine),callFunc(getSelf(magazine),getAmmoCount),0);
		#endif
	};

	func(getWeight)
	{
		objParams();
		private _w = super();
		{
			if !isNullReference(_x) then {
				modvar(_w) + callFunc(_x,getWeight);
			};
		} count [getSelf(bullet),getSelf(magazine)];
		_w
	};

	func(canShoot)
	{
		objParams();
		if !callSelf(isCocked) exitWith {false};
		true
	};

	func(onCantShoot)
	{
		objParams_1(_usr);
		callSelfParams(worldSay,callSelfParams(getNameFor,_usr) + " издаёт щелчок." arg "info");
		callSelf(playTriggerSound);
	};

	getterconst_func(getRofCoef,0.093);//коэффициент скорострельности при shootCount > 1

	var(isJammed,false);
	//сделать клин оружия
	func(doJamWeapon)
	{
		objParams();
		if !getSelf(isJammed) then {
			setSelf(isJammed,true);
			callSelf(playTriggerSound);
		};
	};
	func(tryUnjam)
	{
		objParams_1(_usr);
		//params ['this',"_target","_method","_callAfter",["_checkType",-1],["_optItem",nullPtr]];
		callFuncParams(_usr,startProgress,this arg "target.doUnjamWeapon" arg rand(1,3) arg INTERACT_PROGRESS_TYPE_MEDIUM);
	};
	func(doUnjamWeapon)
	{
		objParams_1(_usr);
		if getSelf(isJammed) then {
			setSelf(isJammed,false);
			callSelf(playBoltSound);
			callFuncParams(_usr,meSay,"устраняет неисправность оружия.");
		};
	};
/*	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(tryUnjam,_usr);
	};*/

	//Вызывается при создании гильзы после выстрела. выбросить из оружия или ещё чтот сделать
	func(onCasingProcess)
	{
		objParams_2(_bulletcase,_usr);

		callFuncAfterParams(_bulletcase,dropItemToWorld,rand(0.3,0.55),getPosATL getVar(_usr,owner) arg null arg null arg _usr);
	};

	getter_func(getBullet,getSelf(bullet));

	//Можно ли загрузить новую пулю в патронник после выстрела (автоматическое оружие)
	getter_func(canPrepareBulletAfterProj,true);

	//Функционал выстрела
	func(prepareProjectile)
	{
		objParams_1(_usr);

		//Проверки выполняются на уровнях выше
/*		if !callSelf(isCocked) exitWith {
			//click
		};*/
		//TODO: revolver handling

		private _bullet = callSelf(getBullet);

		if !isNullReference(_bullet) then {
			callSelfParams(onMoveOutItem,_bullet);
			setVar(_bullet,loc,objnull);
			//create instance case
			private _itm = instantiate(callFunc(_bullet,getCasingType));
			//callSelfParams(onMoveInItem,_itm);
			//drop from weapon
			//callFuncParams(getSelf(bullet),dropItemToWorld,getVar(_usr,owner) arg null arg null arg _usr);
				//new alg
				setVar(_itm,loc,null);
				setVar(_itm,shootedTime,tickTime);
				callSelfParams(onCasingProcess,_itm arg _usr);
		};

		if callSelf(canPrepareBulletAfterProj) then {
			//load next bullet
			callSelf(prepareBullet);
		};

		_bullet
	};

	//Визуальный эффект выстрела. вспышки, дымок итд
	func(getAttackVisualData)
	{
		objParams();
		""
	};

	getter_func(getShootSoundDistance,80);
	func(playShootSound)
	{
		objParams_1(_usr);
		OBSOLETE(IRangedWeapon::playShootSound);
		callFuncParams(_usr,playSoundData,callSelf(getShootSound) arg callSelf(getShootSoundDistance));
	};

	func(playTriggerSound)
	{
		objParams();
		callSelfParams(playSound,"guns\gun_empty" arg rand(0.8,1.3) arg 10);
	};

	//mag loading
	"
		name:Магазин вставлен
		desc:Возвращает @[bool ИСТИНУ], если магазин заряжен в оружие. Для дробовиков, револьверов или однозарядных пистолетов всегда возвращает @[bool ИСТИНУ].
		type:get
		return:bool:Вставлен ли магазин в оружие
	" node_met
	getter_func(hasMagazine,!isNullReference(getSelf(magazine)));
	"
		name:Допустимый тип магазина
		desc:Возвращает имя класса магазина, который можно зарядить в оружие. Дочерние типы от этого магазина также могут быть заряжены в оружие.
		type:const
		return:classname:Имя класса магазина
	" node_met
	getter_func(getReqMagazineType,"IMagazineBase");
	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,IMagazineBase) exitWith {
			callSelfParams(loadMagazine,_with arg _usr);
		};
		if (isTypeOf(_with,IAmmoBase) && {callSelf(getAmmoCaliber)==callFunc(_with,getCaliber)}) exitWith {
			callSelfParams(onAmmoInteract,_with arg _usr);
		};
		if isTypeOf(_with,BulletCase) exitWith {
			callSelfParams(onBulletCaseInteract,_with arg _usr);
		};
	};

	//используется в данный момент чтобы понимать какие патроны можно зарядить внутрь оружия напрямую (в обход магазина)
	getter_func(getAmmoCaliber,"");

	func(onAmmoInteract)
	{
		objParams_2(_ammo,_usr);
		callFuncParams(_ammo,moveItem,this);
	};

	func(onBulletCaseInteract) { objParams_2(_ammo,_usr); };

	func(onItemClick)
	{
		objParams_1(_usr);

		if callSelf(hasMagazine) exitWith {
			callSelfParams(unloadMagazine,_usr);
		};
	};

	func(onItemSelfClick)
	{
		objParams_1(_usr);
		callSelfParams(cockProcess,_usr);
	};

	//Полезный метод, например если из револьвера не выбрасываются патроны
	func(handlePreCockProcess)
	{
		objParams_1(_usr);

		if callSelf(isCocked) then {
			//выбросить текущий патрон на землю
			callFuncParams(getSelf(bullet),dropItemToWorld,getVar(_usr,owner) arg null arg null arg _usr);
		};
	};

	func(playBoltSound)
	{
		objParams();
		callSelfParams(playSound,callSelf(getBoltSound) arg rand(0.8,1.2) arg 10);
	};

	//зарядка при возможности
	func(cockProcess)
	{
		objParams_1(_usr);
		callSelf(playBoltSound);

		callSelfParams(handlePreCockProcess,_usr);

		//вытащить патрон из магазина и переместить в зарядник
		if callSelf(hasMagazine) then {
			callSelf(prepareBullet);
		};
	};

	//патрон в патронник
	func(prepareBullet)
	{
		objParams();
		private _mag = getSelf(magazine);
		if (callFunc(_mag,getAmmoCount)>0) then {
			private _itm = callFunc(_mag,getFirstAmmoInMagazine);
			callFuncParams(_itm,moveItem,this);
		};
	};

	func(loadMagazine)
	{
		objParams_2(_mag,_usr);
		if !isTypeStringOf(_mag,callSelf(getReqMagazineType)) exitWith {
			callFuncParams(_usr,localSay,"Этот магазин сюда не подходит." arg "error");
		};
		if !isNullReference(getSelf(magazine)) exitWith {
			//магазин уже есть
		};
		callFuncParams(_mag,moveItem,this);
		callFuncParams(_mag,playSound,callSelf(getLoadMagazineSound) arg rand(0.8,1.2) arg 10);
	};

	func(unloadMagazine)
	{
		objParams_1(_usr);
		callFuncParams(getSelf(magazine),playSound,callSelf(getUnloadMagazineSound) arg rand(0.8,1.2) arg 10);
		callFuncParams(getSelf(magazine),moveItem,_usr);
	};

	func(canMoveInItem)
	{
		objParams_1(_itm);
		if isTypeOf(_itm,IMagazineBase) exitWith {
			isTypeStringOf(_itm,callSelf(getReqMagazineType)) && !callSelf(hasMagazine)
		};
		if (isTypeOf(_itm,IAmmoBase) || isTypeOf(_itm,BulletCase)) exitWith {
			!callSelf(isCocked)
		};
		false
	};

	func(onMoveInItem)
	{
		objParams_1(_itm);
		setVar(_itm,loc,this);
		if isTypeOf(_itm,IMagazineBase) exitWith {setSelf(magazine,_itm); callSelf(onWeightChanged)};
		if (isTypeOf(_itm,IAmmoBase) || isTypeOf(_itm,BulletCase)) exitWith {setSelf(bullet,_itm); callSelf(onWeightChanged)};
	};

	func(canMoveOutItem)
	{
		objParams_1(_itm);
		if isTypeOf(_itm,IMagazineBase) exitWith {
			isTypeStringOf(_itm,callSelf(getReqMagazineType)) && callSelf(hasMagazine)
		};
		if (isTypeOf(_itm,IAmmoBase) || isTypeOf(_itm,BulletCase)) exitWith {
			callSelf(isCocked)
		};
		false
	};

	//Удаляет заряженную пулю
	func(removeLoadedBullet)
	{
		objParams();
		setSelf(bullet,nullPtr);
	};

	func(onMoveOutItem)
	{
		objParams_1(_itm);
		if isTypeOf(_itm,IMagazineBase) exitWith {setSelf(magazine,nullPtr); callSelf(onWeightChanged)};
		if (isTypeOf(_itm,IAmmoBase) || isTypeOf(_itm,BulletCase)) exitWith {callSelf(removeLoadedBullet); callSelf(onWeightChanged)};
	};

	//Системная функция создания магазина внутри оружия. Не должна вызываться в прогрессе
	func(createMagazine)
	{
		objParams_1(_type);
		if callSelf(hasMagazine) exitWith {nullPtr};
		private _itm = instantiate(_type);
		setVar(_itm,loc,this);
		setSelf(magazine,_itm);
		callSelf(onWeightChanged);
		_itm
	};

	"
		name:Создать магазин
		desc:Создает магазин в оружии. Если магазин уже заряжен в оружии или указан несовместимый тип магазина - создание не произойдёт.
		type:method
		lockoverride:1
		in:classname:Тип магазина:Тип создаваемого магазина
			opt:def=IMagazineBase:typeset_out=Результат
		in:classname:Тип патронов:Тип боеприпасов, создаваемых в оружии
			opt:require=0:def=IAmmoBase
		in:int:Количество:Сколько боеприпасов будет создано в магазине.
			opt:require=0:def=0
		return:IMagazineBase:Созданный магазин. Возвращает @[object^ null-ссылку] если создание не произошло.
	" node_met
	func(createMagazineWithAmmo)
	{
		objParams_3(_itm,_ammo,_ammoCount);
		
		if callSelf(hasMagazine) exitWith {nullPtr};
		if !isTypeNameStringOf(_itm,callSelf(getReqMagazineType)) exitWith {nullPtr};
		private _mag = callSelfParams(createMagazine,_itm);
		
		if (!isNullReference(_mag) ) then {
			callSelfParams(createAmmoInMagazine,_ammo arg _ammoCount);
		};

		_mag
	};

	"
		name:Создать боеприпасы в магазине
		desc:Создает боеприпасы указанного типа в оружии. Если количество не указано - будет создано максимальное количество. Если типы патронов не совместимы с магазином или в оружии нет магазина - создание не произойдёт.
		type:method
		lockoverride:1
		in:classname:Тип патронов:Тип боеприпасов, создаваемых в оружии
			opt:require=0:def=IAmmoBase
		in:int:Количество:Сколько боеприпасов будет создано в магазине.
			opt:require=0:def=1
	" node_met
	func(createAmmoInMagazine)
	{
		objParams_2(_type,_count);
		if !callSelf(hasMagazine) exitWith {};
		callFuncParams(getSelf(magazine),createAmmoInside,_type arg _count);
	};

	//событие после каждого выстрела
	func(onPostShoot)
	{
		objParams_1(_usr);
		
		if not_equals(getSelf(loc),_usr) exitwith {};
		if callFuncParams(_usr,hasPerk,"PerkOneHandShooter") exitwith {};

		private _eventDrop = {
			private _m = format["<t size='1.2'>%1 вылетает из рук %2</t>",callSelf(getName),callFuncParams(_usr,getNameEx,"кого")];
			callFuncParams(_usr,worldSay,_m arg "act");
			callSelfParams(dropItemToWorld,callFunc(_usr,getPos) arg null arg null arg _usr arg false);
		};
		
		if (callFunc(_usr,getST) < callSelf(getReqST)) then {
			private _shtraf = -(callSelf(getReqST) - callFunc(_usr,getST));
			if callFuncParams(_usr,isHoldedTwoHands,this) then {
				//мало силы но держит двумя руками. бросок силы
				if (!callFuncParams(_usr,checkSkill,"ST" arg 0 arg true)) then {
					call _eventDrop;
				};
			} else {
				//мало силы и держит одной рукой - бросок силы со штрафом
				if (!callFuncParams(_usr,checkSkill,"ST" arg _shtraf arg true)) then {
					call _eventDrop;
				};
			};
		};
	};
	func(onPickup)
	{
		objParams_1(_usr);
		super();
		if (callFunc(_usr,getST) < callSelf(getReqST)) then {
			private _name = callSelf(getName);
			private _randMes = ["Тяжеловато.",_name + " мне не по силе.",_name + "? Да я надорвусь!","У меня сил не хватит!"];
			callFuncParams(_usr,localSay,pick _randMes arg "info");
		};
	};

	func(destructor)
	{
		objParams();
		if !isNullReference(getSelf(magazine)) then {
			delete(getSelf(magazine));
		};
		if !isNullReference(getSelf(bullet)) then {
			delete(getSelf(bullet));
		};
	};

endclass

editor_attribute("InterfaceClass")
class(IMagazineBase) extends(Item)
	var(name,"Магазин");
	var(model,"a3\structures_f_epb\items\military\magazine_rifle_f.p3d");
	var(material,"MatSynt");
	//opt metro model: "ml\ml_object_new\model_14_10\patroni.p3d"
	// or
	var(maxCount,8);
	var(weight,0);
	var(size,ITEM_SIZE_SMALL);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	var(content,[]);
	getterconst_func(getBulletType,"IAmmoBase"); //какие типы боеприпасов могут быть загружены в оружие

	getter_func(getEquipSound,"");
	getter_func(getUnequipSound,"");

	getterconst_func(getLoadAmmoSound,"guns\mag_load");
	getterconst_func(getUnloadAmmoSound,"guns\mag_unload");

	getterconst_func(initialAmmo,null); //что будет создано в магазине. структура 2х элементов: тип, количество ИЛИ строка (тип)
	func(constructor)
	{
		objParams();
		private _initAmmo = callSelf(initialAmmo);
		if !isNullVar(_initAmmo) then {
			private _type= ""; private _count = 0;
			if equalTypes(_initAmmo,[]) then {
				_initAmmo params ["_typeEx","_countEx"];
				_count = clamp(_countEx,1,getSelf(maxCount));
				_type = _typeEx;
			} else {
				_type = _initAmmo;
				_count = getSelf(maxCount);
			};
			private _itm = nullPtr;
			for "_i" from 1 to _count do {
				_itm = instantiate(_type);
				callSelfParams(addContent,_itm);
			};
		};
	};

	func(destructor)
	{
		objParams();
		//удаление патронов
		{
			if !isNullReference(_x) then {delete(_x)};
		} foreach array_copy(getSelf(content));
		if !callSelf(isInWorld) then {
			private _loc = getSelf(loc);
			if isTypeOf(_loc,IRangedWeapon) then {
				setVar(_loc,magazine,nullPtr);
				callFunc(_loc,onWeightChanged);
			};
		};
	};

	func(createAmmoInside)
	{
		objParams_2(_ammo,_count);
		
		if isNullVar(_ammo) then {_ammo = callSelf(getBulletType)};
		if !isTypeNameStringOf(_ammo,callSelf(getBulletType)) exitwith {};

		if isNullVar(_count) then {_count = getSelf(maxCount)};
		_count = clamp(_count,1,getSelf(maxCount));
		private _itm = nullPtr;
		for "_i" from 1 to _count do {
			_itm = instantiate(_ammo);
			callSelfParams(addContent,_itm);
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr + (format["Вместимость %1",vec3(getSelf(maxCount),vec3("патрон","патрона","патронов"),true) call toNumeralString]) + sbr + ifcheck(
			callSelf(getAmmoCount)<=0,
			"Он пустой.",
			format vec3(
				"Там %1 %2",
				pick vec3("целых","аж","ещё"),
				vec3(callSelf(getAmmoCount),vec3("патрон","патрона","патронов"),true) call toNumeralString
			)
		)
	};

	func(getWeight)
	{
		objParams();
		private _w = super();
		{
			if !isNullReference(_x) then {
				modvar(_w) + callFunc(_x,getWeight);
			};
		} count getSelf(content);
		_w
	};

	func(canLoadAmmoInMagazine)
	{
		objParams_1(_ammo);
		isTypeStringOf(_ammo,callSelf(getBulletType))
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if isTypeOf(_with,IAmmoBase) then {
			callSelfParams(loadAmmoToMagazine,_with arg _usr);
		};
	};

	func(onItemClick)
	{
		objParams_1(_usr);
		callSelfParams(unloadAmmoFromMagazine,_usr);
	};

	func(loadAmmoToMagazine)
	{
		objParams_2(_ammo,_usr);

		if (callSelf(getAmmoCount) >= getSelf(maxCount)) exitWith {
			callFuncParams(_usr,mindSay,"Больше не вместится.");
		};
		if !callSelfParams(canLoadAmmoInMagazine,_ammo) exitWith {
			callFuncParams(_usr,localSay,"Не подходят патроны." arg "error");
		};

		if callFunc(_ammo,canDestack) then {
			callFuncParams(_ammo,destackItemToLoc,1 arg this arg _usr);
		} else {
			callFuncParams(_ammo,moveItem,this);
		};

		callSelfParams(playSound,callSelf(getLoadAmmoSound) arg rand(0.8,1.15) arg 5);
	};

	func(unloadAmmoFromMagazine)
	{
		objParams_1(_usr);
		if (callSelf(getAmmoCount)<=0) exitWith {
			callFuncParams(_usr,mindSay,"Пусто...");
		};
		private _itm = callSelf(getFirstAmmoInMagazine);
		if isNullReference(_itm) exitWith {};
		callFuncParams(_itm,moveItem,_usr);
		callSelfParams(playSound,callSelf(getUnloadAmmoSound) arg rand(0.8,1.15) arg 5);
	};

	getter_func(getAmmoCount,count getSelf(content));
	getter_func(getFirstAmmoInMagazine,ifcheck(callSelf(getAmmoCount)>0,getSelf(content) select (callSelf(getAmmoCount)-1),nullPtr));

	func(addContent)
	{
		objParams_1(_itm);
		setVar(_itm,loc,this);
		callSelfParams(addContentImpl,_itm);
		callSelf(onWeightChanged);
	};
	func(addContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) pushBack _itm;
	};
	func(removeContent)
	{
		objParams_1(_itm);
		callSelfParams(removeContentImpl,_itm);
		callSelf(onWeightChanged);
	};
	func(removeContentImpl)
	{
		objParams_1(_itm);
		getSelf(content) deleteAt (getSelf(content) find _itm);
	};
	/*func(getBulletsForShoot) //подготавливает массив пуль для выстрела
	{
		objParams_1(_count);
		private _curCount = callSelf(getAmmoCount);
		if (_curCount <= 0) exitWith {[]};
		private _content = getSelf(content);
		private _newCount = (_curCount - _count) max 0;
		private _ret = _content select [_newCount-1,_curCount];
		{
			callSelfParams(removeContent,_x); true
		} count _ret;
		_ret;
	};*/
	func(canMoveOutItem)
	{
		objParams_1(_item);
		_item in getSelf(content);
	};
	func(onMoveOutItem)
	{
		objParams_1(_item);
		callSelfParams(removeContent,_item);
	};
	func(canMoveInItem)
	{
		objParams_1(_item);
		isTypeOf(_item,IAmmoBase)
	};
	func(onMoveInItem)
	{
		objParams_1(_item);
		callSelfParams(addContent,_item);
	};

endclass


editor_attribute("InterfaceClass")
//Базовый патрон
class(IAmmoBase) extends(Stack)
	getterconst_func(getCaliber,"9мм");
	var(name,"Патрон");
	var(stackName,"Патроны");
	editor_attribute("EditorVisible" arg "type:int" arg "range:1:20")
	var(stackCount,1);
	var(stackMaxAmount,20);
	getter_func(canDisentegrate,true);
	getterconst_func(stackNames,vec3("Патрона","Патрона","Патронов"));
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(16.8)); //basic pistol ammo weight
	var(dr,4);
	var(model,"\A3\Weapons_f\ammo\cartridge_small.p3d");
	var(material,"MatMetal");
	getterconst_func(getProjectileModel,"\a3\Weapons_F\data\bullettracer\tracer_white.p3d");

	getter_func(getDropSound,vec2("guns\casingfall"+str randInt(1,3),getRandomPitchInRange(.85,1.3)));

	getterconst_func(isNonLethalAmmo,false);

	var(isFlyingFromWeapon,false); //летит из оружия. данный флаг активируется при броске предмета (выстреле)
	//модификаторы патронов
	var(additionalAccuracy,0);
	var(additionalDamage,0);

	var(shotedFrom,nullPtr);//выстрелено каким оружием
	var(shooter,nullPtr); //кто стрелял (для подсчета убийств)

	getterconst_func(getCasingType,"BulletCase"); //тип гильзы, оставляемой под персонажем.

	getter_func(getProjectileName,"Пуля"); //что попадает в цель

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr + "Калибр: " + callSelf(getCaliber);
	};

	//Вызывает эффекты повреждений от пули
	func(onDamageBulletProcess)
	{
		objParams_5(_targ,_dam,_type,_sel,_dir);
		callFuncParams(_targ,applyDamage,_dam arg _type arg _sel arg _dir);
	};

	func(destructor)
	{
		objParams();
		if !callSelf(isInWorld) then {
			if isNullReference(getSelf(loc)) exitWith {};
			if isTypeOf(getSelf(loc),IMagazineBase) then {
				callFuncParams(getSelf(loc),removeContent,this);
			};
		};
	};

	//есть баг с отсечением пути моделей патронов. это быстрый фикс чтобы видеть иконки
	func(constructor)
	{
		objParams();
		private _myIcon = getSelf(icon);
		if ([_myIcon,"+p3d"] call stringEndWith) then {
			setSelf(icon,_myIcon select [0 arg (count _myIcon)-4]);
		};
	};
endclass

class(BulletCase) extends(Stack)

	//!see IAmmoBase::constructor
	func(constructor)
	{
		objParams();
		private _myIcon = getSelf(icon);
		if ([_myIcon,"+p3d"] call stringEndWith) then {
			setSelf(icon,_myIcon select [0 arg (count _myIcon)-4]);
		};
	};

	getterconst_func(getCaliber,"9мм");
	var(name,"Гильза");
	var(stackName,"Гильзы");
	var(model,"\A3\Weapons_f\ammo\cartridge_small.p3d");
	var(material,"MatMetal");
	editor_attribute("EditorVisible" arg "type:int" arg "range:1:20")
	var(stackCount,1);
	var(stackMaxAmount,20);
	getter_func(canDisentegrate,true);
	getterconst_func(stackNames,vec3("Гильзы","Гильзы","Гильз"));
	var(size,ITEM_SIZE_TINY);
	var(weight,gramm(5.3));
	var(dr,4);
	getter_func(getDropSound,vec2("guns\casingfall"+str randInt(1,3),getRandomPitchInRange(.85,1.3)));
	var(shootedTime,0);
	func(getDescFor)
	{
		objParams_1(_usr);
		private _txt = super();
		if equals(getSelf(loc),_usr) then {
			if (getSelf(shootedTime)+(60*2)>= tickTime) exitWith {modvar(_txt) + sbr + "Она горячая. Недавно отстреляли."};
			if (getSelf(shootedTime)+(60*5)>= tickTime) exitWith {modvar(_txt) + sbr + "Она ещё теплая."};
		};
		modvar(_txt) + sbr + "Калибр: " + callSelf(getCaliber);
		_txt
	};
	/*var(isPickuped,false);
	func(onPickup)
	{
		objParams_1(_usr);
		super();
		if !getSelf(isPickuped) then {
			setSelf(isPickuped);
			callSelfParams(stopUpdateMethod,)
		};
	};*/
endclass

#ifdef EDITOR
	class(TestFullmag) extends(IMagazineBase)
		var(maxCount,1000);
		getterconst_func(initialAmmo,vec2("IAmmoBase",1000));
	endclass

	class(TestPistol) extends(PistolPBM)
		var(shootCount,1);
		getter_func(getReqST,15);
		func(constructor)
		{
			objParams();
			private _itm = new(TestFullmag);

			setVar(_itm,loc,this);
			setSelf(magazine,_itm);
			callSelf(onWeightChanged);
		};
	endclass
	
	class(TestRifle) extends(RifleAuto)
		func(constructor)
		{
			objParams();
			
			private _itm = callSelfParams(createMagazine,"MagazineAuto");
			setVar(_itm,maxCount,1000);
			callSelfParams(createAmmoInMagazine,"AmmoRifle" arg 1000);
			callSelf(onWeightChanged);
		};
	endclass
	
	class(TestShotgun) extends(Shotgun)
		func(constructor)
		{
			objParams();
			setVar(getSelf(magazine),maxCount,1000);
			callSelfParams(createAmmoInMagazine,"AmmoShotgun" arg 1000);
		};
	endclass
	
#endif

/*
	Ammo classes
	"\A3\Weapons_f\ammo\cartridge_small.p3d" - pistol
		"\A3\Weapons_f_enoch\ammo\cartridge_762x39.p3d" - pistol grey
	"\A3\Weapons_f\ammo\cartridge_slug.p3d" - shotgun
		"\A3\Weapons_F_Mark\Ammo\cartridge_127x54.p3d"
	"\A3\Weapons_f\ammo\cartridge_65.p3d" - automat
		"\A3\Weapons_F_Mark\Ammo\cartridge_93x64.p3d"
		"\A3\Weapons_F_Mark\Ammo\cartridge_338_LM.p3d"
	"\A3\Weapons_f\ammo\cartridge_127.p3d" - big rifle

	//traces
	"\a3\Weapons_F\data\bullettracer\tracer_white.p3d"
*/
