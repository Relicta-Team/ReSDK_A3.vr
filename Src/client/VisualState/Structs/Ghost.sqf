// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

struct(VSTGhost) base(VSTBase)
	def(name) "VST_GHOST_EFFECT";

	def(_dummyMesh) objNull;

	def(lock_ghostSyncState) false;

	def(onCreated)
	{
		params ["_ctx"];
		if equals(self callv(getLocalPlayer),self getv(_src)) then {
			private _dummy = [] call vst_createDummyMesh;
			self setv(_dummyMesh,_dummy);
			_dummy attachTo [self getv(_src),[0,0,0],"head",true];

			(self getv(_src)) call cd_fw_syncForceWalk;
			//для самого себя клиент виден
			//звуки шагов вырубаем
			vst_human_stealth_allowStepsounds = false;
		} else {
			//нужно скрыть моба если на нем нет флага
			private _isGhostMe = [player,self getv(name)] call vst_containsConfig;
			if (_isGhostMe) then {
				(self getv(_src)) hideObject false;
			} else {
				(self getv(_src)) hideObject true;
				[self getv(_src),false] call smd_setSlotDataProcessor;
			};
		};

		//пост синхронизация видимости гостов
		if !(self getv(lock_ghostSyncState)) then {
			private _otherUsers = smd_allInGameMobs - [self getv(_src)];
			private _vstGhostObj = null;
			{
				_vstGhostObj = [_x,self getv(name)] call vst_getSourceHandler;
				if !isNullVar(_vstGhostObj) then {
					_vstGhostObj setv(lock_ghostSyncState,true);  
					[_x,"onVisualStates",true] call smd_syncVar;
					_vstGhostObj setv(lock_ghostSyncState,false);
				} else {
					[_x,"onVisualStates",true] call smd_syncVar;
				};
			} foreach _otherUsers; 
		};

		//пост синхронизация частей тела
		[self getv(_src),"onChangeBodyParts",true] call smd_syncVar;
	}

	def(onDestroy)
	{
		params ["_ctx"];
		if !isNullReference(self getv(_dummyMesh)) then {
			deleteVehicle (self getv(_dummyMesh));
			self setv(_dummyMesh,objNull);

			vst_human_stealth_allowStepsounds = true; //возвращаем звуки шагов
		};
		(self getv(_src)) hideObject false;
		[self getv(_src),true] call smd_setSlotDataProcessor;
	}
endstruct