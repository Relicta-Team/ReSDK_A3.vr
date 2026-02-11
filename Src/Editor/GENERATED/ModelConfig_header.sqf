// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// Relicta model storage. Relicta.ru

#define allocstorage (createLocation ['cba_namespacedummy',[5,5,5],0,0])
#define _ call regmodel;

core_cfg2model = allocstorage;
core_model2cfg = allocstorage;
core_modelBBX = createHashMap;
core_assoc_model2id = createHashMap;
core_assoc_id2model = createHashMap;
core___m2i_index = 0;

regmodel = {
	params ['_config','_model','_bbx'];
	
	if (isnil{core_cfg2model getVariable _config}) then {
		core_cfg2model setVariable [_config,_model];
		
		core_assoc_model2id set [_config,core___m2i_index];
		core_assoc_id2model set [core___m2i_index,_config];
		core___m2i_index = core___m2i_index + 1;
	} else {
		diag_log text format ['[ERROR regmodel]: config already exists - %1', _config];
	};
	
	_cfgDat = core_model2cfg getVariable _model;
	if (isnil'_cfgDat') then {
		core_model2cfg setVariable [_model,_config];
		
		core_assoc_model2id set [_model,core___m2i_index];
		core_assoc_id2model set [core___m2i_index,_model];
		core___m2i_index = core___m2i_index + 1;
		
		core_modelBBX set [_model,_bbx];
	} else {
		if (_cfgDat isEqualType '') then {
			_cfgDat = [_cfgDat];
			core_model2cfg setVariable [_model,_cfgDat];
		};
		_cfgDat pushBackUnique _config;
	};
};

