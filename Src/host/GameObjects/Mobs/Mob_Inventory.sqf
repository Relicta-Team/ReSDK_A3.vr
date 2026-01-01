// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//создаёт на основе массива хэшкарту со слотами
//Является по сути просто быстрым геттером для доступа к предметам в слотах
var(slots,INV_LIST_ALL);



var(defaultUniform,"");//дефолтная форма (женское тело или бомжиные обноски)

//контроллер слоёв отображения (волосы, бороды и т.д.)
var(overlayController,struct_new(OverlayLayerController));

region(Low level inventory api)
	func(getSlotInfoForInventory)
	{
		objParams_1(_slot);
		private _it = callSelfParams(getItemInSlot,_slot);
		if isNullObject(_it) then {
			[]
		} else {
			callFunc(_it,GetItemInfoForClient)
		}
	};

	func(syncSlotInfo)
	{
		objParams_1(_slot);

		private _data = [_slot,callSelfParams(getSlotInfoForInventory,_slot)]; //[_slot arg _data]
		if !isNullVar(__EXTERNAL_STOLEN__) then {
			_data pushBack true; //_supressRestoreHide
		};
		callSelfParams(sendInfo,"updateSlotInfo" arg _data);
	};

	func(syncSlotInfoList)
	{
		objParams_1(_slotList);

		private _data = [];

		{
			_data pushback [_x,callSelfParams(getSlotInfoForInventory,_x)];
		} foreach _slotList;

		callSelfParams(sendInfo,"updateSlotListInfo" arg _data);
	};

	func(syncGermsVisual)
	{
		objParams();
		private _stack = [];//key lh,rh,ts,hd
		
		private _ret = null;
		
		private _countParts = 0;
		private _accVal = 0;

		{
			_ret = callFunc(_x,getGermOpacityData);
			if !isNullVar(_ret) then {
				_stack pushBack _ret;
			};
			
			if !isNullReference(_x) then {
				INC(_countParts);
				_accVal = _accVal + callFunc(_x,getGermDecalVisibility);
			};
		} foreach (values getSelf(bodyParts));

		if (_countParts > 0) then {
			_accVal = _accVal / _countParts;
		};

		callSelfParams(sendInfo,"updateGermsInv" arg _stack);

		//! когда персонажи без одежды будут иметь свою модель (ретекстур голого персонажа) - можно вернуть это с правками
		//! Сейчас грязь хранится на самой одежде
		//callSelfParams(syncSmdVar,"decals" arg _accVal);
	};

