// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


class(RatsEatWiresEvent) extends(InfluenceEventAllMaps)
	var(name,"Мельтешата погрызли провода");
	var(desc,"В некоторых щитках мельтешата перекусили провода");
	var(descRoleplay,"Мельтешаша погрызли провода в некоторых щитках.");
	getter_func(isMultiplay,true);

	func(onActivate)
	{
		objParams();
		private _canact = true;
		{
			if (_canact) then {
				callFunc(_x,__randomizeWires);
			};
			_canact = !_canact;
		} foreach array_shuffle(["ElectricalShield" arg true] call getAllObjectsInWorldTypeOf);
	};

endclass

class(WindFireDisablerEvent) extends(InfluenceEventAllMaps)
	var(name,"Пещерный ветер");
	var(desc,"Ветер постоянно тушит факелы, свечки и тд на земле");
	var(descRoleplay,"Пещерный ветер усиливается...");

	getterconst_func(isMultiplay,true);
	getter_func(updateDelay,1);
	var(nextCallWorld,0); //когда будет следующий глобальный вызов
	var(nextCallMobs,0); //когда будет следующий вызов на сущностях
	var(stopAt,0); //отметка по которой onUpdate будет остановлен

	func(constructor)
	{
		objParams();
		setSelf(stopAt,tickTime + randInt(60 * 2,60 * 5));
	};

	func(onUpdate)
	{
		objParams();
		private _t = tickTime;
		
		if (_t >= getSelf(stopAt)) exitwith {
			callSelf(terminateUpdate);
		};

		if (_t >= getSelf(nextCallWorld)) then {
			setSelf(nextCallWorld,_t + randInt(8,11));

			{
				if callFunc(_x,isFireLight) then {
					if getVar(_x,lightIsEnabled) then {
						if prob(60) then {
							trace("some disable")
							callFuncParams(_x,lightSetMode,false);
							private _m = pick["тухнет","затухает"];
							callFuncParams(_x,worldSay,callFunc(_x,getName)+ " "+_m+" от ветра." arg "act");
						};
					};
				};
			} foreach (["ILightible",true] call getAllObjectsInWorldTypeOf);
			
		};

		if (_t >= getSelf(nextCallMobs)) then {
			setSelf(nextCallMobs,_t + randInt(15,30));
			{
				private _items = [_x,"ILightible",true] call getAllItemsInInventory;
				{
					if callFunc(_x,isFireLight) then {
						if getVar(_x,lightIsEnabled) then {
							if prob(50) then {
								callFuncParams(_x,lightSetMode,false);
								private _m = pick["тухнет","затухает"];
								callFuncParams(_x,worldSay,callFunc(_x,getName)+ " "+_m+" от ветра." arg "act");
							};
						};
					};
				} foreach _items;
			} foreach (["Mob",true] call getAllMobsInWorld);
		};
		
	};


endclass

class(GlobalHungerEvent) extends(InfluenceEventAllMaps)
	var(name,"Голод");
	var(desc,"Все резко проголодались");
	getterconst_func(isMultiplay,true);
	getter_func(canPlayOnMobAtStart,true);
	//от текущего голода если больше 5 делим на половину

	func(onMob)
	{
		objParams_1(_usr);
		private _hunger = getVar(_usr,hunger);
		if (_hunger > 5) then {
			callFuncParams(_usr,setHunger,precentage(_hunger,30));
		};
	};

endclass

class(DustSmokeEvent) extends(InfluenceEventAllMaps)
	var(name,"Туман");
	var(desc,"Зловещий туман заполняет пространство");
	var(descRoleplay,"");
	getter_func(isMultiplay,true);
	var(allObjects,[]);
	func(onActivate)
	{
		objParams();
		private _creator = {
			private _o = ["EffectAsStruct",_this] call createStructure;
			callFuncParams(_o,setEffectType,"dust_clouds_10m");
		};

		private _mapUnicalPos = createHashMap;
		private _chunk = null;
		private _strchunk = "";
		private _pos = null;
		{
			_pos = getPosAtl _x;
			_chunk = [_pos,CHUNK_TYPE_STRUCTURE] call noe_posToChunk;
			_strchunk = str _chunk;
			if (!(_strchunk in _mapUnicalPos)) then {
				_mapUnicalPos set [_strchunk,_pos];
			};
		} foreach cm_allInGameMobs;

		{
			_pos = _x;
			_pos call _creator;
			{
				(_pos vectoradd _x vectoradd [0,0,rand(-2,4)]) call _creator;
			} foreach [[10,10,0],[10,-10,0],[-10,10,0],[-10,-10,0]];
		} foreach (values _mapUnicalPos);
	};

