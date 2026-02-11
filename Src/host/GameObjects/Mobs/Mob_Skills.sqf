// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define skill_def [10,0]
#define SKILL_BASE 0
#define SKILL_MOD 1

#define attr_def [0,0]
#define ATTR_BASE 0
#define ATTR_MOD 1

var(ST,skill_def);
var(IQ,skill_def);
var(DX,skill_def);
var(HT,skill_def);

//усталость
var(fp,attr_def);
var(will,attr_def);
var(per,attr_def);
var(hp,attr_def);

//базовый груз
var(bl,attr_def);
//базовая скорость
var(bs,attr_def); //на уклонениях
//базовое движение
var(move,attr_def); //на нагрузке
var(animCoef,1);//for move

// real-time action (скорость действий/рефлексов)
var(rta,1);
var(lastActionTime,0); //время последнего действия
var(lastCombatActionTime,0); //время последней атаки

//Вес и рост
var(height,0);
var(weight,0);

var(stamina,100);
var(staminaMax,100);

//перки персонажа
var(perks,createHashMap);

func(addPerk) {
	objParams_1(_str);
	if !("Perk" in _str) then {
		_str = "Perk" + _str;
	};
	if callSelfParams(hasPerk,_str) exitWith {false};
	private _perkObj = instantiate(_str);
	getSelf(perks) set [_str,_perkObj];
	callFuncParams(_perkObj,onGetPerk,this);

	true
};

func(hasPerk)
{
	objParams_1(_str);
	if !("Perk" in _str) then {
		_str = "Perk" + _str;
	};
	_str in getSelf(perks)
};

func(removePerk)
{
	objParams_1(_str);
	if !("Perk" in _str) then {
		_str = "Perk" + _str;
	};
	private _pObj = getSelf(perks) getOrDefault [_str,nullPtr];
	if !isNullReference(_pObj) then {
		callFuncParams(_pObj,onLossPerk,this);
		delete(_pObj);
	};
	getSelf(perks) deleteAt _str;
};

func(getPerksTextInfo)
{
	objParams_1(_delimeter);
	if isNullVar(_delimeter) then {_delimeter = sbr};
	private _txt = [];
	{
		_txt pushBack (format["%1 - %2",getVar(_y,name),getVar(_y,desc)]);
	} foreach getSelf(perks);
	_txt joinString _delimeter
};

region(Skilldef macros)
	#define replicatePrep(enum,var) [enum,var]
	#define great_less(val) max val
	#define _get_skill_byref(nameref) (nameref select SKILL_BASE) + (nameref select SKILL_MOD)
	#define __alloc_attr(attr,val) getSelf(attr) set [SKILL_BASE,val]
	#define __alloc_attr_repl(attr,val,varname) private varname = getSelf(attr); varname set [SKILL_BASE,val]
	/* Определяет группу методов:
		getSkill - получает фактическое значение скилла на данный момент (мод+текущее)
		addSkill - добавляет к моду скилла значение и производит рекалькуляцию (если надо)
		getBase - получает базовое значение скилла
		getBonus - получает бонусное значение скилла
		initSkill - устанавливает базовое значение скилла и производит рекалькуляцию (если надо)
	*/
	#define defFuncSkill(name,recalc,ismod) func_runtime('get' + 'name') {objParams(); private _##name = getSelf(name); ((_##name select SKILL_BASE) + (_##name select SKILL_MOD)) ismod}; \
	func_runtime('add' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); MODARR(_ref,SKILL_MOD,+_val); \
		warningformat('Added %1 ed on stat <name>. Now is %2 (%3)',_val arg _ref arg _get_skill_byref(_ref)); \
		recalc \
	}; \
	func_runtime('getBase' + 'name') {objParams(); getSelf(name) select SKILL_BASE}; \
	func_runtime('getBonus' + 'name') {objParams(); getSelf(name) select SKILL_MOD}; \
	func_runtime('init' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); _ref set [SKILL_BASE,_val]; \
		recalc \
	}
	/*
		Отличие этого макроса от вышнего лишь в том,
		что при инициализации устанавливается значение модификатора
	*/
	#define defFuncATTRIBUTE(name,recalc) func_runtime('get' + 'name') {objParams(); private _##name = getSelf(name); (_##name select SKILL_BASE) + (_##name select SKILL_MOD)}; \
	func_runtime('add' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); MODARR(_ref,SKILL_MOD,+_val); \
		recalc \
	}; \
	func_runtime('getBase' + 'name') {objParams(); getSelf(name) select SKILL_BASE}; \
	func_runtime('getBonus' + 'name') {objParams(); getSelf(name) select SKILL_MOD}; \
	func_runtime('init' + 'name') {objParams_1(_val); \
		private _ref = getSelf(name); _ref set [SKILL_MOD,_val]; \
		recalc \
	}

	//common skills macros
	// накопленный опыт скилла как сама переменная скилла
	#define defFuncCommonSkill(name,basev) func_runtime('get' + 'name') { \
		objParams(); \
		basev + getSelf(name) \
	}; \
	 _csl = 'name'; var_runtime(_csl,0)

	#define defFuncCommonSkillOverride(name) func_runtime('get' + 'name') { \
		objParams(); \
		getSelf(name) \
	}; \
	_csl = 'name'; var_runtime(_csl,0)