region(Getters and checkers)
	//Проверяет нет ли предметов в обеих руках
	func(isEmptyHands)
	{
		objParams();
		private _slots = getSelf(slots);
		isNullObject(_slots getOrDefault vec2(INV_HAND_L,nullPtr)) &&
			isNullObject(_slots getOrDefault vec2(INV_HAND_R,nullPtr))
	};

	func(isEmptyHand)
	{
		objParams_1(_slot);
		isNullObject(callSelfParams(getItemInSlot,_slot))
	};

	func(isEmptyActiveHand)
	{
		objParams();
		isNullObject(callSelfParams(getItemInSlot,getSelf(activeHand)))
	};

	// Получает итем на слоте. Если итема нет или пустой слот - вернет nullPtr
	func(getItemInSlot)
	{
		objParams_1(_slot);
		getSelf(slots) getOrDefault [_slot,nullPtr]
	};

	// Проверяет пустой ли слот. даже если его нет вернёт nullPtr
	"
		name:Слот пустой
		desc:Возвращает @[bool ИСТИНУ], если проверяемый слот инвентаря персонажа пустой.
		type:get
		lockoverride:1
		in:enum.InventorySlot:Слот:Проверяемый на наличие предмета слот инвентаря.
		return:bool:Слот пустой
	" node_met
	func(isEmptySlot)
	{
		objParams_1(_slot);
		isNullObject(callSelfParams(getItemInSlot,_slot));
	};

	// Проверяет есть ли слот в персонаже
	func(hasSlot)
	{
		objParams_1(_slot);
		_slot in getSelf(slots)
	};

	getter_func(getItemInActiveHand,callSelfParams(getItemInSlot,getSelf(activeHand)));

	getter_func(getNotActiveHand,ifcheck(getSelf(activeHand)==INV_HAND_R,INV_HAND_L,INV_HAND_R));

	//Тоже что и getItemInActiveHand но переопределяет SystemHandItem при получении
	func(getItemInActiveHandRedirect)
	{
		objParams();
		private _probItem = callSelf(getItemInActiveHand);
		if isNullReference(_probItem) exitWith {_probItem};
		if isTypeOf(_probItem,SystemHandItem) exitWith {
			private _m = getVar(_probItem,mode);
			if (_m=="twohand") exitWith {
				getVar(_probItem,object)
			};
			nullPtr
		};
		_probItem
	};
	//Возврат передмета с редиректом
	"
		name:Получить предмет в слоте
		desc:Возвращает предмет, находящийся в слоте. Если предмета нет или слот пустой - вернет @[object^ null-ссылку].
		type:get
		lockoverride:1
		in:enum.InventorySlot:Слот:Проверяемый на наличие предмета слот инвентаря.
		return:Item:Предмет в слоте
	" node_met
	func(getItemInSlotRedirect)
	{
		objParams_1(_slot);
		private _probItem = callSelfParams(getItemInSlot,_slot);
		if isNullReference(_probItem) exitWith {_probItem};
		if isTypeOf(_probItem,SystemHandItem) exitWith {
			private _m = getVar(_probItem,mode);
			if (_m=="twohand") exitWith {
				getVar(_probItem,object)
			};
			nullPtr
		};
		_probItem
	};

	//тоже что и getItemInActiveHandRedirect но для второй руки
	func(getItemInNotActiveHandRedirect)
	{
		objParams();
		private _probItem = callSelfParams(getItemInSlot,callSelf(getNotActiveHand));
		if isNullReference(_probItem) exitWith {_probItem};
		if isTypeOf(_probItem,SystemHandItem) exitWith {
			private _m = getVar(_probItem,mode);
			if (_m=="twohand") exitWith {
				getVar(_probItem,object)
			};
			nullPtr
		};
		_probItem
	};

	func(setActiveHand)
	{
		objParams_1(_newHand);
		if !array_exists(INV_LIST_HANDS,_newHand) exitWith {
			errorformat("Mob::setActiveHand() - Argument error: %1",_newHand);
		};
		if equals(_newHand,getSelf(activeHand)) exitWith {};
		private _oth = 0;
		// __switchVars(otherTargZone,curTargZone)
		#define __switchVars(prevname,nextname) _oth = getSelf(prevname); setSelf(prevname,getSelf(nextname)); setSelf(nextname,_oth)
		__switchVars(otherTargZone,curTargZone);
		__switchVars(otherAttackType,curAttackType);
		__switchVars(otherSpecialAction,specialAction);
		__switchVars(otherCombatStyle,curCombatStyle);
		__switchVars(otherLastCombatActionTime,lastCombatActionTime);
		setSelf(activeHand,_newHand);

		callSelfParams(onChangeAttackType,"change_hand");
	};

	//server event to change active hand
	func(switchActiveHand)
	{
		objParams();
		if isNull(getSelf(activeHand)) exitWith {};
		callSelfParams(setActiveHand,callSelf(getNotActiveHand));
	};

	func(switchTwoHands)
	{
		objParams();
		if !callSelf(isActive) exitWith {};
		if callSelf(isStunned) exitWith {};
		private _item = callSelf(getItemInActiveHandRedirect);
		if isNullReference(_item) then {
			//Проверяем вторую руку
			_item = callSelf(getItemInNotActiveHandRedirect);
			if isNullReference(_item) exitWith {}; //ни в первой ни во второй руке ничего нет
			
			if !callSelfParams(canUseActivePart,false) exitWith {};
			
			callSelfParams(onTwoHand,_item);
		} else {
			//переназначить предмет в аткивную руку
			private _doReassign = not_equals(callSelf(getItemInActiveHand),_item);
			//из-под активной руки взяли в двуручку
			callSelfParams(onTwoHand,_item);
			if (_doReassign) then {
				callSelfParams(transferItem,getVar(_item,slot) arg getSelf(activeHand));
			};
		};

	};

	//проверяет есть ли часть тела
	func(hasPart)
	{
		objParams_1(_BP_IDX);
		!isNullObject(getSelf(bodyParts) getOrDefault vec2(_BP_IDX,nullPtr))
	};

	//Есть ли место для присоединения части тела. Чтобы например нельзя было пришить 3 руку
	func(hasPartSocket)
	{
		objParams_1(_BP_IDX);
		_BP_IDX in getSelf(bodyParts)
	};

	func(hasPartForSlot)
	{
		objParams_1(_slot);

		fswitch(_slot)
		{
			fcasein(INV_LIST_FACE) {callSelfParams(hasPart,BP_INDEX_HEAD)};
			fcase(INV_HAND_R) {callSelfParams(hasPart,BP_INDEX_ARM_R)};
			fcase(INV_HAND_L) {callSelfParams(hasPart,BP_INDEX_ARM_L)};
			fcasein(INV_LIST_TORSO) {callSelfParams(hasPart,BP_INDEX_TORSO)};
			warningformat("Mob::hasPartForSlot() - Cant find slot %1. By default returns true",_slot);
			true
		};
	};

	// Генеральная проверка на возможность установки предмета в слот
	func(canSetItemOnSlot)
	{
		objParams_2(_item,_slot);
		//check item pointer
		if isNullReference(_item) exitWith {false};

		//check hasSlot
		if !callSelfParams(hasSlot,_slot) exitWith {false};
		
		//check if slot not empty
		if !callSelfParams(isEmptySlot,_slot) exitWith {false};
		
		//check body part contains
		if !callSelfParams(hasPartForSlot,_slot) exitWith {false};
		
		//check if item can set on slot (validate allowed slots or more)
		if !callFuncParams(_item,canSetToSlot,_slot) exitWith {false};
		
		// we can add many checkers and conditional logics here...

		true
	};

	//Проверяет наличие предмета в инвентаре моба. _checkSubTypes делает проверку по дочерних типов вместо сравнения по класснейму
	//_item может быть строкой, кодом или объектом
	func(hasItem)
	{
		params ['this',"_item",["_checkSubTypes",false],["_checkInContainers",true]];

		private _checkMethod = if equalTypes(_item,"") then {
			if (_checkSubTypes) then {
				{
					isTypeStringOf(_this,_item)
				}
			} else {
				{
					callFunc(_this,getClassName) == _item
				}
			};
		} else {
			// Проверка по коду
			if equalTypes(_item,{}) then {
				_item
			} else {
				{
					equals(_item,_this)
				}
			};

		};
		private _itmSlot = nullPtr;
		private _hasItem = false;
		{
			if (_hasItem) exitWith {};

			_itmSlot = callSelfParams(getItemInSlot,_x);
			if isNullReference(_itmSlot) then {
				continue;
			};

			if (_itmSlot call _checkMethod) exitWith {
				_hasItem = true;
			};

			if callFunc(_itmSlot,isContainer) then {
				if (_checkInContainers) then {
					{
						if (_x call _checkMethod) exitWith {_hasItem = true};
					} foreach getVar(_itmSlot,content);
				};
			};

		} forEach INV_LIST_ALL;

		_hasItem
	};

