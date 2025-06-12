// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

nd_internal_examine3d_distance = 1;

struct(Examine3d) base(NDBase)

	def(zoneWidgetRef) widgetNull;

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
		if !array_exists(nd_internal_currentStructObj getv(specFlagList),_specFlag) exitWith {
			errorformat("Examine3d::cde_debug - invalid specFlag %1",_specFlag);
			private _textWid = [(nd_internal_currentStructObj getv(thisDisplay)),WIDGET_FULLSIZE,_zone,true] call nd_addClosingButton;
			_textWid ctrlSetText "Закрыть";
		};

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
		nd_internal_currentStructObj setv(zoneWidgetRef,_internalZone);
		_internalZone setvariable ["dragStart",[0,0]];
		_internalZone setvariable ["posStart",[0,0]];
		_internalZone setvariable ["isDragActive",false];
		_internalZone setvariable ["isPosActive",false];
		
		_internalZone setvariable ["xObjPos",0];
		_internalZone setvariable ["yObjPos",0];

		_internalZone setvariable ["currentXObjPos",0];
		_internalZone setvariable ["currentYObjPos",0];

		_internalZone setvariable ["pitch",0];
		_internalZone setvariable ["bank",0];

		_internalZone setvariable ["currentPitch",0];
		_internalZone setvariable ["currentBank",0];

		private _mdlwid = (self getv(thisDisplay)) ctrlCreate ["RscObject",-1,_internalZone];
		_mdlwid ctrlSetModel _model;
		_internalZone setvariable ["model",_mdlwid];

		private _bbx = core_modelBBX getOrDefault [ctrlModel _mdlwid, [[1,1,1], [1,1,1], 1]] select 1;

		private _width = _bbx select 0;
		private _length = _bbx select 1;
		private _height = _bbx select 2;

		private _maxSize = selectMax([_width, _length, _height]);

		_internalZone setvariable ["maxSize",_maxSize];

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
			private _maxSize = _internalZone getVariable ["maxSize",1];
			private _min = -_maxSize * 2;
			private _max = _maxSize * 2;
			modvar(nd_internal_examine3d_distance) + (_val * 0.1);
			nd_internal_examine3d_distance = clamp(nd_internal_examine3d_distance,_min,_max);
			nd_internal_currentStructObj callp(_syncModelPos,_internalZone);
		}];
		
		if (_isFirstCall) then {
			nd_internal_examine3d_distance = 0;
			startAsyncInvoke
			{
				if isNullReference(nd_internal_currentStructObj getv(zoneWidgetRef)) exitWith {true};
				call cde_movingHandle;
				false
			}
			endAsyncInvoke
		};

		self callp(_syncModelPos,_internalZone);
		
		private _cSizeX = 70;
		private _cSizeY = 5;
		private _lwrYPos = 100-10-_cSizeY;
		_textWid = [(self getv(thisDisplay)),[50-_cSizeX/2,_lwrYPos,_cSizeX,_cSizeY],_ctg,true] call nd_addClosingButton;
		_textWid ctrlSetText "Закрыть";

		_internalZone setvariable ["closeButton",_textWid];
	};

	cde_movingHandle = {
		_internalZone = nd_internal_currentStructObj getv(zoneWidgetRef);
		if (_internalZone getVariable ["isDragActive",false]) then {
			getMousePosition params ["_xPos","_yPos"];
			private _lastPos = _internalZone getVariable ["dragStart", [_xPos, _yPos]];
			private _currentPitch = _internalZone getVariable ["currentPitch", 0];
			private _currentBank = _internalZone getVariable ["currentBank", 0];

			private _dx = (_lastPos select 0) - _xPos;
			private _dy = (_lastPos select 1) - _yPos;

			// масштаб чувствительности
			private _sensitivity = 100;

			//! убрать переустановку pitch/bank для корректного вращения
			_currentPitch = _currentPitch - _dy * _sensitivity;
			_currentBank = _currentBank + _dx * _sensitivity;

			// Сохраняем
			_internalZone setVariable ["pitch", _currentPitch];
			_internalZone setVariable ["bank", _currentBank];

			// Применение вращения к модели
			nd_internal_currentStructObj callp(_syncModelPos,_internalZone);

			//_ctrl setVariable ["dragStart", [_xPos, _yPos]];
		} else {
			private _pitch = _internalZone getVariable ["pitch", 0];
			private _bank = _internalZone getVariable ["bank", 0];

			_internalZone setVariable ["currentPitch", _pitch];
			_internalZone setVariable ["currentBank", _bank];

			private _closeButton = _internalZone getVariable ["closeButton", widgetNull];

			ctrlSetFocus _closeButton;
		};
		if (_internalZone getVariable ["isPosActive",false]) then {
			getMousePosition params ["_xPos","_yPos"];
			private _lastPos = _internalZone getVariable ["posStart", [_xPos, _yPos]];
			private _curX = _internalZone getVariable ["currentXObjPos", 0];
			private _curY = _internalZone getVariable ["currentYObjPos", 0];
			private _dx = (_lastPos select 0) - _xPos;
			private _dy = (_lastPos select 1) - _yPos;

			private _sensitivity = 1;
			_curX = _curX - _dx * _sensitivity;
			_curY = _curY - _dy * _sensitivity;

			private _obj = _internalZone getVariable "model";
			private _scale = 1 / (getResolution select 5);

			// Глубина по умолчанию
			private _distance = 3 * 4 / 3;
			if ((getResolution select 4) < (4/3)) then {
				_distance = _distance * (getResolution select 7); // пример: 5:4 мониторы
			};
			private _defDist = _distance/6;

			_curX = clamp(_curX,-_defDist,_defDist);
			_curY = clamp(_curY,-_defDist,_defDist);

			_internalZone setVariable ["xObjPos",_curX];
			_internalZone setVariable ["yObjPos",_curY];

			// Применение вращения к модели
			nd_internal_currentStructObj callp(_syncModelPos,_internalZone);
		} else {
			private _x = _internalZone getVariable ["xObjPos", 0];
			private _y = _internalZone getVariable ["yObjPos", 0];

			_internalZone setVariable ["currentXObjPos", _x];
			_internalZone setVariable ["currentYObjPos", _y];
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

		_distance = _distance / 2;	

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

		private _posX = _ctg getvariable ["xObjPos",0];
		private _posY = _ctg getvariable ["yObjPos",0];

		modvar(_centerX) + _posX;
		modvar(_centerY) + _posY;
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