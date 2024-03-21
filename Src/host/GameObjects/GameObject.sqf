// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"
#include "GameConstants.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include <..\..\client\Inventory\inventory.hpp>
#include <..\PointerSystem\pointers.hpp>

/*
# Основные методы для моба
onMainAction(_usr) - событие когда к этому объекту вызывают действие (игрок жмет Е по цели)
onExtraAction(_usr) - тоже самое что и onMainAction (игрок жмет F по цели)

# Дополнительные предметные события
onInteractWith(_with,_usr) - когда игрок (_usr) взаимодействует с целью (this) с помощью предмета

onClick(_usr) - событие вызывается когда юзер кликает по предмету ЛКМ рукой. Например там реализуем подбор
onAltClick(_usr) - событие вызывается когда юзер кликает по предмету ПКМ рукой

onClickWithItem(_item,_usr) - вызывается с объекта когда клиент жмёт по миру с предметом в активной руке
onAltClickWithItem(_item,_usr) - onClickWithItem

-------------------------ТОЛЬКО ДЛЯ МОБОВ-------------------------
clickTarget(_targ) - вызывается когда игрок кликает по мобу. Возможен вариант что игрок кликнул сам по себе в режиме внутреннего взаимодействия
altClickTarget(_targ) - тоже самое что и clickTarget но альтернатива

onInteractWithMob(_target,_item) - событие вызывается с игрока


*/
#ifdef EDITOR
debug_internal_collectInheritanceDesign = {
	_data = [];
	{
		_type = missionNamespace getVariable ("pt_"+_x);
		_inhList = +getVar(_type,__inhlist);
		reverse _inhList;
		_data pushBack (_inhList joinString "/");
	} foreach p_table_allclassnames;
	text (_data joinString endl)
};
#endif

//летящий объект. системная переменная
flyingObject = createObj;
flyingObject setName "<INTERNAL>flyingObject";

