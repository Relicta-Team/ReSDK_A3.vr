// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//debug draw atmos
//#define ATMOS_DEBUG_DRAW

//тесты по порядку: рендер точек соседних зон, рендер пересечений, рендер объектов в чанке
//#define ATMOS_DEBUG_DRAW_INTERSECT_POS
//#define ATMOS_DEBUG_DRAW_INTERSECT_INFO
//#define ATMOS_DEBUG_DRAW_NEAROBJECTS
//#define ATMOS_DEBUG_DRAW_CHUNKOBJECTS
//отладка силы горения
//#define ATMOS_DEBUG_ON_UPDATE
//ручная симуляция
//#define ATMOS_MANAGED_ACTIVITY


#define ATMOS_DEBUG_CREATE_SPHERE(_r,_g,_b) call {private _s = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0]; \
_s setObjectTexture [0,format(["#(rgb,8,8,3)color(%1,%2,%3,1)",_r,_g,_b])]; _s}


atmos_debug_drawCurrentZone = {
	if !isNull(atmos_debug_handleDebugDraw) then {
		stopUpdate(atmos_debug_handleDebugDraw);
	};
	if !isNull(atmos_debug_map_spheres) then {
		{deleteVehicle _y} foreach atmos_debug_map_spheres;
	};

	showHUD true; //for use drawicon3d
	atmos_debug_cntDrwArndHlf = 3;
	atmos_debug_basicPos = getposatl player;

	atmos_debug_map_spheres = createHashMap;

	private _drawFunc = {
		if !isNullReference(findDisplay 49) exitWith {};
		_myPos = atmos_debug_basicPos call atmos_chunkPosToId;
		private _newPosHalf = 0;
		private _newPosBase = 0;

		for "_x" from -atmos_debug_cntDrwArndHlf to atmos_debug_cntDrwArndHlf do {
			for "_y" from -atmos_debug_cntDrwArndHlf to atmos_debug_cntDrwArndHlf do {
				for "_z" from -atmos_debug_cntDrwArndHlf to atmos_debug_cntDrwArndHlf do {
					_mpsChid = (_myPos vectoradd [_x,_y,_z]);
					_newPosHalf = _mpsChid call atmos_chunkIdToPos;
					_newPosBase = _newPosHalf vectordiff [ATMOS_SIZE_HALF,ATMOS_SIZE_HALF,ATMOS_SIZE_HALF];
					_mhlf = atmos_debug_cntDrwArndHlf;
					_color = [
						linearConversion[-_mhlf,_mhlf,_x,0,1,true],
						linearConversion[-_mhlf,_mhlf,_y,0,1,true],
						linearConversion[-_mhlf,_mhlf,_z,0,1,true],
						1
					];
					drawIcon3D ["", _color, _newPosHalf vectoradd [0,0,0.07], 0, 0, 0, format[
						"CH:{%1,%2,%3} ofs:(%4,%5,%6)",
						_mpsChid select 0,_mpsChid select 1,_mpsChid select 2,_x,_y,_z
					], 1, linearConversion [ATMOS_SIZE_HALF,ATMOS_SIZE_HALF*(atmos_debug_cntDrwArndHlf*2),(asltoatl eyepos player) distance (_newPosHalf),0.04,0.02,true], "TahomaB"];

					_keyCh = str _mpsChid;
					if !(_keyCh in atmos_debug_map_spheres) then {
						_sphere = ATMOS_DEBUG_CREATE_SPHERE(_color select 0,_color select 1,_color select 2);
						atmos_debug_map_spheres set [_keyCh,_sphere];
						_sphere setposatl _newPosHalf;
					};


					_sp = _newPosBase;
					_size = ATMOS_SIZE;
					drawLine3D [_sp,_sp vectorAdd [_size,0,0],_color];
					drawLine3D [_sp,_sp vectorAdd [0,_size,0],_color];
					drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,0,0],_color];
					drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [0,_size,0],_color];
					//to up

					drawLine3D [_sp vectorAdd [0,0,0],_sp vectorAdd [0,0,_size],_color];
					drawLine3D [_sp vectorAdd [_size,0,0],_sp vectorAdd [_size,0,_size],_color];
					drawLine3D [_sp vectorAdd [0,_size,0],_sp vectorAdd [0,_size,_size],_color];
					drawLine3D [_sp vectorAdd [_size,_size,0],_sp vectorAdd [_size,_size,_size],_color];

				};
			}
		};

		//drawtext
		#ifdef ATMOS_DEBUG_DRAW_NEAROBJECTS
		if !isNull(atmos_debug_list_chgno) then {
			{
				_optr = _x getvariable "__objectRef";
				_inarea = _x getvariable "__inArea";
				_dist = _x getvariable "__distance";
				drawIcon3D ["", ifcheck(_inarea,vec4(0,1,0,1),vec4(1,0,0,1)), getPosatl _x, 0, 0, 0, format[
						"%1 (%2) - %3%4",
					getVar(_optr,name),callFunc(_optr,getClassName),_inarea,ifcheck(!_inarea,"; dist: " + (str _dist),"")
					], 1, linearConversion [ATMOS_SIZE_HALF*1,ATMOS_SIZE_HALF*5,(asltoatl eyepos player) distance (getPosatl _x),0.04,0.04,true], "TahomaB"];
			} foreach atmos_debug_list_chgno;
		};
		#endif

		#ifdef ATMOS_DEBUG_DRAW_INTERSECT_INFO
		if !isNull(atmos_debug_list_giiSpheres) then {
			_mid = count atmos_debug_list_giiSpheres - 1;
			for "_i" from 0 to (count atmos_debug_list_giiSpheres)-1 step 2 do {
				_s = atmos_debug_list_giiSpheres select _i;
				_e = atmos_debug_list_giiSpheres select (_i+1);
				drawIcon3D ["",[1,0,0,1],getposatl _s,0,0,0,format[
					"%1",_s getvariable "__index"
				],1,0.04, "TahomaB"];

				drawIcon3D ["",[1,0,0,1],getposatl _e,0,0,0,format[
					"%1",_e getvariable "__index"
				],1,0.04, "TahomaB"];

				drawLine3D [getposatl _s,getposatl _e,[1,0,0,1]];
			};
			
		};
		#endif
	};
	atmos_debug_handleDebugDraw = startUpdate(_drawFunc,0);
};

