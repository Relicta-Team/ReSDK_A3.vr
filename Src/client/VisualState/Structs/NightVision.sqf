// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


struct(VSTEaterNightVision) base(VSTBase)

	def(name) "VST_EATER_NIGHTVISION";

	def(_headMesh) objNull;
	def(_dummyMesh) objNull;

	def(onCreated)
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

	def(onDestroy)
	{
		params ["_ctx"];
		if !isNullReference(self getv(_dummyMesh)) then {
			deleteVehicle (self getv(_dummyMesh));
		};
		deleteVehicle (self getv(_headMesh));
	}

endstruct