region(Skill functions)
	// =================== СИЛА ======================
	defFuncSkill(ST,callSelf(onRecST),great_less(1));
	func(onRecST)
	{
		objParams();
		private _st = callSelf(getST);
		private _bl = _st * _st / 10; if (_bl > 5) then {_bl = round _bl};
		__alloc_attr(bl,_bl);
		callSelf(onRecBL);
		__alloc_attr_repl(hp,_st,_hpArr);

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_ST,_ref) arg
			replicatePrep(SKILL_INDEX_HP,_hpArr)
		]);
	};

	// =================== ИНТЕЛЛЕКТ ======================
	defFuncSkill(IQ,callSelf(onRecIQ),great_less(0));
	func(onRecIQ)
	{
		objParams();
		private _iq = callSelf(getIQ);
		__alloc_attr_repl(will,_iq,_wa);
		__alloc_attr_repl(per,_iq,_pa);

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_IQ,_ref) arg
			replicatePrep(SKILL_INDEX_WILL,_wa) arg
			replicatePrep(SKILL_INDEX_PER,_pa)
		]);
	};

	// =================== ВЫНОСЛИВОСТЬ ======================
	defFuncSkill(DX,callSelf(onRecDX),great_less(0));
	func(onRecDX)
	{
		objParams();
		private _bs = (callSelf(getHT) + callSelf(getDX)) / 4;
		__alloc_attr(bs,_bs);
		callSelf(onRecBs); //ok

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_DX,_ref)
		]);

	};
	// =================== ЗДОРОВЬЕ ======================
	defFuncSkill(HT,callSelf(onRecHT),great_less(1));
	func(onRecHT)
	{
		objParams();
		private _ht = callSelf(getHT);
		__alloc_attr_repl(fp,_ht,_fa);
		callSelf(onRecFp);
		private _bs = (_ht + callSelf(getDX)) / 4;
		__alloc_attr(bs,_bs);
		callSelf(onRecBs); //ok

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_HT,_ref) arg
			replicatePrep(SKILL_INDEX_FP,_fa)
		]);
	};

	// =============== BL ===============
	defFuncATTRIBUTE(BL,callSelf(onRecBL));
	func(onRecBL)
	{
		objParams();
		this call gurps_recalcuateEncumbrance;
	};

	// ============ HP =============
	defFuncATTRIBUTE(HP,callSelf(onRecHP));
	func(onRecHP)
	{
		objParams();
		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_HP,_ref)
		]);
		callSelf(onHPUpdate);
	};

	// ========== WILL =============
	defFuncATTRIBUTE(Will,callSelf(onRecWill));
	func(onRecWill)
	{
		objParams();

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_WILL,getSelf(Will))
		]);
	};

	// ========== PER =============
	defFuncATTRIBUTE(Per,callSelf(onRecPer));
	func(onRecPer)
	{
		objParams();

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_PER,_ref)
		]);
	};

	// ========== FP =============
	defFuncATTRIBUTE(Fp,callSelf(onRecFp));
	func(onRecFp) {
		objParams();
		//todo stamina update
		private _fp = getSelf(Fp);
		private _fullFp = _get_skill_byref(_fp);
		private _maxStamina = _fullFp * 10;
		private _curStamina = getSelf(stamina) min _maxStamina;

		setSelf(staminaMax,_maxStamina);
		setSelf(stamina,_curStamina); //TODO check this

		callSelfParams(fastSendInfo,"cd_stamina_max" arg _maxStamina);
		callSelfParams(fastSendInfo,"cd_stamina_cur" arg _curStamina);

		callSelfParams(sendInfo, "OnSkillsUpdate" arg [
			replicatePrep(SKILL_INDEX_FP,_fp)
		]);
	};

	// ========== bs ============
	defFuncATTRIBUTE(bs,callSelf(onRecBs));
	func(onRecBs)
	{
		objParams();
		private _bs = callSelf(getBs);
		__alloc_attr(move,floor(_bs));

		setSelf(animCoef,_bs / 4);
		callSelf(onChangeAnimCoef);

		setSelf(rta,pow(5,0.75)/pow(_bs,0.75)); //real time action
	};

	// ===== move ====
	func(getMove)
	{
		objParams();
		private _mva = getSelf(move);
		_get_skill_byref(_mva)
	};

