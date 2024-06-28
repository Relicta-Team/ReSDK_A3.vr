// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


atmos_spread_cross = {
	//this always must be a copy of atmos_const_aroundChunks
	[
		[0,0,1],
		[0,0,-1],
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0]
	]
};

atmos_spread_cross_ext = {
	[
		[0,0,1],
		[0,0,-1],
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0],
		[1,1,0],
		[1,-1,0],
		[-1,-1,0],
		[-1,1,0]
	]
};

atmos_spread_std_no_z = {
	[
		[1,0,0],
		[-1,0,0],
		[0,1,0],
		[0,-1,0]
	]
};

atmos_const_list_ptrFuncGetSides = [
	atmos_spread_cross,
	atmos_spread_cross_ext,
	atmos_spread_std_no_z
];

// Возвращает набор случайных сторон по запрошенному типу распространения
atmos_getNextRandAroundChunks = {
	params [["_count",1],["_colType",ATMOS_SPREAD_TYPE_NORMAL]];
	

	private _copyArr = call (atmos_const_list_ptrFuncGetSides select _colType);
	
	assert_str(inRange(_count,1,count _copyArr),"Unexpected count '"+(str _count) + "' for type " + (str _colType));

	private _tArr = [];
	for "_i" from 0 to _count-1 do {
		_tArr pushBack (_copyArr deleteAt (randInt(0,count _copyArr-1)));
	};
	_tArr
};