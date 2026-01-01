// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\keyboard.hpp"
#include "widgets.hpp"


#include <..\..\host\lang.hpp>

namespace(WidgetSystem,widget_)

/*
=========================================================================

		GROUP: common

=========================================================================
*/
inline_macro
#define HOME_PROTECT if (_key == KEY_HOME) then {call displayClose}

// Открыть дисплей
decl(display())
displayOpen = {

	if (isDisplayOpen) exitWith {displayNull};

	private _isCreated = createDialog "mainDisplay";

	if (!_isCreated) exitWith {displaynull};

	private _display = getDisplay;

	_display displayAddEventHandler ["keyDown",
		{
			params ["_obj","_key"];

			//на случай если кто-то сдолбоёбится...
			#ifndef RELEASE
            HOME_PROTECT;
			#endif
            //тут работают армовские приколы. Насколько я помню если в обработчике дисплея идёт возврат (условный) true то больше ничего обрабатываться в этом событии не будет - Yodes
            if (_key == KEY_ESCAPE) then {true;} else {false;}
		}];

	//TODO dynamic mode
	//(findDisplay 46) createDisplay "mainDisplay"

	_display
};

// Открыть динамический дисплей
decl(display())
dynamicDisplayOpen = {
	if (isDisplayOpen) exitWith {displayNull};

	(findDisplay 46) createDisplay "mainDisplay";

	//if (!_isCreated) exitWith {displaynull};

	private _display = getDisplay;
	_display setvariable ["$dynflag$",true];

	_display displayAddEventHandler ["keyDown",
		{
			params ["_obj","_key"];

			//на случай если кто-то сдолбоёбится...
			#ifndef RELEASE
            HOME_PROTECT;
			#endif

			//тут работают армовские приколы. Насколько я помню если в обработчике дисплея идёт возврат (условный) true то больше ничего обрабатываться в этом событии не будет - Yodes
			if (_key == KEY_ESCAPE || {ADDRULE_FORBIDDEN_BUTTONS(_key) || {[_key] call input_movementCheck}}) then {true;} else {false;}
		}];

	//antistrafe handler
	_display displayAddEventHandler ["keyUp",{
		_this call strafeLock_onKeyUp
	}];

	_display
};

// Закрыть дисплей
decl(void())
displayClose = {
	getDisplay closeDisplay 0
};

