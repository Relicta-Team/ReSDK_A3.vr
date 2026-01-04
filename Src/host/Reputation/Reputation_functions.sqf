// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	таблицы:
	votes -
		тут хранится голосовательный буфер который отвечает за систему репутаций
		содержит инфу: айди режима, дату начала голосования, персонажи в режиме за которых можно проголосовать (tStruct), список клиентов которые должны голоснуть (просто список) через разделитель |, счетчик сколько должно проголосовать (конст) - полное количество, счетчик сколько уже проголосовало
	playervotes - 
		тут хранится список игроков с их голосовательной информацией. нужен для информации может ли игрок играть в раунде
		ник игрока, последний режим в котором он играл (айди), за кого он проголосовал структура лучшие;лучшие|худшие;худшие


 */

//структура: ник (аккаунт), персонаж (имя), роль (тип),флаги - строка с разделителем: var=val:var:var=val
repvote_list_tStructVoteObject = [];

//флаг автоматического голосования.
//! работает только в режиме редактора
//#define TEST_REPUTATION_AUTOVOTE

/*
	Флаги:
	lowrep - низкая репутационная необходимость
	earlygame - клиент зашёл в первые 20 минут

*/
repvote_serializeFlags = {
	private _fStruct = [];
	if equalTypes(hashMapNull,_this) then {
		_this = _this toArray false;
	};
	{
		if equalTypes(_x,[]) then {
			_x params ["_key","_val"];
			_fStruct pushback format["%1=%2",_key,_val];
		} else {
			_fStruct pushBack _x;
		};
	} foreach _this;
	_fStruct joinString ":";
};

repvote_deserializeFlags = {
	private _struct = createHashMap;
	{
		if ("=" in _x) then {
			(_x splitString "=") params ["_key","_val"];
			_struct set [_key,_val];
		} else {
			_struct set [_x,"FLAG_ACTIVE"];
		};
	} foreach (_this splitString ":");
	_struct
};

repvote_collectPlayer = {
	params ["_mob","_client"];

	if (!rep_system_enable) exitwith {}; //система репутации выключена

	//собираются персонажи, зашедшие только в первые 20 минут
	private _isBest_JoinedOnBegin = (gm_roundDuration <= (20*60));

	//исключаем тех, у кого репутация кастомная репутация: Быть говну, Покинутый, Сама Суть
	if not_equals(getVar(_client,reputationCustom),"") exitwith {};
	
	//у кого репутационное требование меньше 10 исключаются из голосования за лучшего
	private _basicRole = getVar(_mob,basicRole);
	private _isBest_LowRep = callFunc(_basicRole,getReputationRequirement) < 10;

	private _flags = [];
	if (_isBest_JoinedOnBegin) then {
		_flags pushBack "earlygame";
	};
	if (_isBest_LowRep) then {
		_flags pushBack "lowrep";
	};

	repvote_list_tStructVoteObject pushBack format["%1|%2|%3|%4",getVar(_client,name),callFuncParams(_mob,getNameEx,"кто"),callFunc(_basicRole,getClassName), _flags call repvote_serializeFlags];
};

#ifndef EDITOR
	#undef TEST_REPUTATION_AUTOVOTE
#endif


