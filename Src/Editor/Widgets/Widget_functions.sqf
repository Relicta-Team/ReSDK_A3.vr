// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


function(getOpenedDisplay)
{
	displayChild getEdenDisplay
}

function(isDisplayOpened) {!isNullReference(call getOpenedDisplay)}

function(displayOpen)
{
	params ["_eventOrListOnOpen","_eventOrListOnClose",["_customRsc","RscDisplayEmpty"]];

	if !isNullVar(_eventOrListOnOpen) then {
		if equalTypes(_eventOrListOnOpen,[]) then {
			{
				["onDisplayOpen",_x] call Core_addEventHandler
			} foreach _eventOrListOnOpen;
		} else {
			["onDisplayOpen",_eventOrListOnOpen] call Core_addEventHandler
		}
	};
	if !isNullVar(_eventOrListOnClose) then {
		if equalTypes(_eventOrListOnClose,[]) then {
			{
				["onDisplayClose",_x] call Core_addEventHandler
			} foreach _eventOrListOnClose;
		} else {
			["onDisplayClose",_eventOrListOnClose] call Core_addEventHandler
		};
	};

	(getEdenDisplay) createDisplay _customRsc;
	{_x ctrlShow false} foreach (allControls _d);
	
	if (_customRsc == "RscDisplayEmpty") then {
		//debug closer
		(call getOpenedDisplay) displayAddEventHandler [
			"keyDown",
			{
				params ["_obj","_key","_shift","_ctrl","_alt"];
				
				if (_key == KEY_HOME && _shift && cfg_debug_devMode) then {nextFrame(displayClose)};
				
				//тут работают армовские приколы. Насколько я помню если в обработчике дисплея идёт возврат (условный) true то больше ничего обрабатываться в этом событии не будет - Yodes
				if (_key == KEY_ESCAPE) then {true;} else {false;}
			}
		];
	};

	
	["onDisplayOpen"] call Core_invokeEvent;
	
	call getOpenedDisplay;
}

function(displayClose)
{
	params [["_cleanupEvents",true],["_nextFrame",true]];

	["onDisplayClose"] call Core_invokeEvent;

	//cleanup events
	if (_cleanupEvents) then {
		["onDisplayOpen"] call Core_removeAllEventHandlers;
		["onDisplayClose"] call Core_removeAllEventHandlers;
	};

	if (_nextFrame) then {
		nextFrame({(call getOpenedDisplay) closeDisplay 1});
	} else {
		(call getOpenedDisplay) closeDisplay 1;
	};
}

function(createWidget)
{
	params ["_display","_type","_pos","_parent",["_args",[]]];

	private _postevent = {};
	if (_type select [0,1] == "!") then {
		private _splitedType = _type splitString "!";
		#define INDEX_TYPE 0
		#define INDEX_CUSTOM 1

		_type = _splitedType select INDEX_TYPE;
		private _cust = (_splitedType select INDEX_CUSTOM);
		if (_cust == "background") then {
			_postevent = {_this ctrlEnable false;};
		};
		if (_cust == "inphndl") exitwith {
			_postevent = {
				_this ctrlAddEventHandler ["KeyUp",{
					params ["_w","_key"];
					
					// if (_key == KEY_BACKSPACE) exitWith {
						
					// 	forceUnicode 0;
					// 	_text = ctrlText _w;
					// 	_sel = ctrlTextSelection _w;

					// 	_sel params ["_idxDel","_countDel","_tex"];
					// 	_aText = toArray _text;
					// 	if (_countDel != 0) then {
					// 		if (_countDel > 0) then {
					// 			_aText deleteRange [_idxDel,_countDel];
					// 			_w ctrlSetText (toString _aText);
					// 			_w ctrlSetTextSelection [_idxDel,0];
					// 		} else {
					// 			_aText deleteRange [_idxDel+_countDel,abs _countDel];
					// 			_w ctrlSetText (toString _aText);
					// 			_w ctrlSetTextSelection [_idxDel+_countDel,0];
					// 		};

					// 	} else {
					// 		_aText deleteRange [_idxDel-1,1];
					// 		_w ctrlSetText (toString _aText);
					// 		_w ctrlSetTextSelection [_idxDel-1,0];
					// 	};

					// };
					//auto-send by enter press
					if (_key == KEY_RETURN) exitWith {
						//if equals(focusedCtrl getDisplay,_w) then {
							forceUnicode 1;
							
							(ctrlTextSelection _w) params ["_start","_len","_sel"];
							_oldText = ctrlText _w;
							_oldStart = _oldText select [0,_start];
							_oldEnd = _oldText select [_start+_len,count _oldText];
							_w ctrlSetText (_oldStart + (toString[10]) + _oldEnd);
							//["w %1 <<and>> %2",_oldStart,_oldEnd] call printTrace;
							_w ctrlSetTextSelection [_start+_len+1,0];
						//};
					};
				}];
			};
		};
	};

	private _newObject = if (isNil "_parent") then {
		_display ctrlCreate [_type,-1];
	} else {
		_display ctrlCreate [_type,-1,_parent];
	};
	_newObject ctrlsetpixelprecision 2;
	private _jumpmotherctg = "jumpmotherctg" in _args;
	[_newObject,_pos,null,_jumpmotherctg] call widgetSetPosition;
	// if (_type == WIDGETGROUP) then {
	// 	private _pars = [_display,BACKGROUND,_pos,_newObject];
	// 	private _c={
	// 		_b = _this call createWidget;
	// 		_b setBackgroundColor [0.4,0,0,1]
	// 	};
	// 	nextFrameParams(_c,_pars)
	// };
	_newObject call _postevent;

	_newObject
}

