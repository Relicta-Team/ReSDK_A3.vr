// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


// Внутренняя функция активации наследования всех свойств
ms_internal_initInheritance = {
	[ms_map_allMatters] call ms_internal_processInheritanceOnNamespace;
	[ms_map_allReactions] call ms_internal_processInheritanceOnNamespace;

	
	call ms_internal_loadExtension;
};

ms_internal_processInheritanceOnNamespace = {
	params ["_ns"];

	#define __getMatter__(val) (_ns get (val))

	{
		_matterName = _x;

		_thisMatter = __getMatter__(_matterName);
		
		_fieldList = [];
		_thisMatter set ["__typelist",_fieldList];
		_curMot = _thisMatter get "inherit";

		while {_curMot != "NOTYPE"} do {
			_fieldList pushBack _curMot;
			[_thisMatter,__getMatter__(_curMot)] call ms_internal_copyFrom;
			_curMot = __getMatter__(_curMot) get "inherit";
		};

	} foreach _ns;
};

ms_internal_prepToTester = {
	_string = '"MatterSystem" callExtension ["init",[]];' + endl;
	__nullToNil = {
		params ["_value"];
		if isNullVar(_value) exitWith {"nil"};
		if equals(_value,INFINITY) exitWith {str str _value};
		_value
	};	
	//_y get "chilling_products",_y get "chilling_point",_y get "heating_products",_y get "heating_point"
	{
		_string = _string + format['"MatterSystem" callExtension ["loadreag",["%1",%2,%3,%4,%5]];',
			[_x] call __nullToNil,
			[_y get "chilling_products"] call __nullToNil,
			[_y get "chilling_point"] call __nullToNil,
			[_y get "heating_products"] call __nullToNil,
			[_y get "heating_point"] call __nullToNil
		] + endl;
	} foreach ms_map_allMatters;
	/*
	
	_name = _x;
	_reqReag = _y get "required_reagents";
	_reqCat = _y get "catalysts";
	_reqInh = _y get "inhibitors";
	_reactType = _y get "reaction_type";

	_res = (__nativecall ["loadreact",[_name,_reqReag,_reqCat,_reqInh,_reactType,_y get "minimum_temperature",_y get "maximum_temperature"]]) select 0;
	*/
	{
		_string = _string + format['"MatterSystem" callExtension ["loadreact",["%1",%2,%3,%4,%5,%6,%7,%8]];',
			[_x] call __nullToNil,
			[_y get "required_reagents"] call __nullToNil,
			[_y get "catalysts"] call __nullToNil,
			[_y get "inhibitors"] call __nullToNil,
			[_y get "reaction_type"] call __nullToNil,
			[_y get "minimum_temperature"] call __nullToNil,
			[_y get "maximum_temperature"] call __nullToNil,
			[_y get "required_items"] call __nullToNil
		] + endl;
	} foreach ms_map_allReactions;
	
	_string = _string + '"MatterSystem" callExtension ["makeposreact",[]];' + endl;
	
	_string
};	

// Внутренняя функция копирования свойств
ms_internal_copyFrom = {
	params ["_thisMatter","_copyData"];

	private _keys = keys _thisMatter;
	
	{
		if (!(_x in _keys)) then {
			
			private _y = defIsNull(_y,null);
			if isNullVar(_y) then {
				_thisMatter set [_x,null];
			} else {
				_thisMatter set [_x,_y];
			};
		};
	} foreach _copyData;

};

// Внутренняя функция генерации возможных реакций
ms_internal_makeReactionTable = {
	if (true) exitWith {
		warning("To make reactions use extension");
	};

	{
		_matName = _x;
		_matData = _y;
		{
			_reactName = _x;
			if((_y get "required_reagents")findif{_x select 0 == _matName})then{
				(_matData get "possibleReactions") pushBack _reactName
			}
		} foreach ms_map_allReactions;

	} foreach ms_map_allMatters;
};

ms_internal_printInfo = {
	if (isMultiplayer) exitWith {};

	text ((__nativecall ["printinfo",[_x]]) select 0)
};