endclass

class(DoorsUnlockEvent) extends(InfluenceEventAllMaps)
	var(name,"Открытие замков");
	var(desc,"Больше половины закрытых дверей открываются");
	getter_func(isMultiplay,true);
	func(onActivate)
	{
		objParams();
		{
			//только не электронные двери
			if !isTypeOf(_x,ElectronicDeviceDoor) then {
				if getVar(_x,isLocked) then {
					if prob(65) then {
						callFuncParams(_x,setDoorLock,false arg false);
					};
				};
			};
		} foreach (
			(["DoorStatic",true] call getAllObjectsInWorldTypeOf) + 
			(["DoorDynamic",true] call getAllObjectsInWorldTypeOf)
		);
	};

endclass


class(MoneyLowerEvent) extends(InfluenceEventAllMaps)
	var(name,"Бряки на звяки");
	var(desc,"Все бряки у людей в карманах становятся звяками");
	var(classFrom,"Bryak");
	var(classTo,"Zvak");
	getter_func(canPlayOnMobAtStart,true);
	func(onMob)
	{
		objParams_1(_mob);
		private _loc = null;
		private _slot = 0;
		private _count = 0; //stackCount
		{
			_loc = getVar(_x,loc);
			_slot = getVar(_x,slot);
			_count = getVar(_x,stackCount);
			if equals(_slot,_mob) then {
				delete(_x);
				private _newItem = [getSelf(classTo),_mob,_slot] call createItemInInventory;
				callFuncParams(_newItem,initCount,_count);
			} else {
				if callFunc(_loc,isContainer) then {
					delete(_x);
					private _newItem = [getSelf(classTo),_loc] call createItemInContainer;
					callFuncParams(_newItem,initCount,_count);
				};
			};
		} foreach ([_mob,getSelf(classFrom),false] call getAllItemsInInventory);
	};

endclass

class(MoneyHigherEvent) extends(MoneyLowerEvent)
	var(name,"Звяки на бряки");
	var(desc,"Все звяки у людей в карманах становятся бряками");
	var(classFrom,"Zvak");
	var(classTo,"Bryak");
endclass

class(HumansShuffleEvent) extends(InfluenceEventAllMaps)
	var(name,"Поменяться местами");
	var(desc,"Все люди в сознании меняются местами");

	func(onActivate)
	{
		objParams();
		private _list = [];
		{
			if callFunc(_x,isActive) then {
				_list pushBack _x;
				callFuncParams(_x,changeVisionBlock,+5 arg "unc");
				callFuncParams(_x,Stun,5 arg false arg true);
			};
		} foreach (["Mob",true] call getAllMobsInWorld);
		_list = array_shuffle(_list);
		private _posLis = _list apply {callFunc(_x,getPos)};
		private _first = (_posLis deleteAt 0);
		_posLis pushBack _first;
		{
			private _vObj = callFunc(_x,getBasicLoc);
			[
				_x,
				_posLis select _foreachindex,
				(getdir _vObj)
			] call teleportMobToPoint;
			callFuncAfterParams(_x,changeVisionBlock,4,-5 arg "deunc");
		} foreach _list;
		
	};

endclass


class(FoodToShitEvent) extends(InfluenceEventAllMaps)
	var(name,"Продукты в говно");
	var(desc,"Все пищевые продукты прогнивают (Превращаются в дерьмо).");
	var(weight,0.3);
	func(onActivate)
	{
		objParams();
		private _pos = 0;
		{
			if isTypeOf(_x,Mushroom) then {continue};
			if isTypeOf(_x,Poo) then {continue};

			_pos = callFunc(_x,getModelPosition);
			delete(_x);
			["Poo",_pos,null,true] call createItemInWorld;	
		} foreach (
			//(["IFoodItem",true] call getAllItemsTypeOf)
			(["IFoodItem",true] call getAllObjectsInWorldTypeOf) +
			(["Muka",true] call getAllObjectsInWorldTypeOf)
		);
	};
endclass