function(deleteWidget)
{
	params ["_widget",["_nextFrame",false]];

	if _nextFrame then {
		nextFrameParams({ctrlDelete _this},_widget);
	} else {
		ctrlDelete _widget;
	};
}

function(widgetSetPosition)
{
	params ["_widget","_posarray",["_time",-1],["_jumpmotherctg",false]];
	#define precent_to_real(proc_val) (proc_val / 100)

	_posarray params ["_posx","_posy","_posw","_posh"];

	if (_widget getVariable ['isSquare',false]) then {
		_posw = transformSizeByAR(_posh);
	};

	private _window = ctrlParentControlsGroup _widget;

    //Если находится внутри окна то максимальные размеры берутся от этого окна
    if (!(_window isequalto widgetNull)) then
    {
		if (_jumpmotherctg) then {
			_window = ctrlParentControlsGroup _window;
		};
        private _windPos = ctrlPosition _window; //натив
        private _windW = _windPos select 2;
        private _windH = _windPos select 3;
        _widget ctrlSetPosition [
			precent_to_real(_posx) * _windW,
			precent_to_real(_posy) * _windH,
			precent_to_real(_posw) * _windW,
			precent_to_real(_posh) * _windH
			];

    } else {
        _widget ctrlSetPosition [
			precent_to_real(_posx) * safezoneW + safezoneX,
			precent_to_real(_posy) * safezoneH + safezoneY,
			precent_to_real(_posw) * safezoneW,
			precent_to_real(_posh) * safezoneH
			];
    };

	if (_time != -1) then {
		_widget ctrlcommit _time;
	} else {
		_widget ctrlCommit 0;
	};
}

function(widgetGetSizeFromPrecent)
{
	params ["_WorH","_val"];
	if equalTypes(_WorH,"") then {
		if (_WorH == "W") then {_WorH = 0};
		if (_WorH == "H") then {_WorH = 1};
	};
	if (_WorH == 0) then {
		precent_to_real(_val) * safezoneW + safezoneX
	} else {
		precent_to_real(_val) * safezoneH + safezoneY
	};			
}

function(widgetSetPositionOnly)
{
	params ["_widget","_posarray",["_time",-1]];
	#define precent_to_real(proc_val) (proc_val / 100)

	_posarray params ["_posx","_posy"];

	//if (_widget getVariable ['isSquare',false]) then {
	//	_posw = transformSizeByAR(_posh);
	//};

	private _window = ctrlParentControlsGroup _widget;

    //Если находится внутри окна то максимальные размеры берутся от этого окна
    if (!(_window isequalto widgetNull)) then
    {
        private _windPos = ctrlPosition _window; //натив
        private _windW = _windPos select 2;
        private _windH = _windPos select 3;
        _widget ctrlSetPosition [
			precent_to_real(_posx) * _windW,
			precent_to_real(_posy) * _windH
			];

    } else {
        _widget ctrlSetPosition [
			precent_to_real(_posx) * safezoneW + safezoneX,
			precent_to_real(_posy) * safezoneH + safezoneY
			];
    };

	//if (_time == -2) exitWith {}; //Пока не реализовывать
	if (_time != -1) then {
		_widget ctrlcommit _time;
	} else {
		_widget ctrlCommit 0;
	};
}

