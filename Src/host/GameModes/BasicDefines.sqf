// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <GameMode.h>

editor_attribute("ColorClass" arg "BD5998")
class(IGameEvent) extends(object)

endclass



//Базовый игрвой режим
editor_attribute("ColorClass" arg "C7007D")
editor_attribute("InterfaceClass")
class(GMBase) extends(IGameEvent) attribute(Story)

	"
		name:Базовый режим
		desc:Базовый игровой режим
		path:Игровая логика.Режим
	"
	node_class

	editor_attribute("GMField" arg "type:string") editor_attribute("Tooltip" arg "Название режима")
	var(name,"История"); //Название истории
	
	editor_attribute("GMField" arg "type:string") editor_attribute("Tooltip" arg "Краткое описание режима")
	var(desc,""); //Описание краткое для голосований например
	
	editor_attribute("GMField" arg "type:string") editor_attribute("Tooltip" arg "Расширенное описание режима для конца раунда")
	var(descExtended,"");//Расширенное описание для конца раунда
	
	editor_attribute("GMField" arg "type:bool") editor_attribute("Tooltip" arg "Можно ли прописать аспект на этот режим.\nfalse выключает систему аспектов для режима")
	var(canAddAspect,true); //можно ли прописать аспект на этот режим. false выключает систему аспектов для режима
	
	editor_attribute("GMField" arg "type:float") editor_attribute("Tooltip" arg "Длительность режима в минутах")
	var(duration,60*60);// стандартная длительность режима

	getterconst_func(getProbability,100); //в процентах возвращает вероятность на автопик режима

	getterconst_func(isVotable,true); //включение в голосование

	getterconst_func(isPlayableGamemode,true); //будет ли режим доступен при выборе админом

	//Значения меньше или равны нулю автоматически добавляют режим на вероятность
	getterconst_func(getReqPlayersMin,1); //сколько должно быть игроков для этого режима
	getterconst_func(getReqPlayersMax,999); //максимально игроков для режима

	//минимальное количество полных и скрытых антагов для нормальной игры
	getterconst_func(getMinFullAntags,1);
	getterconst_func(getMinHiddenAntags,1);

	getterconst_func(canPlayEvents,true); //можно ли на этом режиме запускать события в автоматическом режиме (запускает автоматическое обновление)
	//минимальное и максимальное время когда может быть запущено событие
	getter_func(getMinPlayEventTime,60*30);
	getter_func(getMaxPlayEventTime,60*50);

	//Возвращает строковое название типа антага для уникальных антагов
	//Срабатывает при старте раунда. Индекс начинается с 1. Возврат пустой строки означает продолжить спавн по своей роли без антага
	//В этом методе доступны внешние ссылки: _countInGame, _countProbFullAntags
	//! внимание ! Обработка количественной логики (есть ли достаточно ролей данных антагонистов определяется в этом методе)
	func(getAntagRoleFull)
	{
		objParams_2(_client,_index);
		""
	};

	//Обработчик скрытых ролей. _index начинается с 1. вызывается когда уже все клиенты распределены по ролям и загрузились в игру
	//В этом методе доступна внешние ссылки: _countInGame, _countProbHiddenAntags
	func(handleAntagRoleHidden)
	{
		objParams_3(_client,_mob,_index);
	};

	//getterconst_func(getAntagsRoles,[]);//строковые типы антагов (Роли) сюда суём

	var(finishResult,0); //Системная переменная. Устанавливается снаружи класса

	/*func(canPickupMode)
	{
		objParams();
		prob(callSelf(getProbability))
	};*/

	//Вызывается когда режим выбран (до старта раунда с загруженной картой)
	func(preSetup)
	{
		objParams();
	};

	//Вызывается после начала раунда когда все клиенты зашли в игру
	func(postSetup)
	{
		objParams();
	};

	//Проверка финиша. Должен возвращать больше 0
	func(checkFinish)
	{
		objParams();
		0
	};

	func(setFinishResult)
	{
		objParams_1(_index);
		setSelf(finishResult,_index);
	};

	var(bufferedFinishText,"");
	var(bufferedLeadingRolesText,"");

	//Событие при завершении раунда
	func(onFinish)
	{
		objParams();
		setSelf(bufferedFinishText,callSelf(getResultTextOnFinish));

		if (gm_isCustomRoundEnd) then {
			setSelf(bufferedFinishText,gm_customTextResult);
		};

		[format["<t align='center'>Смена %5 завершена!%1<t size='1.6'>%2</t>%1%3%1%1<t shadow='2'>%4</t></t>%1",sbr,
			getSelf(name),
			getSelf(descExtended),
			getSelf(bufferedFinishText),
			ifcheck(gm_currentModeId==-1,"НЕИЗВЕСТНАЯ...",gm_currentModeId)
		],"event"] call cm_sendOOSMessage;

		setSelf(bufferedLeadingRolesText,callSelf(getLeadingRolesInfo));

		callSelfAfter(printLeadingRolesInfo,callSelf(getDelayLeadingRoles));

		callSelfAfter(printRoundStatistic,callSelf(getDelayRoundStatistic));
	};

	getter_func(getResultTextOnFinish,"Конец..."); //результат раунда в текстовом варианте
	getter_func(getDelayRoundStatistic,3); //через сколько выведется статистика
	getter_func(getDelayLeadingRoles,1.5); //через сколько покажет гланвые роли
	func(getLeadingRolesInfo)
	{
		objParams();
		""
	};

	func(getCreditsInfo)
	{
		objParams_2(_mob,_isStructuredText);
		if isNullVar(_isStructuredText) then {_isStructuredText = false};
		//USE _mob.playerClients -> list
		format["%2 как %3 - %1",callSelfParams(__clientOwnersToString,_mob arg _isStructuredText),callFuncParams(_mob,getNameEx,"кто"),getVar(getVar(_mob,role),name)]
	};

	func(__clientOwnersToString)
	{
		objParams_2(_mob,_isST);
		private _list = getVar(_mob,playerClients);
		if array_isempty(_list) exitWith {"ERROR_EMPTY_CLIENT_LIST"};
		private _sb = [];
		{
			_sb pushBack getVar(_x,name)
		} foreach _list;

		if (count _sb == 1) exitwith { _sb select 0};
		
		"(" + (_sb joinString ifcheck(_isST,' -gt '," -> ") ) + ")"
	};

	func(printLeadingRolesInfo)
	{
		objParams();
		if (getSelf(bufferedLeadingRolesText)!="") then {
			[getSelf(bufferedLeadingRolesText),"event"] call cm_sendOOSMessage;
		};
	};

	//Статистика раунда

	//Умершие люди
	var(countDead,0);
	var(countDeadCity,0);
	var(countDeadCave,0);
	var(bloodLoss,0); //литров крови
	var(teethLoss,0); //зубов потеряно
	var(headsLoss,0); //обезглавлено
	var(notesCreated,0); //записок

	func(printRoundStatistic)
	{
		objParams();
		#define printInfoIf(val__,text__,var__) (if (getSelf(var__) val__ ) then {text__ + (str getSelf(var__)) + sbr} else {""})
		#define printInfoIf_Handled(val__,text__,var__,__hnd) (if (getSelf(var__) val__ ) then {text__ + (__hnd) + sbr} else {""})
		private _txtStat = printInfoIf(>0,"Погибших: ",countDead) +
		printInfoIf(>0,"Погибло в городе: ",countDeadCity) +
		printInfoIf(>0,"Сгинуло в пещерах: ",countDeadCave) +
		printInfoIf_Handled(>=1000,"Литров крови пролито: ",bloodLoss,str round(getSelf(bloodLoss)/1000)) +
		printInfoIf(>0,"Выбито зубов: ",teethLoss) +
		printInfoIf(>0,"Обезглавливаний: ",headsLoss);
		printInfoIf(>0,"Записок написано:",notesCreated);

		private _baseText = [getSelf(bufferedFinishText),sbr,"\\n"] call regex_replace;
		private _rolesText = [getSelf(bufferedLeadingRolesText),sbr,"\\n"] call regex_replace;
		_baseText = htmlToString(_baseText);
		_rolesText = htmlToString(_rolesText);

		if (_rolesText!="") then {
			modvar(_baseText) + "\n" + "\n" + _rolesText;
		};

		if (_txtStat != "") then {
			_txtStat = "Статистика раунда:" + sbr + _txtStat;
			[_txtStat,"system"] call cm_sendOOSMessage;
			//отсылаем статистику
			[_baseText + "\n" + ([_txtStat,sbr,"\\n"] call regex_replace),getSelf(name) + "\n\n" + getSelf(descExtended),"Раунд завершён!"] call discServerNotif;
		} else {
			[_baseText,getSelf(name) + "\n\n" + getSelf(descExtended),"Раунд завершён!"] call discServerNotif;
		};
	};

	//данные режима
	//имя загружаемой карты
	getterconst_func(getMapName,"Minimap");

	//имя лобби звука
	getterconst_func(getLobbySoundName,"lobby\First_Steps.ogg");
	//дефолтный бэкграунд
	getterconst_func(getLobbyBackground,PATH_PICTURE("lobby\lobby.paa"));

	//Список ролей для этого режима. Массив строк. Инициализируется во время пикинга режима
	func(getLobbyRoles)
	{
		[
			"RHead",
			"RHeadSon",
			"RWifeHead",
			"RKnut",
			"RAbbat",
			"RAbbatNovice",
			"RCaretaker",
			"RVeteran",
			"RStreak",
			"RBrigadir",
			"RBarmen",
			"RCook",
			"RFarmer",
			"RMedHealer",
			"RWatchman",
			"RCleaner",
			"RMerchant",
			"RGromila",
			"RCitizen"
		]
	};
	//Список лейт ролей. Массив строк. Инициализируется во время пикинга режима
	func(getLateRoles)
	{
		[
			"RBum",
			"RMedHealerNovice",
			"RCookNovice",
			"RBrigadirNovice",
			"REaterStation",
			"RNomadDirtpit"
		]
	};

	//события режима

	//Условие старта раунда
	func(conditionToStart)
	{
		objParams();

		/*#ifdef EDITOR
		if (true) exitWith {true};
		#endif*/

		count getVar(("RHead") call gm_getRoleObject,contenders_1) > 0 &&
		count getVar(("RMerchant") call gm_getRoleObject,contenders_1) > 0 &&
		count getVar(("RCaretaker") call gm_getRoleObject,contenders_1) > 0
	};

	//Возвращает строку почему не вышло
	func(onFailReasonToStart)
	{
		objParams();

		if (
			count getVar(("RHead")call gm_getRoleObject,contenders_1) <= 0 ||
			count getVar(("RMerchant")call gm_getRoleObject,contenders_1) <= 0 ||
			count getVar(("RCaretaker")call gm_getRoleObject,contenders_1) <= 0
			) exitWith {"Для запуска раунда должен быть Голова, Торгаш и Смотритель"};

		"Хуй знает почему не вышло";
	};

	//Получает количество игроков-претендентов на роль
	func(getCandidatesCount)
	{
		objParams_1(_roleName);
		count getVar((_roleName)call gm_getRoleObject,contenders_1)
	};

	func(hasTaskByTag)
	{
		objParams_1(_tag);
		(taskSystem_map_tags getOrDefault [_tag arg []]) > 0
	};

	// Получение объектов задач по тэгу
	func(getAllTasksByTag)
	{
		objParams_1(_tag);
		taskSystem_map_tags getOrDefault [_tag arg []]
	};

	// Получение первой задачи по тэгу 
	func(getFirstTaskByTag)
	{
		objParams_1(_tag);
		private _taskList = taskSystem_map_tags getOrDefault [_tag,[]];
		if (count _taskList == 0) exitWith {nullPtr};
		_taskList select 0
	};

	// Проверить есть ли хотя бы одна успешно выполненная задача с указанным тэгом
	func(hasAnySuccessTaskByTag)
	{
		objParams_1(_tag);
		({getVar(_x,isDone) && getVar(_x,result) > 0} count (taskSystem_map_tags getOrDefault [_tag arg []])) > 0
	};

	// Проверить выполнены ли успешно все задачи с указанным тэгом
	func(hasAllSuccessTaskByTag)
	{
		objParams_1(_tag);
		private _tasksByTag = taskSystem_map_tags getOrDefault [_tag,[]];
		
		// Задач с таким тэгом нет. ничего не выполнено
		if (count _tasksByTag == 0) exitWith {false};
		
		{
			getVar(_x,isDone) && getVar(_x,result) > 0
		} count _tasksByTag == (count _tasksByTag);
	};

	//вызывается каждую секунду. стандартный обработчик раунда
	//Является статической виртуальной функцией. this будет являться неопределенным
	func(onRoundCode)
	{
		objParams();

		//различные проверки в каждом кадре после запуска раунда
		if (gm_roundDuration > 5) then {

			DEC(gm_lobbyTimeLeft);

			if (gm_lobbyTimeLeft < 0) then {
				//embark all
				[] call gm_doEmbark;
				gm_lobbyTimeLeft = gm_lobbyTimeToStart;
			};

			{
				netSendVar("lobby_timeLeft",gm_lobbyTimeLeft,callFunc(_x,getOwner));
			} foreach (call cm_getAllClientsInLobby);
		};

		//ограничение по времени
		USEEVERYDAYRUN_doValidation();
	};

	//Инициализация знания всех персонажей после старта раунда
	func(onKnownMobsProcess)
	{
		objParams();
		{
			//Проход по всем ролям.
			_role = _x call gm_getRoleObject;
			{
				//Всем базовым мобам хандлим addToKnown
			} foreach getVar(_role,mobs);
		} foreach callSelf(getLobbyRoles);
	};

	func(onModeSetup)
	{
		objParams();
		gm_currentModeId = [callSelf(getClassName)] call db_createGamemodeSession;
	};

	//Глобаьно выключено так как система репутации тоже выключена
	getter_func(isVoteSystemEnabled,false); //активна ли система голосования в данном режиме

	getter_func(getUnsleepMessagesCount,1); //количество сообщений в getUnsleepGameInfo randInt(3,4)

	func(getUnsleepGameInfo)
	{
		objParams();
		[
			"Ваше тело расслаблено, глаза закрыты. Одна из немногочисленных радостей, которую могут себе позволить обитатели Сети — это сон."+sbr+sbr+"Крепко спит солдат Новой Армии на скрипучей кровати казармы. В тоннелях на куче тряпья спят культисты. Истязатель спит, подложив под голову раба, который тоже спит, но уже на холодном полу. Спят кочевники в пещерной юрте, всвалку, прижавшись друг к другу и сохраняя тепло. Спят жители свободных поселений, даже вырожденцы спят своим беспокойным сном."+sbr+sbr+"Спите и вы.",
			"Ваши сны никогда не смогут вырваться за пределы Сети, ведь вы никогда не видели и не увидите ничего другого. Среди переплетения тоннелей, воздвигнутых когда-то давно людьми и пещер, воздвигнутых природой, род человеческий провел уже пять поколений. Строились и разрушались поселения, торговые связи, союзы, режимы правления. От былых времён остались только легенды да небылицы."
		]
	};

