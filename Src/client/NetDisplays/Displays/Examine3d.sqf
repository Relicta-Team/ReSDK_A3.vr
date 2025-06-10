// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

nd_internal_examine3d_zoneWidget = widgetNull;
nd_internal_examine3d_distance = 1;

struct(Examine3d) base(NDBase)

	def(specFlagList) [
		"obj",
		"cloth",
		"armor",
		"backpack",
		"mask",
		"helmet"
	];


	cde_debug = {
		params ["_args","_isFirstCall"];
		private _sizeX = 80;
		private _sizeY = 90;

		private _zone = [_isFirstCall,_sizeX,_sizeY,false] call nd_stdLoad;
		call nd_cleanupData;

		(_zone getvariable "background") setBackgroundColor [0,0,0,0];
		
		_args params [["_model",""],["_text",""],["_specFlag","obj"]];

		if (!([_model,"\"] call stringStartWith)) then {
			_model = "\" + _model;
		};

		//private _back = [BACKGROUND,WIDGET_FULLSIZE,_zone] call nd_regWidget;
		//_back setBackgroundColor [.1,0.1,0.1,.8];
	   
		//enable overlay
		/*
		_sizeX = 5;
		_sizeY = 97;
		_b1 = [BACKGROUND,[0,0,_sizeX,_sizeY],_zone] call nd_regWidget;
		_b2 = [BACKGROUND,[_sizeX,0,_sizeY,_sizeX],_zone] call nd_regWidget;
		_b3 = [BACKGROUND,[_sizeY,_sizeX,_sizeX,_sizeY - _sizeX],_zone] call nd_regWidget;
		_b4 = [BACKGROUND,[_sizeX,_sizeY-_sizeX,_sizeY,_sizeX],_zone] call nd_regWidget;
		{
			_x setBackgroundColor [.4,.4,.4,0.8];
		} foreach [_b1,_b2,_b3,_b4];
		*/

		private _tUp = [TEXT,[0,0,100,10],_zone] call nd_regWidget;
		[_tUp,format["<t align='center' size='1.2'>%1</t>",_text]] call widgetSetText;
		
		private _internalZone = [WIDGETGROUP,[0,10,100,80],_zone] call nd_regWidget;
		nd_internal_examine3d_zoneWidget = _internalZone;
		_internalZone setvariable ["dragStart",[0,0]];
		_internalZone setvariable ["posStart",[0,0]];
		_internalZone setvariable ["isDragActive",false];
		_internalZone setvariable ["isPosActive",false];
		
		_internalZone setvariable ["xObjPos",0];
		_internalZone setvariable ["yObjPos",0];

		_internalZone setvariable ["pitch",0];
		_internalZone setvariable ["bank",0];

		_internalZone ctrlAddEventHandler ["MouseButtonDown",{
			params ["_internalZone","_b"];
			_pressPos = getMousePosition;
			if (_b == MOUSE_LEFT) then {
				_internalZone setvariable ["isDragActive",true];
				_internalZone setvariable ["dragStart",_pressPos];
			} else {
				_internalZone setvariable ["isPosActive",true];
				_internalZone setvariable ["posStart",_pressPos];
			};
		}];
		_internalZone ctrlAddEventHandler ["MouseButtonUp",{
			params ["_internalZone","_b"];
			_internalZone setvariable ["isPosActive",false];
			_internalZone setvariable ["isDragActive",false];
		}];
		_internalZone ctrlAddEventHandler ["MouseZChanged",{
			params ["_internalZone","_val"];
			modvar(nd_internal_examine3d_distance) + (_val * 0.1);
			nd_internal_examine3d_distance = clamp(nd_internal_examine3d_distance,-5,5);
			nd_internal_currentStructObj callp(_syncModelPos,_internalZone);
		}];
		
		if (_isFirstCall) then {
			nd_internal_examine3d_distance = 1;
			startAsyncInvoke
			{
				if isNullReference(nd_internal_examine3d_zoneWidget) exitWith {true};
				call cde_movingHandle;
				false
			}
			endAsyncInvoke
		};
		
		private _mdlwid = (self getv(thisDisplay)) ctrlCreate ["RscObject",-1,_internalZone];
		_mdlwid ctrlSetModel _model;
		_internalZone setvariable ["model",_mdlwid];

		self callp(_syncModelPos,_internalZone);
		
		private _cSizeX = 70;
		private _cSizeY = 5;
		private _lwrYPos = 100-10-_cSizeY;
		_textWid = [(self getv(thisDisplay)),[50-_cSizeX/2,_lwrYPos,_cSizeX,_cSizeY],_ctg,true] call nd_addClosingButton;
		_textWid ctrlSetText "Закрыть";
	};

	cde_movingHandle = {
		_internalZone = nd_internal_examine3d_zoneWidget;
		if (_internalZone getVariable ["isDragActive",false]) then {
			getMousePosition params ["_xPos","_yPos"];
			private _lastPos = _internalZone getVariable ["dragStart", [_xPos, _yPos]];
			private _dx = (_lastPos select 0) - _xPos;
			private _dy = (_lastPos select 1) - _yPos;

			// масштаб чувствительности
			private _sensitivity = 10;

			// Получение текущих углов
			private _currentPitch = _internalZone getVariable ["pitch", 0];
			private _currentBank = _internalZone getVariable ["bank", 0];

			//! убрать переустановку pitch/bank для корректного вращения
			_currentPitch = _currentPitch - _dy * _sensitivity;
			_currentBank = _currentBank + _dx * _sensitivity;

			// Сохраняем
			_internalZone setVariable ["pitch", _currentPitch];
			_internalZone setVariable ["bank", _currentBank];

			// Применение вращения к модели
			nd_internal_currentStructObj callp(_syncModelPos,_internalZone);

			//_ctrl setVariable ["dragStart", [_xPos, _yPos]];
		};
		if (_internalZone getVariable ["isPosActive",false]) then {
			getMousePosition params ["_xPos","_yPos"];
			private _lastPos = _internalZone getVariable ["posStart", [_xPos, _yPos]];
			private _curX = _internalZone getVariable ["xObjPos", 0];
			private _curY = _internalZone getVariable ["yObjPos", 0];
			private _dx = (_lastPos select 0) - _xPos;
			private _dy = (_lastPos select 1) - _yPos;

			private _sensitivity = 50;
			_curX = _curX - _dx / _sensitivity;
			_curY = _curY - _dy / _sensitivity;

			_internalZone setVariable ["xObjPos",_curX];
			_internalZone setVariable ["yObjPos",_curY];

			// Применение вращения к модели
			nd_internal_currentStructObj callp(_syncModelPos,_internalZone);
		};
	};

	cde_objhlp = {
		params ["_ctg"];
		private _obj = _ctg getVariable "model";
		private _scale = 1 / (getResolution select 5);

		// Глубина по умолчанию
		private _distance = 3 * 4 / 3;
		if ((getResolution select 4) < (4/3)) then {
			_distance = _distance * (getResolution select 7); // пример: 5:4 мониторы
		};

		// Центр зоны
		private _ctrlPos = ctrlPosition _ctg;
		private _centerX = (_ctrlPos select 0) + (_ctrlPos select 2) / 2;
		private _centerY = (_ctrlPos select 1) + (_ctrlPos select 3) / 2;

		modvar(_distance) - nd_internal_examine3d_distance;

		// Глубина на основе размера BBX (по z, т.е. высоте модели)
		private _bbx = core_modelBBX getOrDefault [ctrlModel _obj, [0, 0, 1]];
		private _depthAdjust = (_bbx select 2) * _distance;

		// Установка позиции в формате: [x, z (depth), y]
		_centerX = 0.5;
		_centerY = 0.5;

		modvar(_centerX) + (_ctg getvariable ["xObjPos",0]);
		modvar(_centerY) + (_ctg getvariable ["yObjPos",0]);
		_obj ctrlSetPosition [_centerX, _depthAdjust, _centerY];

		// Масштаб
		_obj ctrlSetModelScale _scale;

		// Применяем углы
		private _pitch = _ctg getVariable ["pitch", 0];
		private _bank = _ctg getVariable ["bank", 0];
		private _dirUp = [_pitch, 0, _bank] call model_convertPithBankYawToVec;
		_obj ctrlSetModelDirAndUp _dirUp;

		_obj ctrlCommit 0;
	};

	decl(override) def(process)
	{
		_this call cde_debug;
		
	};

	def(_syncModelPos)
	{
		_this call cde_objhlp;
	};

endstruct