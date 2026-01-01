// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>
#include <..\..\..\PointerSystem\pointers.hpp>


class(BodyPart) extends(Item)
	var(germs,-1);//без микробов на старте
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,1.8);
	var(model,"ml\ml_object_new\model_24\okorok.p3d");
	var(material,"MatFlesh");
	var(dr,1);

	//var_num(hp);
	//var_bool(isBleeding);
	var_bool(isVital); //жизненноважная часть тела
	var_bool(isRotten);
	var(boneStatus,BONE_STATUS_OK); //normal,трещина, перелом: 0, 1, 2
	
	getterconst_func(isOrganic,true);
	
	//возвращает индекс части тела
	var(bodyPartIndex,-1);

	//прикреплена ли часть тела (пришита)
	var(isAttached,false);
	
	func(isAttached)
	{
		objParams();
		getSelf(isAttached)
	};
	
	var(isIncised,false);//надрезанаая часть
	
	getter_func(canUsePart,callSelf(isAttached) && !getSelf(isRotten));
	
	func(unlink)
	{
		objParams_2(_target,_isDestruction);
		if isNullVar(_isDestruction) then {_isDestruction = false};
		private _doDelete = isNullVar(_target);
		private _mob = getSelf(loc);
		private _bpIndex = getSelf(bodyPartIndex);
		if equals(_bpIndex,-1) exitWith {
			errorformat("%1::unlink() - bp index cannot find for ptr %2",callSelf(getClassName) arg getSelf(pointer));
		};
		
		callSelfParams(onBodyPartUnlinked,_mob);

		// unlink only after event
		getVar(_mob,bodyParts) set [_bpIndex,nullPtr];

		callSelfParams(onBodyPartPostUnlinked,_mob);
		
		setSelf(isAttached,false);
		
		if (_isDestruction) then {
			if callSelf(isBandaged) then {
				callSelfParams(removeBandage,getVar(_mob,owner));
			};
		};
		
		callFunc(_mob,syncGermsVisual);

		if (_doDelete) exitWith {
			delete(this);
		};
		
		if equalTypes(_target,[]) exitWith {
			[this,_target] call noe_loadVisualObject;			
		};
		if equalTypes(_target,objNUll) exitWith {
			[this,_target] call noe_loadVisualObject_OnDrop;
			callFuncParams(this,onDrop,nullPtr);
		};
		if isImplementFunc(_target,addItem) exitWith {
			if callFuncParams(_target,canMoveInItem,this) then {
				callFuncParams(_target,onMoveInItem,this);
			} else {
				[this,getVar(_target,owner)] call noe_loadVisualObject_OnDrop;
				callFuncParams(this,onDrop,_target);
			};
		};
		
		errorformat("Cant allocate new position for %1<%2>",this arg getSelf(pointer));
		delete(this);
	};
	
	//жесткая линковка с установкой всех данных
	func(hardLink)
	{
		objParams_1(_target);
		callFuncParams(this,link,_target arg getSelf(bodyPartIndex));
		setSelf(isAttached,true);
		setSelf(isWrenched,false);
	};
	
	func(link)
	{
		objParams_2(_target,_bpIndex);
		
		private _canLink = true;
		//сначала выгружаем объект из мира
		call {
			if (callSelf(isInWorld)) exitWith {
				callSelf(unloadModel);
			};
			if callFunc(getSelf(loc),isMob) exitWith {
				callFuncParams(getSelf(loc),removeItem,this);
			};
			
			_canLink = false;
		};
		
		if (!_canLink) exitWith {};		
		
		callSelfParams(onBodyPartLinked,_target);
		
		getVar(_target,bodyParts) set [_bpIndex,this];
		
		callSelfParams(onBodyPartPostLinked,_target);		
	};
	
	func(connectBodyPart)
	{
		objParams_2(_usr,_connecter);
		private _ctz = getVar(_connecter,curTargZone);
		private _bp = [_ctz] call gurps_convertTargetZoneToBodyPart;
		if callFuncParams(_usr,hasPart,_bp) exitWith {
			callFuncParams(_connecter,localSay,"Такая часть тела уже есть..." arg "error");
		};
		if not_equals(_bp,getSelf(bodyPartIndex)) exitWith {
			callFuncParams(_connecter,localSay,"Эта часть тела сюда не отсюда." arg "error");
		};
		callSelfParams(link,_usr arg _bp);
	};
	
	func(disconnectBodyPart)
	{
		objParams_1(_usr);
		if callSelf(isAttached) exitWith {
			if (equalTypes(_usr,nullPtr) && {callFunc(_usr,isMob)}) then {
				callFuncParams(_usr,localSay,"Эта часть закреплена." arg "error");
			};
		};
		
		callSelfParams(unlink,_usr);
	};
	
	func(onBodyPartLinked)
	{
		objParams_1(_usr);

		setVar(_usr,weight,getVar(_usr,weight) + getSelf(weight));
		setSelf(loc,_usr);
		callFunc(_usr,syncBodyParts);
	};

	//Событие вызывается при потере части тела (насильственном или хирургическом)
	//Вызывается ВСЕГДА непосредственно ПЕРЕД обнулением ссылки на часть тела в bodyParts для _usr
	func(onBodyPartUnlinked)
	{
		objParams_1(_usr);

		setVar(_usr,weight,getVar(_usr,weight) - getSelf(weight)); //убираем лишнего веса с персонажа
		setSelf(loc,nullPtr);
		if getSelf(isVital) then {
			callFuncParams(_usr,Die,vec2(di_vitalPartLoss,this));
		};

		if isTypeOf(this,Arm) then {
			//drop item in hand
			callFuncParams(_usr,dropItem,if (getSelf(side) < 0) then {INV_HAND_L} else {INV_HAND_R});
		};
	};

	//Пост событие линковки. Вызывается после фактической линковки
	func(onBodyPartPostLinked) {
		objParams_1(_usr);
		if !isTypeOf(this,Head) then {
			callFunc(_usr,syncBodyParts);
		};

		callFunc(_usr,recalcBloodLoss);
	};
	//Пост событие линковки. Вызывается после фактической линковки
	func(onBodyPartPostUnlinked) {
		objParams_1(_usr);
		if !isTypeOf(this,Head) then {
			callFunc(_usr,syncBodyParts);
		};

		callFunc(_usr,recalcBloodLoss);
		callFunc(_usr,onSyncBones);

		private _pain = getSelf(pain);
		if (_pain > PAIN_LEVEL_NO) then {
			callFuncParams(_usr,addPainLevel,BP_INDEX_TORSO arg _pain);
		};
		setSelf(pain,0);
		setSelf(painTime,0);
	};

	getter_func(getPickupSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);
	getter_func(getPutdownSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);
	getter_func(getDropSound,"flesh\flesh_drop");
	getter_func(getEquipSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);
	getter_func(getUnequipSound,["flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6)]);

	//--------------------------------------------------------------------------
	//вся логика ран тут
	//--------------------------------------------------------------------------

	// внутренняя карта для типа раны pair(WOUND_SIZE..,amount)
	#define _rwt(t) [t,hashMapNew]
	var(partDamage,hashMapNewArgs [_rwt(WOUND_TYPE_BRUISE) arg _rwt(WOUND_TYPE_BLEEDING) arg _rwt(WOUND_TYPE_BURN)])

	getter_func(isBoneBroken,getSelf(boneStatus) == BONE_STATUS_BROKEN);
	
	// Пользовательское событие, вызываемое при изменении состояния кости
	func(onChangeBoneStatus)
	{
		objParams_1(_newStatus);
	};

	func(playBreakBoneSound)
	{
		objParams();
		private _randSound = "mob\trauma" + str randInt(1,3);
		callSelfParams(playSound,_randSound arg getRandomPitchInRange(0.5,1.1));
	};

	func(getBoneStatusText)
	{
		objParams();
		private _status = getSelf(boneStatus);
		if (_status == BONE_STATUS_OK) exitWith {""};
		if (_status == BONE_STATUS_CRACK) exitWith {"трещина"};
		if (_status == BONE_STATUS_BROKEN) exitWith {"перелом"};
		"!!!Хуй пойми что!!!"
	};

	func(setBoneStatus)
	{
		objParams_2(_status,_dosound);

		if (getSelf(boneStatus) == _status) exitWith {
			if (!isNullVar(_dosound) && {_dosound}) then {
				callSelf(playBreakBoneSound);
			};
		}; //already setted

		setSelf(boneStatus,_status);

		callSelfParams(onChangeBoneStatus,_status);

		private _src = callSelf(getSourceLoc);
		if !isNullReference(_src) then {
			callFunc(_src,onSyncBones);
		};
	};
	
	//вывих. вправить часть можно инструментом или самостоятельно. вывихнутой частью тела нельзя пользоваться
	var(isWrenched,true);
	
	autoref var(bandage,nullPtr);//наложенный бинт
	getter_func(isBandaged,!isNullObject(getSelf(bandage)));
	getter_func(canBandageBlockBleeding,((keys (getSelf(partDamage) get WOUND_TYPE_BLEEDING))findif{_x >= BLOOD_BLOCKED_BANDAGE_WOUNDSIZE})!=-1);

	var_num(lastDamageTime); //Момент когда эта часть тела последний раз получила повреждения

	//Показывает сколько крови будет тратиться с части
	func(getBloodLossValue)
	{
		objParams();
		if !callSelf(isAttached) exitWith {0};
		private _value = 0;
		private _woundArr = getSelf(partDamage) get WOUND_TYPE_BLEEDING;
		private _hasBlockBandage = callSelf(canBandageBlockBleeding);
		//Если часть забинтована и нет критической или выше раны то бинт захилит кровь
		if (callSelf(isBandaged) && !_hasBlockBandage) exitWith {_value};
		
		//надрез кровоточит
		if getSelf(isIncised) then {
			modvar(_value) + (BLOOD_LOSS_INCISED);
		};
		
		{
			//_x - wound size, _y - wound amounts
			MOD(_value, + (BLOOD_GET_BLOODLOSS_BY_WOUND_SIZE(_x)*_y));
		} foreach _woundArr;
		_value
	};

	func(addBandage)
	{
		objParams_1(_item);
		if !isTypeOf(_item,Bandage) exitWith {};
		if !callFunc(getSelf(loc),isMob) exitWith {};

		setSelf(bandage,_item);
		setVar(_item,loc,this);
		callFunc(getSelf(loc),recalcBloodLoss);
	};

	func(removeBandage)
	{
		objParams_1(_usr);
		if !callSelf(isBandaged) exitWith {false};

		private _bandageOwner = getSelf(loc);
		private _band = getSelf(bandage);
		setSelf(bandage,nullPtr);
		callFunc(_bandageOwner,recalcBloodLoss);
		if equalTypes(_usr,[]) exitWith {
			[_band,_usr] call noe_loadVisualObject;			
		};
		if equalTypes(_usr,objNUll) exitWith {
			[_band,_usr] call noe_loadVisualObject_OnDrop;
			callFuncParams(_band,onDrop,nullPtr);
		};
		if isNullVar(_usr) exitWith {
			delete(_band);
		};
		callFuncParams(_usr,addItem,_band);
	};

	//система боли
	var(pain,0);
	var(painTime,0);

	func(healPain)
	{
		objParams_2(_time,_doRecalculateHandler);
		if (getVar(this,pain) <= PAIN_LEVEL_NO) exitWith {}; //нет боли
		setSelf(painTime, (getSelf(painTime) - _time) max 1);
		if !isNullVar(_doRecalculateHandler) then {
			if (_doRecalculateHandler) then {
				callSelf(handle_pain);
			};
		};
	};

	//Отладка
	//#define debug_body_wounds_regen

	//Срабатывает только во сне
	//_usr - external link
	var(nextCheckTime,0);
	func(onUpdate)
	{
		objParams();

		//С последнего повреждения должно пройти время
		#ifndef debug_body_wounds_regen
		if (getSelf(lastDamageTime) + BODY_PART_REGEN_DELAY > tickTime) exitWith {};
		#endif
		/*
			(callFunc(_usr,getHt) call gurps_rollnocrit) params ["_amount","_result"];
			Реген вызывается каждые 5 секунд
			Условия лечения:
				- последняя атака по части была достаточно давно
				- если мало еды штраф -4 к броску регена

			Броски проверки лечения делаются для каждой раны
		*/

		if (tickTime >= getSelf(nextCheckTime)) then {
			setSelf(nextCheckTime,tickTime + randInt(5,6));

			#ifdef debug_body_wounds_regen
			setSelf(nextCheckTime,tickTime + 1);
			#endif

			{
				callSelfParams(regenProcessWounds,_usr arg _x);
			} foreach keys getSelf(partDamage);
		};
	};

	//Есть ли такой урон на персонаже
	func(hasAnyDamageOfType)
	{
		objParams_1(_woundType);
		count (getSelf(partDamage) get _woundType) > 0
	};

	//Процесс регенерации одноразовый
	func(regenProcessWounds)
	{
		params ['this',"_usr","_woundType",["_modifHT",0]];

		if (getVar(_usr,hunger) < BODY_PART_HUNGER_REGEN_LOWLEVEL) then {
			modvar(_modifHT)-4;// правило по расширению
		};

		private _woundArr = getSelf(partDamage) get _woundType;
		private _doRecreate = false;

		for "_i" from WOUND_SIZE_SCRATCH to WOUND_SIZE_DESTRUCTION do {
			//таких ран нет
			if (!(_i in _woundArr)) then {continue};

			#ifdef debug_body_wounds_regen
			traceformat("CHECK WOUND SIZE %1 for part %2",_i arg this)
			#endif

			private _roll = callFuncParams(_usrc,checkSkill,"HT" arg _modifHT);

			if (getRollType(_roll) in [DICE_SUCCESS,DICE_CRITSUCCESS]) then {

				#ifdef debug_body_wounds_regen
				traceformat("SUCCESS REGEN %1 for %2",_i arg this)
				#endif

				if (_i<=WOUND_SIZE_SCRATCH) then {
					_woundArr deleteAt _i;

					#ifdef debug_body_wounds_regen
					traceformat("RECALC (DELETED)=> %1",_woundArr)
					#endif

				} else {

					private _cursize = _woundArr get _i;
					_woundArr deleteAt _i;
					_prvSize = _woundArr getOrDefault [_i-1,0];
					if (_prvSize>0)then {_cursize = 5};
					_woundArr set [_i-1,_cursize];

					#ifdef debug_body_wounds_regen
					traceformat("RECALC => %1",_woundArr)
					#endif
				};

				_doRecreate = true;
			};
		};

		if (_doRecreate && _woundType == WOUND_TYPE_BLEEDING) then {
			callFunc(_usr,recalcBloodLoss);
		};
	};
	//метод полностью копипастит regenProcessWounds но без ролла
	func(regenProcessWoundsNoRoll)
	{
		params ['this',"_usr","_woundType"];
		private _woundArr = getSelf(partDamage) get _woundType;
		private _doRecreate = false;
		for "_i" from WOUND_SIZE_SCRATCH to WOUND_SIZE_DESTRUCTION do {
			//таких ран нет
			if (!(_i in _woundArr)) then {continue};
			if (_i<=WOUND_SIZE_SCRATCH) then {
				_woundArr deleteAt _i;
			} else {
				private _cursize = _woundArr get _i;
				_woundArr deleteAt _i;
				_prvSize = _woundArr getOrDefault [_i-1,0];
				if (_prvSize>0)then {_cursize = 5};
				_woundArr set [_i-1,_cursize];
			};

			_doRecreate = true;

		};
		if (_doRecreate && _woundType == WOUND_TYPE_BLEEDING) then {
			callFunc(_usr,recalcBloodLoss);
		};
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		super() + ifcheck(getSelf(isRotten),sbr+"Сгнило...","");
	};
	
	func(doRotten)
	{
		objParams();
		setSelf(isRotten,true);

		private _pre = pick["О боже!!!","Ужасно...","Паршиво..."];
		private _mes = _pre + "" + callSelf(getName) + " гниет";
		callFuncParams(getSelf(loc),localSay,setstyle(_mes,style_redbig));
		if getSelf(isVital) then {
			callFuncParams(getSelf(loc),Die,vec2(di_vitalPartRotten,this));
		};

		callFuncParams(getSelf(loc),adjustPain,BP_INDEX_TORSO arg randInt(1000,1300));

		callSelf(transferInfection);
	};

	//данные для некроза части тела: уровень инфекции и время до перехода в следующее состояние гниения
	var(infectionLevel,0); //с 1 по 4, где 4 полное сгнивание
	var(infectionTime,0); //1 - 5 минут, 2 - 5 минут, 3 - 10 минут, 4 - 15 минут

	func(addInfection)
	{
		objParams_1(_level);
		
		if getSelf(isRotten) exitWith {};

		if isNullVar(_level) then {
			_level = INFECTION_MIN_LEVEL;
		};
		_level = clamp(_level,INFECTION_MIN_LEVEL,INFECTION_MAX_LEVEL);
		setSelf(infectionLevel,_level);
		setSelf(infectionTime,0);
	};
	
	func(removeInfection)
	{
		objParams_1(_level);
		if isNullVar(_level) then {
			_level = INFECTION_MAX_LEVEL;
		};
		private _curlvl = getSelf(infectionLevel);
		modvar(_curlvl) - _level;
		_curlvl = clamp(_curlvl,0,INFECTION_MAX_LEVEL);
		setSelf(infectionLevel,_curlvl);
		setSelf(infectionTime,0);
	};

	func(handleInfections)
	{
		objParams();
		private _level = getSelf(infectionLevel);
		if inRange(_level,INFECTION_MIN_LEVEL,INFECTION_MAX_LEVEL) then {
			modSelf(infectionTime, + 1);
			if (getSelf(infectionTime) > (INFECTION_LIST_DELAY_NEXTLEVEL select _level)) then {
				modSelf(infectionLevel, + 1);
				modSelf(infectionTime, + 0);
				if (getSelf(infectionLevel) > INFECTION_MAX_LEVEL) then {
					callSelf(doRotten);
				};
			};
		} else {
			if getSelf(isRotten) exitWith {};
			if !callSelf(canWoundPassInfection) exitWith {};
			private _germs = getSelf(germs);

			if (_germs >= GERM_COUNT_INFECTION) then {
				//check skill HT
				private _modifHT = 0;
				if (_germs > 80) then {
					modvar(_modifHT) - 5;
				};
				private _roll = callFuncParams(_usr,checkSkill,"HT" arg _modifHT);
				if DICE_ISFAIL(getRollType(_roll)) then {
					callSelfParams(addInfection,null);
				};
			};
		};
	};

	func(canWoundPassInfection)
	{
		objParams();
		((keys (getSelf(partDamage) get WOUND_TYPE_BLEEDING))findif{_x >= GERM_MIN_WOUND_SIZE})!=-1
	};

	func(transferInfection)
	{
		objParams();
		private _curPart = getSelf(bodyPartIndex);
		private _mob = callSelf(getSourceLoc);
		if isNullReference(_mob) exitWith {};
		if !isTypeOf(_mob,Mob) exitWith {};
		
		private _canTransferToPartDelegate = {
			private _part = _this;
			if !callFuncParams(_mob,hasPart,_part) exitWith {false};
			private _pObj = callFuncParams(_mob,getPart,_part);
			getVar(_pObj,infectionLevel) < INFECTION_MIN_LEVEL && !getVar(_pObj,isRotten)
		};
		if not_equals(_curPart,BP_INDEX_TORSO) then {
			traceformat("DEINFO %1 %2",callFuncParams(_mob,getPart,BP_INDEX_TORSO) arg !getVar(callFuncParams(_mob,getPart,BP_INDEX_TORSO),isRotten))
			if (BP_INDEX_TORSO call _canTransferToPartDelegate) then {
				callFuncParams(callFuncParams(_mob,getPart,BP_INDEX_TORSO),addInfection,null);
			};
		} else {
			{
				if !callFuncParams(_mob,hasPart,_x) exitWith {};
				if (_x call _canTransferToPartDelegate) then {
					callFuncParams(callFuncParams(_mob,getPart,_x),addInfection,null);
				};
			} foreach (BP_INDEX_ALL - [BP_INDEX_TORSO]);
		};
	};

	var(partGermKey,"");//bd,lh,rh,hd
	func(getGermOpacityData)
	{
		objParams();
		if (getSelf(partGermKey)=="") exitwith {
			null
		};

		[
			getSelf(partGermKey),
			GERM_CONV_VALUE_TO_OPACITY(getSelf(germs))
		]
	};

	getter_func(getGermDecalIndex,0); //0 - body, 1 - arms, 2 - legs
	getter_func(getGermDecalVisibility,GERM_CONV_VALUE_TO_VISIBILITY_DECAL(getSelf(germs)));

	func(updateGermsAt)
	{
		objParams_1(_p);
		super();
		if getSelf(isAttached) then {
			private _mob = getSelf(loc);
			if isNullReference(_mob) exitwith {};
			if !isTypeOf(_mob,BasicMob) exitwith {};
			
			callFunc(_mob,syncGermsVisual);
		};
	};

endclass

class(Body) extends(BodyPart)
	var(name,"Туловище");
	var(desc,"Остатки человеческой сущности.");
	var(size,ITEM_SIZE_LARGE);
	var(weight,randInt(22,25));
	var(isVital,true);
	
	var(bodyPartIndex,BP_INDEX_TORSO);
	var(partGermKey,"bd");
	getter_func(getGermDecalIndex,0);
	
	var(organs,null);
	
	//вскрытый торс (для доступа к органам)
	autoref var(surgexpander,nullPtr);
	getter_func(isOpened,!isNullReference(getSelf(surgexpander)));
	
	func(openBodyWithExpander)
	{
		objParams_1(_exp);
		callFuncParams(_exp,moveItem,this)
	};
	
	func(canMoveInItem)
	{
		objParams_1(_item);
		if isTypeOf(_item,SurgicalExpander) exitWith {
			!callSelf(isOpened)
		};
		false
	};
	func(canMoveOutItem)
	{
		objParams_1(_item);
		if !callSelf(isOpened) exitWith {false};
		if not_equals(getSelf(surgexpander),_item) exitWith {false};
		true
	};
	
	func(onMoveOutItem)
	{
		objParams_1(_item);
		if equals(getSelf(surgexpander),_item) then {
			
			setVar(_item,loc,nullPtr);
			setSelf(surgexpander,nullPtr);
			
			callFuncParams(getSelf(loc),adjustPain,getSelf(bodyPartIndex) arg randInt(100,200));
			
			private _ptr = getVar(_item,pointer);
			
			private _handle = {
				private _ctx = _this;
				if (count _ctx > 1) then {
					_params = _ctx select 1;
					private _idx = _params findif {equals(_x select 0,_ptr)};
					_params deleteAt _idx;
				};
				_ctx
			};
			
			callFuncParams(getSelf(loc),updateVisualState,"VST_ATTACHED_OBJECTS" arg _handle arg []);
			
			callFuncParams(getSelf(loc),playSound,"flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6));
		};
	};
	
	func(onMoveInItem)
	{
		objParams_1(_item);
		setVar(_item,loc,this);
		setSelf(surgexpander,_item);
		
		callFuncParams(getSelf(loc),adjustPain,getSelf(bodyPartIndex) arg randInt(500,1000));
		
		private _ptr = getVar(_item,pointer);
		private _model = getVar(_item,model);
		private _ctxUpdate = [_ptr,_model,[0,0.15,-0.14],"spine3",[90,-5,-90],0.6];
		private _handle = {
			private _ctx = _this;
			if (count _ctx > 1) then {
				_params = _ctx select 1;
				private _idx = _params findif {equals(_x select 0,_ptr)};
				//"_ptr","_model","_bias","_selection","_vec",["_scale",1]
				if (_idx==-1) then {
					_params pushBack _ctxUpdate;
				} else {
					_params set [_idx,_ctxUpdate];
				};
			};
			_ctx
		};
		
		callFuncParams(getSelf(loc),updateVisualState,"VST_ATTACHED_OBJECTS" arg _handle arg [_ctxUpdate]);
		
		callFuncParams(getSelf(loc),playSound,"flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6));
	};
	
	func(tryRemoveExpander)
	{
		objParams_1(_usr);
		if !callSelf(isOpened) exitWith {};
		private _sexp = getSelf(surgexpander);
		private _oldLoc = getSelf(loc);
		if callFuncParams(_sexp,moveItem,_usr) then {
			callFuncParams(_usr,meSay,"снимает " + callFunc(_sexp,getName) + " с " + callFuncParams(_oldLoc,getNameEx,"кого"));
		};
	};
	
	//структура данных листбокса: индекс органа, указатель моба,указатель части тела, указатель органа
	func(showOrgans)
	{
		objParams_1(_usr);
		private _data = ["Выберите орган:"];
		{
			if !callFuncParams(getSelf(loc),hasBodyOrgan,_x) then {
				_data pushBack (format ["Зона - %1|%2-%3-%4-%5",BO_INDEX_TO_NAME(_x),_x,getVar(getSelf(loc),pointer),getSelf(pointer),""]);
			} else {
				_data pushBack (format ["Зона - %1|%2-%3-%4-%5",BO_INDEX_TO_NAME(_x),_x,getVar(getSelf(loc),pointer),getSelf(pointer),getVar(callFuncParams(getSelf(loc),getBodyOrgan,_x),pointer)]);
			};
		} foreach BO_INDEX_ALL;
		private _event = {
			
			(_value splitString "-")params ["_organIdx","_mobPtr","_bpPtr","_organPtr"];
			pointer_tryUnpackLazy(_bpPtr,_body);
			pointer_tryUnpackLazy(_mobPtr,_mob);
			if (isNullReference(_body) || isNullReference(_mob)) exitWith {
				callSelf(CloseMessageBox);
			};
			_organIdx = parseNumber _organIdx;
			_organ = callFuncParams(_mob,getBodyOrgan,_organIdx);
			private _data = ["Зона - "+BO_INDEX_TO_NAME(_organIDX)];
			private _surgery = callFunc(this,getSurgery);
			private _canUseSurgerySkill = _surgery > 7;
			{
				_x params ["_name","_act"];
				//if (_act == "get" && isNullReference(_organ)) then {continue};
				//if (_act == "insert" && !isNullReference(_organ)) then {continue};
				if (_act == "attach" && !_canUseSurgerySkill) then {continue};
				_data pushBack format["%1|%2-%3-%4-%5-%6",_name,_act,_organIdx,_mobPtr,_bpPtr,getVar(_organ,pointer)];
			} foreach [
				["Изучить","examine"],
				["Изъять","get"],
				["Поместить","insert"],
				["Соеденить сосуды","attach"],
				["Назад","back"]
			];
			
			private _eventInternal = {
				(_value splitString "-")params["_action","_organIdx","_mobPtr","_bpPtr","_organPtr"];
				_organIdx = parseNumber _organIdx;
				
				pointer_tryUnpackLazy(_bpPtr,_body);
				pointer_tryUnpackLazy(_mobPtr,_mob);
				if (isNullReference(_body) || isNullReference(_mob)) exitWith {
					callSelf(CloseMessageBox);
				};
				pointer_tryUnpack(_organPtr,_organ);
				
				if (isNullReference(_organ) && _action in ["examine","get","attach"]) exitWith {
					private _m = pick["Там нет органа...","Ничего лишнего. Даже органа!","Там, где должен быть орган - пусто!"];
					callSelfParams(mindSay,_m);
					//setMessageBoxContext
					//callSelf(UpdateMessageBox);
					if (_action == "examine") exitWith {};
					callSelf(CloseMessageBox);
				};
				//если орган уже не в этом теле
				if not_equals(getVar(_organ,loc),_body) exitWith {
					callSelf(CloseMessageBox);
				};
				
				if (_action == "examine") then {
					callSelfParams(examine,_organ);
				};
				if (_action == "get") then {
					if !callFuncParams(this,canMoveInItem,_organ) exitWith {
						callSelfParams(localSay,"Не могу вытащить... Наверное надо руку освободить..." arg "error");
					};
					private _item = callSelf(getItemInNotActiveHandRedirect);
					private _isHandedRemoving = isNullReference(_item);
					private _isrem = false;
					if (_isHandedRemoving) then {
						_isrem = true;
						callSelfParams(meSay,"вырывает "+lowerize(callFunc(_organ,getName)) + " у " + callFuncParams(_mob,getNameEx,"кого"));
						callFuncParams(_mob,adjustPain,getVar(_body,bodyPartIndex) arg randInt(700,1000));
						callFuncParams(_organ,setStatus,ORGAN_STATUS_DESTROYED);
					} else {
						if isTypeOf(_item,Forceps) then {
							_isrem = true;
							callSelfParams(meSay,"извлекает "+lowerize(callFunc(_organ,getName)) + " у " + callFuncParams(_mob,getNameEx,"кого"));
						} else {
							callSelfParams(localSay,"С помощью " + callFunc(_item,getName) + " нельзя вытащить "+ (callFunc(_organ,getName)) arg "error");
						};
					};
					if (_isrem) then {
						callFuncParams(_mob,playSound,"flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6));
						callFuncParams(_organ,unlink,this);
						callSelf(CloseMessageBox);
					};
				};
				if (_action == "insert") then {
					private _item = callSelf(getItemInActiveHandRedirect);
					if isNullReference(_item) exitWith {
						callSelfParams(localSay,"А что вставлять?" arg "error");
					};
					if !isTypeOf(_item,Organ) exitWith {
						callSelfParams(localSay,callFunc(_item,getName) + " не является органом." arg "error");
					};
					if not_equals(_organIdx,callFunc(_item,getOrganSocketName)) exitWith {
						callSelfParams(localSay,callFunc(_item,getName) + " на это место не встанет." arg "error");
					};
					if !callFuncParams(_item,link,_body arg _organIdx) exitWith {
						callSelfParams(localSay,"Не получилось вставить "+callFunc(_item,getName)+"." arg "error");
					};
					callSelfParams(meSay,"помещает "+lowerize(callFunc(_item,getName)) + " в " + callFuncParams(_mob,getNameEx,"вин"));
					callFuncParams(_mob,playSound,"flesh\flesh"+str pick[1 arg 2] arg getRandomPitchInRange(.85,1.6));
					callSelf(CloseMessageBox);
				};
				if (_action == "attach") then {
					private _surgery = callFunc(this,getSurgery);
					private _canUseSurgerySkill = _surgery > 7;
					if (!_canUseSurgerySkill) exitWith {
						callSelfParams(localSay,"Я не понимаю как это сделать!" arg "error");
					};
					private _item = callSelf(getItemInActiveHandRedirect);
					if isNullReference(_item) exitWith {
						callSelfParams(localSay,"Голыми руками не справиться." arg "error");
					};
					if !isTypeOf(_item,Forceps) exitWith {
						callSelfParams(localSay,"Соеденить сосуды с помощью "+callFunc(_item,getName)+" не получится." arg "error");
					};
					if getVar(_organ,isAttached) exitWith {
						callSelfParams(localSay,callFunc(_organ,getName)+" уже соединен." arg "error");
					};
					setVar(_organ,isAttached,true);
					callSelfParams(meSay,"соединяет сосуды на "+callFunc(_organ,getName));
					callSelf(CloseMessageBox);
				};
				if (_action == "back") then {
					callFuncParams(_body,showOrgans,this);
				};
			};
			
			callSelfParams(ShowMessageBox,"Listbox" arg _data arg _eventInternal arg callFunc(_body,getSourceLoc));
		};
		callFuncParams(_usr,ShowMessageBox,"Listbox" arg _data arg _event arg getSelf(loc));
	};
	
	func(constructor)
	{
		objParams();
		private _organs = [
			new(Heart),
			new(Liver),
			newParams(Kidney,1),
			newParams(Kidney,-1),
			new(Guts),
			new(Stomach),
			new(Lungs)
		];
		private _map = BO_INDEX_ALL createHashMapFromArray _organs;
		setSelf(organs,_map);
		{
			setVar(_y,loc,this);
			setVar(_y,isAttached,true);
		} foreach _map;
	};

	func(damageOrgan)
	{
		objParams_1(_organIDX);
		private _organs = getSelf(organs);
		if !(_organIDX in _organs) exitWith {};
		private _organ = _organs get vec2(_organIDX,nullPtr);
		if isNullObject(_organ) exitWith {};
		callFuncParams(_organ,setStatus,ORGAN_STATUS_DAMAGED);
	};

	func(damageRandomOrgan)
	{
		objParams();
		private _organs = getSelf(organs);
		private _canDamList = [];
		{
			if !isNullObject(_y) then {
				if callFunc(_y,isStatusOk) then {
					_canDamList pushBack _x;
				};
			};
		} forEach _organs;

		if (count _canDamList > 0) then {
			callSelfParams(damageOrgan,pick _canDamList);
		};
	};
	
	func(doRotten)
	{
		objParams();
		super();
		{
			callFuncParams(_y,setStatus,ORGAN_STATUS_DESTROYED);
		} foreach getSelf(organs);
	};
	
endclass

editor_attribute("InterfaceClass")
class(Head) extends(BodyPart)
	var(isVital,true);
	
	var(bodyPartIndex,BP_INDEX_HEAD);
	var(partGermKey,"hd");

	var(name,"Голова");
	var(desc,"Эта голова уже никому ничего не расскажет. Кто знает, может быть это и к лучшему.");
	//Правила как для почек -1 и 1 (left,right)
	var(eyes,[new(Eye) arg new(Eye)]);
	var(tongue,new(Tongue));
	var(brain,new(Brain));
	var(slotedWeap,weaponModule(Bite));

	var(model,"ml_shabut\exoduss\golova_trup1.p3d");
	var(weight,5.4);
	var(dr,1);

	var(isAlreadyRenamed,false); //нужно чтобы не переименовывать пересаженную голову сотни раз "Голова Васи Голова Васи Голова Васи..."

	var(icon,invicon(head));

	getter_func(getEyesCount,{!isNullReference(_x)}count getSelf(eyes));

	//Количество зубов
	var(teeth,32);
	
	func(constructor)
	{
		objParams();
		{
			setVar(_x,loc,this);
			setVar(_x,isAttached,true);
		} foreach getSelf(eyes);
		setVar(getSelf(tongue),loc,this);
		setVar(getSelf(tongue),isAttached,true);
		setVar(getSelf(brain),loc,this);
		setVar(getSelf(brain),isAttached,true);
	};
	
	func(doRotten)
	{
		objParams();
		super();
		//todo eyes,tongue and brain rotten process
	};
	
	func(destructor)
	{

		//Dispose organs
		objParams();
		{
			delete(_x);
		} foreach getSelf(eyes);

		delete(getSelf(tongue));
		delete(getSelf(brain));
	};

	func(onBodyPartUnlinked)
	{
		objParams_1(_usr);
		super();
		{callFuncParams(_usr,dropItemFromSlot,_x)} foreach INV_LIST_FACE;
	};

	func(onBodyPartPostUnlinked)
	{
		objParams_1(_usr);

		callSuper(BodyPart,onBodyPartPostUnlinked);

		callFuncParams(_usr,setMobFace,callFunc(_usr,getMobFace) + "_nohead");

		if getSelf(isAlreadyRenamed) exitWith {};

		private _usrName = callFuncParams(_usr,getNameEx,"кого");

		setSelf(name,"Голова " + _usrName);

		setSelf(isAlreadyRenamed,true);
	};

endclass

class(Head1) extends(Head)
	var(model,"ml_shabut\exoduss\golova_trup1.p3d");
endclass

class(Head2) extends(Head)
	var(model,"ml_shabut\exoduss\golova_trup2.p3d");
endclass

class(Head3) extends(Head)
	var(model,"ml_shabut\exoduss\golova_trup3.p3d");
endclass

editor_attribute("InterfaceClass")
class(ITwoSidedBodyPart) extends(BodyPart)
	var(side,-1);//-1 left, 1 right

	func(constructor)
	{
		objParams();
		if equalTypes(ctxParams,0) then {
			if (ctxParams > 0) then {
				setSelf(side,1);
			} else {
				setSelf(side,-1);
			};
		};
	};

	func(getSideName)
	{
		objParams();
		if (getSelf(side) > 0) then {"Правая"} else {"Левая"}
	};

	func(getName)
	{
		objParams();
		callSelf(getSideName) + " " + super();
	};
endclass

class(Arm) extends(ITwoSidedBodyPart)
	var(name,"Рука");
	var(model,"relicta_models2\body_parts\s_arm\s_arm.p3d");
	var(weight,2.4);
	var(desc,"Сколько всего интересного могла бы сделать эта рука, но ей не повезло");
	var(slotedWeap,weaponModule(Fists));
	func(onBodyPartUnlinked)
	{
		objParams_1(_usr);
		super();
		callFuncParams(_usr,dropItemFromSlot,ifcheck(equals(getSelf(side),SIDE_RIGHT),INV_HAND_R,INV_HAND_L));
		if callFunc(_usr,isHandcuffed) then {
			callFuncParams(getVar(_usr,handcuffObject),doFree,null);
		};
	};
	
	func(constructor)
	{
		objParams();
		private _idx = [BP_INDEX_ARM_L,BP_INDEX_ARM_R] select sideToIndex(getSelf(side));
		setSelf(bodyPartIndex,_idx);

		private _hkey = ["lh","rh"] select sideToIndex(getSelf(side));
		setSelf(partGermKey,_hkey);
	};

	getter_func(getGermDecalIndex,1);
	
endclass

class(Leg) extends(ITwoSidedBodyPart)
	var(name,"Нога");
	var(model,"relicta_models2\body_parts\s_leg\s_leg.p3d");
	var(weight,4.3);
	var(desc,"Даже теперь она остаётся хорошим оружием.");
	var(slotedWeap,weaponModule(Punch));
	
	func(constructor)
	{
		objParams();
		private _idx = [BP_INDEX_LEG_L,BP_INDEX_LEG_R] select sideToIndex(getSelf(side));
		setSelf(bodyPartIndex,_idx);
	};
	
	getter_func(getGermDecalIndex,2);

	func(onBodyPartPostUnlinked)
	{
		objParams_1(_usr);

		callSuper(ITwoSidedBodyPart,onBodyPartPostUnlinked);

		if (!callFuncParams(_usr,hasPart,BP_INDEX_LEG_R)
			&& !callFuncParams(_usr,hasPart,BP_INDEX_LEG_L)) then {
			callFunc(_usr,KnockDown);
		};
	};
endclass