editor_attribute("HiddenClass")
class(GameObject) extends(ManagedObject)
	"
		name:Игровой объект
		desc:Базовый игровой объект, от которого унаследованы все сущности, объекты и предметы.
		path:Игровые объекты.Базовые
	"
	node_class

	//сохранено для обратной совместимости
	"
		name:Имя
		desc:Имя игрового объекта
		prop:all
		classprop:1
		return:string
	" node_var
	editor_attribute("EditorVisible" arg "type:string") editor_attribute("Tooltip" arg "Имя игрового объекта") var(name,null);
	"
		name:Описание
		desc:Описание игрового объекта
		prop:all
		classprop:1
		return:string
	" node_var
	editor_attribute("EditorVisible" arg "type:string") editor_attribute("Tooltip" arg "Описание игрового объекта") var(desc,null);
	editor_attribute("Tooltip" arg "Обобщённое название объекта")
	getter_func(getAbstractName,"Что-то");
	editor_attribute("Tooltip" arg "Модифицируемый метод получения имени")
	getter_func(getName,if isNull(getSelf(name)) then {callSelf(getAbstractName)} else {getSelf(name)});
	editor_attribute("Tooltip" arg "Модифицируемый метод получения описания")
	getter_func(getDesc,if isNull(getSelf(desc)) then {""} else {getSelf(desc)});

	verbListOverride("description mainact"); //список действий которые можно сделать с ЭТИМ объектом

	"
		name:В мире
		desc:Возвращает @[bool ИСТИНУ], если игровой объект находится в мире.
		type:get
		lockoverride:1
		return:bool:Находится ли объект в мире
	" node_met
	editor_attribute("Tooltip" arg "Находится ли игровой объект в мире (для всех кроме мобов)") getter_func(isInWorld,equalTypes(getSelf(loc),objNull));

	//летит ли объект
	getter_func(isFlying,equals(getSelf(loc),flyingObject));
	func(stopFlying)
	{
		objParams();
		if !callSelf(isFlying) exitWith {
			warningformat("Object %1 (%2) already not flying",callSelf(getClassName) arg getSelf(pointer));
		};
		setSelf(_flagFlyLoad,true);
	};

	//когда объект был принудительно остановлен в полете
	func(onStopFlying)
	{
		objParams();
	};

	getterconst_func(getChunkType,-1);
	
	"
		name:Это предмет
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является предметом.
		type:const
		classprop:0
		return:bool:Является ли объект предметом
	" node_met
	getterconst_func(isItem,false);
	"
		name:Это моб
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является мобом (сущностью).
		type:const
		classprop:0
		return:bool:Является ли объект мобом
	" node_met
	getterconst_func(isMob,false);
	"
		name:Это декор
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является декорацией.
		type:const
		classprop:0
		return:bool:Является ли объект декорацией
	" node_met
	getterconst_func(isDecor,false);
	"
		name:Это структура
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является структурой.
		type:const
		classprop:0
		return:bool:Является ли объект структурой
	" node_met
	getterconst_func(isStruct,false);

	"
		name:Это дверь
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является дверью.
		type:const
		classprop:0
		return:bool:Является ли объект дверью
	" node_met
	getterconst_func(isDoor,false);

	"
		name:Это контейнер
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является контейнером.
		type:const
		classprop:0
		return:bool:Является ли объект контейнером
	" node_met
	getterconst_func(isContainer,false); //является ли объект контейнером

	"
		name:Это стак
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является стакуемым итемом.
		type:const
		classprop:0
		return:bool:Является ли объект стаком
	" node_met
	getterconst_func(isStack,false); //является ли предмет стакуемым
	"
		name:Может светить
		desc:Возвращает @[bool ИСТИНУ], если игровой объект может светиться, используя конфиги освещения и частиц.
		type:const
		classprop:0
		return:bool:Является ли объект дверью
	" node_met
	getterconst_func(canLight,false); //является ли предмет источником света
	"
		name:Это огненный источник света
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является огненным источником света. В будущем такие объекты смогут поджигать окружение.
		type:const
		classprop:0
		return:bool:Является ли объект огненным источником света
	" node_met
		getterconst_func(isFireLight,false); //огненный источник света
	"
		name:Это хранилище реагентов
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является хранилищем реагентов (например, бутыки, шприцы).
		type:const
		classprop:0
		return:bool:Является ли объект дверью
	" node_met
	getterconst_func(isReagentContainer,false); // реагент-контейнер
	"
		name:Это питьё
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является выпиваемым предметом.
		type:const
		classprop:0
		return:bool:Является ли объект питьём
	" node_met
		getterconst_func(isDrink,false); //является водой
	"
		name:Это пища
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является съедаемым предметом.
		type:const
		classprop:0
		return:bool:Является ли объект едой
	" node_met
		getterconst_func(isFood,false);// является пищей
	"
		name:Это сиденье
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является сиденьем, таким как стул, кровать или любой объект привязки персонажа.
		type:const
		classprop:0
		return:bool:Является ли объект сиденьем
	" node_met
	getterconst_func(isSeat,false); //это сиденье (стул, лавка)

	getter_func(canUseAsCraftSpace,false);//для пукнта в verb-меню (позволяет открывать крафт от этого объекта)
	getter_func(getAllowedCraftCategories,[]); //доступные категории для крафт меню

	"
		name:Вес
		desc:Вес объекта в граммах. 1 кг = 1000 грамм.
		prop:all
		classprop:1
		return:float:Вес игрового объекта
	" node_var
	editor_attribute("EditorVisible" arg "custom_provider:weight")
	editor_attribute("Tooltip" arg "Вес объекта в граммах или килограммах")
	var(weight,gramm(1000));//вес в граммах

	editor_attribute("ReadOnly")
	var(pointer,pointer_new(this)); //unique pointer
	
	func(constructor)
	{
		objParams();
		
		//create pool if does not exists
		private _t = typeGetFromObject(this);
		if (!typeHasVar(_t,__mempool_inst__)) then {
			private _map = createHashMap;
			_map set [getSelf(pointer),this];
			typeSetVar(_t,__mempool_inst__,_map);
		} else {
			private _map = typeGetVar(_t,__mempool_inst__);
			_map set [getSelf(pointer),this];
		};
	};

	//Системный метод для обработки начальных значений переменных с префиксом preinit@
	func(__handlePreInitVars__)
	{
		objParams();
	};
	//массив с именами переменных (константная функция)
	func(__handleNativePreInitVars__)
	{
		[]
	};

	//Получает список всех объектов данного типа
	"
		name:Все объекты
		desc:Возвращает список всех объектов данного типа.
		type:get
		lockoverride:1
		return:array[GameObject]:Список всех объектов данного типа
	" node_met
	func(getAllObjects)
	{
		objParams();
		private _list = [];
		{
			_list pushBack _y;
		} foreach typeGetVar(typeGetFromObject(this),__mempool_inst__);
		_list;
	};

	func(destructor)
	{
		objParams();

		private _t = typeGetFromObject(this);
		typeGetVar(_t,__mempool_inst__) deleteAt getSelf(pointer);

		pointer_delete(getSelf(pointer));
	};

	//Пользовательский базовый метод для moveitem
	func(onMoveInItem)
	{
		objParams_1(_from);
	};

	func(canMoveInItem) {objParams_1(_item);true};
	func(canMoveOutItem) {objParams_1(_item);true};

	//Пользовательский базовый метод для moveItem
	func(onMoveOutItem)
	{
		objParams_1(_from);
	};

	// получить название для юзера
	"
		name:Получить имя для моба
		desc:Получает имя игрового объекта для указанного моба. Данный метод можно переопределить и реализовать, к примеру, разные названия в зависимости от навыков моба.
		type:get
		in:BasicMob:Моб:Сущность, для которой будет получено имя данного игрового объекта.
		return:string:Имя игрового объекта
	" node_met
	func(getNameFor)
	{
		objParams_1(_usr);
		callSelf(getName);
	};

	func(getIcon)
	{
		objParams();
		null
	};

	// получить описание для юзера
	func(getDescFor)
	{
		objParams_1(_usr);

		#define PIC_PREP <img size='0.8' image='%2'/>

		private _rand = pick(["Ну а это %1" arg "А это %1" arg "Это %1" arg "Да это же %1" arg "Вот это %1"]);
		private _postrand = selectRandom ["!" arg "." arg "..." arg ", вроде..."]; //очень странные дела с пикингом через препроцессор

		private _icon = callSelf(getIcon);

		private _desc = callSelf(getDesc);
		if (_desc != "") then {_desc = sbr + _desc;};

		//todo replace parsing picture to server
		_icon = if (isNullVar(_icon) || {equals(_icon,stringEmpty)}) then {stringEmpty} else {
			format["<img size='0.8' image='%1'/> ",if (".paa" in _icon) then {_icon} else {PATH_PICTURE_INV(_icon)}]};

		private _otherText = if isTypeOf(this,Decor) then {""} else {
			//Вес меньше 0 значит это фиктивный итем
			if (callSelf(getWeight) < 0) exitWith {""};

			sbr + callSelf(getTextWeight) + sbr +
			"Размер: " + callSelf(getTextSize)
			#ifdef EDITOR
			+ sbr + (if (isTypeOf(this,Item) && !isNull(getSelf(bbx))) then
			{
				"Пропорции: " + str getSelf(bbx) + sbr + "Объем: " + str (getSelf(volume)^(1/3));
			}
			else {"Пропорции отсутствуют"})
			#endif
		};

		if isTypeOf(this,IDestructible) then {
			//collect germ info to ru text with GERM_COUNT_TO_NAME()
			private _germText = GERM_COUNT_TO_NAME(getSelf(germs));
			if (_germText != "") then {
				modvar(_otherText) + sbr + _germText;
			};
		};

		format[_rand + _postrand,_icon + callSelfParams(getNameFor,_usr)] +
		_desc +
		_otherText;
	};

	go_internal_updateMethodsAfterStart = [];

	editor_attribute("InternalImpl")
	var(_update_handle_auto,-1);

	// запускает метод в цикле
	func(startUpdateMethod)
	{
		params ['this',"_methodName",["_refvar","_update_handle_auto"],["_delay",DEFAULT_TICK_DELAY]];

		if (["<=","GAME_STATE_LOBBY"] call gm_checkState) exitWith {
			go_internal_updateMethodsAfterStart pushBack [this,_methodName,_refvar,_delay];
		};

		INC(oop_upd);
		private _hnd = startUpdateParams(getSelfFuncReflect(_methodName),_delay,this);
		if equals(_refvar,"_update_handle_auto") then {
			if (getSelf(_update_handle_auto)!=-1) then {
				callSelfParams(stopUpdateMethod,null);
			};
		};
		setSelfReflect(_refvar,_hnd);
	};

	//останавливает цикл по указателю
	func(stopUpdateMethod)
	{
		objParams_1(_fieldName);

		//redirect to auto generated field
		if isNullVar(_fieldName) then {_fieldName =	"_update_handle_auto"};
		if (_fieldName == "") then {_fieldName = "_update_handle_auto"};

		private _hnd = getSelfReflect(_fieldName);
		if (_hnd != -1) then {
			stopUpdate(_hnd);
			DEC(oop_upd);
			setSelfReflect(_fieldName,-1);
		};
	};

	//Основной алгоритм получения полного веса
	getter_func(getWeight,getSelf(weight));

	//Специальный метод перерасчета нагрузки
	func(onWeightChanged)
	{
		objParams();
		if !callSelf(isInWorld) then {
			private _loc = getSelf(loc);
			if callFunc(_loc,isMob) then {
				this call gurps_recalcuateEncumbrance;
			};
		};
	};

	func(getTextWeight)
	{
		objParams();
		private _weight = callSelf(getWeight);
		if isTypeOf(this,Mob) then {MOD(_weight,+getSelf(encumbrance))};
		if (_weight < 1) then {
			format["Вес: %1 г.",kgToGramm(_weight)]
		} else {
			format["Вес: %1 кг.",_weight call {
				//Внутренняя статическая функция каста веса
				if ((_this toFixed 2) == ((floor _this) toFixed 2)) then {
					((floor _this) toFixed 2)
				} else {
					_this toFixed 2
				}
			}
			]
		}
	};

	func(getTextSize)
	{
		objParams();
		["Крошечный","Маленький","Средний","Крупный","Большой","Огромный"] select (getSelf(size) - 1)
	};

	//специальное условие для видимости действия
	getter_func(canUseMainAction,isTypeOf(_usr,Mob));
	//не пустые строчки установят действие
	getter_func(getMainActionName,"");
	//основное действие по предмету
	func(onMainAction) {objParams_1(_usr);
		#ifdef EDITOR
		warningformat("No main action defined - %1",callSelf(getClassName));
		#endif
	"*UNDECL*"};

	//экстра действие по предмету
	//оставлено для обратной совместимости
	func(onExtraAction) {objParams_1(_usr);
		#ifdef EDITOR
		warningformat("No extra action defined - %1",callSelf(getClassName));
		#endif
		errorformat("DEPRECATED METHOD %1::onExtraAction()",callSelf(getClassName));
	};

	//Событие вызывается при взаимодействии с этим объектом с помощью другого объекта
	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		#ifdef EDITOR
		if (isMultiplayer) exitWith {};
		private _text = format["[DEBUG]: %1 взаимодействует с %2 (%4) с помощью %3 (%5)",
		callFunc(_usr,getName), callSelf(getName), callFunc(_with,getName),
		getSelf(pointer),getVar(_with,pointer)];

		rpcSendToObject(getVar(_usr,owner),"chatPrint",[_text arg "log"]);
		#endif
	};

	func(onClick)
	{
		objParams_1(_usr);
		#ifdef EDITOR
		warningformat("No click method defined - %1",callSelf(getClassName));
		#endif
	};

	//Только для итемов
	//срабатывает при нажатии по предмету в инвентаре
	func(onItemClick)
	{
		objParams_1(_usr);
		#ifdef EDITOR
		warningformat("No item click method defined - %1",callSelf(getClassName));
		#endif
	};

	//Только для итемов
	//срабатывает при нажатии по предмету в инвентаре когда он в активной руке
	func(onItemSelfClick)
	{
		objParams_1(_usr);
		#ifdef EDITOR
		warningformat("No item self click method defined - %1",callSelf(getClassName));
		#endif
	};

	func(onCrushingContact)
	{
		objParams_2(_usr,_supressMessage);

		//гост не врезается ни во что...
		if isTypeOf(_usr,MobGhost) exitWith {};

		if isNullVar(_supressMessage) then {_supressMessage = false};

		if(isTypeOf(this,IStruct) || isTypeOf(this,Decor)) then {
			private _d = 2 call gurps_throwdices;
			if (!_supressMessage) then {
				callFuncParams(_usr,meSay,format ["со всей мощи впечатался в %1." arg callSelfParams(getNameFor,_usr)]);
			};
			callFuncParams(_usr,applyDamage,_d arg DAMAGE_TYPE_CRUSHING arg callFunc(_usr,pickRandomTargZoneTorsoHeadNeck) arg DIR_FRONT arg di_crushingContact);
			callFuncParams(_usr,Stun,rand(3,4));
			callFuncParams(_usr,addStaminaLoss,randInt(50,55));
			callFunc(_usr,Knockdown);
			callSelfParams(playSound,"mob\fallsmash" arg getRandomPitchInRange(0.8,1.3) arg null arg 2.2);
		}

		else {
			#ifdef EDITOR
			[format["Врезание в %1",getSelf(pointer)],"log"] call chatPrint;
			#endif
		};
	};

	//Находит базовый объект (моб или игровой объект)
	"
		name:Получить модель
		desc:Получает исходную модель игрового объекта. Если объект в контейнере возвращает модель контейнера в мире. Если в инвентаре моба - возвращает модель моба. В ином случае возвращает модель этого игрового объекта.
		type:get
		lockoverride:1
		return:model:Модель-владелец игрового объекта
	" node_met
	func(getBasicLoc)
	{
		objParams();

		private _curLoc = this;
		private _probNewLoc = nullPtr;
		while {true} do {
			_probNewLoc = getVar(_curLoc,loc);

			if (isNullVar(_probNewLoc)) exitWith {
				if isTypeOf(_curLoc,BasicMob) then {
					_curLoc = getVar(_curLoc,owner);
				} else {
					errorformat("GameObject::getBasicLoc() - Cant find basic loc for object %1 (%2)",this arg getSelf(pointer));
					_curLoc = OBJNULL;
				};
			};
			_curLoc = _probNewLoc;
		};

		_curLoc;
	};

	"
		name:Дистанция до
		desc:Получает расстояние до цели в метрах
		type:get
		lockoverride:1
		in:GameObject:Объект-цель:Объект, до которого расчитывается расстояние
		in:bool:2d расстояние:При включении данной опции расстояние будет вычислено только по двум координатам, т.е. высота не будет учитываться.
		return:float:Расстояние до цели
	" node_met
	func(getDistanceTo)
	{
		params ['this',"_targ",["_is2dDist",false]];
		if (_is2dDist) exitwith {
			callSelf(getBasicLoc) distance2d callFunc(_targ,getBasicLoc);	
		};
		callSelf(getBasicLoc) distance callFunc(_targ,getBasicLoc);
	};

	//Находит конечного владельца как GameObject
	"
		name:Получить источник
		desc:Получает объект, который владеет этим игровым объектом. Для объекта в контейнере владельцем будет контейнер, для объекта в инвентаре моба - моб. Если объектом никто не владеет возвращает @[object^ null-ссылку].
		type:get
		lockoverride:1
		return:GameObject:Источник
	" node_met
	func(getSourceLoc)
	{
		objParams();
		private _curLoc = this;
		private _probNewLoc = nullPtr;
		while {true} do {
			_probNewLoc = getVar(_curLoc,loc);

			if (isNullVar(_probNewLoc) || {equalTypes(_probNewLoc,objNUll)}) exitWith {};

			_curLoc = _probNewLoc;
		};
		
		if isNullVar(_curLoc) exitWith {nullPtr};
		//is a normal. not warning
		/*if equals(_curLoc,this) then {
			warningformat("%1:getSourceLoc() returns this object",callSelf(getClassName));
		};*/

		_curLoc;
	};

	//Возвращает позицию объекта
	getter_func(getModelPosition,getPosATL callSelf(getBasicLoc));
	getter_func(getModelDirection,getDir callSelf(getBasicLoc));

	"
		name:Позиция игрового объекта
		desc:Получает позицию игрового объекта. Если игровым объектом является предмет в контейнере, либо в инвентаре моба, то будет возвращена позиция объекта владельца (моба или контейнера).
		type:get
		lockoverride:1
		return:vector3:Позиция
	" node_met
	getter_func(getPos,callSelf(getModelPosition));
	"
		name:Направление игрового объекта
		desc:Получает направление игрового объекта. Если игровым объектом является предмет в контейнере, либо в инвентаре моба, то будет возвращено направление объекта владельца (моба или контейнера).
		type:get
		lockoverride:1
		return:vector3:Направление
	" node_met
	getter_func(getDir,callSelf(getModelDirection));

	#define startSectorIndex 1
	#define sectorSize 1
	//Расчет для боёвки. Секторы величиной 1х1х1 метра
	func(getSectorPos)
	{
		objParams();
		setLastError("GameObject::getSectorPos() - Obsoleted");
		callSelf(getModelPosition) params ["_x","_y","_z"];

		[
			floor(_x / sectorSize) + startSectorIndex,
			floor(_y / sectorSize) + startSectorIndex,
			floor(_z / sectorSize) + startSectorIndex
		]
	};

	func(getSectorDistTo)
	{
		objParams_1(_otherPos);
		setLastError("GameObject::getSectorDistTo() - Obsoleted");
		private _other = [
			floor((_otherPos select 0) / sectorSize) + startSectorIndex,
			floor((_otherPos select 1) / sectorSize) + startSectorIndex,
			floor((_otherPos select 2) / sectorSize) + startSectorIndex
		];
		//Всегда округление вниз из-за диагональной проверки
		(callSelf(getSectorPos) distance _other)
	};

	//возвращает массив от чего унаследован данный объект
	//возвращает строки
	//?нигде не используется
	func(getInheritFrom)
	{
		objParams();
		private _inhlist = this getVariable PROTOTYPE_VAR_NAME getVariable "__inhlist";
		_inhlist select[0,(count _inhlist)-2]//exclude object and managed object
	};

	//возвращает игроков в радиусе
	//?нигде не используется
	func(getNearClients)
	{
		//objParams_2(_radius,_includeOwner);
		params ['this',"_radius",["_includeOwner",true]];

		private _ownerObj = callSelf(getBasicLoc);

		private _list = if (isMultiplayer) then {
			(_ownerObj nearEntities _radius) select {isPlayer _x};
		} else {
			(_ownerObj nearEntities _radius);
		};
		if (!_includeOwner) then {
			_list = _list - [_ownerObj];
		};

		_list
	};