atmos_debug_drawObjectInfo = {
	params ["_aObj"];
	if isNullReference(_aObj) exitWith {};
	private _pos = callFunc(_aObj,getModelPosition);
	private _di = callFunc(_aObj,getDeubgInfo);
	if (_di == "") exitWith {};
	#ifdef ATMOS_MODE_SIMPLE_VISUALIZATION
	_di = _di + (format[" lcf:%1-%2",getVar(_aObj,light),getVar(_aObj,lightIsEnabled)]);
	#endif
	#ifdef ATMOS_MODE_FORCE_OPTIMIZE
	_di = _di + (format[" pwr:%1 (isset:%2)",getVar(_aObj,areaPower),!getVar(_aObj,canDecrementAreaPower)]);
	#endif
	drawIcon3D ["", [0,1,0,1], _pos, 0, 0, 0, _di
	, 1, linearConversion [ATMOS_SIZE_HALF*5,ATMOS_SIZE_HALF*2,(asltoatl eyepos player) distance _pos,0.02,0.04,true], "TahomaB"];
};

atmos_debug_onupdate_internal = {
	showHUD true;
	if !isNullReference(findDisplay 49) exitWith {};
	{
		{
			[_x] call atmos_debug_drawObjectInfo;
		} foreach getVar(_x,aObj);
	} foreach (values atmos_map_chunks);
};

atmos_debug_onupdate_getObjInChunk = {
	
	if !isNullReference(findDisplay 49) exitWith {};
	showHUD true;
	// {
	// 	_ref = _x getvariable "_ref";
	// 	_vec = _x getvariable "_vec";
	// 	private _pos = getPosAtl _x; //callFunc(_ref,getModelPosition);
	// 	drawIcon3D ["", [1,1,0,1], _pos, 0, 0, 0, format[
	// 						"%1",
	// 					_vec
	// 	], 1, linearConversion [ATMOS_SIZE_HALF*1,ATMOS_SIZE_HALF*5,(asltoatl eyepos player) distance _pos,0.04,0.02,true], "TahomaB"];
	// } foreach atmos_debug_list_goic;

	_color = [1,0,0,1];
	{
		_x params ["_sp","_ep"];
		drawLine3D [_sp,_ep,_color];
	} foreach atmos_debug_list_goicSposes;
};

// ---------- initialize debug ----------
#ifdef EDITOR
	//debug cleanup on reload
	if !isNull(atmos_debug_onupdate_handle_internal) then {
		stopUpdate(atmos_debug_onupdate_handle_internal);
	};
	if !isNull(atmos_debug_handleDebugDraw) then {
		stopUpdate(atmos_debug_handleDebugDraw);
	};
	if !isNull(atmos_debug_handle_getObjInChunk) then {
		stopUpdate(atmos_debug_handle_getObjInChunk);
	};
	if !isNull(atmos_debug_map_spheres) then {
		{deleteVehicle _y} foreach atmos_debug_map_spheres;
	};
	atmos_debug_handleDebugDraw = -1;

	if !isNull(atmos_debug_list_chintto) then {{deleteVehicle _x} foreach atmos_debug_list_chintto;};
	if !isNull(atmos_debug_list_giiSpheres) then {{deleteVehicle _x} foreach atmos_debug_list_giiSpheres;};
	if !isNull(atmos_debug_list_goic) then {{deleteVehicle _x} foreach atmos_debug_list_goic;};
#endif

#ifdef ATMOS_DEBUG_ON_UPDATE
atmos_debug_onupdate_handle_internal = startUpdate(atmos_debug_onupdate_internal,0);
#endif

#ifdef ATMOS_DEBUG_DRAW_CHUNKOBJECTS
atmos_debug_handle_getObjInChunk = startUpdate(atmos_debug_onupdate_getObjInChunk,0);
#endif
