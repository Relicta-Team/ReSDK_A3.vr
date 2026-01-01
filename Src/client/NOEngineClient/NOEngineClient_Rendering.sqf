// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//! this file is deprecated and will be removed

// RENDERING (not optimized). Need rewrite

objLeft = "Sign_Arrow_F" createVehicle [0,0,0];
objRight = "Sign_Arrow_F" createVehicle [0,0,0];
objTemp = "Sign_Arrow_F" createVehicle [0,0,0];
objMode = 0;
prevPosObj = [[0,0],[0,0],[0,0]];
prevStateIsHidden = [false,false,false];

#define vectorFromDir(pos,dir,dist) ((pos) vectorAdd [sin (_eyedir + (dir)) * dist,cos (_eyedir + (dir)) * dist,0])

_rendering = {
	
	_ppos = getPosATL player;
	_eyedir = [0,0,0] getdir (eyeDirection player);
	

	
	{
		//_chunk = [[_ppos,_x] call noe_posToChunk,_x] call noe_client_getPosChunkToData;
		//traceformat("data %1",chunk_getObjectsData(_chunk));
		_size = getChunkSizeByType(_x) /2;
		_vdir = vectordir player;
		//_ppos = _ppos vectorAdd [round(_vdir select 0),round(_vdir select 1)];
		
		_cpos = (([_ppos,_x] call noe_posToChunk) vectorAdd [round(_vdir select 0),round(_vdir select 1)]) select [0,2];
		_curPrev = prevPosObj select _x;
		_psh = prevStateIsHidden select _x;
		_chunk = [_cpos,_x] call noe_client_getPosChunkToData;
		
		#define RayCastCount(obj) (count(lineIntersectsSurfaces [eyePos player, getPosASL obj, player, obj, true, 20,"GEOM","VIEW",false]))
		
		#define setHideMode(mode) \
		prevStateIsHidden set [_x,mode]; \
		{ \
			(_y select chunk_objectData_ptr) hideObject mode; \
		} foreach chunk_getObjectsData(_chunk);
		
		
		#define setHidePrevMode(mode) \
		_chunkPrev = [_curPrev,_x] call noe_client_getPosChunkToData; \
		{ \
			(_y select chunk_objectData_ptr) hideObject mode; \
		} foreach chunk_getObjectsData(_chunkPrev); \
		
		#define state(num) trace('State num')
		
		if not_equals(_cpos,_curPrev) then { //позиция изменилась
			
			setHidePrevMode(false);
			
			//setHideMode(true);
			
			prevPosObj set [_x,_cpos];
		} else {
			{
				_obj = _y select chunk_objectData_ptr;
				if (RayCastCount(_obj) > 2) then {
					_obj hideObject true;
				} else {
					_obj hideObject false;
				};
			} foreach chunk_getObjectsData(_chunk);
		};
	
		
	} forEach noe_client_allChunkTypes;
	
}; //startUpdate(_rendering,1);
if !isNil(thd) then {
		terminate thd;
};
thd = _rendering spawn {
	while {true} do {
	    call _this;
		
	};
};

/*#define renderTracer(t,del) _re = { \
	_ppos = getPosATL player; _eyedir = [0,0,0] getdir (eyeDirection player); \
	_size = getChunkSizeByType(t); \
	objLeft setposatl vectorFromDir(_ppos,-210,_size); \
	objRight setPosATL vectorFromDir(_ppos,210,_size); \
}; startUpdate(_re,del);

DELT = 1;
invokeAfterDelay({renderTracer(0,DELT)},DELT * 1);
invokeAfterDelay({renderTracer(1,DELT + 0.1)},DELT * 2);
invokeAfterDelay({renderTracer(2,DELT + 0.1)},DELT * 3);*/