// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


struct(CraftRecipeResult)
	def(class) null;
	def(count) null; //type CraftDynamicCountRange__
	def(radius) 0;
	def(modifiers) null;

	def(_model) null; //model path

	def(init)
	{
		params ["_class","_count"];
		self setv(class,_class);
		self setv(count,struct_newp(CraftDynamicCountRange__,_count));
		self setv(modifiers,[]);

		self setv(_model,getFieldBaseValue(_class,"model"))
	}

	def(str)
	{
		format["%1 %2",self getv(class),(self getv(count))];
	}

	def(onCrafted)
	{
		params ["_craftCtx"];
		
		private _pos = _craftCtx get "position";
		private _dir = _craftCtx get "direction";
		private _usr = _craftCtx get "user";
		private _robj = _craftCtx get "recipe";

		private _class = self getv(class);
		if !isNullVar(_class) then {
			for "_i" from 1 to (_craftCtx get "result_count") do {
				private _realPos = [_pos,self getv(radius)] call randomRadius;
				private _newObj = [_class,_realPos,_dir] call createGameObjectInWorld;
				
				//apply modifiers to created object
				private _modCtxList = _craftCtx get "modifier_context_list";
				traceformat("Start apply craft reslut modifiers (%1) with context %2",count (self getv(modifiers)) arg _modCtxList)
				{
					traceformat("apply craft reslut modifier %1",_x)
					_x callp(onApply,_newObj arg _usr arg _modCtxList select _foreachIndex arg _craftCtx);
				} foreach (self getv(modifiers));
			};
		};

		if ((_craftCtx get "roll_result") == DICE_CRITSUCCESS) then {
			callFuncParams(_usr,localSay,"<t size='1.5'>Критический успех</t>" arg "mind");
		};
		
		callFuncParams(_usr,meSay,"создаёт " + (_robj getv(name)));
	}

	//получает путь до результирующей модели
	def(getModelPath)
	{
		self getv(_model)
	}

endstruct

struct(CraftRecipeInteractResult) base(CraftRecipeResult)
	
	def(radius) 0.01;
	
	def(sounds) []
	def(emotes) []

	def(onCrafted)
	{
		params ["_craftCtx"];
		
		private _pos = _craftCtx get "position";
		private _dir = _craftCtx get "direction";
		private _usr = _craftCtx get "user";
		private _robj = _craftCtx get "recipe";
		private _newObj = nullPtr;
		private _createInHands = _craftCtx getOrDefault ["create_in_hands",false];

		private _class = self getv(class);
		if !isNullVar(_class) then {

			for "_i" from 1 to (_craftCtx get "result_count") do {
				private _realPos = [_pos,self getv(radius)] call randomRadius;
				_newObj = if (_i == 1 && {_createInHands}) then {
					[_class,_usr] call createItemInInventory;
				} else {
					[_class,_realPos,_dir] call createGameObjectInWorld;
				};

				//apply modifiers to created object
				private _modCtxList = _craftCtx get "modifier_context_list";
				traceformat("Start apply craft reslut modifiers (%1) with context %2",count (self getv(modifiers)) arg _modCtxList)
				{
					traceformat("apply craft reslut modifier %1",_x)
					_x callp(onApply,_newObj arg _usr arg _modCtxList select _foreachIndex arg _craftCtx);
				} foreach (self getv(modifiers));
			};
		};

		if ((_craftCtx get "roll_result") == DICE_CRITSUCCESS) then {
			callFuncParams(_usr,localSay,"<t size='1.5'>Критический успех</t>" arg "mind");
		};

		if (count (self getv(sounds)) > 0) then {
			private _snd = pick (self getv(sounds));
			//used soundPathPrep because user can be define wrong song path delimeter "/"
			callFuncParams(_newObj,playSound,soundPathPrep(_snd) arg getRandomPitchInRange(0.7,1.2) arg 5);
		};

		if (count (self getv(emotes)) > 0) then {
			private _msg = pick (self getv(emotes));
			_msg = [_msg,
				createHashMapFromArray[
					["basename", callFuncParams(_newObj,getNameFor,_usr)]
					,["target", _craftCtx get "target_name"]
					,["hand_item", _craftCtx get "hand_item_name"]
				]
			] call csys_format;
			_msg = [_msg] call csys_formatSelector;
			callFuncParams(_usr,meSay,_msg);
		};
		
	}

endstruct

struct(CraftRecipeSystemResult) base(CraftRecipeResult)
	def(radius) 0.01;

	def(onCrafted)
	{
		params ["_craftCtx"];
		
		private _pos = _craftCtx get "position";
		private _dir = _craftCtx get "direction";
		private _usr = _craftCtx get "user";
		private _robj = _craftCtx get "recipe";

		private _class = self getv(class);
		private _resultObjects = [];
		if !isNullVar(_class) then {
			for "_i" from 1 to (self getv(count) callv(getValue)) do {
				private _realPos = [_pos,self getv(radius)] call randomRadius;
				private _newObj = [_class,_realPos,_dir] call createGameObjectInWorld;
				
				_resultObjects pushBack _newObj;

				//apply modifiers to created object
				private _modCtxList = _craftCtx get "modifier_context_list";
				traceformat("Start apply craft reslut modifiers (%1) with context %2",count (self getv(modifiers)) arg _modCtxList)
				{
					traceformat("apply craft reslut modifier %1",_x)
					_x callp(onApply,_newObj arg _usr arg _modCtxList select _foreachIndex arg _craftCtx);
				} foreach (self getv(modifiers));
			};
		};

		_resultObjects
	}
endstruct