endregion

region(Inventory control)

	func(_makeSlots)
	{
		objParams();
		private _slots = getSelf(slots);
		private _newMap = createHashMap;
		{
			_newMap set [_x,nullPtr];
		} foreach _slots;
		setSelf(slots,_newMap);
	};

	func(_onDelete_Inventory)
	{
		objParams();
		{
			delete(_y);
		} foreach getSelf(slots);
	};

	func(onApplyDefaultUniform)
	{
		objParams();
		getSelf(owner) forceAddUniform getSelf(defaultUniform);
	};

	func(canMoveInItem)
	{
		objParams_1(_item);
		callSelfParams(canSetItemOnSlot,_item arg getSelf(activeHand))
	};
	func(canMoveOutItem)
	{
		objParams_1(_item);
		equals(getVar(_item,loc),this)
		//commented after legacy 0.1.10
		/* && getSelf(activeHand) == getVar(_item,slot)*/ //перемещение из моба через moveItem должно быть реализовано через onInteractWith
	};

	func(onMoveOutItem)
	{
		objParams_2(_item,_newloc);
		callSelfParams(removeItem,_item);
		if isTypeOf(_newloc,IRangedWeapon) exitWith {}; //duplicate sound fix
		callFuncParams(_item,onPutdown,this);
	};
	func(onMoveInItem)
	{
		objParams_1(_item);
		callSelfParams(addItem,_item);
	};

	//Передача предмета цели
	func(transferItemToTarget)
	{
		objParams_3(_item,_target,_slotTo);
		if !callSelfParams(canMoveOutItem,_item) exitWith {false};
		if !callFuncParams(_target,canSetItemOnSlot,_item arg _slotTo) exitWith {false};
		
		callFuncParams(this,onMoveOutItem,_item);
		callFuncParams(_target,addItem,_item arg _slotTo);
		true
	};

	// Internal unsafe method for set item on slot without access to adding
	//if you need pickup item - use pickupItem() method
	func(setItemOnSlot)
	{
		objParams_2(_item,_slot);

		//установка локации
		if not_equals(getVar(_item,loc),this) then {
			setVar(_item,loc,this);
			callFunc(_item,onChangeLoc);
		};

		//если предыдущий слот предмета занят убираем его и добавляем сообщение об отправке
		private _idFrom = getVar(_item,slot);

		private _hasNeedUpdateFrom = _idFrom != -1;

		//Обновляем слот
		private _slots_data = getSelf(slots);
		_slots_data set [_slot,_item];
		setVar(_item,slot,_slot);

		//вызываем событие onEquip или onUnequip
		if array_exists(INV_LIST_HANDS,_slot) then { //новый слот руки и предыдущий слот был определён
			if (_idFrom != -1 && !array_exists(INV_LIST_HANDS,_idFrom)) then {
				callFuncParams(_item,onUnequip,this);
			};
		} else {
			callFuncParams(_item,onEquip,this);
		};

		if (_hasNeedUpdateFrom) then {

			_slots_data set [_idFrom,nullPtr];

			callSelfParams(syncSlotInfoList,[_idFrom arg _slot]);
			//smd sync
			callSelfParams(syncSmdSlot,_idFrom);
			callSelfParams(syncSmdSlot,_slot);
		} else {
			callSelfParams(syncSlotInfo,_slot);
			//smd sync
			callSelfParams(syncSmdSlot,_slot);
		};

		this call gurps_recalcuateEncumbrance;

		callSelfParams(onChangeAttackType,"sync");
		//останавливаем прогресс при получении предмета
		callSelfParams(stopProgress,true);

		//face block update
		if (_slot == INV_FACE || _idFrom == INV_FACE) then {
			callSelf(handleVoiceUpdate);
		};

		//обновляем грязь по слоту
		private _bpIdx = [_slot] call gurps_convertSlotToBodyPart;
		private _part = callSelfParams(getPart,_bpIdx);
		traceformat("Attempt update germs for part %1",callFunc(_part,getName));
		if !isNullReference(_part) then {
			callFuncParams(_part,updateGermsAt,_item);
		};
	};

	// Internal unsafe method for remove item from slot
	func(removeItemOnSlot)
	{
		objParams_3(_item,_slot,_newLoc);

		if callSelfParams(isHoldedTwoHands,_item) then {
			callSelfParams(onTwoHand,_item);
		};

		private _curSlot = getVar(_item,slot);

		getSelf(slots) set [_slot,nullPtr];
		setVar(_item,slot,-1);
		if !isNullObject(_newLoc) then {
			setVar(_item,loc,_newLoc);
			callFunc(_item,onChangeLoc);
		};
		
		if ( !array_exists(INV_LIST_HANDS,_curSlot)) then { //если в момент выкладывания был не в руках
				callFuncParams(_item,onUnequip,this);
			//};
		};

		callSelfParams(onChangeAttackType,"sync");

		//face block update
		if (_curSlot == INV_FACE) then {
			callSelf(handleVoiceUpdate);
		};

		this call gurps_recalcuateEncumbrance;

		callSelfParams(syncSlotInfo,_slot);
		callSelfParams(syncSmdSlot,_slot);
		//останавливаем прогресс при уничтожении предмета
		callSelfParams(stopProgress,true);
	};


	// безопасный метод подбора предмета со всеми проверками
	func(pickupItem)
	{
		objParams_1(_item);

		//check if in world (server protect)
		if !callFunc(_item,isInWorld) exitWith {};

		if !callFunc(_item,canPickup) exitWith {
			callFuncParams(_item,onCantPickup,this);
		}; //cant pickup item
		
		if (callSelf(getLastInteractDistance)>INTERACT_ITEM_DISTANCE)exitWith {
			//далеко для подбора
		};

		private _slot = getSelf(activeHand);

		if !callSelfParams(canSetItemOnSlot,args2(_item,_slot)) exitWith {};

		callSelfParams(interpolate,"pickup" arg _item arg _slot);

		callFunc(_item,simulatePhysics);

		callFunc(_item,unloadModel);

		callSelfParams(setItemOnSlot, _item arg _slot);

		callFuncParams(_item,onPickup,this); //calling std event on pickup
	};

	func(dropItem) {
		params ['this','_slotId',['_isSafePutdown',false]];

		if !callSelfParams(hasSlot,_slotId) exitWith {};
		private _item = callSelfParams(getItemInSlot,_slotId);

		// check if reference null
		if isNullObject(_item) exitWith {};

		// serverside protect
		if not_equals(getVar(_item,loc),this) exitWith {};

		if isTypeOf(_item,SystemItem) exitWith {
			//callFuncParams(_item,onDrop, this);
			if (_isSafePutdown) then {
				callFuncParams(_item,onPutdown,this);
			} else {
				callFuncParams(_item,onDrop, this);
			};
		};

		// can drop from hands only
		if !array_exists(INV_LIST_HANDS,_slotId) exitWith {};

		// logical error check
		if not_equals(getVar(_item,slot),_slotId) exitWith {
			errorformat("Logical error in Mob::dropItem() - item.slot is %1; _slot is %2",getVar(_item,slot) arg _slotId);
		};
		if callSelfParams(isHoldedTwoHands,_item) then {
			callSelfParams(onTwoHand,_item);
		};

		callSelfParams(interpolate,"putdown" arg _item);

		//create worldobj on mob position
		private _worldObj = [_item,getSelf(owner),null,null,_isSafePutdown] call noe_loadVisualObject_OnDrop;

		callSelfParams(removeItemOnSlot,_item arg _slotId arg _worldObj);

		if (_isSafePutdown) then {
			callFuncParams(_item,onPutdown,this);
		} else {
			callFuncParams(_item,onDrop, this);
		};
	};

	//системный метод. для выбрасывания масок при слете головы, предметов
	func(dropItemFromSlot)
	{
		objParams_1(_slotId);
		private _item = callSelfParams(getItemInSlot,_slotId);
		if isNullReference(_item) exitWith {};
		if not_equals(getVar(_item,slot),_slotId) exitWith {};
		if callSelfParams(isHoldedTwoHands,_item) then {
			callSelfParams(onTwoHand,_item);
		};
		
		callSelfParams(interpolate,"putdown" arg _item);

		private _worldObj = [_item,getSelf(owner),null,null] call noe_loadVisualObject_OnDrop;
		callSelfParams(removeItemOnSlot,_item arg _slotId arg _worldObj);
		callFuncParams(_item,onDrop, this);
	};

	func(putdownItem) {
		objParams_2(_item,_posData);
		//_posData:[pos,dir,vecup,placerPtr]
		private _slotId = getVar(_item,slot);
		if !callSelfParams(hasSlot,_slotId) exitWith {};

		// serverside protect
		if not_equals(getVar(_item,loc),this) exitWith {};

		if isTypeOf(_item,SystemItem) exitWith {
			callFuncParams(_item,onPutdown, this arg _posData);
		};

		// can putdown item from hands only
		if !array_exists(INV_LIST_HANDS,_slotId) exitWith {};

		_posData params ["_pos","_dir","_vecUp","_objPlace"];

		//? Проверка на дистанцию происходит на клиенте. Это дает лучшую точность
		
		if !callFuncParams(_objPlace,canEmplaceItem,_item arg _pos arg _dir arg _vecUp arg this) exitWith {
			callFuncParams(_objPlace,onEmplaceItemFail,_item arg _pos arg _dir arg _vecUp arg this);
		};

		if callSelfParams(isHoldedTwoHands,_item) then {
			callSelfParams(onTwoHand,_item);
		};
		
		callSelfParams(interpolate,"putdown" arg _item);

		private _worldObj = [_item,_posData] call noe_loadVisualObject_OnPutdown;

		callSelfParams(removeItemOnSlot,_item arg _slotId arg _worldObj);

		callFuncParams(_item,onPutdown,this);

		callFuncParams(_objPlace,onEmplaceItem,_item arg _pos arg _dir arg _vecUp arg this);
	};
	
	/*var(__fastputdownbuffer,null);
	func(onPutdownBindPress)
	{
		objParams();
		getSelf(__fastputdownbuffer) params [["_item",nullPtr],"_posData"];
		setSelf(__fastputdownbuffer,null);
		if isNullReference(_item) exitWith {};
		callSelfParams(putdownItem,_item arg _posData);
	};*/
	

	//Безопасный метод передачи предмета из слота А в слот Б
	func(transferItem)
	{
		objParams_2(_slotFrom,_slotTo);
		
		if equals(_slotFrom,_slotTo) exitWith {}; //источник и назначение одинаковы
		
		//standart checker
		if !callSelfParams(hasSlot,_slotFrom) exitWith {};
		if !callSelfParams(hasSlot,_slotTo) exitWith {};
		private _itemFrom = callSelfParams(getItemInSlotRedirect,_slotFrom);
		if isNullReference(_itemFrom) exitWith {};
		
		//serverside protect location
		if not_equals(getVar(_itemFrom,loc),this) exitWith {};
		
		if !callSelfParams(canSetItemOnSlot,args2(_itemFrom,_slotTo)) exitWith {};
		
		if callSelfParams(isHoldedTwoHands,_itemFrom) then {
			callSelfParams(onTwoHand,_itemFrom);
		};
		callSelfParams(interpolate,"trans" arg _itemFrom arg _slotTo);
		callSelfParams(setItemOnSlot,_itemFrom arg _slotTo);
	};

	//устанавливает в мобе данный предмет. Возвращает результат успеха
	//Параметр _slotTo опциональный и по-умолчанию activeHand
	func(addItem)
	{
		objParams_2(_item,_slotTo);
		if isNullVar(_slotTo) then {_slotTo = getSelf(activeHand)};

		if !callSelfParams(hasSlot,_slotTo) exitWith {false};
		if !callSelfParams(canSetItemOnSlot,args2(_item,_slotTo)) exitWith {false};

		callSelfParams(setItemOnSlot,_item arg _slotTo);

		callFuncParams(_item,onPickup,this);

		true
	};

	//Убирает из моба данный предмет
	func(removeItem)
	{
		objParams_2(_item,_newLoc);
		if isNullVar(_newLoc) then {_newLoc = nullPtr};

		private _slotId = getVar(_item,slot);

		// serverside protect
		if not_equals(getVar(_item,loc),this) exitWith {};

		callSelfParams(removeItemOnSlot,_item arg _slotId arg _newLoc);
	};

