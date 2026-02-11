// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(NOEngine.Client.ChunkDebug,noe_debug_)

//#define enableDebugDraw 1
//#define enableDebugDrawText 1
//#define enableDebugDrawInfo 1
//#define enableDebugDrawSectors 1

inline_macro
#define upside _size

#ifdef RELEASE
	#undef enableDebugDraw
	#undef enableDebugDrawText
	#undef enableDebugDrawInfo
	#undef enableDebugDrawSectors
#endif

decl(bool)
noe_debug_canDrawInfo = !isNull(enableDebugDrawInfo);

	decl(void(vector2;int;vector4))
	noe_debug_drawChunkSides_player = {
		params ["_chunk","_type","_color"];

		_basicPos = [_chunk,_type] call noe_chunkToPos;
		_basicPos set [2,getPosATL player select 2];
		_linePos = +_basicPos;
		_size = getChunkSizeByType(_type);

		MODARR(_basicPos,0,+ _size / 2);
		MODARR(_basicPos,1,+ _size / 2);
/*
		dont uncomment this (may be error)
		#ifdef enableDebugDrawText

			drawIcon3D ["", [1,1,1,1], _basicPos , .5, .5, 0,
				format["%1:%2 (size:%3)",
				_chunk select 0,_chunk select 1,_size
				], 1, 0.03, "TahomaB"];
		#endif
*/
		drawLine3D [_linePos,_linePos vectorAdd [_size,0,0],_color];
		drawLine3D [_linePos,_linePos vectorAdd [0,_size,0],_color];
		drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,0,0],_color];
		drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [0,_size,0],_color];
		//to up
		
		drawLine3D [_linePos vectorAdd [0,0,0],_linePos vectorAdd [0,0,upside],_color];
		drawLine3D [_linePos vectorAdd [_size,0,0],_linePos vectorAdd [_size,0,upside],_color];
		drawLine3D [_linePos vectorAdd [0,_size,0],_linePos vectorAdd [0,_size,upside],_color];
		drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,_size,upside],_color];
	};
	
	decl(void(vector2;int;vector4))
	noe_debug_drawChunkInfo = {
		params ["_chunk","_type","_color"];
		private _chunkObject = [_chunk,_type] call noe_client_getPosChunkToData;
		_state = ["NOT_LOADED","PROGR","DONE"] select chunk_getLoadingState(_chunkObject);
		
		_basicPos = [_chunk,_type] call noe_chunkToPos;
		_basicPos set [2,getPosATL player select 2];
		_linePos = +_basicPos;
		_size = getChunkSizeByType(_type);

		MODARR(_basicPos,0,+ _size / 2);
		MODARR(_basicPos,1,+ _size / 2);
		
		_ocount = 0;
		_serializeOD = {
			params ["_odata","_color"];
			
			_ocount = count _odata;
			//_s = "";
			//_cnt = 0;
			{
				//_x - ptr
				//_y[0] - ref, _y[1] -dat
				_posobj = getPosATL(_y select 0);
				if ((getPosATL player distance _posobj) > 60) then {continue};
				
				_k = 5 / (getPosATL player distance _posobj);
				
				drawIcon3D ["", _color, _posobj, 1, 1, 0, format[
					//#ifndef NOE_CLIENT_THREAD_DEBUG
					"*%1(%2)",
					_x,_y select 0
					/*#else
					"*%1(%2)[lu:%3;cf:%4]%5",
					_x,_y select 0,(_y select 0) getVariable ["last_update_flag","ERRUPDF"],
					(_y select 0)getVariable ["create_flag","ERRCF"],
					ifcheck((_y select 0)getVariable["mark_del" arg false],"DESTROY THRD","")
					#endif*/
				], 1, 0.04 * _k, "RobotoCondensed"];
				
				/*_strdata = format["*%1(%2); ",_x,_y select 0];
				modvar(_s) + _strdata;
				modvar(_cnt) + (count _strdata);
				if (_cnt > 128) then {modvar(_s)+endl;_cnt = 0;};*/
			} foreach _odata;
			//if (_s == "") exitWith {"no_objs"};
			//_s
		};
		
		[chunk_getObjectsData(_chunkObject),_color] call _serializeOD;
		
		drawIcon3D ["", _color, _basicPos, 0, 0, 0, format[
			"CH:%1-%2 (%3 t) cnt:%4",
			_type,_state,chunk_getLastTicktimeUpdate(_chunkObject),_ocount
		], 1, 0.04, "TahomaB"];
		
		
	};