function(widgetGetPosition)
{

	(ctrlPosition _this) params ["_xp","_yp","_wp","_hp"];

	private _window = ctrlParentControlsGroup _this;

    if (_window isequalto widgetNull) then
    {
        #define STARTX (0 * safezoneW + safezoneX)
        #define STARTY (0 * safezoneH + safezoneY)
        #define DIAPAZONX ((1 * safezoneW + safezoneX) - STARTX)
        #define DIAPAZONY ((1 * safezoneH + safezoneY) - STARTY)

        _xp = (_xp - STARTX) / (DIAPAZONX / 100);
        _yp = (_yp - STARTY) / (DIAPAZONY / 100);
        _wp = _wp / (1 * safezoneW) * 100;
        _hp = _hp / (1 * safezoneH) * 100;
    } else {
		private _windPos = ctrlPosition _window; //натив
        private _windW = _windPos select 2;
        private _windH = _windPos select 3;

        _xp = _xp / (_windW) * 100;
        _yp = _yp / (_windH) * 100;
        _wp = _wp / (_windW) * 100;
        _hp = _hp / (_windH) * 100;
    };

	[_xp,_yp,_wp,_hp]
}

function(isMouseInsideWidget)
{
	private _wid = _this;
	if equals(_wid,widgetNull) exitWith {false};

	(ctrlPosition _wid) params ["_xp","_xy","_w","_h"];
	(ctrlMousePosition _wid) params ["_mX","_mY"];

	!((_mX < 0 || _mX > _w )  || (_mY < 0 || _mY > _h ))
}

function(isMouseInsidePosition)
{
	params ["_xe","_ye","_xe2","_ye2"];
	(call mouseGetPosition) params ["_xPos","_yPos"];
	if (
		( _xPos > _xe && _xPos < _xe2 ) && (_yPos > _ye && _yPos < _ye2 )
	) exitWith {true};
	false
}

function(getMousePositionInWidget)
{
	if (! (_this call isMouseInsideWidget)) exitWith {[0,0]};


   //Находится на экране
   #define STARTX (0 * safezoneW + safezoneX)
   #define STARTY (0 * safezoneH + safezoneY)
   #define DIAPAZONX ((1 * safezoneW + safezoneX) - STARTX)
   #define DIAPAZONY ((1 * safezoneH + safezoneY) - STARTY)

   (ctrlPosition _this) params ["_xp","_yp","_wp","_hp"];

   getMousePosition params ["_mX","_mY"];

   private _window = ctrlParentControlsGroup _this;

   if (_window isequalto widgetNull) then {

	   _xp = (_xp - STARTX) / (DIAPAZONX / 100);
	   _yp = (_yp - STARTY) / (DIAPAZONY / 100);
	   //добавляем смещение мыши
	   _xp = ((_mX - STARTX) / (DIAPAZONX / 100)) - _xp;
	   _yp = ((_mY - STARTY) / (DIAPAZONY / 100)) - _yp;

	  [_xp,_yp];

   	} else {

	   (ctrlPosition _window) params ["_windX","_windY","_windW","_windH"]; //натив

	   private _ParentWindow = ctrlParentControlsGroup _window;
	   private "_ctgPos";
	   while {!(_ParentWindow isEqualTo widgetNull)} do
	   {
		   _ctgPos = ctrlPosition _ParentWindow;
		   MOD(_windX, + (_ctgPos select 0));
		   MOD(_windY, + (_ctgPos select 1));
		   _ParentWindow = ctrlParentControlsGroup _ParentWindow;
	   };

	   _xp = -(_xp + (_windX - _mX))/ (_windW) * 100;
	   _yp = -(_yp + (_windY - _mY))/ (_windH) * 100;

	  [_xp,_yp];
   }
}

function(widgetSetText)
{
	params ["_obj","_text"];

	if (_text isEqualType "") then {
        //строка
        _obj setStructuredText (parseText _text);
    } else {
        //уже текст
        _obj setStructuredText _text;
    }
}

function(widgetSetPicture)
{
	params ["_obj","_text"];
	_obj ctrlsettext _text;
}

