// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//получить количество текущих созданных реагентов
reagentSystem_getActiveCount = {
	reagentSystem_count_created - reagentSystem_count_destroyed
};

reagentSystem_initReactions = {
	private _o = nullPtr;
	private _genname = {
		"r:" + (getVar(_o,required_reagents) apply {
			(_x select 0) + (format["(%1)",_x select 1])
		} joinString "+") + "="+(if isNull(getVar(_o,result)) then {
			"<NULL>"
		} else {
			getVar(_o,result)
		});
	};
	{
		_o = instantiate(_x);
		_o setName (call _genname);
		reagentSystem_map_allReactions set [_x,_o];
	} foreach getAllObjectsTypeOf(ReagentReaction);

	//old matter system
	if !isNull(ms_internal_initInheritance) exitwith {};

	call reagentSystem_loadExension;
};

reagentSystem_loadExension = {
	FHEADER;
	#define __nativecall "MatterSystem" CALLExtension
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
		errorformat("reagentSystem::loadExtension() - cant load extension: %1",_res);
	};

	//load reagents
	{
		_res = (__nativecall ["loadreag",[
				_x,
				[_x,"chilling_products"] call oop_getFieldBaseValue,
				[_x,"chilling_point"] call oop_getFieldBaseValue,
				[_x,"heating_products"] call oop_getFieldBaseValue,
				[_x,"heating_point",true] call oop_getFieldBaseValue
				]
		]) select 0;
		if (_res != "ok") exitWith {
			errorformat("reagentSystem::loadExtension() - Reagent (%2) loading error: %1",_res arg _x);
			appExit(APPEXIT_REASON_RUNTIMEERROR);
			RETURN(0);
		};
	} foreach getAllObjectsTypeOf(ReagentBase);

	//load reactions
	{
		_name = _x;
		_reqReag = _y getvariable "required_reagents";
		_reqCat = _y getvariable "catalysts";
		_reqInh = _y getvariable "inhibitors";
		_reactType = _y getvariable "reaction_type";
		_reqItems = _y getvariable "required_items";
		
		_res = (__nativecall ["loadreact",[
			_name,
			_reqReag,
			_reqCat,
			_reqInh,
			_reactType,
			_y getvariable "minimum_temperature",
			_y getvariable "maximum_temperature",
			_reqItems
		]]) select 0;
		if (_res != "ok") exitWith {
			errorformat("reagentSystem::loadExtension() - Reaction loading error: %1",_res);
			appExit(APPEXIT_REASON_RUNTIMEERROR);
			RETURN(0);
		};
		
		{
			_x params ["_nameObj","_amount"];
			_typeReference = missionNamespace getvariable ("pt_"+_nameObj);
			if (isNullVar(_typeReference)) then {
				errorformat("reagentSystem::loadExtension() - Reaction <%3> loading error: Object %1 does not exists in reqItems list %2",_nameObj arg _reqItems arg _name);
				appExit(APPEXIT_REASON_RUNTIMEERROR);
				RETURN(0);
			} else {
				if equals(_typeReference,nullPtr) exitWith {
					errorformat("reagentSystem::loadExtension() - Reaction <%3> loading error: Object %1 is null reference in reqItems list %2",_nameObj arg _reqItems arg _name);
					appExit(APPEXIT_REASON_RUNTIMEERROR);
					RETURN(0);
				};
			};	
		} foreach _reqItems;

	} foreach reagentSystem_map_allReactions;
};

reagentSystem_createOnObj = {
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
	[this,_capacity,_mats] call reagentSystem_createHolder;
};

reagentSystem_createHolder = {
	params ["_src","_maxvol","_mats"];
	private _holder = new(ReagentHolder);
	setVar(_holder,loc,_src);
	setVar(_holder,maxVolume,_maxvol);
	{
		_x params ["_id","_vol"];
		callFuncParams(_holder,addReagent,_id arg _vol);
	} foreach _mats;
};