// Создать виджет
decl(widget(display;string;vector4;widget))
createWidget = {
	params ["_display","_type","_pos","_parent"];
	private _postevent = {};
	if (_type select [0,1] == "!") then {
		private _splitedType = _type splitString "!";
		#define INDEX_TYPE 0
		#define INDEX_CUSTOM 1

		_type = _splitedType select INDEX_TYPE;
		private _cust = _splitedType select INDEX_CUSTOM;
		if (_cust == "background") exitwith {
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
						if equals(focusedCtrl getDisplay,_w) then {
							_w ctrlSetText (ctrlText _w + endl);
						};
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
	[_newObject,_pos] call widgetSetPosition;

	_newObject call _postevent;

	_newObject
};

// Удалить виджет
decl(void(widget;bool))
deleteWidget = {
	params ["_widget",["_nextFrame",false]];

	if _nextFrame then {
		nextFrameParams({ctrlDelete _this},_widget);
	} else {
		ctrlDelete _widget;
	};
};

/*
=========================================================================

		GROUP: POSITIONS

=========================================================================
*/
//Устанавливает новую позицию виджету
decl(void(widget;vector4;float))
widgetSetPosition = {
	params ["_widget","_posarray",["_time",-1]];
	#define precent_to_real(proc_val) (proc_val / 100)

	_posarray params ["_posx","_posy","_posw","_posh"];

	if (_widget getVariable ['isSquare',false]) then {
		_posw = transformSizeByAR(_posh);
	};

	private _window = ctrlParentControlsGroup _widget;

    //Если находится внутри окна то максимальные размеры берутся от этого окна
    if (!(_window isequalto widgetNull)) then
    {
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
};

//Преобразовать позицию виджета из процента в экранное пространство
decl(vector4(widget;float;int))
widgetPosPrecentToSafezone = {
	params ["_widget","_prec","_index"];
	private _vec4 = [0,0,0,0];
	_vec4 set [_index,_prec];
	_vec4 params ["_posx","_posy","_posw","_posh"];

	if (_widget getVariable ['isSquare',false]) then {
		_posw = transformSizeByAR(_posh);
	};

	private _window = ctrlParentControlsGroup _widget;

    //Если находится внутри окна то максимальные размеры берутся от этого окна
    if (!(_window isequalto widgetNull)) then
    {
        private _windPos = ctrlPosition _window; //натив
        private _windW = _windPos select 2;
        private _windH = _windPos select 3;
        [
			precent_to_real(_posx) * _windW,
			precent_to_real(_posy) * _windH,
			precent_to_real(_posw) * _windW,
			precent_to_real(_posh) * _windH
		] select _index;

    } else {
		[
			precent_to_real(_posx) * safezoneW + safezoneX,
			precent_to_real(_posy) * safezoneH + safezoneY,
			precent_to_real(_posw) * safezoneW,
			precent_to_real(_posh) * safezoneH
		] select _index;
    };
};

//Устанавливает новую позицию виджету без изменеия размеров
decl(void(widget;vector2|vector4;float))
widgetSetPositionOnly = {
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
};


//Получает позицию виджета
decl(vector4(widget))
widgetGetPosition = {

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
};

//Проверяет находится ли мышь внутри контрола
decl(bool(widget))
isMouseInsideWidget = {

	// Rewrited after 0.8.243

	private _wid = _this;
	if equals(_wid,widgetNull) exitWith {false};

	(ctrlPosition _wid) params ["_xp","_xy","_w","_h"];
	(ctrlMousePosition _wid) params ["_mX","_mY"];

	!((_mX < 0 || _mX > _w )  || (_mY < 0 || _mY > _h ))
	//( _xPos > _xe && _xPos < _xe2 ) && (_yPos > _ye && _yPos < _ye2 )
	/*if (
		(_mX < 0 && _mX > _w ) ||
		(_mY < 0 && _mY > _h )
	) exitWith {false};

	true*/

	/*private _array = ctrlPosition _this;

	if (_array isEqualTo []) exitWith {false};

    getMousePosition params ["_xPos","_yPos"];

	_array params ["_xe","_ye","_w","_h"];

	private _window = ctrlParentControlsGroup _this;

    if (!(_window isequalto widgetNull)) then {

        private _ParentWindow = _window;
        private _inc = 0;

        private _ctgPos = ctrlPosition _ParentWindow;
        //ctgPos.params(CX,CY);
     	_xe = _xe + (_ctgPos select 0);
        _ye = _ye + (_ctgPos select 1);

        //Я не уверен в достаточной быстроте цикла... Но пока работает так
        while {!(_ParentWindow isEqualTo widgetNull)} do
        {
            INC(_inc);
            //printf("Inc:%1",inc);
            _ParentWindow = ctrlParentControlsGroup _ParentWindow;
            _ctgPos = ctrlPosition _ParentWindow;
            //ctgPos.params(CX,CY);
			_xe = _xe + (_ctgPos select 0);
	        _ye = _ye + (_ctgPos select 1);

        };

	};

	if (
		( _xPos < _xe || _xPos > (_w + _xe) )  ||
		(_yPos < _ye || _yPos > (_h + _ye) )
	) exitWith {false};

	true*/
};

//Проверяет находится ли мышь внутри позиции
decl(bool(vector4))
isMouseInsidePosition = {

	_this params ["_xe","_ye","_xe2","_ye2"];

	(call mouseGetPosition) params ["_xPos","_yPos"];

	// [20,50]
	// [30 , 30 , 60 , 60]
	if (
		( _xPos > _xe && _xPos < _xe2 ) && (_yPos > _ye && _yPos < _ye2 )
	) exitWith {true};

	false
};

//Получает позицию мыши внутри виджета
decl(vector2(widget))
getMousePositionInWidget = {

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
};

// Устанавливает текст в виджет
decl(void(widget;string))
widgetSetText = {
	params ["_obj","_text"];

	if (_text isEqualType "") then {
        //строка
        _obj setStructuredText (parseText _text);
    } else {
        //уже текст
        _obj setStructuredText _text;
    }
};

// Устанавливает картинку в виджет
decl(void(widget;string))
widgetSetPicture = {
	params ["_obj","_text"];

	_obj ctrlsettext _text;
};

// Получает высоту текста виджета
decl(float(widget))
widgetGetTextHeight = {

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
};

//скроллинг контрол группы WIDGETGROUP_H
decl(void(widget))
widgetWGScrolldown = {
	params ["_wid"];
	_wid ctrlSetAutoScrollRewind true;
	_wid ctrlSetAutoScrollDelay 0;
	_wid ctrlSetAutoScrollSpeed 0.001;

	invokeAfterDelayParams({_this ctrlSetAutoScrollSpeed 0;},0.5,_wid);
};

//=================== MOUSE HELPERS =====================

// Устанавливает позицию мыши в процентах
decl(void(float;float))
mouseSetPosition = {
	params ["_xpos","_ypos"];
	#define precent_to_real(proc_val) (proc_val / 100)
    setMousePosition [precent_to_real(_xpos) * safezoneW + safezoneX,precent_to_real(_ypos) * safezoneH + safezoneY];
};

//Получает позицию мыши (значения в процентах)
decl(vector2())
mouseGetPosition = {

	getMousePosition params ["_mX","_mY"];

	//Находится на экране
	#define STARTX (0 * safezoneW + safezoneX)
	#define STARTY (0 * safezoneH + safezoneY)
	#define DIAPAZONX ((1 * safezoneW + safezoneX) - STARTX)
	#define DIAPAZONY ((1 * safezoneH + safezoneY) - STARTY)

	private _xp = ((_mX - STARTX) / (DIAPAZONX / 100));
	private _yp = ((_mY - STARTY) / (DIAPAZONY / 100));

	[_xp,_yp];
};

//Преобразует позицию мыши в координаты экранного пространства
decl(vector2(vector2))
convertScreenCoords = {
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
};

// Конвертация мировой позиции в экранные координаты. Всегда возвращает vec2
decl(vector2(vector3))
positionWorldToScreen = {
	((worldToScreen _this) call convertScreenCoords)
};

//screenToWorld scripted alternative (ray to distance, not surface)
// getScreenPointToWorld = {
//     params [["_screenPos",getMousePosition],["_mulDist",1000]];

//     _screenPos = _screenPos vectorDiff [0.5, 0.5];
//     private _res = getResolution;

//     private _m = _res select 4;
//     private _aspect = _res select 7;
//     positionCameraToWorld (vectorNormalized [
//       (_screenPos select 0) * tan (45/2) * _m * _aspect,
//       -((_screenPos select 1) * tan (45/2) * _m),
//       1
//     ] vectorMultiply _mulDist);
// };

//возвращает мировую позицию по экранным координатам
decl(vector3(vector2;float;bool))
screenPosToWorldPoint = {
	params [["_spos",getMousePosition],["_distanceMul",1000],["_fromNative",true]];
	private _vectorDir = screenToWorldDirection ifcheck(_fromNative,_spos,_spos call convertScreenCoords);
	private _startPos = positionCameraToWorld[0,0,0];
	_startPos vectorAdd (_vectorDir vectorMultiply _distanceMul);
};

//Проверяет находится ли позиция внутри другой позиции. Отсчёт позиции с верхнего левого угла всегда
decl(bool(vector2;vector2))
isPointInScreenPosition = {
	params ["_point","_sp"];

	_sp params ["_xe","_ye","_xe2","_ye2"];

	_point params ["_xPos","_yPos"];

	if (
		( _xPos > _xe && _xPos < _xe2 ) && (_yPos > _ye && _yPos < _ye2 )
	) exitWith {true};

	false
};

//Можно ли видеть точку на экране
decl(bool(vector2))
canSeeScreenPoint = {
	[_this,[0,0,100,100]] call isPointInScreenPosition
};

// видно ли объект в сцене. Лучше всего работает с малыми объектами
decl(bool(mesh))
hasObjectInScene = {
	((worldToScreen (getposatl _this)) call convertScreenCoords) params ["_xPos","_yPos"];
	( _xPos > 0 && _xPos < 100 ) && (_yPos > 0 && _yPos < 100 )
};

//other screen support
decl(bool)
hasEnabledBlackScreen = false;

// Устанавливает режим черного экрана
decl(void(bool;float))
setBlackScreenGUI = {
	params ["_mode",["_time",0.001]];
	private _ateff = activeTitleEffectParams 0;
	private _isEnabled = count _ateff > 0 && {_ateff select 1 == "BLACK"};
	hasEnabledBlackScreen = _mode;

	if equals(_isEnabled,_mode) exitWith {};
	if (_mode) then {
		titleCut ["","BLACK", _time];
	} else {
		titleCut ["","BLACK IN", _time];
	};
};

// Устанавливает режим видимости HUD-а
decl(void(bool))
setVisibleHUD = {
	params ["_mode"];

	//chat
	{
		_x ctrlShow _mode;
	} foreach chat_widgets;
	//cursor
	{
		_x ctrlShow _mode;
	} foreach interaction_aim_widgets;
	//stamina
	{
		_x ctrlShow _mode;
	} foreach stamina_widgets;
	//inventory
	{
		_x ctrlShow _mode;
	} forEach inventor_slot_widgets;
	
	(cd_vv_widgets select 0) ctrlShow _mode;
	
	(hud_zone select 0) ctrlShow _mode;
};

decl(string)
widget_antiGamma_lastError = "";

macro_const(widget_antiGamma_lowProtectValue)
#define low_protect 0.9
macro_const(widget_antiGamma_maxProtectValue)
#define max_protect 1.1

// false is not allowed values
decl(bool())
widget_antiGammaCheck = {

	private _vOpts = getVideoOptions;
	//all values in range 0-2 (mid 1)

	//яркость (вкладка изображение)
	private _brightness = _vOpts get "brightness";
	//гамма (вкладка изображение)
	private _gamma = _vOpts get "gamma";
	//яркость (вкладка AA&PP)
	private _ppBrightness = _vOpts get "ppBrightness";
	//контраст (вкладка AA&PP)
	private _ppContrast = _vOpts get "ppContrast";

	private _errMesDef = "Восстановите значение опции ""%1"" в настройках (вкладка %2). Ваше значение %3, требуется от %4 до %5";

	if !inRange(_brightness,low_protect,max_protect) exitWith {
		widget_antiGamma_lastError = format[_errMesDef,"Яркость","Изображение",_brightness tofixed 2,low_protect,max_protect];
		false
	};
	if !inRange(_gamma,low_protect,max_protect) exitWith {
		widget_antiGamma_lastError = format[_errMesDef,"Гамма","Изображение",_gamma tofixed 2,low_protect,max_protect];
		false
	};
	if !inRange(_ppBrightness,low_protect,max_protect) exitWith {
		widget_antiGamma_lastError = format[_errMesDef,"Яркость","AA & PP",_ppBrightness*100 tofixed 0,low_protect*100,max_protect*100];
		false
	};
	if !inRange(_ppContrast,low_protect,max_protect) exitWith {
		widget_antiGamma_lastError = format[_errMesDef,"Контраст","AA & PP",_ppContrast*100 tofixed 0,low_protect*100,max_protect*100];
		false
	};
	
	widget_antiGamma_lastError = "";

	true

	//obsolete after platform 2.14
	// (findDisplay 46) createDisplay  "RscDisplayInterrupt";
	// ctrlActivate (findDisplay 49 displayCtrl 301);
	// _sets = (findDisplay 5);
	// (findDisplay 5) displayAddEventHandler ["Unload",{(findDisplay 49) closeDisplay 0}];
	// //{_x ctrlsettooltip (str ctrlidc _x)} foreach (allcontrols _sets);

	// _bri = _sets displayCtrl 112;
	// _gam = _sets displayCtrl 110;

	// _brival = sliderPosition _bri;
	// _gam = sliderPosition _gam;

	// _sets closeDisplay 0;

	// inRange(_brival,low_protect,max_protect) && inRange(_gam,low_protect,max_protect)
};

// Создание сообщения отключения от сервера
decl(void(any[]))
widget_createDisconnectMessage = {
	private _args = _this;
	if (isDisplayOpen) then {
		call displayClose;
	};

	_d = call dynamicDisplayOpen;

	_back = [_d,BACKGROUND,WIDGET_FULLSIZE] call createWidget;

	_okButton = [_d,BUTTON,[50 - 30/2,80-20/2,30,20]] call createWidget;
	_okButton ctrlSetText "Выход";
	_okButton ctrlSetBackgroundColor [0,0.113,0.01,0.8];
	_okButton ctrlAddEventHandler ["MouseButtonUp",{
		_h = [] spawn {getDisplay closeDisplay 0}; //here displayClose is undefined (engine specific)
	}];
	_headerText = "Отключен";
	_reasonText = "Вы вышли с сервера";

	_header = [_d,TEXT,[0,5,100,20]] call createWidget;
	_reason = [_d,TEXT,[0,25,100,50]] call createWidget;

	#define setwt(wid,_t,_sz) [wid,format["<t align='center' size='%2'>%1</t>",_t,_sz]] call widgetSetText

	setwt(_header,_headerText,1.6);
	setwt(_reason,_reasonText,1.2);

	if (count _args != 2) exitWith {};
	_args params ["_headerText","_reasonText"];

	setwt(_header,_headerText,1.6);
	setwt(_reason,_reasonText,1.2);
};


//специальная функция регистрации переноса каретки по нажатию enter
decl(void(widget))
widget_registerInput = {
	private _input = _this;
	_input ctrlAddEventHandler ["KeyUp",{
		params ["_w","_key"];
		if (_key == KEY_BACKSPACE) exitWith {
			forceUnicode 0;
			_text = ctrlText _w;
			_sel = ctrlTextSelection _w;

			_sel params ["_idxDel","_countDel","_tex"];
			_aText = toArray _text;
			if (_countDel != 0) then {
				if (_countDel > 0) then {
					_aText deleteRange [_idxDel,_countDel];
					_w ctrlSetText (toString _aText);
					_w ctrlSetTextSelection [_idxDel,0];
				} else {
					_aText deleteRange [_idxDel+_countDel,abs _countDel];
					_w ctrlSetText (toString _aText);
					_w ctrlSetTextSelection [_idxDel+_countDel,0];
				};

			} else {
				_aText deleteRange [_idxDel-1,1];
				_w ctrlSetText (toString _aText);
				_w ctrlSetTextSelection [_idxDel-1,0];
			};

		};
		//auto-send by enter press
		if (_key == KEY_RETURN) exitWith {
			if equals(focusedCtrl getDisplay,_w) then {
				_w ctrlSetText (ctrlText _w + endl);
			};
		};
	}];
};

// Внутренняя функция для расчетов размеров объекта в экранном пространстве
decl(vector3(any;any[];float))
widgetModel_objectHelper = {
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
};

decl(void(widget;vector4;vector4))
widgetSetMouseMoveColors = {
	params ["_w","_out","_in"];
	_w setBackgroundColor _out;
	_w setvariable ["___ieFocusCol_Exit",_out];
	_w setvariable ["___ieFocusCol_Enter",_in];
	_w ctrlAddEventHandler ["MouseEnter",{_w = _this select 0; _w setBackgroundColor (_w getvariable "___ieFocusCol_Enter")}];
	_w ctrlAddEventHandler ["MouseExit",{_w = _this select 0; _w setBackgroundColor (_w getvariable "___ieFocusCol_Exit")}];
};



#ifdef EDITOR
	//https://gist.github.com/HallyG/fa7a6cda10abcb630b1dc325f0523553
	
	#include "_iconviewer.sqf"

	//["onload"] call fn_iconViewer;
#endif