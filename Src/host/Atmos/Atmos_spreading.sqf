// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

//#define ATMOS_DEBUG_TRY_IGNITE

#ifdef ATMOS_DEBUG_TRY_IGNITE
    #define ignite_info(v) if equals(atmos_debug_ignite_ptr,getVar(_obj,pointer)) then {traceformat("atmos::tryIgnite() [%1] - %2",_obj arg v)};
    atmos_debug_ignite_ptr = "";
#else
    #define ignite_info(v) 
#endif
//попытка зажечь область при нахождении предметов рядом
atmos_tryIgnite = {
    params ["_obj"];
	
	#ifdef SP_MODE
		sp_checkWSim("atmos");
	#endif

	ASP_REGION("atmos_tryIgnite: "+(str _obj))

    ignite_info("Check process from >>>>>>>>>>>>>>>" + str _obj + "; deleted: " + str isdeleted(_obj))
    if callFunc(_obj,isFlying) exitWith {
        ignite_info("OBJECT IS FLYING")
        false
    };

    private _pos = callFunc(_obj,getPos);
    private _chObj = [_pos call atmos_chunkPosToId] call atmos_getChunkAtChId;
    ignite_info("   Check chunk: " + str _chObj)
        
	//already flamed
	if (_chObj callv(hasFire)) exitWith {
		ignite_info("   - already inflamed")
	};

	ignite_info("   - objcount: " + str (_chObj callv(getObjectsInChunk)))

	private _mat = nullPtr;
	{
		if equals(_obj,_x) then {continue};
		_mat = callFunc(_x,getMaterial);
		if !isNullReference(_mat) then {
			ignite_info("   - precheck material object " + str _x)
			if prob(callFunc(_mat,getFireDamageIgniteProb)) then {
				ignite_info("   - postcheck object " + str _x)
				
				if getVar(_obj,_lockedCanIgnite) exitWith {}; //temp exit to avoid crafted

				if callFuncParams(_obj,checkCanIgniteObject,_x) then {
					[_pos,"AtmosAreaFire",true] call atmos_createProcess;
					break;
				};
			};
		};
	} foreach (_chObj callv(getObjectsInChunk));

};