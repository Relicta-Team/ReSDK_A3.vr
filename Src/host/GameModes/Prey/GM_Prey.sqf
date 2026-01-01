// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\GameMode.h>

/*
Прорыв кочевников через бомжей к точке
*/

editor_attribute("CodeOnyGamemode")
class(GMPrey) extends(GMBase)

	var(name,"Добыча"); //Название истории
	var(desc,"Опасное путешествие в пещерах.");
	var(descExtended,"Сквозь мрак пещер и истошные вопли чудиш группа кочевников пытается отыскать древннюю реликвию.");

	func(getRelic)
	{
		objParams();
		pick [
			["GMPreyGlassBottle","Бутылка из бара 'Кабак'"],
			["GMPreyWoodenCup","Кружка из которой пил Ливоний"],
			//["GMPreyChairLibrary","Резной стул"],//стул по размеру не влезает скорее всего...
			["GMPreyMeltesh","Мумифицированный мельтешонок"],
			["GMPreyDaggerKnife","Ритуальный кинжал"],
			["GMPreyBryak","Бряк с изображением бибы"],
			["GMPreyBiba","Биба Великого Ромзеса"],
			["GMPreyRottenEgg","Тухлое яйцо"],
			["GMPreyHeadTalking","Говорящая голова"]
		]
	};

	getterconst_func(getReqPlayersMin,3);
	getterconst_func(getReqPlayersMax,20);
	var(duration,60 * 60); //1 hr
	getter_func(isVoteSystemEnabled,false);
	getterconst_func(getMapName,""); //dymaic creation
	getterconst_func(getLobbySoundName,"lobby\Endless_Deep.ogg");
	//getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobbyrats.paa"));


	func(conditionToStart)
	{
		objParams();
		private _eaters = count getVar(("RPreyEaterStandard") call gm_getRoleObject,contenders_1);
		private _allplayers = {getVar(_x,isReady)} count (call cm_getAllClientsInLobby);
		private _hasLeader = count getVar(("RPreyNomadLeader") call gm_getRoleObject,contenders_1) > 0;
		_eaters > 0 && _hasLeader
	};

	func(onFailReasonToStart)
	{
		objParams();
		"Нужны жруны и лидер кочевников.";
	};

	func(getLateRoles)
	{
		[
			"RPreyEaterStrong",
			"RPreyEaterStandard"
		]
	};
	func(getLobbyRoles)
	{
		[
			"RPreyNomadLeader",
			"RPreyNomadHealer",
			"RPreyNomadCaveman",
			//"RPreyNomadFighter",
			"RPreyNomadLighter",
			//"RPreyNomadDragger",
			"RPreyEaterStandard"
		]
	};

	func(checkFinish)
	{
		objParams();
		/*
			Победа жрунов
				- кочевники умерли
				- время кончилось
			Победа кочевников
				- реликвия на базе

		*/
		_pos = callFunc(getSelf(relicObj),getModelPosition);
		_relicInBase = _pos distance [2000,2000,10] <= 10;
		//traceformat("relic pos %1; inbase %2",_pos arg _relicInBase)
		if (_relicInBase && (count (["GMPreyMobEater",[2000.45,2000.46,10.0879],5,true,false] call getGameObjectOnPosition) <= 0)) exitWith {1};
		#ifndef EDITOR
		if (getSelf(aliveNomads) <= 0 && gm_roundDuration > 10) exitWith {-1};
		#endif
		if (gm_roundDuration >= getSelf(duration)) exitWith {-2};
		0
	};

	func(getResultTextOnFinish)
	{
		objParams();
		private _fr = getSelf(finishResult);
		if (_rf == -2) exitWith {"Кочевники не успели заполучить реликвию"};
		if (_rf == 1) exitWith {"Кочевники добыли реликвию"};
		if (_rf == -1) exitWith {"Все кочевники погибли"};
		""
	};

	//база
	//["Mob",[2000.45,2000.46,10.0879],5,true,true] call getMobsOnPosition

	var(aliveNomads,0);
	var(container,nullPtr);
	var(relicObj,nullPtr);
	var(relicProbSpawnpos,[]);//возможные спавны
	var(eaterSpawnPos,vec3(0,0,0));

	func(preSetup)
	{
		objParams();
		// init map
		call cave_preyload;
		
		if isNullReference(getSelf(container)) exitWith {
			errorformat("RELIC CONTAINER NOT CREATED - %1",getSelf(container));
			appExit(APPEXIT_REASON_CRITICAL);
		};
		
		//insert relic inside container
		(callSelf(getRelic)) params ["_class","_name"];
		private _relic = [_class,getSelf(container)] call createItemInContainer;
		if (isNullVar(_relic) || isNullReference(_relic)) then {
			errorformat("RELIC NOT DEFINED ON GM PREY %1",_class arg getSelf(container));
			appExit(APPEXIT_REASON_CRITICAL);
		};
		setSelf(relicObj,_relic);
		setVar(_relic,name,_name);

		//spawn base furniture
		["CampfireBig",[2001.43,1998.25,10.1127],null,false,vec3(0,0,1)] call createStructure;
		["IStruct",[2000-3.5,2000,10],90,vec3(0,0,1),{setSelf(model,"a3\structures_f\households\slum\slum_house03_f.p3d")}] call initStruct;
		["IStruct",[2001,2000-2,10.3],270,vec3(0,0,1),{setSelf(model,"a3\structures_f\households\slum\cargo_addon01_v2_f.p3d")}] call initStruct;
		
		setSelf(eaterSpawnPos,callFunc(getSelf(relicObj),getModelPosition));
	};