function(widgetGetTextHeight)
{

	private _window = ctrlParentControlsGroup _this;

	private _height = ctrlTextHeight _this;

	if (_window isEqualTo widgetNull) then
    {
        _height = _height / (1 * safezoneH) * 100;
    } else {
        private _windH = ctrlPosition _window; //натив
        _windH = _windH select 3;
        _height = _height / (_windH) * 100;
    };

	_height
}

function(mouseSetPosition)
{
	params ["_xpos","_ypos"];
	#define precent_to_real(proc_val) (proc_val / 100)
    setMousePosition [precent_to_real(_xpos) * safezoneW + safezoneX,precent_to_real(_ypos) * safezoneH + safezoneY];
}

function(mouseGetPosition)
{

	getMousePosition params ["_mX","_mY"];

	//Находится на экране
	#define STARTX (0 * safezoneW + safezoneX)
	#define STARTY (0 * safezoneH + safezoneY)
	#define DIAPAZONX ((1 * safezoneW + safezoneX) - STARTX)
	#define DIAPAZONY ((1 * safezoneH + safezoneY) - STARTY)

	private _xp = ((_mX - STARTX) / (DIAPAZONX / 100));
	private _yp = ((_mY - STARTY) / (DIAPAZONY / 100));

	[_xp,_yp];
}

function(convertScreenCoords)
{
	if (count _this == 0) exitWith {[-100,-100]};
	_this params ["_mX","_mY"];

	//Находится на экране
	#define STARTX (0 * safezoneW + safezoneX)
	#define STARTY (0 * safezoneH + safezoneY)
	#define DIAPAZONX ((1 * safezoneW + safezoneX) - STARTX)
	#define DIAPAZONY ((1 * safezoneH + safezoneY) - STARTY)

	private _xp = ((_mX - STARTX) / (DIAPAZONX / 100));
	private _yp = ((_mY - STARTY) / (DIAPAZONY / 100));

	[_xp,_yp];
}

// Конвертация мировой позиции в экранные координаты. Всегда возвращает vec2
function(positionWorldToScreen)
{
	((worldToScreen _this) call convertScreenCoords)
}

//screenToWorld scripted alternative (ray to distance, not surface)
function(getScreenPointToWorld)
{
    params [["_screenPos",getMousePosition],["_mulDist",1000]];

    setLastError("This function is not implemented in Editor");
}

//Проверяет находится ли позиция внутри другой позиции. Отсчёт позиции с верхнего левого угла всегда
function(isPointInScreenPosition)
{
	params ["_point","_sp"];

	_sp params ["_xe","_ye","_xe2","_ye2"];

	_point params ["_xPos","_yPos"];

	if (
		( _xPos > _xe && _xPos < _xe2 ) && (_yPos > _ye && _yPos < _ye2 )
	) exitWith {true};

	false
}

function(widgetModel_objectHelper)
{
	params ["_func", "_array", ["_scale", 1]];

	private _adjustCam = 1;
	private _topFOV = getResolution select 6;
	private _leftFOV = getResolution select 7;

	private _topLeftX = (_leftFOV-1)*0.5/_leftFOV;
	private _bottomRightX =  1-_topLeftX;
	private _topLeftY = 0;
	private _bottomRightY = 1;

	private _return = [];

	switch (toLower _func) do {
		case ("2d"): {
			_array params ["_pointX", "_z", "_pointY"];

			private _scrX = _pointX * (_bottomRightX - _topLeftX) + _topLeftX;
			private _vX = _leftFOV * (_scrX - 0.5) * _adjustCam * _z;

			private _scrY = _pointY * (_bottomRightY - _topLeftY) + _topLeftY;
			private _vY = _topFOV * (0.5 - _scrY) * _adjustCam * _z;

			_vX = _vX / _scale;
			_vY = _vY / _scale;

			_return = [_vX, _vY, _z];
		};
		case ("3d"): {
			_array params ["_vX", "_vY", "_z"]; // z is distance from screen

			_vX = _vX * _scale;
			_vY = _vY * _scale;

			private _scrX = _vX / (_leftFOV * _adjustCam * _z) + 0.5;
			private _pointX = (_scrX - _topLeftX) / (_bottomRightX - _topLeftX);

			private _scrY = 0.5 - _vY / (_topFOV * _adjustCam * _z);
			private _pointY = (_scrY - _topLeftY) / (_bottomRightY - _topLeftY);

			_return = [_pointX, _z, _pointY];
		};
	};

	_return
}