region(Nearest game objects)
	
	"
		name:Ближайшие предметы
		namelib:Ближайшие предметы в радиусе
		desc:Получает все игровые предметы, находящиеся в мире в радиусе от этого игрового объекта. Предметы в контейнерах или инвентарях других мобов не учитываются.
		type:get
		lockoverride:1
		in:float:Радиус:Радиус в метрах
			opt:def=5
		in:bool:Исключить себя:Если @[bool ИСТИНА], то игровой объект, который вызывает этот метод будет исключён из результата.
			opt:def=true
		return:array[Item]:Массив игровых объектов
	" node_met
	//нерестит все предметы в радиусе _radius
	func(getNearItems)
	{
		params ['this',"_radius",["_excludeThis",true]];
		private _ownerObj = callSelf(getBasicLoc);
		private _list = [];
		{
			_x = _x getVariable "link";
			if (callFunc(_x,isItem)) then {_list pushBack _x};
		} foreach (_ownerObj nearObjects _radius);
		if (_excludeThis) then {
			_list = _list - [this];
		};
		_list;
	};

	"
		name:Ближайшие структуры
		namelib:Ближайшие структуры в радиусе
		desc:Получает все структуры, в радиусе от этого игрового объекта.
		type:get
		lockoverride:1
		in:float:Радиус:Радиус в метрах
			opt:def=5
		in:bool:Исключить себя:Если @[bool ИСТИНА], то игровой объект, который вызывает этот метод будет исключён из результата.
			opt:def=true
		return:array[IStruct]:Массив игровых объектов
	" node_met
	//нерестит все структуры в радиусе _radius
	func(getNearStructs)
	{
		params ['this',"_radius",["_excludeThis",true]];
		private _ownerObj = callSelf(getBasicLoc);
		private _list = [];
		{
			_x = _x getVariable "link";
			if (callFunc(_x,isStruct)) then {_list pushBack _x};
		} foreach (_ownerObj nearObjects _radius);
		if (_excludeThis) then {
			_list = _list - [this];
		};
		_list;
	};

	"
		name:Ближайшие декорации
		namelib:Ближайшие декорации в радиусе
		desc:Получает все декорации, в радиусе от этого игрового объекта.
		type:get
		lockoverride:1
		in:float:Радиус:Радиус в метрах
			opt:def=5
		in:bool:Исключить себя:Если @[bool ИСТИНА], то игровой объект, который вызывает этот метод будет исключён из результата.
			opt:def=true
		return:array[Decor]:Массив игровых объектов
	" node_met
	//нерестит все декорации в радиусе _radius
	func(getNearDecors)
	{
		params ['this',"_radius",["_excludeThis",true]];
		private _ownerObj = callSelf(getBasicLoc);
		private _list = [];
		{
			_x = _x getVariable "link";
			if (callFunc(_x,isDecor)) then {_list pushBack _x};
		} foreach (_ownerObj nearObjects _radius);
		if (_excludeThis) then {
			_list = _list - [this];
		};
		_list;
	};

	"
		name:Ближайшие мобы
		namelib:Ближайшие мобы в радиусе
		desc:Получает всех мобов, в радиусе от этого игрового объекта.
		type:get
		lockoverride:1
		in:float:Радиус:Радиус в метрах
			opt:def=5
		in:bool:Исключить себя:Если @[bool ИСТИНА], то игровой объект, который вызывает этот метод будет исключён из результата.
			opt:def=true
		in:bool:Поиск по типу:Если @[bool ИСТИНА], то будет осуществлён поиск ближайших мобов по типу. В ином случае поиск будет осуществлён по всем мобам.
			opt:def=false
		in:classname:Тип мобов:Тип мобов, которые будут искаться. Используется только если включен поиск по типу.
			opt:def=BasicMob:typeset_out=Результат|array[{typename}]
		return:array[BasicMob]:Массив игровых объектов
	" node_met
	//Собираем мобов на дистанции
	func(getNearMobs)
	{
		params ['this',"_radius",["_excludeThis",true],["_retByType",false],["_checkedType","BasicMob"]];
		private _ownerObj = callSelf(getBasicLoc);
		private _list = [];
		private _algGet = ifcheck(_retByType,{isTypeStringOf(_this,_checkedType)},{callFunc(_this,isMob)});
		{
			_x = _x getVariable "link";
			if (_x call _algGet) then {_list pushBack _x};
		} foreach (_ownerObj nearObjects _radius);
		if (_excludeThis) then {
			_list = _list - [this];
		};
		_list;
	};

	//Параметр _retByType - будет делать проверку не по функции isMob, а по сопоставлению типа, указанного в _checkedType
	"
		name:Ближайший моб
		desc:Получает первого ближайшего моба к этому игровому объекту.
		type:get
		lockoverride:1
		in:float:Радиус:Радиус в метрах
			opt:def=5
		in:bool:Поиск по типу:Если @[bool ИСТИНА], то будет осуществлён поиск ближайших мобов по типу. В ином случае поиск будет осуществлён по всем мобам.
			opt:def=false
		in:classname:Тип мобов:Тип мобов, которые будут искаться. Используется только если включен поиск по типу.
			opt:def=BasicMob:typeset_out=Результат
		return:BasicMob:Ближайшая сущность
	" node_met
	func(getNearMob)
	{
		params ['this',"_radius",["_retByType",false],["_checkedType","BasicMob"]];
		private _ownerObj = callSelf(getBasicLoc);
		private _list = [];
		private _lastNear = nullPtr;
		private _lastDist = _radius; 
		private _checkedDist = _radius;
		private _algGet = ifcheck(_retByType,{isTypeStringOf(_this,_checkedType)},{callFunc(_this,isMob)});
		{
			_x = _x getVariable "link";
			if (_x call _algGet) then {
				_checkedDist = callSelfParams(getDistanceTo,_x);
				if (_checkedDist < _lastDist) then {
					_lastNear = _x;
					_lastDist = _checkedDist;
				};
			};
		} foreach ((_ownerObj nearObjects _radius)-[_ownerObj]);

		_lastNear
	};

	//Возвращает вообще все игровые объекты в радиусе
	func(getNearObjects)
	{
		//TODO remove this function
		params ['this',"_type","_dist",["_retChild",false],["_retAsList",true],["_excludeThis",true]];
		private _pos = getPosATL callSelf(getBasicLoc);
		private _ret = [_type,_pos,_dist,_retAsList,_retChild] call getGameObjectOnPosition;
		if (_retAsList && _excludeThis) then {
			_ret - [this]
		} else {
			_ret
		};
	};

	//прототип функции получения объекта (под этим объектом). для мобов переопределено и возвращает массив
	getter_func(getObjectPlace,nullPtr);

