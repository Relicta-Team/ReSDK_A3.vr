// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Main functional:



*/

init_function(vcom_relpos_initialize)
{
	vcom_relpos_dataVar = createHashMap;

	//насколько каждая точка может быть от начала координат (для любой оси)
	vcom_relpos_maxPointDistance = 50;
	vcom_relpos_sliderPosChangeDelta = 0.001;
}

function(vcom_relposEditorOpen)
{
	params ["_modelObj"];
	private _sel = ifcheck(isNullVar(_modelObj),call golib_getSelectedObjects,[_modelObj]);
	if (count _sel == 0) exitWith {
		["Выберите объект для открытия редактора позиций"] call showWarning;
	};

	["relpos"] call vcom_openWindow;
	[[50,0,50,100]] call vcom_observ_loadCameraController;

	private _d = call vcom_getDisplay;
	private _ctg = call vcom_getCtg;
	
	[_ctg,[50,0,50,5]] call vcom_createNoGeomWidget;

	private _t = [_d,TEXT,[50,95,50,5],_ctg] call createWidget;
	[_t,null,
		[""]+(notificationSounds select 1 select [1,2])
	] call setNotificationContext;
	["onDisplayClose",{
		[null] call setNotificationContext;
	}] call Core_addEventHandler;

	[_sel select 0,null,false] call vcom_loadModel;
	call vcom_observ_centerAtModel;

	_back = [_d,BACKGROUND,[0,0,50,100],_ctg] call createWidget;
	_back setBackgroundColor [0.3,0.3,0.3,0.8];
	_back ctrlEnable false;

	_ctgInput = [_d,WIDGETGROUP,[0,0,50,100],_ctg] call createWidget;
	
	_ctg setvariable ["allPoints",[]];
	//cleanup memory points
	["onDisplayClose",{{deleteVehicle _x} foreach ((call vcom_getCtg) getvariable "allPoints")}] call Core_addEventHandler;

	//start ypos
	private _curY = 0;

	_lb = [_d,LISTBOX,[0,0,100,30],_ctgInput] call createWidget; modvar(_curY) + 30;
	_ctg setvariable ["_lb",_lb];
	_lb ctrladdeventhandler ["LBSelChanged",{params ["_wid","_idx"];[_idx] call vcom_relpos_updateSelection;}];
	_lb ctrladdeventhandler ["LBDblClick",{params ["_wid","_idx"];
		if (_idx == -1) exitwith {};
		private _sel = call vcom_relpos_getSelectedPoint;
		if !isNullReference(_sel) then {
			[_sel] call vcom_observ_centerAtObject;
		};
	}];
	
	//for "_i" from 0 to 30 do {_lb lbAdd ("test"+str _i);};

	_textName = [_d,TEXT,[0,_curY,100,5],_ctgInput] call createWidget;
	modvar(_curY) + 5;
	[_textName,"<t align='center' size='1.5'>Редактирование позиции точки</t>"] call widgetSetText;


	_zoneRelPos = [_d,WIDGETGROUP,[0,_curY,100,25],_ctgInput] call createWidget;
	modvar(_curY) + 25;
	_back = [_d,BACKGROUND,WIDGET_FULLSIZE,_zoneRelPos] call createWidget;
	_back setBackgroundColor [0.5,0.5,0.5,0.3];

	_ctg setvariable ["_zoneRelPos",_zoneRelPos];

	for "_i" from 0 to 2 do {
		_perbut = 100/3;
		_col = [0,0,0,1];
		_col set [_i,1];

		_t = [_d,TEXT,[0,_perbut*_i,10,_perbut],_zoneRelPos] call createWidget;
		[_t,format["<t align='center' size='2'>%1</t>",["X","Y","Z"] select _i]] call widgetSetText;
		_t ctrlsettextColor _col;

		_inp = [_d,INPUT,[10,_perbut*_i,10,_perbut-8],_zoneRelPos] call createWidget;
		_inp setvariable ["_index",_i];

		_inp ctrladdeventhandler ["KillFocus",{[(_this select 0) getvariable "_index",ctrlText (_this select 0),false] call vcom_relpos_updateSelAtIndex}];

		_slid = [_d,SLIDERWNEW,[10+10,_perbut*_i,80,_perbut-8],_zoneRelPos] call createWidget;
		_slid ctrlSetActiveColor _col;
		_slid ctrlSetForegroundColor _col;
		_slid sliderSetPosition 0;
		_slid sliderSetSpeed [0.1,vcom_relpos_sliderPosChangeDelta,vcom_relpos_sliderPosChangeDelta];
		_slid sliderSetRange [-vcom_relpos_maxPointDistance,vcom_relpos_maxPointDistance];
		_slid setvariable ["_index",_i];

		_slid ctrladdeventhandler ["SliderPosChanged",{[(_this select 0)getvariable "_index",_this select 1,true] call vcom_relpos_updateSelAtIndex}];

		_zoneRelPos setvariable ["_slid_"+str _i,_slid];
		_zoneRelPos setvariable ["_inp_"+str _i,_inp];
	};

	//system buttons:
	{
		_x params ["_ev","_name",["_desc",""]];
		_bt = [_d,BUTTON,[10,_curY,100-20,4],_ctgInput] call createWidget; modvar(_curY) + 5;
		_bt ctrlSetText _name;
		_bt ctrlSetTooltip _desc;

		_bt ctrladdeventhandler ["MouseButtonUp",{nextFrame(missionNamespace getvariable ((_this select 0) getvariable "invFnc"))}];
		_bt setvariable ["invFnc",format["vcom_relpos_%1",_ev]];

	} foreach [
		["createPoint","Добавить точку","Добавляет новую точку"], //add new point with random color
		["saveInClipboard","Сохранить","Сохраняет данные в буфер обмена"], //save to cliboard as native array
		["saveInClipboardOOP","Сохранить (ООП)","Сохраняет данные в буфер обмена с заменой всех запятых на arg"],
		["loadFromClipboard","Загрузить","Загружает массив и создает точки"], //load arrayof relative points from clipboard
		["resetCurPosition","Сброс позиции","Сбрасывает позицию выбранной точки"], //reset pos for current point
		["deletePoint","Удалить точку","Удаляет выбранную точку"], //delete current point
		["deleteAllPoints","Удалить все","Удаляет все точки"], //delete all points
		["exitComponent","Выход","Выйти без сохранения"] //exit witout save
	];
	
	[-1] call vcom_relpos_updateSelection;

	//not working... why?
	//(call vcom_getCtg) setvariable ["handle_drawText",addMissionEventHandler ["draw3D",{call vcom_relpos_onDrawPointName}]];
	//["onDisplayClose",{removemissioneventhandler ["draw3D",(call vcom_getCtg) getvariable "handle_drawText"];}] call Core_addEventHandler;
}

