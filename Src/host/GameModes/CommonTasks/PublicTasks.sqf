// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// ITemGetTask updated. Refactoring this file required

//structure: class, handler, 
taskSystem_internal_list_generator = [
	["ItemGetTask",{
		private _randItems = [
			["Melteshonok",""]
		];
		setSelf(name,"Добыть предмет");
		(pick _randItems) params ["_class","_rpDesc"];
		setSelf(descRoleplay,_rpDesc)
	}]
];

taskSystem_generateTask = {
	(pick taskSystem_internal_list_generator) params ["_class","_handler"];
	
};