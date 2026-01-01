// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\NOEngine\NOEngine.hpp"


init_function(pertest_init)
{
	pertest_handle_renderingChunks = -1;

	pertest_optimalObjectCount = createHashMap; //оптимальное количество объектов
	pertest_optimalObjectCount set [chunkType_item,		80];
	pertest_optimalObjectCount set [chunkType_structure,100];
	pertest_optimalObjectCount set [chunkType_decor,	150];
	
	pertest_handle_perfChunk = -1;
	pertest_perfChunk_lastUpdate = 0;
	pertest_perfChunk_updateDelay = 1.5;
	pertest_perfChunk_objList = [];

	pertest_perfChunk_cachedRender = [];

	//imports:
	/*
		noe_posToChunk
		noe_chunkToPos
		noe_collectAroundChunks
	*/
	#include "..\..\host\NOEngine\NOEngine_Shared.sqf"	
}

function(pertest_chunkPerformanceToggle)
{
	if (pertest_handle_perfChunk == -1) then {
		pertest_handle_perfChunk = ["onFrame",pertest_perfChunkOnUpdate] call Core_addEventHandler;
	} else {
		["onFrame",pertest_handle_perfChunk] call Core_removeEventHandler;
		pertest_handle_perfChunk = -1;
	};
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
		_allColors = [
			[((["Item","Class","ColorClass"] call goasm_attributes_getValues) select 0)] call color_HTMLtoRGBA,
			[((["IStruct","Class","ColorClass"] call goasm_attributes_getValues) select 0)] call color_HTMLtoRGBA,
			[((["Decor","Class","ColorClass"] call goasm_attributes_getValues) select 0)] call color_HTMLtoRGBA
		];
		

		{
			_chunk = [getPosATL get3DENCamera, _x] call noe_posToChunk;
			_pos = [_chunk,_x] call noe_chunkToPos;

			_colorSide = _allColors select _foreachIndex;

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
		_itPos = getPosATL get3DENCamera;
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
	_upside = _size;
	_wdt = [10,20,50] select _type;
	drawLine3D [_linePos,_linePos vectorAdd [_size,0,0],_color,_wdt];
	drawLine3D [_linePos,_linePos vectorAdd [0,_size,0],_color,_wdt];
	drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,0,0],_color,_wdt];
	drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [0,_size,0],_color,_wdt];
	//to up
	
	drawLine3D [_linePos vectorAdd [0,0,0],_linePos vectorAdd [0,0,_upside],_color,_wdt];
	drawLine3D [_linePos vectorAdd [_size,0,0],_linePos vectorAdd [_size,0,_upside],_color,_wdt];
	drawLine3D [_linePos vectorAdd [0,_size,0],_linePos vectorAdd [0,_size,_upside],_color,_wdt];
	drawLine3D [_linePos vectorAdd [_size,_size,0],_linePos vectorAdd [_size,_size,_upside],_color,_wdt];
	
}

