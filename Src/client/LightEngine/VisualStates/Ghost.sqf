// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



regVST(VST_GHOST_EFFECT)
	_vstghostflag = "ghost_flag";
	_dummyObjRef = "ghost_nightvision_dummyobj";
	
	//localPlayer = objnull;
	VSTCreate {
		[src,_vstghostflag,true] call le_vst_regVar;
		if equals(localPlayer,src) then {
			// ["ghost_color",true] call pp_setEnable;
			// ["ghost_color_overlay",true] call pp_setEnable;
			// private _skipGrain = equalTypes(vstParams,[]) && {"no_gray" in vstParams};
			// if (!_skipGrain) then {
			// 	["ghost_grain",true] call pp_setEnable;
			// };
			
			private _dummy = [] call le_vst_createDummyObj;
			[src,_dummyObjRef,_dummy] call le_vst_regVar;
			_dummy attachTo [src,[0,0,0],"head",true];
			
			//create NightVision
			//[
			//	[LIGHT_AREA_GHOST_NIGHTVISION,_dummy] call le_loadLight
			//] call os_light_registerAsNoProcessedLight;
			
			src call cd_fw_syncForceWalk;
			//для самого себя клиент виден
			//звуки шагов вырубаем
			vst_human_stealth_allowStepsounds = false;
			
		} else {
			//нужно скрыть моба если на нем нет флага
			private _flag = [player,_vstghostflag] call le_vst_getVar;
			private _isGhostMe = !isNullVar(_flag);
			if (_isGhostMe) then {
				src hideObject false;
			} else {
				src hideObject true;
				[src,false] call smd_setSlotDataProcessor;
			};
			
		};
		
		//пост синхронизация видимости гостов
		if isNullVar(__FLAG_VST_GHOST_SYNC_STATE__) then {
			__FLAG_VST_GHOST_SYNC_STATE__ = true;
			{
				[_x,"onVisualStates",true] call smd_syncVar;
			} foreach (smd_allingamemobs-[src]);
		};

		
		//пост синхронизация частей тела
		[src,"onChangeBodyParts",true] call smd_syncVar;
	};
	VSTDestroy {
		
		_dummy = [src,_dummyObjRef] call le_vst_getVar;
		if !isNullVar(_dummy) then {
			//[_dummy] call le_unloadLight;
			[src,_dummyObjRef] call le_vst_remVar;
			deleteVehicle _dummy;
			// ["ghost_color",false] call pp_setEnable;
			// ["ghost_color_overlay",false] call pp_setEnable;
			// ["ghost_grain",false] call pp_setEnable;
			
			vst_human_stealth_allowStepsounds = true; //возвращаем звуки шагов
		};
		_dummy = [src,_vstghostflag] call le_vst_getVar;
		if !isNullVar(_dummy) then {[src,_vstghostflag] call le_vst_remVar};
		src hideObject false;
		[src,true] call smd_setSlotDataProcessor;
	};
endRegVST