function(vcom_relpos_exitComponent)
{
	call displayClose;
}

function(vcom_relpos_updateList)
{
	private _ctg = call vcom_getCtg;
	private _lb = _ctg getvariable "_lb";
	
	//cleanup
	lbclear _lb;

	//reset selection
	_lb lbSetCurSel -1;

	//create
	{
		_itm = _lb lbAdd (_x getvariable "unicalIDStr");
		_lb lbsetdata [_itm,str _foreachindex];
		_lb lbSetColor [_itm,_x getvariable "color"];
		_lb lbSetTooltip [_itm,format["idx %1 %2",_x getvariable "index",_x getvariable "unicalID"]];
	} foreach (_ctg getvariable "allPoints");

	[-1] call vcom_relpos_updateSelection;
}

function(vcom_relpos_updateSelection)
{
	params ["_idx"];
	//["update seleciton call %1",_idx] call printTrace;
	private _ctg = call vcom_getCtg;
	private _lb = _ctg getvariable "_lb";
	private _zoneRelPos = _ctg getvariable "_zoneRelPos";
	{
		if ((_x getvariable "index")==_idx) then {
			[_x] call vcom_relpos_onSelectPointEffect;
			//_x setobjecttexture [0,"#(argb,8,8,3)color(1,0,0,1)"];
		//} else {
			//_x setobjecttexture [0,"#(argb,8,8,3)color(0,1,0,1)"];
		};
	} foreach (_ctg getvariable "allPoints");
	if (_idx == -1) exitWith {
		_zoneRelPos ctrlEnable false;
		_zoneRelPos ctrlShow false;
	};
	_zoneRelPos ctrlEnable true;
	_zoneRelPos ctrlShow true;

	private _o = call vcom_relpos_getSelectedPoint;

	call vcom_relpos_syncCurrentFromRealPosToVisualInfo;
}

