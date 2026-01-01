// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

struct(VSTStrongArmor) base(VSTBase)

	decl(override) def(name) "VST_CLOTH_STRONGARMOR";

	decl(mesh[]) def(_list) [];

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		private _list = [];
		self setv(_list,_list);
		{
			_x params ["_bias","_slot","_vec","_scale"];
			private _o = createSimpleObject ["a3\structures_f\items\vessels\waterbarrel_f.p3d",[0,0,0],true];
			_o attachTo [self getv(_src),_bias,_slot,true];
			[_o,_vec] call model_SetPitchBankYaw;
			_o setObjectScale _scale;
			_list pushBack _o;
		} foreach [
			[[0,0,0.05],"spine3",[-3,0,0],0.37],
			[[0,0,0],"pelvis",[-180,0,0],0.34],
			[[0,0,-0.15],"rightupleg",[20,0,50],0.23],
			[[0,0,-0.15],"leftupleg",[20,0,-50],0.23]
		];
	}

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		{deleteVehicle _x} foreach (self getv(_list));
		self setv(_list,[]);
	}

endstruct