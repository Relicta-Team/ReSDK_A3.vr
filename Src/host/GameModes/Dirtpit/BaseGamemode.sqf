#include <..\GameMode.h>

editor_attribute("HiddenClass")
class(GMStationBase) extends(GMBase)
	getterconst_func(isPlayableGamemode,false);
	var(headSecondNames,vec2("","")); //фамилия головы для мужского и женского варианта

	func(preSetup)
	{
		objParams();
	};

	func(postSetup)
	{
		objParams();
	};

	//стандартизированное событие начала раунда
	//!!! Не рекомендуется к использованию
	func(onRoundBegin)
	{
		objParams();
		//init bank money
		private _bank = ["SteelGreenCabinet",[3753.97,3772.06,29.788],4,false] call getGameObjectOnPosition;
		if !isNullReference(_bank) then {

			private _pap = ["Paper",_bank] call createItemInContainer;
			setVar(_pap,name,"Напоминание");


			private _count = randInt(300,1200);

			if ("MoreMoneyInBankAspect" call gm_isAspectSetup) then {
				_count = 3000;
			};

			if ("NoMoneyInBankAspect" call gm_isAspectSetup) exitwith {
				setVar(_pap,name,"Смятая записка");
				setVar(_pap,content,"Тебя развели дуда! Спасибо за эту кучу звяков. Мы богачи а ты - сюсявый бибовед.");
			};

			private _mCnttxt = format["В казне на сегодня %1",[_count,["звяк","звяка","звяков"],true] call toNumeralString];
			setVar(_pap,content,"Для размена бряков на звяки обращаться к торгашу." +sbr+_mCnttxt);

			callFuncParams(_bank,initMoney,_count arg true);
		};

		//start generator
		private _gen = ["PowerGenerator",[3827.37,3728.61,17.0241],4,false] call getGameObjectOnPosition;
		if !isNullReference(_gen) then {
			callFunc(_gen,beginUpdateGenerator);
		};

		if (count cm_allClients >= 30) then {	
			setSelf(duration,60* (60*3));
			setSelf(deadThreshold,35);
		};

		_ladders = ["LadderBase"] call getAllObjectsInWorldTypeOf;
		_sewercover = ["SewercoverBase"] call getAllObjectsInWorldTypeOf;
		if (count _ladders == count _sewercover) then {
			_sewercover = array_shuffle(_sewercover);
			{
				private _curlad = _ladders select _forEachIndex;
				private _cursew = _x;
				
				setVar(_curlad,pointTo,_cursew);
				setVar(_cursew,pointTo,_curlad);
			} foreach _sewercover;
		} else {
			errorformat("Collectors initialize error; Count ladders %1; sewercover %2",count _ladders arg count _sewercover);
		};


		//initialize ideology
		callSelf(processInitIdeology);

		private _head = callFunc("RHead" call gm_getRoleObject,getBasicMobs);
		if (count _head > 0) then {
			[format["Правитель грязноямска - %1",callFuncParams(_head select 0,getNameEx,"кто")],"event"] call cm_sendOOSMessage;
		};
	};
	
	var(possibleIdeologies,[]);
	getterconst_func(ideologySelectionTimeout,t_asMin(3));
	func(processInitIdeology)
	{
		objParams();
		private _ideologies = getAllObjectsTypeOf(GMStationIdeology);
		{
			if !(call typeGetVar(typeGetFromString(_x),canVisible)) then {
				_ideologies set [_foreachIndex,objnull];
			};
		} foreach _ideologies;

		_ideologies = _ideologies - [objnull];

		setSelf(possibleIdeologies,_ideologies);
		callSelfAfter(_onIdeologyTimeout,callSelf(ideologySelectionTimeout));
		
		["Mob","setSleep",{
			objParams_1(_mode);
			
			private _hasIdeology = callFunc(gm_currentMode,isPickedIdeology);
			
			if (!_mode && !_hasIdeology) exitwith {
				if isTypeOf(getSelf(basicRole),RHead) exitwith {
					callFuncParams(gm_currentMode,openPickIdeology,this);
				};
				callSelfParams(localSay,"<t size='1.7'>Время ещё не пришло. Наш правитель ещё не определился</t>" arg "error");
			};
			
		},"begin",true] call oop_injectToMethod;
	};

	func(openPickIdeology)
	{
		objParams_1(_mob);
		private _handler = {
			callFuncParams(gm_currentMode,pickIdeology,_value);
			callSelf(CloseMessageBox);

			if callFunc(this,isSleep) then {
				callFuncParams(this,setSleep,false);
			};
		};
		private _dat = ["Выберите идеологию:"] + (getVar(gm_currentMode,possibleIdeologies) apply {
			getFieldBaseValue(_x,"name") + "|" + _x
		});
		_dat pushBack "Случайно|random__ideology";
		callFuncParams(_mob,ShowMessageBox,"Listbox" arg _dat arg _handler);
	};

	getter_func(isPickedIdeology,!isNullReference(getSelf(ideology)));

	func(_onIdeologyTimeout)
	{
		objParams();
		
		if callSelf(isPickedIdeology) exitwith {};

		private _headRole = "RHead" call gm_getRoleObject;
		{
			callFuncParams(_x,localSay,"Время вышло. Идеология будет выбрана автоматически." arg "system");
		} foreach callFunc(_headRole,getBasicMobs);

		callSelfParams(pickIdeology,"");
	};

	var(ideology,nullPtr);

	func(pickIdeology)
	{
		objParams_1(_selected);
		private _idObject = nullPtr;
		{
			if (_x == _selected) exitwith {
				_idObject = instantiate(_selected);
			};
		} foreach getSelf(possibleIdeologies);

		if isNullReference(_idObject) then {
			_idObject = instantiate(pick getSelf(possibleIdeologies));
		};

		setSelf(ideology,_idObject);

		callFunc(_idObject,onStarted);
		{
			callFuncParams(_idObject,onApplyToMob,_x arg true);
		} foreach (["BasicMob",true] call getAllMobsInWorld);
	};

	func(printRoundStatistic)
	{
		objParams();
		super();
		private _ideology = getSelf(ideology);
		if isNullReference(_ideology) exitwith {};
		private _t = format["Идеология: %1%2%3",getVar(_ideology,name),sbr,getVar(_ideology,desc)];
		[_t,"system"] call cm_sendOOSMessage;
	};