ms_internal_loadExtension = {
	FHEADER;
	
	#ifdef SP_MODE
	if(true) exitWith {};
	#endif

	/*
		struct Reagent {
			string name -> 0
			List<React> possibleReacts - >

			List<Reagent> chillingProducts;
			double chillingPoint;
			List<Reagent> heatingProducts;
			double heatingPoint;

		} add to Dictionary<string,Reagent>

		struct React {
			string name
			List<KeyValuePair<Reagent,int>> reqMatters
			List<KeyValuePair<Reagent,int>> catalysts
			List<KeyValuePair<Reagent,int>> inhibitors
			List<string> reqItems
			int reactionType

			double minimumTemperature;
			double maximumTemperature;
		} add to Dictionary<string,React>

	*/

	private _res = (__nativecall ["init",[]]);
	if ((_res select 0) == "") exitWith {
		errorformat("ms::internal::loadExtension() - cant load extension: %1",_res);
	};

	// loading base reagents

	{
		_res = (__nativecall ["loadreag",[_x,_y get "chilling_products",_y get "chilling_point",_y get "heating_products",_y get "heating_point"]]) select 0;
		if (_res != "ok") exitWith {
			errorformat("ms::internal::loadExtension() - Reagent loading error: %1",_res);
			appExit(APPEXIT_REASON_RUNTIMEERROR);
			RETURN(0);
		};
	} foreach ms_map_allMatters;



	//loading reactions
	{
		_name = _x;
		_reqReag = _y get "required_reagents";
		_reqCat = _y get "catalysts";
		_reqInh = _y get "inhibitors";
		_reactType = _y get "reaction_type";
		_reqItems = _y get "required_items";
		
		_res = (__nativecall ["loadreact",[
			_name,
			_reqReag,
			_reqCat,
			_reqInh,
			_reactType,
			_y get "minimum_temperature",
			_y get "maximum_temperature",
			_reqItems
		]]) select 0;
		if (_res != "ok") exitWith {
			errorformat("ms::internal::loadExtension() - Reaction loading error: %1",_res);
			appExit(APPEXIT_REASON_RUNTIMEERROR);
			RETURN(0);
		};
		
		{
			_x params ["_nameObj","_amount"];
			_typeReference = missionNamespace getvariable ("pt_"+_nameObj);
			if (isNullVar(_typeReference)) then {
				errorformat("ms::internal::loadExtension() - Reaction <%3> loading error: Object %1 does not exists in reqItems list %2",_nameObj arg _reqItems arg _name);
				appExit(APPEXIT_REASON_RUNTIMEERROR);
				RETURN(0);
			} else {
				if equals(_typeReference,nullPtr) exitWith {
					errorformat("ms::internal::loadExtension() - Reaction <%3> loading error: Object %1 is null reference in reqItems list %2",_nameObj arg _reqItems arg _name);
					appExit(APPEXIT_REASON_RUNTIMEERROR);
					RETURN(0);
				};
			};	
		} foreach _reqItems;

	} foreach ms_map_allReactions;

	// создаём лист реакций
	_res = (__nativecall ["makeposreact",[]]) select 0;
	if (_res == "") exitWith {
		errorformat("ms::internal::loadExtension() - make pos react error: %1",_res);
		appExit(APPEXIT_REASON_RUNTIMEERROR);
	};
	if ((_res select [0,2]) == "er") exitWith {
		errorformat("ms::internal::loadExtension() - make pos react error: %1",_res);
		appExit(APPEXIT_REASON_RUNTIMEERROR);
	};
	
	logformat("Matter system loaded! Result: %1",_res);
};

ms_canReact = {
	params ["_ms","_reactType"];
	
	#ifdef SP_MODE
	if(true) exitWith {[false,"noreaction"]};
	#endif
	// canReact,reaction name,temperature convert reagents
	parseSimpleArray ((__nativecall ["canreact",[_reactType,ms_getMatterList(_ms),26 /*temperature*/,[]]]) select 0);
};

// process reaction
ms_processReaction = {
	params ["_ms","_rT"];

	([_ms,_rT] call ms_canReact) params ["_can","_rName","_tTransf","_removedStr","_newListMatters"];


	//if (getVar(ms_getSource(_ms),pointer) == "34") then {
	//	output = [_can arg _rt arg _tTransf arg _removedStr arg _newListMatters arg getVar(ms_getSource(_ms),pointer)];
	//};

	//сначала изменяем материи от температуры
/*	if (_tTransf != 0) then {
		_ms set [MS_STRUCT_INDEX_MATTERS,createHashMapFromArray _newListMatters];

		{
			//getMatter(_x) get "onChangeMatterState" //by heating or cooling
		} count _removedStr;
	};*/

	if (_can) then {
		private _rObj = ms_map_allReactions get _rName;
/*		if (!call (_rObj get "postCondition")) exitWith {
			//post condition returns false
			_can = false;
		};*/
		
		{
			[_ms,_x select 0,_x select 1] call ms_removeMatter;
		} count (_rObj get "required_reagents");

		private _res = _rObj get "result";

		if !isNullVar(_res) then {
			[_ms,_res,_rObj get "result_amount"] call ms_addMatter;
		};

		private this = ms_getSource(_ms);
		call (_rObj get "onReaction");
	}
#ifdef DEBUG
	else {
		if (_rName select [0,2] == "ex") then {
			errorformat("[MATTERSYSTEM::CANREACT] - CRITICAL ERROR: %1",_rName);
			ms_internal_lastException = _rName;
			ms_internal_lastObject = _ms;
		};
	}
#endif
	;

	_can
};