endclass

class(GMPreyMobEater) extends(Mob)
	var(name,"Жрун");
	var(__listactions,[]);
	var(voiceType,"eater");
	getter_func(isFailCombat,false);

	getter_func(getRetchSounds,generate_list(1,5,{"monster\eater\scream" + (str _this)})); //подавиться
	getter_func(getPainSounds,generate_list(1,5,{"monster\eater\attack" + (str _this)})); //боль
	getter_func(getMoanSounds,generate_list(1,5,{"monster\eater\idle" + (str _this)})); //слабая боль
	getter_func(getScreamSounds,generate_list(1,5,{"monster\eater\scream" + (str _this)})); //крикушки
	getter_func(getTortureScreamSounds,generate_list(1,5,{"monster\eater\scream" + (str _this)}));

	
	["eater","roar","onEaterRoar"] call ie_actions_regNew;
	["eater","sniff","onEaterSniff"] call ie_actions_regNew;
	["eater","regen","onEaterRegen"] call ie_actions_regNew;
	["eater","legkie","onEaterStamina"] call ie_actions_regNew;
	func(constructor)
	{
		objParams();
		{
			setVar(callFuncParams(this,getPart,_x),slotedWeap,weaponModule(Claws));
		} foreach [BP_INDEX_ARM_R,BP_INDEX_ARM_L];

		callSelfParams(addAction,"Жрун" arg "Рычать" arg "eater_roar");
		callSelfParams(addAction,"Жрун" arg "Принюхаться" arg "eater_sniff");
		//callSelfParams(addAction,"Жрун" arg "Восстановление" arg "eater_regen");
		callSelfParams(addAction,"Жрун" arg "Сгинуть" arg "eater_regen");
		callSelfParams(addAction,"Жрун" arg "Наполнить лёгкие" arg "eater_legkie");
		
		callSelfParams(addPerk,"PerkSeeInDark");
		
		/*vtest = this;
		_c = {
			this = vtest;
			callSelfParams(removeAction,"eater_regen");
			callSelfParams(removeAction,"eater_sniff");
		}; invokeAfterDelay(_c,5);*/
	};
	getter_func(canEnableHumanPostprocessOnConnection,false);
	func(onConnected)
	{
		objParams();
		super();
		callSelfParams(localEffectUpdate,"EaterNightVision");
	};

	func(onEaterStamina)
	{
		objParams();
		callSelfParams(startSelfProgress,"onEaterStamina_ok" arg 5 arg INTERACT_PROGRESS_TYPE_LAZY);
	};
	func(onEaterStamina_ok)
	{
		objParams();
		callSelfParams(addStaminaRegen,50);
	};

	var(_eater_lastscream,0);
	func(onEaterRoar)
	{
		objParams();
		if (tickTime < getSelf(_eater_lastscream)) exitWith {};
		setSelf(_eater_lastscream,tickTime + randInt(10,20));

		callSelfParams(playSound,"monster\eater\scream" + (str randInt(1,5)) arg getRandomPitchInRange(0.8,1.3) arg 30 arg 2.2 arg null arg false);
		private _rmes = pick [
			"рычит",
			"скалится",
			"кричит",
			"вопит",
			"орёт",
			"визжит"
		];
		callSelfParams(meSay,_rmes);
		
		{
			callFuncParams(_x,addCamShake,0.01 arg 2.5 arg 0.02 arg 1.4);
		} foreach callSelfParams(getNearMobs,15 arg false);
	};

	var(_eater_nextAttackSound,0);
	func(syncAttackDelayProcess)
	{
		objParams_4(_type,_attWeapon,_attItem,_overrideRTA);
		super();
		if equals(_type,"melee") then {
			if (tickTime >= getSelf(_eater_nextAttackSound)) then {
				setSelf(_eater_nextAttackSound,tickTime + rand(0.5,4));
				callSelfParams(playSound,"monster\eater\attack" + (str randInt(1,5)) arg getRandomPitchInRange(0.8,1.3) arg 6 arg 2.2 arg null arg false arg 1);
			};
		};
	};

	func(onUpdate)
	{
		updateParams();
		super();
		callSelf(handle_eaterlife);
	};

	var(_eater_nextRoar,0);
	func(handle_eaterlife)
	{
		objParams();
		if (!callSelf(isActive)) exitWith {};
		if (tickTime >= getSelf(_eater_nextRoar)) then {
			setSelf(_eater_nextRoar,tickTime + randInt(20,60 + 30));
			callSelfParams(playSound,"monster\eater\idle" + (str randInt(1,6)) arg getRandomPitchInRange(0.8,1.3) arg 10 arg 2.2 arg null arg !false);
		};
	};

	var(sniffDistance,80);

	func(onEaterSniff)
	{
		objParams();
		callSelfParams(meSay,"принюхивается.");
		private _nat = [];
		private _maxDist = 10000;
		private _lastmob = nullPtr;
		{
			if !isTypeOf(_x,GMPreyMobEater) then {
				if !getVar(_x,isDead) then {
					if (callSelfParams(getDistanceTo,_x) < _maxDist) then {
						_maxDist = callSelfParams(getDistanceTo,_x);
						_lastmob = _x;
					};
				};
			};
		} foreach (["Mob",callSelf(getPos),getSelf(sniffDistance),true,true] call getGameObjectOnPosition);
		
		if !isNullReference(_lastmob) then {
			_dir = callSelfParams(getDirectionTo,_lastmob);
			call {
				if(_dir==DIR_FRONT)exitWith{_dir=pick["впереди","спереди","прямо"]};
				if(_dir==DIR_BACK)exitWith{_dir=pick["позади","сзади","за мной"]};
				if(_dir==DIR_LEFT)exitWith{_dir=pick["слева","слева от меня"]};
				if(_dir==DIR_RIGHT)exitWith{_dir=pick["справа","справа от меня"]};
			};
			private _m = format["Чую кого-то. %1 метров %2 от меня!",round callSelfParams(getDistanceTo,_lastmob),_dir];
			callSelfParams(mindSay,_m);
		} else {
			callSelfParams(mindSay,"Никого не чую...");
		};
		
	};
	getter_func(canRegenPain,super() || getSelf(__eaterPainRegenFlag));
	func(onEaterRegen)
	{
		objParams();
		callSelfParams(startSelfProgress,"onkilledeaterprogress" arg 30 arg INTERACT_PROGRESS_TYPE_LAZY);
		/*setSelf(__eaterPainRegenFlag,true);
		{
			callFuncParams(_y,healPain,9999 arg true);
			callFuncParams(this,removePainLevel,_x arg PAIN_LEVEL_NO);
			
			callFuncParams(_y,regenProcessWoundsNoRoll,this arg WOUND_TYPE_BRUISE);
			callFuncParams(_y,regenProcessWoundsNoRoll,this arg WOUND_TYPE_BLEEDING);
			
		} foreach (getSelf(bodyParts));
		callSelfParams(addStaminaRegen,99999);
		setSelf(__eaterPainRegenFlag,false);*/
	};
	func(onkilledeaterprogress)
	{
		objParams();
		callSelfParams(Die,"noargs");
	};

	func(initAsActor)
	{
		objParams_1(_linked);
		super();
		callSelfParams(addVisualState,"VST_EATER_NIGHTVISION");
	};

	func(getRandomNamePrefix)
	{
		objParams();
		pick [
			"Голодный",
			"Страшный",
			"Жуткий",
			"Свирепый",
			"Опасный",
			"Кровожадный",
			"Дикий",
			"Смертоносный",
			"Угрожающий",
			"Великий",
			"Убийственный",
			"Прекрасный",
			"Главный",
			"Омерзительный",
			"Отвратительный",
			"Угрожающий",
			"Следящий",
			"Кричащий"
		]
	};
	
	func(onThrow)
	{
		objParams_2(_item,_isKicking);
		if (isTypeOf(gm_currentMode,GMPrey) && equals(_item,getVar(gm_currentMode,relicObj))) exitWith {false};
		super();
	};
	
	func(canSetItemOnSlot)
	{
		objParams_2(_item,_slot);
		if (_slot == INV_CLOTH) exitWith {super() && true};
		false
	};

	func(updateVoiceType)
	{
		objParams_1(_vt);
	};
	
