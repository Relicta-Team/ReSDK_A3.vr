// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"


editor_attribute("InterfaceClass")
class(ITrapItem) extends(Item)
	autoref var(trapStruct,nullPtr); //Ссылка на структуру ловушки
	getter_func(isTrapActive,!isNullReference(getSelf(trapStruct))); //Создана ли структура ловушки
	//Работает ли эта ловушка в данный момент
	getter_func(isTrapEnabled,callSelf(isTrapActive) && {callFunc(getSelf(trapStruct),tIsEnabled)});

	getterconst_func(activateOnCreate,false); //Будет активировать ловушку при создании

	getter_func(isMovable,!callSelf(isTrapEnabled));

	func(constructor)
	{
		objParams();
		if callSelf(activateOnCreate) then {
			callSelfAfter(__initTrap,2);
		};
	};

	func(__initTrap) //внутренняя функция инициализации при флаге activateOnCreate
	{
		objParams();
		callSelfParams(setTrapEnable,true);
	};

	//Вызывается при активации ловушки когда игрок зашёл в триггер
	func(onActivateTrap)
	{
		objParams_1(_usr);
	};
	//Вызывается при активации ловушки когда игрок взаимодействовал с ловушкой
	func(onActivateHandTrap)
	{
		objParams_1(_usr);
	};

	//создание или удаление ловушки
	func(setTrapActive)
	{
		objParams_1(_mode);
		if equals(_mode,callSelf(isTrapActive)) exitWith {false}; //already setted

		private _bcond = true;

		if (_mode) then {
			if !callSelf(isInWorld) exitWith {_bcond = false};
			private _t = ["TrapVirtualStruct",getPosATL getSelf(loc),null,false] call createStructure;
			setSelf(trapStruct,_t);
			setVar(_t,trapObj,this);
		} else {
			delete(getSelf(trapStruct)); //potential ptr list owerflow
		};

		_bcond
	};
	//Включение системного объекта ловушки
	func(setTrapEnable)
	{
		objParams_1(_mode);
		if (!callSelf(isTrapActive) && _mode) then {
			callSelfParams(setTrapActive,true);
		};
		if (callSelf(isTrapActive) && !_mode) then {
			callSelfParams(setTrapActive,false);
		};

		callFuncParams(getSelf(trapStruct),setTriggerEnalbe,_mode);
	};

	func(canPickup)
	{
		objParams();
		super() && !callSelf(isTrapEnabled);
	};

	func(onCantPickup)
	{
		objParams_1(_usr);
		if (callSelf(isTrapEnabled)) then {
			callSelfParams(setTrapEnable,false);
			callSelfParams(onActivateHandTrap,_usr); //по рукам ебашим
		};
	};

	func(onPickup)
	{
		objParams_1(_usr);
		super();
		callSelfParams(setTrapEnable,false);
	};

/*	func(onPutdown)
	{
		objParams_1(_usr);
		super();
	};

	func(onDrop)
	{
		objParams_1(_usr);
		super();
	};*/




endclass

//Виртуальный триггер ловушки. Не должен быть создан пользователем
class(TrapVirtualStruct) extends(IStruct)
	var(model,"a3\structures_f\system\cluttercutter_small_f.p3d");

	#include "..\..\Interfaces\ITrigger.Interface"
	//attributeParams(hasField,"tDistance" arg "tDelay" arg "tCallDelay");
	var(tDistance,0.4);
	var(tDelay,0.1);
	var(tCallDelay,0.2);
	var(trapObj,nullPtr);

	func(onTriggerActivated)
	{
		objParams_1(_usr);
		if !isTypeOf(_usr,Mob) exitwith {};//только мобы могу активировать ловушку
		callFuncParams(getSelf(trapObj),onActivateTrap,_usr);
		callFuncParams(getSelf(trapObj),setTrapEnable,false);
	};

	//onEnterArea, onLeaveArea - дают нам возможность на отправку видимых ловушек этим персонажем.

endclass