endregion


	//Возвращает всех клиентов кто видит этот игровой объект
	// ВНИМАНИЕ! Функция достаточно требовательная и не должна вызываться слишком часто
	func(getViewers)
	{
		params ['this',"_radius"];
		NOTIMPLEMENTED(GameObject::getViewers)
		[]//returns empty list now
	};

	//Проигрывание звука. Если параметр _hasRTProcess = false, то звук воспроизведется на сервере без симуляции гашения от стен
	"
		name:Проиграть звук
		desc:Воспроизводит звук в формате ogg по указанному пути
		type:method
		lockoverride:1
		in:string:Путь:Путь до файла звука, например: ""fire\\torch_on""
		in:float:Тон:Тон звука. 2 - максимальный возможный, 0.5 - минимальный возможный
			opt:def=1
		in:float:Расстояние:Расстояние, на которое будет слышно данный звук.
			opt:def=50
		in:float:Громкость:Громкость звука. Не рекомендуется менять это значение
			opt:def=1
		in:void:Источник:Источник звука. Можно указать 3д вектор или модель сущности.
			opt:require=0
		in:bool:Симуляция:Использовать симуляцию гашения звука от стен.
			opt:def=true
	" node_met
	func(playSound)
	{
		params ['this',"_path",["_pitch",1],["_maxDist",50],["_vol",1],"_atPos",["_hasRTProcess",true]];
		FHEADER;
		private _source = if !isNullVar(_atPos) then {
			_atPos
		} else {
			private _src = callSelf(getSourceLoc);
			if (isNullVar(_src) || {isNullReference(_src)}) exitWith {RETURN(0)};
			if callFunc(_src,isMob) then {
				getVar(_src,owner);
			} else {
				//? possible error if loc not rv_object type; Maybee need use callFunc(_src,getBasicLoc) ?
				ifcheck(_hasRTProcess,getVar(_src,pointer),getVar(_src,loc)) 
			};
			//ifcheck(callFunc(_src,isMob),getVar(_src,owner),getVar(_src,pointer))
		};

		private _data = [_path arg _source arg _vol arg _pitch arg _maxDist];

		private _srcObj = callSelf(getBasicLoc);
		
		//if not runtime processed then called from server
		if (!_hasRTProcess) exitwith {
			_data call soundGlobal_play;
		};

		private _nearMobs = _srcObj nearEntities _maxDist;
		{
			rpcSendToObject(_x,"sl_p_rt",_data);
			true
		} count _nearMobs;
	};

	"
		name:Сказать в чат
		desc:Выводит сообщение в чат всем игрокам от данного игрового объекта.
		type:method
		lockoverride:1
		in:string:Текст:Текст сообщения
		in:enum.ChatMessageChannel:Тип сообщения:Тип сообщения чата
		in:float:Расстояние:Расстояние, на которое будет видно данное сообщение.
			opt:def="+'DISTANCE_WORLDSAY'+"
		in:bool:Только при видимости:При включении будет показывать сообщение только тем персонажам, которые явно видят источник сообщения.
			opt:def=true
	" node_met
	func(_worldSayWrapper)
	{
		assert_str(count _this > 2,"Param count error");
		private _ch = _this select 2;
		assert_str(!isNullVar(_ch),"Channel param cannot be null");
		assert_str(equalTypes(_ch,0),"Channel param type error. Must be integer - not " + typename _ch);
		assert_str(inRange(_ch,0,count go_internal_chatMesMap - 1),"Channel index out of range: " + str _ch);
		_this set [2,go_internal_chatMesMap select _ch];
		
		private this = _this select 0;
		_this call getSelfFunc(worldSay)
	};

	//!do not replace. Used in enum generator (renode)
	go_internal_chatMesMap = ["emote","log","act","combat","info","mind","event","system","error","default"];
	go_internal_chatMesMapText = ["Эмоут:Кастомное пользовательское действие",
		"Лог:Логируемое сообщение",
		"Действие:Пользовательские действия",
		"Бой:Атака, защита и получение повреждений",
		"Информация:Информационное сообщение общего назначения",
		"Мысли:Внутренее состояние персонажа и его мысли",
		"Событие:Игровое событие, эвент",
		"Система:Системные сообщения",
		"Ошибка:Сообщение ошибки. Добавляет префиксный текст в начало сообщения.",
		"По умолчанию:Сообщение по умолчанию"
	];

	func(worldSay)
	{
		params ['this',"_text","_channel",["_distance",DISTANCE_WORLDSAY],["_isVisibleMessage",true]];
		//DEPREACTED. use GameObject.getBasicLoc
/*		private _loc = getSelf(loc);

		if isTypeOf(_loc,Mob) then {
			_loc = getVar(_loc,owner);
		};
		if equalTypes(_loc,nullPtr) then {
			_loc = getVar(_loc,loc); //if item inside struct
		};	*/
		private _nearMobs = callSelf(getBasicLoc) nearEntities _distance;
		if (_isVisibleMessage) then {
			{
				if (isPlayer _x) then {
					if callFuncParams(_x getVariable vec2("link",nullPtr),canSeeObject,this) then {
						rpcSendToObject(_x,"chatPrint", [_text arg _channel]);
					};
				};
			} count _nearMobs;
		} else {
			{
				if (isPlayer _x) then {
					rpcSendToObject(_x,"chatPrint", [_text arg _channel]);
				};
			} count _nearMobs;
		};
		
	};

	// method for unloading world model
	func(unloadModel)
	{
		objParams();
		private _cht = callSelf(getChunkType);
		if isNullVar(_cht) exitWith {
			error("GameObject::unloadModel() - getChunkType returns null");
			false
		};
		[this,_cht] call noe_unloadVisualObject;
		true
	};

	//Загрузить модель в мир. Параметр _vecOrDist - если _simDrop это дистанция дропа. иначе это вектор up для трансформа
	func(loadModel)
	{
		objParams_4(_pos,_dir,_vecOrDist,_simDrop);
		
		if isNullVar(_simDrop) then {_simDrop = true};

		if equals(getSelf(loc),objNULL) then {
			setSelf(loc,nullPtr); //drop value for checks in noe_loadVisualObject
		};
		if callSelf(isInWorld) exitwith {false};
		private _wobj = objNull;
		if (_simDrop) then {
			_wobj = [this,_pos,_vecOrDist,_dir] call noe_loadVisualObject_OnDrop;
		} else {
			_wobj = [this,_pos,_dir,_vec] call noe_loadVisualObject;
		};
		
		!isNullReference(_wobj)
	};

	//Реплицирует позицию или любое изменённое состояние объекта
	func(replicateObject)
	{
		objParams();
		if callSelf(isInWorld) then {
			private _cht = callSelf(getChunkType);
			if isNullVar(_cht) exitWith {
				error("GameObject::unloadModel() - getChunkType returns null");
				false
			};
			[getSelf(loc),_cht,true] call noe_replicateObject;

			true
		} else {
			false
		};
	};

	// Замена модели объекта
	"
		name:Установить модель
		desc:Заменяет модель игрового объекта
		type:method
		lockoverride:1
		in:string:Путь:Путь до модели
		return:bool:Успешно ли заменилась модель
	" node_met
	func(setModel)
	{
		objParams_1(_newmodel);

		if isTypeOf(this,BasicMob) exitwith {false};
		
		assert_str(!callSelf(isSeat),"Seat " + callSelf(getClassName) + " cannot change model");

		if callSelf(isInWorld) then {
			//update modelpath
			setSelf(model,_newmodel);
			if callSelf(isItem) then {callSelf(syncIcon);};
			//setLastError("TODO: implement world model update");
			/*
				1. Получаем метаданные с текущего визуального объекта.
				2. создаем объект
			*/
			private _cht = callSelf(getChunkType);
			private _loc = getSelf(loc);

			private _pos = getPosATLVisual _loc;
			private _dir = vectorDirVisual _loc;
			private _vec = vectorUpVisual _loc;


			//setLastError("TODO: Check all variables on object" + str (allVariables _loc));
			// private _varmap = [];
			// {_varmap pushBack [_x,_loc getvariable _x]} foreach (allVariables _loc);


			callSelf(unloadModel); //now object deleted from world
			//assert(isNullReference(_loc));

			private _visObj = callSelfParams(InitModel,_pos arg _dir arg _vec);
			[[_pos,_cht] call noe_posToChunk,_cht,_visObj] call noe_registerObject;
		} else {
			private _loc = getSelf(loc);
			if isNullReference(_loc) exitwith {false};
			if !isTypeOf(_loc,BasicMob) exitwith {false};
			setSelf(model,_newmodel);
			if callSelf(isItem) then {callSelf(syncIcon);};
			callFuncParams(_loc,syncSlotInfo,getSelf(slot)); //for update icon
			callFuncParams(_loc,syncSmdSlot,getSelf(slot)); //for update render in proxy
		};
		true
	};