endclass


#define overrideCanPickup \
	func(onPickup) \
	{ \
		objParams_1(_usr); \
		super(); \
		if isTypeOf(getVar(_usr,basicRole),RPreyEater) then { \
			callFuncParams(_usr,meSay,"обессиливает перед священной реликвией"); \
			callFuncParams(_usr,addStaminaLoss,10000); \
		}; \
	}; \
	



class(GMPreyHeadTalking) extends(Head)
	overrideCanPickup
	func(constructor)
	{
		objParams();
		callSelfParams(startUpdateMethod,"onUpdate" arg "handleUpdate");
	};

	autoref var(handleUpdate,-1);
	var(lastTalk,0);
	func(onUpdate)
	{
		updateParams();

		if (tickTime >= getSelf(lastTalk)) then {
			setSelf(lastTalk,tickTime + randInt(30,60 * 3));

			_phrases = [
				"Хуй блядь.",
				"Девочки...",
				"Напиши книгу!",
				"Это всё не реально.",
				"Я знаю истину",
				"Кто выключил свет?",
				"Вы - покинутые.",
				"Я четыре года ждал этого момента.",
				"Ты увидишь.",
				"Вы уже проиграли.",
				"Они тебя сожрут.",
				"Ты такой хоро...",
				"Прекращай!",
				"Помогите!",
				"А голову ты не забыл?",
				"Я буду твоей новой головой.",
				"Что такое голова?",
				"Ну как так может быть?",
				"Нас будет больше. Обязательно.",
				"А твоя голова тоже умеет говорить?",
				"Деньги...",
				"Дай запить.",
				"От тебя воняет.",
				"Я ничего не говорил.",
				"Найди смысл!",
				"Скотина!",
				"НРСП не ошибается!",
				"Ненавижу, блядь, серых.",
				"Меня зовут Денис, мне 13 лет. Я люблю какиш.",
				"Хи-хи-хи-хи... Ты чумазёда.",
				"Ничего ты не знаешь.",
				"Это всего-лишь игра.",
				"Я хочу в Грязоямск.",
				"Ладно мужики...",
				"Бякостно всё это."
			];
			_txt = format["Голова %1, '%2'",
				pick["пищит","шуршит","балакает","шепчет","вопит","шлепает губами","говорит","возмущается","приговаривает"],
				pick _phrases
			];
			callSelfParams(worldSay,_txt arg "info" arg 5);
		};

	};