endregion


//Выбрасывает всё из рук
func(dropAllItemsInHands)
{
	objParams();
	if (!callSelfParams(isEmptyHand,INV_HAND_L)) then {
		callSelfParams(dropItem,INV_HAND_L);
	};
	if (!callSelfParams(isEmptyHand,INV_HAND_R)) then {
		callSelfParams(dropItem,INV_HAND_R);
	};
};


func(interpolate)
{
	objParams_3(_mode,_obj,_opt); //_opt -> slotId|null
	traceformat("INTERPOLATE ------------------> %1",_this)
	private _plist = null;
	call {
		if (_mode=="pickup") exitWith {
			private _obj = getVar(_obj,loc);
			assert_str(equalTypes(_obj,objNull) && {!isNullReference(_obj)},"Object is not valid for pickup");
			private _d = [getPosAtl _obj,[_obj] call model_getPitchBankYaw];
			_plist = [netTickTime,
				/*getVar(_obj,pointer)*/ //! this doesn't work
				_d,
				_opt
			];
		};
		if (_mode=="putdown") exitWith {
			_plist = [netTickTime,getVar(_obj,slot),getVar(_obj,pointer)];
		};
		//transfer: delete source object and teleport to destination|or other slot
		if (_mode=="trans") exitWith {
			private _d = null;
			if equalTypes(_opt,nullPtr) then {
				private _optObj = getVar(_opt,loc);
				assert_str(equalTypes(_optObj,objNull) && {!isNullReference(_optObj)},"Object is not valid for pickup");
				_d = [getPosAtl _optObj,[_optObj] call model_getPitchBankYaw];	
			} else {
				//Отлично работает. трансфер объекта в слот
				assert(equalTypes(_opt,0));
				_d = _opt;
			};
			if isNullVar(_d) exitWith {};
			private _fS = getVar(_obj,slot);
			
			if callSelfParams(isHoldedTwoHands,_obj) exitWith {}; //do not play actions on twohanded anim

			if (_fS==-1) then {
				private _obj = getVar(_obj,loc);
				_fS = [getPosAtl _obj,[_obj] call model_getPitchBankYaw];
			};
			_plist = [netTickTime,_fS,_d];
		};
		private _speedModifOnFalling = false;
		if (_mode == "auto_trans_fall") then {
			_mode = "auto_trans";
			_speedModifOnFalling = true;
		};
		if (_mode == "auto_trans") exitWith {
			/*
				Дополнительные параметры:
					- выключить скрытие источника (nhs)
					- выключить скрытие назначения (nhd)
					- скалирование к минимому (для контейнерной эмуляции) (sc-)
					- скалирование к стандарту (sc+)
					- использовать модель от объекта dest (udo)

				Автоперемещение нужно для перемещения объекта по локациям.
				каждый из параметров может быть 3х типов:
					указатель - для мировой локации
					слот - для трансфера из инвентаря
					трансформ - из мировой позиции
				для определения типа перемещения:
					1. определяем локацию источника. 
						для мобов это слот, 
						для предметов в мире и внутри других предметов это позиция/указатель
					2. определяем локацию цели.
						владелец цели этот моб - используем слот (активной руки)
						владелец цели не в мире - используем позицию

					--
					для отдачи объекта другому персонажу - в цель помещаем позицию цели, в источник новую локацию
			*/
			private _getTransform = {
				params ["_srcObj"];
				private _l = callFunc(_srcObj,getBasicLoc);
				private _pos = getPosATLVisual _l;
				if callFunc(_srcObj,isContainer) then {
					_bbx = boundingBoxReal [_l,"Geometry"];
					_pos = _l modelToWorldVisual ([_bbx select [0,2]] call getPosListCenter);
				};
				[_pos,[_l] call model_getPitchBankYaw]
			};
			private _datFrom = null;
			private _datTo = null;
			private _optionals = [];

			if (equalTypes(_obj,nullPtr)) then {
				if (callFunc(_obj,isMob)) then {
					//todo
					_datFrom = getVar(_obj,activeHand);
				} else {
					//loc check
					if callFunc(_obj,isInWorld) then {
						//object is in world
						_datFrom = [_obj] call _getTransform;
					} else {
						//object inside another object
						private _ownObj = callFuncParams(_obj,getSourceLocEx,null);
						if callFunc(_ownObj,isInWorld) then {
							_datFrom = [_ownObj] call _getTransform;
						} else {
							assert_str(callFunc(getVar(_ownObj,loc),isMob),"Unexpected condition for " + (str _ownObj));
							_datFrom = getVar(_ownObj,slot);
							_optionals pushBack "udo";
						};

						if callFunc(_ownObj,isContainer) then {
							_optionals pushBack "sc+";
						};

						//enable nohide source
						_optionals pushBack "nhs";
					};

				};
			} else {
				setLastError("Unsupported source object type");
			};

			if equalTypes(_opt,nullPtr) then {
				if callFunc(_opt,isMob) then {
					_datTo = getVar(_opt,activeHand);
				} else {
					if callFunc(_opt,isInWorld) then {
						_datTo = [_opt] call _getTransform;
						if callFunc(_opt,isContainer) then {
							_optionals pushBack "sc-";
						};	
					} else {
						private _ownObj = callFuncParams(_opt,getSourceLocEx,null);
						if callFunc(_ownObj,isInWorld) then {
							_datTo = [_ownObj] call _getTransform;
						} else {
							assert_str(callFunc(getVar(_ownObj,loc),isMob),"Unexpected condition for " + (str _ownObj));
							_datTo = getVar(_ownObj,slot);
							array_remove(_optionals,"udo");
						};

						_optionals pushBack "nhd";
					};
				};
			} else {
				//for pointer type
				if equalTypes(_opt,"") exitWith {
					_datTo = _opt;
				};
				//for slot type
				if equalTypes(_opt,0) exitWith {
					_datTo = _opt;
				};
				setLastError("Unsupported destination object type");
			};
			
			
			if (!isNullVar(_datFrom) && !isNullVar(_datTo)) then {
				_plist = [netTickTime,_datFrom,_datTo];
				if (_speedModifOnFalling) then {
					_optionals append ["ispd",rand(1,1.3)];
				};
				if (count _optionals > 0) then {
					_plist pushBack _optionals;
				};
			};
		};
	};
	if isNullVar(_plist) exitWith {};
	callSelfParams(syncSmdVar,"interp" arg _plist);
};
