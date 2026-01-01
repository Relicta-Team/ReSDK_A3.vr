// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\text.hpp"
#include <..\GameConstants.hpp>
#include "..\..\PointerSystem\pointers.hpp"
#include "..\..\ServerRpc\serverRpc.hpp"
#include "..\..\..\client\Inventory\inventory.hpp"
#include <..\..\NOEngine\NOEngine.hpp>

#define DEBUG_TARG

editor_attribute("InterfaceClass")
editor_attribute("ColorClass" arg "44C242")
class(Item) extends(IDestructible) attribute(GenerateWeaponModule)
	"
		name:Предмет
		desc:Базовый игровой предмет
		path:Игровые объекты.Предметы
	" node_class

	getter_func(getAbstractName,"Предмет");

	//for example we can find pic by classname (arma): getText (configFile >> "cfgVehicles" >> "B_Respawn_Sleeping_bag_brown_F" >> "picture");
	editor_attribute("EditorVisible" arg "custom_provider:icon") editor_attribute("Tooltip" arg "Иконка предмета")
	var(icon,invicon(temp_item));
	editor_attribute("EditorVisible" arg "custom_provider:model") editor_attribute("Tooltip" arg "Модель предмета")
	var(model,"a3\structures_f_epa\items\food\canteen_f.p3d");
	getterconst_func(getChunkType,CHUNK_TYPE_ITEM);
	getter_func(isItem,true);

	getter_func(canApplyDamage,true);

	verbList("pickup twohands description3d",GameObject);
	editor_attribute("EditorVisible" arg "custom_provider:size") editor_attribute("Tooltip" arg "Размер предмета")
	var(size,ITEM_SIZE_TINY);//объём предмета

	
	var(loc,objNull); //локация объекта. Данное поле по соглашению публично только для чтения. Установка значения ТОЛЬКО через setLoc()
	editor_attribute("InternalImpl")
	var(slot,-1); //если loc==mob тогда slot айди слота инвентаря
	//проверяет находится ли предмет в слотах брони или одежды
	getter_func(isInSlot,array_exists(INV_LIST_TORSO + INV_LIST_FACE,getSelf(slot)));

	getterconst_func(isRadio,false);

	getter_func(isMovable,true);

	getterconst_func(canPickup,true); //можно ли поднять предмет
	editor_attribute("EditorVisible" arg "custom_provider:allowedSlots") editor_attribute("Tooltip" arg "В какие слоты может быть назначен предмет")
	var_array(allowedSlots);

	//Получение звуков
	getter_func(getPickupSound,"updown\clothUp");
	getter_func(getPutdownSound,"updown\clothDown");
	getter_func(getDropSound,vec2("dropping\smallfall",getRandomPitchInRange(.85,1.3)));
	getter_func(getEquipSound,"updown\clothUp");
	getter_func(getUnequipSound,"updown\clothUp");

	getter_func(getHandAnim,ITEM_HANDANIM_LOWERONLYHAND); //анимация в состоянии покоя
	getter_func(getCombAnim,ITEM_COMBATANIM_SHORT); //анимация в состоянии комбата
	getter_func(getTwoHandAnim,ITEM_2HANIM_LOWER); //Анимация двуручного хвата
	getter_func(getTwoHandCombAnim,ITEM_2HANIM_COMBAT_LOWER); //анимация двуручного хвата в боевом режиме

	//анимации защиты оружием
	getter_func(getParryAnim,pick [ITEM_PARRY_SWORD_1 arg ITEM_PARRY_SWORD_2]);
	getter_func(getTwoHandParryAnim,pick [ITEM_2HANIM_PARRY_SWORD_1 arg ITEM_2HANIM_PARRY_SWORD_2]);

	//последний владелец который брал предмет
	editor_attribute("InternalImpl")
	var(lastAttLoc,vec2(nullPtr,ATTACK_TYPE_SWING));
	getter_func(getLastTouched,getSelf(lastAttLoc) select 0); //кто последний трогал предмет
	getter_func(getAttacksTypeAssoc,ATTACK_TYPE_ASSOC_SWING_ONLY);

	//проигрывает звук из категории
	func(playEventSound)
	{
		params ['this',"_category",["_pitch",getRandomPitch],["_maxDist",50],["_vol",1]];
		FHEADER;
		//для подавления при воровстве
		if !isNullVar(__SUPPRESS_PLAYEVENTSOUND__) exitWith {};
		if !callSelf(isInWorld) then {
			private _loc = getSelf(loc);
			if callFunc(_loc,isMob) then {
				if equals(getVar(_loc,specialAction),SPECIAL_ACTION_STEAL) then {
					RETURN(false);
				};
			};
		};

		if (!(tolower _category in ["pickup","putdown","drop","equip","unequip"])) exitWith {
			errorformat("Cant play eventsound: category %1 not found",_category);
		};

		private _soundName = null;

		private _snd = callSelfReflect("get"+_category+"sound");
		//Для мультипараметров
		if equalTypes(_snd,[]) then {
			#ifdef SP_MODE
			private _md = null;
			private _lv = null;
			private _p = null;
			#endif
			_snd params ["_s",["_p",null],["_md",null],["_vl",null]];
			callSelfParams(playSound, _s arg _p arg _md arg _vl); //parametrize called
		} else {
			callSelfParams(playSound, _snd arg _pitch arg _maxDist arg _vol);
		};


		//callSelf(__debug_checkLoc);
	};

	//TODO предлагаю инициализировать быстрые свойства через парсинг строки, прим:
	//getterconst_func(customWeaponModuleData,"dmgbonus:+3; canparry:WEAPON_PARRY_ENABLE");
	getter_func(getGeneratedWeaponModule,weaponModule(WeapHandyItem)); //системный метод для атрибута GenerateWeaponModule
	func(constructor)
	{
		objParams();
		if equals(getSelf(attachedWeap),weaponModule(WeapHandyItem)) then {
			setSelf(attachedWeap,callSelf(getGeneratedWeaponModule));
		};
		private _m = getSelf(model);
		//сначала проверяем если это конфиг модель то получаем путь до модели
		if (!(".p3d" in _m) && !("\" in _m)) then {
			_m = core_cfg2model getVariable _m;
		};
		
		//на всякий случай ассертим путь
		#ifdef EDITOR
		if (isNullVar(_m) || {not_equalTypes(_m,"")}) exitWith {
			errorformat("Constructor error; Cant find model for %1; Model was %2 [%3]",this arg _m arg getSelf(model));
			appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
		};
		#endif
		
		//если в пути модели есть \ - убираем
		if ((_m select [0,1]) == "\") then {
			_m = _m select [1,count _m];
		};
		
		setSelf(icon,"gen\"+(_m splitString "\/." joinString "+"));
		
		// private _bbx = core_modelBBX get _m;
		// if isNullVar(_bbx) exitWith {
		// 	/////errorformat("Cant get bbx by model path %1",_m);
		// };
		// setSelf(size,_bbx call generateItemSize);
		// #ifdef EDITOR
		// 	setSelf(bbx,_bbx);
		// #endif
	};

	//процедура синхронизации иконки
	func(syncIcon)
	{
		objParams();
		//copypaste... bruh...
		private _m = getSelf(model);
		//сначала проверяем если это конфиг модель то получаем путь до модели
		if (!(".p3d" in _m) && !("\" in _m)) then {
			_m = core_cfg2model getVariable _m;
		};
		
		//на всякий случай ассертим путь
		#ifdef EDITOR
		if (isNullVar(_m) || {not_equalTypes(_m,"")}) exitWith {
			errorformat("%1 %2 %3",this arg _m arg getSelf(model));
			appExit(APPEXIT_REASON_COMPILATIOEXCEPTION);
		};
		#endif
		
		//если в пути модели есть \ - убираем
		if ((_m select [0,1]) == "\") then {
			_m = _m select [1,count _m];
		};
		
		setSelf(icon,"gen\"+(_m splitString "\/." joinString "+"));
	};

	generateItemSize = {
		params ["_bmin","_bmax","_radius"];
		//_bmin,_bmax - массив vec3; выбрать элемент массива так: _bmin select 0 - вернет ось X
		//Индексация X - 0, Y - 1, Z - 2
		
		//Временная заглушка - сейчас просто берется диаметр объекта и на его основе высчитывается размер
		//linearConversion [minFrom, maxFrom, value, minTo, maxTo, clip]
		//Убираешь этот алгоритм и делаешь свой. Оптимизация процесса на мне
		private _vol = ((_bmax select 0) - (_bmin select 0)) * ((_bmax select 1) - (_bmin select 1)) * ((_bmax select 2) - (_bmin select 2));

		#ifdef EDITOR
			setSelf(volume,_vol);
		#endif

		private _vlinear = _vol^(1/3);
		private _addFromRadius = 0;
		if(_vlinear > .1 && _radius / _vlinear > 2) then {_addFromRadius = 1;};
		//round linearConversion [0,.5,_vol^(1/3),ITEM_SIZE_TINY,ITEM_SIZE_HUGE,true];
		if (_vlinear < .05) exitWith {ITEM_SIZE_TINY + _addFromRadius};
		if (_vlinear < .17) exitWith {ITEM_SIZE_SMALL + _addFromRadius};
		if (_vlinear < .4)  exitWith {ITEM_SIZE_MEDIUM + _addFromRadius};
		if (_vlinear < .55) exitWith {ITEM_SIZE_LARGE + _addFromRadius};
		if (_vlinear < .7)  exitWith {ITEM_SIZE_BIG + _addFromRadius};
		ITEM_SIZE_HUGE
	};
	#ifdef EDITOR
	generateItemInfoList = {
		private _data = [];
		private _sizeConst = ["ITEM_SIZE_TINY","ITEM_SIZE_SMALL","ITEM_SIZE_MEDIUM","ITEM_SIZE_LARGE","ITEM_SIZE_BIG","ITEM_SIZE_HUGE"];
		_getPathinfo = {
			params [["_file","unknown_file"],["_line",0]];
			format["file: %1 at line %2",SHORT_PATH_CUSTOM(_file),_line]
		};
		{
			private _class = _x;
			traceformat("Process class %1",_class);
			private _w = getFieldBaseValue(_class,"weight");
			private _nargs = [null,null,null,null,null,null,null];
			private _obj = instantiateParams(_class,_nargs);
			assert_str(!isNullReference(_obj),"Null ref " + _class);
			private _size = getVar(_obj,size);
			assert_str(!isNullVar(_size) && {inRange(_size,ITEM_SIZE_TINY,ITEM_SIZE_HUGE)},"cant define size for " + _size);
			private _name = getVar(_obj,name);
			
			_data pushBack (format["%1 (%2)::%3"+
				"%4decl: %5%3"+
				"%4size: %6 (%7) (const: %8)%3"+
				"%4weight: %9 kg (const:%10)",
				_class, _name,endl,toString[9],
				(typeGetFromObject(_obj) getvariable "__decl_info__") call _getPathinfo,
				_sizeConst select (_size-1),_size,([_class,"size",false] call oop_getFieldBaseValue),
				_w,([_class,"weight",false] call oop_getFieldBaseValue)
			]);
		} foreach getAllObjectsTypeOf(Item);

		copytoclipboard (_data joinString endl)
	};
	#endif

	func(destructor)
	{
		objParams();
		private _loc = getSelf(loc);
		if callSelf(isInWorld) then {
			callSelf(unloadModel);
		};
		if !isNullObject(_loc) then {
			if callFunc(_loc,isMob) exitWith {
				if (getSelf(slot) != -1) then {
					callFuncParams(_loc,removeItem, this arg objnull);
				};
			};
			if callFunc(_loc,isContainer) exitWith {
				callFuncParams(_loc,removeItem, this arg objnull)
			};
		};
	};
	
	//инверсирует вызов onInteractWith. Если взаимодействовать с предметом у которого установлен этот флаг то вызывается метод интеракции с игрового объекта
	getterconst_func(isRedirectedInteractWith,false);
	//Флаг указывает можно ли взаимодействовать с другой целью (сущность)
	getterconst_func(canUseInteractToMethod,false);
	
	//основной метод взаимодействия с целью. вызывается из Mob::onInteractWith()
	func(interactTo)
	{
		objParams_2(_target,_usr);
	};
	
	//Может ли предмет быть помещён в данный слот
	// Метод внутренний и не для открытого пользования.
	// Если нужно ограничить логику возможности установки - юзай canPickup,..
	func(canSetToSlot) {
		objParams_1(_slot);
		if equalTypes(_slot,"") then {
			private _slotInd = INV_LIST_VARNAME find _slot;
			if (_slotInd != -1) then {
				_slot = INV_LIST_VARNAME select _slotInd;
			};
		};
		if (_slot in INV_LIST_HANDS) exitWith {true};

		_slot in getSelf(allowedSlots)
	};

	func(onClick)
	{
		objParams_1(_usr);
		callFuncParams(_usr,pickupItem,this);
	};

	func(onPickup)
	{
		objParams_1(_usr);

		callSelfParams(playEventSound, "pickup");
	};
	//Вызывается при невозможности поднять предмет
	func(onCantPickup)
	{
		objParams_1(_usr);
	};

	func(onPutdown)
	{
		objParams_1(_usr);
		callSelf(updateGerms);
		if equals(getVar(_usr,specialAction),SPECIAL_ACTION_STEAL) exitWith {};
		callSelfParams(playEventSound, "putdown");
	};

	func(onEquip) {
		objParams_1(_usr);
		callSelfParams(playEventSound, "equip");
	};

	func(onUnequip) {
		objParams_1(_usr);
		callSelfParams(playEventSound, "unequip");
	};
	editor_attribute("ReadOnly")
	var(attachedWeap,weaponModule(WeapHandyItem)); //нод драки предметом
	editor_attribute("ReadOnly")
	var(slotedWeap,nullPtr); //нод атаки частью тела (кусать, кулак, пинок)

	func(getItemWeapon)
	{
		objParams();
		private _weapNode = getSelf(attachedWeap);
		if isNullVar(_weapNode) exitWith {nullPtr};
		_weapNode
	};
	//Получает активный нод части, которая будет проводить атаку
	func(getItemWeaponAsPartDamager)
	{
		objParams();
		private _weapNode = getSelf(slotedWeap);
		if isNullVar(_weapNode) exitWith {nullPtr};
		_weapNode
	};

	//Установка оружейного свойства. Копирует модуль если он не уникален
	func(setWeaponProperty)
	{
		params ['this',"_name","_val",["_asPartDamager",false]];
		private _fieldName = ifcheck(_asPartDamager,"slotedWeap","attachedWeap");
		private _obj = getSelfReflect(_fieldName);
		if isNullReference(_obj) exitWith {false};
		if getVar(_obj,isCommon) then {
			_obj = callFunc(_obj,Copy);
			setSelfReflect(_fieldName,_obj);
		};
		#ifdef DEBUG
		if !isImplementVarStr(_obj,_name) then {
			warningformat("%1->%2::getWeaponProperty<%3> - Property not implemented",callSelf(getClassName) arg _fieldName arg _name);
		};
		#endif
		setVarReflect(_obj,_name,_val);
	};
	//Получение оружейного свойства
	func(getWeaponProperty)
	{
		params ['this',"_name","_retDef",["_asPartDamager",false]];
		private _fieldName = ifcheck(_asPartDamager,"slotedWeap","attachedWeap");
		private _ret = getSelfReflect(_fieldName);
		if isNullReference(_ret) exitWith {_retDef};
		#ifdef DEBUG
		if !isImplementVarStr(_ret,_name) then {
			warningformat("%1->%2::getWeaponProperty<%3> - Property not implemented",callSelf(getClassName) arg _fieldName arg _name);
		};
		#endif
		_retDef = getVarReflect(_ret,_name);
		if isNullVar(_ret) then {
			_retDef
		} else {
			_ret
		};
	};

	//вызывается после атаки когда предметом атаковали сущность
	//например здесь предмет может получить повреждения или вовсе разрушится
	func(onAttackedMob)
	{
		objParams_4(_mob,_bodyPart,_damageType,_woundSize);
	};

	//вызывается при атаке объекта
	func(onAttackedObj)
	{
		objParams_2(_obj,_damage);
	};

	//Поскольку нам нужно оттестить что метод всегда отрабатывает добавляем тестовое поле локации
	//var(__debug_onchangeloc,objNull);
	//var(__debug_lastslot,-1);
	//Для данного метода существует правило:
	//Если текущая локация nullPtr, null или objNull то действия должны быть отброшены
	//TODO данный метод должен принимать параметр старой локации. Сам метод вызывается когда loc уже принял новое значение.
	func(onChangeLoc) {
		objParams();
		//setSelf(__debug_onchangeloc,getSelf(loc));
		//setSelf(__debug_lastslot,getSelf(slot));
	};

	//TODO найти все прямые установки и заменить на установку через метод
	//подстроки для поиска:
	// ,loc,
	// (loc,
	func(setLoc)
	{
		objParams_1(_newLoc);
		private _isChanged = not_equals(_newLoc,getSelf(loc));
		setSelf(loc,_newLoc);
		if (_isChanged) then {
			callSelf(onChangeLoc);
		};
	};

	/*func(__debug_checkLoc)
	{
		objParams();
		if not_equals(getSelf(__debug_onchangeloc),getSelf(loc)) then {
			error("LOCATION NOT EQUALITY:");
			errorformat("	loc old %1; loc new %2",getSelf(__debug_onchangeloc) arg getSelf(loc));
			errorformat("	slot old %1; slot new %2",getSelf(__debug_lastslot) arg getSelf(slot));
			appExit(APPEXIT_REASON_CRITICAL);
		} else {
			log("location check success");
		};
	};*/

	//Специальный метод для перемещения предмета в локацию
	//Для корректной работы должны быть определены методы:
	// this.loc.onMoveOutItem(this,_newlocation) -> bool
	// _newlocation.onMoveInItem(this)
	func(moveItem)
	{
		objParams_1(_newlocation);
		private _loc = getSelf(loc);
		if (isNullObject(_loc) || equalTypes(_loc,objNull)) exitWith {
			errorformat("Item.moveItem() - source object location error. Loc:%1 (as %2)",_loc arg typename _loc);
			false
		};
		if (isNullObject(_newlocation) || equalTypes(_newlocation,objNull)) exitWith {
			errorformat("Item.moveItem() - destination object location error. Loc:%1 (as %2)",_loc arg typename _loc);
			false
		};
		if !callFuncParams(_loc,canMoveOutItem,this) exitWith {false};
		if !callFuncParams(_newlocation,canMoveInItem,this) exitWith {false};

		if callFunc(_newlocation,isMob) then {
			//transfer item in mob
			traceformat("transfer item to mob %1",vec3(this,_loc,_newlocation))
			callFuncParams(_newlocation,interpolate,"auto_trans" arg this arg _newlocation);
		} else {
			//transfer item from mob
			if callFunc(_loc,isMob) then {
				traceformat("transfer item from mob %1",vec3(this,_loc,_newlocation))
				callFuncParams(_loc,interpolate,"auto_trans" arg this arg _newlocation);
			};
		};

		callFuncParams(_loc,onMoveOutItem,this);
		callFuncParams(_newlocation,onMoveInItem,this);
		true
	};

	func(dropItemToWorld)
	{
		params ['this',"_vMobOrPos","_rad","_dir",["_usr",nullPtr],["_supressThrowErrLoc",false]];
		private _loc = getSelf(loc);
		if ((isNullObject(_loc) || equalTypes(_loc,objNull)) && !_supressThrowErrLoc) exitWith {
			errorformat("Item.dropItemToWorld() - source object location error. Loc:%1 (as %2)",_loc arg typename _loc);
			false
		};
		if (!_supressThrowErrLoc && {!callFuncParams(_loc,canMoveOutItem,this)}) exitWith {false};
		
		if isTypeOf(_loc,Mob) then {
			callFuncParams(_loc,interpolate,"auto_trans" arg this arg getVar(this,pointer));
		};

		if (!_supressThrowErrLoc) then {
			callFuncParams(_loc,onMoveOutItem,this);
		};
		//params ["_vObj","_vMobOrPos",["_dropRad",DROP_RADIUS],["_goDir",random 360],["_isSafePutdown",false]];
		private _wobj = [this,_vMobOrPos,_rad,_dir,false] call noe_loadVisualObject_OnDrop;
		setVar(this,loc,_wobj);
		callFunc(this,onChangeLoc);
		callFuncParams(this,onDrop, _usr);
		true
	};

	"
		name:В контейнере
		desc:Возвращает @[bool ИСТИНУ], если предмет находится в контейнере.
		type:get
		lockoverride:1
		return:bool:Находится ли предмет в контейнере.
	" node_met
	func(isInContainer)
	{
		objParams();
		private _loc = getSelf(loc);
		if equalTypes(_loc,nullPtr) exitWith {
			callFunc(_loc,isContainer)
		};
		false
	};

	//Когда предмет падает на землю, _isDropFromFly - флаг указывающий что предмет падает из полета
	func(onDrop)
	{
		objParams_2(_usr,_isDropFromFly);
		callSelf(updateGerms);
		callSelfParams(playEventSound, "drop");
		//errorformat("USER IS DROPPING ITEM %1",callSelf(getName));
	};

	func(GetItemInfoForClient)
	{
		objParams();

		[
		callSelf(getName),
		callSelf(getIcon),
		getSelf(pointer),
		getSelf(model)
		]
	};

	getter_func(GetItemInfoInContainer,[callSelf(getName) arg callSelf(getIcon) arg getSelf(pointer)]); //собирает инфу итема из контейнера для клиента (исключает сбор модели)

	func(getIcon)
	{
		objParams();
		getSelf(icon)
	};

	//NoEngine visual object instancer
	//var(loc,objNUll); //референс на серверный объект. Если он objNull то объект не существует
	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		_vObj = createMesh([getSelf(model) arg [0 arg 0 arg 0] arg true]);
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_true;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		//генерируем данные объекта
		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};


	//Производит симуляцию физики объекта. Вызывается перед удалением модели
	func(simulatePhysics)
	{
		objParams();

		private _srcObject = getSelf(loc);
		if not_equalTypes(_srcObject,objNULL) exitWith {
			errorformat("%1.loc is not type of rvobject - type: %2, value %3",callSelf(getClassName) arg typename _srcObject arg _srcObject);
		};
		if equals(_srcObject,objNULL) exitWith {
			errorformat("%1.loc is null type of rvobject",callSelf(getClassName));
		};

		[_srcObject ] call simulatePhysicsOnVisualObject;
	};

	//различные физические параметры
	getter_func(thCanStuck,false); //предмет может застрять в стене или персонаже при бросании
	func(thGetDamageData) //получает данные повреждений предмета при броске
	{
		objParams_1(_mob);
		private _w = callSelf(getWeight)/0.5;
		private _bl = callFunc(_mob,getBL);
		private _damArr = callFuncParams(_mob,getDmgByAttackType,ATTACK_TYPE_THRUST);
		private _dices = _damArr select 0;
		private _mod = _damArr select 1;
		call {
			if (_w <= (_bl/8)) exitWith {
				modvar(_mod) - (_dices * 2);
			};
			if (_w <= (_bl/4)) exitWith {
				modvar(_mod) - (_dices * 1);
			};
			if (_w <= (_bl/2)) exitWith {

			};
			if (_w <= _bl) exitWith {
				modvar(_mod) + (_dices * 1);
			};
			if (_w <= (_bl*2)) exitWith {

			};
			if (_w <= (_bl*4)) exitWith {
				modvar(_mod) - floor(_dices * 0.5);
			};
			if (_w <= (_bl*8)) exitWith {
				modvar(_mod) - (_dices * 1);
			};
		};
		//["_dam","_type","_selection","_usr"];
		[(_dices call gurps_throwdices) + _mod,DAMAGE_TYPE_CRUSHING,getVar(_mob,curTargZone),_mob];
	};
	//TODO может ли быть выложен предмет по нормали


	//Удаляет этот игровой объект и создаёт новый
	func(replaceWith)
	{
		params ['this',"_class",["_delPrev",true]];
		if callSelf(isInWorld) then {
			private _pos = getPosATL callSelf(getBasicLoc);
			if (_delPrev) then {
				delete(this);
			};
			[_class,_pos,null,false] call createItemInWorld;
		} else {
			private _loc = getSelf(loc);
			private _slot = getSelf(slot);
			if (_delPrev) then {
				delete(this);
			};
			[_class,_loc,_slot] call createItemInInventory;
		};
	};

	//Функция когда слишком далеко до цели. Может быть переопределено под свои нужды позднее
	func(onLongDistanceAttack)
	{
		objParams_2(_usr,_targ);

		callFuncParams(_usr,meSay,"размахивает " + callSelfParams(getNameFor,_usr));
	};

	func(canSetAttackType)
	{
		objParams_1(_newType);
		private _hashList = hashSet_toArray(getVar(callFunc(this,getItemWeapon),attackType));
		array_exists(_hashList,_newType)
	};

	func(onSetAttackType)
	{
		objParams_2(_newType,_usr);
		getVar(this,lastAttLoc) set [1,_newType];
		setVar(_usr,curAttackType,_newType);
	};

	//Вызывается при невозможности установки нового типа атаки
	func(onCantSetAttackType)
	{
		objParams_1(_usr);
		callFuncParams(_usr,localSay,"Так нельзя." arg "error");
	};


	//объект лежит на земле - надо добавить микробов на поверхность, в которой он лежит
	func(updateGerms)
	{
		objParams();
		private _p = callSelf(getObjectPlace);
		callSelfParams(updateGermsAt,_p);
	};

	func(updateGermsAt)
	{
		objParams_1(_p);
		traceformat("germ update process: this: %1, p: %2",callSelf(getClassName) arg _p);
		if isNullVar(_p) exitWith {
			errorformat("cannot update germs on class %2 - null object %1",_p arg callSelf(getClassName));
		};
		if isNullReference(_p) exitWith {};
		if isTypeOf(_p,BasicMob) exitWith {};
		private _germHis = getVar(_p,germs);
		private _germsMe = getSelf(germs);
		// отдается только половина от микробов источника
		private _newMe = clamp(_germsMe + floor(_germHis * 0.25),0,GERM_COUNT_MAX);
		private _newHim = clamp(_germHis + floor(_germsMe * 0.15),0,GERM_COUNT_MAX);
		callSelfParams(setGerms,_newMe);
		callFuncParams(_p,setGerms,_newHim);
	};

	//examine3d
	getterconst_func(getExamine3dItemType,"obj"); //one of "obj","cloth","armor","backpack","mask","helmet"
	
	func(getExamine3dItemModel)
	{
		objParams();
		private _etype = callSelf(getExamine3dItemType);
		
		//проверка корректности типа
		if !array_exists(["obj" arg "cloth" arg "armor" arg "backpack" arg "mask" arg "helmet"],_etype) exitWith {
			"" //в любом случае на клиенте обработается неверный тип формы
		};
		if equals(_etype,"obj") exitWith {getSelf(model)};
		getSelf(armaClass)
		
	};
	func(examine3dItem)
	{
		objParams_1(_usr);
		private _dynDisp = getVar(_usr,_internalDynamicND);

		private _getInfo = {
			private _ctx = getSelf(context);

			[
				callFunc(_ctx,getExamine3dItemModel)
				,format["%1",getVar(_ctx,name)]
				,callFunc(_ctx,getExamine3dItemType)
			]
		};
		private _handleInp = { objParams_2(_usr,_inp); };
		private _ctx = this;
		private _dist = callFuncParams(_usr,getDistanceTo,this) + 0.5;
		callFuncParams(_dynDisp,setNDOptions,"Examine3d" arg _dist arg getSelf(pointer) arg _getInfo arg _handleInp arg _ctx);
		
		callFuncParams(_dynDisp,openNDisplayInternal,_usr arg getVar(_usr,owner));
		
		//starting netdisplay handler (because opened as internal (usr is checked target))
		private _ctxParams = [this,_usr,_dynDisp,getSelf(loc)];
		startAsyncInvoke
		{
			params ["_item","_usr","_dynDisp","_curLoc"];
			private _maxDist = getVar(_dynDisp,ndInteractDistance);
			//already closed from clientside
			if (count getVar(_dynDisp,ndOpenedBy) == 0) exitWith {true};
			_state = false;
			call {
				if isNullReference(_item) exitWith {_state = true};
				//localtion changed
				if not_equals(_curLoc,getVar(_item,loc)) exitWith {_state = true};
				//too far
				if (callFuncParams(_usr,getDistanceTo,_item) > _maxDist) exitWith {_state = true};
			};
			if (_state) then {
				if (count getVar(_dynDisp,ndOpenedBy) > 0) then {
					callFuncParams(_dynDisp,closeNDisplayServer,_usr);
				};
			};
			_state
		},{}, //in action block do nothing
		_ctxParams
		endAsyncInvoke
	};

endclass


class(ItemRadio) extends(Item)
	var(name,"Радио");

	var(model,"a3\structures_f\items\electronics\portablelongrangeradio_f.p3d");
	var(weight,gramm(400));
	var(size,ITEM_SIZE_SMALL);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);

	getterconst_func(isRadio,true);
	var(radioIsEnabled,true);

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + sbr + ifcheck(getSelf(radioIsEnabled),"Лампочка горит","Лампочка не горит");
	};

	var(radioSettings,[10 arg "radio_enc_def" arg 1 arg 5 arg null arg 150]);
	var(radioType,RADIO_TYPE_WALKIETALKIE);

	func(InitModel)
	{
		objParams_3(_pos,_dir,_vec);

		//private _o = callSuper(Item,InitModel);

		_vObj = createMesh([getSelf(model) arg [0 arg 0 arg 0] arg true]);
		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		_vobj hideObject true;
		#endif
		_headerT = simpleObj_true;

		if (count _pos == 4) then {
			_vObj setPosWorld (_pos select [0,3]);
			_vObj setvariable ["wpos",true];
			MOD(_headerT,+wposObj_true);
		} else {
			_vObj setPosAtl _pos;
			MOD(_headerT,+wposObj_false);
		};
		if equalTypes(_dir,0) then {
			_vObj setDir _dir;
			_vObj setVectorUp _vec;
			MOD(_headerT,+vDirObj_false);
		} else {
			_vObj setVectorDirAndUp [_dir,_vec];
			_vObj setvariable ["vdir",true];
			MOD(_headerT,+vDirObj_true);
		};

		if getSelf(radioIsEnabled) then {
			_vObj setVariable ["radio",callSelf(getRadioData)];
			MOD(_headerT,+radioObj_true);
		};

		//mapping objects
		setSelf(loc,_vObj);
		_vObj setVariable ["link",this];
		//проверяем ngo
		[_vObj,getSelf(model)] call noe_server_ngo_check;

		//хедер
		_vObj setvariable ["flags",_headerT];

		[_vObj] call noe_updateObjectByteArr;

		_vObj
	};

	func(onMainAction)
	{
		objParams_1(_usr);
		callSelfParams(radioItemSetMode,!getSelf(radioIsEnabled));
	};
	getter_func(getMainActionName,ifcheck(getSelf(radioIsEnabled),"Выключить","Включить"));

	func(radioItemSetMode)
	{
		objParams_1(_mode);
		private _isEnabled = getSelf(radioIsEnabled);
		if (_isEnabled == _mode) exitWith {false;};
		setSelf(radioIsEnabled,_mode);
		
		private _vObj = getSelf(loc); //mesh or mob
		if callSelf(isInWorld) then {
		
			if (!_mode) then {
				//_vObj setVariable ["radio",null];
				//_vObj setvariable ["flags",0.1];
				[_vObj,false] call noe_updateObjectRadio;
			} else {
				_vObj setVariable ["radio",callSelf(getRadioData)];
				[_vObj,true] call noe_updateObjectRadio;
			};
			
			[_vObj,CHUNK_TYPE_ITEM,true] call noe_replicateObject;
		} else {
			private _slot = getSelf(slot);
			if (_slot >= 0) then {
				callFuncParams(_vObj,syncSmdSlot,_slot);
			};
		};

		callSelfParams(playSound, "electronics\click" arg getRandomPitch arg 3);

		true;
	};


	#include "..\Interfaces\IRadio.Interface"

endclass

editor_attribute("HiddenClass")
//интерфейс. не должен быть создан
class(SystemItem) extends(Item)
	var(weight,0);//нет веса у системного предмета

	//rewriteSystemItem
	//and other interaction
endclass

editor_attribute("HiddenClass")
class(StolenItem) extends(Item)
	//TODO: stolen items memory leaks
	var(suppressDelete,true);

	func(copyDataFrom)
	{
		objParams_1(_item);
		#define copyProp(name) setSelf(name,getVar(_item,name))
		copyProp(name);
		copyProp(desc);
		copyProp(weight);
		copyProp(size);
		copyProp(model);
		copyProp(icon);
		//copyProp(loc);
		//copyProp(slot);
	};

	func(onStolen)
	{
		objParams_1(_usr);

		if getSelf(suppressDelete) exitWith {};
		if isNullReference(this) exitWith {};

		private _deleg_steal = {
			params ["_usr"];
			if prob(25) then {
				callFuncParams(_usr,playSoundLocal,"UNCATEGORIZED\spizdil" arg getRandomPitchInRange(0.9,1.1));
				callFuncParams(_usr,localSay,"<t color='#ff0000' size='1.5'>СПИЗДИЛИ!</t>");
			} else {
				callFuncParams(_usr,playSoundLocal,"UNCATEGORIZED\steal" arg getRandomPitchInRange(0.8,1.3));
				private _t = pick ["Украли...","Своровали...","Спёрли!..","Пропало!!!","Нету...","Исчезло..."];
				callFuncParams(_usr,localSay,"<t color='#ff0000' size='1.4'>"+_t+"</t>");
			};
		};

		if isNullVar(_usr) then {
			private _oldLoc = getSelf(loc);
			if !callSelf(isInWorld) then {
				if callFunc(_oldLoc,isMob) then {
					[_oldLoc] call _deleg_steal;
				};
			};
		} else {
			[_usr] call _deleg_steal;
		};

		//sound/lfwbsounds/stolen.ogg
		delete(this);
	};

	func(onClick)
	{
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
		"..."
	};

	func(onPickup)
	{
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};
	//Вызывается при невозможности поднять предмет
	func(onCantPickup)
	{
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};

	func(onPutdown)
	{
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};

	func(onDrop)
	{
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};

	func(onEquip) {
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};

	func(onUnequip) {
		objParams_1(_usr);
		callSelfParams(onStolen,_usr);
	};

	func(onChangeLoc) {
		objParams();
		callSelfParams(onStolen,null);
	};

	func(playEventSound)
	{
		super();
		callSelfParams(onStolen,null);
	};


endclass

//system hands
/*
	Данный класс служит для системы хватания предметов и существ.
	Методы выбрасывания этих предметов не выбрасывают предмет фактически а лишь вызывают перегрузку onDrop
	Хватание как процесс:
		1. чел проделывает дейсвтия начинается подкапотная возня
		2. устанавливаем в пустой слот наш объект системного предмета
		3. синхронизируем сетевой инвентарь

*/
editor_attribute("HiddenClass")
class(SystemHandItem) extends(SystemItem)
	getter_func(getName,ifcheck(isNullReference(getSelf(object)),"Схвачено",callFuncParams(getSelf(object),getNameFor,getSelf(loc))));
	func(getHandAnim) //todo новая анимация хватания
	{
		objParams();
		private _mode = getSelf(mode);
		call {
			if (_mode == "grab") exitWith {ITEM_HANDANIM_TORCH};
			if (_mode == "twohand") exitWith {callFunc(getSelf(object),getHandAnim)};
			ITEM_HANDANIM_TORCH
		};
	};
	func(getTwoHandAnim)
	{
		objParams();
		private _mode = getSelf(mode);
		call {
			if (_mode == "grab") exitWith {super()};
			if (_mode == "twohand") exitWith {callFunc(getSelf(object),getTwoHandAnim)};
			ITEM_HANDANIM_TORCH
		};
	};

	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");
	getter_func(rewriteSystemItem,getSelf(object));
	var(object,nullPtr);//объект который тащится этой рукой
	var(part,null); //часть тела, за которую схвачен (только если существо)
	var(side,0);
	var(mode,"none"); //none - нет, grab - объект, человек, twohand - двуручное (object предмет во второй руке)

	getter_func(canApplyDamage,false);

	func(constructor)
	{
		objParams();
		setSelf(loc,ctxParams select 0);
		setSelf(side,ctxParams select 1);
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		if isNullReference(getSelf(object)) exitWith {"Тут ничего нет."};
		callFuncParams(getSelf(object),getDescFor,_usr);
	};

	getter_func(isGrabProcess,!isNullReference(getSelf(object)) && equals(getSelf(mode),"grab"));
	getter_func(isTwoHandedProcess,!isNullReference(getSelf(object)) && equals(getSelf(mode),"twohand"));

	func(startGrab)
	{
		objParams_2(_obj,_slotTo);

		if isNullVar(_slotTo) then {_slotTo = getVar(getSelf(loc),activeHand)};

		private _grabIsBlocked = false; //true запретит граб
		private _worldObj = objnull;
		private _usrObj = getVar(getSelf(loc),owner);
		private _relDir = [0,0,1];
		private _sidePos = ifcheck(getSelf(side)==SIDE_LEFT,vec3(-0.3,0.8,0),vec3(0.3,0.8,0));
		private _canReattach = true;
		private _isMob = callFunc(_obj,isMob);
		private _itemDragModename = "grab";//todo -> ifcheck(_isMob,"grab","pull");

		if (_isMob) then {
			
			//если его хочет грабнуть кто-то другой то ...
			//точнее если владелец
			private _grabber = getVar(_obj,grabber);
			if (!isNullReference(_grabber) && not_equals(getSelf(loc),_grabber)) exitWith {
				callFuncParams(getSelf(loc),localSay,getVar(getVar(_obj,gender),Его) + " уже держат." arg "error");
				_grabIsBlocked = true;
			};

			_canReattach = isNullReference(_grabber);

			_worldObj = getVar(_obj,owner);
			private _tz = getVar(getSelf(loc),curTargZone);

			private _isEye = array_exists(vec2(TARGET_ZONE_EYE_R,TARGET_ZONE_EYE_L),_tz);

			private _bp = [_tz] call gurps_convertTargetZoneToBodyPart;
			if (!callFuncParams(_obj,hasPart,_bp) || _isEye) exitWith {
				_grabIsBlocked = true;
				private _m = if (_isEye) then {
					"За глаз-то не ухватишься."
				} else {
					"Цель не имеет такой части тела."
				};
				callFuncParams(getSelf(loc),localSay,_m arg "error");
			};
			
			if callFunc(_obj,isConnected) then {
				callFunc(_obj,disconnectFromSeat);
			};
			
			setSelf(object,_obj);

			//только если первый аттачинг
			if (_canReattach) then {
				//вес объекта вкладываем в руку
				setSelf(weight,getVar(_obj,weight));
			} else {
				setSelf(weight,0)
			};


			setVar(_obj,grabber,getSelf(loc));

			setSelf(attachedWeap,weaponModule(WeapGrabbedHuman));
			_relDir = _usrObj vectorWorldToModelVisual vectorDirVisual _worldObj;

			setSelf(part,_tz);

			callFuncParams(getSelf(object),syncSmdVar,"isGrabbed" arg true);

			private _m = format["хватает %1 %2",[_tz,TARGET_ZONE_NAME_WHAT] call gurps_convertTargetZoneToString,callFuncParams(_obj,getNameEx,"кого")];
			callFuncParams(getSelf(loc),meSay,_m);

			callFuncParams(getSelf(loc),fastSendInfo,"cd_sp_grabbingMob" arg true);
			callFuncParams(getSelf(loc),sendInfo,"spr_sync" arg []);

		} else {
			//checks
			//!temporary
			if !isNullReference(callFunc(_obj,getPullMainOwner)) exitWith {
				_grabIsBlocked = true;
			};
			//уже тащит что-то
			if callFunc(getSelf(loc),isGrabAny) exitWith {
				_grabIsBlocked = true;
			}; 
			if !callFuncParams(_obj,canStartPull,getSelf(loc)) exitWith {
				_grabIsBlocked = true;	
			};
				

			//non-mob
			setSelf(object,_obj);
			setSelf(weight,getVar(_obj,weight));//set weight for object
			_worldObj = getVar(_obj,loc);
			setSelf(attachedWeap,weaponModule(WeapHandyItem)); //todo change 
			_canReattach = false;
		};

		if (_grabIsBlocked) exitWith {};

		if (_canReattach) then {
			_worldObj attachTo [getVar(getSelf(loc),owner),_sidePos];
			if (local _worldObj) then {
				_worldObj setVectorDirAndUp [_relDir,vec3(0,0,1)];
				_worldObj setPosASL getPosASL _worldObj;
			} else {
				//syncongrabrot
				rpcSendToObject(_worldObj,"syncongrabrot",[_relDir]);
			};

		};

		setSelf(mode,_itemDragModename);

		callFuncParams(getSelf(loc),addItem,this arg _slotTo);

		if (!_isMob) then {
			callFuncParams(_obj,startPull,getSelf(loc));
		};
	};

	func(stopGrab)
	{
		objParams();

		private _obj = getSelf(object);
		setSelf(object,nullPtr);

		setSelf(mode,"none");
		setSelf(weight,0);

		//сверяем существо в другой руке (костыль временный)
		private _otherObj = getVar(getVar(getSelf(loc),specHandAct) select ifcheck(getSelf(side) == SIDE_RIGHT,0,1),object);
		private _isGrabOtherMob = !isNullReference(_otherObj) && {not_equals(_obj,_otherObj)};

		callFuncParams(getSelf(loc),removeItem,this arg nullPtr);

		if !callFunc(_obj,isMob) exitWith {
			callFuncParams(_obj,stopPull,getSelf(loc));
		};

		private _mobObj = getVar(_obj,owner);
		private _usrObj = getVar(getSelf(loc),owner);

		//и если второго держит и он не другой моб
		if (!callFunc(getSelf(loc),isGrabAny) || _isGrabOtherMob) then {

			setVar(_obj,grabber,nullPtr);

			private _its = lineIntersectsSurfaces [
				AGLToASL getCenterMobPos(_usrObj),
				AGLToASL getCenterMobPos(_mobObj),
				_mobObj,
				_usrObj,
				true,
				#ifdef EDITOR
				20,
				#else
				1,
				#endif
				INTERACT_LODS_CHECK_GEOM
			];

			//Данная условка лишь эмулирует сингл, убирая все нгошки которые кастом собираются
			#ifdef EDITOR
			for "_i" from 0 to count _its - 1 do {
				if !isNull((_its select _i select 2) getVariable "ngo_src") then {
					_its set [_i,objnull];
				};
			};
			_its = _its - [objnull];
			traceformat("itsc on stop grab %1",_its);
			#endif

			detach getVar(_obj,owner);

			if (count _its > 0) then {
				_mobObj setPosATL (getPosATL _usrObj);
			};

			callFuncParams(_obj,syncSmdVar,"isGrabbed" arg false);
		};

		
		private _grabbedAnyMobs = (
			{
				(!isNullReference(_x) && {callFunc(getVar(_x,object),isMob)})
			} count getVar(getSelf(loc),specHandAct)
		) > 0;//no grabbed mobs now
		callFuncParams(getSelf(loc),fastSendInfo,"cd_sp_grabbingMob" arg _grabbedAnyMobs);
		callFuncParams(getSelf(loc),sendInfo,"spr_sync" arg []);

	};

	func(grabWithTwoHands)
	{
		objParams_2(_slotTo,_obj);
		setSelf(icon,getVar(_obj,icon));
		setSelf(object,_obj);

		setSelf(mode,"twohand");
		callFuncParams(getSelf(loc),syncSmdSlot,getVar(_obj,slot)); //sync otherhand
		callFuncParams(getSelf(loc),addItem,this arg _slotTo);
	};

	func(stopGrabWithTwoHands)
	{
		objParams();
		//private _prevslot = getSelf(slot);
		private _item = getSelf(object);
		setSelf(object,nullPtr);
		setSelf(mode,"none");
		setSelf(weight,0);
		callFuncParams(getSelf(loc),removeItem,this arg nullPtr);
		callFuncParams(getSelf(loc),syncSmdSlot,getVar(_item,slot));
		//callFuncParams(getSelf(loc),syncSmdSlot,_prevslot);
	};

	//умный алгоритм взаимодействия.
	//Работает как перетаскивание предмета на схваченную часть (референсится в передачу мобу)
	//Усадить на стул - определяется в стуле при onInteractWith._with == SystemItem (SystemItem->object)
	//ударить об стену схваченной частью тела как и выше
	func(onInteractWith)
	{
		objParams_2(_with,_usr); //with == other object

		if callSelf(isTwoHandedProcess) exitWith {
			callFuncParams(_with,onItemSelfClick,_usr);
		};

		traceformat("implement onInteractWith: with %1; usr %2",_with arg _usr)

		if callFunc(getSelf(object),isMob) exitWith {
			callFuncParams(getSelf(object),onInteractWith,_with arg _usr);
		};

	};

	func(onDrop)
	{
		objParams_1(_usr);
		if callSelf(isGrabProcess) exitWith {
			callSelf(stopGrab);
		};
		if callSelf(isTwoHandedProcess) exitWith {
			private _slot = getVar(getSelf(object),slot);
			callSelf(stopGrabWithTwoHands);
			callFuncParams(_usr,dropItem,_slot arg _isSafePutdown);
		};
	};

	func(onPutdown)
	{
		objParams_1(_usr);
		if callSelf(isGrabProcess) exitWith {
			callSelf(stopGrab);
		};
		if callSelf(isTwoHandedProcess) exitWith {
			private _item = getSelf(object);
			callSelf(stopGrabWithTwoHands);
			callFuncParams(_usr,putdownItem,_item arg _posData);
		};
	};

	//обработчик передачи предмета в другой слот (сграбанного)
	func(onTransferToSlot)
	{
		objParams_2(_usr,_slotTo);
		if equals(getSelf(mode),"twohand") exitWith {
			callFuncParams(_usr,transferItem,getVar(getSelf(object),slot) arg _slotTo);
		};
	};

	#define methodReference(name__,parm,refparam) func(name__) {parm; callFuncParams(getSelf(object),name__,refparam)}

	methodReference(onMainAction,objParams_1(_usr),_usr);
	methodReference(onExtraAction,objParams_1(_usr),_usr);

	//Переопределённый метод
	func(GetItemInfoForClient)
	{
		objParams();

		[
		callFuncParams(getSelf(object),getNameFor,this),
		callSelf(getIcon), //todo replace to special icon
		getSelf(pointer), //prob pointer prefix ! -> !0x1aba
		getSelf(model) //todo replace to dummy model
		]
	};

	func(getIcon)
	{
		objParams();
		if callSelf(isGrabProcess) exitWith {
			private _sidePostfix = ifcheck(getSelf(side)==SIDE_LEFT,"_l","_r");
			PATH_PICTURE("inventory\pull"+_sidePostfix+".paa")
		};
		super();
	};

endclass


editor_attribute("HiddenClass")
class(SystemInternalND) extends(Item)
	var(name,null);
	var(desc,null);
	#include "..\Interfaces\INetDisplay.Interface"

	func(constructor)
	{
		setSelf(loc,ctxParams);
	};
	getter_func(canApplyDamage,false);

	var(ndName,"MobInventory");
	var(ndInteractDistance,INTERACT_DISTANCE);

	func(getNDInfo) {
		objParams();
		private _data = [];
		{
			_data pushBack callFuncParams(getSelf(loc),getSlotInfoForInventory,_x);
		} foreach INV_LIST_ALL;
		_data
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);

		if (!callFuncParams(getSelf(loc),isEmptySlot,_inp)) then {
			private _item = callFuncParams(getSelf(loc),getItemInSlotRedirect,_inp);
			if (callFuncParams(_item,moveItem,_usr)) then {
				callSelf(updateNDisplay);
			};
		} else {
			private _item = callFunc(_usr,getItemInActiveHandRedirect);
			if !isNullReference(_item) then {
				if callFuncParams(_usr,transferItemToTarget,_item arg getSelf(loc) arg _inp) then {
					callSelf(updateNDisplay);
				};
			};
		};
	};