region(smelling)
	
	//источать запах. тип определяется параметром. вонь - stink, вкусный - delicious, резкий - pungent,отвратительный sickening 
	func(doSmell)
	{
		objParams_2(_type,_smellDist);
		if isNullVar(_type) then {_type = ""};
		if isNullVar(_smellDist) then {_smellDist = 5};
		private _typeText = "Чем-то пахнет.";
		private _modifPer = 0;
		private _vomitAdd = 0;
		call {
			if (_type=="stink") exitWith {
				_modifPer = 4;
				_typeText = pick["Тут воняет.","Чем-то воняет."];
				_vomitAdd = 3;
			};
			if (_type=="rotten") exitWith {
				_modifPer = 8;
				_typeText = pick["Гнильцой пахнет.","Гнилью воняет."];
				_vomitAdd = 10;
			};
			if (_type=="delicious") exitWith {
				_modifPer = 4;
				_typeText = pick["Вкусно пахнет.","Что за чудный запах?!","Приятно пахнет."];
				_vomitAdd = 0;
			};
			if (_type == "pungent") exitWith {
				_modifPer = 3;
				_typeText=pick["Ой. Что так странно пахнет?","Резкий какой-то запах."];
				_vomitAdd = 1;
			};
			if (_type == "sickening") exitWith {
				_modifPer = 6;
				_typeText=pick["Омерзительный запах.","Невыносимый запах.","Ужас! Тошнотворный запах.","Отвратительно пахнет."];
				_vomitAdd = 40;
			};
		};

		{
			if (isTypeOf(_x,Mob) && {callFunc(_x,isActive)}) then {
				//проверка скилла на Per
				//if DICE_ISSUCCESS(getRollType(callFuncParams(_x,checkSkill,"Per" arg _modifPer))) then {
					callFuncParams(_x,localSay,_typeText arg "mind");
				//};

				if (_vomitAdd > 0) then {
					modVar(_x,vomitAmount, + _vomitAdd);
				};
			};
		} foreach callSelfParams(getNearMobs,_smellDist arg false);
	};
	
	//возвращая пустую строчку ничем не пахнет
	func(getSmellInfo)
	{
		objParams_1(_distToTaget);
		""
	};