class(Trap) extends(ITrapItem)
	var(name,"Капкан");
	var(model,"relicta_models\models\weapons\kapkan\kapkan.p3d");
	var(material,"MatMetal");
	var(desc,"Стальной капкан. Используется кочевниками для поимки монстров... и иногда людей.");
	var(size,ITEM_SIZE_MEDIUM);
	var(weight,1.35);
	var(dr,4);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);
	getter_func(getMainActionName,ifcheck(callSelf(isTrapActive),"Обезвредить","Активировать"));
	var(emplacer,"map");
	func(onMainAction)
	{
		objParams_1(_usr);

		if !callSelf(isInWorld) exitWith {
			callFuncParams(_usr,mindSay,"Нужно положить ловушку на землю");
		};
		callFuncParams(_usr,startProgress,this arg "target.onChangeTrapState" arg getVar(_usr,rta)*3 arg INTERACT_PROGRESS_TYPE_FULL);

	};

	func(onChangeTrapState)
	{
		objParams_1(_usr);
		private _prevstate = callSelf(isTrapEnabled);
		private _roll = callFuncParams(_usr,checkSkill,"traps");
		if (getRollType(_roll) in [DICE_FAIL,DICE_CRITFAIL] && _prevstate) exitWith {
			callFuncParams(_usr,meSay,"допускает фатальную ошибку при обезвреживании " + callSelfParams(getNameFor,_usr));
			if (_prevstate) then {
				callSelfParams(setTrapEnable,!_prevstate);
				callSelfParams(onActivateHandTrap,_usr);
			};
		};

		callSelfParams(setTrapEnable,!_prevstate);

		if (_prevstate) then {
			callFuncParams(_usr,meSay,"разряжает " + callSelfParams(getNameFor,_usr));
		} else {
			callFuncParams(_usr,meSay,"заряжает " + callSelfParams(getNameFor,_usr));
			setSelf(emplacer,callFuncParams(gm_currentMode,getCreditsInfo,_usr arg false));
		};
	};


	func(getDescFor)
	{
		objParams_1(_usr);
		super() + ifcheck(callSelf(isTrapEnabled),sbr + "Ловушка <t color='#AD1D1D'>ГОТОВА</t>","");
	};

	func(onActivateTrap)
	{
		objParams_1(_usr);

		if callFunc(_usr,isGrabbed) then {
			//чтобы телами схваченных нельзя было обезвредить капканы
			if prob(40) then {
				_usr = getVar(_usr,grabber);
			};
		};

		//в зависимости от положения будет разный дэмеж
		private _stance = callFunc(_usr,getStance);
		private _parts = [BP_INDEX_LEG_L,BP_INDEX_LEG_R];
		private _canDamParts = [];
		if (_stance != STANCE_UP) then {
			_parts pushBack BP_INDEX_TORSO;
		};
		if (_stance == STANCE_DOWN) then {
			_parts append [BP_INDEX_ARM_R,BP_INDEX_ARM_L,BP_INDEX_HEAD];
		};
		{
			if callFuncParams(_usr,hasPart,_x) then {
				_canDamParts pushBack _x;
			};
		} foreach _parts;
		if (count _canDamParts > 0) then {
			callSelfParams(damageProcess,_usr arg pick _canDamParts);
		};
	};

	func(onActivateHandTrap)
	{
		objParams_1(_usr);
		private _part = ifcheck(getVar(_usr,activeHand) == INV_HAND_R,BP_INDEX_ARM_R,BP_INDEX_ARM_L);
		callSelfParams(damageProcess,_usr arg _part);
	};

	func(damageProcess)
	{
		objParams_2(_usr,_part);
		if !callFuncParams(_usr,hasPart,_part) exitWith {};

		private _dam = 2 call gurps_throwdices;
		callFuncParams(_usr,applyDamage,_dam arg DAMAGE_TYPE_CUTTING arg [_part] call gurps_convertBodyPartToTargetZone arg DIR_RANDOM arg vec2(di_trapDamage,getSelf(emplacer)));
		private _m = pick["схлопывается","издает леденящий щелчок","сжимается"];
		callFuncParams(this,worldSay,"<t color='#AD1D1D' size='1.3'>"+callFuncParams(this,getNameFor,_usr) + " " + _m +".</t>");
	};

	//temporary damage handler
	getter_func(canApplyDamage,true);
	func(applyDamage)
	{
		objParams_4(_amount,_type,_worldPos,_cause);
		
		if callSelf(isTrapActive) then {
			private _damMob = _caller; //caller defined inside combat system
			if !isNullVar(_damMob) then {
				//мы считаем что ближайший ударил по ловушке...
				callSelfParams(onActivateHandTrap,_damMob);
				callSelfParams(setTrapEnable,false);
			};
		};
		super();
	};

endclass

class(TrapEnabled) extends(Trap) getterconst_func(activateOnCreate,true); endclass