region(calculating common skills basic values)
	func(calculateCommonSkillsBasicValues)
	{
		objParams();

		//TODO change common skills basic evaluation

		private _dx = callSelf(getDX);
		private _iq = callSelf(getIQ);
		private _per = callSelf(getPer);
		setSelf(fight,_dx);
		setSelf(shield,_dx - 4);
		setSelf(fencing,_dx - 1);
		setSelf(axe,_dx - 1);
		setSelf(baton,_dx - 5);
		setSelf(spear,_dx - 1);
		setSelf(sword,_dx - 1);
		setSelf(knife,_dx);
		setSelf(whip,_dx - 1);

		setSelf(pistol,_dx - 4);
		setSelf(rifle,_dx - 4);
		setSelf(shotgun,_dx - 4);
		setSelf(crossbow,_dx - 4);

		setSelf(throw,_dx - 1);

		setSelf(chemistry,_iq - 6);
		setSelf(alchemy,0);

		setSelf(engineering,_iq - 5);
		setSelf(traps,_iq - 5);
		setSelf(repair,_iq - 5);
		setSelf(blacksmithing,_iq - 5);
		setSelf(craft,0);

		setSelf(theft,_dx - 6);
		setSelf(stealth,_dx - 5);
		setSelf(agility,_dx - 5);
		setSelf(lockpicking,_dx - 5);

		setSelf(healing,_iq - 4);
		setSelf(surgery,_iq - 7);

		setSelf(cavelore,_per - 5);

		setSelf(cooking,_iq - 5);
		setSelf(farming,_iq - 5);

		//нижний предел
		{setSelfReflect(_x,getSelfReflect(_x) max 0)} count skills_internal_list_otherSkillsSystemNames;
	};