endclass


class(GMStationIdeology) extends(IGamemodeSpecificClass)
	var(name,"Режим правления");
	var(desc,"");
	var(descExtended,"Без описания");

	//событие идеологии применяется к стартовавшим с начала
	func(onApplyToMob)
	{
		objParams_2(_mob,_isInit);
		if (_isInit) then {
			callFuncParams(_mob,addUnsleepInfo,"Описание идеологии:" + sbr + getSelf(descExtended));
		};
		private _ideology = format["<t size='1.3'>Идеология Грязноямска: <t color='#CD0074'>%1</t></t>",getSelf(name)];
		callFuncParams(_mob,addFirstJoinMessage,_ideology);
	};

	//событие, вызываемое при старте идеологии
	func(onStarted)
	{
		objParams();

		//[format["%1",getVar(_idObject,name)],"event"] call cm_sendOOSMessage;
	};

	func(onEndgame)
	{
		objParams();
	};

	//константная функция
	func(canVisible)
	{
		true
	};

endclass

class(GMStationIdeologyKingdom) extends(GMStationIdeology)
	var(name,"Царство Подземное");
	var(desc,"Голова - царь Грязноямска. Жители города его верные подданные.");

	func(onStarted)
	{
		objParams();

		private _desc = "Голова - коронованный царь Грязноямска и принимает указы, которым его верные подданные бесприкословно следуют под страхом смерти. "
		+ "В Грязноямске нет простых жителей или хвостов - все они либо порабощены, либо уничтожены. Работники различных сфер являются бедными и бесправными крестьянами. "
		+ "Огнестрельное оружие не в почете: городская стража вооружена мечами и по первому указу отрубит головы всем ослушавшимся. "
		+ "В Расход уходит Голова, его охрана и люди, которых он захочет взять с собой.";
		setSelf(descExtended,_desc);

		private _listDel = (["IRangedWeapon",true] call getAllItemsTypeOf)
			+ (["IAmmoBase",true] call getAllItemsTypeOf)
			+ (["IMagazineBase",true] call getAllItemsTypeOf)
			+ (["AmmoBoxBase",true] call getAllItemsTypeOf);

		{
			delete(_x);
		} foreach _listDel;
	};

	func(onApplyToMob)
	{
		objParams_2(_mob,_isInit);
		super();

		private _baseRole = getVar(_mob,basicRole);
		private _class = callFunc(_baseRole,getClassName);

		if (_class != "RMerchant") then {
			//у всех должно быть денег всего-ничего кроме торгаша
			{
				if (getVar(_x,stackCount) >= 2) then {
					callFuncParams(_x,setStackCount,randInt(1,3));
				};
			} foreach ([_mob,"Zvak",true] call getAllItemsInInventory);
		};

		if (_class == "RHead") exitwith {
			["Crown1",_mob,INV_HEAD] call createItemInInventory;
			["WoolCoat",_mob,INV_BACK] call createItemInInventory;
			private _cloth = callFuncParams(_mob,getItemInSlot,INV_CLOTH);
			if !isNullReference(_cloth) then {
				{
					callFuncParams(_x,setUniformClass,"mantel_reich");
					setVar(_x,name,"Царские одеяния");
				} foreach ([callFunc(_cloth,getClassName),false] call getAllItemsTypeOf);
			};
			
		};
		if (_class == "RCaretaker" || _class == "RVeteran") exitwith {
			{delete(_x)} foreach ([_mob,"IRangedWeapon",true] call getAllItemsInInventory);

			["ShortSword",_mob,INV_BELT] call createItemInInventory;
		};
		if (_class == "RStreak") exitwith {
			["CaveAxe",_mob,INV_BELT] call createItemInInventory;
		};
	};