//Получает точку которая выбрана. null если ничего не выбрано
function(vcom_relpos_getSelectedPoint)
{
	private _ctg = call vcom_getCtg;
	private _lb = _ctg getvariable "_lb";
	private _idx = lbcursel _lb;
	if (_idx == -1) exitwith {objnull};
	private _cnt = count(_ctg getvariable "allPoints");
	if (_idx < 0 || _idx>(_cnt-1))exitWith {
		setLastError("Index out of range:"+str _idx+"; Count: "+str _cnt);
		objNull;
	};
	(_ctg getvariable "allPoints") select _idx;
}

function(vcom_relpos_updateSelAtIndex)
{
	params ["_ind","_newval",["_isInEventSlider",false]];
	
	//["%1 - %2",__FUNC__,_this] call printTrace;

	if equalTypes(_newval,"") then {
		_newval = parseNumberSafe(_newval);
	};

	private _ctg = call vcom_getCtg;
	private _lb = _ctg getvariable "_lb";
	_idx = lbcursel _lb;
	if (_idx == -1) exitwith {};

	_newval = clamp(_newval,-vcom_relpos_maxPointDistance,vcom_relpos_maxPointDistance);

	private _points = _ctg getvariable "allPoints";
	private _cur = _points select _idx;
	private _curPos = _cur getvariable "pos";
	_curPos set [_ind,_newval];
	
	_cur setvariable ["pos",_curPos];
	_cur attachto [vcom_visualObject,[_curPos,_cur] call vcom_relpos_applyBiasPointPos];

	//sync from real to visual
	call vcom_relpos_syncCurrentFromRealPosToVisualInfo;
}

function(vcom_relpos_forceUpdatePoint)
{
	params ["_ind","_el","_val"];
	private _ctg = call vcom_getCtg;
	private _points = _ctg getvariable "allPoints";
	if (_ind < 0) exitwith {};
	if (_ind > ((count _points) - 1)) exitWith {};
	private _cur = _points select _ind;
	private _curPos = _cur getvariable "pos";
	_curPos set [_el,_val];

	_cur setvariable ["pos",_curPos];
	_cur attachto [vcom_visualObject,[_curPos,_cur] call vcom_relpos_applyBiasPointPos];

	//sync from real to visual
	call vcom_relpos_syncCurrentFromRealPosToVisualInfo;
}

//Эта функция берет текущую точку и возвращает данные внутрь виджетов слайда и ввода
function(vcom_relpos_syncCurrentFromRealPosToVisualInfo)
{
	private _ctg = call vcom_getCtg;
	private _zoneRelPos = _ctg getvariable "_zoneRelPos";
	private _o = call vcom_relpos_getSelectedPoint;
	if isNullReference(_o) exitwith {};
	private _pos = _o getvariable "pos";

	for "_i" from 0 to 2 do {
		_sli = _zoneRelPos getvariable ("_slid_"+str _i);
		_sli sliderSetPosition (_pos select _i);

		_inp = _zoneRelPos getvariable ("_inp_"+str _i);
		_inp ctrlsettext (str (_pos select _i));
	};
}

function(vcom_relpos_createPoint)
{
	private _ctg = call vcom_getCtg;
	private _pointList = _ctg getvariable "allPoints";
	private _p = "Sign_Arrow_F" createVehicle [0,0,0];
	_p attachto [vcom_visualObject,[[0,0,0],_p] call vcom_relpos_applyBiasPointPos];
	private _color = [rand(0,1),rand(0,1),rand(0,1),1];
	_p setobjecttexture [0,format["#(argb,8,8,3)color(%1)",_color joinString ","]];
	_p setvariable ["pos",[0,0,0]];
	_p setvariable ["color",_color];
	_p setvariable ["index",_pointList pushBack _p];
	
	private _curId = _ctg getvariable ["unicalID_Last",1];
	_p setvariable ["unicalID",_curId];
	_p setvariable ["unicalIDStr",format["Точка %1",_curId]];
	_ctg setvariable ["unicalID_Last",_curId + 1];

	call vcom_relpos_updateList;
}

function(vcom_relpos_deletePoint)
{
	private _p = call vcom_relpos_getSelectedPoint;
	if isNullReference(_p) exitwith {};
	[_p getvariable "index"] call vcom_relpos_deletePointAtIndex;
	//call vcom_relpos_updateSelection;
}

function(vcom_relpos_deletePointAtIndex)
{
	params ["_index"];
	private _ctg = call vcom_getCtg;
	private _list = _ctg getvariable "allPoints";
	if (_index < 0||_index>((count _list) - 1)) exitWith {};

	deleteVehicle (_list deleteAt _index);
	//update indexes
	{
		_x setvariable ["index",_foreachindex];
	} foreach _list;

	call vcom_relpos_updateList;
}