region(Common skills functions)
	// =============================
	// ======= COMMON SKILLS =======
	// =============================

	/****************

       MELEE COMBAT

    *****************/

   // ======== Рукопашный бой ============
   defFuncCommonSkill(fight,callSelf(getDX));

   // ====== Щит =========
   defFuncCommonSkill(shield,callSelf(getDX) - 4);

   // ========== Сабли и рапиры (фехтовальное) ===========
   defFuncCommonSkill(fencing,callSelf(getDX) - 1);

   // ========= Топоры =========
   defFuncCommonSkill(axe,callSelf(getDX) - 1);

   // ========= Дубины =========
   defFuncCommonSkill(baton,callSelf(getDX) - 5);

   // ========= Копья =========
   defFuncCommonSkill(spear,callSelf(getDX) - 1);

   // ========= Мечи =========
   defFuncCommonSkill(sword,callSelf(getDX) - 1);

   // ========= Ножи =========
   defFuncCommonSkill(knife,callSelf(getDX));

   // ========= Кнут =========
   defFuncCommonSkill(whip,callSelf(getDX) - 1);

   /****************

      RANGED COMBAT

   *****************/

   // ========= Пистолеты,винтовки, дробовики =========
   defFuncCommonSkill(pistol,callSelf(getDX));
   defFuncCommonSkill(rifle,callSelf(getDX));
   defFuncCommonSkill(shotgun,callSelf(getDX));
   defFuncCommonSkill(crossbow,callSelf(getDX) - 4); //арбалеты

   defFuncCommonSkill(throw,callSelf(getDX) - 1); //метание обычных предметов (например гранат или просто вещей). для оружия использовать их спецу

   /****************

      OTHER SKILLS

   *****************/
   // ======= Химия =========
   defFuncCommonSkill(chemistry,callSelf(getIQ) - 6); //химичество (химия)
   defFuncCommonSkillOverride(alchemy); //грибничество (алхимия)

   //  ======= Инженерка ========
   defFuncCommonSkill(engineering,callSelf(getIQ) - 2); //общая инженерка
   defFuncCommonSkill(traps,callSelf(getIQ) - 5); //ловушечки
   defFuncCommonSkill(repair,callSelf(getIQ) - 5);
   defFuncCommonSkill(blacksmithing,callSelf(getIQ) - 5);
   defFuncCommonSkill(craft,0);

   // ========= Воровские =========
   defFuncCommonSkill(theft,0);
   defFuncCommonSkill(stealth,0);
   defFuncCommonSkill(agility,0); //карабканье
   defFuncCommonSkill(lockpicking,0); //взлом

   // Медицинские
   defFuncCommonSkill(healing,0); //первая помощь
   defFuncCommonSkill(surgery,0); //хирургия

   // Знание пещер
   defFuncCommonSkill(cavelore,0);

   // Готовка и фермерство
   defFuncCommonSkill(cooking,0);
   defFuncCommonSkill(farming,0);

	//Полная проверка. Возвращает результат успеха
	//Если последний параметр _isSimpleReturn == true то возвращается true при успехе и false при провалах
	func(checkSkill)
	{
		params ['this',"_strSkill",["_bonus",0],["_isSimpleReturn",false]];
		//objParams_1(_strSkill);
		private _res = (callSelfReflect("get"+_strSkill)+_bonus) call gurps_rollstd;
		if (_isSimpleReturn) exitwith {
			getRollType(_res) in [DICE_SUCCESS,DICE_CRITSUCCESS]
		};
		_res
	};

	//провести состязание навыков. Если возвращается true то победа вызывающего, false проигрыш
	func(doSkillCompetition)
	{
		params ['this',"_target","_strSkill","_bonuses"];
		ifcheck(equalTypes(_strSkill,[]),_strSkill,vec2(_strSkill,_strSkill))params["_meSkill","_himSkill"];

		private _bonusMe = ifcheck(isNullVar(_bonuses),0,ifcheck(equalTypes(_bonuses,0),_bonuses,_bonuses select 0));
		private _bonusHim = ifcheck(isNullVar(_bonuses),0,ifcheck(equalTypes(_bonuses,0),_bonuses,_bonuses select 1));
		unpackRollResult(callSelfParams(checkSkill,_meSkill arg _bonusMe),_stMe,_diceRez_1,_3d6Amount_1);
		unpackRollResult(callFuncParams(_target,checkSkill,_himSkill arg _bonusHim),_stHim,_diceRez_2,_3d6Amount_2);
		(_stMe - _stHim)>0
	};

	// func(checkSkillWith)
	// {
	// 	params ['this',"_strSkill","_otherValue",["_bonuses",0],["_isSimpleReturn",false]];
	// 	private _bonusMe = ifcheck(isNullVar(_bonuses),0,ifcheck(equalTypes(_bonuses,0),_bonuses,_bonuses select 0));
	// 	private _bonusHim = ifcheck(isNullVar(_bonuses),0,ifcheck(equalTypes(_bonuses,0),_bonuses,_bonuses select 1));

	// 	unpackRollResult(callSelfParams(checkSkill,_strSkill arg _bonusMe),_stMe,_diceRez_1,_3d6Amount_1);
	// 	unpackRollResult(_otherValue call gurps_rollstd,_stHim,_diceRez_2,_3d6Amount_2);
	// 	(_stMe - _stHim)>0
	// };