endclass


class(GMStationIdeologyFugu) extends(GMStationIdeology)
	var(name,"Путь Фугу");
	var(desc,"Церковь во главе всего. Все полностью следуют религиознным укладам.");

	func(onStarted)
	{
		objParams();

		private _desc = "Голова принимает решения в соответствии с устоями церкви Фугу и Аббатом. Местное ополчение является инквизицией, уничтожающей всех иновверцев. Количество огнестрельного оружия и боеприпасов снижена."
			+ " Смотритель является инквизитором и подчиняется приказам как Головы, так и Аббата. В Расход уходит вся церковь, инквизиция и сам Голова.";
		setSelf(descExtended,_desc);

		private _listDel = (["IRangedWeapon",true] call getAllItemsTypeOf)
			+ (["IAmmoBase",true] call getAllItemsTypeOf)
			+ (["IMagazineBase",true] call getAllItemsTypeOf)
			+ (["AmmoBoxBase",true] call getAllItemsTypeOf);

		{
			if prob(30) then {
				delete(_x);
			};
		} foreach _listDel;
	};

	func(canVisible)
	{
		private _abbatRole = "RAbbat" call gm_getRoleObject;
		count callFunc(_abbatRole,getBasicMobs) > 0
		#ifdef EDITOR
		|| true
		#endif
	};

	func(onApplyToMob)
	{
		objParams_2(_mob,_isInit);
		super();

		private _baseRole = getVar(_mob,basicRole);
		private _class = callFunc(_baseRole,getClassName);

		if (_class == "RHead") exitwith {
			private _scepetr = ["Scepter",_mob] call createItemInInventory;
			setVar(_scepetr,name,"Скипетр СТРАХА");
			setVar(_scepetr,energy,10);
			["Scepter","canUseInteractToMethod",{
				objParams();
				!isNull(getSelf(energy))
			},"replace",false] call oop_injectToMethod;

			["Scepter","interactTo",{
				objParams_2(_target,_usr);
				if !isNull(getSelf(energy)) exitwith {
					if (getSelf(energy) <= 0) exitwith {
						callFuncParams(_usr,localSay,"Мало страха..." arg "error");
					};
					callFuncParams(getVar(_target,reagents),addReagent,"Tamidin" arg randInt(3,8));
					private _m = ["одаривает","благословляет","наполняет","преисполняет"];
					callFuncParams(_usr,meSay," "+pick _m+" исцеляющим страхом " + callFuncParams(_target,getNameEx,"вин"));
					callFuncParams(_usr,playSound,"effects\bell" arg getRandomPitchInRange(0.6,0.9));
					modSelf(energy,-1);
					private _post = {
						if isNullReference(_this) exitwith {};
						modVar(_this,energy,+1);
					};
					invokeAfterDelayParams(_post,t_asMin(randInt(2,5)) + randInt(10,40),this);
				};
			},"begin",false] call oop_injectToMethod;

			["Scepter","getDesc",{
				objParams();
				if !isNull(getSelf(energy)) exitwith {
					private _en = getSelf(energy);
					if (_en <= 0) exitwith {
						"Камень на конце почернел."
					};
					[
						"Камень на конце слабо пульсирует розовым цветом.",
						"Камень на конце мерцает красным цветом.",
						"Камень на конце ярко горит."
					] select (linearConversion [1,10,_en,1,3,true]);
				};
			},"begin",false] call oop_injectToMethod;

			["HoodAbbat",_mob,INV_HEAD] call createItemInInventory;
			private _cloth = callFuncParams(_mob,getItemInSlot,INV_CLOTH);
			if !isNullReference(_cloth) then {
				{
					callFuncParams(_x,setUniformClass,"U_TIOW_Priest_DarkGrey");
					setVar(_x,name,"Головинские одеяния церкви Фугу");
				} foreach ([callFunc(_cloth,getClassName),false] call getAllItemsTypeOf);
			};
			
		};
		if (_class == "RCaretaker" || _class == "RVeteran") exitwith {
			{delete(_x)} foreach ([_mob,"IRangedWeapon",true] call getAllItemsInInventory);

			["TwoHandedSword",_mob,INV_BACK] call createItemInInventory;
				
			private _headItm = callFuncParams(_mob,getItemInSlot,INV_HEAD);
			if isNullReference(_headItm) then {
				_headItm = ["HoodAbbat",_mob,INV_HEAD] call createItemInInventory;
				callFuncParams(_hood,setUniformClass,"TIOW_Cultist_Hood_green");
			};
			callFuncParams(_headItm,setUniformClass,"TIOW_Cultist_Hood_green");
		};
		
	};