class(CrazyMessagesEvent) extends(InfluenceEventAllMaps)
	var(name,"Безумные послания");
	var(desc,"В головы взрослых персонажей наводятся безумные сообщения и мысли. Выглядит как череда различного текста.");
	getter_func(canPlayOnMobAtStart,true);
	var(mobList,[]);
	var(mobNextCall,[]);
	var(stopAt,0);
	func(onMob)
	{
		objParams_1(_mob);
		if !isTypeOf(_mob,Mob) exitwith {};
		if isTypeOf(_mob,GMPreyMobEater) exitwith {};

		if (getVar(_mob,age) >= 30) then {
			getSelf(mobList) pushBack _mob;
			getSelf(mobNextCall) pushback (tickTime + randInt(2,60));
			setSelf(stopAt,tickTime + randInt(60*3,60*6));
		} else {
			private _m = pick["В голове загудело.","Странное ощущение.","Всё стало очень странно.","Мне немного поплохело.","Какое незнакомое чувство...","Что...произошло?!"];
			callFuncParams(_mob,mindSay,_m);
		};
		
	};

	func(getCrazyMessage)
	{
		objParams();
		pick[
			"Нужно покинуть...",
			"ОНИ РЯДОМ!",
			"Он следит за мной?",
			"Кто-то "+(pick["сбоку","сзади"])+"!",
			"В моей голове что-то шевелится...",
			"Почему здесь так темно?",
			"А когда нас накормят?",
			"Я НЕ ТОМНЫЙ!",
			"Кто на меня смотрит?",
			"Они все не те, кеми являются.",
			"Кругом сплошной обман",
			"Всё так...нереально...",
			"Это не по настоящему. Это вранье!",
			"Мельтешата под кожей...",
			"Это сказка... Это сон!",
			"Я нормааааальный!",
			"Я у тебя в голове. Поговори со мной!",
			"Кругом одни ТОМные...",
			"Они все обманщики.",
			"Никто не знает истину.",
			"Мы все играем свои роли...",
			"Прекрати этот парад безумия!",
			"Остановись немедленно!",
			"Хватит!",
			"Стоп. Перестань!",
			"Закончи свои мучения...",
			"К чему все эти старания...",
			"Я за тобой слежу.",
			"Перестань баловаться.",
			"Мы смотрим за тобой.",
			"Давай в сторону отойдём. Есть серьёзный разговор.",
			"Ты нарушаешь наши правила!",
			"ПОТОЛОК ПАДАЕТ!",
			"Ты уже мёртв."
		]
	};

	getter_func(updateDelay,1);

	func(onUpdate)
	{
		objParams();
		_curTime = tickTime;
		_nextcallList = getSelf(mobNextCall);
		{
			_nc = _nextcallList select _foreachIndex;
			if (_curTime >= _nc && callFunc(_x,isActive)) then {
				_nextcallList set [_foreachIndex,_curTime + randInt(20,60)];
				_mes = format["<t size='%1' color='#%2' font='%4'>%3</t>",
					pick["1.2","1.4","1.8","2","2.3"],
					pick["CF0041","CF00BA","E00000","F01F92","753448"],
					callSelf(getCrazyMessage),
					pick["RobotoCondensedLight","RobotoCondensed","Ringbear","PuristaBold","Zeppelin32","KursivC"]
				];
				callFuncParams(_x,mindSay,_mes);
				_v4 = [rand(0.01,0.1),rand(5,10),0.11,7.2];
				callFuncParams(_x,sendInfo,"camshake" arg _v4);

				_rsnd = pick [
					"UNCATEGORIZED\rat_life1",
					"UNCATEGORIZED\rat_life2",
					"UNCATEGORIZED\glass_break"+str randInt(1,3),
					"UNCATEGORIZED\bell_toll",
					"attacks\blademiss"+str randInt(1,4),
					"attacks\stab"+str randInt(1,3)
				];
				callFuncAfterParams(_x,playSoundUI,rand(2,15),_rsnd arg rand(0.5,1.9) arg rand(0.7,1.1));
				
			};
		} foreach getSelf(mobList);

		if (_curTime >= getSelf(stopAt)) exitwith {
			callSelf(terminateUpdate);
		};
	};

endclass

//боль от стульев
class(ChairPainEvent) extends(InfluenceEventAllMaps)
	var(name,"Боль от сидения на стульях");
	var(desc,"Все кто сидят на стульях получают боль.");
	var(weight,0.4);
	func(onActivate)
	{
		objParams();
		{
			[_x,"onSeat",{
				if isNull(getSelf(___chairpainupd)) then {
					private _updater = {
						updateParams();
						{
							callFuncParams(_x,adjustPain,null arg randInt(2,4) arg null arg true);
						} foreach getSelf(seatListOwners);
					};

					setSelf(___chairpainupd,startUpdateParams(_updater,STD_UPDATE_DELAY,this));
				};
				callFuncParams(_usr,mindSay,"Неприятно сидеть на "+callSelf(getName));
			},"end",true] call oop_injectToMethod;

		} foreach ["ItemBaseChair","IChair"];
	};

endclass