function(vcom_relpos_deleteAllPoints)
{
	for"_I" from 0 to count ((call vcom_getCtg) getvariable "allPoints") - 1 do {
		[0] call vcom_relpos_deletePointAtIndex;
	};
}

function(vcom_relpos_resetCurPosition)
{
	for "_i" from 0 to 1 do {
		[_i,0] call vcom_relpos_updateSelAtIndex;
	};
	//?maybee not need?
	call vcom_relpos_syncCurrentFromRealPosToVisualInfo;
}

function(vcom_relpos_saveInClipboard) {[false] call vcom_relpos_saveInClipboardCommon}

function(vcom_relpos_saveInClipboardOOP) {[true] call vcom_relpos_saveInClipboardCommon}

function(vcom_relpos_saveInClipboardCommon)
{
	params ["_changeCommas"];
	private _ctg = call vcom_getCtg;
	private _list = _ctg getvariable "allPoints";
	private _text = "";
	private _poses = [];

	{
		_poses pushBack (_x getvariable "pos");
	} foreach _list;

	_text = "["+(_poses joinString ",")+"]";
	if (_changeCommas) then {
		_text = [_text,"\,"," arg "] call regex_replace;
	};

	copytoclipboard _text;
}

function(vcom_relpos_loadFromClipboard)
{
	private _str = copyfromclipboard;
	if (_str == "") exitwith {["No data in clipboard"] call showWarning; true};

	private _strBase = _str;
	private _lastErr = "unknown error";
	private _errReturn = {
		if (relicta_debug_internal_isHandledError) then {
			relicta_debug_internal_isHandledError = false;
		};
		[ "%1 - Convert value error: %3 -> %2",__FUNC__,str _strBase,_lastErr] call printError;
		["Ошибка загрузки. Некорректный формат данных в буфере обмена"] call showWarning;
		true
	};
	private _isSuccess = call {
		_str = [_str," arg ",","] call regex_replace;
		private _arr = null;
		_lastErr = "Parsing error";
		private _out = parseSimpleArray _str;
		if (isNullVar(_out) || {count _out == 0}) exitWith _errReturn;
		_arr = _out;
		_lastErr = "Type error";
		if not_equalTypes(_arr,[]) exitWith _errReturn;
		_lastErr = "Array size error";
		if (count _arr != ({equalTypes(_x,[]) && {count _x == 3}} count _arr)) exitwith _errReturn;
		
		//clear
		call vcom_relpos_deleteAllPoints;

		{
			call vcom_relpos_createPoint;

			_x params ["_xp","_yp","_zp"];
			[_foreachindex,0,_xp] call vcom_relpos_forceUpdatePoint;
			[_foreachindex,1,_yp] call vcom_relpos_forceUpdatePoint;
			[_foreachindex,2,_zp] call vcom_relpos_forceUpdatePoint;
		} foreach _arr;

		true
	};
	["%1 - Unhandled exception; Drop errhndl: %2 (%3)",__FUNC__,isNullVar(_isSuccess),_isSuccess] call printTrace;
	if isNullVar(_isSuccess) then {
		call _errReturn;
	};
}

function(vcom_relpos_onDrawPointName)
{
	drawIcon3D ["", [1,0,0,1],  ASLToAGL  getPosASLVisual vcom_visualObject, 0, 0, 0, "TEST", 1, 0.05, "PuristaMedium","center",true];
	{
		drawIcon3D ["", _x getvariable "color", getposatl _x, 0, 0, 0, _x getvariable "unicalIDStr", 1, 0.05, "PuristaMedium"];
	} foreach ((call vcom_getCtg) getvariable "allPoints");
}

function(vcom_relpos_onSelectPointEffect)
{
	params ["_o"];
	private _sethide = { if !isNullReference(_this) then {_this hideObject true} };
	private _setunhide = { if !isNullReference(_this) then {_this hideObject false} };

	private _t = 0;
	for "_i" from 0 to 3 do {
		invokeAfterDelayParams(_sethide,_t,_o); modvar(_t) + 0.1;
		invokeAfterDelayParams(_setunhide,_t,_o); modvar(_t) + 0.1;
	};
}

function(vcom_relpos_applyBiasPointPos)
{
	params ["_pos","_o"];
	(boundingBoxReal _o)params["_b1","_b2"];
	_pos vectoradd [0,0,(_b2 select 2)]
}