ms_debug_count = 0;

ms_create = {
	params ["_src","_capacity",["_matters",[]],["_matData",[]]];
	
	private _newMS = [
		_src,
		_capacity,
		createHashMapFromArray _matters,
		createHashMap
	];
	
	if (ms_getFilledSpace(_newMS) > _capacity) then {
		errorformat("ms::create() - Capacity out of range matters: %1 at pointer<%2>. Forced resize to filled space",_newMS arg getVar(_src,pointer));
		ms_setCapacity(_newMS,ms_getFilledSpace(_newMS));
	};
	
	{
		[_newMS,_x select 0,_x select 1] call ms_addMatterData;
		true;
	} count _matData;
	INC(ms_debug_count);
	_newMS
};

//Добавляет данные для реагента
ms_addMatterData = {
	params ["_ms","_matter","_data"];
	
	(_ms select MS_STRUCT_INDEX_MATDATA) set [_matter,_data];
};	

//убирает данные
ms_removeMatterData = {
	params ["_ms","_matter"];
	private _mdata = _ms select MS_STRUCT_INDEX_MATDATA;
	if (_matter in _mdata) then {
		_mdata deleteAt _matter;
	};	
};	



ms_createOnObject = {
	params [["_mats",[]],"_capacity"];
	
	if isNullVar(_capacity) then {
		_capacity = 0;
		#ifdef EDITOR
		if (not_equalTypes(_mats,[]) || not_equalTypes(_mats select 0,[])) exitWith {
			errorformat("Critical error on create ms. Wrong arguments at object: %1. Compare macros newReagentsFood and newReagents",this);
			_capacity = +INFINITY;
		};	
		#endif
		{MOD(_capacity, + (_x select 1))} count _mats;
		if (_capacity == 0) then {_capacity = +INFINITY};
	};	
	[this,_capacity,_mats] call ms_create
};



ms_delete = {
	params ["_ms"];

};

ms_addMatter = {
	params ["_ms","_matter","_amount","_data"];

	private _mlist = ms_getMatterList(_ms);

	//Места в мсе может не хватить. надо ограничить сверху по вместимости
	_amount = _amount max 0 min ms_getFreeSpace(_ms);
	
	if (_amount == 0) exitWith {false};//мы не можем добавить туда ничего. реакций не будет

	// Материя существует в мсе
	if (_matter in _mlist) then {
		_mlist set [_matter, (_mlist get _matter)+_amount];
		//mixing data
		if !isNullVar(_data) then {
			private __mdata__ = ms_getMatterData(_ms);
			if (_matter in __mdata__) then {
				private __NEW_DATA__ = _data;
				private __MD_NAME__ = _matter;
				private thisMatter = getMatter(_matter);
				call (thisMatter get "onMixingData")
			};	
		};
		
		//reaction for blending
		[_ms,REACTION_BLENDING] call ms_processReaction;
	} else {
		_mlist set [_matter,_amount];
	};

	true
};

ms_removeMatter = {
	params ["_ms","_matter","_amount"];

	private _mlist = ms_getMatterList(_ms);

	if (!(_matter in _mlist)) exitWith {false};

	private _newamount = (_mlist get _matter)-_amount;
	
	if (_newamount <= 0) then {
		_mlist deleteAt _matter;
		[_ms,_matter] call ms_removeMatterData;
		
		//reaction for blending
		[_ms,REACTION_BLENDING] call ms_processReaction;
		
	} else {
		if ((_newamount toFixed 4) == "0.0000") exitWith {_mlist deleteAt _matter; [_ms,_matter] call ms_removeMatterData;};

		_mlist set [_matter,_newamount];
	};
	true
};

ms_transToHolder = {
	params ["_ms","_amount","_chemType"];
	//chemType CHEM_INGEST, CHEM_BLOOD, CHEM_TOUCH (проглотить, через кровь,через прикосновение)

	private _loc = ms_getSource(_ms);

	call {
		if (_chemType == "CHEM_INGEST") exitWith {
			private _stomach = getVar(_loc,organs) select BO_INDEX_STOMACH;
			if isNullObject(_stomach) exitWith {};
			[_ms,getVar(_stomach,reagents)] call ms_transferMatter;
		};
		if (_chemType == "CHEM_BLOOD") exitWith {

		};
		if (_chemType == "CHEM_TOUCH") exitWith {

		};
	}

};

//#define ms_log_transfer

