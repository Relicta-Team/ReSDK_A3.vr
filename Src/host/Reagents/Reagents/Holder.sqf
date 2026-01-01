// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================




class(ReagentHolder)
	
	var(reagentList,createHashMap);//_x class, _y reference
	var(maxVolume,0); //объем контейнера
	var(loc,nullPtr);//игровой объект
	
	var(lastTick,0);

	var(_needRegenerateMS,false); //true будет пересоздавать данные

region(initializers)
	func(constructor)
	{
		objParams();
	};

	func(destructor)
	{
		objParams();
		{
			delete(_y);
		} foreach array_copy(getSelf(reagentList));
	};

	func(reagentsToMap)
	{
		objParams();
		getSelf(reagentList) apply {
			[_x,getVar(_y,volume)]
		}
	};

region(functions)
	func(processReaction)
	{
		params ["_reactType"];
		(parseSimpleArray (
			("MatterSystem" CALLExtension [
				"canreact",
				[
					_reactType,
					getSelf(reagentList) apply {
						[_x,getVar(_y,volume)]
					},
					DEFAULT_TEMPERATURE /*temperature*/
					,[]
				]
			]) select 0))
		params ["_can","_rName","_tTransf","_removedStr","_newListMatters"];

		if (_can) then {
			private _rObj = reagentSystem_map_allReactions get _rName;
			
			{
				callSelfParams(removeReagent,_x select 0 arg _x select 1);
			} count getVar(_rObj,required_reagents);

			private _res = getVar(_rObj,result);

			if !isNullVar(_res) then {
				callSelfParams(addReagent,_res arg getVar(_rObj,result_amount));
			};

			callFuncParams(_rObj,onReaction,getSelf(loc));
		}
#ifdef DEBUG
		else {
			if (_rName select [0,2] == "ex") then {
				errorformat("[REAGENTSYSTEM::CANREACT] - CRITICAL ERROR: %1",_rName);
				[format["[REAGENTSYSTEM::CANREACT] - CRITICAL ERROR: %1",_rName]] call logError;
				reagentSystem_internal_lastEx = _rName;
				reagentSystem_internal_lastObj = this;
			};
		}
#endif
		;

		_can
	};

	func(addReagent)
	{
		params ['this',"_id","_amount",["_data",null]];

		if (_amount <= 0) exitWith {false};

		private _total = callSelf(getTotalVolume);
		private _max = getSelf(maxVolume);
		private _map = getSelf(reagentList);
		if (_total + _amount > _max) then {
			_amount = _max - _total;
		};

		if (_id in _map) then {
			private _r = _map get _id;
			modVar(_r,volume, + _amount);

			callFuncParams(_r,onMerge,_data);
		} else {
			private _r = instantiate(_id);
			setVar(_r,volume,_amount);
			setVar(_r,holder,this);
			_map set [_id,_r];

			if !isNullVar(_data) then {
				setVar(_r,data,_data);
				callFuncParams(_r,onNew,_data);
			};
		};

		true
	};

	func(removeReagent)
	{
		params ['this',"_id","_amount",["_safety",false]];
		private _list = getSelf(reagentList);
		if !(_id in _list) exitwith {false};
		private _newamount = getVar(_list get _id,volume)-_amount;
		//если меньше указанного занчения то вырезаем
		if (_newamount < 0.1) then {
			private _r = _list deleteAt _id;
			callFunc(_r,onRemove);
			delete(_r);
		} else {
			setSelf(_list get _id,_newamount);
		};

		if (!_safety) then {
			//!handle reactions
		};

		true
	};

	//получить сколько занято
	func(getTotalVolume)
	{
		objParams();
		private _t = 0;
		{
			modvar(_t) + getVar(_y,volume);
		} foreach getSelf(reagentList);
		_t
	};

	func(getLeftVolume)
	{
		objParams();
		getSelf(maxVolume) - callSelf(getTotalVolume)
	};

	//удалить реагент
	func(deleteReagent)
	{
		objParams_1(_id);
		private _list = getSelf(reagentList);
		if !(_id in _list) exitWith {false};

		private _r = _list deleteAt _id;
		callFunc(_r,onRemove);
		delete(_r);
		true
	};

	//убрать все остальные реагенты кроме указанного
	func(isolateReagent)
	{
		objParams_1(_id);
		{
			if (_x != _id) then {
				callSelfParams(deleteReagent,_x);
			};
		} foreach array_copy(getSelf(reagentList));
	};

	func(getMasterReagent)
	{
		objParams();
		private _max = 0;
		private _r = nullPtr;
		{
			if (getVar(_y,volume) > _max) then {
				_max = getVar(_y,volume);
				_r = _y;
			};
		} foreach getSelf(reagentList);
		_r
	};
	
	func(getRandomReagent)
	{
		objParams();
		if (count getSelf(reagentList) == 0) exitwith {nullPtr};
		pick values getSelf(reagentList)
	};
	
	func(transferTo)
	{
		params ['this',"_target",["_amount",1],["_mul",1],["_canPreserveData",true]];

		if !isTypeOf(_target,ReagentHolder) exitwith {false};

		private _rsTotalFrom = callSelf(getTotalVolume);
		_amount = _amount max 0 min _rsTotalFrom;

		_amount = _amount max 0 min callFunc(_target,getLeftVolume);
		if (_amount == 0) exitwith {false};
		private _rListFrom = array_copy(getSelf(reagentList));

		private _trEach = _amount / _rsTotalFrom;
		private _transf = 0;
		private _transData = null;
		{
			_transf = getVar(_y,volume) * _trEach;
			if (_canPreserveData) then {
				_transData = callSelfParams(copyData,_y);
			};
			callFuncParams(_target,addReagent,_x arg _transf * _mul arg _transData);
			callSelfParams(removeReagent,_x arg _transf);
		} foreach _rListFrom;

	};

	func(removeReagents)
	{
		objParams_1(_amount);
		private _rsTotalFrom = callSelf(getTotalVolume);
		if (_rsTotalFrom <= 0) exitwith {false};
		_amount = _amount max 0 min _rsTotalFrom;

		private _trEach = _amount / _rsTotalFrom;
		private _transf = 0;
		{
			_transf = getVar(_y,volume) * _trEach;
			callSelfParams(removeReagent,_x arg _transf);
		} foreach array_copy(getSelf(reagentList));
	};

	func(hasReagent)
	{
		objParams_1(_id);
		_id in (keys getSelf(reagentList))
	};

	func(getReagentAmount)
	{
		objParams_1(_id);
		private _r = getSelf(reagentList) getOrDefault [_id,nullPtr];
		if isNullReference(_r) exitwith {0};
		getVar(_r,volume)
	};

	func(transferIdTo)
	{
		params ['this',"_target","_id","_amount",["_canPreserveData",true]];

		if isTypeOf(_target,ReagentHolder) exitwith {false};
		if (
			callSelf(getTotalVolume)<=0 ||
			!callSelfParams(hasReagent,_id)
		) exitwith {false};
		private _curAmount = callSelfParams(getReagentAmount,_id);
		if (_curAmount<_amount) then {
			_amount = _curAmount;
		};
		
		_amount = _amount min callFunc(_target,getLeftVolume);

		private _data = null;
		if (_canPreserveData) then {
			_data = callSelfParams(copyData,getSelf(reagentList) get _id);
		};
		callFuncParams(_target,addReagent,_id arg _amount arg _transData);
		callSelfParams(removeReagent,_id arg _amount);
		
		true
	};

	func(copyData)
	{
		objParams_1(_reagent);
		private _data = getVar(_reagent,data);
		if isNullVar(_data) exitwith {null};
		if !equalTypes(_data,[]) exitwith {_data};

		array_copy(_data)
	};

	func(clearReagents)
	{
		objParams();
		{
			callSelfParams(deleteReagent,_x);
		} foreach array_copy(getSelf(reagentList));
	};

	//вызывается при контакте одного объекта с другим
	func(reaction)
	{
		params ['this',"_obj",["_method",TOUCH],"_targetZone",["_volMod",1]];
		{
			call {
				if isTypeOf(_obj,Mob) exitWith {
					callFuncParams(_y,reactionOnMob,_obj arg _method arg getVar(_y,volume) arg _targetZone);
				};
				callFuncParams(_y,reactionOnObj,_obj arg getVar(_y,volume))
			};
		} foreach getSelf(reagentList);
	};

	//функцонал метаболизма. эта функция вызывается у всех мобов
	func(metabolize)
	{
		objParams_1(_mob);
		if (getSelf(lastTick) >= 2) then {
			private _overdose = 0;
			private _v = 0;
			private _isOverdosed = false;
			{
				_v = getVar(_x,volume);
				_overdose = callFunc(_x,getOverdose);
				if (_overdose > 0) then {
					_isOverdosed = getVar(_x,isOverdosed);
					if (_v >= _overdose && !_isOverdosed) then {
						_isOverdosed = true;
						setVar(_x,isOverdosed,_isOverdosed);
					};

					if (_isOverdosed) then {
						callFuncParams(_x,onOverdose,_mob);
					};
				};
				

				callFuncParams(_x,onMob,_mob);
			} count (values getSelf(reagentList));
		};

		modSelf(lastTick,+ 1);
	};

	abstract_func(handleReactions);


	//удаляет реагенты пока не останется _amount количества
	func(removeAny)
	{
		objParams_1(_amount);
	};
	

endclass