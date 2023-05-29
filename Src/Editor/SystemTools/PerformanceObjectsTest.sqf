// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\NOEngine\NOEngine.hpp"


init_function(pertest_init)
{
	pertest_handle_renderingChunks = -1;

	pertest_optimalObjectCount = createHashMap; //оптимальное количество объектов
	pertest_optimalObjectCount set [chunkType_item,		40];
	pertest_optimalObjectCount set [chunkType_structure,60];
	pertest_optimalObjectCount set [chunkType_decor,	80];
	
	//imports:
	/*
		noe_posToChunk
		noe_chunkToPos
		noe_collectAroundChunks
	*/
	#include "..\..\host\NOEngine\NOEngine_Shared.sqf"	
}

function(pertest_chunkViewToggle)
{
	if (pertest_handle_renderingChunks==-1) then {
		call pertest_showRenderingChunks;
	} else {
		call pertest_stopRenderingChunks;
	};
}

function(pertest_showRenderingChunks)
{
	pertest_handle_renderingChunks = ["onFrame",pertest_showRendeing_onUpdate] call Core_addEventHandler;
	["Chunks rendering enabled"] call showInfo;
}

function(pertest_showRendeing_onUpdate)
{
		_colorSide = [0,0,0,1];
		{
			_chunk = [getPosATL get3DENCamera, _x] call noe_posToChunk;
			_pos = [_chunk,_x] call noe_chunkToPos;

			_colorSide set [_forEachIndex,1];

			[_chunk,_x,_colorSide] call pertest_drawChunkSquad;

			[_chunk vectorAdd [1,0],_x,_colorSide] call pertest_drawChunkSquad;
			[_chunk vectorAdd [-1,0],_x,_colorSide] call pertest_drawChunkSquad;
			[_chunk vectorAdd [0,1],_x,_colorSide] call pertest_drawChunkSquad;
			[_chunk vectorAdd [0,-1],_x,_colorSide] call pertest_drawChunkSquad;

			[_chunk vectorAdd [1,1],_x,_colorSide] call pertest_drawChunkSquad;
			[_chunk vectorAdd [-1,-1],_x,_colorSide] call pertest_drawChunkSquad;
			[_chunk vectorAdd [-1,1],_x,_colorSide] call pertest_drawChunkSquad;
			[_chunk vectorAdd [1,-1],_x,_colorSide] call pertest_drawChunkSquad;
			
		} foreach [chunkType_item,chunkType_structure,chunkType_decor];
}

function(pertest_stopRenderingChunks)
{
	["onFrame",pertest_handle_renderingChunks] call Core_removeEventHandler;
	pertest_handle_renderingChunks = -1;
	["Chunks rendering disabled"] call showInfo;
}

function(pertest_drawChunkSquad)
{
	params ["_chunk","_type","_color"];
	
	_basicPos = [_chunk,_type] call noe_chunkToPos;
	//TODO cast ray front to camera (center postion) and get Z value
	([(positionCameraToWorld [0,0,0])vectoradd[0,0,-10000]] call golib_om_getRayCastData) params ["","_itPos"];
	if equals(_itPos,vec3(0,0,0)) then {
		_itPos = getPosATL cameraOn;
	};
	_basicPos set [2,(_itPos select 2) + 0.15];
	_linePos = +_basicPos;
	_size = getChunkSizeByType(_type);

	MODARR(_basicPos,0,+ _size / 2);
	MODARR(_basicPos,1,+ _size / 2);

	_tRender = format ["%1:%2[%4] (size:%3)",
		_chunk select 0,
		_chunk select 1,
		_size,
		["Item","Struct","Decor"] select _type
	];
	_basicPos set [2,(_basicPos select 2)+(_forEachIndex * 0.1)];
	drawIcon3D ["", _color, _basicPos, 0.5, 0.5, 0,_tRender,1, 0.03, "TahomaB"];

	drawLine3D [_linePos,_linePos vectorAdd [_size,0,0],_color];
	drawLine3D [_linePos,_linePos vectorAdd [0,_size,0],_color];
	drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,0,0],_color];
	drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [0,_size,0],_color];
	//to up
	
	drawLine3D [_linePos vectorAdd [0,0,0],_linePos vectorAdd [0,0,upside],_color];
	drawLine3D [_linePos vectorAdd [_size,0,0],_linePos vectorAdd [_size,0,upside],_color];
	drawLine3D [_linePos vectorAdd [0,_size,0],_linePos vectorAdd [0,_size,upside],_color];
	drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,_size,upside],_color];
	
}


function(pertest_start)
{
	//! Not work...
	//TODO fix
	private _objList = [];
	{
		if (_x call golib_hasHashData) then {
			if not_equals(golib_com_object,_x) then {
				_objList pushBack _x;
			};
		};
	} foreach (all3DENEntities select 0);

	pertest_internal_listChunks = createHashMapFromArray[
		[chunkType_item,createHashMap],
		[chunkType_structure,createHashMap],
		[chunkType_decor,createHashMap]
	];
	private _cls = [];
	private _overloadedCount = createHashMap;
	{
		_srcObj = _x;
		_cls = [_srcObj] call golib_getClassName;
		{
			_x params ["_typenameCheck","_chType"];
			
			if ([_cls,_typenameCheck] call oop_isTypeOf) exitWith {
				_ch = str([getposatl _srcObj,_chType] call noe_posToChunk);
				_itData = pertest_internal_listChunks get _chType;
				if (_ch in _itData) then {
					(_itData get _ch) pushBack _srcObj;
					if ((count (_itData get _ch)) > (pertest_optimalObjectCount get _chType)) then {
						_overname = _ch + ":"+str _chType;
						_overloadedCount set [_overname,
							[_typenameCheck,
							(pertest_optimalObjectCount get _chType) - 
								(count (_itData get _ch)),
								_ch
							]
						];

					};
				} else {
					_itData set [_ch,[_srcObj]];
				};
			};
		} foreach [["Item",chunkType_item],["IStruct",chunkType_structure],["Decor",chunkType_decor]];
		
	} foreach _objList;

	{
		_y params ["_typename","_amount","_chname"];
		["Обнаружена перегрузка в %1 типа %2 на %3 объектов",_chname,_typename,_amount] call printWarning;
	} foreach _overloadedCount;

	if (count _overloadedCount > 0) then {
		["Обнаружены перегруженные сектора. Проверьте лог"] call showWarning;
		private _list = [];
		{
			(_x splitString ":")params["_chstr","_cht"];
			_ch = parseSimpleArray _chstr;
			_cht = parseNumber _cht;

			_list pushBack [
				format["%1%2",["Item","Struct","Decor"] select _cht,_ch],
				[_ch,_cht]
			]
		} foreach _overloadedCount;

		[
			_list,
			//event on select
			{
				_pos = _data call noe_chunkToPos;
				_cht = _data select 1;
				_pos = _pos vectoradd [getChunkSizeByType(_cht)/2,getChunkSizeByType(_cht)/2,0];
				_lobjs = pertest_internal_listChunks get _cht get (str (_data select 0));
				_mid = 0;
				{
					_pTemp = (getposatl _x) select 2;
					if (_pTemp > _mid) then {
						_mid = _pTemp;
					};
				} foreach _lobjs;
				_pos set [2,_mid];

				move3DENCamera [atltoasl _pos,!true];

				pertest_internal_listChunks = null;
			},
			{
				pertest_internal_listChunks = null;
			},
			null,
			"Выберите чанк для телепортации"
		] call control_createList;

	};
}