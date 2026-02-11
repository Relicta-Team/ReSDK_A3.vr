// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\text.hpp"

//включена ли данная система
//! WARNING - система нестабильна и нуждается в доработке.
rep_system_enable = false;

#include "Reputation_functions.sqf"

//Список вопросов
rep_map_questions = hashMapNew;
rep_list_categories = [];
rep_map_customQuestions = hashMapNew;

#define QUESTIONS_COUNT 5
#define QUESTIONS_CUSTOM_COUNT 2

#define QUESTION_CUSTOM_SPECIAL_CHAR "▬"

//по 1 вопросу из каждой категории
#define CATEGORIES_COUNT QUESTIONS_COUNT

rep_list_categories resize QUESTIONS_COUNT;
rep_list_categories = rep_list_categories apply {[]};

rep_startTest_info = "<t size='1.6' font='RobotoCondensedLight'>Перед тем, как начать игру на проекте, вы должны пройти небольшой тест," +
format[" состоящий из %1 вопросов.",QUESTIONS_COUNT + QUESTIONS_CUSTOM_COUNT] + " Данный тест проверит ваши знания игрового мира и понимание основных концепций " +
"ролевой игры, а также поможет определить базовую репутацию" + " Старайтесь честно ответить на каждый вопрос и удачи!</t>";

rep_regQuestion = {
	params ["_catIdx","_questionText","_answers","_correctAnswers"];
	rep_map_questions set [_questionText, [_answers, _correctAnswers]];
	(rep_list_categories select _catIdx) pushBack _questionText;
};

rep_regCustomQuestion = {
	params ["_questionText"];
	rep_map_customQuestions set [QUESTION_CUSTOM_SPECIAL_CHAR+_questionText, [[],[]]]; //no answers and correct answers
};

rep_generateQuestions = {
	private _keyList = [];
	private _leftItems = [];
	private _item = 0;
	private _result = [];
	//generate tests questions
	for "_i" from 0 to QUESTIONS_COUNT - 1 do {
		_item = pick array_shuffle(array_copy(rep_list_categories select _i));
		_result pushBack _item;
	};

	//generate custom questions
	_keyList = array_shuffle(keys(rep_map_customQuestions));
	_leftItems = count _keyList;
	for "_i" from 1 to QUESTIONS_CUSTOM_COUNT do {
		_leftItems = count _keyList;
		_item = pick _keyList;
		_keyList = _keyList - [_item];
		_result pushBack _item;
	};

	_result
};



rep_processTesting = {
	private _questionsId = call rep_generateQuestions;
	//генерируем карту вопросов
	private _questionMap = [];
	private _data = [];
	private _ans = [];
	{
		_data = rep_map_questions get _x;
		if isNullVar(_data) then {
			_data = rep_map_customQuestions get _x;
		};
		if isNullVar(_data) then {continue};
		_data params ["_answers","_correct"];
		{
			_ans pushBack format["%1|%2",_x,_forEachIndex];
		} foreach _answers;
		_questionMap pushBack [_x,_ans,_correct];
		_ans = [];
	} foreach _questionsId;
	//локаль
	setSelf(__repCurTestId,0);
	setSelf(__repQuestionMap,_questionMap); //testProgress
	setSelf(__repPoints,0); //дается за правильные ответы
	setSelf(__repQuestionsText,""); //текст ответов
	
	[this,"progress","init"] call db_saveReputationTests;

	[this] call rep_handleProcessTesting;
};

