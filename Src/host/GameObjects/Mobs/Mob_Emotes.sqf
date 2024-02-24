// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

region(Declaration of verbs methods)
	getter_func(getScreamSounds,["mob\fear_scream1" arg "mob\fear_scream2"]);
	getter_func(getTortureScreamSounds,["mob\male_torture_scream1" arg "mob\male_torture_scream2" arg "mob\male_torture_scream3" arg "mob\male_torture_scream4"]);

	func(onActEmote)
	{
		objParams();

		"emt" call ie_action_setPrefix;
		//неактивный не может действовать
		if !callSelf(isActive) exitWith {};

		if (["blink"] call ie_action_check) exitWith {
			callSelfParams(meSay,"моргает.");
			callSelfParams(setCloseEyes,true);
			callSelfAfterParams(setCloseEyes,rand(0.2,0.3),false);
			callSelfAfterParams(setCloseEyes,rand(0.35,0.4),true);
			callSelfAfterParams(setCloseEyes,rand(0.45,0.5),false);
		};
		if (["bow"] call ie_action_check) exitWith {
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			private _text = ifcheck(callSelf(isMale),"поклонился","поклонилась");
			if isNullReference(_obj) exitWith {
				callSelfParams(meSay,_text + ".");
			};
			private _name = if callFunc(_obj,isMob) then {callFuncParams(_obj,getNameEx,"кому")} else {callFunc(_obj,getName)};
			callSelfParams(meSay,_text + " " + _name+".");
		};
		if (["salute"] call ie_action_check) exitWith {
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			private _text = "машет";
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			if isNullReference(_obj) exitWith {
				callSelfParams(meSay,_text + "рукой.");
			};
			_text = pick[["приветствует","вин"],["машет рукой","кому"],["помахивает рукой","кому"]];
			private _name = if callFunc(_obj,isMob) then {
				callFuncParams(_obj,getNameEx,_text select 1)
			} else {
				callFunc(_obj,getName)
			};
			callSelfParams(meSay,(_text select 0) + " " + _name+".");
		};
		if (["clap"] call ie_action_check) exitWith {
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			callSelfParams(meSay,"хлопает.");
			callSelfParams(playEmoteSound,"clap");
		};
		if (["eyebrow"] call ie_action_check) exitWith {
			callSelfParams(meSay,ifcheck(callSelf(isMale),"приподнял","приподняла")+" бровь.");
		};
		if (["blush"] call ie_action_check) exitWith {
			callSelfParams(meSay,pick["краснеет."]);
		};
		if (["frown"] call ie_action_check) exitWith {
			callSelfParams(meSay,pick["хмурится." arg ifcheck(callSelf(isMale),"нахмурился.","нахмурилась.")]);
		};
		if (["nod"] call ie_action_check) exitWith {
			callSelfParams(meSay,pick["кивает."]);
			//изучение скиллов
		};
 		if (["cough"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"cough");
			callSelfParams(meSay,"кашляет.");
		};
		if (["gasp"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"gasp");
			callSelfParams(meSay,"задыхается.");
		};
		if (["1shotbreath"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"1shotbreath");
			callSelfParams(meSay,"издаёт тихий звук.");
		};
		if (["coughwounded"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"coughwounded");
			callSelfParams(meSay,"кашляет кровью.");
		};
		if (["giggle"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"giggle");
			callSelfParams(meSay,pick["посмеивается." arg "хихикает." arg "усмехается."]);
		};
		if (["glare"] call ie_action_check) exitWith {
			callSelfParams(meSay,"пристально смотрит.");
			//подробная информация о предмете
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			if isNullReference(_obj) exitWith {};
			callSelfParams(examine,_obj);
		};
		if (["look"] call ie_action_check) exitWith {
			callSelfParams(meSay,"смотрит.");
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			if isNullReference(_obj) exitWith {};
			callSelfParams(examine,_obj);
		};
		if (["point"] call ie_action_check) exitWith {
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			if isNullReference(_obj) exitWith {
				callSelfParams(meSay,"показывает вдаль.");
			};
			private _text = pick["показывает на","указывает на"];
			private _name = if callFunc(_obj,isMob) then {
				callFuncParams(_obj,getNameEx,"вин")
			} else {
				lowerize(callFunc(_obj,getName))
			};
			callSelfParams(meSay,_text + " " + _name + ".");
			callSelfParams(applyPointVisualEffects,_obj arg callSelf(getLastInteractEndPos) arg callSelf(getLastInteractNormal));
		};
		if (["hug"] call ie_action_check) exitWith {
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			if isNullReference(_obj) exitWith {};
			if (callSelf(getLastInteractDistance) <= 1.6) then {
				if callFunc(_obj,isMob) then {
					callSelfParams(meSay,"обнимает " + callFuncParams(_obj,getNameEx,"вин"));
				};
			};
		};
		if (["handshake"] call ie_action_check) exitWith {
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			if isNullReference(_obj) exitWith {};
			if !callFunc(_obj,isMob) exitWith {};
			if equals(_obj,this) exitWith {}; //самопожатие...
			if (callSelf(getLastInteractDistance) > 1.9) exitWith {
				callSelfParams(localSay,"Слишком далеко." arg "error");
			};
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			/*
				Алгоритм работы:
					время много прошло с последнего действия
						я протягиваю руку цели
							биндим цель и время пожатия
						он хочет пожать в ответ
							если его цель я то жмем в ответ
			*/
			if (
				equals(getVar(_obj,lastHandshakeTarget),this) &&
				getVar(_obj,lastHandshakeTime)+5 >= tickTime
			) then {
				//reset vars
				setSelf(lastHandshakeTarget,nullPtr);
				setSelf(lastHandshakeTime,0);
				setVar(_obj,lastHandshakeTarget,nullPtr);
				setVar(_obj,lastHandshakeTime,0);

				private _myHand = callSelfParams(getActiveHandPart,false);
				private _himHand = callFuncParams(_obj,getActiveHandPart,false);

				if isNullReference(_himHand) exitwith {
					callFuncParams(_obj,localSay,"Нечем это сделать" arg "error");
				};
				callFuncParams(_himHand,updateGermsAt,_myHand);

				callFuncParams(_obj,meSay,"пожимает руку " + callFuncParams(this,getNameEx,"кому")+".");
				//TODO known system process
			} else {
				setSelf(lastHandshakeTarget,_obj);
				setSelf(lastHandshakeTime,tickTime);
				callSelfParams(meSay,"протягивает руку " + callFuncParams(_obj,getNameEx,"кому")+".");

				//отладочная ответка пожатия руки
				//! игрок должен стоят передь целью
				#ifdef EDITOR
					if isNullVar(__EDITOR_DEBUG_FLAG_HANDSHAKE) exitwith {
						private __EDITOR_DEBUG_FLAG_HANDSHAKE = true;
						[_obj,"emt_handshake"] call ie_action_call;
					};

				#endif
			};
		};
		if (["slap"] call ie_action_check) exitWith {
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			callSelf(generateLastInteractOnServer);
			private _obj = callSelf(getLastInteractTarget);
			private _ctz = getSelf(curTargZone);

			private _deleg_selfslap = {
				_zname = "лицу";
				call {
					if (_ctz in TARGET_ZONE_LIST_HEAD) exitWith {_zname = "щеке"};
					if (_ctz == TARGET_ZONE_GROIN) exitWith {_zname = "заднице"};
				};
				callSelfParams(meSay,"шлепает себя по "+_zname+".");
				callSelfParams(playEmoteSound,"slap");
			};

			if isNullReference(_obj) exitWith {
				call _deleg_selfslap;
			};
			if (callSelf(getLastInteractDistance) <= 1.6) then {
				if callFunc(_obj,isMob) then {
					if callFuncParams(_obj,hasPart,[_ctz] call gurps_convertTargetZoneToBodyPart) then {
						call {
							if (_ctz == TARGET_ZONE_GROIN && {
								callSelfParams(getDirTo,_obj)==DIR_BACK ||
								callFunc(_obj,getStance) == STANCE_DOWN
							}) exitWith {
								callSelfParams(meSay,"шлепает "+callFuncParams(_obj,getNameEx,"вин")+" по заднице.");
							};

							callSelfParams(meSay,"даёт пощёчину "+callFuncParams(_obj,getNameEx,"кому")+".");

						};
						callSelfParams(playEmoteSound,"slap");
					} else {
						callSelfParams(localSay,"Цель не имеет такой части тела." arg "error");
					};
				} else {
					call _deleg_selfslap;
				};
			} else {
				call _deleg_selfslap;
			};
		};
		if (["grin"] call ie_action_check) exitWith {
			callSelfParams(meSay,"скалится.");
		};
		if (["krak"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"krak");
			callSelfParams(meSay,"похрустывает пальцами.");
		};
		if (["whistle"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"whistle");
			callSelfParams(meSay,"свистит.");
		};
		if (["finger"] call ie_action_check) exitWith {
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			callSelfParams(playEmoteSound,"finger");
			callSelfParams(meSay,"щелкает пальцами.");
		};
		if (["cry"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"cry");
			callSelfParams(meSay,"плачет.");
		};
		if (["sigh"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"sigh");
			callSelfParams(meSay,"вздыхает.");
		};
		if (["laugh"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"laugh");
			callSelfParams(meSay,"смеется.");
		};
		if (["scream"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"scream");
			private _m = pick["испуганно кричит","кричит в ужасе"];
			callSelfParams(meSay,_m+".");
		};
		if (["torturescream"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"torturescream");
			private _m = pick["истошно вопит","дико орёт","вопит"];
			callSelfParams(meSay,_m+".");
		};
		if (["clearthroat"] call ie_action_check) exitWith {
			callSelfParams(playEmoteSound,"clearthroat");
			callSelfParams(meSay,"прочищает горло.");
		};
		if (["mumble"] call ie_action_check) exitWith {
			callSelfParams(meSay,"бормочет.");
		};
		if (["moan"] call ie_action_check) exitWith {
			callSelfParams(meSay,"стонет.");
		};
		if (["smile"] call ie_action_check) exitWith {
			callSelfParams(meSay,"улыбается.");
		};
		if (["shiver"] call ie_action_check) exitWith {
			callSelfParams(meSay,"дрожит.");
		};
		if (["pale"] call ie_action_check) exitWith {
			callSelfParams(meSay,"на секунду бледнеет.");
		};
		if (["tremble"] call ie_action_check) exitWith {
			callSelfParams(meSay,"дрожит от страха.");
		};
		if (["sneeze"] call ie_action_check) exitWith {
			callSelfParams(meSay,"чихает.");
			callSelfParams(playEmoteSound,"sneeze");
		};
		if (["sniff"] call ie_action_check) exitWith {
			callSelfParams(meSay,"сопит.");
		};
		if (["snore"] call ie_action_check) exitWith {
			callSelfParams(meSay,"храпит.");
			callSelfParams(playEmoteSound,"snore");
		};
		if (["whimper"] call ie_action_check) exitWith {
			callSelfParams(meSay,"хнычет.");
			callSelfParams(playEmoteSound,"whimper");
		};
		if (["hem"] call ie_action_check) exitWith {
			callSelfParams(meSay,"хмыкает.");
			callSelfParams(playEmoteSound,"hem");
		};
		if (["wink"] call ie_action_check) exitWith {
			callSelfParams(meSay,"подмигивает.");
		};
		if (["licklips"] call ie_action_check) exitWith {
			callSelfParams(meSay,"облизывается.");
		};
		if (["yawn"] call ie_action_check) exitWith {
			callSelfParams(meSay,"зевает.");
			callSelfParams(playEmoteSound,"yawn");
		};
		if (["stop"] call ie_action_check) exitWith {
			callSelfParams(meSay,"жестом просит остановиться!");
			callSelfParams(playEmoteSound,"stop");
		};
		if (["burp"] call ie_action_check) exitWith {
			callSelfParams(meSay,"рыгает.");
			callSelfParams(playEmoteSound,"burp");
		};
		if (["fallscream"] call ie_action_check) exitWith {
			callSelfParams(meSay,"летит и орет!");
			callSelfParams(playEmoteSound,"fallscream");
		};
		if (["agonyscream"] call ie_action_check) exitWith {
			callSelfParams(meSay,"кричит от боли!");
			callSelfParams(playEmoteSound,"agonyscream");
		};
		if (["agonypain"] call ie_action_check) exitWith {
			callSelfParams(meSay,"кричит от боли.");
			callSelfParams(playEmoteSound,"agonypain");
		};
		if (["moandeath"] call ie_action_check) exitWith {
			callSelfParams(meSay,"стонет от боли.");
			callSelfParams(playEmoteSound,"moandeath");
		};
		if (["agonymoan"] call ie_action_check) exitWith {
			callSelfParams(meSay,"стонет от боли.");
			callSelfParams(playEmoteSound,"agonymoan");
		};
		if (["agonydeath"] call ie_action_check) exitWith {
			callSelfParams(meSay,"кричит от боли.");
			callSelfParams(playEmoteSound,"agonydeath");
		};
		//пошло добро...
		if (["fart"] call ie_action_check) exitWith {
			if (tickTime > getSelf(lastFartTime)) then {
				if (getSelf(hunger)>=100) then {
					setSelf(lastFartTime,tickTime + randInt(2,6));
					callSelfParams(meSay,"пердит.");
					callSelfParams(playEmoteSound,"fart");
				}
				else {
					callSelfParams(localSay,pick["НЕ ВЫХОДИТ!" arg "Не получается." arg "В животике не бродит." arg ""] arg "error")
				}
			};
		};
		if (["pee"] call ie_action_check) exitWith {
			callSelfParams(localSay,"Пока не хочется." arg "mind");
			//handle_piss
		};
		if (["poo"] call ie_action_check) exitWith {
			callSelfParams(localSay,"Пока не хочется." arg "mind");
			//handle_shit
		};
		if (["vomit"] call ie_action_check) exitWith {
			callSelfParams(localSay,"Я пока не собираюсь расставаться со своей едой!" arg "mind");
			//callSelfParams(playEmoteSound,"vomit");
			//callSelfParams(playEmoteSound,"gasp");
		};
		if (["masturbate"] call ie_action_check) exitWith {
			if callSelf(isChild) exitWith {};
			if !callSelf(hasActiveHand) exitWith {callSelfParams(localSay,"Руки нет." arg "error");};
			if !callSelfParams(isEmptySlot,INV_CLOTH) exitWith {
				private _item = callSelfParams(getItemInSlot,INV_CLOTH);
				callSelfParams(localSay,"Надо бы сначала снять " + lowerize(callFuncParams(_item,getNameFor,this))+"." arg "error");
			};
			callSelfParams(addStaminaLoss,3);
			if callSelf(isMale) then {
				private _m = pick ["мутюлит бибу.","заряжает грибыша.","бибует руку.","дёргает корешок.","душит мельтешонка."];
				callSelfParams(meSay,_m);
			} else {
				private _m = pick ["мутюлит сюсю.","натирает мясную пещерку.","теребит камушек.","приятничает себя.","сюсюкает."];
				callSelfParams(meSay,_m);
			};
			callSelfParams(playEmoteSound,"masturbate");
		};
	};

	func(playEmoteSound)
	{
		objParams_1(_type);
		if (_type == "scream") exitWith {
			if callSelf(isChild) then {
				callSelfParams(playSound,"mob\fear_child" arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound,pick callSelf(getScreamSounds) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "torturescream") exitWith {
			if callSelf(isChild) then {
				callSelfParams(playSound,"mob\kid_torture_scream"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound,pick callSelf(getTortureScreamSounds) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "stop") exitWith {
			callSelfParams(playSound,"emotes\stop" arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "burp") exitWith {
			callSelfParams(playSound,"emotes\burp" arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "vomit") exitWith {
			callSelfParams(playSound, "mob\vomit" arg getRandomPitch);
		};
		if (_type == "masturbate") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "f2\act_pen_hj\hj"+str randInt(1,9) arg getRandomPitch);
			} else {
				callSelfParams(playSound, "f2\act_vag_tch\th"+str randInt(1,10) arg getRandomPitch);
			};
		};
		if (_type == "clearthroat") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound,"emotes\throatclear_male" arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound,"emotes\throatclear_female" arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "agonyscream") exitWith {
			if (callSelf(isMale) && !callSelf(isChild)) exitWith {
				callSelfParams(playSound, "agony\agony_male"+str randInt(1,13) arg getRandomPitchInRange(0.85,1.2));
			};
			if callSelf(isChild) then {
				callSelfParams(playSound, "emotes\child_pain"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "agony\woman_pain"+str randInt(1,4) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "agonydeath") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "agony\death_male"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "agony\death_female"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "agonymoan") exitWith {
			if callSelf(isChild) exitWith {
				callSelfParams(playSound, "agony\child_moan1" arg getRandomPitchInRange(0.85,1.2));
			};
			if callSelf(isMale) then {
				callSelfParams(playSound, "agony\male_moan"+str randInt(1,5) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "agony\female_moan_wounded"+str randInt(1,8) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "cry") exitWith {
			if callSelf(isChild) exitWith {
				callSelfParams(playSound, "emotes\child_cry" arg getRandomPitchInRange(0.85,1.2));
			};
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\cry_man0"+str randInt(1,4) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\cry_woman0"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "agonypain") exitWith {
			if (callSelf(isMale) && !callSelf(isChild)) exitWith {
				callSelfParams(playSound, "agony\man_pain"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			};
			if callSelf(isChild) then {
				callSelfParams(playSound, "emotes\child_pain"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "agony\woman_pain"+str randInt(1,4) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "moandeath") exitWith {
			callSelfParams(playSound, "agony\painb"+str randInt(1,8) arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "fallscream") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "agony\falling_down_scream"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "agony\fem_falling" arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "laugh") exitWith {
			if callSelf(isChild) then {
				if callSelf(isMale) then {
					callSelfParams(playSound, "emotes\laugh\boy_laugh"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
				} else {
					callSelfParams(playSound, "emotes\laugh\girl_laugh1" arg getRandomPitchInRange(0.85,1.2));
				};
			}  else {
				if (callSelf(getIQ) <= 5) exitWith {
					callSelfParams(playSound, "emotes\laugh\smeshinka"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
				};
				private _vt = getSelf(voiceTypeTembre);
				if callSelf(isMale) then {
					if (_vt == "cultist") exitWith {
						callSelfParams(playSound, "emotes\laugh\cultiste_laugh"+str randInt(1,6) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "revisor") exitWith {
						callSelfParams(playSound, "emotes\laugh\revisor"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "tiamat") exitWith {
						callSelfParams(playSound, "emotes\laugh\stronglaugh"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "harris") exitWith {
						callSelfParams(playSound, "emotes\laugh\harris_laugh_"+str randInt(1,11) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "cynical") exitWith {
						callSelfParams(playSound, "emotes\laugh\cynical_laugh"+str randInt(1,6) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "sketchy") exitWith {
						callSelfParams(playSound, "emotes\laugh\01laugh"+str randInt(1,7) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "noble") exitWith {
						callSelfParams(playSound, "emotes\laugh\leg_laugh"+str randInt(1,9) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "hobo") exitWith {
						callSelfParams(playSound, "emotes\laugh\bum_laugh"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
					};
					if (_vt == "midget") exitWith {
						callSelfParams(playSound, "emotes\laugh\midgetlaugh"+str randInt(1,7) arg getRandomPitchInRange(0.85,1.2));
					};
					callSelfParams(playSound, "emotes\laugh\leg_laugh"+str randInt(1,9) arg getRandomPitchInRange(0.85,1.2));
				} else {
					private _vt = getSelf(voiceTypeTembre);
					if (_vt == "hobo") then {
						callSelfParams(playSound, "emotes\laugh\oldbum_female_laugh"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
					} else {
						callSelfParams(playSound, "emotes\laugh\laugh_female"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
					};
				};
			};
		};
		if (_type == "gasp") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\gasp_male"+str randInt(1,7) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\gasp_female"+str randInt(1,7) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "1shotbreath") exitWith {
			//1shot_breathing
			callSelfParams(playSound, "emotes\1shot_breathing"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "coughwounded") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\woundedcough"+str randInt(1,4) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\cough_female"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "fart") exitWith {
			callSelfParams(playSound, "emotes\fart"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "clap") exitWith {
			//can use gloves variant clapping_gloves
			callSelfParams(playSound, "emotes\clapping" arg getRandomPitchInRange(0.8,1.3));
		};
		if (_type == "krak") exitWith {
			callSelfParams(playSound, "emotes\krak"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "yawn") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\yawn_man"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\yawn_woman"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		//
		if (_type == "whimper") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\whimper_male"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\whimper_female"+str randInt(1,3) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		//хм
		if (_type == "hem") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\huh_male1" arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\huh_female1" arg getRandomPitchInRange(0.85,1.2));
			};
		};
		//чих
		if (_type == "sneeze") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\sneezem"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\sneezef"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "finger") exitWith {
			callSelfParams(playSound, "emotes\finger" arg getRandomPitchInRange(0.85,1.2));
		};
		if (_type == "whistle") exitWith {
			callSelfParams(playSound, "emotes\whistle"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
		};
		//хихикать
		if (_type == "giggle") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\male_giggle" arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\giggle_woman"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		//храп
		if (_type == "snore") exitWith {
			callSelfParams(playSound, "emotes\snore"+str randInt(1,7) arg getRandomPitchInRange(0.85,1.2));
		};
		//шлепочек
		if (_type == "slap") exitWith {
			callSelfParams(playSound, "emotes\slap" arg getRandomPitchInRange(0.85,1.2));
		};
		//вздох
		if (_type == "sigh") exitWith {
			if callSelf(isMale) then {
				callSelfParams(playSound, "emotes\sigh_male" arg getRandomPitchInRange(0.85,1.2));
			} else {
				callSelfParams(playSound, "emotes\sigh_female"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
			};
		};
		if (_type == "cough") exitWith {
			if callSelf(isMale) then {
				if (getSelf(age) >= 50) then {
					callSelfParams(playSound, "emotes\cough_oldman" arg getRandomPitchInRange(0.85,1.2));
				} else {
					if callSelf(isChild) then {
						callSelfParams(playSound, "emotes\kid_cough"+str randInt(1,2) arg getRandomPitchInRange(0.85,1.2));
					} else {
						callSelfParams(playSound, "emotes\cough_man"+str randInt(1,8) arg getRandomPitchInRange(0.85,1.2));
					};
				};
			} else {
				callSelfParams(playSound, "emotes\cough_woman"+str randInt(1,7) arg getRandomPitchInRange(0.85,1.2));
			};
		};

		errorformat("Mob::playEmoteSound() - Unknown sound type <%1>",_type);
	};

	func(onActWorld)
	{
		objParams();
		"wrld" call ie_action_setPrefix;
		
		if (["toGhost"] call ie_action_check) exitWith {
			private _event = {
				callSelf(CloseMessageBox);
				[this,"Ghost"] call cm_switchToMob;
			};
			callSelfParams(ShowMessageBox,"MessageBox" arg ["<t size='1.4'>Вы уверены?</t>" arg "Да"] arg _event);
		};
		
		if !callSelf(isActive) exitWith {};
		
		if (["teach"] call ie_action_check) exitWith {
			callSelfParams(localSay,"НЕ ХОЧУ УЧИТЬ!" arg "error");
		};
		if (["search"] call ie_action_check) exitWith {
			if !callSelf(isEmptyActiveHand) exitWith {
				callSelfParams(localSay,"В руке не пусто." arg "error");
			};
			callSelfParams(startSelfProgress,"actworld_dosearch" arg getSelf(rta)*1.5 arg INTERACT_PROGRESS_TYPE_MEDIUM);
		};
		if (["inputedsignlang"] call ie_action_check) exitWith {
			private _emoteStr = capitalize(getSelf(lastEmoteActionString));
			
			{
				if callFuncParams(_x,hasPerk,"PerkSignLang") then {
					_rm__ = format["%1 %2 - <t color='#EB49CD'>""%3""</t>",
						callFuncParams(this,getNameFor,_x),
						pick[
							"жестикулирует",
							"общается руками",
							"говорит руками"
						],
						_emoteStr
					];
					callFuncParams(_x,localSay,_rm__ arg "default");
				} else {
					_rm__ = format["<t color='#EB49CD'>%1 %2.</t>",
						callFuncParams(this,getNameFor,_x),
						pick[
							"мотает руками",
							"показывает непонятные жесты",
							"вертит руками",
							"что-то делает руками",
							"болтает руками"
						]
					];
					callFuncParams(_x,localSay,_rm__ arg "default");
				};
			} foreach callSelfParams(getNearMobs,10 arg false);
		};
	};
	func(actworld_dosearch)
	{
		objParams();
		if !callSelf(isEmptyActiveHand) exitWith {
			callSelfParams(localSay,"В руке не пусто." arg "error");
		};
		callSelf(generateLastInteractOnServer);
		private _list = callSelfParams(getNearItems,1.2);
		{
			if !callFunc(_x,canPickup) then {_list = _list - [_x]};
		} foreach array_copy(_list);
		if (count _list > 0) then {
			private _item = _list select 0;
			private _m = pick["нащупать","нарыскать","отыскать","найти","надыбать"];
			callSelfParams(mindSay,"Мне удалось "+_m+" "+lowerize(callFunc(_item,getName))+".");
			callSelfParams(pickupItem,_item);
		} else {
			callSelfParams(localSay,"Ничего нет." arg "error");
		};
	};

	func(onActPerception)
	{
		objParams();

		if !callSelf(isActive) exitWith {};
		if (callSelf(getSpeedMode) != SPEED_MODE_STOP) exitWith {
			callSelfParams(localSay,"Надо остановиться." arg "error");
		};
		"pr" call ie_action_setPrefix;
		if (["hear"] call ie_action_check) exitWith {
			callSelfParams(meSay,pick["прислушивается." arg "начинает прислушиваться."]);
			callSelfParams(startSelfProgress,"checkHearing" arg rand(1,2) arg INTERACT_PROGRESS_TYPE_MEDIUM);
		};
		if (["smell"] call ie_action_check) exitWith {
			callSelfParams(startSelfProgress,"checkSmell" arg rand(1,2) arg INTERACT_PROGRESS_TYPE_MEDIUM);
		};
		if (["see"] call ie_action_check) exitWith {
			callSelfParams(meSay,pick["внимательно озирается." arg "всматривается в пространство." arg "бдительно осматривается."]);
			callSelfParams(startSelfProgress,"checkSee" arg rand(1,2) arg INTERACT_PROGRESS_TYPE_FULL);
		};
	};

	func(checkHearing)
	{
		objParams();
		private _hearDist = callSelf(getHearingDistance);
		private _objs = callSelfParams(getNearObjects,"GameObject" arg _hearDist arg true arg true);
		private _dir = "";
		private _delegate_dirCalc = {
			_dir = callSelfParams(getDirectionTo,_x);
			call {
				if(_dir==DIR_FRONT)exitWith{_dir=pick["впереди","спереди","прямо"]};
				if(_dir==DIR_BACK)exitWith{_dir=pick["позади","сзади","за мной"]};
				if(_dir==DIR_LEFT)exitWith{_dir=pick["слева","слева от меня"]};
				if(_dir==DIR_RIGHT)exitWith{_dir=pick["справа","справа от меня"]};
			};
		};
		private _delegate_getDistanceText = {
			private _idx = round(linearConversion[0,_hearDist,callSelfParams(getDistanceTo,_x),0,2,true]);
			["совсем рядом","неподалёку","вдалеке"] select _idx
		};
		private _list = [];
		private _unStealthedMob = false;
		{
			if callFunc(_x,isMob) then {
				private _isBigText = false;
				private _isStealthMovingText = false;
				private _canShowText = true;
				if getVar(_x,isStealthEnabled) then {
					private _meBouns = 0;
					private _himBonus = 0;
					// ----------- мои бонусы ---------------
					if !callSelfParams(isEmptySlot,INV_HEAD) then {
						modvar(_meBouns) - 3; //штраф за головной убор
					};
					if getSelf(isCloseEyes) then {
						modvar(_meBouns) + 2; //сосредоточился и слушает
					};

					//--------- бонусы скрытого (копия из стандартного хандлера) ----------------
					_stance = callFunc(_x,getStance);
					if (_stance == STANCE_MIDDLE) then {
						modvar(_himBonus) + 3;
					} else {
						if (_stance == STANCE_DOWN) then {
							modvar(_himBonus) + 4;
						};
					};
					_speedMode = callFunc(_x,getSpeedMode);
					if (_speedMode == SPEED_MODE_WALK) then {modvar(_himBonus) - 2};
					if (_speedMode == SPEED_MODE_RUN) then {modvar(_himBonus) - 8};
					if (_speedMode == SPEED_MODE_SPRINT) then {modvar(_himBonus) - 14};
					modvar(_himBonus) - getSelf(curEncumbranceLevel);
					if !callFuncParams(this,hasPerk,"PerkSeeInDark") then {
						modvar(_himBonus) + LIGHT_GET_MODIF_STEALTH(callFunc(_x,getLighting));
					};

					//скрытность против слуха
					if callSelfParams(doSkillCompetition,_x arg vec2("Hearing","stealth") arg vec2(_meBouns,_himBonus)) then {
						_isBigText = true;
						_isStealthMovingText = true;
						callFuncParams(_x,setStealth,false);
						private _m = pick["Тебя обнаружили...","Тебя заметили!","Тебя услышали!"];
						callFuncParams(_x,mindSay,_m);
						_unStealthedMob = true;
					} else {
						_canShowText = false;
					};
				};

				_isStealthMovingText = true;
				if (_canShowText) then {
					private _movtxt = "есть";
					_speed = callFunc(_x,getSpeedMode);
					_stance = callFunc(_x,getStance);
					if (_speed > SPEED_MODE_STOP) then {
						if(_stance==STANCE_DOWN)then{
							_movtxt= if (!_isStealthMovingText) then {
								pick["ползет","ползает","копошится","шуршит","двигается лёжа"];
							} else {
								pick["шуршит","мельтешит","ползет"];
							}
						}else{
							_movtxt=if(!_isStealthMovingText)then{
								pick["топчет","идёт","двигается","шагает","ступает","перебирает ногами"];
							} else {
								pick["крадётся","подкрадывается","аккуратно двигается","скрытничает"];
							}
						};
					};
					call _delegate_dirCalc;
					private _tForm = "%1 %2 %3 %4.";
					if (_isBigText) then {
						private _pref = pick["ОПА! ","ОПАЧКИ! ","АГААА! ","НУ ВОТ! ","АААААА! ","ОПАНЬКИ! ","ЧТООО?!! "];
						_tForm = setstyle(_pref + _tForm,style_redbig);
					};
					_list pushBack (format[
						_tForm,
						pick["Слышу! Кто-то","Кто-то","Я слышу, как кто-то","Кажется кто-то","Мне слышно как кто-то"],
						_movtxt,
						_dir,
						call _delegate_getDistanceText
					]);
				};

			} else {
				if callFunc(_x,isFireLight) then {
					if getVar(_x,lightIsEnabled) then {
						call _delegate_dirCalc;

						_txt = format["%4 %1 %2 %3.",
							lowerize(callFunc(_x,getName)),
							_dir,
							call _delegate_getDistanceText,
							pick["Слышу","Мне слышится","Я слышу...","Кажется слышу...","Слух не подводит - это"]
						];
						_list pushBack _txt;
					};
					continue
				};
			};

		} foreach _objs;

		if (_unStealthedMob) then {
			callSelfParams(playSoundLocal,"effects\tension"+str randInt(1,8) arg getRandomPitchInRange(0.8,1.3));
		};
		if (count _list == 0) exitWith {
			callSelfParams(mindSay,"Не слышу ничего подозрительного.");
		};
		//callSelfParams(mindSay,_list joinString sbr); //Много сообщений лучше вывдоить в mbx
		callSelfParams(ShowMessageBox,"Text" arg _list joinString sbr);

	};
	func(checkSmell)
	{
		objParams();
		private _smell = callSelf(getPer);
		//за маску штраф -2
		if !callSelfParams(isEmptySlot,INV_FACE) then {
			modvar(_smell) - 2;
		};
		//конвертация в дистанцию
		private _dist = (linearConversion[1,80,_smell,0,50]) max 0;
		private _mArr = [];
		private _si = "";
		{
			_si = callFuncParams(_x,getSmellInfo,callSelfParams(getDistanceTo,_x));
			if (_si!="") then {_mArr pushBackUnique _si};
		} foreach callSelfParams(getNearObjects,"GameObject" arg _dist arg true arg true arg false);
		if (count _mArr == 0) exitWith {
			callSelfParams(mindSay,"Тут ничем не пахнет.");
		};
		
		private _txt = "<t size='1.3' color='#0BB3B3'>" + (pick["Я чую что-то:","Мне удалось учуять:","Я чую:"]);
		modvar(_txt)+sbr;
		modvar(_txt) + (_mArr joinString sbr);
		modvar(_txt)+"</t>";
		callSelfParams(ShowMessageBox,"Text" arg _txt);
	};
	
	
	func(checkSee)
	{
		objParams();

		if getSelf(isCloseEyes) exitWith {
			private _m = pick["бесконечную","непроглядную","вечную","безысходную","бессмысленную"];
			callSelfParams(mindSay,"Вижу только "+_m+" тьму.");
		};

		private _maxDist = callSelf(getViewDistance);
		private _viewMode = callSelf(getViewMode);
		private _canvisAny = false;
		private ["_ref_vismode"];
		{
			/*
				Логика следующая:
					- бросаем до него лайны с рефом
					если я его совсем не вижу то скип
						или
					работаем с модами
						мне моды:
							viewmode (как штраф)
							за головной убор (бред... за маски и очки может но пока not implemented)
							по ссылке я вижу половину тела его
							за дистанцию
							он сзади но только если дальше 3х метров (штраф)
						ему моды
							он не двигается
							его сложнее заметить (лежит)
							спец мод освещения (штраф)

				Опционально:
					если никого не увидел то прикольное сообщение...
			*/
			_ref_vismode = refcreate(VISIBILITY_MODE_NONE);
			if !callSelfParams(canSeeObject,_x arg _ref_vismode) then {
				continue
			};
			if getVar(_x,isStealthEnabled) then {
				private _meMod = 0;
				call {
					if (_viewMode == VIEW_MODE_MEDIUM) exitWith {modvar(_meMod) - 6};
					if (_viewMode == VIEW_MODE_NONE) exitWith {modvar(_meMod) - 50}; //нихуя без глаз ты не увидишь...
				};

				private _visiblity = refget(_ref_vismode);
				modvar(_meMod) + (round linearConversion[VISIBILITY_MODE_NONE,VISIBILITY_MODE_FULL,_visiblity,-10,3,true]);

				//тут правило понимается следующим образом:
				//насколько хорошо я вижу впринципе и как далеко цель относительно моей дальнозоркости
				private _distance = callSelfParams(getDistanceTo,_x);
				private _distMod = round (linearConversion[1,_maxDist,_distance,+4,-10,true]);
				modvar(_meMod) + _distMod;

				if ((callSelfParams(getDirectionTo,_x)==DIR_BACK) && _distance >= 3) then {
					modvar(_meMod) - 6;
				};

				private _himMod = 0;
				if (callFunc(_x,getSpeedMode)==SPEED_MODE_STOP) then {
					modvar(_himMod) + 1;
				};
				call {
					private _stance = callFunc(_x,getStance);
					if (_stance == STANCE_MIDDLE) exitWith {modvar(_himMod) + 2};
					if (_stance == STANCE_DOWN) exitWith {modvar(_himMod) + 4};
				};
				if !callFuncParams(this,hasPerk,"PerkSeeInDark") then {
					private _lighting = callFunc(_x,getLighting);
					modvar(_himMod) + LIGHT_GET_MODIF_STEALTH(_lighting);
				};

				traceformat("see check - me: %1+%2(%3); him: %4+%5(%6)",callSelf(getPer) arg _meMod arg callSelf(getPer) + _meMod arg
				callFunc(_x,getStealth) arg _himMod arg callFunc(_x,getStealth) + _himMod
				)

				//бросаем
				if callSelfParams(doSkillCompetition,_x arg vec2("Per","stealth") arg vec2(_meMod,_himMod)) then {
					callFuncParams(_x,setStealth,false);
					private _m = pick["Тебя обнаружили...","Тебя заметили!","Тебя увидели!"];
					callFuncParams(_x,mindSay,_m);
					_canvisAny = true;
				} else {

				};

			} else {
				//may be extended examine?..
			};


			true;
		} count callSelfParams(getNearMobs,_maxDist);

		if (_canvisAny) then {
			private _m = pick["Кого-то срисовал!","Вижу кого-то!","Я ВИЖУ!","ВИЖУ!"];
			callSelfParams(mindSay,setstyle(_m,style_redbig));
			callSelfParams(playSoundLocal,"effects\tension"+str randInt(1,8) arg getRandomPitchInRange(0.8,1.3));

		} else {
			callSelfParams(mindSay,"Ничего подозрительного...");
		};

	};


region(Emotes subsystem)

	var(lastEmoteActionString,""); //последняя строка эмоута (для языка жестов или иных)

	/*
		all declaration in "..\..\VerbSystem\ActionsPseudonames.sqf"
		__thisAction__ - external reference for action name

		Всё с префиксами inputed отправляет строку из ввода
	*/
	#define addemt(t___) ["emt", #t___ ,"onActEmote"] call ie_actions_regNew
	["emt","blink","onActEmote"] call ie_actions_regNew;
	["emt","bow","onActEmote"] call ie_actions_regNew;
	["emt","salute","onActEmote"] call ie_actions_regNew;
	["emt","clap","onActEmote"] call ie_actions_regNew;
	["emt","eyebrow","onActEmote"] call ie_actions_regNew;
	["emt","frown","onActEmote"] call ie_actions_regNew;
	["emt","blush","onActEmote"] call ie_actions_regNew;
	["emt","cough","onActEmote"] call ie_actions_regNew;
	["emt","nod","onActEmote"] call ie_actions_regNew;
	["emt","gasp","onActEmote"] call ie_actions_regNew;
	["emt","1shotbreath","onActEmote"] call ie_actions_regNew;
	["emt","coughwounded","onActEmote"] call ie_actions_regNew;
	["emt","giggle","onActEmote"] call ie_actions_regNew;
	["emt","glare","onActEmote"] call ie_actions_regNew;
	addemt(look); addemt(grin); addemt(krak); addemt(whistle);
	addemt(finger); addemt(sigh); addemt(laugh); addemt(mumble);
	addemt(moan); addemt(point); addemt(smile); addemt(shiver); addemt(pale);
	addemt(tremble); addemt(sneeze); addemt(sniff); addemt(snore); addemt(whimper);
	addemt(hem); addemt(wink); addemt(licklips); addemt(yawn); addemt(hug); addemt(handshake);
	addemt(stop); addemt(burp); addemt(fallscream); addemt(agonyscream); addemt(agonypain);
	addemt(moandeath); addemt(agonymoan); addemt(agonydeath);
	addemt(fart); addemt(pee); addemt(poo); addemt(vomit); addemt(masturbate);
	["emt","scream","onActEmote"] call ie_actions_regNew; //крик
	["emt","torturescream","onActEmote"] call ie_actions_regNew; //ебнутый крик
	["emt","clearthroat","onActEmote"] call ie_actions_regNew;
	["emt","cry","onActEmote"] call ie_actions_regNew;
	["emt","slap","onActEmote"] call ie_actions_regNew;

	["pr","hear","onActPerception"] call ie_actions_regNew;
	["pr","smell","onActPerception"] call ie_actions_regNew;
	["pr","see","onActPerception"] call ie_actions_regNew;

	["wrld","teach","onActWorld"] call ie_actions_regNew;
	["wrld","search","onActWorld"] call ie_actions_regNew;
	["wrld","toGhost","onActWorld"] call ie_actions_regNew; //в госта 

	["wrld","inputedsignlang","onActWorld"] call ie_actions_regNew;

	var(__listactions,[
		["Эмоции" arg		
			"Краснеть:emt_blush" arg
			"Скалиться:emt_grin" arg
			"Улыбка:emt_smile" arg
			"Подмигнуть:emt_wink" arg
			"Облизнуться:emt_licklips" arg
			"Нахмуриться:emt_frown" arg
			"Приподнять бровь:emt_eyebrow"
		] arg
		["Звуки" arg
			"Посмеиваться:emt_giggle" arg
			"Хмыкнуть:emt_hem" arg
			"Свистеть:emt_whistle" arg
			"Крик:emt_scream" arg
			"Хныкать:emt_whimper" arg
			"Плач:emt_cry" arg
			"Зевать:emt_yawn" arg
			"Вздох:emt_sigh" arg
			"Смеяться:emt_laugh" arg
			"Кашель:emt_clearthroat" arg
			"Бормотать:emt_mumble" arg
			"Рыгнуть:emt_burp" arg
			"Пернуть:emt_fart" 
		] arg
		["Жесты" arg
			"Стоп:emt_stop" arg
			"Поклон:emt_bow" arg
			"Обнять:emt_hug" arg
			"Рукопожатие:emt_handshake" arg
			"Приветствие:emt_salute" arg
			"Похлопать:emt_clap" arg	
			"Кивнуть:emt_nod" arg
			"Хруст пальцами:emt_krak" arg
			"Щелчок пальцами:emt_finger" arg
			"Указать:emt_point" arg
			"Шлепок:emt_slap"
		] arg
		["Восприятие" arg
			"Смотреть:emt_look" arg
			"Моргать:emt_blink" arg	
			"Прислушаться:pr_hear" arg
			"Принюхаться:pr_smell" arg
			"Присмотреться:pr_see"
		] arg

		["Мир" arg 
			"Учить:wrld_teach" arg 
			"Надыбать:wrld_search"]
	]);
	/*["Желания" arg
		"Наложить:emt_poo" arg
		"Отлить:emt_pee" arg
		"Мутюлить:emt_masturbate" arg
		"Курамозиться:emt_sex" arg
		"Сон:emt_sleep"
	] arg*/

/*	func(testActions)
	{
		objParams();
		if (getSelf(owner) isNotEqualTO player) exitWith {};
		callSelfParams(addAction,"Жрун" arg "Принюхаться" arg "eater_sniff");
		callSelfParams(addAction,"Жрун" arg "Восстановление" arg "eater_regen");
		vtest = this;
		_c = {
			this = vtest;
			callSelfParams(removeAction,"eater_regen");
			callSelfParams(removeAction,"eater_sniff");
		}; invokeAfterDelay(_c,7);
	};*/

	