function(pertest_perfChunkOnUpdate)
{
	if (tickTime > pertest_perfChunk_lastUpdate) then {
		call pertest_perfChunk_collectObjects;
		pertest_perfChunk_lastUpdate = tickTime + pertest_perfChunk_updateDelay;
		pertest_perfChunk_cachedRender = []; //cache cleanup
	};
	//draw info
	_chunkTypes = [chunkType_item,chunkType_structure,chunkType_decor];
	_curDrawedChunks_ALL = [createHashMap,createHashMap,createHashMap];
	
	_curDrawedChunks = null;
	_curChType = -1;

	_myPos = getPosATL get3DENCamera;
	{
		_curChType = _chunkTypes select _foreachIndex;
		_curDrawedChunks = _curDrawedChunks_ALL select _foreachIndex;
		_myChunkPos = [_myPos,_curChType] call noe_posToChunk;
		
		{
			_ch = [getPosAtl _x,_curChType] call noe_posToChunk;
			//if (_ch distance _myChunkPos > 2) then {continue};

			_chStr = str _ch;
			
			if (_chStr in _curDrawedChunks) then {
				_cdcObj = (_curDrawedChunks get _chStr);
				_cdcObj set [1,(_cdcObj select 1) + 1];
			} else {
				_curDrawedChunks set [_chStr,[
					[_ch,_curChType] call noe_chunkToPos,
					1,
					_ch
				]]
			};
		} foreach _x; //_x is objectList
	} foreach pertest_perfChunk_objList;

	([(positionCameraToWorld [0,0,0])vectoradd[0,0,-10000]] call golib_om_getRayCastData) params ["","_itPos"];
	if equals(_itPos,vec3(0,0,0)) then {
		_itPos = getPosATL get3DENCamera;
	};

	//["Draw chunks %1",_curDrawedChunks_ALL apply {count _x}] call printTrace;
	if (count pertest_perfChunk_cachedRender > 0) exitWith {
		{
			drawIcon3D _x;
		} foreach pertest_perfChunk_cachedRender;
	};


	_zPos = _itPos select 2;
	{
		_curChType = _chunkTypes select _foreachIndex;
		
		_chName = ["Item","Struct","Decor"] select _foreachIndex;
		
		
		{
			_y params ["_basicPos","_count","_chunk"];

			//["draw %1 = %2 %3",_chName,_basicPos,_count] call printTrace;

			_size = getChunkSizeByType(_curChType);
			MODARR(_basicPos,0,+ _size / 2);
			MODARR(_basicPos,1,+ _size / 2);

			if ((_basicPos select [0,2]) distance (_myPos select [0,2]) > _size * 2) then {continue};


			_maxCount = pertest_optimalObjectCount get _curChType;
			_color = [0,1,0,1];
			_budgetText = "";
			_textSize = 0.05;
			if (_count > _maxCount) then {
				_budgetText = format["Бюджет превышен на %1 объектов (загружено %2%3)",_count - _maxCount,(_count*100/_maxCount),"%"];
				_color = [1,0,0,1];
				_textSize = 0.07;
			} else {
				_budgetText = "Оптимально";
				_colAdd = linearConversion [precentage(_maxCount,70),_maxCount,_count,0,1,true];
				_color set [0,_colAdd];
				if (_colAdd > 0) then {
					_budgetText = "Приемлемо"
				};
				if (_colAdd > 0.5) then {_budgetText = "Допустимо"};
				_budgetText = format["%1 (%2%3)",_budgetText,(_count*100/_maxCount),"%"];
			};

			_tRender = format ["%4:%2 = %1; %3",
				_count,
				_chName,
				_budgetText,
				_chunk
			];
			_basicPos set [2,_zPos+0.2+(_forEachIndex * 0.1)];
			pertest_perfChunk_cachedRender pushBack ["", _color, _basicPos, 0.5, 0.5, 0,_tRender,1, _textSize, "TahomaB"];
			//drawIcon3D ["", _color, _basicPos, 0.5, 0.5, 0,_tRender,1, _textSize, "TahomaB"];

		} foreach _x;
	} foreach _curDrawedChunks_ALL;
}

function(pertest_perfChunk_collectObjects)
{
	_basePos = getPosATL get3DENCamera;
	_collectDist = (chunkSize_decor *1.5)*2;
	//_collectDist = coldist;
	_campos = _basePos;
	_objList = (_campos select [0,2]) nearObjects _collectDist; //nearestObjects [_campos,[],_collectDist,true];
	
	_class = null;
	_curObj = null;
	_typeassoc = ["Item","IStruct","Decor"];
	
	//хранилище объектов по типам чанков
	_objChunks = [];
	_objChunks resize (count _typeassoc);
	_objChunks = _objChunks apply {[]};
	
	{
		_curObj = _x;
		_class = [_curObj] call golib_getClassName;
		if !isNullVar(_class) then {
			{
				if ([_class,_x] call oop_isTypeOfBase) exitWith {
					(_objChunks select _foreachIndex) pushBack _curObj;
				};
			} foreach _typeassoc;
		};
	} foreach _objList;

	pertest_perfChunk_objList = _objChunks;
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