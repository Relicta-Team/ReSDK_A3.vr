// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


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