endclass

editor_attribute("HiddenClass")
class(SystemInternalDynamicND) extends(SystemInternalND)
	var(ptrval,"");
	var(delegateNDInfo,null);
	var(delegateNDInput,null);
	var(context,null);

	func(getNDInfo) {
		objParams();
		this call getSelf(delegateNDInfo);
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);
		[this,_usr,_inp] call getSelf(delegateNDInput);
	};

	//getter_func(getNDPointer,getSelf(ptrval));
	func(setNDOptions)
	{
		objParams_6(_ndname,_dist,_ptr,_ndinf,_ndinp,_context);
		setSelf(ndName,_ndname);
		setSelf(ndInteractDistance,_dist);
		setSelf(ptrval,_ptr);
		setSelf(delegateNDInfo,_ndinf);
		setSelf(delegateNDInput,_ndinp);
		setSelf(context,_context);
	};
endclass

editor_attribute("HiddenClass")
class(SystemMessageBoxND) extends(SystemInternalND)
	
	var(ndInteractDistance,2);
	
	var(delegate_handleInput,{});
	var(delegate_handleData,{[]});
	
	var(event_inputHandler,{});
	
	var(bufferedCtx,null); //специальные данные для контекста
	
	func(getNDInfo) {
		objParams();
		call getSelf(delegate_handleData);
	};
	
	
	func(getAllowedModes)
	{
		objParams();
		//vec3: ndname, getNDInfo, handleNDInput
		//handle input has params: _usr,_inp
		[
			["Listbox",{
				getSelf(bufferedCtx)
			},{
				//_inp was index and value from data
				_inp params ["_value","_index"];
				_ev__ = getSelf(event_inputHandler);
				private this = _usr;
				call _ev__;
			}],
			["Text",
			{
				getSelf(bufferedCtx)
			},{
				//no action was placed
			}],
			["MessageBox",
			{
				getSelf(bufferedCtx)
			},{
				//_inp == 1 - is pressed apply button
				// other cases is cannot be sended
				_ev__ = getSelf(event_inputHandler);
				private this = _usr;
				call _ev__;
			}],
			["Alert",
			{
				getSelf(bufferedCtx)
			},{
				//_inp == 1 - is pressed yes button, 0 - no button
				_ev__ = getSelf(event_inputHandler);
				_value = _inp;
				private this = _usr;
				call _ev__;
			}],
			["Input",
			{
				getSelf(bufferedCtx)
			},{
				_value = _inp;
				_ev__ = getSelf(event_inputHandler);
				private this = _usr;
				call _ev__;
			}],
			

			["VoteRep",
			{
				getSelf(bufferedCtx)
			},{
				//_inp == [bestlist,badlist]
				_ev__ = getSelf(event_inputHandler);
				private this = _usr;
				call _ev__;
			}]
		]
	};
	
	var(event_onClose,{});

	func(closeNDisplayImplBackend)
	{
		objParams_1(_usr);
		super();
		if (getSelf(ndName) in ["Input","MessageBox","Alert","Text","Listbox",
		"VoteRep"]) then {
			private __thisNDisplay = this;
			this = _usr;
			call getVar(__thisNDisplay,event_onClose);
		};
	};
	func(closeNDisplayServer)
	{
		objParams_1(_usr);
		super();
		callSelfParams(closeNDisplayImplBackend,_usr);
	};

	func(Show)
	{
		objParams_3(_name,_probTargetCheck,_probEventOnClose);
		private _thisUsr = getSelf(loc);
		if !callSelfParams(setNDMode,_name) exitWith {
			errorformat("Error on open system net display %1",_name);
		};

		if isNullVar(_probEventOnClose) then {_probEventOnClose = {}};
		setSelf(event_onClose,_probEventOnClose);
		if !isNullVar(_probTargetCheck) then {
			private _targ = _probTargetCheck;
			if callFunc(_targ,isMob) then {
				_targ = getVar(_targ,owner);
			};
			callSelfParams(openNDisplayInternal,_thisUsr arg _targ);
		} else {
			callSelfParams(openNDisplayInternal,_thisUsr arg getVar(_thisUsr,owner));
		};
	};
	
	func(setNDMode)
	{
		objParams_1(_name);
		private _modes = callSelf(getAllowedModes);
		private _allowedNames = _modes apply {_x select 0};
		if !array_exists(_allowedNames,_name) exitWith {
			errorformat("Cant set ND mode - %1",_name);
			false;
		};
		private _curMode = _modes findif {_x select 0 == _name};
		if (_curMode==-1) exitWith {false};
		setSelf(ndName,_name);
		setSelf(delegate_handleData,_modes select _curMode select 1);
		setSelf(delegate_handleInput,_modes select _curMode select 2);
		true
	};

	func(onHandleNDInput) {
		objParams_2(_usr,_inp);
		call getSelf(delegate_handleInput);
	};
endclass

#ifdef EDITOR
class(Debug_Item_damager) extends(Item)

	var(attachedWeap,weaponModule(WeapDebugger_item));
	runtimeGenerateWeapon("WeapDebugger_item","WeapHandyItem")
	{
		varpair(attackedBy,pair(ATTACK_TYPE_SWING,"бьет отладочным"));
		var(defenceBy,"отладочного");
		getter_func(getMissAttackWeaponText,"отладочным");
		varpair(dmgBonus,pair(ATTACK_TYPE_SWING,+10));
	};

	getterconst_func(startUpdateOnConstruct,true);
	getterconst_func(defaultUpdateDelay,0.01);
	getter_func(canApplyDamage,false);
	func(onUpdate)
	{
		objParams();
		
		private _m = callSelf(getSourceLoc);
		if isNullVar(_m) exitWith {};
		if isNullReference(_m) exitWith {};
		if isTypeOf(_m,Mob) then {
			callFuncParams(_m,addStaminaRegen,1000);
			setVar(_m,lastCombatActionTime,0);
			setVar(_m,otherLastCombatActionTime,0);
			setVar(_m,hunger,100);
			setVar(_m,thirst,100);
			
		};
		
	};
endclass

#endif