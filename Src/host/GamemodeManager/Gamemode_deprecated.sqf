// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! ДАННЫЙ ФАЙЛ НЕ ПОДКЛЮЧЕН К ПРОЕКТУ И БУДЕТ УДАЛЕН В БУДУЩЕМ

/*//! УСТАРЕВШАЯ ДОКУМЕНТАЦИЯ
	# 1. Этап подготовки
	В этом этапе собираются нужные коллекции персонажей кто на какие роли готов встать. На этом этапе необходимо подготовить список преддекларарнутых клиентов и антагов. В каждом режиме указано минимальное количество каждого типа антагов. Если антагов не набралось нужное количество - значит антагами могут быть все (исключая роли которые действительно не могут быть антагами)

	- Собираем всех кто готов встать на роли. Данные заносятся в массив vec2 с клиентом и антагом (**gm_prepToPlayClients**).
	Так же клиент вносится в лист полных (**gm_antagClientsFull**) и скрытых (**gm_antagClientsHidden**) антагов в зависимости от того что он указал в настройках персонажа.
	*Важное примечание*: роли декрементируются уже на этом этапе чтобы провести проверку количества.
	- После подготовки проверяем листы полных и скрытых антагов. Если их количество меньше указанных в режиме (**GMBase::getMinFullAntags** и **GMBase::getMinHiddenAntags**) то проходимся по листу подготовленных и добавляем роли, допустимые для типа антага.
	- Теперь после этого проходимся по листу полных антагов (предварительно зашафлив) и выбираем из функции (**GMBase::getFullAntagRoleClass**) типы полных антагов, заменяя их в листе подготовленных (**НЕ ЗАБЫВАЯ ВЕРНУТЬ КОЛИЧЕСТВО РОЛЕЙ**)

	> И вот тут возникла проблема, что допустим бармена перекинуло на фулл антага и роль бармена осталась не занятой. Как решать? 
	>> А никак. Это не проблема, потому что безролевые клиенты будут распределены на эту роль.

	> Проблема 2. Безролевые клиенты не могут получить антаг роль.
	>> Решение: нужно распределять их до того как полные антаги выбраны.

	# 2. Этап распределения
	Здесь происходит спавн клиентов которые задекларились на свои роли.

	- Когда все клиенты подготовлены начинаем спавнить их на свои роли. Полные антаги уже переопределены и будут назначены на свои отдельные роли.
	- После этого спавним безрольных клиентов в порядке общей очереди.

	# 3. Финализация
	- Шафлим список игроков в игре и вызываем стандартный метод обработки антагов. 
 */

//Выбор уникальных антагонистов
//ЗАКОМЕНТИРОВАН И НЕ ВЫЗЫВАЕТСЯ НА ДАННЫЙ МОМЕНТ
gm_processAntags = {

	private _lobbyClientList = call cm_getAllClientsInLobby;

	//shuffle list (for resolve problem priority of roles)
	_lobbyClientList = array_shuffle(_lobbyClientList);

	//Гарантированные антаги
	private _antagClients = [];

	{
		if getVar(_x,isReady) then {
			_antagEnum = getVar(_x,charSettings) get "antag";

			//Антаг полный или все (больше чем скрытый)
			if (_antagEnum > 1) then {
				_role1 = getVar(_x,charSettings) get "role1";
				_rObj = _role1 call gm_getRoleObject;
				//Это ключевая роль
				if getVar(_rObj,isKeyRole) then {
					_contenders = getVar(_rObj,contenders_1);
					//Можно добавить если количество претендентов больше 1
					if (count _contenders > 1) then {
						_antagClients pushBack _x;
						//remove him
						_contenders deleteAt (_contenders find _x);
					};
				} else {
					_antagClients pushBack _x;
				};
			};

			//скрытый или все
			/*if (_antagEnum%2 == 1) then {
				gm_antagClientsHidden
			};	*/

		};
	} foreach _lobbyClientList;

	//Случайная сортировка клиентов на антагов
	gm_antagClients = array_shuffle(_antagClients);

	// Если явных антагов меньше требуемых (режим не зарандомился или любые другие исключения.) то добираем из оставшихся клиентов
	private _needAntags = getVar(gm_currentMode,getReqAntagsFull);
	if (count gm_antagClients < _needAntags) then {

		warningformat("gm::processAntags() - too low count full antags: need %1; cur %2",_needAntags arg count gm_antagClients);

		//removing picked antags from all lobby clients
		_lobbyClientList = _lobbyClientList - [gm_antagClients];
		private _lessCount = _needAntags - (count gm_antagClients);
		{
			if getVar(_x,isReady) then {
				//________________________________________________________________
				//COPIED FROM LINE 249
				//________________________________________________________________
				_role1 = getVar(_x,charSettings) get "role1";
				_rObj = _role1 call gm_getRoleObject;
				//Это ключевая роль
				if getVar(_rObj,isKeyRole) then {
					_contenders = getVar(_rObj,contenders_1);
					//Можно добавить если количество претендентов больше 1
					if (count _contenders > 1) then {
						gm_antagClients pushBack _x;
						//remove him
						_contenders deleteAt (_contenders find _x);
					};
				} else {
					gm_antagClients pushBack _x;
				};
			};
		} foreach _lobbyClientList;
	};
};

//раздаём скрытых антагов
//оставшиеся в gm_antagClients плюс те, у которых "antag"%2==1
//! УСТАРЕВШИЙ МЕТОД - НЕ ВЫЗЫВАЕТСЯ
gm_processPostAntags = {
	OBSOLETE(gm::processPostAntags);
	//--- private _allClients = call cm_getAllClientsInGame;
	private _rndListClients = array_copy(call cm_getAllClientsInGame);

	//Добавляем уникальных
	{
		_rndListClients pushBackUnique _x;
	} foreach gm_antagClients;

	//--- находим количество кто скрыт
	//_rndListClients

	//--- удаляем тех, кто выключил мод если хватает по количеству.
	//----Количество - процентное соотношение от всех игроков в игре

	//Удаляем тех, у кого статус антага равен 0
	private _toRemList = [];
	{
		if ((getVar(_x,charSettings) get "antag") == 0) then {_toRemList pushBack _x};
	} foreach _rndListClients;

	//смешивание с удалением левых типов
	_rndListClients = array_shuffle(_rndListClients - _toRemList);

	//внешняя ссылка для использования в GMBase::handleAntagRoleHidden
	private _allClientsInGame = count _rndListClients;
	
	#ifdef gamemode_testing_antags
	_rndListClients pushBack (cm_allClients select 0);
	#endif
	
	private _curClient = nullPtr;
	for "_i" from 0 to (count _rndListClients)-1 do {
		_curClient = _rndListClients select _i;
		callFuncParams(gm_currentMode,handleAntagRoleHidden,_curClient arg _i + 1);
	};

};