region(learning skills)
	//max skill level was 18, min 0
	var(__learnStatus,createHashMap);

	func(updateSkillLevel)
	{
		params ['this',"_skill","_level",["_noApply",false]];
		private _oldValue = getSelfReflect(_skill);
		_level = floor clamp(ifcheck(_noApply,_level,_oldValue + _level),0,18);
		setSelfReflect(_skill,_level);
	};

	func(learnSkill)
	{
		params ['this',"_name",["_bonus",0],["_isSilent",false]];
		private _learnref = getSelf(__learnStatus);
		//for map use
		_name = tolower _name;

		private _roll = callSelfParams(checkSkill,"IQ" arg _bonus);
		private _result = getRollType(_roll);
		private _learned = getRollAmount(_roll);
		call {
			if (_result == DICE_CRITSUCCESS) then {
				_learned = _learned * 2;
			};
			if (_result == DICE_SUCCESS) exitWith {
				private _oldval = _learnref getOrDefault [_name,0];
				_learnref set [_name,_oldval + _learned];

				private _t = format["<t size='1.2'>Мне %1: %2</t>",
					pick["что-то ясно","становится понятно","узнаётся новое"],
					callSelfParams(getSkillLearnProgressToText,_name)
				];
				if (!_isSilent) then {
					callSelfParams(localSay,_t arg "mind");
				};
			};
			if (_result == DICE_FAIL) exitWith {
				if (!_isSilent) then {
					callSelfParams(localSay,"Не могу понять." arg "error");
				};
			};
			if (_result == DICE_CRITFAIL) exitWith {
				if (!_isSilent) then {
					callSelfParams(localSay,"Слооожна!..." arg "error");
				};
			};
		};

		callSelfParams(postCheckLearning,_name);
	};

	skills_internal_map_nameAssoc = createHashMapFromArray[
		vec2("st","сила"),
		vec2("iq","интеллект"),
		vec2("dx","ловкость"),
		vec2("ht","здоровье"),
		vec2("fp","усталость"),
		vec2("will","воля"),
		vec2("per","восприятие"),
		vec2("hp","жизнь"),
		//other
		vec2("fight","рукопашный бой"),
		vec2("shield","щиты"),
		vec2("fencing","фехтование"),
		vec2("axe","топоры"),
		vec2("baton","дубины"),
		vec2("spear","копья"),
		vec2("sword","мечи"),
		vec2("knife","ножи"),
		vec2("whip","кнуты"),

		vec2("pistol","пистолеты"),
		vec2("rifle","винтовки"),
		vec2("shotgun","дробовики"),
		vec2("crossbow","луки"),

		vec2("throw","метание"),

		vec2("chemistry","химичество"),
		vec2("alchemy","грибничество"),

		vec2("engineering","инженерия"),
		vec2("traps","ловушки"),
		vec2("repair","ремонт"),
		vec2("blacksmithing","кузнечество"),
		vec2("craft","создание"),

		vec2("theft","воровство"),
		vec2("stealth","скрытность"),
		vec2("agility","акробатика"),
		vec2("lockpicking","взлом"),

		vec2("healing","первая помощь"),
		vec2("surgery","хирургия"),

		vec2("cavelore","знание пещер"),

		vec2("cooking","готовка"),
		vec2("farming","фермерство")
	];
	func(getSkillName)
	{
		objParams_1(_name);
		skills_internal_map_nameAssoc getOrDefault [toLower _name,"неизвестно"]
	};

	func(getSkillLearnProgressToText)
	{
		objParams_1(_name);
		private _learned = getSelf(__learnStatus) getOrDefault [toLower _name,0];
		private _skillVal = getSelfReflect(_name);
		private _val = _learned / (_skillVal max 1);
		private _textRet = "";
		for "_i" from 0 to 20 do {
			modvar(_textRet) + ifcheck(_i <= _val,"+","-");
		};
		_textRet
	};

	func(postCheckLearning)
	{
		objParams_1(_name);
		private _curSkill = getSelfReflect(_name);
		private _learnref = getSelf(__learnStatus);

		private _learned = _learnref getOrDefault [_name,0];
		private _maxlearn = 20 * _curSkill;
		if (_learned < _maxlearn) exitWith {}; //not learn

		callSelfParams(updateSkillLevel,_name arg + 1);
		_learnref set [_name,0];

		private _m = format["Мой навык '%1' улучшился!",callSelfParams(getSkillName,_name)];
		callSelfParams(localSay,_m arg "mind");
	};

	func(getSkillLevelText)
	{
		objParams_1(_sk);
		private _val = getSelfReflect(_sk);
		if (_val <= 2) exitWith {"<t color='#572700'>Никчемный</t>"};
		if (_val >= 3 && _val <= 5) exitWith {"<t color='#8EA647'>Неумелый</t>"};
		if (_val >= 6 && _val <= 9) exitWith {"<t color='#13BA1E'>Новичок</t>"};
		if (_val >= 10 && _val <= 11) exitWith {"<t color='#D8DB07'>Опытный</t>"};
		if (_val >= 12 && _val <= 13) exitWith {"<t color='#FF4D00'>Умелый</t>"};
		if (_val >= 14 && _val <= 15) exitWith {"<t color='#0E41CC'>Эксперт</t>"};
		if (_val == 16) exitWith {"<t color='#8C06CB'>Мастер</t>"};
		//if (_val >= 17) exitWith {"Легендарный"};
		"<t color='#CF083D'>Легендарный</t>"
	};

	skills_internal_list_otherSkillsSystemNames = [
		"fight","shield","fencing","axe","baton","spear","sword","knife","whip",
		"pistol","rifle","shotgun","crossbow",
		"throw",
		"chemistry","alchemy",
		"engineering","traps","repair","blacksmithing","craft",
		"theft","stealth","agility","lockpicking",
		"healing","surgery",
		"cavelore",
		"cooking","farming"
	];

	skills_internal_list_otherSkillsSystemNames_withCategories = [
		"@Ближний бой","fight","shield","fencing","axe","baton","spear","sword","knife","whip",
		"@Дальний бой","pistol","rifle","shotgun","crossbow",
		"throw",
		"@Химичество","chemistry","alchemy",
		"@Ремесло","engineering","traps","repair","blacksmithing","craft",
		"cavelore",
		"@Проворство","theft","stealth","agility","lockpicking",
		"@Медицина","healing","surgery",
		"@Кухня","cooking","farming"
	];

	//get all skills info
	func(getLearnedSkillsInfo)
	{
		objParams();

		//TODO: опциональный режим вывода ТОЛЬКО изученных навыков. Изученный, это тот, который числится в getSelf(__learnStatus)

		private _text = pick["Я знаю:","Мне известно:","Мне ведомо:","Я умею:","Я владею:"];
		//_text = format["<t underline='1'>%1</t>",_text];
		private _lvl = 0;
		private _knownany = false;
		private _awaitedCat = "";
		forceUnicode 0; //for work ru-cat
		{
			if (_x select [0,1] == "@") then {
				_x = _x select [1,count _x];
				_awaitedCat = toUpper _x;
				continue;
			};
			_lvl = getSelfReflect(_x);
			if (_lvl > 0) then {
				if (_awaitedCat != "") then {
					modvar(_text) + sbr + setstyle(format["[ %1 ]" arg _awaitedCat],style_learnedskillscategory);
					_awaitedCat = "";
				};
				modvar(_text) + sbr + capitalize(callSelfParams(getSkillName,_x))
				+ ": "+callSelfParams(getSkillLevelText,_x);
				#ifdef EDITOR
				modvar(_text) + (format[" (lvl: %1)",getSelfReflect(_x)]);
				#endif
				_knownany = true;
			};
		} foreach skills_internal_list_otherSkillsSystemNames_withCategories;
		if (!_knownany) then {_text = "Я ничего не умею..."};

		_text
	};

region(perks)