region(throwing and bullets functions)
	func(onThrowHit) //вызывается при попадании в цель
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_throwed);

	};

	//Тут обязательно нужно удалить пулю чтобы не вызывать утечек памяти
	func(onBulletAct) //вызывается при попадании пули в цель
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_throwed);
		callSelfParams(playSound,"guns\ric"+str randInt(1,5) arg randInt(0.85,1.15) arg 15 arg null arg _p); //_p is exref
		callSelfParams(applyDamage,_dam arg _type arg _p arg null);
		delete(_throwed);
	};

endclass

editor_attribute("InterfaceClass")
editor_attribute("HiddenClass")
class(IDestructible) extends(GameObject)

	"
		name:Разрушаемый игровой объект
		desc:Разрушаемый игровой объект. Все игровые объекты кроме мобов наследуются от данного класса.
		path:Игровые объекты
	"
	node_class

	//all info for this system in baisc set: B 557
	//Повреждения оружия на B 485

	//общие данные. Все значения отличные от нуля сбрасывают инициализацию своих значений
	var(ht,10); //Статическая переменная "здоровья" объекта. От этого скилла кидаются броски на разрушение
	var(hp,0);
		var(hpMax,0);
	var(dr,0);
		var(drMax,0);
	//звук повреждений
	getter_func(getDamageSound,"");
	getter_func(canApplyDamage,false);

	//complex - электронику, огнестрельное оружие, автотранспорт,роботов и большинство других механизмов
	//simple - ткани (плащи, занавески), мебель и контактное оружие, действующее на силе владельца
	//spreaded - рассеянные объекты например (сеть)
	getter_func(objectHealthType,"simple");

	//Вызывается при уничтожении игрового объекта
	func(onDestroyed)
	{
		objParams();
	};

	func(applyDamage)
	{
		// количество урона, тип повреждений, мировая позиция по которой пришлись повреждения, (опциональная) причина урона
		objParams_4(_amount,_type,_worldPos,_cause);
		if !callSelf(canApplyDamage) exitWith {};

		//сначала проходим через СП, потом мод. повр.
		_amount = (_amount - getSelf(dr)) max 0;

		if (callSelf(objectHealthType)=="complex")then{
			//DAMAGE_TYPE_IMPALING,DAMAGE_TYPE_PIERCING_HU modif x1
			if (_type == DAMAGE_TYPE_PIERCING_LA) exitWith {
				_amount = floor(_amount * 0.5);
			};
			if (_type == DAMAGE_TYPE_PIERCING_NO) exitWith {
				_amount = floor(_amount * 0.3);
			};
			if (_type == DAMAGE_TYPE_PIERCING_SM) exitWith {
				_amount = floor(_amount * 0.2);
			};
		} else {
			if (callSelf(objectHealthType)=="spreaded") then {
				if (_type in [DAMAGE_TYPE_IMPALING,DAMAGE_TYPE_PIERCING_SM,DAMAGE_TYPE_PIERCING_NO,DAMAGE_TYPE_PIERCING_LA,DAMAGE_TYPE_PIERCING_HU]) then {
					_amount = _amount min 1;
				} else {
					_amount = _amount min 2;
				};
			} else {
				//simple type objects
				if (_type in [DAMAGE_TYPE_IMPALING,DAMAGE_TYPE_PIERCING_HU]) exitWith {
					_amount = floor(_amount * 0.5);
				};
				if (_type == DAMAGE_TYPE_PIERCING_LA) exitWith {
					_amount = floor(_amount * 0.3);
				};
				if (_type == DAMAGE_TYPE_PIERCING_NO) exitWith {
					_amount = floor(_amount * 0.2);
				};
				if (_type == DAMAGE_TYPE_PIERCING_SM) exitWith {
					_amount = floor(_amount * 0.1);
				};
			};
		};
	/*	//По правилам, описанным на B 380 мы применяем модификатор повреждений в этом методе, вместо стандартного модификатора
		private _passed = //[
			(_amount - getSelf(dr)) max 0
		//] call gurps_applyDamageType
		;*/
		callSelfParams(onAffectDamageToPos,_passed arg _type arg _worldPos arg _cause);

		modSelf(hp,- _passed);
		private _newhp = getSelf(hp);
		private _maxhp = getSelf(hpMax);

		if (_newhp < (round(_maxhp/3)) && _newhp > 0) exitWith {
			callSelfParams(onChangeObjectHP,1);
			//понижение эффективности предмета
		};
		if (_newhp <= 0 && _newhp > (-1*_maxhp)) exitWith {
			callSelfParams(onChangeObjectHP,2);
			private _rr = (getSelf(ht) call gurps_rollstd);
			if (getRollType(_rr) in [DICE_FAIL,DICE_CRITFAIL]) then {
				callSelf(onDestroyed);
				delete(this);
			};
		};
		if (_newhp <= (-1*_maxhp) && _newhp > (-5*_maxhp)) exitWith {
			callSelfParams(onChangeObjectHP,3);
			private _rr = (getSelf(ht) call gurps_rollstd);
			if (getRollType(_rr) in [DICE_FAIL,DICE_CRITFAIL]) then {
				callSelf(onDestroyed);
				delete(this);
			};
		};
		if (_newhp <= (-5*_maxhp)) exitWith {
			callSelfParams(onChangeObjectHP,4);
			callSelf(onDestroyed);
			delete(this);
		};
		errorformat("IDestructible::applyDamage() - no affect damage: hp %1; max hp %2",_newhp arg _maxhp);
	};

	func(onChangeObjectHP)
	{
		objParams_1(_type); //1,2,3,4 => 1/3HP, 0HP, -1HP, -5HP
	};

	//Пользовательское событие когда повреждения применяются в определённую точку
	func(onAffectDamageToPos)
	{
		objParams_4(_passedDamage,_type,_worldPos,_cause);
		traceformat("AFFECT DAM %1 %2 %3",_passedDamage arg _type arg _worldPos);
	};

	func(constructor)
	{
		objParams();

		//germs
		if isTypeOf(this,Item) then {
			if isTypeOf(this,SystemItem) exitWith {};
			if (callSelf(isFood)) exitWith {};
			if (getSelf(germs) == -1) exitWith {};
			private _prob = ifcheck(equals(getSelf(attachedWeap),weaponModule(WeapHandyItem)),50,5);
			if prob(_prob) then {
				setSelf(germs,randInt(1,30));
			};
		} else {
			setSelf(germs,randInt(-10,50) max 0);
		};


		//no damage - no hp
		if !callSelf(canApplyDamage) exitWith {};

		private _ft = kgToLb(callSelf(getWeight));
		private _type = callSelf(objectHealthType);
		private _val = 0;

		if (getSelf(hp)>0) then {
			setSelf(hpMax,getSelf(hp));
		} else {
			_val = if (_type == "complex") then {
				ceil(4 * (_ft ^ (1/3)))
			} else {
				ceil(8 * (_ft ^ (1/3)))
			};
			setSelf(hp,_val);
			setSelf(hpMax,_val);
		};

		if (getSelf(dr)>0) then {
			setSelf(drMax,getSelf(dr));
		} else {
			if (_type == "simple") then {

			};
		};
	};
	
	
	var(germs,0);//сколько микробов на объекте (для инфекций)

	//функция, получающая с помощью рейкаста объект, на котором лежит этот объект
	func(getObjectPlace)
	{
		objParams();
		if !callSelf(isInWorld) exitWith {nullPtr};
		private _baseModelPos = callSelf(getModelPosition);
		private _obj = ([_baseModelPos vectorAdd [0,0,-0.001],_baseModelPos vectorAdd [0,0,-100]] call si_getIntersectData) select 0;
		private _vobj = [_obj] call si_handleObjectReturnCheckVirtual;
		if isNullReference(_vobj) exitWith {nullPtr};
		_vobj;
	};


	//хранилище для статусэффектов
	var(__statusEffects,null);
	
	func(addStatusEffect)
	{
		objParams_1(_statusEffect);
		private _se = getSelf(__statusEffects);
		if isNullVar(_se)then{
			_se = [];
			setSelf(__statusEffects,_se);
		};
		if equalTypes(_statusEffect,"") then {
			_statusEffect = instantiate(_statusEffect);
		};
		if !isTypeOf(_statusEffect,SEDiseaseBase) exitWith {
			errorformat("IDestructible::addStatusEffect() - invalid status effect type %1",_statusEffect);
			delete(_statusEffect);
			false;
		};
		_se pushBack _statusEffect;
		
		setVar(_statusEffect,loc,this);

		setVar(_statusEffect,longevityStartTime,tickTime);

		true;
	};

	func(removeStatusEffect)
	{
		objParams_1(_type);
		private _se = getSelf(__statusEffects);
		
		if isNullVar(_se) exitWith{
			errorformat("IDestructible::removeStatusEffect() - no status effects storage loaded. Cant delete %1",_type);
			false;
		};
		if equalTypes(_type,nullPtr) then {
			_se deleteAt (_se find _type);
		} else {
			_se deleteAt (_se findif {_type == callFunc(_x,getClassName)});
		};

		if (count _se == 0) then {
			setSelf(__statusEffects,null);
		};
		
		true;
	};

	// "
	// 	name:Установка света
	// 	desc:Включает или выключает освещение для данного объекта
	// "
	// node_met
	// func(lightSetMode) {objParams_1(_m); setLastError("Установка света не поддерживается для класса " + callSelf(getClassName));};

	__iseat_node_init__ = true;
	__iseat_node_postfix = endl + "path:Игровые объекты.Сиденья";
	#include "Interfaces\ISeat.Interface"
	__iseat_node_init__ = null;
	__iseat_node_postfix = null;

endclass
