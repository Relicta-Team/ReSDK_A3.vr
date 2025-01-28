// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

struct(VSTAttachedObjects) base(VSTBase)
	def(name) "VST_ATTACHED_OBJECTS";

	def(_objList) [];

	def(onCreated)
	{
		params ["_ctx"];
		private _list;
		
		{
			_x params ["_ptr","_model","_bias","_selection","_vec",["_scale",1]];
			private _o = createSimpleObject [_model,[0,0,0],true];
			_o attachTo [self getv(_src),_bias,_selection,true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
			_list pushBack _o;
		} foreach _ctx;
		self setv(_objList,_list);
	}

	def(onDestroy)
	{
		params ["_ctx"];
		{deleteVehicle _x} foreach (self getv(_objList));
	}
endstruct