endclass

class(GMPreyGlassBottle) extends(GlassBottle)
	getter_func(canBreakOnDrop,false);
	overrideCanPickup
	/*func(onDrop)
	{
		objParams_1(_usr);
		callSuper(IReagentNDItem,onDrop);
	};*/
endclass

class(GMPreyChairLibrary) extends(ChairLibrary)
	overrideCanPickup
	var(size,ITEM_SIZE_HUGE);
endclass

class(GMPreyMeltesh) extends(Melteshonok)
	overrideCanPickup
	getter_func(canEat,false);
endclass

class(GMPreyBryak) extends(Bryak)
	overrideCanPickup
endclass

class(GMPreyWoodenCup) extends(WoodenCup)
	overrideCanPickup
endclass

class(GMPreyDaggerKnife) extends(DaggerKnife)
	overrideCanPickup
endclass

class(GMPreyBiba) extends(Bun)
	overrideCanPickup
	getter_func(canEat,false);
	var(desc,"");
endclass

class(GMPreyRottenEgg) extends(Egg)
	overrideCanPickup
	getter_func(canEat,false);
endclass

class(GMPreyMap) extends(Paper)
	var(name,"Карта голодных пещер");
	getter_func(canWrite,false);
	getter_func(getMainActionName,"Посмотреть");
	func(onMainAction)
	{
		objParams_1(_usr);
		if isTypeOf(_usr,GMPreyMobEater) exitWith {
			callFuncParams(_usr,mindSay,"Не пойму ничего...");
		};
		callSelfParams(checkMapInfo,_usr);
	};

	func(checkMapInfo)
	{
		objParams_1(_usr);
		private _dir = callFunc(_usr,getBasicLoc) getRelDir callFunc(getVar(gm_currentMode,container),getBasicLoc);
		private _textMove = "прямо";
		call {
			if (_dir > 315 || _dir <= 45) exitWith {_textMove = pick["вперёд","прямо"]};
			if (_dir > 45 && _dir <= 135) exitWith {_textMove = "правее"};
			if (_dir > 135 && _dir <= 225) exitWith {_textMove = "назад"};
			if (_dir > 225 && _dir <= 315) exitWith {_textMove = "левее"};
		};
		private _mes = format[
			"%1 %2",
			pick["Двигаемся","Идём","Нужно пройти","По карте нужно идти"],
			_textMove
		];
		callFuncParams(_usr,mindSay,_mes);
	};
endclass