decl(void())
noe_debug_enableDebugDrawChunks = {
	#ifdef enableDebugDraw
		showHUD true;
		private _code = {

			_colorSide = [0,0,0,1];
			{
				_chunk = [getPosATL player, _x] call noe_posToChunk;
				_pos = [_chunk,_x] call noe_chunkToPos;

				_colorSide set [_forEachIndex,1];

				[_chunk,_x,_colorSide] call noe_debug_drawChunkSides_player;

				[_chunk vectorAdd [1,0],_x,_colorSide] call noe_debug_drawChunkSides_player;
				[_chunk vectorAdd [-1,0],_x,_colorSide] call noe_debug_drawChunkSides_player;
				[_chunk vectorAdd [0,1],_x,_colorSide] call noe_debug_drawChunkSides_player;
				[_chunk vectorAdd [0,-1],_x,_colorSide] call noe_debug_drawChunkSides_player;

				[_chunk vectorAdd [1,1],_x,_colorSide] call noe_debug_drawChunkSides_player;
				[_chunk vectorAdd [-1,-1],_x,_colorSide] call noe_debug_drawChunkSides_player;
				[_chunk vectorAdd [-1,1],_x,_colorSide] call noe_debug_drawChunkSides_player;
				[_chunk vectorAdd [1,-1],_x,_colorSide] call noe_debug_drawChunkSides_player;
				
				//draw info
				if (noe_debug_canDrawInfo) then {
					_dist = getChunkSizeByType(_x);
					[_chunk,_x,_colorSide] call noe_debug_drawChunkInfo;
					inline_macro
					#define remap_ch(x,y) [(getPosATL player) vectorAdd [x*_dist,y*_dist],_x] call noe_posToChunk
					//other chunks checker
					[remap_ch(1,0),_x,_colorSide] call noe_debug_drawChunkInfo;
					[remap_ch(-1,0),_x,_colorSide] call noe_debug_drawChunkInfo;
					[remap_ch(0,1),_x,_colorSide] call noe_debug_drawChunkInfo;
					[remap_ch(0,-1),_x,_colorSide] call noe_debug_drawChunkInfo;
		
					[remap_ch(1,1),_x,_colorSide] call noe_debug_drawChunkInfo;
					[remap_ch(-1,-1),_x,_colorSide] call noe_debug_drawChunkInfo;
					[remap_ch(-1,1),_x,_colorSide] call noe_debug_drawChunkInfo;
					[remap_ch(1,-1),_x,_colorSide] call noe_debug_drawChunkInfo;
				};
				
			} foreach [chunkType_item,chunkType_structure,chunkType_decor];
		};
		startUpdate(_code,0);
	#endif
};


	inline_macro
	#define startSectorIndex 1
	inline_macro
	#define sectorSize 1
	
	decl(vector3())
	noe_debug_sector_redraw = {
		(getPosATL player) params ["_x","_y","_z"];
	
		[
			floor(_x / sectorSize) + startSectorIndex,
			floor(_y / sectorSize) + startSectorIndex,
			floor(_z / sectorSize) + startSectorIndex
		]
	};
	
	decl(void(vector3;vector4))
	noe_debug_drawSectorSides_player = {
		params ["_chunk","_color"];
		
		_draw = {
			_this params ["_chunkX","_chunkY","_chunkZ"];
			private _chunkSize = sectorSize;
		
			[(_chunkX - startSectorIndex) * _chunkSize,(_chunkY - startSectorIndex) * _chunkSize,(_chunkZ - startSectorIndex) * _chunkSize]
		};
		_basicPos = (_chunk) call _draw;
		_basicPos set [2,getPosATL player select 2];
		_linePos = +_basicPos;
		_size = 1;

		MODARR(_basicPos,0,+ _size / 2);
		MODARR(_basicPos,1,+ _size / 2);

		drawLine3D [_linePos,_linePos vectorAdd [_size,0,0],_color];
		drawLine3D [_linePos,_linePos vectorAdd [0,_size,0],_color];
		drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,0,0],_color];
		drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [0,_size,0],_color];
		//to up
		
		drawLine3D [_linePos vectorAdd [0,0,0],_linePos vectorAdd [0,0,upside],_color];
		drawLine3D [_linePos vectorAdd [_size,0,0],_linePos vectorAdd [_size,0,upside],_color];
		drawLine3D [_linePos vectorAdd [0,_size,0],_linePos vectorAdd [0,_size,upside],_color];
		drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,_size,upside],_color];
	};

decl(void())
noe_debug_enableDebugDrawSectorsChunks = {
	#ifdef enableDebugDrawSectors
		private _code = {
			_chunk = call noe_debug_sector_redraw;
			_colorSide = [1,0,0,1];
			//for "_z" from -5 to 5 do {
				for "_y" from -5 to 5 do {
					for "_x" from - 5 to 5 do {
						[_chunk vectorAdd [_x,_y],_colorSide] call noe_debug_drawSectorSides_player;
					};
				};
			//};
			/*[_chunk vectorAdd [1,0],_colorSide] call noe_debug_drawSectorSides_player;
			[_chunk vectorAdd [-1,0],_colorSide] call noe_debug_drawSectorSides_player;
			[_chunk vectorAdd [0,1],_colorSide] call noe_debug_drawSectorSides_player;
			[_chunk vectorAdd [0,-1],_colorSide] call noe_debug_drawSectorSides_player;

			[_chunk vectorAdd [1,1],_colorSide] call noe_debug_drawSectorSides_player;
			[_chunk vectorAdd [-1,-1],_colorSide] call noe_debug_drawSectorSides_player;
			[_chunk vectorAdd [-1,1],_colorSide] call noe_debug_drawSectorSides_player;
			[_chunk vectorAdd [1,-1],_colorSide] call noe_debug_drawSectorSides_player;*/
		};
		startUpdate(_code,0);
	#endif

};

#undef upside