endclass

class(GMStationIdeologyDictatorship) extends(GMStationIdeology)
	var(name,"Республика Железной Руки");
	var(desc,"Военная диктатура");

	func(onStarted)
	{
		objParams();

		private _desc = "Голова - диктатор и верховный главнокомандующий. Весь город держится им в железной руке при помощи городского ополчения. "
		+ "Расстрелы и пропаганда здесь - обычное дело. У каждого находящегося в городе при себе обязательно должны быть документы. В Расход уходит только командование.";
		setSelf(descExtended,_desc);

		private _listDel = (["Sword",true] call getAllItemsTypeOf)
			+ (["AxeBase",true] call getAllItemsTypeOf);

		{
			delete(_x);
		} foreach _listDel;
	};

	var(id_docs,0);
	var(randNum,randInt(1,9999));

	//IdentityDocs makeRegList
	func(onApplyToMob)
	{
		objParams_2(_mob,_isInit);
		super();

		modSelf(id_docs, + 1);

		private _docs = ["IdentityDocs",_mob] call createItemInInventory;
		private _id = format["%1-%2",getSelf(randNum),getSelf(id_docs)];
		callFuncParams(_docs,makeRegList,_mob arg _id);

		private _baseRole = getVar(_mob,basicRole);
		private _class = callFunc(_baseRole,getClassName);

		if (_class == "RHead") exitwith {
			private _cloth = callFuncParams(_mob,getItemInSlot,INV_CLOTH);
			if !isNullReference(_cloth) then {
				{
					callFuncParams(_x,setUniformClass,"sovietisher");
					setVar(_x,name,"Одежда главнокомандующего");
				} foreach ([callFunc(_cloth,getClassName),false] call getAllItemsTypeOf);
			};
			["HatArmyCap",_mob,INV_HEAD] call createItemInInventory;
		};
		if (_class == "RCaretaker") exitwith {
			private _cap = ["HatBeret",_mob,INV_HEAD] call createItemInInventory;
			callFuncParams(_cap,setUniformClass,"H_ParadeDressCap_01_AAF_F");

			["HatBeret",_mob,INV_HEAD] call createItemInInventory;
			private _weapon = ["RifleFinisherSmall",_mob] call createItemInInventory;
			callFuncParams(_weapon,createMagazine,"MagazineFinisherLoaded");
			["MagazineFinisherLoaded",["ArmorLite",_mob,INV_ARMOR] call createItemInInventory] call createItemInContainer;
		};
		if (_class == "RVeteran"|| _class == "RStreak") exitwith {
			if (_class == "RVeteran") then {
				["MagazineFinisherLoaded",["ArmorLite",_mob,INV_ARMOR] call createItemInInventory] call createItemInContainer;
			};
			["HatBeret",_mob,INV_HEAD] call createItemInInventory;
			private _weapon = ["RifleFinisher",_mob] call createItemInInventory;
			callFuncParams(_weapon,createMagazine,"MagazineFinisherLoaded");
		};
	};