repvote_onEndRound = {
	#ifdef DISABLE_VOTING_SYSTEM
	if (true) exitwith {[]};
	#endif
	
	private _rep = 0;

	private _onSelected = {
		(_inp) params ["_best","_bad"];
		callSelf(CloseMessageBox);
		if !isTypeOf(this,ServerClient) then {
			this = getVar(this,client);
		};
		[getSelf(name),_best,_bad] call repvote_voteTo;
	};
	
	private _genClient = [];
	private _bestPla = [];
	private _badPla = [];
	private _cName = "";
	private _rv_list_unpacked = [];
	// сплитим каждый элемент repvote_list_tStructVoteObject, распаковываем флаги и записываем значения в vec4
	{
		(_x splitString "|") params ["_name","_charName","_roleClass","_flags"];
		_rv_list_unpacked pushBack [_name,_charName,_roleClass,_flags call repvote_deserializeFlags];
	} foreach repvote_list_tStructVoteObject;


	{
		_badPla = [];
		_bestPla = [];
		_rep = getVar(_x,reputation);
		//репа говно. он не голосует
		if (_rep <= -4) then {continue};

		//персональная модификация. тут собираются списки лучших и худших
		_cName = getVar(_x,name);
		{
			_x params ["_name","_nick","_role","_flags"]; 
			
			// исключаем локального игрока из голосования
			if (_name == _cName) then {
				continue;
			};
			// на голосование за лучших добавляем только тех, кто зашёл в первые 20 минут
			if ("earlygame" in _flags) then {
				// исключаются игроки с репутационнм требованием (проверка через флаг)
				if ("lowrep" in _flags) exitwith {};
				_bestPla pushBack ([_name,_nick,getVar(_role call gm_getRoleObject,name),_role] joinString "|");
			};

			// на голосование за худших добавляем всех, кроме тех у кого роли: TOMMonsterRole и TheEssenseRole
			if (_role in ["TOMMonsterRole","TheEssenseRole"]) then {
				continue;
			};
			_badPla pushBack ([_name,_nick,getVar(_role call gm_getRoleObject,name),_role] joinString "|");

		} foreach _rv_list_unpacked;
		
		if (count _bestPla > 2) then {
			callFuncParams(_x,ShowMessageBox,"VoteRep" arg vec2(_bestPla,_badPla) arg _onSelected);
			//увеличение счетчика срабатывает только если клиент может голоосовать (возможных лучших игроков больше 2х)
			_genClient pushBack getVar(_x,name);
		};

	} foreach gm_internal_ingameClients;

	// Тут ограничение по минимому голосующих
	if (count _genClient > 3) then {
		{
			[gm_currentModeId,_x] call db_registerVoteClient;
		} foreach _genClient;
		[gm_currentModeId,repvote_list_tStructVoteObject,_genClient] call db_registerNewVote;


		#ifdef TEST_REPUTATION_AUTOVOTE
			_mainClient = "Septima" call cm_findClientByName;
			if isNullReference(_mainClient) exitwith {
				error("[(TEST)TEST_REPUTATION_AUTOVOTE]: cant find client - null reference")
			};	
			_mainClientName = getVar(_mainClient,name);
			if ("Septima" in _mainClient) exitwith {
				errorformat("[(TEST)TEST_REPUTATION_AUTOVOTE]: main client is not player: %1",_mainClient);
			};

			//? -------------------------------- CONFIGURE --------------------------------
			
			_ctrToBest = 5; //сколько первых клиентов проголосует за нашего игрока как за лучшего 
			
			_badRndMax = 2; //сколько максимально могут выбрать плохих игроков. 
			//? -------------------------------- --------- --------------------------------
			
			{
				
				//generate auto vote for best and bads
				if (_ctrToBest > 0) then {
					_ctrToBest = _ctrToBest - 1;
					_uList = cm_allClients - [_mainClient];
					_rndList = [];
					for "_i" from 1 to randInt(0,_badRndMax) do {
						_el = pick _uList;
						_uList = _uList - [_el];
						_rndList pushBack getVar(_el,name);
					};

					[getVar(_x,name),[_mainClientName],_rndList,false] call repvote_voteToEDITOR;
				} else {
					_rlist = cm_allClients - [_mainClient];
					_bList = [];
					for "_i" from 1 to 2 do {
						_el = pick _rlist;
						_rlist = _rlist - [_el];
						_bList pushBack getVar(_el,name);
					};
					[getVar(_x,name),_bList,[],true] call repvote_voteToEDITOR;
				};
				
			} foreach (gm_internal_ingameClients - [_mainClient]);
		#endif
	};
};

