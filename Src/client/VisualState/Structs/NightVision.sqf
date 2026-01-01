// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

namespace(VisualState.Configs,vst_)

struct(VSTEaterNightVision) base(VSTBase)

	decl(override) def(name) "VST_EATER_NIGHTVISION";

	decl(mesh) def(_headMesh) objNull;
	decl(mesh) def(_dummyMesh) objNull;

	decl(override) def(onCreated)
	{
		params ["_ctx"];
		if equals(self callv(getLocalPlayer),self getv(_src)) then {
			private _dummy = [] call vst_createDummyMesh;
			self setv(_dummyMesh,_dummy);
			_dummy attachTo [self getv(_src),[0,0,0],"head",true];
		} else {
			private _object = ["relicta_models\models\mutants\bloatfly.p3d",false] call vst_createDummyMesh;

			private _posData = [[-0.053,0.017,-0.024],[180,-55,0]];
			_object disableCollisionWith player;
			_object attachTo [self getv(_src),_posData select 0,"head",true];
			[_object,_posData select 1] call BIS_fnc_setObjectRotation;
		
			//fix lagvector after 0.8.147
			_object attachTo [self getv(_src),_posData select 0,"head",true];
			_object setobjectScale 0.7;
			
			self setv(_headMesh,_object);
		};
	}

	decl(override) def(onDestroy)
	{
		params ["_ctx"];
		if !isNullReference(self getv(_dummyMesh)) then {
			deleteVehicle (self getv(_dummyMesh));
		};
		deleteVehicle (self getv(_headMesh));
	}

endstruct