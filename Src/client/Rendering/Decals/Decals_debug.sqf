// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\oop.hpp>
#include <..\..\..\host\text.hpp>
/*
	функция отображает на ui все текстуры сверху вниз с подписью.
	Все текстуры покрываются сеткой для определения наиболее оптимального типа текстур
*/
dec_debug_visualizeTexture = {
	
};

dec_debug_init = {
	private _d = call displayOpen;
	_ctgMain = [_d,WIDGETGROUP_H,[0,0,50,100]] call createWidget;
	private _h = 0;
	_datalist = [];
	_d setvariable ["datalist",_datalist];
	//listgen
	for "_i" from 0 to 10 do {
		_mapinfo = createhashmap;
		_datalist set [_i,_mapinfo];
		private _p = [_d,TEXT,[0,_h,100,5],_ctgMain] call createWidget;
		[_p,format["index %1",_i]] call widgetSetText;
		_mapinfo set ["text",_p];
		_h = _h + 5;
		_sizeHPic = 40;
		private _ctgPic = [_d,WIDGETGROUP,[0,_h,50,_sizeHPic],_ctgMain] call createWidget;
		_h = _h + _sizeHPic;
		_pic = [_d,PICTURE,WIDGET_FULLSIZE,_ctgPic] call createWidget;
		_mapinfo set ["pic",_pic];
		_mapinfo set ["ctgPic",_ctgPic];
		private _sizeLine = 1;
		private _lineopac = 0.1;
		for "_xline" from 0 to 100 step 10 do {
			private _p = [_d,TEXT,[_xline,0,_sizeLine,100],_ctgPic] call createWidget;
			_p setBackgroundColor [1,1,1,_lineopac];
			_p ctrlEnable false; // Отключаем взаимодействие
		};
		for "_yline" from 0 to 100 step 10 do {
			private _p = [_d,TEXT,[0,_yline,100,_sizeLine],_ctgPic] call createWidget;
			_p setBackgroundColor [1,1,1,_lineopac];
			_p ctrlEnable false; // Отключаем взаимодействие
		};
		for "_xt" from 0 to 10 do {
			for "_yt" from 0 to 10 do {
				private _p = [_d,TEXT,[_xt*10,_yt*10,10,10],_ctgPic] call createWidget;
				_p setBackgroundColor [1,1,1,_lineopac];
				[_p,format["<t size='0.8'>%1,%2</t>",_xt,_yt]] call widgetSetText;
				_p ctrlsettextcolor [1,1,1,_lineopac];
				_p ctrlEnable false; // Отключаем взаимодействие
			};
		};

		//_ctgPic ctrlenable true;
		_ctgPic ctrlAddEventHandler ["MouseButtonUp",{
			params ["_ctgPic","_button","_xpos","_ypos","_shift","_ctrlKey","_altKey"];
			_type = "body";
			
			// Конвертируем координаты мыши в процентную систему относительно _ctgPic
			(ctrlPosition _ctgPic) params ["_ctgX","_ctgY","_ctgW","_ctgH"];
			
			// Вычисляем процентную позицию внутри виджета (от 0 до 100)
			_localX = ((_xpos - _ctgX) / _ctgW) * 100;
			_localY = ((_ypos - _ctgY) / _ctgH) * 100;
			
			// Округляем до целых процентов (шаг 0.1 в нормализованной системе 0-10)
			_localX = round _localX;
			_localY = round _localY;
			
			// Нормализуем для вывода (0-10)
			_normX = _localX / 10;
			_normY = _localY / 10;
			
			traceformat("mouseButtonUp %1 normalized [%2:%3] percent [%4:%5]",_button arg _normX arg _normY arg _localX arg _localY);
			
			if (_button == 0) then {
				_ctgPic setvariable ["startpos",[_localX,_localY]];
			};
			if (_button == 1) then {
				_ctgPic setvariable ["endpos",[_localX,_localY]];
			};

			[(_ctgPic getvariable "debug_layer")] call deleteWidget;

			(_ctgPic getvariable ["startpos",[0,0]])params [["_xStart",0],["_yStart",0]];
			(_ctgPic getvariable ["endpos",[100,100]])params [["_xEnd",100],["_yEnd",100]];
			
			// Вычисляем размеры как разницу координат
			_xSize = _xEnd - _xStart;
			_ySize = _yEnd - _yStart;
			
			// Округляем размеры до целых процентов (шаг 0.1 в нормализованной системе)
			_xSize = round _xSize;
			_ySize = round _ySize;
			
			// Нормализуем для вывода
			_normStartX = _xStart / 10;
			_normStartY = _yStart / 10;
			_normSizeX = _xSize / 10;
			_normSizeY = _ySize / 10;
			
			_nwid = [getDisplay,TEXT,[_xStart,_yStart,_xSize,_ySize],_ctgPic] call createwidget;

			private _mt = dec_debug_const_layercolors;
			_nwid setBackgroundColor (_mt getOrDefault [_type,[1,0,0,0.3]]);
			_ctgPic setvariable ["debug_layer",_nwid];
			//traceformat("create layer %1 normalized pos [%2,%3] size [%4,%5]",_nwid arg _normStartX arg _normStartY arg _normSizeX arg _normSizeY);
			private _fmtOutput = "normalized(%1,%2:%3,%4)";
			traceformat(_fmtOutput,_normStartX arg _normStartY arg _normStartX+_normSizeX arg _normStartY+_normSizeY);
			copytoclipboard (format["NAME(%1,%2:%3,%4)",_normStartX,_normStartY,_normStartX+_normSizeX,_normStartY+_normSizeY]);
		}];

	};

	_list = [_d,LISTBOX,[50,0,50,40]] call createWidget;

	private _bodyclothlist = ["BodyClothBase",true] call oop_getinhlist;
	{
		_tobj = (typeGetFromString(_x));
		_name = typeGetVar(_tobj,classname);
		private _i = _list lbadd (format["%1 - %2",_foreachindex,_name]);
		_list lbsetdata [_i,_x];
	} foreach _bodyclothlist;
	
	_onSync = {
		params ["_list","_index"];
		private _d = getDisplay;
		private _datalist = _d getvariable "datalist";
		//cleanup
		{
			[(_x get "pic"),""] call widgetSetPicture;
			[_x get "text","<t color='#ff0000'>index outofrange</t>"] call widgetSetText;
		} foreach _datalist;

		private _classname = _list lbData _index;
		private _aclass = getFieldBaseValue(_classname,"armaClass");
		//private _textures = getArray(configFile >> "cfgVehicles" >> _aclass >> "hiddenSelectionsTextures");
		player forceAddUniform _aclass;
		{
			private _map = _datalist select (_foreachindex);
			[(_map get "pic"),_x] call widgetSetPicture;
			[(_map get "text"),format["[%1]::%2",_foreachindex,_x]] call widgetSetText;
		} foreach (getObjectTextures player);
	};
	_list ctrlAddEventHandler ["LBSelChanged",_onSync];


	[_list,0] call _onSync;

	//create texture layers
	_listlayers = [_d,LISTBOX,[50,40,50,40]] call createWidget;
	{
		private _i = _listlayers lbadd (_x select 0);
		
	} foreach dec_debug_layers;
	_syncLayering = {
		params ["_list","_index"];
		_dat = dec_debug_layers select _index select 1;
		//cleanup
		private _d = getDisplay;
		private _datalist = _d getvariable "datalist";
		{
			_ctgPic = _x get "ctgPic";
			{[_x,false] call deleteWidget} foreach (_ctgPic getvariable ["layers",[]]);
		} foreach _datalist;
		{
			private _ctgPic = _datalist select _foreachindex get "ctgPic";
			private _selectionIndex = _foreachindex;
			
			private _rtName = format["dec_debug_layer_%1",_selectionIndex];
			private _dRTTContext = [_rtName] call dec_getRenderContext;
			{[_x] call deleteWidget} foreach (allcontrols _dRTTContext);

			_newlayers = [];
			_ctgPic setvariable ["layers",_newlayers];
			{
				(_x splitstring "(),:") params ["_type","_xStart","_yStart","_xEnd","_yEnd"];
				_xStart = parseNumber _xStart * 10;
				_yStart = parseNumber _yStart * 10;
				_xEnd = (parseNumber _xEnd)* 10;
				_yEnd = (parseNumber _yEnd)* 10;
				_xSize = _xEnd - _xStart;
				_ySize = _yEnd - _yStart;
				
				_nwid = [getDisplay,TEXT,[_xStart,_yStart,_xEnd,_yEnd],_ctgPic] call createwidget;
				private _mt = dec_debug_const_layercolors;
				_nwid setBackgroundColor (_mt getOrDefault [_type,[1,0,0,0.3]]);
				traceformat("create layer %1 at %2 with pos %3",_nwid arg _ctgPic arg vec4(_xStart,_yStart,100-_xEnd,100-_yEnd));
				_newlayers pushBack _nwid;

				//create on unit
				player setobjecttexture [_selectionIndex,"#reset"];
				_orig = getobjecttextures player select _selectionIndex;
				
				player setobjecttexture [_selectionIndex,format['#(argb,2048,2048,1)uiEx(texType:ca,display:RscDisplayEmpty,uniqueName:%1)', _rtName]];
				
				_dRTTContext = [_rtName] call dec_getRenderContext;
				private _p = [_dRTTContext,PICTURE,[28,23,44,54]] call createWidget;
				_p ctrlsetposition [0,0,1,1];
				_p ctrlcommit 0;
				[_p,_orig] call widgetSetPicture;

				_p = [_dRTTContext,TEXT,WIDGET_FULLSIZE] call createWidget;
				_p ctrlsetposition ([_xStart/10,_yStart/10,_xSize/10,_ySize/10]);
				_p ctrlcommit 0;
				_p setBackgroundColor (_mt getOrDefault [_type,[1,0,0,0.3]]);

				[_dRTTContext] call dec_applyContext;
			} foreach (_x splitString ";");
		} foreach _dat;
	};
	[_listlayers,0] call _syncLayering;
	_listlayers ctrlAddEventHandler ["LBSelChanged",_syncLayering];
};

dec_debug_const_layercolors = createHashMapFromArray [
	["body",[0,1,0,0.3]],
	["leg",[0,0,1,0.3]],
	["arm",[1,1,0,0.3]]
];

dec_debug_layers = [
	["empty",[]],
	["l2.std_naked",["body(0,0:10,10);","leg(0,0:4,4);leg(0,5:4,10);arm(5,0:10,6);arm(4,6:6,10)"]]
];