repvote_startVotingClient = {
	params ['this',"_bestBads"];
	_bestBads params ["_best","_bad"];
	
	private _onSelected = {
		(_inp) params ["_best","_bad"];
		callSelf(CloseMessageBox);
		setSelf(votingData,null); // drop voting data
		if !isTypeOf(this,ServerClient) then {
			this = getVar(this,client);
		};
		[getSelf(name),_best,_bad] call repvote_voteTo;
	};

	if (count _best > 2) then {
		callSelfParams(ShowMessageBox,"VoteRep" arg vec2(_best,_bad) arg _onSelected);
	} else {
		//fix
		setSelf(votingData,null);
	};
};

//Добавление структуры голосования
repvote_voteTo = {
	params ["_name",["_best",[]],["_bad",[]]];

	private _struct = (_best joinString ";") + "|" + (_bad joinString ";");
	[_name,_struct] call db_processVoteClient;

};

#ifdef EDITOR
repvote_voteToEDITOR = {
	params ["_name",["_best",[]],["_bad",[]],["_autoSync",true]];
	private _struct = (_best joinString ";") + "|" + (_bad joinString ";");
	[_name,_struct,_autoSync] call db_processVoteClient;
};
#endif

repvote_list_textNames = [
			"ТОМНЫЙ",
			"Вас ненавидят!",
			"Отчужденец",
			"ДБРПЖЛ",
			"Молодцом",
			"Быть добру",
			"Вас тут любят",
			"Просветленный",
			"Близь Сути"
		];

repvote_reputationToLevel = {
	params ["_rep"];
	if (_rep <= -7) exitwith {
		0
	};
	if inRange(_rep,-6,-4) exitwith {
		1
	};
	if inRange(_rep,-3,-2) exitwith {
		2
	};
	if inRange(_rep,-1,2) exitwith {
		3
	};
	if inRange(_rep,3,4) exitwith {
		4
	};
	if inRange(_rep,5,9) exitwith {
		5
	};
	if inRange(_rep,10,14) exitwith {
		6
	};
	if inRange(_rep,15,29) exitwith {
		7
	};
	//if (_rep >= 30)
	8
};

repvote_getReputationText = {
	params ["_points"];
	private _idx = _points call repvote_reputationToLevel;
	private _listTNames = repvote_list_textNames;
	_idx = clamp(_idx,0,count _listTNames - 1);
	_listTNames select _idx
};

repvote_isAllowedRoleByReputation = {
	params ["_rep","_role"];
	private _rdump = _role;
	if equalTypes(_role,"") then {
		_role = _role call gm_getRoleObject;
	};
	if isNullReference(_role) exitWith {
		errorformat("repvote::isAllowedRoleByReputation: role %1 is not found",_rdump);
		false
	};
	private _repNeed = callFunc(_role,getReputationRequirement);
	3 * (_rep + 10) >= _repNeed
};

#include "..\text.hpp"
//debug
#ifdef EDITOR
rep_debug_showNeedPoints = {
	_myCli = "Septima" call cm_findClientByName;
	private _txt = "Моя репа:" + format["%1 := Я могу брать роли если у меня <t size='1.2'>%2</t> очков или более",getVar(_myCli,reputation),3 * (getVar(_myCli,reputation) + 10)] + sbr + sbr + "Лобби:"+sbr;
	{
		_robj = _x call gm_getRoleObject;
		_txt = _txt + sbr + format["%1(%2) - need <t size='1.2'>%3</t> : %4",getVar(_robj,name),callFunc(_robj,getClassName),
			callFunc(_robj,getReputationRequirement),getVar(_robj,reputationNeed)
		];
	} foreach (callFunc(gm_currentMode,getLobbyRoles));
	_txt = _txt + sbr + sbr + "Лейт:"+sbr;
	{
		_robj = _x call gm_getRoleObject;
		_txt = _txt + sbr + format["%1(%2) - need <t size='1.2'>%3</t> : %4",getVar(_robj,name),callFunc(_robj,getClassName),
			callFunc(_robj,getReputationRequirement),getVar(_robj,reputationNeed)
		];
	} foreach (callFunc(gm_currentMode,getLateRoles));
	
	{
		if (getVar(_x,name) == "Septima") then {
			callFuncParams(_x,ShowMessageBox,"Text" arg _txt);
		};
	} foreach cm_allClients;
};

#endif