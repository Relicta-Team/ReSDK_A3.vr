// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

struct(VSTAttachedObjects) base(VSTBase)
	decl(override) def(name) "VST_ATTACHED_OBJECTS";

	decl(mesh[]) def(_objList) [];

	decl(override) def(onCreated)
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

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		{deleteVehicle _x} foreach (self getv(_objList));
	}
endstruct