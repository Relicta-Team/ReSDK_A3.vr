// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

editor_attribute("HiddenClass" arg "allChild")
class(IInfluenceEvent) extends(IGameEvent)
	
	var(name,"Событие");
	var(desc,"Описание");
	var(descRoleplay,"Что-то произошло");

	// Вес для выбора геймэвента
	var(weight,1);

	autoref var(__handle_update,-1);
	
	func(constructor)
	{
		objParams();
		callSelf(onActivate);
		
		if callSelf(canUpdate) then {
			setSelf(__handle_update,startSelfUpdateWithDelay(_onUpdateImpl,1));
		};
	};
	
	//вызывается при активации события
	//Активация события по-другому именуется как состояние иницилизации
	func(onActivate)
	{
		objParams();
	};
	
	//Если true - то новые мобы в игре будут обрабатываться методом onMob, 
	//если false - то только те, которые были в игре в момент активации события
	getter_func(canActivateOnMobAfterStart,true);
	
	// обработчик каждой сущности событием
	func(onMob)
	{
		objParams_1(_mob);
	};
	
	//Должен ли запускаться метод обновления onUpdate
	getter_func(canUpdate,false);
	
	//Вызывается каждую секунду после активации события
	func(onUpdate)
	{
		objParams();
	};
	
	func(_onUpdateImpl)
	{
		updateParams();
		callSelf(onUpdate);
	};
	
endclass


//Игровой аспект
class(BaseGameAspect) extends(IInfluenceEvent)
	var(name,"Аспект");
	var(desc,"Описание аспекта");
	var(descRoleplay,"Ролевое описание");
	
	var(allowedModes,[]);//на каких режимах(картах) доступен данный аспект. пустой массив означает что доступно всем
	var(allowedMaps,[]); //на каких картах доступен режим. пустой массив - под все карты
	
	var(weight,1);

	var(isHidden,false); //скрытые аспекты
	
	func(onActivate)
	{
		objParams();
	};
	
	func(getAspectText)
	{
		objParams();
		private _aspText = ifcheck(getSelf(isHidden),pick ["Неизвестно, страшно, загадочно" arg "Неизвестно и загадочно" arg "Неизвестно и страшно" arg "Страшно и загадочно"],getSelf(descRoleplay));
		format["<t font='Ringbear' align='center' color='#269669'><t size='1.4'>Влияние Реликты</t>%1%2</t>",sbr,_aspText];
	};
	
	func(printAspectInfo)
	{
		objParams();
		private _postHide = false;
		if getSelf(isHidden) then {
			_postHide = true;
			setSelf(isHidden,false);
		};
		private _text = callSelf(getAspectText);
		{
			callFuncParams(_x,localSay,_text arg "");
		} foreach (cm_allClients);
		
		if (_postHide) then {
			setSelf(isHidden,true);
		};
	};
	
	func(onRoundBegin)
	{
		objParams();
	};
	
	func(onRoundEnd)
	{
		objParams();
		if getSelf(isHidden) then {
			_text = format["<t font='RobotoCondensed' size='1.3' color='#269669'>Влияние Реликты - ""%1"": %2</t>",getSelf(name),getSelf(descRoleplay)];
			{
				callFuncParams(_x,localSay,_text arg "");
			} foreach (cm_allClients);
			
		};
	};
	
	func(onMob)
	{
		objParams_1(_mob);
	};
	
	
endclass

editor_attribute("HiddenClass")
// влияние реликты (колдун сотворил непотребство)
class(BaseProgressInfluenceEvent) extends(IGameEvent)
		
	var(name,"Событие");
	var(desc,"Описание");
	var(descRoleplay,"Что-то произошло");

	var(allowedModes,[]); //пустой список - доступно для всех режимов
	var(allowedMaps,[]); //пустой список - доступно для всех карт
	var(weight,1); //число от 0 до 2 со средним значением 1 (вес события)
	getterconst_func(canPlay,true); //кастомное дополнительное условие возможности запуска события
	getterconst_func(isMultiplay,false); //true означает что событие может выпадать более 1 раза
	getter_func(canPlayOnMobAtStart,false);//true вызовет onMob для всех сущностей в конструкторе
	
	//вызывается на каждой сущности при срабатывании события
	func(onMob)
	{
		objParams_1(_mob);
	};

	//только разрешенным сущностям допускается вызов onMob
	func(isAllowedMob)
	{
		objParams_1(_mob);
		isTypeOf(_mob,Mob);
	};

	getter_func(updateDelay,1);
	autoref var(update_handle,-1);
	func(onUpdate)
	{
		objParams();
		"*EMPTY_FUNCTION*"
	};

	getter_func(activateDelay,0); //любые значения больше 0 запустят onActivate

	//вызывается при активации
	func(onActivate)
	{
		objParams();
	};

	//---------------------------------------------------------------
	// private members
	//---------------------------------------------------------------
	
	//!ВСЕ СОБЫТИЯ СКРЫТЫ И НЕ ДОЛЖНЫ БЫТЬ ПУБЛИЧНЫМИ!
	getter_func(isHidden,true); //скрытое влияние не будет выводить описательное сообщение

	var(roundDurationCreated,0);
	var(tickTimeCreated,0);
	
	func(_onUpdateImpl)
	{
		updateParams();
		callSelf(onUpdate);
	};

	//принудительная остановка обновления
	func(terminateUpdate)
	{
		objParams();
		private _h = getSelf(update_handle);
		stopUpdate(_h);
		setSelf(update_handle,-1);
	};

	
	getter_func(canStartUpdate,!("*EMPTY_FUNCTION*" in (toString getFunc(this,onUpdate))));

	func(constructor)
	{
		objParams();
		//def vars
		setSelf(roundDurationCreated,gm_roundDuration);
		setSelf(tickTimeCreated,tickTime);

		//update check
		if (callSelf(canStartUpdate)) then {
			setSelf(update_handle,startSelfUpdateWithDelay(_onUpdateImpl,callSelf(updateDelay)));
		};

		//activate check
		private _delay = callSelf(activateDelay);
		if (_delay > 0) then {
			callSelfAfter(onActivate,_delay);
		} else {
			callSelf(onActivate);
		};

		//onmob check
		if callSelf(canPlayOnMobAtStart) then {
			private _m = null;
			{
				_m = _x getvariable "LINK";
				if callSelfParams(isAllowedMob,_m) then {
					callSelfParams(onMob,_m);
				};
			} foreach cm_allInGameMobs;
		};

		//created counter
		private _class = callSelf(getClassName);
		private _oldValue = gameEvents_internal_map_createdEvents getOrDefault [_class,0];
		gameEvents_internal_map_createdEvents set [_class,_oldValue + 1];

		callSelf(playNotification);
	};

	func(playNotification)
	{
		objParams();
		private _varM = pick["усиливается","усугубляется","возрастает","нарастает","крепчает","накапливается","множится","набирает силы","повышается","увеличивается"];
		private _text = if callSelf(isHidden) then {
			format["<t size='1.8' align='center'>Влияние Реликты %1...</t>",_varM];
		} else {
			format["<t size='1.8' align='center'>Влияние Реликты %1...%2%3</t>",_varM,sbr,getSelf(descRoleplay)];
		};
		private _sound = "events\event_" + str randInt(1,5);
		private _pitch = rand(0.9,1.1);
		
		{
			callFuncParams(_x,playSound,_sound arg _pitch arg 1.15);
			callFuncParams(_x,localSay,_text arg "event");
		} foreach (cm_allClients);
	};
	
endclass