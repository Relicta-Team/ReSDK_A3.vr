// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"
#include "..\struct.hpp"
#include "GameConstants.hpp"
#include "..\ServerRpc\serverRpc.hpp"
#include "..\Networking\Network.hpp"
#include <..\..\client\Inventory\inventory.hpp>
#include <..\PointerSystem\pointers.hpp>
#include <..\NOEngine\NOEngine_SharedTransportLevel.hpp>

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

	verbListOverride("pull pulltransform extinguish craft_here description mainact"); //список действий которые можно сделать с ЭТИМ объектом

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
		return:bool:Является ли объект источником света
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
		return:bool:Является ли объект реагент-хранилищем
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

	//TODO remove
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
	var(weight,0);//вес в граммах

	//перетаскивание
	getter_func(isMovable,false); //объект движим
	var(__moverMobs,[]);// кто двигает предмет

	//рандомизатор веса
	getterconst_func(canApplyWeightRandomize,false);
	getterconst_func(getWeightRandomCoeff,vec2(0,0));
	getterconst_func(getWeightRandomPrecision,2);//сколько знаков после нуля доступно

	//editor_attribute("ReadOnly")
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

		if callSelf(canApplyWeightRandomize) then {
			private _oldWeight = getSelf(weight);
			callSelf(getweightRandomCoeff) params [["_min",0],["_max",0]];
			private _rval = parseNumber (rand(_min,_max) toFixed callSelf(getWeightRandomPrecision));
			setSelf(weight,_oldWeight + _rval);
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

		private _otherText = if (isTypeOf(this,Decor) || isTypeOf(this,IStruct)) then {""} else {
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

			if (callFuncParams(_usr,getDistanceTo,this) < 5) then {
				modvar(_otherText) + sbr + (
					if (
						callSelf(canApplyDamage)
						&& callSelf(getClassName) != "IStruct" //!temporary fix. remove in next versions
						) then {
					private _drTexts = ["Беззащитно","Слабенько защищено","Выглядит крепко","Хорошо защищено","Отличная защита"];
					private _drConv = round (linearConversion [0, 8, getSelf(dr),0,4,true]);
					
					format[
						'Состояние: %1 - %2br_inlineКачество: %3',
						callSelfParams(getHPStatusText,true),
						_drTexts select _drConv,
						callSelf(getHTStatusText)
					]
				} else {
					format[
						"Выглядит %1. Никому %2 разрушить такое...",
						pick["крайне древне","так старо","очень древне","на сотни колен"],
						pick["не подвластно","не дозволено","не смочь","не найти сил","не суметь"],
						pick["такое","это",callSelfParams(getNameFor,_usr)]
					]
				});
			};
			

			#ifdef EDITOR
			modvar(_otherText) + sbr + callSelf(getObjectHealth_Editor)
			#endif
		};

		callFunc(_usr,generateLastInteractOnServer);
		if equals(this,callFunc(_usr,getLastInteractTarget)) then {
			private _ch = [callFunc(_usr,getLastInteractEndPos) call atmos_chunkPosToId] call atmos_getChunkAtChIdUnsafe;
			if !isNullVar(_ch) then {
				private _inf = _ch call ["getChunkUserInfo",[_usr]];
				if (_inf!=stringEmpty) then {
					modvar(_otherText) + sbr + _inf;
				};

			};
		};

		
		//ddat = [_rand,_postrand,_icon,callSelfParams(getNameFor,_usr),_desc,_otherText];
		format[_rand + _postrand,_icon + callSelfParams(getNameFor,_usr)] +
		_desc +
		_otherText;
	};

	func(getObjectHealth_Editor)
	{
		objParams();
		private _m = format["HP (%1/%2); DR (%3/%4); HT %5",getSelf(hp),getSelf(hpMax),getSelf(dr),getSelf(drMax),getSelf(ht)];
		if callSelf(canApplyDamage) then {

		} else {
			_m = setstyle("БЕЗ УРОНА: ",style_redbig) + _m;
		};
		_m
	};

	go_internal_updateMethodsAfterStart = [];

	editor_attribute("InternalImpl")
	var(_update_handle_auto,-1);

	getter_func(isScriptedObject,false);

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

	func(setWeight)
	{
		objParams_1(_w);
		setSelf(weight,_w);
		callSelf(onWeightChanged);
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

		if callSelf(isFlying) exitWith {
			assert_str(!isNullVar(__INTERNAL_THROWED_VIRTUAL__),"Object is flying but visual object is null -> __INTERNAL_THROWED_VIRTUAL__");
			__INTERNAL_THROWED_VIRTUAL__
		};

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
		in:GameObject:Объект-цель:Объект, до которого рассчитывается расстояние
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

	//расширенный метод получения базовой локации объекта
	func(getSourceLocEx)
	{
		params ['this',"_owningList"];
		if isNullVar(_owningList) then {_owningList = []};
		private _curLoc = this;
		private _probNewLoc = nullPtr;
		while {true} do {
			_probNewLoc = getVar(_curLoc,loc);
			if (isNullVar(_probNewLoc) || {equalTypes(_probNewLoc,objNUll)}) exitWith {};
			if callFunc(_probNewLoc,isMob) exitWith {};
			
			_curLoc = _probNewLoc;
			_owningList pushBack _probNewLoc;
		};
		if isNullVar(_curLoc) exitWith {nullPtr};
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
			#ifdef EDITOR_OR_SP_MODE
			if isNullVar(_x) then {continue};
			#endif
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
		params ['this',"_path",["_pitch",1],["_maxDist",50],["_vol",1],"_atPos",["_hasRTProcess",true],["_offset",0]];
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
		if (_offset > 0) then {
			_data append [null,_offset]; //null is file extension
		};

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

		//request for update atmos chunk
		private _ch = [(getposatl getSelf(loc))call atmos_chunkPosToId] call atmos_getChunkAtChId;
		_ch set ["flagUpdObj",true];
		callSelf(onUpdatePosition);

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
			if not_equalTypes(_vecOrDist,0) then {_vecOrDist = null};
			if not_equalTypes(_dir,0) then {_dir = null};
			_wobj = [this,_pos,_vecOrDist,_dir] call noe_loadVisualObject_OnDrop;
		} else {
			_wobj = [this,_pos,_dir,_vecOrDist] call noe_loadVisualObject;
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
				error("GameObject::replicateObject() - getChunkType returns null");
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
		//_p is outref
		private _drObj = getSelf(dr);
		callSelfParams(applyDamage,_dam arg _type arg _p arg "throw_hit");

		//! THIS CAN BE THROWS ERROR BECAUSE _throwed.loc - is flyingObject
		callFuncParams(_throwed,onAttackedObject,this arg _dam arg _drObj arg _p arg "throwed");
	};

	//Тут обязательно нужно удалить пулю чтобы не вызывать утечек памяти
	func(onBulletAct) //вызывается при попадании пули в цель
	{
		objParams_6(_dam,_type,_sel,_usr,_dist,_throwed);
		if !callFunc(_throwed,isNonLethalAmmo) then {
			callSelfParams(playSound,"guns\ric"+str randInt(1,5) arg randInt(0.85,1.15) arg 15 arg null arg _p); //_p is exref
			callSelfParams(applyDamage,_dam arg _type arg _p arg null);
		};
		delete(_throwed);
	};

endclass

editor_attribute("InterfaceClass")
editor_attribute("HiddenClass")
class(IDestructible) extends(GameObject)

	"
		name:Разрушаемый игровой объект
		desc:Разрушаемый игровой объект. Все игровые объекты кроме мобов наследуются от данного класса.
		path:Игровые объекты.Базовые
	"
	node_class

	"
		name:Скрипт
		desc:Возвращает ссылку на скрипт, привязанный к игровому объекту.
		type:get
		classprop:0
		return:object^:Ссылка на скрипт
	" node_var
	var(__script,nullPtr);
	"
		name:Это скриптовый объект
		desc:Возвращает @[bool ИСТИНУ], если игровой объект является скриптовым объектом.
		type:get
		lockoverride:1
		classprop:0
		return:bool:Является ли объект скриптовым объектом
	" node_met
	getter_func(isScriptedObject,!isNullReference(getSelf(__script)));

	func(destructor)
	{
		objParams();
		private _script = getSelf(__script);
		if !isNullReference(_script) then {
			delete(_script);
		};

		private _ccomp = getSelf(craftComponent);
		if !isNullVar(_ccomp) then {
			_ccomp callv(releaseComponent);
		};

		{
			_x set ["flagUpdObj",true];
			false;
		} count (values getSelf(__atm_ownerChunks));
	};

	func(onUpdatePosition)
	{
		objParams();
		{
			_x set ["flagUpdObj",true];
			false;
		} count (values getSelf(__atm_ownerChunks));
		setSelf(__atm_ownerChunks,createHashMap);

		//TODO определение НИЗА модели
		if (true) exitWith {};

		//update simulation
		/*
			Цель - получить все объекты, граничащие с чанками этого объекта
			1. Получаем чанки с помощью [this,true,false] atmos_getObjectOwnedChunks
			2. Получаем полный список объектов в каждом чанке
		*/
		private _chObjList = [this,true,false] call atmos_getObjectOwnedChunks;
		private _mapObjAll = createHashMap;
		private _needSim = [];
		traceformat("CHUNKS COUNT: %1",count _chObjList);
		{
			{
				if !array_exists(_mapObjAll,getVar(_x,pointer)) then {
					_mapObjAll set [getVar(_x,pointer),_x];
					traceformat("CHECK OPENSPACE %1 - %2",_x arg callFunc(_x,isInOpenSpace))
					if callFunc(_x,isInOpenSpace) then {
						_needSim pushBack _x;
					};
				};
				false;
			} count (_x callv(getObjectsInChunk));
			false
		} count _chObjList;

		//TODO sorting by z-value
		{
			callFunc(_x,onObjectFalling);
		} count _needSim;
	};

	#define DEBUG_VISUAL_OBJECTFALLING

	#ifndef EDITOR
		#undef DEBUG_VISUAL_OBJECTFALLING
	#endif

	func(onObjectFalling)
	{
		objParams();
		//if isNullReference(this) exitWith {false};

		private _visObj = callSelf(getBasicLoc);
		private _p1 = _visObj modelToWorldVisual [0,0,0];
		private _p2 = _p1 vectorAdd [0,0,-1000];

		private _iDat = [_p1,_p2,_visObj,
		#ifdef EDITOR
		noe_client_allPointers getOrDefault [getSelf(pointer),objNull]
		#else
		objNull
		#endif
		] call si_getIntersectData;
		
		#ifdef DEBUG_VISUAL_OBJECTFALLING
		if !isNull(debug_objfalling_list) then {{deletevehicle _x} foreach debug_objfalling_list};
		debug_objfalling_list = [];
		assert_str(!isNull(atmos_debug_createSphere),"atmos_debug_createSphere must be defined");
		_s1 = [1,0,0] call atmos_debug_createSphere;
		_s2 = [0,1,0] call atmos_debug_createSphere;
		_s1 setposatl _p1;
		_s2 setposatl ifcheck(isNullReference(_iDat select 0),_p2,_iDat select 1);
		debug_objfalling_list append vec2(_s1,_s2);
		#endif

		if isNullReference(_iDat select 0) exitWith {false};

		
		{
			callFuncParams(_x,interpolate,"auto_trans_fall" arg this arg getSelf(pointer));
		} foreach callSelfParams(getNearMobs,20);
		
		callSelfParams(setPos__,_iDat select 1);

		private _dam = D6 * 5; //TODO расчет урона от дистанции падения+ объемов объекта
		//TODO урон по объектам, на которые упал этот объект
		callSelfAfterParams(applyDamage,rand(1.2,1.3),_dam arg DAMAGE_TYPE_CRUSHING arg _iDat select 1);
		true
	};

	//set positiof of world object with replication
	func(setPos__) //name is temporary
	{
		objParams_1(_pos);
		if !callSelf(isInWorld) exitWith {};

		private _wobj = callSelf(getBasicLoc);
		_wobj setposatl _pos;
		callSelf(replicateObject);
	};

	//set new position with interpolation
	func(changePosition)
	{
		objParams_2(_pos,_interp);
		if !callSelf(isInWorld) exitWith {};
		if isNullVar(_interp) then {_interp = true};

		if (_interp) then {
			{
				callFuncParams(_x,interpolate,"auto_trans_fall" arg this arg getSelf(pointer));
			} foreach callSelfParams(getNearMobs,20);
		};

		callSelfParams(setPos__,_pos);
	};

	func(getNewTransform)
	{
		params ['this',["_down",-90],["_dir",random 360],["_force",2],["_addIgnored",[]]];
		private _startPos = callSelf(getPos);
		_force = clamp(_force,1,10);
		private _ign = [this];
		_ign append _addIgnored;
		[
			this,
			_startPos,
			[_down,0,_dir],
			_force,
			null,
			null,
			_ign
		] call si_rayTraceProcess;
	};

	//todo optimize transport (from replicateObject to replicateTransform)
	func(setTransform)
	{
		objParams_2(_p,_rot);
		if !callSelf(isInWorld) exitWith {false};
		assert_str(callSelf(isEnabledTransformMode),"Transform mode for pointer must be enabled -> " + getSelf(pointer));
		private _wobj = getSelf(loc);
		
		if !isNullVar(_rot) then {
			if equalTypes(_rot,0) then {
				_wobj setDir _rot;
			} else {
				//conv to vec-coords
				if (count _rot == 3) then {
					_rot = _rot call model_convertPithBankYawToVec;
				};
				_rot params ["_vdr","_vup"];
				_wobj setvectordirandup _rot;
			};
		};
		
		_wobj setPosWorld (atltoasl _p);

		traceformat("Replicate object %1 (wpos %4); %2 %3",getSelf(pointer) arg _p arg _rot arg _posworld)

		callSelf(replicateObject);

		true
	};

	//return in struct vec2(pos[ATL|world],rot) - rot is float or vec3 (see model_getPitchBankYaw)
	func(getTransform)
	{
		objParams();
		if !callSelf(isInWorld) exitWith {null};
		private _wobj = getSelf(loc);
		[
			ifcheck(_wobj getVariable vec2("wpos",false),getPosWorld _wobj,getPosAtl _wobj),
			ifcheck(_wobj getVariable vec2("vdir",false),getDir _wobj,[_wobj] call model_getPitchBankYaw)
		]
	};

	func(setTransformMode)
	{
		objParams_2(_mode,_replicate);
		if !callSelf(isInWorld) exitWith {};
		private _wobj = getSelf(loc);
		if (_mode) then {
			if !(_wobj getVariable ["wpos",false]) then {
				(_wobj setVariable ["flags",(_wobj getvariable "flags") + wposObj_true]);
			};
			_wobj setVariable ["wpos",true];
			if !(_wobj getVariable ["vdir",false]) then {
				(_wobj setVariable ["flags",(_wobj getvariable "flags") + vDirObj_true]);
			};
			_wobj setVariable ["vdir",true];
		} else {
			if (_wobj getVariable ["wpos",false]) then {
				(_wobj setVariable ["flags",(_wobj getvariable "flags") - wposObj_true]);
			};
			_wobj setVariable ["wpos",null];
			if (_wobj getVariable ["vdir",false]) then {
				(_wobj setVariable ["flags",(_wobj getvariable "flags") - vDirObj_true]);
			};
			_wobj setVariable ["vdir",null];
		};
		
		if !isNullVar(_replicate) then {_replicate = true};

		if (_replicate) then {
			callSelf(replicateObject);
		};
	};
	func(isEnabledTransformMode)
	{
		objParams();
		if !callSelf(isInWorld) exitWith {false};
		private _wobj = getSelf(loc);
		(_wobj getVariable ["wpos",false]) && (_wobj getVariable ["vdir",false])
	};

	func(replicateTransform)
	{
		objParams();
		if callSelf(isInWorld) then {
			private _cht = callSelf(getChunkType);
			if isNullVar(_cht) exitWith {
				error("GameObject::replicateTransform() - getChunkType returns null");
				false
			};
			[getSelf(loc),_cht,true] call noe_replicateTransform;

			true
		} else {
			false
		};
	};

	#define DEBUG_VISUAL_OPENSPACE

	#ifndef EDITOR
		#undef DEBUG_VISUAL_OPENSPACE
	#endif

	//функция проверки находится ли объект в воздухе
	func(isInOpenSpace)
	{
		objParams();
		private _visObj = callSelf(getBasicLoc);
		private _bbx = boundingBoxReal [_visObj,"Geometry"];
		private _lowerZ = _bbx select 0 select 2;
		private _poses = [
			_bbx select 0 select [0,2],
			_bbx select 1 select [0,2],
			[_bbx select 0 select 0,_bbx select 1 select 1],
			[_bbx select 1 select 0,_bbx select 0 select 1]
		] apply {
			asltoatl (
				_visObj modelToWorldVisualWorld  (_x vectoradd [0,0,_lowerZ])
			)
		};

		//additional positions workaround
		private _added = [];
		{
			_added pushBack ([_x] call getPosListCenter);
		} foreach [
			[_poses select 1,_poses select 2],
			[_poses select 1,_poses select 3],
			[_poses select 0,_poses select 2],
			[_poses select 0,_poses select 3]
		];
		_poses append _added;

		private _iDat = null;
		private _countConnections = 0;

		#ifdef DEBUG_VISUAL_OPENSPACE
		if !isNull(debug_openspace_list) then {{deletevehicle _x} foreach debug_openspace_list};
		debug_openspace_list = [];
		assert_str(!isNull(atmos_debug_createSphere),"atmos_debug_createSphere must be defined");
		{
			_s1 = [1,0,1] call atmos_debug_createSphere;
			_s2 = objNull;
			_s1 setposatl _x;
			private _iDatDebug = [_x,_x vectoradd [0,0,-.2],_visObj] call si_getIntersectData;
			if !isNullReference(_iDatDebug select 0) then {
				_s2 = [0,1,0] call atmos_debug_createSphere;
				_s2 setposatl (_iDatDebug select 1);
			} else {
				_s2 = [1,0,0] call atmos_debug_createSphere;
				_s2 setposatl (_x vectoradd [0,0,-.2]);
			};
			debug_openspace_list append vec2(_s1,_s2);
		} foreach _poses;
		#endif
		#ifdef EDITOR
		private _toUnhide = [];
		{
			if !(isObjectHidden _x) then {
				_x hideObject true;
				_toUnhide pushBack _x;
			};
		} foreach (values noe_client_allPointers);
		#endif
		{

			_iDat = [_x,_x vectorAdd [0,0,-0.2],_visObj] call si_getIntersectData;

			if !isNullReference(_iDat select 0) then {
				INC(_countConnections);
			};
			false;
		} count _poses;

		#ifdef EDITOR
		{_x hideObject false} foreach _toUnhide;
		#endif

		#ifdef DEBUG_VISUAL_OPENSPACE
		traceformat("IDestructible::isInOpenSpace: _countConnections = %1",_countConnections);
		#endif

		_countConnections <= 3//8=>примерно треть для устойчивости объекта
	};

	getter_func(isMovable,false);

	//all info for this system in baisc set: B 557
	//Повреждения оружия на B 485

	//общие данные. Все значения отличные от нуля сбрасывают инициализацию своих значений
	/*
		Здоровье объекта.
		показывает вероятность того, что объект сломается от давления или нападения.

		Мечи,столы, щиты и другие цельные однородные объекты ЗД 12.
		Дешёвые, прихотливые или плохо содержащиеся вещи получают от -1 до -3 к ЗД;
		качественно или грубо сделанные получают +1 или +2 к ЗД.
		Большинство машин и подобных артефактов в хорошем состоянии имеют ЗД 10.
	*/
	"
		name:Качество
		desc:Возвращает @[int качество] игрового объекта. Среднее значение равно 10. Чем выше качество, тем ценее и прочнее предмет.
		prop:all
		classprop:1
		return:int:Качество игрового объекта
	" node_var
	var(ht,10); //Статическая переменная "здоровья" объекта. От этого скилла кидаются броски на разрушение

	/*
		ЕЖ предмета.
		количество повреждений, которое объект может вынести, прежде чем сломается или прекратит функционировать
	*/
	"
		name:Здоровье
		desc:Возвращает текущее здоровье игрового объекта. Оно варьируется от максимального здоровья до пятикратного отрицательного значения от максимального здоровья. Наприме, при максимальном здоровье 5 минимальное здоровье после которого предмет будет уничтожен будет -25 (5 * -5)
		prop:get
		classprop:1
		return:int:Здоровье
	" node_var
	var(hp,0);
		"
			name:Максимальное здоровье
			desc:Возвращает максимальное здоровье игрового объекта. Это значение никогда не может быть меньше 0.
			prop:get
			classprop:1
			return:int:Максимальное здоровье
		" node_var
		var(hpMax,0);
	/*
		СП объекта.
		Деревянные и пластиковые инструменты, устройства, мебель и т.д. обычно имеют СП 2.
		Маленькие металлические, деревянно-металлические или композитные объекты, например топоры и пистолеты, обычно имеют СП 4.
		Цельнометаллическое оружие ближнего боя имеет СП 6
	*/
	var(dr,0);
		var(drMax,0);
	getter_func(canApplyDamage,false);

	//complex - электронику, огнестрельное оружие, автотранспорт,роботов и большинство других механизмов
	//simple - ткани (плащи, занавески), мебель и контактное оружие, действующее на силе владельца
	//spreaded - рассеянные объекты например (сеть)
	getter_func(objectHealthType,OBJECT_TYPE_SIMPLE);

	//Вызывается при уничтожении игрового объекта
	func(onDestroyed)
	{
		objParams();
		private _p = callSelf(getModelPosition);
		for "_i" from 1 to randInt(3,6) do {
			private _worldPos = _p vectorAdd [rand(-0.2,0.2),rand(-0.2,0.2),rand(-0.2,0.2)];
			callSelfParams(sendDamageVisualOnPos,_worldPos arg true arg true arg false);
		};

		callSelf(dropDebrisOnDestroy);
	};
	
	//Отметка времени последнего урона огнём
	var(__atm_lastFireDamage,0);
	//Здесь хранятся ссылка на чанки, которые владеют этим объектом. key:chId, value:AtmosChunk
	var(__atm_ownerChunks,createHashMap);

	func(applyDamage)
	{
		// количество урона, тип повреждений, мировая позиция по которой пришлись повреждения, (опциональная) причина урона
		objParams_4(_amount,_type,_worldPos,_cause);
		//traceformat("%1::applyDamage main - count: %2; dt: %3; pos: %4; cause: %5",this arg _amount arg _type arg _worldPos arg _cause);
		private _canUseEffect = true;
		private _canUseSound = true;
		private _useBlockSound = true;
		private _effector = {
			if !isNullVar(_worldPos) then {
				callSelfParams(sendDamageVisualOnPos,_worldPos arg _canUseEffect arg _canUseSound arg _useBlockSound);
			};
		};

		if (!callSelf(canApplyDamage) || callSelf(getClassName) == "IStruct") exitWith {
			_canUseEffect = false;
			call _effector;
		};

		//сначала проходим через СП, потом мод. повр.
		_amount = (_amount - getSelf(dr)) max 0;

		if (callSelf(objectHealthType)==OBJECT_TYPE_COMPLEX)then{
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
			if (callSelf(objectHealthType)==OBJECT_TYPE_SPREADED) then {
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
		
		callSelfParams(onAffectDamageToPos,_amount arg _type arg _worldPos arg _cause);

		_canUseEffect = _amount > 0;
		_useBlockSound = _amount <= 0;
		call _effector;

		modSelf(hp,- _amount);
		private _newhp = getSelf(hp);
		private _maxhp = getSelf(hpMax);

		if (_newhp < (round(_maxhp/3)) && _newhp > 0) exitWith {
			callSelfParams(onChangeObjectHP,1);
			//понижение эффективности предмета
		};
		if (_newhp <= 0 && _newhp > (-1*_maxhp)) exitWith {
			callSelfParams(onChangeObjectHP,2);
			private _rr = (getSelf(ht) call gurps_rollstd);
			if DICE_ISFAIL(getRollType(_rr)) then {
				//?тест. снижаем dr объекта
				private _oldDr = getSelf(dr);
				if (_oldDr>0) then {
					setSelf(dr,(_oldDr - 1) max 0);
				};
			};
		};
		if (_newhp <= (-1*_maxhp) && _newhp > (-5*_maxhp)) exitWith {
			callSelfParams(onChangeObjectHP,3);
			private _rr = (getSelf(ht) call gurps_rollstd);
			if DICE_ISFAIL(getRollType(_rr)) then {
				callSelf(onDestroyed);
				delete(this);
			};
		};
		if (_newhp <= (-5*_maxhp)) exitWith {
			callSelfParams(onChangeObjectHP,4);
			callSelf(onDestroyed);
			delete(this);
		};
		//errorformat("IDestructible::applyDamage() - no affect damage: hp %1; max hp %2; Amount %3",_newhp arg _maxhp arg _amount);
	};

	func(onAttackedObject)
	{
		objParams_5(_targ,_dam,_targDr,_pos,_reason);
		
		private _weapDamage = (getSelf(dr) + randInt(1,4)) max 0;
		private _mod = 0;
		if (isTypeOf(this,IMeleeWeapon) || isTypeOf(this,IRangedWeapon)) then {
			modvar(_mod) + 4;
		};
		
		traceformat("onAttachedObject: %1 => %2 [%3;%4]:: %5 (mod: %6)",this arg _targ arg _dam arg _targDr arg _weapDamage arg _mod)

		if !([getSelf(ht) + _mod] call gurps_probSuccess) then {
			//weapon damage after attack
			callSelfParams(applyDamage,_weapDamage max 0 arg DAMAGE_TYPE_CRUSHING arg _pos arg _reason);
		};
	};

	//получает эффективный урон против объекта
	func(getEfficiencyOnAttack)
	{
		objParams_2(_dam,_targ);
		private _mat = callFunc(_targ,getMaterial);
		if !isNullReference(_mat) then {
			private _modifWeaponDamage = callFunc(_mat,getDamageCoefOnAttack);
			_dam = round(_dam*_modifWeaponDamage);
		};
		_dam
	};

	func(getHPStatusText)
	{
		objParams_1(_addClr);
		if isNullVar(_addClr) then {_addClr = false};
		private _curClr = "ffffff";
		
		private _tval = call {
			private _hp = getSelf(hp);
			private _maxhp = getSelf(hpMax);
			if (_hp < (round(_maxhp/3)) && _hp > 0) exitWith {
				_curClr = "207332";
				"Повреждено"
			};
			if (_hp <= 0 && _hp > (-1*_maxhp)) exitWith {
				_curClr = "3D541D";
				"Сильно повреждено"
			};
			if (_hp <= (-1*_maxhp) && _hp > (-5*_maxhp)) exitWith {
				_curClr = "992C08";
				//private _idx = round linearConversion [-5*_maxhp,-1*_maxhp,_hp,0,4,true];
				//["Почти уничтожено",""] select _idx
				"Почти " + (pick["разрушено","уничтожено","сломано","раздолбано"])
			};
			if (_hp > 0) exitWith {
				_curClr = "00C12B";
				"Нормальное"
			};
			_curClr = "ff0000";
			"Уничтожено"
		};
		ifcheck(_addClr,format["<t color='#%1'>%2</t>" arg _curClr arg _tval],_tval);
	};

	func(getHTStatusText)
	{
		objParams();
		private _ht = getSelf(ht);
		if (_ht <= 2) exitWith {"Отвратительное"};//2
		if inRange(_ht,3,5) exitWith {"Ужасное"}; //3
		if (inRange(_ht,6,8)) exitWith {"Плохое"}; //3
		if inRange(_ht,9,11) exitWith {"Обычное"}; //3
		if inRange(_ht,12,13) exitWith {"Хорошее"}; //2
		if inRange(_ht,13,14) exitWith {"Отличное"};//2
		if inRange(_ht,15,16) exitWith {"Превосходное"};//2
		if (_ht >= 17) exitWith {"Великолепное"};//2
	};

	func(onChangeObjectHP)
	{
		objParams_1(_type); //1,2,3,4 => 1/3HP, 0HP, -1HP, -5HP
	};

	//Пользовательское событие когда повреждения применяются в определённую точку
	func(onAffectDamageToPos)
	{
		objParams_4(_passedDamage,_type,_worldPos,_cause);
		//traceformat("AFFECT DAM %1 %2 %3",_passedDamage arg _type arg _worldPos);
	};

	func(constructor)
	{
		objParams();

		callSelf(initCraftSystem);

		private _mat = getSelf(material);
		if equalTypes(_mat,"") then {
			_mat = _mat call mat_getByClass;
			setSelf(material,_mat);
		};

		//germs
		if isTypeOf(this,Item) then {
			if isTypeOf(this,SystemItem) exitWith {};
			if (callSelf(isFood)) exitWith {};
			if (getSelf(germs) == -1) exitWith {};
			private _prob = ifcheck(equals(getSelf(attachedWeap),weaponModule(WeapHandyItem)),50,5);
			if prob(_prob) then {
				callSelfParams(setGerms,randInt(1,30));
			};
		} else {
			callSelfParams(setGerms,randInt(-10,50) max 0);
		};


		//no damage - no hp
		if !callSelf(canApplyDamage) exitWith {};

		private _type = callSelf(objectHealthType);
		private _val = 0;

		if (getSelf(hp)>0) then {
			setSelf(hpMax,getSelf(hp));
			if !callSelf(isItem) then {
				setSelf(weight,([this] call gurps_calculateConstructionWeight) * 1000);
			};
		} else {
			callSelf(generateObjectHP);
		};

		if (getSelf(dr)>0) then {
			setSelf(drMax,getSelf(dr));
		} else {
			if (_type == "simple") then {

			};
		};
	};

	func(generateObjectHP)
	{
		objParams();
		private _val = 1;
		if callSelf(isItem) then {
			_val = [this] call gurps_calculateItemHP;
		} else {
			private _dwt = getSelf(weight);
			if equals(_dwt,0) then {
				private _weightTn = [this] call gurps_calculateConstructionWeight;
				_val = [_weightTn] call gurps_calculateConstructionHP;
				//lb to kg
				setSelf(weight,_weightTn * 1000);
			} else {
				_val = [_dwt / 1000] call gurps_calculateConstructionHP;
			};
		};
		setSelf(hp,_val);
		setSelf(hpMax,_val);
	};

	//коэффициент для авторасчета веса. это делитель веса объекта. для мебели например 10
	getterconst_func(getCoefAutoWeight,1);

	//TODO replace to nullptr and refactoing all checks
	var(material,null);//string|object
	func(getMaterial)
	{
		objParams();
		private _mObj = getSelf(material);
		if isNullVar(_mObj) exitWith {nullPtr};
		if not_equalTypes(_mObj,nullPtr) exitWith {nullPtr};
		_mObj
	};

	func(sendDamageVisualOnPos)
	{
		objParams_4(_pos,_doEffect,_doSound,_useBlockSound);
		if isNullVar(_doEffect) then {_doEffect = true};
		if isNullVar(_doSound) then {_doSound = false};
		if isNullVar(_useBlockSound) then {_useBlockSound = true};

		private _mat = getSelf(material);
		if isNullVar(_mat) exitWith {};

		if (_doEffect) then {
			private _emt = callFunc(_mat,getDamageEffect);
			{
				callFuncParams(_x,sendInfo,"do_fe" arg [_pos arg _emt arg _norm]);
			} foreach callSelfParams(getNearMobs,20);
		};


		if (_doSound) then {
			private _sound = ifcheck(_useBlockSound,callFunc(_mat,getResistSound),callFunc(_mat,getDamageSound));
			if (_sound == stringEmpty) exitWith {};
			callSelfParams(playSound,_sound arg rand(0.85,1.15) arg 15 arg null arg _pos);
		};
	};

	//функция создает частицы и раскидывает их вокруг объекта
	func(dropDebrisOnDestroy)
	{
		objParams();
		
		//nonworld objects cannot drop debris
		if !callSelf(isInWorld) exitWith {};

		private _typeList = callSelf(getOnDestroyTypes);
		//_typeList = ["TorchDisabled"];//!for debug only

		if (count _typeList == 0) exitWith {}; //nothing to drop 
		/*
			Стандартная формула расчета количества частиц из объекта:
			round(hpMax / 20)
		*/
		private _countCreate = callSelf(getOnDestroyCountCreate);

		private _type = null;
		private _startPos = getSelf(loc) modelToWorldVisual [0,0,0]; //center of model (not atl pos)
		private _wobj = nullPtr;
		private _tDat = null;

		#ifdef NOE_DEBUG_HIDE_SERVER_OBJECT
		private _nochange_serverobject = true;
		#endif
		#ifdef EDITOR
		private _hidemodevobj = {
			params ["_vobj","_mode"];
			if (_mode) then {
				if isNullVar(_nochange_serverobject) then {
					getVar(_vobj,loc) hideObject true;
				};
				(noe_client_allPointers getOrDefault [getVar(_vobj,pointer),objNull]) hideObject true;
			} else {
				if isNullVar(_nochange_serverobject) then {
					getVar(_vobj,loc) hideObject false;
				};
				(noe_client_allPointers getOrDefault [getVar(_vobj,pointer),objNull]) hideObject false;
			};
		};
		[this,true] call _hidemodevobj;
		//_parList = [this,_countCreate,_typeList,_startPos];
		//_nfp = { params ['this',"_countCreate","_typeList","_startPos"];
		#else
		
		//non editor hide serverside object
		getVar(_vobj,loc) hideObject true;

		#endif
		
		private _mobs = callSelfParams(getNearMobs,20);

		for "_i" from 1 to _countCreate do {
			_type = pick _typeList;
			
			_wobj = [_type,_startPos] call createGameObjectInWorld;//instantiate(_type);//
			assert_str(!isNullReference(_wobj),"Failed to create debris type " + _type);

			#ifdef EDITOR
			[_wobj,true] call _hidemodevobj;
			#else
			getVar(_wobj,loc) hideObject true; //hide debris on server prod
			#endif

			_tDat = [
				_wobj,
				_startPos vectoradd [rand(-.1,.1),rand(-.1,.1),rand(0,.1)],
				[rand(-20,70),rand(0,360)],
				rand(2,4) //testforce
			] call si_rayTraceProcess;

			#ifdef EDITOR
			[_wobj,false] call _hidemodevobj;
			#else
			getVar(_wobj,loc) hideObject false; //unhide debris on server prod
			#endif
			
			_tDat params ["_iobj","_ipos","_ivec"];
			
			private _plis = [getVar(_wobj,pointer),[_ipos,callFunc(_wobj,getDir)],["ispd",
				rand(0.7,1.2)//3//<fortest
				,
				"emuf"]];
			{
				callFuncParams(_x,sendInfo,"nintrp" arg _plis)
			} foreach _mobs;

			
			callFuncParams(_wobj,setPos__,_ipos);
		};

		#ifdef EDITOR
		//}; invokeAfterDelayParams(_nfp,2,_parList);
		[this,false] call _hidemodevobj;
		#else
		
		//non editor show serverside object
		getVar(_vobj,loc) hideObject false;

		#endif
	};

	//Пользовательская функция определения количества выпадающих предметов
	getter_func(getOnDestroyCountCreate,round(getSelf(hpMax)/20));
	//пользовательская функция получения типов при уничтожении объекта. можно настроить кастомные типы, выпадающие при уничтожении
	getter_func(getOnDestroyTypes,callSelf(getOnDestroyTypesFromMaterial));

	//минимально допустимое хп
	"
		name:Минимально допустимое здоровье
		desc:Возвращает минимальное допустимое здоровье для этого игрового объекта (макс.зд. * -5)
		type:get
		lockoverride:1
		return:int:Минимальное допустимое здоровье игрового объекта
	" node_met
	getter_func(getMinAllowedHP,-5 * getSelf(hpMax));

	"
		name:Текущее здоровье в процентах
		desc:Возвращает текущее здоровье в процентах от 100 до 0
		type:get
		lockoverride:1
		return:int:Текущее здоровье в процентах
	" node_met
	//текущее представление хп в процентном соотношении
	func(getHPCurrentPrecentage)
	{
		objParams();
		round linearConversion [callSelf(getMinAllowedHP),getSelf(hpMax),getSelf(hp),0,100,true];
	};

	"
		name:Установить текущее здоровье в процентах
		desc:Устанавливает текущее здоровье в процентах от 100 до 0
		type:method
		lockoverride:1
		in:int:Здоровье:Здоровье в процентах
			opt:def=100
	" node_met
	func(setHPCurrentPrecentage)
	{
		objParams_1(_val);
		private _newHp = round linearConversion [0,100,_val,callSelf(getMinAllowedHP),getSelf(hpMax),true];
		_newHp = clamp(_newHp,callSelf(getMinAllowedHP),getSelf(hpMax));
		setSelf(hp,_newHp);
	};

	func(getOnDestroyTypesFromMaterial)
	{
		objParams();
		private _mat = callSelf(getMaterial);
		if !isNullReference(_mat) then {
			callFunc(_mat,getDestructionTypes);
		} else {
			[]
		};
	};
	
	
	var(germs,0);//сколько микробов на объекте (для инфекций)

	func(addGerms)
	{
		objParams_1(_val);
		callSelfParams(setGerms,getSelf(germs) + _val);
	};

	func(setGerms)
	{
		objParams_1(_val);
		setSelf(germs,clamp(_val,0,GERM_COUNT_MAX));
		callSelf(onGermsChanged);
	};

	func(onGermsChanged)
	{
		objParams();
	};

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

region(Fire functionality)
	//Временное решение чтобы при готовке не загорался предмет
	var(_lockedCanIgnite,false); //внешнее блокирование пожара

	getter_func(canIgniteArea,false); //может ли этот источник поджечь свой чанк
	//доп проверка на возгорание объекта. например можно настроить, чтобы источником был маленький предмет
	func(checkCanIgniteObject)
	{
		objParams_1(_targ);
		true
	};
	var(__s_nextCheckIgnite,0);
	func(handleIgniteArea)
	{
		objParams();
		if !callSelf(canIgniteArea) exitWith {};

		if (tickTime>=getSelf(__s_nextCheckIgnite)) then {
			callSelf(resetIngiteTimer);
			[this] call atmos_tryIgnite;
		};
	};
	func(resetIngiteTimer)
	{
		objParams();
		#ifdef EDITOR
		setSelf(__s_nextCheckIgnite,tickTime + 5);
		#else
		setSelf(__s_nextCheckIgnite,tickTime + randInt(40,60*2));
		#endif
	};

region(Pulling functionality)
	//get helper object on pulling
	func(getPullHelperObject)
	{
		objParams();
		if !callSelf(isInWorld) exitWith {objNull};
		private _vtg = getSelf(loc) getVariable ["__vtarg_pull",objNull];
		_vtg
	};
	getter_func(isPulled,count getSelf(__moverMobs) > 0);
	func(getPullMainOwner)
	{
		objParams();
		private _mvr = getSelf(__moverMobs);
		if (count _mvr == 0) exitWith {nullPtr};
		_mvr select 0
	};

	var(__pullProc_tdat,null);

	func(_getPullSounds)
	{
		objParams();
		private _mat = callSelf(getMaterial);
		if isNullReference(_mat) exitWith {[]};
		callFunc(_mat,getPullSounds);
	};

	func(_checkCanPullingConditions)
	{
		objParams_1(_usr);
		
		if !callFunc(_usr,isActive) exitWith {false};

		private _dir = callFuncParams(_usr,getDirFrom,this);
		if (_dir!=DIR_FRONT) exitWith {false};
		if callFunc(_usr,isConnected) exitWith {false};//сел - сброс
		_stance = callFunc(_usr,getStance);
		
		if (_stance < STANCE_MIDDLE) exitWith {false};
		
		true
	};
	func(startPull)
	{
		objParams_1(_usr);
		
		
		getSelf(__moverMobs) pushBack _usr;
		callSelfParams(_pullStarted,_usr);
		callSelf(onPullChanged);
	};
	func(canStartPull)
	{
		objParams_1(_usr);

		if !callSelf(isMovable) exitWith {false};
		if !callSelf(isInWorld) exitWith {false};
		if !callSelfParams(_checkCanPullingConditions,_usr) exitWith {false};
		//пусть пока тащить может только один
		if (count getSelf(__moverMobs) > 0) exitWith {false};
		//todo горящие чанки объекта не позволят двигать его

		true
	};

	//internal function for handling pullings
	func(_pullStarted)
	{
		objParams_1(_usr);

		private _wobj = getSelf(loc);
		private _srcPos = asltoatl getPosWorld _wobj;
		private _own = getVar(_usr,owner);
		private _cachedPosVar = [getposatl _wobj,getposworld _wobj];
		private _offs = _srcPos vectorDiff (getposatl _own);
		private _pby = [_wobj] call model_getPitchBankYaw;
		
		callSelf(unloadModel);

		private _wposRequired = !([_pby] call model_isSafedirTransform);
		private _cachePos = if (_wposRequired) then {_cachedPosVar select 1} else {_cachedPosVar select 0};
		setSelf(__pullProc_tdat,vec2(_cachePos,_pby));

		private _rpcInfo = [getSelf(pointer),getSelf(model),_offs,_pby,callSelf(_getPullSounds)];
		if (callSelf(canLight) && {getSelf(light) != -1}) then {
			_rpcInfo pushBack getSelf(light);
		};

		callFuncParams(_usr,syncSmdVar,"pull" arg _rpcInfo);
	};
	
	func(stopPull)
	{
		objParams_1(_usr);
		
		if isNullReference(_usr) exitWith {};
		callFuncParams(_usr,syncSmdVar,"pull" arg 0);
		private _mvr = getSelf(__moverMobs);
		private _isMainOwner = equals(callSelf(getPullMainOwner),_usr);
		array_remove(_mvr,_usr);

		if (_isMainOwner) then {
			callSelf(closePullSettings);
		};

		if (count _mvr == 0) then {
			// private _vtarg = callSelf(getPullHelperObject);
			// deleteVehicle _vtarg;
			getSelf(__pullProc_tdat) params ["_pos","_pby"];
			(_pby call model_convertPithBankYawToVec) params ["_vd","_vu"];
			private _wposRequired = !([_pby] call model_isSafedirTransform);
			traceformat("WPOS REQUIRED: %1; pby: %2 => %3",_wposRequired arg _pby arg vec2(_vd,_vu))
			if (_wposRequired) then {
				callSelfParams(loadModel,_pos + [true] arg _vd arg _vu arg false);
			} else {
				callSelfParams(loadModel,_pos arg _vd arg _vu arg false);
			};
		};

		callSelf(onPullChanged);
	};
	
	func(onPullChanged)
	{
		objParams();
		callSelf(pullRecalculateWeight);
	};
	func(pullRecalculateWeight)
	{
		objParams();
		private _mvr = getSelf(__moverMobs);
		if ((count _mvr) == 0) exitWith {};
		private _wobjList = [];
		{
			if isTypeOf(_x,Mob) then {
				private _sysitm = getVar(_x,specHandAct);
				{if equals(_x,this) then {_wobjList pushBack _x;}} foreach _sysitm;
			};
		} foreach _mvr;
		
		if (count _wobjList == 0) exitWith {};

		private _wPerItem = callSelf(getWeight) / (count _wobjList);
		{setVar(_x,weight,_wPerItem)} foreach _wobjList;
		//update weight for mobs
		{_x call gurps_recalcuateEncumbrance} foreach _mvr;
	};
	
	func(closePullSettings)
	{
		objParams();
		private _dynDisp = getVar(_usr,_internalDynamicND);
		if equals(getVar(_dynDisp,ndName),"ObjectPull") then {
			callFunc(_dynDisp,closeNDisplayForAllMobs);
		};
	};

	func(openPullSettings)
	{
		objParams_1(_usr);
		private _dynDisp = getVar(_usr,_internalDynamicND);

		private _getInfo = {
			private _p = getSelf(ptrval);
			private _ctx = getSelf(context);
			private _ph = callFunc(_ctx,getPullHelperObject);

			[_p]
		};
		private _handleInp = {
			objParams_2(_usr,_inp);
			assert_str(false,"Pull settings changing not supported");
			private _src = getSelf(context);
			if isNullReference(_src) exitWith {};
			if !callFunc(_src,isInWorld) exitWith {};
			
			private _ph = callFunc(_src,getPullHelperObject);
			if isNullReference(_ph) exitWith {};
			private _maxZOffset = _ph getvariable "_maxZOffset";

			_inp params ["_mode","_val"];
			if (_mode == "vupd") exitWith {
				private _oldrot = _ph getVariable "_rot";
				_ph setVariable ["_rot",_val];
			};
			if (_mode == "zupd") exitWith {
				private _oldval = _ph getVariable "_zpos";
				_ph setVariable ["_zpos",clamp(_val + _oldval,-_maxZOffset/2,_maxZOffset)];	
			};
			//unsupported mode
			setLastError("Mode '" + _mode + "' is not supported");
		};
		private _ctx = this;
		callFuncParams(_dynDisp,setNDOptions,"ObjectPull" arg 10 arg getSelf(pointer) arg _getInfo arg _handleInp arg _ctx);
		
		callFuncParams(_dynDisp,openNDisplayInternal,_usr arg getVar(_usr,owner));
	};

region(Emplacer system)
	//можно ли расположить предмет на this объекте. проверяемый
	func(canEmplaceItem)
	{
		objParams_5(_obj,_pos,_dir,_vup,_usr);
		//по умолчанию можно расположить только если предмет на полу
		callFuncParams(_obj,isFloorEmplaceFromVUP,_vup);
	};
	
	//called on canEmplaceItem returns 
	func(onEmplaceItemFail)
	{
		objParams_5(_obj,_pos,_dir,_vup,_usr);
		if !callFuncParams(_obj,isFloorEmplaceFromVUP,_vup) exitWith {
			private _msg = pick["Упадёт же!","Слишком большой наклон.","Лучше поставлю где поровнее.","Отсюда всё скатится...","Тут не встанет."];
			callFuncParams(_usr,localSay,_msg arg "error");
		};
	};

	func(onEmplaceItem)
	{
		objParams_5(_obj,_pos,_dir,_vup,_usr);
		//virtual function for custom functionality
		//for example: can use for update germs on item and source object
	};

	//внутренняя функция проверки расположен ли vectorup на полу
	func(isFloorEmplaceFromVUP)
	{
		objParams_1(_vup);
		(_vup select 2) >= 0.65
	};

region(Craft system)
	
	//кто последний дотрагивался до предмета
	getter_func(getLastTouched,nullPtr);

	var(craftComponentName,null); //система крафта (строка или null)
	var(craftComponentParams,null);
	var(craftComponent,null);
	getter_func(hasCraftComponent,!isNull(getSelf(craftComponent)));

	func(initCraftSystem)
	{
		objParams();
		private _craftComp = getSelf(craftComponentName);
		if !isNullVar(_craftComp) then {
			assert_str(struct_existType_str(_craftComp),format vec3("Craft component %1 not found in class %2",_craftComp,callSelf(getClassName)));
			private _params = getSelf(craftComponentParams);
			if !isNullVar(_params) then {
				_params = createHashMapFromArray _params;
			};
			private _comp = [_craftComp,[this,_params]] call struct_alloc;
			setSelf(craftComponent,_comp);
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _baseDesc = super();
		if callSelf(hasCraftComponent) then {
			private _ccompDesc = getSelf(craftComponent) callp(getDescFor,_usr);
			if (_ccompDesc!="") then {
				modvar(_baseDesc) +sbr+ _ccompDesc;
			};
		};
		_baseDesc
	};

	func(onMainAction) {
		objParams_1(_usr);
		if callSelf(hasCraftComponent) exitWith {
			getSelf(craftComponent) callp(onActivate,_usr);
		};
		super();
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if callSelf(hasCraftComponent) exitWith {
			getSelf(craftComponent) callp(moveIngredient,_with arg _usr);
		};
	};

	//redirects move funcs to craft component
	func(canMoveInItem)
	{
		objParams_1(_item);
		private _ccomp = getSelf(craftComponent);
		if (isNullVar(_ccomp) || {!isinstance(_ccomp,BaseInternalCraftSystem)}) exitWith {true};
		_ccomp callp(canMoveInItem,_item);
	};

	func(canMoveOutItem)
	{
		objParams_1(_item);
		private _ccomp = getSelf(craftComponent);
		if (isNullVar(_ccomp) || {!isinstance(_ccomp,BaseInternalCraftSystem)}) exitWith {true};
		_ccomp callp(canMoveOutItem,_item);
	};

	func(onMoveInItem)
	{
		objParams_1(_item);
		private _ccomp = getSelf(craftComponent);
		if (!isNullVar(_ccomp) && {isinstance(_ccomp,BaseInternalCraftSystem)}) then {
			_ccomp callp(onMoveInItem,_item);
		};
	};

	func(onMoveOutItem)
	{
		objParams_1(_item);
		private _ccomp = getSelf(craftComponent);
		if (!isNullVar(_ccomp) && {isinstance(_ccomp,BaseInternalCraftSystem)}) then {
			_ccomp callp(onMoveOutItem,_item);
		};
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