ms_transferMatter = {
	params ["_mFrom","_mTo",["_mAmount",INFINITY]];

	private _fsFrom = ms_getFilledSpace(_mFrom);
	//traceformat("from %1 to %2",ms_getMatterList(_mFrom) arg ms_getMatterList(_mTo));

	if (_fsFrom > 0) then {
		// Ограничиваем передаваемое количество по текущему в этом и незаполненом в принимающем.
		_mAmount = _mAmount max 0 min _fsFrom;
		#ifdef ms_log_transfer
		traceformat("blocker 1:: ->  %1 (up %2)",_mAmount arg _fsFrom);
		#endif
		_mAmount = _mAmount max 0 min ms_getFreeSpace(_mTo);
		#ifdef ms_log_transfer
		traceformat("blocker 2:: ->  %1 (up %2)",_mAmount arg ms_getFreeSpace(_mTo));
		#endif
		if (_mAmount == 0) exitWith {false}; //нет свободного места
		private _mListFrom = ms_getMatterList(_mFrom);

		// with ss13 code
		private _trEach = _mAmount / _fsFrom;//(count _mListFrom);
		private _transf = 0;

		#ifdef ms_log_transfer
		traceformat("treach:: -> tr:%3 ||| am:%1 (mlistfrom: %2)",_mAmount arg (count _mListFrom) arg _trEach);
		#endif
		// Отбрасываем все дальше пятой дроби
		//_trEach = throwFloor(_trEach,5);
		//traceformat("resize value:: ->  %1",_trEach);
		{
			//traceformat("IN LOOP BEFORE REISZE (%2) :: ->  %1 min %3",_trEach arg _x arg _y);
			// Ограничиваем передаваемое количество по существующему (предыдущие ограничения не позволяют это сделать)
			///_trEach = _trEach max 0 min _y;
			//traceformat("IN LOOP AFTER REISZE (%3) :: ->  %1 (y:%2) need full replace %4",_trEach arg _y arg _x arg _y - _trEach < 1);
			//если останется меньше единицы то переместим всё
			//if (_y - _trEach < 1) then {_trEach = _y};

			//ss13 code
			_transf = _y * _trEach;
			#ifdef ms_log_transfer
			traceformat("IN LOOP TRANSFER (%2) :: ->  %1",_transf arg _x);
			#endif
			//todo если остаток меньше 1 то доливаем всё

			// Передача
			[_mTo,_x,_transf] call ms_addMatter;
			[_mFrom,_x,_transf] call ms_removeMatter;

			//_trEach = _trEach max 0 min _y;
		} foreach +_mListFrom;
		
		//reaction for blending
		[_mTo,REACTION_BLENDING] call ms_processReaction;

		true
	} else {
		false
	}
};

ms_removeMatters = {
	params ["_mFrom",["_mAmount",INFINITY]];

	private _fsFrom = ms_getFilledSpace(_mFrom);
	//traceformat("from %1 to %2",ms_getMatterList(_mFrom) arg ms_getMatterList(_mTo));

	if (_fsFrom > 0) then {
		// Ограничиваем передаваемое количество по текущему в этом и незаполненом в принимающем.
		_mAmount = _mAmount max 0 min _fsFrom;
		#ifdef ms_log_transfer
		traceformat("blocker 1:: ->  %1 (up %2)",_mAmount arg _fsFrom);
		#endif

		private _mListFrom = ms_getMatterList(_mFrom);

		// with ss13 code
		private _trEach = _mAmount / _fsFrom;//(count _mListFrom);
		private _transf = 0;

		#ifdef ms_log_transfer
		traceformat("treach:: -> tr:%3 ||| am:%1 (mlistfrom: %2)",_mAmount arg (count _mListFrom) arg _trEach);
		#endif

		{

			//ss13 code
			_transf = _y * _trEach;
			#ifdef ms_log_transfer
			traceformat("IN LOOP TRANSFER (%2) :: ->  %1",_transf arg _x);
			#endif
			//todo если остаток меньше 1 то доливаем всё

			// Передача
			[_mFrom,_x,_transf] call ms_removeMatter;

			//_trEach = _trEach max 0 min _y;
		} foreach +_mListFrom;

		//TODO: работа с температурой требуется

		true
	} else {
		false
	}
};

//убирает материи из мса и возвращает сколько было убрано и чего в виде массива
ms_removeMattersWithReturns = {
	params ["_mFrom",["_mAmount",INFINITY]];

	private _fsFrom = ms_getFilledSpace(_mFrom);

	if (_fsFrom > 0) then {
		// Ограничиваем передаваемое количество по текущему в этом и незаполненом в принимающем.
		_mAmount = _mAmount max 0 min _fsFrom;

		private _mListFrom = ms_getMatterList(_mFrom);

		// with ss13 code
		private _trEach = _mAmount / _fsFrom;
		private _transf = 0;
		private _retList = [];
		{
			//ss13 code
			_transf = _y * _trEach;

			// Передача
			_retList pushBack [_x,_transf];
			[_mFrom,_x,_transf] call ms_removeMatter;
		} foreach +_mListFrom;

		//TODO: работа с температурой требуется

		_retList
	} else {
		[]
	}
};
