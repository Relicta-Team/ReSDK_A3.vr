// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
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

		private _realPos = [_pos,self getv(radius)] call randomRadius;
		private _class = self getv(class);
		if !isNullVar(_class) then {
			for "_i" from 1 to (self getv(count) callv(getValue)) do {
				private _newObj = [_class,_realPos,_dir] call createGameObjectInWorld;
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
	def(sounds) []
	def(emotes) []
endstruct

struct(CraftRecipeResultModifier)
	def(name) null;
	def(params) [];
	def(__raised) false;

	def(init)
	{
		params ["_paramData"];
		if equalTypes(_paramData,"") exitWith {
			self setv(name,_paramData);
		};

		private _pname = _paramData get "name";
		if not_equalTypes(_pname,"") exitWith {self setv(__raised,true)};

		private _val = _paramData get "value";
		if !isNullVar(_val) exitWith {
			self setv(params,[_val]);	
		};
		_val = _paramData get "parameters";
		if !isNullVar(_val) exitWith {
			self setv(params,[_val]);
		};
	}

	def(str)
	{
		format["%1(%2)",struct_typename(self),self getv(name)]
	}

endstruct