region(Sound Helpers)
	
	//Получение стартовой композиции. Пустая строка или null - без проигрыша
	func(getStartSong)
	{
		objParams_1(_usr);
		""
	};

	//Получение композиции в конце. Пустая строка или null - без проигрыша. Внутри этого метода можно получить finishResult
	func(getEndSong)
	{
		objParams_1(_usr);
		""
	};

region(Voting Helpers)

	//получает приоритет голосования для режима
	func(getVotePriority)
	{
		objParams();
		private _online = count (call cm_getAllClientsInLobby);
		if isTypeOf(this,ScriptedGamemode) then {
			private _duration = getSelf(duration) max 600; // секунды
			private _durFactor = clamp((_duration / (60*60)) ^ 0.5, 0.5, 2);
			private _onlineFactor = clamp((_online / 30) ^ 0.7, 0.5, 2.5);
			private _weight = _durFactor * _onlineFactor;
			(_weight max 0.1)
		} else {
			private _reqMin = callSelf(getReqPlayersMin) max 1;
			private _reqMax = callSelf(getReqPlayersMax) max _reqMin;
			private _underMinFactor = clamp((_online / _reqMin), 0.3, 2);
			private _overMaxFactor = ifcheck(_online > _reqMax,clamp((_reqMax / _online), 0.3, 1),1);
			private _weight = _underMinFactor * _overMaxFactor;
			(_weight max 0.1)
		}
	};

endregion

endclass

//Специфичный для режима компонент
class(IGamemodeSpecificClass)

endclass