endclass

class(GMStationIdeologyCouncilOfFive) extends(GMStationIdeology)
	var(name,"Совет Пяти");
	var(desc,"Социализм и демократия");

	var(additionalAccess,[]);

	getter_func(roles,["RHead" arg "RCaretaker" arg "RBarmen" arg "RMedHealer" arg "RBrigadir"]);

	func(onStarted)
	{
		objParams();

		private _desc = "Решения по любым вопросам принимаются коллективно группой людей. "
		+ "В совет входят 5 человек: Голова, Смотритель, Бригадир, Лекарь и Барник. Голова - принимает основные решения по управлению городом. Смотритель - отвечает за безопасность жителей."
		+" Барник - отвечает за пищевые припасы и управляет фермой. Лекарь - отвечает за здравоохранение и заведует складом препаратов."
		+" Бригадир - отвечает за энергообеспечение. Каждый член совета имеет ключ к залу переговоров.";
		setSelf(descExtended,_desc);

		private _keyAccess = ["sobranie","headpre"];
		setSelf(additionalAccess,_keyAccess);
	};

	func(canVisible)
	{
		#ifdef EDITOR
		true
		#else

		private _existsAll = true;
		{
			private _role = _x call gm_getRoleObject;
			if ((count callFunc(_role,getBasicMobs)) == 0) exitwith {
				_existsAll = false;
			};
		} foreach callSelf(roles);
		
		_existsAll

		#endif
	};

	func(onApplyToMob)
	{
		objParams_2(_mob,_isInit);
		super();

		private _baseRole = getVar(_mob,basicRole);
		private _class = callFunc(_baseRole,getClassName);
		private _roles = callSelf(roles);
		
		if (_class in _roles) then {
			private _key = ["Key",_mob] call createItemInInventory;
			setVar(_key,name,"Ключ Совета");
			{
				getVar(_key,keyOwner) pushBack _x;
			} foreach getSelf(additionalAccess);
		};
	};
endclass