rep_processQuestionText = {
	params ["_qt"];
	forceUnicode 1;
	[_qt,"\"+QUESTION_CUSTOM_SPECIAL_CHAR,""]call regex_replace
};

rep_handleProcessTesting = {
	params ['this'];
	private _onNext = {
		//_inp is value
		_inp params ["_answerId",["_isCustom",false]];
		
		private _ansTxt = "ERROR_UNDEF_ANSWER";
		private _isok = "-";

		//проверяем ответы
		(getSelf(__repQuestionMap) select getSelf(__repCurTestId)) params ["_qTxt","_qAnsw","_correctAnswers"];

		if (_isCustom) then {
			_isok = "+";
			// защита от инъекций в бд
			_ansTxt = _answerId regexReplace ["'/g",""""];
		} else {
			if equals(_answerId,"___NANDATA___") exitwith {
				_isok = "-";
				_ansTxt = "Таймаут ответа";
			};

			_answerId = parseNumber _answerId;
			INC(_answerId); //нам приходят индексы а работаем мы с номерами вопросов

			if array_exists(_correctAnswers,_answerId) then {
				modSelf(__repPoints,+ 1);
				_isok = "+"
			};

			_ansTxt = sanitizeHTML(_qAnsw select (_answerId-1)) splitString "|" select 0;
		};

		private _QAData = format["(%4)Q: %1%2	A:%3%2",sanitizeHTML(_qTxt call rep_processQuestionText),endl,_ansTxt,_isok];
		modSelf(__repQuestionsText, + _QAData);

		//all tests passed!
		if (getSelf(__repCurTestId) >= ((QUESTIONS_COUNT+ QUESTIONS_CUSTOM_COUNT) - 1)) exitWith {
			//для последнего сообщения делаем сохранение
			[this,"progress","done"] call db_saveReputationTests;
			callSelf(CloseMessageBox);
			[this] call rep_endTest;
		};
		
		modSelf(__repCurTestId, + 1);

		(getSelf(__repQuestionMap) select getSelf(__repCurTestId) select [0 arg 2]) params ["_qText","_qAns"];
		_qText = "Вопрос №" + str (getSelf(__repCurTestId)+1) + ": "+ sbr + _qText;
		callSelfParams(UpdateMessageBox, vec2(_qText, _qAns));

		[this,"progress","save"] call db_saveReputationTests;
	};

	(getSelf(__repQuestionMap) select getSelf(__repCurTestId) select [0 arg 2]) params ["_qText","_qAns"];
	_qText = "Вопрос №" + str (getSelf(__repCurTestId)+1) + ": "+ sbr + _qText;
	callSelfParams(ShowMessageBox,"TestingReputation" arg vec2(_qText, _qAns) arg _onNext);
};

rep_startTesting = {
	params ['this'];
	
	callSelfParams(localSay,"Запускаем тестирование..." arg "system");

	private _onStart = {
		[this] call rep_processTesting;
	};
	callSelfParams(ShowMessageBox,"Text" arg [rep_startTest_info arg "Начнём!"] arg {} arg _onStart );
};

//! данная функция вызывает ошибку движка с падением базы в некоторых случаях
rep_continueTesting = {
	params ['this',"_testResult","_testQuestions","_testProgress"];
	
	error("rep::continueTesting() - not supported testing function");
	appExit(APPEXIT_REASON_CRITICAL);

	/*
	_result = _result + "|" + str getSelf(__repCurTestId) + "|" + str getSelf(__repPoints);
	_dataTest = getSelf(__repQuestionMap);
	_dataQuestions = getSelf(__repQuestionsText);
	*/
	(_testResult splitString "|")params["_prog","__repCurTestId","__repPoints"];
	setSelf(__repCurTestId,parseNumber __repCurTestId);
	setSelf(__repPoints,parseNumber __repPoints);
	private _resultMap = [];
	//_qT + "@" + (_aT joinString "&") + "@" + (_cT joinString "&") + "~";
	{
		(_x splitString "@") params ["_qT","_aT","_cT"];
		if ([_qT,"\"+ QUESTION_CUSTOM_SPECIAL_CHAR] call regex_isMatch) then {
			_resultMap pushBack [_qT,[],[]];
		} else {
			_resultMap pushBack [_qT,_aT splitString "&",(_cT splitString "&")apply {parseNumber _x}];
		};
	} foreach (_testProgress splitString "~");
	setSelf(__repQuestionMap,_resultMap);
	setSelf(__repQuestionsText,_testQuestions);

	[this] call rep_handleProcessTesting;
};

rep_endTest = {
	params ['this'];
	#ifdef EDITOR
	callSelfParams(localSay,"Тест завешён. Очков:" + str getSelf(__repPoints) arg "log");
	#endif

	setSelf(testResult,"awaitrep|"+str getSelf(__repPoints));
	[this] call db_saveReputation;
	callSelfParams(localSay,"<t size='2'>Тестирование завершено. Спасибо за уделенное время."+sbr+"Теперь вы можете приступить к игре!</t>" arg "system");
};

rep_init = {
	
	if (!rep_system_enable) exitWith {};

	//custom questions
	["В чем, по вашему, состоит суть ролевой игры?"] call rep_regCustomQuestion;
	["Самое, на ваш взгляд, правильное наказание для игрока, сознательно нарушающего игровой процесс?"] call rep_regCustomQuestion;

	//common questions
	// [0,"Вопрос 1",
	// 	["Ответ 1","Ответ 2","Ответ 3","Ответ 4"],
	// 	[1]
	// ] call rep_regQuestion;

	// СЕКЦИЯ ЛОР
	[
		0,"Где находится выжившая часть человечества согласно лору проекта?",
		["В Сети","В Московском метро","На поверхности планеты","На другой планете"],
		[1]
	] call rep_regQuestion;
	[
		0,"Кто такие ""Дети Исхода""",
		["Потомки первых беженцев из ""Оплота""","Потомки Исхода Правдоведова, аристократия города Канавы","Кочевники","Тоталитарная пещерная секта"],
		[1]
	] call rep_regQuestion;
	[
		0,"В каком ""Колене"" происходит основное действие всех игровых режимов?",
		["6","3","11","7"],
		[1]
	] call rep_regQuestion;
	[
		0,"Какой населённый пункт является столицей Свободных Поселений?",
		["Канава","Грязноямск","Стольник","Кислоберг"],
		[1]
	] call rep_regQuestion;
	[
		0,"Ниже перечислены языки, на котором говорят жители Сети. Выберите один лишний:",
		["Общий","Верхний","Нижний"],
		[1]
	] call rep_regQuestion;
	[
		0,"Кто такие ""Серые""?",
		["Носители таинственной болезни","Пещерные монстры","Военная организация","Орден убийц"],
		[1]
	] call rep_regQuestion;
	[
		0,"""Гребуха"" на пещерном наречии это:",
		["Ложка","Рука","Нога","Лодочное весло"],
		[1]
	] call rep_regQuestion;
	[
		0,"Смотритель в поселениях отвечает за:",
		["Организацию местного ополчения","Присмотр за входом в поселение","Отчёты главе поселения о выполнении его указов","Такая роль отсутствует"],
		[1]
	] call rep_regQuestion;
	[
		0,"Что такое ""Собака""?",
		["Никто не знает...","Это животное семейства собачьих!","Расхожее ругательство","Должность вышибалы в баре"],
		[1]
	] call rep_regQuestion;
	[
		0,"""Оплот"" - это...",
		["Трудовой лагерь Новой Армии","Гильдия наёмников","""Оплата за услуги"" на пещерном наречии","Подземный завод"],
		[1]
	] call rep_regQuestion;
	//СЕКЦИЯ УПРАВЛЕНИЕ
	[
		1,"Сколько окон в режиме взаимодействия доступно игрокам без учета инвентаря?",
		["3","2","1","5"],
		[1]
	] call rep_regQuestion;
	[
		1,"Какая клавиша по умолчанию отвечает за смену активной руки персонажа?",
		["Q","E","I","P"],
		[1]
	] call rep_regQuestion;
	[
		1,"Для выбора определённой части тела при взаимодействии с другим персонажем необходимо:",
		["Выбрать часть тела в разделе области взаимодействия через меню взаимодействия","Прицелиться в эту часть курсором","Через контекстное меню, на правую кнопку мыши","Нажать среднюю кнопку мыши"],
		[1]
	] call rep_regQuestion;
	[
		1,"Активация боевого режима по умолчанию привязана к клавише:",
		["Пробел","F","L","F11"],
		[1]
	] call rep_regQuestion;
	[
		1,"Обилие событий или же ваша концентрация на чём-то другом, но в потоке сообщений чата вы упустили что-то очень важное для себя. Благо, есть специальная клавиша, которая вызывает историю сообщений. Какая она по умолчанию?",
		["F8","End","F10","C"],
		[1]
	] call rep_regQuestion;
	[
		1,"Как изменять громкость голоса у персонажа?",
		["Вращением колеса мыши","Клавишами + и -","Никак, только говорить тише или громче, ведь погружение-то полное!"],
		[1]
	] call rep_regQuestion;
	// СЕКЦИЯ ИГРОВЫЕ МОМЕНТЫ
	[
		2,"Представьте ситуацию: посреди ролевого (In-Character, IC) процесса у вас появился внеролевой вопрос или проблема, о которой вы хотите сообщить другим игрокам или игроку. Как вы это сделаете максимально быстро и эффективно для себя?",
		["Нажмёте F10, и в появившемся окне напишете nrp*пробел*нужный вам текст","Обратитесь к игрокам голосом, начав свой вопрос со слов ""Не по РП""","Напишете в общий канал Дискорда"],
		[1]
	] call rep_regQuestion;
	[
		2,"В игровом процессе кто-то случайно (или специально) использовал жаргон, который не является частью атмосферы игры. Как будет наиболее правильно поступить в таком случае?",
		["Не оставить без внимания, но действовать по обстоятельствам, не вынося за рамки игры","Оставить без видимого внимания со стороны своего персонажа, оформив жалобу в канале Дискорда","Сразу же предпринять все возможные способы вывести персонажа из игры. Бей Томного!","Проигнорировать"],
		[1]
	] call rep_regQuestion;
	[
		2,"О, нет! Вы спохватились слишком поздно и теперь получили роль или спецроль, которую не хотели или не умеете за неё играть. Что вы будете делать?",
		["Импровизировать!","Сгорел сарай – гори и хата! Моё настроение испорчено, так почему я должен оставаться в одиночестве?","Напишу в ООС-чат с просьбой переназначить роль на другого игрока","Выйти из игры."],
		[1]
	] call rep_regQuestion;
	[
		2,"Вы – обычный житель Грязноямска, который неожиданно подвергся нападению другого жителя, желающего вас убить. Что из нижеперечисленных действий ближе всего к понятию ""Суть""?",
		["По возможности обезвредить и сообщить ополчению, или сбежать, привлекая к себе внимание","Матом вопрошать о его мотивации и грозить послеигровой расправой","Выйти из роли и спокойно обьяснить ему, что он не прав"],
		[1]
	] call rep_regQuestion;
	[
		2,"Представьте себе: вы досконально знаете предысторию мира, и внезапно один из персонажей начинает рассказывать что-то, идущее вразрез с ним или отсутствующее в нём. Что ближе к ""Сути""?",
		["Подыграть ему, не выходя из роли. Вдруг получится что-то интересное?","Проигнорировать","Посоветовать идти читать лор, ведь там такой небывальщины нет","С упорством оспаривать его слова, не выходя из роли, и отрубая ему возможность развить деструктивную идею"],
		[1]
	] call rep_regQuestion;
	// СЕКЦИЯ ВНЕИГРОВЫЕ МОМЕНТЫ
	[
		3,"Планка ролевого отыгрыша на проекте оценивается как...",
		["Высокая","Мы ставим себя вне общепринятых рамок. Сами задаём планку!","Низкая","Средняя"],
		[1]
	] call rep_regQuestion;
	[
		3,"Что такое ""ТОМ""?",
		["Тоннельный Образ Мышления","Слово из трёх букв, не несущее никакого значения","Типичное Обоснование Метагейма","Турель Оборонная Модифицированная"],
		[1]
	] call rep_regQuestion;
	[
		3,"Выберите наиболее подходящее определение проектному термину ""Суть"":",
		["Авторское видение ролевой игры","Это база!","Набор правил, существующих на сервере"],
		[1]
	] call rep_regQuestion;
	[
		3,"Возможно ли находиться в игре без присоединения к серверу проекта в TeamSpeak?",
		["Возможно, но недолго","Да!","Нет","Возможно, но не нужно"],
		[1]
	] call rep_regQuestion;
	[
		3,"Разрешено ли использовать внеигровые методы коммуникации в течение игрового раунда?",
		["Нет","Да, без исключений – ваше желание первостепенно!","Да, если это не мешает ролевому процессу"],
		[1]
	] call rep_regQuestion;
	// СЕКЦИЯ ОБЩИЕ ВОПРОСЫ
	[
		4,"Возможно ли играть на сервере без наличия у вас микрофона?",
		["Да","Нет"],
		[1]
	] call rep_regQuestion;
	[
		4,"В течение игровой сессии вы столкнулись с чем-то, что вам, как игроку, совершенно испортило настроение. Что вы предпримете?",
		["Доиграете раунд как ни в чём не бывало, а после завершения сессии, уже во внеигровом общении, обозначите её без перехода на личности","Выведете из игры обидчика максимально быстро и жёстко. Может даже и не раз!","Выйдете из игры и больше на сервер не зайдёте","Затерпите"],
		[1]
	] call rep_regQuestion;
	[
		4,"В процессе игры вы нашли баг, который при его использовании даёт вам преимущество над другими игроками. Ваше слово!",
		["Не буду его использовать в раунде, после игры описав его в специальном канале Дискорда","Сообщу о нём в OOC-чат и не буду использовать его","Проигнорирую","Это не моя проблема, а недоработка билда. Если есть – значит можно!"],
		[1]
	] call rep_regQuestion;
	[
		4,"Сервер реликты доступен...",
		["Сессионно","24/7","В точно определённые дни недели на полный день"],
		[1]
	] call rep_regQuestion;
	[
		4,"Ваш персонаж, зайдя в генераторную, обнаруживает повара, играючи и тонко настраивающего генератор вместо бригадира. Что правильнее всего будет предпринять?",
		["Удивиться и спросить, откуда он всё это знает","Похвалить его. Молодцом!","Не обратить внимания","Выйти из роли и поставить его на место. Это метагейм, выход из роли оправдан!"],
		[1]
	] call rep_regQuestion;


	


	//validate count
	if (count rep_map_questions < QUESTIONS_COUNT) exitwith {
		errorformat("Questions amount error: %1; Expect: %2",count rep_map_questions arg QUESTIONS_COUNT);
		appExit(APPEXIT_REASON_CRITICAL);
	};
	if (count rep_map_customQuestions < QUESTIONS_CUSTOM_COUNT) exitwith {
		errorformat("Custom questions amount error: %1; Expect: %2",count rep_map_customQuestions arg QUESTIONS_CUSTOM_COUNT);
		appExit(APPEXIT_REASON_CRITICAL);
	};
	if (count rep_list_categories < CATEGORIES_COUNT) exitwith {
		errorformat("Categories amount error: %1; Expect: %2",count rep_list_categories arg CATEGORIES_COUNT);
		appExit(APPEXIT_REASON_CRITICAL);
	};
};

call rep_init;