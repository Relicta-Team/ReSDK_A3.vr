// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

/*
	poses:
	cpt4_pos_start - start playerpos
	cpt4_pos_armyattacktom - army enter to tom actor
	cpt4_pos_enterkochevs - pos of 3 nomads
	cpt4_pos_armyfrommeds - start army guys pos


	RedButton_Activator G:0BHVbZgUjcE - open window
	GateCity G:8fd0oIb9ArY (2) - window gate

	Tumbler_Activator G:hQrKBb16ltI - open enter
	GateCity G:8fd0oIb9ArY (1) - enter door
*/
cpt4_questName_begin = "Снова за работу";
cpt4_questName_kochevs = "Оформим как надо";
cpt4_questName_tomed = "На досмотр";

cpt4_questName_tobar = "Смену отпахал";

cpt4_canOpenEnter = false;
cpt4_canOpenWindow = false;

cpt4_gref_doorwindow = "GateCity G:8fd0oIb9ArY (2)";
cpt4_gref_doorenter = "GateCity G:8fd0oIb9ArY (1)";

cpt4_data_karimFace = "face05_baf";

cpt4_playerUniform = "WatchmanCloth";

cpt4_data_hudStatesDefault = "chat+right+stats+cursor+inv+stam";

cpt4_addProcessorMainAct = {
	params ["_tobjName","_code"];
	["main_action",compile format['
		params ["_t"];
		private _ret = false;
		private _target = "%1" call sp_getObject;
		if equals(_t,_target) then {
			private _result = false;
			%2 ;
			_ret = _result;
		};
		_ret
	',_tobjName,toString _code]] call sp_addPlayerHandler;
	["activate_verb",compile format['
		params ["_t","_name"];
		private _ret = false;
		if (_name == "mainact") then {
			private _target = "%1" call sp_getObject;
			if equals(_t,_target) then {
				private _result = false;
				%2 ;
				_ret = _result;
			};
		};
		_ret
	',_tobjName,toString _code]] call sp_addPlayerHandler;
};

cpt4_internal_func_checkMainAction = {
	params ["_t"];
	if equals(_t,"RedButton G:NJnbP0kznrs" call sp_getObject) exitWith {
		[pick["Это плохая идея!","Свет мне ещё понадобится...","Включить чтобы выключить? Ну и тупость..."],"error"] call chatPrint;
		true
	};
	if (equals(_t,"cpt4_obj_doorbegin" call sp_getObject) && {getVar(_t,isLocked)}) exitWith {
		[pick["Тут еще есть дела.","Нужно сначала разобраться с бумагами.","Работа должна быть доделана..."],"mind"] call chatPrint;
		true
	};
	false
};

cpt4_func_genDescDocs = {
	params [["_name",""],["_role","временное пребывание"],["_note","нет"]];
	
	if equalTypes(_name,GENDER_MALE) then {
		_name = [_name,true] call naming_getRandomName;
	};
	if (_name == "") then {
		_name = [GENDER_MALE,true] call naming_getRandomName;
	};
	private _nh = ifcheck(isNullVar(_namehash),""," " + _namehash);
	private _content = format[
		"Бумага пребывания"+_nh+sbr+sbr+
		"Имя: %1"+sbr+
		"Возраст: " + ([randInt(19,50),["цикл","цикла","циклов"],true] call toNumeralString) + sbr+
		"Положение\работа: %2"+sbr+
		"Примечания: %3",
		_name,_role,_note
	];

	[_content,_name];
};

cpt4_internal_delegate_baseClothRemoveItem = {};

["cpt4_begin",{
	
	private _itemContent = [
		[
			[GENDER_MALE,"сторож насосного склада","злоупотребляет грибной брагой"],
			[GENDER_FEMALE,"кухарка","есть ребёнок"],
			[GENDER_MALE,"счетовод"],
			[GENDER_MALE,"владелец кабака"],
			[GENDER_FEMALE,"хвост","лишена языка"],
			[GENDER_FEMALE,"уходница","лишена языка"],
			[GENDER_MALE,"ополченец","умеет стрелять из пафелей"],
			[GENDER_FEMALE,"торговка"],
			[GENDER_MALE,"ремонтник","был пойман за воровством"],
			[GENDER_MALE, "механик", "специализируется на починке генераторов"],
			[GENDER_MALE, "лекарь", ""],
			[GENDER_MALE, "фермер", "отлично обращается с лопатой"],
			[GENDER_FEMALE, "знахарка", "обучена грамоте"],
			[GENDER_MALE, "кузнец", "недавно прибыл в город"],
			[GENDER_FEMALE, "ткачиха", "лишний вес"],
			[GENDER_MALE, "электрик", "вероятно ворует проводку из генераторной"],
			[GENDER_MALE, "пекарь", "нет правого глаза"],
			[GENDER_MALE, "стражник", "недавно потерял брата"],
			[GENDER_FEMALE, "грибовед", "НЕ ВЫПУСКАТЬ В ПЕЩЕРЫ!"],
			[GENDER_MALE, "переписчик"],
			[GENDER_MALE, "мойщик"],
			[GENDER_MALE, "водовод"],
			[GENDER_MALE, "портной", "2 раза был пойман за драку в баре"],
			[GENDER_MALE, "мусорщик", "собирает и перерабатывает отходы"],
			[GENDER_MALE, "сторож", "испытывает проблемы со сном"],
			[GENDER_MALE, "охотник", "выпускать в пещеры не дольше чем на 3 смены"],
			[GENDER_MALE, "музыкант", "владеет навыком игры на гитаре"],
			[GENDER_MALE, "рыбовод", "запрет на ношение холодного оружия"],
			[GENDER_FEMALE, "светотехник"],
			[GENDER_MALE, "архивариус", "слабое здоровье"],
			[GENDER_FEMALE, "повариха", "под надзором после случая с отравлением в городской столовой"],
			[GENDER_MALE, "диспетчер", "ПДП 34-2927 (УКС)"],
			[GENDER_MALE, "санитар"],
			[GENDER_MALE, "ремонтник", "может работать с генератором"],
			[GENDER_FEMALE, "библиотекарь", "принят недавно. Под ответственность архивариуса"],
			[GENDER_MALE, "грибовед"],
			[GENDER_MALE, "разводчик мельтешат"],
			[GENDER_MALE, "инженер"],
			[GENDER_MALE, "алхимик", "принят из пещер. Под надзором."],
			[GENDER_MALE, "сборщик"],
			[GENDER_FEMALE, "пекарь"],
			[GENDER_MALE, "охранник склада"],
			[GENDER_MALE, "лекарь", "нет левой ноги"],
			[GENDER_MALE, "главный лекарь", "зависимость от алкоголя"],
			[GENDER_MALE, "ученик", "слабые умственные способности"],
			[GENDER_MALE, "техник", "обслуживает оборудование на нижнем ярусе"],
			[GENDER_FEMALE, "хвост"],
			[GENDER_MALE, "повар"],
			[GENDER_MALE, "работник торговой лавки", "изымать пафели"],
			[GENDER_MALE, "строитель", "слабое психическое состояние"],
			[GENDER_FEMALE, "уходница", "язык отрублен"],
			[GENDER_MALE, "плотник"],
			[GENDER_MALE, "техник связи", "выделить отдельное рабочее место в рубке 16"],
			[GENDER_MALE, "оператор", "4 раза терял ключ"],
			[GENDER_MALE, "гриблан"],
			[GENDER_MALE, null, "пребывание не больше 3х смен"],
			[GENDER_FEMALE, null, "будет переоформлена на постоянное пребывание при успешном прохождении проверки"],
			[GENDER_MALE, null, "ТОЛЬКО ВРЕМЕННОЕ ПРЕБЫВАНИЕ"],
			[GENDER_MALE, "электрик"],
			[GENDER_MALE, "вахтёр", "заведующий пропускным ходом 14"],
			[GENDER_FEMALE, "вахтёр", "помощник вахтера с пропускного хода 10"],
			[GENDER_MALE, "пекарь"],
			[GENDER_MALE, "рабочий", "выделить отдельное жильё"],
			[GENDER_MALE, "обувщик"],
			[GENDER_MALE, "хвост", "!последнее предупреждение! Постоянно ворует у торговца химикаты и брагу"],
			[GENDER_MALE, "столяр", "любит хвостить"],
			[GENDER_FEMALE, "охр", "сильная. Очень..."],
			[GENDER_MALE, "охр", "не может быстро бегать"],
			[GENDER_MALE, "духовник", "бывший раб истязателей"],
			[GENDER_MALE, "доставщик", "требуется выяснения по случаю с потерянным ящиком цацевской одежды"],
			[GENDER_MALE, "сетевед", "грамотей, отлично знает писание"],
			[GENDER_MALE, "архитектор", "так же умеет обращаться с лекарствами"],
			[GENDER_MALE, "инструктор охров", "бывший рядовой новоармеец. Под надзором. До первого предупреждения."],
			[GENDER_MALE, "кухарь"],
			[GENDER_MALE, "барник"],
			[GENDER_MALE, "инспектор технических помещений"],
			[GENDER_MALE, "хвост", "местанахождение неизвестно"]
		],
		[
			[GENDER_MALE, "инженер", "работал со схемами основного насоса"],
			[GENDER_MALE, "лекарь"],
			[GENDER_MALE, "учёный", "грамотей"],
			[GENDER_MALE, "технолог", "общается сам с собой. Устроить проверку здоровья"],
			[GENDER_MALE, "механик", "подозрение на ТОМность. Надзор"],
			[GENDER_MALE, "алхимик"],
			[GENDER_MALE, "электрик", "4 раза пережил удар током"],
			[GENDER_MALE, "рабочий", "не сказал ни слова с момента прихода в город. Следить"],
			[GENDER_MALE, "каменщик", "украл хлеб у пекаря. Работает по 3 смены без звяков. Надзор"],
			["Акептис Ухамов", "младший охр", "молчалив. Под надзором Исимбара"],
			[GENDER_MALE, "сборщик"],
			[GENDER_FEMALE, "лекарка"],
			[GENDER_MALE, "исследователь", "бредит во сне"],
			[GENDER_FEMALE, "плотница", "постоянно занимает в долг"],
			[GENDER_MALE, "инспектор фильтров"],
			[GENDER_MALE, "оператор", "под присмотром"],
			["Ладан Усатый", "архивариус", "написал книгу Первого Роя"],
			[GENDER_MALE, "автоматист"],
			[GENDER_MALE, "кузнец"],
			[GENDER_MALE, "инженер"],
			[GENDER_MALE, "эксперт по вентиляции", "говорит, что слышал 'вентиляторного демона'. Проверить на ТОМность"],
			[GENDER_MALE, "логист"],
			[GENDER_MALE, "сварщик"],
			[GENDER_MALE, "механик"],
			[GENDER_MALE, "строитель"],
			[GENDER_MALE, "работник", "лучший работник плана"],
			[GENDER_MALE, "грибовед"],
			[GENDER_MALE, "координатор", "всегда говорит шёпотом"],
			[GENDER_MALE, "оптик", "улучшает зрение каплями из слизня"],
			[GENDER_MALE, "чертёжник"],
			[GENDER_MALE, "главный уходник", "носит маску даже дома"],
			[GENDER_MALE, "слесарь"],
			[GENDER_MALE, "хвост", "под надзором"],
			[GENDER_MALE, "гидротехник"],
			[GENDER_MALE, "радиовед", "также разбирается в крупной электронике"],
			[GENDER_MALE, "хвост", "в клетке за ибиение двух рабочих"],
			[GENDER_MALE, "системотехник"],
			[GENDER_FEMALE, "рабочая"],
			[GENDER_MALE, "инженер","ходит со странным амулетом. Устроить проверку"],
			[GENDER_MALE, "координатор сектора"],
			[GENDER_MALE, "картограф", "создаёт карты мест, куда никто не ходит"],
			[GENDER_MALE, "техник", "отсутствует левая рука"],
			[GENDER_MALE, "работник", "отрезано правое ухо"],
			[GENDER_MALE, "заправщик", "возможно имеет последствие"],
			[GENDER_MALE, "работник"],
			[GENDER_MALE, "таскальщик"],
			[GENDER_MALE, "эксперт по водоочистке"],
			[GENDER_FEMALE, null, "оформить в кабак"],
			[GENDER_MALE, "знахарь"],
			[GENDER_MALE, "хвост"],
			[GENDER_MALE, "хвост", "считает себя шляпкой гриба. Надзор"],
			[GENDER_MALE, "техник очистки", "бывший раб. Нет языка"],
			[GENDER_MALE, "мастер"],
			[GENDER_MALE, "протоколист"],
			[GENDER_MALE, "гриборуб", "не выпускать в пещеры. Возможно необходимо предложить другую работу"],
			[GENDER_MALE, "алхимик", "возможно продает нелегальные химикаты"],
			[GENDER_MALE, "охранный инженер"],
			[GENDER_MALE, "специалист по технике"],
			[GENDER_MALE, "механик"],
			[GENDER_MALE, "разводчик мельтешат", "плохое зрение"],
			[GENDER_MALE, "писарь", "проблемы со слухом"],
			[GENDER_MALE, "факелщик", "пребывание до первого предупреждения"],
			[GENDER_MALE, "координатор"],
			[GENDER_FEMALE, "техник аварийного доступа", "допуск к зонам: 3,4,5,5Б,8,14. Проход к пропускным ходам 10, 17, 19"],
			[GENDER_MALE, "чистилщик"],
			[GENDER_MALE, "охр", "проблемы с алкоголем"],
			[GENDER_MALE, "управляющий насосом"]
		],
		[
			["Архатил Вялов", "торгаш", "во владении имеет 2 бомжевозки"],
			["Варош Баваров", "охр", "приставлен к зоне бара Тушняк"],
			["Измур Дуччах", "охр", "временно приставлен в патруль к переулку 26"],
			["Дий Черный", "-", "поймать и допросить"],
			["Выха Забойщик", "рабочий", "алкоголик"],
			["Губан Мощин", "рабочий", "пристрастие к алкоголю"],
			["Иванур Володин", "ремонтник"],
			["Малим Паванин", "барник", "владелец бара Тушняк"],
			["Ибам Шнурок", null, "подозрительное общение. Проверка на ТОМность и исключительно временное пребывание"],
			["Карим Сухач", null, "грибовед. Продает грибы ближайшим городам"],
			[GENDER_MALE, "музыкант", "умеет играть на гармошке"],
			[GENDER_MALE, "работник", "на данный момент закреплен за мельтешиным складом"],
			[GENDER_MALE, "хвост", "в клетке за убийство курьера"],
			[GENDER_MALE, null, "пребывание до 4х смен"],
			[GENDER_MALE, "певец"],
			[GENDER_FEMALE, "работница"],
			[GENDER_MALE, "торговец"],
			[GENDER_FEMALE, null],
			[GENDER_MALE, null, "покинет город после восстановления в лекарне"],
			[GENDER_MALE, null, "жрец культа. Только временное пребывание - не более 2х смен."],
			[GENDER_MALE, null, "надзор"],
			[GENDER_FEMALE, "швея", "вышивает вещи, которых никто не видел"],
			[GENDER_MALE, "хирург", "работает только для высших членов города"],
			[GENDER_MALE, "истеричка", "впадает в истерику. Надзор"],
			["Агний Игралов", "таскальщик"],
			[GENDER_FEMALE, "танцовщица"],
			[GENDER_MALE, null, "пребывание не более 5 смен"],
			[GENDER_MALE, "помощник гриборуба"],
			[GENDER_MALE, "вахтёр"],
			[GENDER_MALE, "вахтёр", "временно заведующий пропускным ходом 14"],
			[GENDER_MALE, "хвост", "не чувствует боли"],
			[GENDER_MALE, null, "отсутствует левая рука"],
			[GENDER_MALE, "таскальщик"],
			[GENDER_FEMALE, "плакальщица", "плачет по живым"],
			[GENDER_MALE, "слухач"],
			[GENDER_MALE, "ведарь"],
			[GENDER_MALE, "вскрывалщик замков", "работа одобрена при присутствии охра и письменном разрешении владельца"],
			[GENDER_MALE, null, "проблемы со здоровьем"],
			[GENDER_MALE, "кожевеник", "слабоумие"],
			[GENDER_MALE, "работник", "дебильность. Надзор"],
			[GENDER_MALE, "работник", "слабоумие. Надзор"],
			[GENDER_MALE, "выжимальщик грибного масла"],
			[GENDER_MALE, "привратник"],
			[GENDER_MALE, "гость", "пребывание до 5 смен. Сопровождение до головинской."],
			[GENDER_MALE, null, "беженец. Боится открытых дверей"],
			[GENDER_FEMALE, "уходница", "носит фрагмент карты вшитый в кожу"],
			[GENDER_MALE, "труповед", "пишет о мертвых"],
			[GENDER_MALE, "ученик", "пишет на стенах"],
			[GENDER_MALE, "хвост"],
			[GENDER_FEMALE, "рабочая", "никто не нанимает. Временно приставлена к работе на бражном складе"],
			[GENDER_MALE, "тюремщик", "разрешено ношение холодного оружия"],
			[GENDER_FEMALE, "гадалка", "проверить психику у лекарей"],
			[GENDER_MALE, "рабочий", "недавно потерял руку на рабочем месте"],
			[GENDER_MALE, "смотрящий", "не помнит откуда пришёл. До первого предупреждения"],
			[GENDER_MALE, "архивный изгнанник"],
			[GENDER_FEMALE, "псаломщица", "поёт забытые имена"],
			[GENDER_MALE, null, "жмёт кнопки наугад"],
			[GENDER_FEMALE, "отшельница", "жила одна в шахте 3 плана. Следить за состоянием"],
			[GENDER_MALE, "повар", "может готовить без огня"],
			[GENDER_FEMALE, "спасённая", "вытянута из обвала"],
			[GENDER_MALE, null, "значится в реестре ранее посещавших. Причина ухода неизвестна. Надзор"],
			[GENDER_MALE, null, "оказалась в городе по ошибке"],
			[GENDER_MALE, "разнорабочий", "отлично работает с лопатой"],
			[GENDER_MALE, "факелщик", "выходит только в тёмные смены"],
			[GENDER_MALE, "слушатель"],
			[GENDER_MALE, null, "проход без ограничений. Сопровождение до смотрителя"],
			[GENDER_MALE, "рабочий", "иногда бредит. Проверить у лекаря"],
			[GENDER_MALE, null, "приходил 2 плана назад. Только временное пребывание"],
			[GENDER_MALE, "рабочий"],
			[GENDER_FEMALE, "учитель", "воспитывает 3х чужих детей"],
			[GENDER_MALE, "рыбовед","молчалив"],
			[GENDER_MALE, "жрица", "культистам только временное пребывание"]
		]
	];
	_itemContent = _itemContent apply {array_shuffle(_x)};

	for "_i" from 1 to 3 do {
		private _objName = "cpt3_obj_kart" + (str _i);
		private _obj = _objName call sp_getObject;
		if (count getVar(_obj,content) == 0) then {
			private _code = {
				params ["_obj","_x"];
				private _d = ["Documents",_obj,null,"all;expand"] call createItemInContainer;
				_namehash = (str randInt(1,999999)) + "-" + pick vec3("А","Б","В") + pick vec3("Р","Д","П");
				(_x call cpt4_func_genDescDocs) params ["_content","_namev"];
				modvar(_namehash)  + " [" + _namev + "]";
				setVar(_d,content,_content);
				setVar(_d,name,"Документ " + _namehash);
			};

			{
				[_obj,_x] call _code;
			} foreach (_itemContent select (_i-1));

			if (_i == 3) then {
				private _post = {
					[
						_this select 0,
						[callFuncParams(call sp_getActor,getNameEx,"кто"),"помощник вахтёра","встречал жруна в пещерах. Приставлен к пропускнопу пункту 17. Надзор"]
					] call (_this select 1)
				};
				invokeAfterDelayParams(_post,3,[_obj arg _code])
			};
		};
	};

	["cpt4_pos_start",0] call sp_setPlayerPos;
	call sp_initializeDefaultPlayerHandlers;
	[call sp_getActor] call sp_loadCharacterData;

	[sp_const_list_stdPlayerHandlers,false] call sp_setLockPlayerHandler;

	[{
        params ["_t","_wid"];
		false
    },{
		params ["_t","_wid"];
		false
	},{
		params ["_t","_wid"];
        if array_exists(interactMenu_selectionWidgets,_wid) exitWith {true};
		//if ("Глаза" == _t) exitWith {true};
		false
	}] call sp_gui_setInventoryVisibleHandler;

	["main_action",{
		params ["_t"];
		if (
			isTypeOf(_t,BaseElectronicDeviceLighting)
			&& getVar(_t,lightIsEnabled)
		) exitWith {
			true
		};
		false
	}] call sp_addPlayerHandler;
	["activate_verb",{
		params ["_t","_name"];
		if (
			isTypeOf(_t,BaseElectronicDeviceLighting)
			&& getVar(_t,lightIsEnabled)
			&& _name == "mainact"
		) exitWith {true};
		false
	}] call sp_addPlayerHandler;

	//отдавать кариму можно только когда есть transitem в sp_allowebVerbs
	["interact_with",{
		params ["_targ","_with"];
		if equals(_targ,"cpt4_karim" call sp_ai_getMobObject) exitWith {
			if not_equals(_with,cpt4_data_refLastTakenDoc) exitWith {true};
			!array_exists(sp_allowebVerbs,"transitem");
		};
		false
	}] call sp_addPlayerHandler;

	//отключаем сжигание бумаги
	["click_target",{
		params ["_targ"];
		private _r = false;
		private _with = callFunc(call sp_getActor,getItemInActiveHandRedirect);
		{
			_x params ["_a","_b"];
			if (isTypeOf(_a,IPaperItemBase) && callFunc(_b,isFireLight)) exitWith {
				[
					pick [
						"Так и до пожара дойдёт",
						"Я не буду устраивать поджог",
						"Зачем это делать?"
					],
					"error"
				] call chatPrint;
				_r = true;
			};
		} foreach [[_targ,_with],[_with,_targ]];
		_r
	}] call sp_addPlayerHandler;

	//запрет брать всё (небольшая задержка из-за ожидания ~рендера~ (NOE-загрузчика))
	_post = {
		{
			if isTypeOf(_x,IPaperItemBase) then {continue};
			if isTypeOf(_x,ItemWritter) then {continue};
			if isTypeOf(_x,IChairAsItem) then {continue};
			if isTypeOf(_x,Candle) then {continue};
			if isTypeOf(callFunc(_x,getObjectPlace),SmallWoodenTable) then {continue};
			
			sp_blacklistClickItems pushBack _x;
		} foreach (callFuncParams(call sp_getActor,getNearItems,20));
	}; invokeAfterDelay(_post,1);

	//выключаем надрезы ножом
	["click_self",{
        params ["_t"];
        if (isTypeOf(_t,Knife)) exitWith {
            _m = pick[
                "Я не буду себя резать.",
                "Что я творю?",
                "Это глупо.",
                "В этом нет необходимости.",
                "Зачем мне резать себя?",
                "Я не хочу это делать."
            ];
            callFuncParams(call sp_getActor,mindSay,_m);
            true
        };
        false
    }] call sp_addPlayerHandler;


	if isNullReference(callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH)) then {
		private _cloth = [cpt4_playerUniform,call sp_getActor,INV_CLOTH] call createItemInInventory;
		private _mon = ["Zvak",_cloth] call createItemInContainer;
		callFuncParams(_mon,initCount,5);
		
		//пока нельзя забирать звяки
	};

	_cloth = callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH);
	cpt4_internal_delegate_baseClothRemoveItem = getFunc(_cloth,removeItem);
	[callFunc(_cloth,getClassName),"removeItem",{
		objParams_3(_item,_newLoc,_slot);
		if isTypeOf(_item,Zvak) exitWith {
			callFuncParams(call sp_getActor,mindSay,"Мне не стоит доставать свои звяки сейчас...");
		};
		_this call cpt4_internal_delegate_baseClothRemoveItem;
	},"replace"] call oop_injectToMethod;
	
	[false,2] call setBlackScreenGUI;
	[cpt4_data_hudStatesDefault] call sp_view_setPlayerHudVisible;
	sp_allowebVerbs pushBack "standupfromchair";

	["cpt4_pos_enterkochevs","cpt4_karim",[
		["uniform","NomadCloth3"],
		["name",["Карим","Сухач"]],
		["age",34],
		["face",cpt4_data_karimFace]
	],{
		["ShuttleBag",_this,INV_HAND_L] call createItemInInventory;
		["Torch",_this,INV_HAND_R] call createItemInInventory;
		["CustomKnife",_this,INV_BELT] call createItemInInventory;
	}] call sp_ai_createPersonEx;	

	callFuncParams("RedButton G:NJnbP0kznrs" call sp_getObject,setEnable,false);
	_hndls = [
		["main_action",{
			params ["_t"];
			if not_equals(_t,"RedButton G:NJnbP0kznrs" call sp_getObject) exitWith {true};
			false
		}] call sp_addPlayerHandler,
		["activate_verb",{
			params ["_t","_name"];
			if not_equals(_t,"RedButton G:NJnbP0kznrs" call sp_getObject) exitWith {true};
			false
		}] call sp_addPlayerHandler
	];
	["cpt4_data_start_lightButtonEnableHandlers",_hndls] call sp_storageSet;


	{
		[cpt4_questName_begin,"Включите свет"] call sp_setTaskMessageEff;

		_bt = "RedButton G:NJnbP0kznrs" call sp_getObject;
		_rememberTime = tickTime + 15;
		{
			getVar(_bt,edIsEnabled)
			||  (tickTime >= _rememberTime)
		} call sp_threadWait;

		if (tickTime >= _rememberTime) then {
			if (!getVar(_bt,edIsEnabled)) then {
				_h = ["Для включения света нажмите $input_act_mainAction по #(кнопке) на стене"] call sp_setNotification;
				{getVar(_bt,edIsEnabled)} call sp_threadWait;
				[false,_h] call sp_setNotificationVisible;
			};
		};

		{
			_x call sp_removePlayerHandler;
		} foreach (["cpt4_data_start_lightButtonEnableHandlers",[]] call sp_storageGet);

		_h1act = ["main_action",{
			params ["_t"];
			[_t] call cpt4_internal_func_checkMainAction;
		}] call sp_addPlayerHandler;
		_h2act = ["activate_verb",{
			params ["_t","_name"];
			if (_name == "mainact") exitWith {
				[_t] call cpt4_internal_func_checkMainAction;
			};
			false
		}] call sp_addPlayerHandler;

		
		["vahta",true] call sp_audio_playMusic;
		1 call sp_threadPause;
		
		[cpt4_questName_begin,"Заполните отчет о посетителях"] call sp_setTaskMessageEff;
		["Сядьте на #(стул), нажав $input_act_mainAction по нему"] call sp_setNotification;
		
		{
			equals("cpt4_obj_chairbegin" call sp_getObject,getVar(call sp_getActor,connectedTo))
		} call sp_threadWait;
		1 call sp_threadPause;

		["На столе перед вами лежит #(папка). Это список посетителей - людей, которые пытались или прошли в город сегодня. Чтобы посмотреть имена посетителей - нажмите $input_act_mainAction по папке"] call sp_setNotification;

		{
			nd_isOpenDisplay && {equals(nd_openedDisplayType,"Paper")}
			&& {equals(nd_sourceRef,getVar("cpt4_obj_visitorlistpaper" call sp_getObject,pointer))}
		} call sp_threadWait;

		["Прочтите список посетителей и #(посчитайте), сколько из них было пропущено в город. Нажмите #(""Закрыть"") как будете готовы."] call sp_setNotification;
		{
			!nd_isOpenDisplay
		} call sp_threadWait;
		1 call sp_threadPause;

		["Вы можете писать на бумаге с помощью #(ручки) или любого пишущего предмета. Возьмите один #(лист бумаги) из стопки нажав по ней $input_act_mainAction"] call sp_setNotification;

		{
			callFuncParams(call sp_getActor,hasItem,"Paper")
		} call sp_threadWait;

		
		["Теперь возьмите #(ручку), и нажмите ЛКМ по листку бумаги. Сам листок при этом может быть во второй руке, либо лежать на столе."] call sp_setNotification;
		
		{
			callFuncParams(call sp_getActor,hasItem,"ItemWritter" arg true)
			&& nd_isOpenDisplay && {equals(nd_openedDisplayType,"Paper")}
		} call sp_threadWait;

		["Сейчас вы в режиме чтения. Чтобы начать писать нажмите на текст в верхней части листа #(""Записать"") - так вы перейдете в режим редактирования. Напишите, #(сколько человек прошло в город) за эту смену (числом или словом)."] call sp_setNotification;

		{
			_papers = callFuncParams(call sp_getActor,getNearObjects,"Paper" arg 3 arg false arg true);
			_papers append ([call sp_getActor,"Paper",false] call getAllItemsInInventory);
			private _found = false;
			{
				_found = [getVar(_x,content),"(5|пять|пятер|пято|пятю)"] call regex_isMatch;
				if (_found)exitWith{};
			} foreach _papers;
			_found
		} call sp_threadWait;
		
		["Отличная работа! Нажмите кнопку #(""Закрыть"")"] call sp_setNotification;
		{
			!nd_isOpenDisplay
		} call sp_threadWait;

		["Чтобы посмотреть что написано на бумаге нажмите по ней $input_act_mainAction"] call sp_setNotification;
		
		3 call sp_threadPause;
		[false] call sp_setNotificationVisible;

		[false] call sp_setNotificationVisible;
		["cpt4_act_koch1_arrived"] call sp_startScene;
		
	} call sp_threadStart;

}] call sp_addScene;

cpt4_data_canTakeDocPaper = false;
cpt4_data_refLastTakenDoc = nullPtr;

["cpt4_act_koch1_arrived",{

	["RedButton_Activator G:0BHVbZgUjcE",{
		_result = !cpt4_canOpenWindow
	}] call cpt4_addProcessorMainAct;

	["Tumbler_Activator G:hQrKBb16ltI",{
		_result = !cpt4_canOpenEnter
	}] call cpt4_addProcessorMainAct;

	private _porig = "cpt4_obj_paperdoc" call sp_getObject;
	private _c = getVar(_porig,content);
	setVar(_porig,content,[_c arg "ИГРОК" arg callFuncParams(call sp_getActor,getNameEx,"кем")] call stringReplace);

	["main_action",{
		params ["_t"];
		_ret = false;
		_ptarg = "cpt4_obj_papersrc" call sp_getObject;
		_porig = "cpt4_obj_paperdoc" call sp_getObject;
		if equals(_t,_ptarg) then {
			if (cpt4_data_canTakeDocPaper) then {
				["updown\paper_up"+str randInt(1,3),player modelToWorldVisual (player selectionPosition "head"),1,null,5,null,0] call soundGlobal_play;
				_pap = ["Paper",call sp_getActor] call createItemInInventory;
				cpt4_data_refLastTakenDoc = _pap;
				setVar(_pap,name,getVar(_porig,name));
				setVar(_pap,content,getVar(_porig,content));
				cpt4_data_canTakeDocPaper = false;
			} else {
				callFuncParams(call sp_getActor,"Я уже взял бланк" arg "error");
			};


			_ret = true;
		};
		_ret
	}] call sp_addPlayerHandler;
	["activate_verb",{
		params ["_t","_name"];
		_ret = false;
		if (_name == "mainact") then {
			_ptarg = "cpt4_obj_papersrc" call sp_getObject;
			_porig = "cpt4_obj_paperdoc" call sp_getObject;
			if equals(_t,_ptarg) then {
				if (cpt4_data_canTakeDocPaper) then {
					["updown\paper_up"+str randInt(1,3),player modelToWorldVisual (player selectionPosition "head"),1,null,5,null,0] call soundGlobal_play;
					_pap = ["Paper",call sp_getActor] call createItemInInventory;
					cpt4_data_refLastTakenDoc = _pap;
					setVar(_pap,name,getVar(_porig,name));
					setVar(_pap,content,getVar(_porig,content));
					cpt4_data_canTakeDocPaper = false;
				} else {
					callFuncParams(call sp_getActor,"Я уже взял бланк" arg "error");
				};

				_ret = true;
			};
		};
		_ret
	}] call sp_addPlayerHandler;

	{
		callFuncParams("cpt4_obj_radio1" call sp_getObject,playSound,"electronics\siren" arg 1.25 arg 20 arg 1.2 arg null arg false);
		
		1 call sp_threadPause;
		(["chap4\gg\vaht1_gg1"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
		0.5 call sp_threadPause;

		if !isNullReference(getVar(call sp_getActor,connectedTo)) then {
			private _h = ["Чтобы встать со стула нажмите $input_act_resist, либо через ПКМ меню, нажав по #(""Моей персоне"") и выбрав #(""Встать"")"] call sp_setNotification;
			{
				isNullReference(getVar(call sp_getActor,connectedTo))
			} call sp_threadWait;
			[false,_h] call sp_setNotificationVisible;
			1 call sp_threadPause;
		};

		[cpt4_questName_kochevs,"К городу подходит человек. Встречайте его и решите, достоин ли он пройти внутрь"] call sp_setTaskMessageEff;

		callFuncParams("cpt4_obj_doorbegin" call sp_getObject,setDoorLock,false arg false);

		cpt4_canOpenWindow = true;
		{getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)} call sp_threadWait;
		cpt4_canOpenWindow = false;

		//play anim
		["cpt4_karim" call sp_ai_getMobObject,"cpt4_pos_enterkochevs","cpt4_koch1_enter",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "acts_commenting_on_fight_loop";
		},[
			["state_1",{
				params ["_obj"];
				_empPos = _obj modelToWorld [0.2,0.3,0];
				_bag = [_obj,INV_HAND_L,_empPos] call sp_ai_moveItemToWorld;
				["cpt4_obj_bag1koch",_bag] call sp_storageSet;
			}]
		]] call sp_ai_playAnim;

		//for realistic dialog
		{("cpt4_karim" call sp_ai_getmobbody distance2d player <= 2.6)} call sp_threadWait;
		["cpt4_act_koch1_enter"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_trg_openwindow",{
	{
		_h = ["Нажмите на красную #(кнопку) под окном с помощью $input_act_mainAction, чтобы открыть окно регистрации"] call sp_setNotification;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch1_enter",{
	{
		([
			[player,"chap4\gg\vaht1_gg2",["endoffset",1]]   
			,["cpt4_karim","chap4\npc_vaht\koch1_1",["endoffset",0.5]] 
			,[player,"chap4\gg\vaht1_gg3"] 
			,["cpt4_karim","chap4\npc_vaht\koch1_2"] 
			,[player,"chap4\gg\vaht1_gg4"] 
			,["cpt4_karim","chap4\npc_vaht\koch1_3",[
				["endoffset",0.5],
				["onstart",{
					_knifePos = callFunc("cpt4_pos_knifekarimpos" call sp_getObject,getPos);
					_karim = "cpt4_karim" call sp_ai_getMobObject;
					_par1 = [_karim,INV_BELT,INV_HAND_L];
					invokeAfterDelayParams({_this call sp_ai_moveItemToMob},0.2,_par1);
					_par2 = [_karim,INV_HAND_L,_knifePos];
					_cde = {
						_dta = _this call sp_ai_moveItemToWorld;
						if !isNullVar(_dta) then {
							["cpt4_obj_knifetostore",_dta] call sp_storageSet;
						};
					}; invokeAfterDelayParams(_cde,2.9,_par2);
				}]
			]] 
			,[player,"chap4\gg\vaht1_gg5"]
		] call sp_audio_startDialog)
			call sp_audio_waitForEndDialog;
		1 call sp_threadPause;

		[cpt4_questName_kochevs,"Заберите нож на хранение, убрав его на один из красных стеллажей"] call sp_setTaskMessageEff;

		{
			_knife = ["cpt4_obj_knifetostore",nullPtr] call sp_storageGet;
			_plc = callFunc(_knife,getObjectPlace);
			!isNullReference(_plc) && {
				isTypeOf(_plc,BigRedEdgesRack)
			}
			|| {
				_r = [];
				_kpos = callFunc(_knife,getPos);
				{
					_r = [
						_kpos,_kpos vectoradd [0,0,-100],
						null,null,20,true,true
					] call si_getIntersectObjects;
				} call sp_threadCriticalSection;
				({isTypeOf(_x,BigRedEdgesRack)} count _r) > 0
			}
		} call sp_threadWait;

		sp_blacklistClickItems pushBackUnique (["cpt4_obj_knifetostore",nullPtr] call sp_storageGet);

		[cpt4_questName_kochevs,"Оформите пропуск кочевнику"] call sp_setTaskMessageEff;
		2 call sp_threadPause;
		(["chap4\gg\vaht1_gg6"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
		
		cpt4_data_canTakeDocPaper = true;
		["Возьмите #(бланк пропуска), нажав по стопке бланков $input_act_mainAction. Стопка бланков лежит на стеллаже #(слева от окна регистрации)"] call sp_setNotification;

		
		{
			!cpt4_data_canTakeDocPaper
		} call sp_threadWait;
		private _origContent = getVar(cpt4_data_refLastTakenDoc,content);
		sp_allowebVerbs append ["transitem"];		
		
		["Подпишите пропуск именем #(""Карим Сухач"")"] call sp_setNotification;
		
		{
			not_equals(_origContent,getVar(cpt4_data_refLastTakenDoc,content))
		} call sp_threadWait;

		_handlerWid = [{
            _wid = widgetNull;
            {
                if equals(ctrltext _x,"Левая рука") exitWith {_wid = _x};
            } foreach interactMenu_selectionWidgets;
            _wid
        }] call sp_createWidgetHighlight;

		["Отдайте пропуск кочевнику. Для этого нажмите $input_act_inventory, выберите в области взаимодействия руку, в которую будем отдавать предметы и перетащите на него пропуск из вашей руки. Либо нажмите ПКМ и выберите #(""Передать пропуск"")"] call sp_setNotification;

		_karim = "cpt4_karim" call sp_ai_getMobObject;
		_pap = nullPtr;
		while {true} do {
			_pap = callFuncParams(_karim,getItemInSlotRedirect,INV_HAND_L);
			if isNullReference(_pap) then {
				0.5 call sp_threadPause;
				continue;
			};

			1.2 call sp_threadPause;
			{
				callFuncParams(_pap,onMainAction,_karim);
				[getVar(_karim,owner)] call anim_syncAnim;
			} call sp_threadCriticalSection;
			
			3.5 call sp_threadPause;
			{
				callFuncParams(_pap,closeNDisplayServer,_karim);
				[getVar(_karim,owner)] call anim_syncAnim;
			} call sp_threadCriticalSection;

			private _content = "";
			if isTypeOf(_pap,Paper) then {
				_content = getVar(_pap,content);
			};

			if (
				[tolower _content,"(карим\s*сухач|сухач\s*карим)"] call regex_isMatch
			) exitWith {};

			_knifePos = callFunc("cpt4_pos_knifekarimpos" call sp_getObject,getPos) vectoradd [rand(-0.1,0.1),rand(-0.1,0.1),0];
			[_karim,INV_HAND_L,_knifePos] call sp_ai_moveItemToWorld;
			{
				callFuncParams(_karim,playSound, "emotes\sigh_male" arg 0.92);
				callFuncParams(_karim,meSay,"мотает головой");
			} call sp_threadCriticalSection;
			["Вы неправильно заполнили пропуск. Возьмите новый и напишите на нём имя кочевника - #(""Карим Сухач"")"] call sp_setNotification;
			cpt4_data_canTakeDocPaper = true;
			3 call sp_threadPause;
		};
		
		("cpt4_karim" call sp_ai_getMobBody) switchmove "";
		["cpt4_karim",player] call sp_ai_setLookAtControl;
		_emotepost = {
			callFuncParams("cpt4_karim" call sp_ai_getMobObject,meSay,"одобрительно кивает");
		}; invokeAfterDelay(_emotepost,0.7);

		array_remove(sp_allowebVerbs,"transitem");
		refset(_handlerWid,true);
		1.8 call sp_threadPause;
		
		{
			callFuncParams("cpt4_karim" call sp_ai_getMobObject,meSay,"прячет пропуск в карман");
		} call sp_threadCriticalSection;

		{
			[_pap] call deleteGameObject;
		} call sp_threadCriticalSection;
		
		["cpt4_act_koch1_exit"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch1_exit",{
	
	{
		["Откройте входную дверь, повернув #(рычаг) на стене слева от окна регистрации"] call sp_setNotification;
		cpt4_canOpenEnter = true;
		{
			getVar(cpt4_gref_doorenter call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenEnter = false;
		["cpt4_karim",objNull] call sp_ai_setLookAtControl;
		[false] call sp_setNotificationVisible;

		_karimMob = "cpt4_karim" call sp_ai_getMobObject;
		_karimPos = getposatl getVar(_karimMob,owner);
		[_karimMob,_karimPos,"cpt4_koch1_exit",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "acts_commenting_on_fight_loop";
			["cpt4_act_koch1_done",true] call sp_storageSet;
		},[
			["state_1",{
				params ["_obj"];
				[_obj,["cpt4_obj_bag1koch",nullPtr] call sp_storageGet,INV_HAND_L] call sp_ai_moveItemToMob;
			}]
		]] call sp_ai_playAnim;

		{
			["cpt4_act_koch1_done",false] call sp_storageGet
		} call sp_threadWait;

		{
			["cpt4_karim"] call sp_ai_deletePerson;
		} call sp_threadCriticalSection;

		[cpt4_questName_kochevs,"Возвращайтесь в свой кабинет"] call sp_setTaskMessageEff;

		{
			callFuncParams(cpt4_gref_doorenter call sp_getObject,setDoorOpen,false arg true);
		} call sp_threadCriticalSection;
		0.3 call sp_threadPause;
		{
			callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
		} call sp_threadCriticalSection;

		["cpt4_act_koch2_prepare"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch2_prepare",{
	
	callFuncParams("cpt4_obj_doorbegin" call sp_getObject,setDoorLock,false arg false);

	{
		{
			callFuncParams("cpt4_obj_radio1" call sp_getObject,getDistanceTo,call sp_getActor arg true)
			<= 3
		} call sp_threadWait;
		[true] call sp_setHideTaskMessageCtg;
		
		3 call sp_threadPause;

		callFuncParams("cpt4_obj_radio1" call sp_getObject,playSound,"electronics\siren" arg 1.25 arg 20 arg 1.2 arg null arg false);
		1.5 call sp_threadPause;

		[cpt4_questName_kochevs,"Встречайте очередного посетителя"] call sp_setTaskMessageEff;

		{
			["cpt4_pos_enterkochevs","cpt4_ibam",[
				["name",["Ибам","Шнурок"]],
				["uniform","NomadCloth8"],
				["age",26],
				["face","face09_baf"]
			],{
				["WoolCoat",_this,INV_BACK] call createItemInInventory;
				["Candle",_this,INV_HAND_L] call createItemInInventory;
			}] call sp_ai_createPersonEx;
		} call sp_threadCriticalSection;

		[true] call sp_setHideTaskMessageCtg;

		cpt4_canOpenWindow = true;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenWindow = false;
		["cpt4_store_ibam_actions",0] call sp_storageSet;

		"cpt4_ibam" call sp_ai_waitForMobLoaded;
		{
			["cpt4_ibam" call sp_ai_getMobObject,"cpt4_pos_enterkochevs","cpt4_koch2_enter",{
				params ["_mob"];
				[_mob,getposatl _mob,null] call sp_ai_setMobPos;
				_mob switchmove "acts_jetscrewaidf_idle2";
				["cpt4_store_ibam_actions",{_this + 1}] call sp_storageUpdate;	
			}] call sp_ai_playAnim;
		} call sp_threadCriticalSection;


		//before because dynamic dialog
		{("cpt4_ibam" call sp_ai_getmobbody distance2d player <= 2.6)} call sp_threadWait;
		([
			[player,"chap4\gg\vaht2_gg1"]   
			,["cpt4_ibam","chap4\npc_vaht\koch2_1",["endoffset",0.5]] 
			,[player,"chap4\gg\vaht2_gg2"]
			,["cpt4_ibam","chap4\npc_vaht\koch2_2",["endoffset",0.5]]
			,[player,"chap4\gg\vaht2_gg3"]
			,["cpt4_ibam","chap4\npc_vaht\koch2_3",["endoffset",0.2]]
			,[player,"chap4\gg\vaht2_gg4",["onstart",{
				[cpt4_questName_kochevs,"Решите стоит ли пропускать его в город"] call sp_setTaskMessageEff;
			}]]
		] call sp_audio_startDialog)
			call sp_audio_waitForEndDialog;
		
		{(["cpt4_store_ibam_actions",0] call sp_storageGet) >= 1} call sp_threadWait;

		["cpt4_act_koch2_enter"] call sp_startScene;

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_screamerTOM",{
	_d = getGUI;
	_txtlist = [];
	_provideText = {
		params ["_sizeX","_sizeY","_count","_sizeMod"];
		for "_i" from 1 to _count do {
			_w = [_d,TEXT,[rand(0,100-_sizeX),rand(0,100-_sizeY),_sizeX,_sizeX]] call createWidget;
			widgetFadeNow(_w,1);
			[_w,format["<t align='center' size='%1' font='Ringbear' color='#d11534'>ТОМНЫЙ</t>",_sizeMod]] call widgetSetText;
			_txtlist pushBack _w;
		};
	};

	[8,5,100,1] call _provideText;
	[15,8,50,2] call _provideText;
	[30,20,10,4] call _provideText;
	
	_mainback = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;
	_mainback setBackgroundColor [0,0,0,1];
	widgetFadeNow(_mainback,1);

	_cdesnd = { ["chap4\scream",0.7] call sp_audio_sayPlayer; };
	invokeAfterDelay(_cdesnd,0.05);

	{
		_x setFade 0;
		_cde = { 
			_this commit rand(0.1,0.5);
			[0,1.5,0.001,0.2] call cam_addCamShake;
			startAsyncInvoke
			{
				if !isNullReference(_this) then {
					(_this call widgetGetPosition) params ["_curX","_curY"];
					[_this,[_curX + rand(-0.1,0.1),_curY + rand(-0.1,0.1)],0] call widgetSetPositionOnly
				};
				isNullReference(_this)
			},
			{},
			_this
			endAsyncInvoke
		};
		invokeAfterDelayParams(_cde,rand(0.2,1),_x);
	} foreach _txtlist;
	[0.04,0.1,0.08,8] call cam_addCamShake;

	_cend = { 
		[{
			params ["_txtlist","_mainback"];

			for "_i" from 1 to 3 do {
				_tent = rand(0.05,0.2);
				_text = rand(0.05,0.2);
				
				widgetSetFade(_mainback,0,_tent);
				_tent call sp_threadPause;
				
				widgetSetFade(_mainback,1,_text);
				_text call sp_threadPause;
			};
			
			widgetSetFade(_mainback,0,0.2);
			0.3 call sp_threadPause;
			{{[_x] call deleteWidget} foreach _txtlist;} call sp_threadCriticalSection;
			
			widgetSetFade(_mainback,1,0.2);
			1 call sp_threadPause;
			[_mainback,true] call deleteWidget; 
		},_this] call sp_threadStart;
	};
	invokeAfterDelayParams(_cend,4.2,[_txtlist arg _mainback]);
	
}] call sp_addScene;

["cpt4_act_koch2_enter",{
	{		
		1 call sp_threadPause;
		
		cpt4_data_canTakeDocPaper = true;

		_hreg = ["Люди, использующие странные слова в речи могут быть #(опасны). Решите - пропустить кочевника или отказать в пропуске."
		+ sbr + "Если решите пропустить его - оформите #(пропуск) на имя #(""Ибам Шнурок"") и положите перед ним на стол. В ином случае просто нажмите #(красную кнопку), чтобы закрыть окно регистрации."] call sp_setNotification;

		["cpt4_data_rejectIbam",false] call sp_storageSet;
		["main_action",{
			params ["_t"];
			if equals(_t,"RedButton_Activator G:0BHVbZgUjcE" call sp_getObject) exitWith {
				call sp_removeCurrentPlayerHandler;
				["cpt4_data_rejectIbam",true] call sp_storageSet;
				false//because cpt4_canOpenWindow = false
			};
			false
		}] call sp_addPlayerHandler;
		//cpt4_canOpenWindow = true;

		["cpt4_act_ibam_result",0] call sp_storageSet;
		_tOnClose = {
			
			("cpt4_ibam" call sp_ai_getMobBody) switchmove "HubStandingUC_idle2";
			_ibam = "cpt4_ibam" call sp_ai_getMobObject;
			
			_knifePos = callFunc("cpt4_pos_knifekarimpos" call sp_getObject,getPos) vectoradd [0.15,rand(-0.05,0.1),0];
			_it = [_ibam,INV_HAND_L,_knifePos] call sp_ai_moveItemToWorld;

			//{!getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)} call sp_threadWait;
			{["cpt4_data_rejectIbam",false] call sp_storageGet} call sp_threadWait;
			_postclose = {
				callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
			}; invokeAfterDelay(_postclose,1.5);

			if (callFuncParams("cpt4_ibam" call sp_ai_getMobObject,getDistanceTo,_it arg true) <= 2.5) then {
				[_ibam,_it,INV_HAND_L] call sp_ai_moveItemToMob;
			};

			//speak ibam
			([
				["cpt4_ibam","chap4\npc_vaht\koch2_bad",["distance",40]]
			] call sp_audio_startDialog) call sp_audio_waitForEndDialog;
			//4 call sp_threadPause;
			{["cpt4_ibam"] call sp_ai_deletePerson} call sp_threadCriticalSection;
			["cpt4_act_ibam_result",-1] call sp_storageSet;
		} call sp_threadStart;
		
		_tOnEnter = {
			_ibam = "cpt4_ibam" call sp_ai_getMobObject;
			_ibamPos = getposatl getVar(_ibam,owner);
			_tpaper = nullPtr;
			_takenPapers = [];
			while {true} do {
				if isNullReference(cpt4_data_refLastTakenDoc) then {
					0.5 call sp_threadPause;
					continue;
				};
				_tpaper = cpt4_data_refLastTakenDoc;
				_nearPapers = callFuncParams(_ibam,getNearObjects,"Paper" arg 2 arg false arg true);
				if (
					!array_exists(_nearPapers,_tpaper)
					|| {array_exists(_takenPapers,_tpaper)}
				) then {
					0.5 call sp_threadPause;
					continue;
				};
				if equals(callFunc(_tpaper,getLastTouched),_ibam) exitWith {
					0.5 call sp_threadPause;
					continue;
				};

				1.2 call sp_threadPause;
				[_ibam,_tpaper,INV_HAND_R] call sp_ai_moveItemToMob;
				_takenPapers pushBackUnique _tpaper;
				1 call sp_threadPause;

				{
					callFuncParams(_tpaper,onMainAction,_ibam);
					[getVar(_ibam,owner)] call anim_syncAnim;
				} call sp_threadCriticalSection;
				
				3.5 call sp_threadPause;
				{
					callFuncParams(_tpaper,closeNDisplayServer,_ibam);
					[getVar(_ibam,owner)] call anim_syncAnim;
				} call sp_threadCriticalSection;

				//exit because success name write
				if (
					[tolower getVar(_tpaper,content),"(ибам\s*шнурок|шнурок\s*ибам)"] call regex_isMatch
					|| sp_debug
				) exitWith {};

				_knifePos = callFunc("cpt4_pos_knifekarimpos" call sp_getObject,getPos) vectoradd [rand(-0.1,0.1),rand(-0.1,0.1),0];
				[_ibam,INV_HAND_R,_knifePos] call sp_ai_moveItemToWorld;
				["Вы неправильно написали его имя. Возьмите новый и напишите на нём имя кочевника - #(""Ибам Шнурок"")"] call sp_setNotification;
				
				cpt4_data_canTakeDocPaper = true;
				1 call sp_threadPause;
			};

			_ht = ["Теперь можно открыть проход в город, нажав на #(рычаг)"] call sp_setNotification;
			cpt4_canOpenEnter = true;
			{
				getVar(cpt4_gref_doorenter call sp_getObject,isOpen)
			} call sp_threadWait;
			cpt4_canOpenEnter = false;
			[false,_ht] call sp_setNotificationVisible;

			[
				["cpt4_ibam","chap4\npc_vaht\koch2_good",["distance",40]]
			] call sp_audio_startDialog;

			[_ibam,_ibamPos,"cpt4_koch2_exit",{
				params ["_mob"];
				[_mob,getposatl _mob,null] call sp_ai_setMobPos;
				_mob switchmove "acts_commenting_on_fight_loop";
				["cpt4_act_koch2_done",true] call sp_storageSet;

				["cpt4_ibam"] call sp_ai_deletePerson;
			}] call sp_ai_playAnim;

			{["cpt4_act_koch2_done",false] call sp_storageGet} call sp_threadWait;

			["cpt4_act_ibam_result",1] call sp_storageSet;
		} call sp_threadStart;

		_threads = [_tOnClose,_tOnEnter];

		{(["cpt4_act_ibam_result",0] call sp_storageGet) != 0} call sp_threadWait;
		cpt4_canOpenWindow = false;
		cpt4_data_canTakeDocPaper = false;
		[false] call sp_setNotificationVisible;
		{[_x] call sp_threadStop} foreach _threads;

		{
			if (getVar(cpt4_gref_doorenter call sp_getObject,isOpen)) then {
				callFuncParams(cpt4_gref_doorenter call sp_getObject,setDoorOpen,false arg true);
			};
		} call sp_threadCriticalSection;
		0.4 call sp_threadPause;
		{
			if (getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)) then {
				callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
			};
		} call sp_threadCriticalSection;

		["cpt4_act_koch3_prepare"] call sp_startScene;
		

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch3_prepare",{
	callFuncParams("cpt4_obj_doorbegin" call sp_getObject,setDoorLock,false arg false);

	{
		[cpt4_questName_kochevs,"Возвращайтесь к заполнению отчёта"] call sp_setTaskMessageEff;
		
		{
			callFuncParams("cpt4_obj_radio1" call sp_getObject,getDistanceTo,call sp_getActor arg true)
			<= 3
		} call sp_threadWait;
		[true] call sp_setHideTaskMessageCtg;
		
		1 call sp_threadPause;

		callFuncParams("cpt4_obj_radio1" call sp_getObject,playSound,"electronics\siren" arg 1.25 arg 20 arg 1.2 arg null arg false);
		1.5 call sp_threadPause;

		[cpt4_questName_kochevs,"Вернитесь к окну регистрации"] call sp_setTaskMessageEff;

		//========== tombomz
		{
			["cpt4_pos_enterkochevs","cpt4_tombomz",[
				["age",44],
				["name",["Бомж","Нормальнышек"]],
				["uniform","Castoffs2"],
				["face","face12_ep1"]
			]] call sp_ai_createPersonEx;
		} call sp_threadCriticalSection;

		//========== armyguy
		{
			["cpt4_pos_armyattacktom","cpt4_tombomz_armyguy",[
				["uniform","StreakCloth"],
				["age",24],
				["name",["Выха","Штрих"]],
				["face","asianhead_a3_05"]
			],{
				["Gasmask",_this,INV_FACE] call createItemInInventory;
				["ShortSword",_this,INV_HAND_R] call createItemInInventory;
				callFunc(_this,switchTwoHands);
			}] call sp_ai_createPersonEx;
			
		} call sp_threadCriticalSection;

		cpt4_canOpenWindow = true;
		{
			getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)
		} call sp_threadWait;
		cpt4_canOpenWindow = false;
		[true] call sp_setHideTaskMessageCtg;

		["cpt4_tombomz" call sp_ai_getMobObject,"cpt4_pos_enterkochevs","cpt4_koch3_enter",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			_mob switchmove "amovpknlmstpsnonwnondnon";
		}] call sp_ai_playAnim;

		//dynamic audio
		{("cpt4_tombomz" call sp_ai_getmobbody distance2d player <= 2.8)} call sp_threadWait;

		([
			["cpt4_tombomz","chap4\npc_vaht\koch3_1",["endoffset",0.2]] 
			,[player,"chap4\gg\vaht3_gg1",["endoffset",1.3]]
			,["cpt4_tombomz","chap4\npc_vaht\koch3_2",["endoffset",0.5]]  
			,[player,"chap4\gg\vaht3_gg2",["endoffset",1.3]]   
			,["cpt4_tombomz","chap4\npc_vaht\koch3_3",["endoffset",1]] 
			,[player,"chap4\gg\vaht3_gg3",[
				["endoffset",1.7],
				["onstart",{
					[true,true] call sp_audio_setMusicPause;
			
					_post = {
						[] call sp_audio_stopMusic;
						[!true,true] call sp_audio_setMusicPause;
					};
					invokeAfterDelay(_post,5);
				}]
			]]
			,["cpt4_tombomz","chap4\npc_vaht\koch3_4",["endoffset",1.5]]
			,[player,"chap4\gg\vaht3_gg4",["endoffset",1.3]]
			,["cpt4_tombomz","chap4\npc_vaht\koch3_5",["endoffset",2.6]]
			,[player,"chap4\gg\vaht3_gg5",[
				["endoffset",0.2],
				["onstart",{
					_post = {
						["cpt4_act_screamerTOM"] call sp_startScene;
					};
					invokeAfterDelay(_post,4.4);
				}]
			]]		
		] call sp_audio_startDialog)
			call sp_audio_waitForEndDialog;
		
		[
			["cpt4_tombomz","chap4\npc_vaht\koch3_6",["endoffset",2.6]]
		] call sp_audio_startDialog;
		["cpt4_act_koch3_enter"] call sp_startScene;

		//for test
		//["cpt4_act_koch3_enter"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_koch3_enter",{
	{
		

		["Люди, которые ведут себя странно и говорят непонятные слова - больны болезнью #(Тоннельного Образа Мышления) (в народе - ТОМность)."
		+sbr + "Избегайте любых контактов с ними, так как #(ТОМность заразна). Если у вас есть силы и возможность - облегчите муки болезненного, прервав его жизнь."
		] call sp_setNotification;

		["cpt4_obj_radio2","chap4\speaker\speak1",50] call sp_audio_sayAtTarget;

		["cpt4_tombomz_armyguy" call sp_ai_getMobObject,"cpt4_pos_armyattacktom","cpt4_armygettom",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
		},[
			["state_1",{
				params ["_obj"];
				
				[true]	call sp_setHideTaskMessageCtg;

				callFuncParams(_obj getvariable "link",setCombatMode,true);

				["cpt4_tombomz",callFunc("cpt4_tombomz" call sp_ai_getMobObject,getPos),"cpt4_koch3_gettom",{
					params ["_mob"];
					[_mob,getposatl _mob,null] call sp_ai_setMobPos;
				}] call sp_ai_playAnim;
			}],
			["state_2",{
				["cpt4_act_tomdie",true] call sp_storageSet;
			}]
		]] call sp_ai_playAnim;

		{["cpt4_act_tomdie",false] call sp_storageGet} call sp_threadWait;
		{
			if (getVar(cpt4_gref_doorwindow call sp_getObject,isOpen)) then {
				callFuncParams(cpt4_gref_doorwindow call sp_getObject,setDoorOpen,false arg true);
			};
		} call sp_threadCriticalSection;
		
		2 call sp_threadPause;
		
		[false] call sp_setNotificationVisible;
		{
			["cpt4_tombomz"] call sp_ai_deletePerson;
			["cpt4_tombomz_armyguy"] call sp_ai_deletePerson;
		} call sp_threadCriticalSection;

		3 call sp_threadPause;
		//speaker activate GODO med
		(["cpt4_obj_radio2","chap4\speaker\speak2",50] call sp_audio_sayAtTarget) call sp_audio_waitForEndSound;
		2 call sp_threadPause;

		{
			["cpt4_act_gotomed_begin"] call sp_startScene;
		} call sp_threadCriticalSection;

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_gotomed_begin",{
	callFuncParams("cpt4_obj_doortomed" call sp_getObject,setDoorOpen,true);

	[cpt4_questName_tomed,"Отправляйтесь на медицинское обследование"] call sp_setTaskMessageEff;

	["cpt4_pos_armyfrommeds","cpt4_armyguy1",[
		["name",["Охр","Исимбар"]],
		["uniform","CaretakerCloth"],
		["face","face58"]
	]] call sp_ai_createPersonEx;
	["cpt4_pos_armyfrommeds","cpt4_armyguy2",[
		["name",["Младший Охр","Акептис"]],
		["uniform","StreakCloth"],
		["face","face07"]
	],{
		["Baton",_this,INV_HAND_R] call createItemInInventory;
	}] call sp_ai_createPersonEx;

	
}] call sp_addScene;

//event started anim army guys
cpt4_trg_gotomed_act = false;
["cpt4_trg_gotomed",{
	if (cpt4_trg_gotomed_act) exitWith {};
	cpt4_trg_gotomed_act = true;

	{
		"cpt4_armyguy1" call sp_ai_waitForMobLoaded;
		"cpt4_armyguy2" call sp_ai_waitForMobLoaded;

		["cpt4_armyguy1","cpt4_pos_armyfrommeds","cpt4_gotomed1",{
			params ["_mob"];
			[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			["cpt4_armyguy1",player] call sp_ai_setLookAtControl;
			["cpt4_act_gotomed_dialog_start",true] call sp_storageSet;
		},[
			["state_1",{
				callFuncParams("cpt4_obj_doorarmyguys" call sp_getObject,setDoorOpen,true);
			}]
		]] call sp_ai_playAnim;
		_after = {
			["cpt4_armyguy2","cpt4_pos_armyfrommeds","cpt4_gotomed2",{
				params ["_mob"];
				[_mob,getposatl _mob,null] call sp_ai_setMobPos;
			}] call sp_ai_playAnim;
		};
		invokeAfterDelay(_after,2);
	} call sp_threadStart;
	
	{
		{["cpt4_act_gotomed_dialog_start",false] call sp_storageGet} call sp_threadWait;
		
		([
			["cpt4_armyguy1","chap4\npc_vaht\armytomed_1",["endoffset",0.2]],
			[player,"chap4\gg\armytomed_gg1",["endoffset",0.7]],
			["cpt4_armyguy1","chap4\npc_vaht\armytomed_2",["endoffset",0.2]]
		] call sp_audio_startDialog)
			call sp_audio_waitForEndDialog;
		
		2 call sp_threadPause;

		[true] call sp_setHideTaskMessageCtg;
		[false] call sp_setNotificationVisible;
		[""] call sp_view_setPlayerHudVisible;
		[true,1.5] call setBlackScreenGUI;

		2 call sp_threadPause;
		//black screen
		["cpt4_armyguy1"] call sp_ai_deletePerson;
		["cpt4_armyguy2"] call sp_ai_deletePerson;

		[] call sp_audio_stopMusic;

		{
			["cpt4_tobar"] call sp_startScene;
		} call sp_threadCriticalSection;
	} call sp_threadStart;
}] call sp_addTriggerEnter;

["cpt4_tobar",{
	{
		{
			["cpt4_pos_cutscenetobar","player_cutscene",[
				["uniform",cpt4_playerUniform]
			],{
				callFuncParams("cpt4_obj_medtobarchair" call sp_getObject,seatConnect,_this);
				callFuncParams(_this,setMobFace,callFunc(call sp_getActor,getMobFace));
			},{
				invokeAfterDelay({("player_cutscene" call sp_ai_getMobBody) switchmove "re_HubSittingChairC_idle1"},0.1);
			}] call sp_ai_createPersonEx;

			["cpt4_pos_cutscenelekar","cpt4barlek",[
				["uniform","DoctorCloth"]
			],{},{
				_this switchmove "Acts_Briefing_Intro3_Major_1";
				[_this,player] call sp_ai_setLookAtControl;
				{
					_body = "cpt4barlek" call sp_ai_getMobBody;
					while {!isNullReference(_body)} do {
						_body setRandomlip true;
						rand(0.2,0.4) call sp_threadPause;
						_body setRandomlip false;
						rand(0.4,0.8) call sp_threadPause;
					};
				} call sp_threadStart;
			}] call sp_ai_createPersonEx;

			["cpt4_pos_cutsceneohr","cpt4barohr",[
				["name",["Охр","Исимбар"]],
				["uniform","CaretakerCloth"],
				["face","face58"]
			],{
				["RifleFinisher",_this] call createItemInInventory;
				callFunc(_this,switchTwoHands);
			},{
				_this switchmove "Acts_A_M01_briefing";
				[_this,player] call sp_ai_setLookAtControl;
			}] call sp_ai_createPersonEx;


		} call sp_threadCriticalSection;

		[true] call sp_cam_setCinematicCam;
		[true] call sp_gui_setCinematicMode;
		["vr",[4152.96,3809.78,17.8719],270.399,0.59,[-26.5285,0],0,0,720,0.0524573,0,1,0,1] call sp_cam_prepCamera;
		
		"player_cutscene" call sp_ai_waitForMobLoaded;
		"cpt4barlek" call sp_ai_waitForMobLoaded;
		"cpt4barohr" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		["transition2"] call sp_audio_playMusic;
		["all",["vr",[4152.96,3809.78,16.7719],269.477,0.8,[-8.80887,0],0,0,720,0.0524573,0,1,0,1],35] call sp_cam_interpTo;
		[false,5] call sp_gui_setBlackScreenGUI;
		15 call sp_threadPause;
		[true,5] call sp_gui_setBlackScreenGUI;
		[false] call sp_cam_setCinematicCam;
		[false] call sp_gui_setCinematicMode;
		call sp_cam_stopAllInterp;

		["cpt4_bar_begin"] call sp_startScene;
	} call sp_threadStart;
	
}] call sp_addScene;

/*
---------------------------------------------------------------------------------------------------------
 												BAR STAGE
---------------------------------------------------------------------------------------------------------


cpt4_pos_p2player - pos for playerspawn

citywalkers:
cpt4_pos_citywalker1 - above gate
cpt4_pos_citywalker2 - abobe bumcar

cpt4_pos_poorman - poor man

cpt4_pos_bomzcar - bum mob
cpt4_pos_bomzowner - bum owner (merchant)

ohr-walker
cpt4_pos_ohrwalk1

cpt4_pos_barsmoker1
cpt4_pos_barsmoker2
---- guys with sigarets


bar:
cpt4_pos_brodyaga_bar - sitter
	cpt4_obj_barsit_brod
cpt4_pos_barnik - barkeeper

cpt4_pos_barkarim - karim inside bar
	cpt4_obj_bar_karimsit - sit

cpt4_pos_bar_aloguys - 3 sits


*/

cpt4_data_playerHandlerNamesOnCutscene = ["item_action","main_action","open_inventory"];
cpt4_func_setLockPlayerInteract = {
	params ["_lock"];
	{
		[_x,_lock] call sp_setLockPlayerHandler;
	} foreach cpt4_data_playerHandlerNamesOnCutscene;
};


["cpt4_bar_begin",{
	["cpt4_pos_p2player",0] call sp_setPlayerPos;
	["chat+right+stats+cursor+inv"] call sp_view_setPlayerHudVisible;

	{
		_texData = [0,"#(rgb,512,512,3)text(1,1,""Caveat"",0.15,""#00000000"",""#2b1b0ddf"",""/\\nлекарня\n< ПХ-17            \nБар ''Тушняк''>\n  Жилая зона>"")"];
		_ref = getVar("cpt4_obj_signinfoboard" call sp_getObject,pointer);
		_objReal = objNull;
		while {isNullReference(_objReal)} do {
			_obj = noe_client_allPointers getOrDefault [_ref,objNull];
			if isNullReference(_obj) then {
				1 call sp_threadPause;
				continue;
			};
			_objReal = "signad_sponsors_f" createVehicleLocal [0,0,0];
			_objReal setposatl getposatl _obj;
			_objReal setVectorDirAndUp [vectorDir _obj,vectorUp _obj];
			_objReal setObjectTexture _texData;
			break;
		};

		{
			[_ref] call deleteGameObject;
		} call sp_threadCriticalSection;
	} call sp_threadStart;

	_post = {
		{
			if isTypeOf(_x,IPaperItemBase) then {continue};
			
			
			
			sp_blacklistClickItems pushBack _x;
		} foreach (callFuncParams(call sp_getActor,getNearItems,100) - [
			"cpt4_obj_barbottle" call sp_getObject,
			"cpt4_obj_barcup" call sp_getObject
		]);
	}; invokeAfterDelay(_post,1);

	//prep mobs
	["cpt4_pos_barlekar","cpt4_barlekar",[
		["uniform","DoctorCloth"],
		["name",["Лекарь"]]
	],{},{
		_this switchMove "Acts_Accessing_Computer_Loop";
	}] call sp_ai_createPersonEx;

	// ========== лекари ========
	["cpt4_pos_barlekar2","cpt4_barlekar2",[
		["uniform","DoctorCloth"],
		["name",["Лекарь"]]
	],{
		private _item = callFuncParams(_this,getPart,BP_INDEX_ARM_R);		
		callFuncParams(_item,unlink,null arg true);
	},{
		_this switchMove "Acts_GetAttention_Loop";
	}] call sp_ai_createPersonEx;

	// ========== ходуны на заднем фоне ==========
	for "_i" from 1 to 3 do {
		_pos = "cpt4_pos_farwalker" + (str _i);
		_anm = "cpt4_farwalk" + (str _i);
		[_pos,_pos + "_mobref",[
			["uniform","CitizenCloth6"],
			["name",["Мужик"]]
		],{},{}] call sp_ai_createPersonEx;

		_uniformChanger = {
			params ["_mob"];
			_formClass = pick["CitizenCloth" + (str randInt(1,22)),(pick["Green","Yellow","BlackPlaid","BluePlaid","WhitePlaid"])+"Coat"
			//,"AbbatCloth" - script error
			];

			_mob forceAddUniform getFieldBaseValue(_formClass,"armaClass");
		};

		[_pos + "_mobref",
			[
				[_pos,_anm + "_start",{rand(5,10)},_uniformChanger],
				[_pos + "_end",_anm + "_end",{rand(5,10)},_uniformChanger]
			]
		] call sp_ai_playAnimsLooped;

		//inverted mobs
		[_pos + "_end",_pos + "_mobref_invert",[
			["uniform","CitizenCloth6"],
			["name",["Мужик"]]
		],{},{}] call sp_ai_createPersonEx;

		[_pos + "_mobref_invert",
			[
				[_pos + "_end",_anm + "_end",{rand(5,10)},_uniformChanger],
				[_pos,_anm + "_start",{rand(5,10)},_uniformChanger]
			]
		] call sp_ai_playAnimsLooped;

	};


	["cpt4_pos_citywalker1","cpt4_citywalker1",[
		["uniform","CitizenCloth3"]
	],{
		["SleevelessOuterwear1",_this,INV_ARMOR] call createItemInInventory;
		["Sigarette",_this,INV_FACE] call createItemInInventory;
	}] call sp_ai_createPersonEx;

	["cpt4_pos_citywalker2","cpt4_citywalker2",[
		["uniform","CitizenCloth8"]
	]] call sp_ai_createPersonEx;

	["cpt4_pos_poorman","cpt4_poorman",[
		["uniform","Castoffs3"],
		["name",["Доходяга"]],
		["face","playerhead_white1"]
	],{
		private _item = callFuncParams(_this,getPart,BP_INDEX_ARM_L);		
		callFuncParams(_item,unlink,null arg true);
	},{
		_this switchMove "passenger_boat_4_idle_unarmed";
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barsmoker1","cpt4_barsmoker1",[
		["uniform","TorgashPalthCloth"]
	],{
		["Sigarette",_this,INV_FACE] call createItemInInventory;
	}, { _this switchMove "acts_commenting_on_fight_loop" }] call sp_ai_createPersonEx;
	["cpt4_pos_barsmoker2","cpt4_barsmoker2",[
		["uniform","WhitePlaidCoat"]
	],{
		["Sigarette",_this,INV_FACE] call createItemInInventory;
	}, { _this switchMove "hubbriefing_ext_contact" }] call sp_ai_createPersonEx;

	["cpt4_pos_bomzcar","cpt4_bomzcar",[
		["uniform","Castoffs1"],
		["name",["Бомжара","Тянульщик"]],
		["face","face29"]
	],{
		
	},{ _this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop"; }] call sp_ai_createPersonEx;

	["cpt4_pos_bomzowner","cpt4_bomzowner",[
		["uniform","ZnatCloth"],
		["name",["Архатил","Вялов"]],
		["face","face73"]
	],{
		
	}, { _this switchMove "Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop" }] call sp_ai_createPersonEx;

	["cpt4_pos_ohrwalk1","cpt4_ohrwalk1",[
		["uniform","StreakCloth"],
		["name",["Охр","Варош"]],
		["face","greekhead_a3_12"]
	],{
		["ShortSword",_this,INV_BELT] call createItemInInventory;
	}] call sp_ai_createPersonEx;

	["cpt4_pos_ohrstand","cpt4_ohrstand1",[
		["uniform","StreakCloth"],
		["name",["Охр","Измур"]],
		["face","face17_ep1"]
	],{
		["Baton",_this,INV_BELT] call createItemInInventory;
	},{
		_this switchMove "Acts_JetsCrewaidR_idle_m";
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barstrangeman","cpt4_barstrangeman",[
		["uniform","HeadCloth"],
		["name",["Дий","Черный"]],
		["face","face16_ep1"]
	],{},{[_this, player] call sp_ai_setLookAtControl; _this enableMimics false}] call sp_ai_createPersonEx;

	//-------------------------- bar spawn -------------------
	["cpt4_pos_bar_alсoguys","cpt4_bar_alсoguys1",[
		["uniform","ZnatCloth"],
		["name",["Выха","Забойщик"]],
		["face","face123_pmc"],
		["age",36]
	],{
		callFuncParams("cpt4_obj_barsit_party1" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;
	["cpt4_pos_bar_alсoguys","cpt4_bar_alсoguys2",[
		["uniform","GreatcoatWhiteBrown"],
		["name",["Губан","Мощин"]],
		["face","face109_pmc"],
		["age",23]
	],{
		callFuncParams("cpt4_obj_barsit_party2" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;
	["cpt4_pos_bar_alсoguys","cpt4_bar_alсoguys3",[
		["uniform","GreenCoat"],
		["name",["Иванур","Володин"]],
		["face","livonianhead_1"],
		["age",32]
	],{
		callFuncParams("cpt4_obj_barsit_party3" call sp_getObject,seatConnect,_this);
		("cpt4_bar_alсoguys3" call sp_ai_getMobBody) switchMove "HubSittingAtTableU_idle3";
	}] call sp_ai_createPersonEx;

	["cpt4_pos_brodyaga_bar","cpt4_brodyaga_bar",[
		["uniform","GreenJacketCloth"],
		["name",["Алкашня",""]],
		["face","face08"]
	],{
		callFuncParams("cpt4_obj_barsit_brod" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barnik","cpt4_bar_barnik",[
		["uniform","CookerCloth"],
		["name",["Барник","Малим"]],
		["face","nc_head2"],
		["age",38]
	],{
		
	}] call sp_ai_createPersonEx;

	["cpt4_pos_barkarim","cpt4_karim",[
		["uniform","NomadCloth3"],
		["name",["Карим","Сухач"]],
		["age",34],
		["face",cpt4_data_karimFace]
	],{
		callFuncParams("cpt4_obj_bar_karimsit" call sp_getObject,seatConnect,_this);
	}] call sp_ai_createPersonEx;

	//main handle
	{
		1 call sp_threadPause;
		[false,1.5] call setBlackScreenGUI;
		3 call sp_threadPause;

		([
			[player,"chap4\gg\prebar_gg1"],
			[player,"chap4\gg\prebar_gg2"],
			[player,"chap4\gg\prebar_gg3"]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		[cpt4_questName_tobar,"Идите в бар"] call sp_setTaskMessageEff;

	} call sp_threadStart;
}] call sp_addScene;

cpt4_trg_barstartmusic_act = false;
["cpt4_trg_barstartmusic",{
	if (cpt4_trg_barstartmusic) exitWith {};
	cpt4_trg_barstartmusic = true;
	["city",true] call sp_audio_playMusic;
}] call sp_addTriggerEnter;

["cpt4_trg_nearbumcar",{
	if (!isNullReference("cpt4_obj_bomzcar" call sp_getObject)) then {
		{
			_h = ["Дорогу к вашему дому перекрывает #(бомжевозка). Отдохните в баре - скоро путь освободится."] call sp_setNotification;
			7.5 call sp_threadPause;
			[false,_h] call sp_setNotificationVisible;
		} call sp_threadStart;
	};
}] call sp_addScene;

["cpt4_trg_barstartanims",{	
	//looped state of ohrwalk
	_anims = {
		["cpt4_ohrwalk1",
			[
				["cpt4_pos_ohrwalk1","cpt4_bar_ohrwalk1",{rand(10,15)},{ params ["_obj"]; _obj switchMove "Acts_Kore_IdleNoWeapon_loop"}],
				["cpt4_pos_ohrwalk2","cpt4_bar_ohrwalk2",{rand(10,15)},{ params ["_obj"]; _obj switchMove "Acts_Kore_IdleNoWeapon_loop"}]
			]
		] call sp_ai_playAnimsLooped;

		["cpt4_citywalker1","cpt4_pos_citywalker1","cpt4_bar_citywalker1"] call sp_ai_playAnim;
		["cpt4_citywalker2","cpt4_pos_citywalker2","cpt4_bar_citywalker2",{
			_mob = "cpt4_citywalker2" call sp_ai_getMobObject;
			callFuncParams("cpt4_obj_barnearmed_bench" call sp_getObject,seatConnect,_mob);
		}] call sp_ai_playAnim;
	};
	invokeAfterDelay(_anims,2);
}] call sp_addScene;

cpt4_bar_musicProc = false;
cpt4_bar_musicUpdateReq = false;
if !isNull(cpt4_bar_musicHandle) then {
	stopUpdate(cpt4_bar_musicHandle);
};
cpt4_bar_musicHandle = -1;
if !isNull(cpt4_bar_curMusicPlayed) then {
	if equalTypes(cpt4_bar_curMusicPlayed,objNull) then {
		deleteVehicle cpt4_bar_curMusicPlayed;
	} else {
		stopSound (cpt4_bar_curMusicPlayed);
	};
};
cpt4_bar_curMusicPlayed = -1;
cpt4_bar_curMusicStartTime = 0;
cpt4_bar_curMusicDist = 10;
cpt4_bar_curMusicName = "";

["cpt4_trg_barhallway",{
	cpt4_bar_curMusicDist = 8;
	cpt4_bar_musicUpdateReq = true;
}] call sp_addTriggerEnter;

["cpt4_trg_bazone",{
	cpt4_bar_curMusicDist = 14;
	cpt4_bar_musicUpdateReq = true;

	[true,true] call sp_audio_setMusicPause;
}] call sp_addTriggerEnter;

["cpt4_trg_bazone",{
	cpt4_bar_curMusicDist = 8;
	cpt4_bar_musicUpdateReq = true;

	if (["cpt4_data_drinksuccess",false] call sp_storageGet) then {
		if !(["cpt4_data_barnik_9_played",false] call sp_storageGet) then {
			["cpt4_data_barnik_9_played",true] call sp_storageSet;
			([
				["cpt4_bar_barnik","chap4\npc_bar\barnik_9",["distance",50]]
			] call sp_audio_startDialog);
		};
	};

}] call sp_addTriggerExit;

["cpt4_trg_bumbar",{
	["cpt4_poorman" call sp_ai_getMobBody, player] call sp_ai_setLookAtControl;
}] call sp_addTriggerEnter;
["cpt4_trg_bumbar",{
	["cpt4_poorman" call sp_ai_getMobBody, objNull] call sp_ai_setLookAtControl;
}] call sp_addTriggerExit;

["cpt4_trg_bardoor",{
	//start bar handle
	
	if (!cpt4_bar_musicProc) then {
		cpt4_bar_musicProc = true;
		_mlist = [
			"chap4\radios\bar_radio1",
			"chap4\radios\bar_radio2",
			"chap4\radios\bar_radio3",
			"chap4\radios\bar_radio4",
			"chap4\radios\bar_radio5",
			"chap4\radios\bar_radio6",
			"chap4\radios\bar_radio7"
		];
		private _fnc = {
			(_this select 0) params ["_mlist"];
			if(isgamepaused) exitWith {};
			if (!cpt4_bar_musicProc) exitWith {
				stopThisUpdate();
			};

			if (cpt4_bar_musicUpdateReq && {not_equals(cpt4_bar_curMusicPlayed,-1) && not_equals(cpt4_bar_curMusicPlayed,objNull)}) then {
				cpt4_bar_musicUpdateReq = false;
				//_startTime = (soundParams cpt4_bar_curMusicPlayed) select 3;
				
				_prevhandler = cpt4_bar_curMusicPlayed;
				if (equalTypes(_prevhandler,objNull)) then {
					deleteVehicle _prevhandler;
				} else {
					stopSound _prevhandler;
				};
				if (!(_prevhandler call sp_audio_isSoundHandleDone)) then {
					warningformat("Sound not stopped at task: %1",_prevhandler);
					startAsyncInvoke
						{
							params ["_v","_t"];
							warningformat("Attempt to stop: %1",_v);
							if (equalTypes(_v,objNull)) then {
								deleteVehicle _v;
							} else {
								stopSound _v;
							};
							_v call sp_audio_isSoundHandleDone
						},
						{
							warningformat("Sound stopped: %1 time %2",_this select 0 arg tickTime - (_this select 1));
						},
						[_prevhandler,tickTime]
					endAsyncInvoke
					// [_prevhandler]SPAWN {uisleep 0.01;stopSound (_this select 0)};
				};
				
				_startTime = tickTime - cpt4_bar_curMusicStartTime; //new offset
				cpt4_bar_curMusicPlayed = [
					"cpt4_obj_barradio",cpt4_bar_curMusicName,cpt4_bar_curMusicDist,_startTime
				] call sp_audio_sayAtTarget;

				//[format["update mus: %1 (%2m) dur: %3",cpt4_bar_curMusicName,cpt4_bar_curMusicDist,_startTime]] call chatPrint;

				assert_str(_prevhandler call sp_audio_isSoundHandleDone,"music handle not null: " + (str cpt4_bar_curMusicPlayed) + "; " + (str ifcheck(equalTypes(cpt4_bar_curMusicPlayed,objNull),cpt4_bar_curMusicPlayed,soundParams cpt4_bar_curMusicPlayed)) );
			};

			if (cpt4_bar_curMusicPlayed call sp_audio_isSoundHandleDone) then {
				_m = _mlist deleteAt 0;
				_mlist pushBack _m;
				cpt4_bar_curMusicName = _m;
				
				cpt4_bar_curMusicPlayed = ["cpt4_obj_barradio",_m,cpt4_bar_curMusicDist,
					//!errors... ifcheck(cpt4_bar_curMusicPlayed==-1,30,0) //first time offset
					0 
				] call sp_audio_sayAtTarget;
				cpt4_bar_curMusicStartTime = tickTime;

				//[format["start mus: %1 (%2m)",cpt4_bar_curMusicName,cpt4_bar_curMusicDist]] call chatPrint;
			};
		};
		cpt4_bar_musicHandle = startUpdateParams(_fnc,0,[_mlist]);
	};

	[false,true] call sp_audio_setMusicPause;

	cpt4_bar_curMusicDist = 0.5;
	cpt4_bar_musicUpdateReq = true;
}] call sp_addTriggerEnter;

["cpt4_trg_barenter",{
	
	//radlist: chap4\radios\bar_radio3.ogg
	private _distance = 10;
	//["cpt4_obj_barradio","chap4\radios\bar_radio1",_distance] call sp_audio_sayAtTarget;
}] call sp_addScene;

cpt4_func_alcoDrinkProcess_forthread = {
	params ["_cupName","_alcoName",["_prepause",[10,30]],["_codecondition",{true}],["_drinkCount",1]];
	randInt(_prepause select 0,_prepause select 1) call sp_threadPause; //first time delay

	_alcoObj = _alcoName call sp_ai_getMobObject;

	_cupObj = (_cupName) call sp_getObject;
	_cupDefPos = callFunc(_cupObj,getPos);
	if equals(_codecondition,"once") then {
		_codecondition = { __called == 0 };
	};
	__called = 0;
	while _codecondition do {					
		
		//взять кружку
		[_alcoObj,_cupObj,INV_HAND_R] call sp_ai_moveItemToMob;

		//выждать время
		rand(1.2,1.8) call sp_threadPause;

		//глотаем глотки
		for "_i" from 1 to randInt(1,_drinkCount) do {
			_mes = pick[
				"алкашится",
				"алкашится из кружки",
				"квасит",
				"квасит из кружки",
				"упивается",
				"упивается брагой",
				"пьёт",
				"пьёт из кружки",
				"бухает",
				"бухает из кружки",
				"делает глоток",
				"подбухивает",
				"выпивает"
			];
			{
				callFuncParams(_alcoObj,meSay,_mes arg "act");
				callFuncParams(_alcoObj,playSound,"mob\drink" arg getRandomPitch);
			} call sp_threadCriticalSection;
			rand(0.8,1.6) call sp_threadPause;
		};

		rand(1,3) call sp_threadPause;

		//ставим кружку
		[_alcoObj,_cupObj,_cupDefPos vectorAdd vec3(rand(-0.05,0.05),rand(-0.05,0.05),0)] call sp_ai_moveItemToWorld;

		//отдых
		randInt(30,80) call sp_threadPause;
		INC(__called);
	}
};

["cpt4_trg_alcoguys_talk",{
	{
		([
			["cpt4_bar_alсoguys3","chap4\npc_bar\alcoguy_1",[["endoffset",1.5],["distance",50]]],
			["cpt4_bar_alсoguys2","chap4\npc_bar\alcoguy_2",[["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		_thds = [];
		for "_i" from 1 to 3 do {
			_thds pushBack ([{
				params ["_i"];
				_cupObj = ("cpt4_obj_barcup" + (str _i)) call sp_getObject;
			
				_cupDefPos = callFunc(_cupObj,getPos);

				_alcoName = "cpt4_bar_alсoguys" + (str _i);
				_alcoObj = _alcoName call sp_ai_getMobObject;

				rand(0.8,1.4) call sp_threadPause;

				//взять кружку
				[_alcoObj,_cupObj,INV_HAND_R] call sp_ai_moveItemToMob;

				//выждать время
				rand(0.6,1.4) call sp_threadPause;

				//глотаем глотки
				for "_i" from 1 to randInt(2,4) do {
					_mes = pick[
						"алкашится из кружки",
						"квасит брагу",
						"упивается",
						"упивается брагой",
						"пьёт из кружки",
						"бухает брагу"
					];
					{
						callFuncParams(_alcoObj,meSay,_mes arg "act");
						callFuncParams(_alcoObj,playSound,"mob\drink" arg getRandomPitch);
					} call sp_threadCriticalSection;
					rand(0.8,1.6) call sp_threadPause;
				};

				if (_alcoName == "cpt4_bar_alсoguys1") then {
					_awaiter = [];
					{
						_awaiter = [["cpt4_bar_alсoguys1","chap4\npc_bar\alcoguy_3",["distance",50]]] call sp_audio_startDialog;
					} call sp_threadCriticalSection;
					_awaiter call sp_audio_waitForEndDialog;
				};

				//ставим кружку
				[_alcoObj,_cupObj,_cupDefPos vectorAdd vec3(rand(-0.05,0.05),rand(-0.05,0.05),0)] call sp_ai_moveItemToWorld;

			},[_i]] call sp_threadStart);
		};

		{
			all_of(_thds apply {_x call sp_threadWaitForEnd})
		} call sp_threadWait;

		

		{
			callFuncParams("cpt4_bar_alсoguys1" call sp_ai_getMobObject,getDistanceTo,call sp_getActor arg true)
			<= 1.4
		} call sp_threadWait;

		[["cpt4_bar_alсoguys1","chap4\npc_bar\alcoguy_4",["distance",50]]] call sp_audio_startDialog;

		//looped state
		for "_i" from 1 to 3 do {
			[{
				params ["_i"];
				randInt(5,20) call sp_threadPause; //first time delay

				_alcoName = "cpt4_bar_alсoguys" + (str _i);
				_alcoObj = _alcoName call sp_ai_getMobObject;

				_cupObj = ("cpt4_obj_barcup" + (str _i)) call sp_getObject;
				_cupDefPos = callFunc(_cupObj,getPos);
				while {true} do {					
					
					//взять кружку
					[_alcoObj,_cupObj,INV_HAND_R] call sp_ai_moveItemToMob;

					//выждать время
					rand(1.2,1.8) call sp_threadPause;

					//глотаем глотки
					for "_i" from 1 to randInt(1,3) do {
						_mes = pick[
							"алкашится из кружки",
							"квасит брагу",
							"упивается",
							"упивается брагой",
							"пьёт из кружки",
							"бухает брагу"
						];
						{
							callFuncParams(_alcoObj,meSay,_mes arg "act");
							callFuncParams(_alcoObj,playSound,"mob\drink" arg getRandomPitch);
						} call sp_threadCriticalSection;
						rand(0.8,1.6) call sp_threadPause;
					};

					rand(1,3) call sp_threadPause;

					//ставим кружку
					[_alcoObj,_cupObj,_cupDefPos vectorAdd vec3(rand(-0.05,0.05),rand(-0.05,0.05),0)] call sp_ai_moveItemToWorld;

					//отдых
					randInt(20,60) call sp_threadPause;
				}

			},[_i]] call sp_threadStart;
		};

	} call sp_threadStart;
}] call sp_addScene;

["cpt4_trg_barkarim_talk",{
	{
		([
			["cpt4_karim","chap4\npc_bar\karim_1",[["endoffset",0.1],["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		{
			equals(getVar(call sp_getActor,connectedTo),"cpt4_obj_barseat_karimdialog" call sp_getObject)
		} call sp_threadWait;

		sp_canResist = false;

		[cpt4_func_alcoDrinkProcess_forthread,["cpt4_obj_cupforkarim","cpt4_karim",[0,0],"once"]] call sp_threadStart;

		1.2 call sp_threadPause;

		([
			["cpt4_karim","chap4\npc_bar\karim_2",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\karmitalk_gg1",["endoffset",0.1]],
			["cpt4_karim","chap4\npc_bar\karim_3",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\karmitalk_gg2",["endoffset",0.1]],
			["cpt4_karim","chap4\npc_bar\karim_4",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\karmitalk_gg3",[["endoffset",1.1],["onstart",{
				[cpt4_func_alcoDrinkProcess_forthread,["cpt4_obj_cupforkarim","cpt4_karim",[0.5,1],"once"]] call sp_threadStart;
			}]
			]],
			["cpt4_karim","chap4\npc_bar\karim_5",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\karmitalk_gg4",["endoffset",0.1]],
			["cpt4_karim","chap4\npc_bar\karim_6",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\karmitalk_gg5",["endoffset",0.7]],
			["cpt4_karim","chap4\npc_bar\karim_7",[["endoffset",0.1],["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		sp_canResist = true;
		_h = ["Чтобы #(встать) со стула нажмите $input_act_resist, либо через ПКМ меню, нажав по ""Моей персоне"" и выбрав ""Встать""."] call sp_setNotification;
		{
			not_equals(getVar(call sp_getActor,connectedTo),"cpt4_obj_barseat_karimdialog" call sp_getObject)
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;

		([
			["cpt4_karim","chap4\npc_bar\karim_8",[["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		[cpt4_func_alcoDrinkProcess_forthread,["cpt4_obj_cupforkarim","cpt4_karim",[2,5],null,3]] call sp_threadStart;

	} call sp_threadStart;
}] call sp_addScene;

cpt4_internal_brodyagaDrink_threadHandle = sp_threadNull;

["cpt4_trg_barmainroom",{
	{
		if not_equals(cpt4_internal_brodyagaDrink_threadHandle,sp_threadNull) then {
			[cpt4_internal_brodyagaDrink_threadHandle] call sp_threadStop;	
		};
		cpt4_internal_brodyagaDrink_threadHandle = [cpt4_func_alcoDrinkProcess_forthread,["cpt4_obj_cupforbrodyaga","cpt4_brodyaga_bar"]] call sp_threadStart;

		["cpt4_bar_barnik",player] call sp_ai_setLookAtControl;
		([
			["cpt4_bar_barnik","chap4\npc_bar\barnik_1",["distance",50]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		[cpt4_questName_tobar,"Сядьте за барную стойку и закажите выпивку"] call sp_setTaskMessageEff;
		
		{
			equals(getVar(call sp_getActor,connectedTo),"cpt4_obj_barchair_forplayer" call sp_getObject);
		} call sp_threadWait;

		//disable standup
		sp_canResist = false;

		//! BAR ENTER EVENT
		{
			callFuncParams("cpt4_obj_doorbarmain" call sp_getObject,setDoorOpen,false arg true);
			callFuncParams("cpt4_obj_doorbarmain" call sp_getObject,setDoorLock,true arg false);
		} call sp_threadCriticalSection;

		//delete objects
		{
			["cpt4_obj_wallpostbar" call sp_getObject] call deleteGameObject;
			["cpt4_obj_bomzcar" call sp_getObject] call deleteGameObject;
			["cpt4_bomzcar"] call sp_ai_deletePerson;
			["cpt4_bomzowner"] call sp_ai_deletePerson;

			["cpt4_barsmoker1"] call sp_ai_deletePerson;
			["cpt4_barsmoker2"] call sp_ai_deletePerson;

			_cw = "cpt4_citywalker1";
			[_cw,"cpt4_pos_citywalker1_after",0] call sp_ai_setMobPos;
			(_cw call sp_ai_getMobBody) switchmove "passenger_bench_1_Idle_Unarmed_Idling";
		} call sp_threadCriticalSection;

		//dialog 
		["cpt4_bar_barnik" call sp_ai_getMobBody,player] call sp_ai_setLookAtControl;
		([
			["cpt4_bar_barnik","chap4\npc_bar\barnik_2",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\barmentalk_gg1",["endoffset",0.1]],
			["cpt4_bar_barnik","chap4\npc_bar\barnik_3",[["endoffset",0.1],["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		{
			private _cloth = callFuncParams(call sp_getActor,getItemInSlot,INV_CLOTH);
			[callFunc(_cloth,getClassName),"removeItem",cpt4_internal_delegate_baseClothRemoveItem,"replace"] call oop_injectToMethod;
		} call sp_threadCriticalSection;

		["Достаньте из кармана свои деньги - #(звяки), взяв их в руки"] call sp_setNotification;

		private _handitems = [];
		{
			_handitems = [INV_HAND_L,INV_HAND_R] apply {
				isTypeOf(callFuncParams(call sp_getActor,getItemInSlotRedirect,_x),Zvak)
			};
			any_of(_handitems);
		} call sp_threadWait;

		["Чтобы разделить #(звяки), нажмите $input_act_mainAction по ним пустой рукой. Разделите #(3 звяка) и выложите на барную стойку"] call sp_setNotification;

		_barnik = "cpt4_bar_barnik" call sp_ai_getMobObject;
		private _moneyList = [];
		{
			private _amount = 0;
			{
				if (_amount + getVar(_x,stackCount) <= 3) then {
					_moneyList pushBack _x;
					_amount = _amount + getVar(_x,stackCount);
				};
			} foreach callFuncParams(_barnik,getNearObjects,"Zvak" arg 1.5 arg false arg true);
			
			if (_amount != 3) then {
				_moneyList resize 0;
			};

			_amount == 3
		} call sp_threadWait;

		[false] call sp_setNotificationVisible;

		if (count _moneyList > 0) then {
			1.2 call sp_threadPause;
			
			{
				[_barnik,_x,INV_HAND_R] call sp_ai_moveItemToMob;
				0.3 call sp_threadPause;
				{
					[_x] call deleteGameObject;
				} call sp_threadCriticalSection;
			} foreach _moneyList;
			["cpt4_bar_barnik" call sp_ai_getMobBody,objNull] call sp_ai_setLookAtControl;
			
			//talk
			1 call sp_threadPause;
			{
				//[_money] call deleteGameObject;
				[true] call cpt4_func_setLockPlayerInteract;
				
				[
					["cpt4_bar_barnik","chap4\npc_bar\barnik_4",[["endoffset",0.1],["distance",50]]]
				] call sp_audio_startDialog;

				["cpt4_bar_barnik","cpt4_pos_barnik","cpt4_bar_barnik1",{
					params ["_obj"];
					{
						_obj = "cpt4_bar_barnik" call sp_ai_getMobObject;
						_pos = callFunc("cpt4_pos_bar_itemdrinkloc" call sp_getObject,getPos);
						[_obj,INV_HAND_L,_pos vectoradd [0.1,0,0]] call sp_ai_moveItemToWorld;
						0.8 call sp_threadPause;
						[_obj,INV_HAND_R,_pos vectoradd [-0.1,0,0]] call sp_ai_moveItemToWorld;
						
						["cpt4_act_drinklearn"] call sp_startScene;
					} call sp_threadStart;
					
				},[
					["state_1",{
						params ["_obj"];
						[_obj,"cpt4_obj_barbottle" call sp_getObject,INV_HAND_L] call sp_ai_moveItemToMob;
					}],
					["state_2",{
						params ["_obj"];
						[_obj,"cpt4_obj_barcup" call sp_getObject,INV_HAND_R] call sp_ai_moveItemToMob;
					}],
					["state_3",{
						//not used
					}]
				]] call sp_ai_playAnim;
			} call sp_threadCriticalSection;

		};
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_drinklearn",{
	
	["cpt4_data_drinkcount",0] call sp_storageSet;
	["cpt4_data_drinksuccess",false] call sp_storageSet;
	{
		while {!(["cpt4_data_drinksuccess",false] call sp_storageGet)} do {
			pp_alc_amount = ["cpt4_data_drinkcount",0] call sp_storageGet;
			0.1 call sp_threadPause;
		};
	} call sp_threadStart;
	["click_self",{
		params ["_targ"];
		if callFunc(_targ,isReagentContainer) then {
			if (callFunc(_targ,getFilledSpace) > 0
			&&
			getVar(call sp_getActor,curTargZone) == TARGET_ZONE_MOUTH
			) then {
				_nval = ["cpt4_data_drinkcount",{_this + getVar(_targ,curTransferSize)}] call sp_storageUpdate;
				if (_nval >= 30) then {
					call sp_removeCurrentPlayerHandler;
					["cpt4_data_drinksuccess",true] call sp_storageSet;
				};
			};
		};
		false
	}] call sp_addPlayerHandler;
	{
		//dialog
		([
			["cpt4_bar_barnik","chap4\npc_bar\barnik_5",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\barmentalk_gg2",["endoffset",0.1]],
			["cpt4_bar_barnik","chap4\npc_bar\barnik_6",[["endoffset",0.1],["distance",50]]],
			[player,"chap4\gg\barmentalk_gg3",["endoffset",0.1]],
			["cpt4_bar_barnik","chap4\npc_bar\barnik_7",[
				["endoffset",1.2],
				["distance",50],
				["onstart",{
					("cpt4_bar_barnik" call sp_ai_getMobBody) switchMove "acts_pointingleftunarmed";
				}]
			]],
			[player,"chap4\gg\barmentalk_gg4",["endoffset",0.1]],
			["cpt4_bar_barnik","chap4\npc_bar\barnik_8",[["endoffset",0.1],["distance",50]]]
		] call sp_audio_startDialog) call sp_audio_waitForEndDialog;

		[cpt4_questName_tobar,"Отдыхайте..."] call sp_setTaskMessageEff;

		[false] call cpt4_func_setLockPlayerInteract;

		["cpt4_bar_barnik","cpt4_pos_barnik","cpt4_bar_barnik2",{
			//onend
			params ["_body"];
			_body switchmove "inbasemoves_table1";
		},[
			["state_1",{
				[{(["cpt4_data_drinkcount",0] call sp_storageGet) >= 10}] call sp_ai_animWait;
			}],
			["state_2",{
				[{(["cpt4_data_drinkcount",0] call sp_storageGet) >= 15}] call sp_ai_animWait;

			}]
		]
		] call sp_ai_playAnim;
		

		_h = ["Питьё жидкостей работает по аналогии с поеданием. Чтобы #(налить) брагу в кружку нажмите ЛКМ бутылкой по ней. Выберите область взаимодействия ""Рот"" и нажмите ЛКМ с кружкой в руке по кнопке ""Моя персона"". "
		+"Для регулирования #(размера глотка и объема переливания) нажмите $input_act_mainAction по емкости для жидкости"] call sp_setNotification;
		{
			["cpt4_data_drinksuccess"] call sp_storageGet
		} call sp_threadWait;
		[false,_h] call sp_setNotificationVisible;

		//restore standup from chairs
		sp_canResist = true;

		if !isNullReference(getVar(call sp_getActor,connectedTo)) then {
			1 call sp_threadPause;
			_h = ["Чтобы #(встать) со стула нажмите $input_act_resist, либо через ПКМ меню, нажав по ""Моей персоне"" и выбрав ""Встать""."] call sp_setNotification;
			{
				isNullReference(getVar(call sp_getActor,connectedTo))
			} call sp_threadWait;
			[false,_h] call sp_setNotificationVisible;
		};

		["cpt4_act_gotohome"] call sp_startScene;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_act_gotohome",{
	{
		callFuncParams("cpt4_obj_doorbarmain" call sp_getObject,setDoorLock,false arg false);

		{
			{
				_bobj = "cpt4_brodyaga_bar" call sp_ai_getMobObject;
				callFuncParams(_bobj,isEmptySlot,INV_HAND_R)
				&& callFuncParams(_bobj,isEmptySlot,INV_HAND_L)
			} call sp_threadWait;
			[cpt4_internal_brodyagaDrink_threadHandle] call sp_threadStop;
			4 call sp_threadPause;
			callFuncParams("cpt4_brodyaga_bar" call sp_ai_getMobObject,meSay,"лениво поднимается со стула");
			callFuncParams("cpt4_obj_barsit_brod" call sp_getObject,seatDisconnect,0);
			["cpt4_brodyaga_bar","cpt4_pos_brodyaga_bar","cpt4_bar_brodyaga_away",{
				params ["_body"];
				{
					

					for "_ind" from 1 to 6 do {
						rand(5,20) call sp_threadPause;
						{
							private this = "cpt4_brodyaga_bar" call sp_ai_getMobObject;
							private _vomitDuration = rand(2,5);
							private _vparams = [getSelf(owner),"SLIGHT_MOB_VOMIT" call lightSys_getConfigIdByName,
								["bubbleseffect","Memory"] //"head"
								,_vomitDuration];
							{
								callFuncParams(_x,sendInfo,"do_fe_mob" arg _vparams);
							} foreach callSelfParams(getNearMobs,20 arg false);
							_m = pick [
								"блююёт",
								"рыгается",
								"рвётся",
								"трясётся и блюется",
								"выблёвывает выпитое"
							];
							callSelfParams(meSay,_m);
							callSelfParams(playEmoteSound,"vomit");

							callSelfParams(setMobFaceAnim,'dead');
							callSelfAfter(syncMobFaceAnim,_vomitDuration);
							
						} call sp_threadCriticalSection;
					};

					callFuncParams("cpt4_brodyaga_bar" call sp_ai_getMobObject,setUnconscious,10000000);
					//hardcoded pos
					["cpt4_brodyaga_bar",[4128.49,3853.23,16.0964],257.924] call sp_ai_setMobPos;
					("cpt4_brodyaga_bar" call sp_ai_getMobBody) switchmove "Acts_StaticDeath_12";
					
				} call sp_threadStart;
			},[
				["state_1",{
					if !getVar("cpt4_obj_doorbarmain" call sp_getObject,isOpen) then {
						callFuncParams("cpt4_obj_doorbarmain" call sp_getObject,setDoorOpen,true arg true);
					};
				}]
			]] call sp_ai_playAnim;
		} call sp_threadStart;


		[cpt4_questName_tobar,"Идите домой"] call sp_setTaskMessageEff;
		_thandle = {
			while {pp_alc_amount > 0} do {
				pp_alc_amount = (pp_alc_amount - 1) max 0;
				1 call sp_threadPause;
			};
		} call sp_threadStart;
		["cpt4_data_threaddecreasealctox",_thandle] call sp_storageSet;
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_trg_onendchapter",{
	{
		[""] call sp_view_setPlayerHudVisible;
		[true] call sp_setHideTaskMessageCtg;
		[false] call sp_setNotificationVisible;

		[true,1.5] call setBlackScreenGUI;
		
		[true,true] call sp_audio_setMusicPause;
		
		_post = {
			[] call sp_audio_stopMusic;
			[!true,true] call sp_audio_setMusicPause;
		};
		invokeAfterDelay(_post,4);

		3 call sp_threadPause;
		
		["cpt4_topart5"] call sp_startScene;
		
	} call sp_threadStart;
}] call sp_addScene;

["cpt4_topart5",{

	pp_alc_amount = 0;
	[["cpt4_data_threaddecreasealctox",sp_threadNull] call sp_storageGet] call sp_threadStop;
	{
		{
			["cpt4_pos_cutscenetocpt5","player_cutscene",[],{
				[_this] call sp_copyPlayerInventoryTo;
				{
					_it = callFuncParams(_this,getItemInSlotRedirect,_x);
					if !isNullReference(_it) then {
						[_it] call deleteGameObject;
					};
				} foreach [INV_HAND_L,INV_HAND_R];
			},{
				_this switchmove "Acts_Accessing_Computer_Loop";
			}] call sp_ai_createPersonEx;

			for "_i" from 1 to 2 do {
				_strI = str _i;
				_pos = "cpt4_pos_cutscenetocpt5_iz" + _strI;
				[_pos,"cpt4_iztpre" + _strI,[
					["uniform",["BlackLightweightArmyCloth1","BlackLightweightArmyCloth2"] select (_i-1)]
				],{
					["RifleFinisher",_this,INV_HAND_R] call createItemInInventory;
					callFunc(_this,switchTwoHands);
				}] call sp_ai_createPersonEx;
			};

		} call sp_threadCriticalSection;
		
		[true] call sp_cam_setCinematicCam;
		[true] call sp_gui_setCinematicMode;

		["vr",[4200.24,3846.01,10.3988],146.569,0.53,[-26.2951,-4.11871],0,0,2.26073,0,0,1,0,1] call sp_cam_prepCamera;
		"player_cutscene" call sp_ai_waitForMobLoaded;
		{call sp_isPlayerPosPrepared} call sp_threadWait;

		(["chap4\monolog\gg1"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;

		[false,3] call sp_gui_setBlackScreenGUI;
		
		["player_cutscene","cpt4_pos_cutscenetocpt5","cutscenes\cpt4_cutscenetocpt5"] call sp_ai_playAnim;
		1 call sp_threadPause;

		["vr",[4203.27,3841.75,8.69881],354.543,0.53,[3.87096,-0.301369],0,0,2.26073,0,0,1,0,1] call sp_cam_prepCamera;
		2 call sp_threadPause;
		(["chap4\monolog\gg2"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
		1 call sp_threadPause;
		(["chap4\monolog\gg3"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
		
		2 call sp_threadPause;

		[true,3] call sp_gui_setBlackScreenGUI;
		
		["chap3end"] call sp_audio_playMusic;

		["vr",[4230.88,3700.47,8.00983],147.826,0.71,[8.00672,0],0,0,3.27006,0,1,1,0,1] call sp_cam_prepCamera;
		["all",["vr",[4232.79,3697.42,8.00983],147.826,0.71,[8.00672,0],0,0,3.27006,0,1,1,0,1],20] call sp_cam_interpTo;
		{call sp_isPlayerPosPrepared} call sp_threadWait;
		[false,3] call setBlackScreenGUI;
		(["chap4\monolog\gg4"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound; //city walls
		1 call sp_threadPause;
		[true,3] call sp_gui_setBlackScreenGUI;

		call sp_cam_stopAllInterp;
		["vr",[4143.06,3714.21,11.7165],87.1522,0.36,[1.21158,0],0,0,2.05077,0,0,1,0,1] call sp_cam_prepCamera;
		"cpt4_iztpre1" call sp_ai_waitForMobLoaded;
		
		["all",["vr",[4144.86,3714.28,11.7165],87.607,0.36,[0.458279,0],0,0,2.05077,0,0,1,0,1],20] call sp_cam_interpTo;
		2 call sp_threadPause;
		[false,2] call setBlackScreenGUI;
		["cpt4_iztpre1","cpt4_pos_cutscenetocpt5_iz1","cutscenes\cpt4_cutscenetocpt5_iz1"] call sp_ai_playAnim;
		["cpt4_iztpre2","cpt4_pos_cutscenetocpt5_iz2","cutscenes\cpt4_cutscenetocpt5_iz2"] call sp_ai_playAnim;
		(["chap4\monolog\gg5"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
		2.8 call sp_threadPause;
		(["chap4\monolog\gg6"] call sp_audio_sayPlayer) call sp_audio_waitForEndSound;
		[true,2.5] call sp_gui_setBlackScreenGUI;

		[false] call sp_cam_setCinematicCam;
		[false] call sp_gui_setCinematicMode;
		[4] call sp_onChapterDone;
		_post = {
			call sp_clearPlayerInventory;
			call sp_cleanupSceneData;
			["cpt5_begin"] call sp_startScene;
		};
		invokeAfterDelay(_post,3);
	} call sp_threadStart;
}] call sp_addScene;