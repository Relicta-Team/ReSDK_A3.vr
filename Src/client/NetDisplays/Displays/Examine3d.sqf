// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

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

	def(imgRef) widgetNull;

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];

		call personCli_syncLocalVisibility;

		private _sizeX = 80;
		private _sizeY = 90;

		private _zone = [_isFirstCall,_sizeX,_sizeY,false] call nd_stdLoad;
		call nd_cleanupData;

		(_zone getvariable "background") setBackgroundColor [0,0,0,0];
		
		_args params [["_model",""],["_text",""],["_specFlag","obj"]];
		if !array_exists(nd_internal_currentStructObj getv(specFlagList),_specFlag) exitWith {
			errorformat("Examine3d::process - invalid specFlag %1",_specFlag);
			private _textWid = [(nd_internal_currentStructObj getv(thisDisplay)),WIDGET_FULLSIZE,_zone,true] call nd_addClosingButton;
			_textWid ctrlSetText "Закрыть";
		};

		
		_img = [PICTURE,[0,0,100,90],_zone] call nd_regWidget;
		[null,_specFlag,true] call personCli_prepCamera;
		[_specFlag,_model] call personCli_setStat;
		[_img] call personCli_setPictureRenderTarget;
		_img ctrlEnable true;

		if (!isPiPEnabled) then {
			private _text = [TEXT,[0,0,100,90],_zone] call nd_regWidget;
			[_text,"<t color='#ff0000' size='4'>Включите PIP (картинка в картинке) в настройках графики Arma 3</t>"] call widgetSetText;
			_text setBackgroundColor [0,0,0,1];
			_text setFade 0;
			_text commit 0;
		};

		_img setvariable ["orbitAngleH",0];
		_img setvariable ["orbitAngleV",0];
		_img setvariable ["orbitStart",[0,0]];
		_img setvariable ["dragStart",[0,0]];

		_img setvariable ["isOrbitActive",false];
		_img setvariable ["isDragActive",false];

		_img setvariable ["specFlag",_specFlag];

		_img setvariable ["curOrbitAngleH",0];
		_img setvariable ["curOrbitAngleV",0];

		_img setvariable ["zoom", 0];

		_img setvariable ["pitch", 0];
		_img setvariable ["yaw", 0];
		_img setvariable ["currentPitch", 0];
		_img setvariable ["currentYaw", 0];

		// Установка позиции объекта
		if equals(_specFlag,"obj") then {
			private _object = call personCli_getLocalObject;
			private _bb = boundingBoxReal _object;
			private _centerPos = _bb select 1 select 2;
			private _per = call personCli_getLocalMob;
			_img setvariable ["bb", _bb];
			private _newpos = getposatl _object vectorAdd [0,-(selectMax(_bb select 1) * 5),-_centerPos];
			_object setposatl _newpos;
		};

		private _cFlag = personCli_const_cFlag;
		private _cPosTarget = personCli_const_cPosTargetList;
		private _cPos = personCli_const_cPosList;
		private _curIndex = _cFlag find _specFlag;
		private _curPos = _cPos select _curIndex;
		private _curPosTarg = _cPosTarget select _curIndex;
		_img setvariable ["distance", _curPosTarg distance _curPos];

		_img ctrlAddEventHandler ["MouseButtonDown",{
			params ["_img","_b"];
			if (_b == MOUSE_LEFT) then {
				_pressPos = getMousePosition;
				private _specFlag = _img getVariable ["specFlag", ""];

				if equals(_specFlag,"obj") then {
					_img setvariable ["dragStart",_pressPos];
					_img setvariable ["isDragActive",true];
				} else {
					_img setvariable ["orbitStart",_pressPos];
					_img setvariable ["isOrbitActive",true];
				};
			};
		}];
		_img ctrlAddEventHandler ["MouseButtonUp",{
			params ["_img","_b"];
			private _specFlag = _img getVariable ["specFlag", ""];
			if equals(_specFlag,"obj") then {
				_img setvariable ["isDragActive",false];
			} else {
				_img setvariable ["isOrbitActive",false];
			};
		}];
		
		_img ctrlAddEventHandler ["MouseZChanged",{
			params ["_img","_val"];
			private _cSelections = personCli_const_cSelections;
			private _per = call personCli_getLocalMob;
			private _cFlag = personCli_const_cFlag;
			private _specFlag = _img getVariable ["specFlag", "cloth"];
			private _cPos = personCli_const_cPosList;
			private _cPosTarget = personCli_const_cPosTargetList;
			private _curIndex = _cFlag find _specFlag;
			private _curPos = _cPos select _curIndex;
			private _curPosTarg = _cPosTarget select _curIndex;
			private _distance = _img getVariable ["distance", 1];
			private _curSel = _cSelections select _curIndex;

			//Дефолтные значения мин/макс дистанции (одежда)
			private _minDistance = 1;
			private _maxDistance = 6;
			private _campos = getposatl _per vectorAdd [0,0,1];

			if not_equals(_specFlag,"obj") then {
				_campos = (_per modeltoworldvisual (_per selectionPosition _curSel));
				_maxDistance = personCli_const_cPosList select _curIndex select 1;
			} else {
				//Расчитываем мин/макс дистанцию (объект)
				private _bb = _img getVariable ["bb", []];
				private _bbMin = selectMin(_bb select 1);
				private _bbMax = selectMax(_bb select 1);

				if (_bbMin < 0.1) then {
					_bbMin = 0.3;
				};

				_minDistance = _bbMin;
				_maxDistance = (_bbMax * 5) + 1;
			};

			private _zoomSensitivity = 1;
			private _distChange = -(_val * 0.1) * _zoomSensitivity;
			private _newDistance = _distance + _distChange;

			_newDistance = clamp(_newDistance, _minDistance, _maxDistance);

			_img setvariable ["distance", _newDistance];

			private _orbitAngleH = _img getVariable ["orbitAngleH", 0];
			private _orbitAngleV = _img getVariable ["orbitAngleV", 0];

			private _relPos = [
				sin(_orbitAngleH) * cos(_orbitAngleV) * _newDistance,
				cos(_orbitAngleH) * cos(_orbitAngleV) * _newDistance,
				sin(_orbitAngleV) * _newDistance
			];

			_campos = _campos vectoradd _relPos;

			[_campos,false] call personCli_setCameraPos;
		}];

		self setv(imgRef,_img);

		startAsyncInvoke
		{
			params ["_ndObj","_img"];
			if isNullReference(_img) exitWith {true};
			
			_ndObj callv(handleOrbit);
			_ndObj callv(handleMovingObject);
			false
		},{},[self,_img]
		endAsyncInvoke


		_textWid = [(self getv(thisDisplay)),[0,90,100,10],_zone,true] call nd_addClosingButton;
		_textWid ctrlSetText "Закрыть";
	};

	def(handleOrbit)
	{
		private _img = self getv(imgRef);
		if (_img getVariable ["isOrbitActive", false]) then {
			getMousePosition params ["_xPos","_yPos"];
			private _lastPos = _img getVariable ["orbitStart", [0, 0]];
			private _orbitAngleH = _img getVariable ["orbitAngleH", 0];
			private _orbitAngleV = _img getVariable ["orbitAngleV", 0];
			private _specFlag = _img getVariable ["specFlag", "cloth"];
			private _sensitivity = 80;

			private _per = call personCli_getLocalMob;
			private _cFlag = personCli_const_cFlag;
			private _cSelections = personCli_const_cSelections;
			private _cPos = personCli_const_cPosList;
			private _cPosTarget = personCli_const_cPosTargetList;
			private _curIndex = _cFlag find _specFlag;
			private _curPos = _cPos select _curIndex;
			private _curPosTarg = _cPosTarget select _curIndex;
			private _curSel = _cSelections select _curIndex;

			private _curOrbitAngleH = _img getVariable ["curOrbitAngleH", 0];
			private _curOrbitAngleV = _img getVariable ["curOrbitAngleV", 0];

			private _orbitDistance = _img getVariable ["distance", 1];

			_orbitDistance = clamp(_orbitDistance, 1, personCli_const_cPosList select _curIndex select 1);

			private _dx = (_lastPos select 0) - _xPos;
			private _dy = (_lastPos select 1) - _yPos;

			_curOrbitAngleH = _curOrbitAngleH + (_dx * (_sensitivity * 2));
			_curOrbitAngleV = _curOrbitAngleV + (_dy * _sensitivity);

			// Ограничение углов обзора
			_curOrbitAngleV = if (_specFlag == "cloth" || _specFlag == "armor") then { clamp(_curOrbitAngleV,-10,80) } else { clamp(_curOrbitAngleV,-85,85) };

			_img setvariable ["orbitAngleH", _curOrbitAngleH];
			_img setvariable ["orbitAngleV", _curOrbitAngleV];

			_orbitAngleH = _curOrbitAngleH;
			_orbitAngleV = _curOrbitAngleV;

			private _relPos = [
				sin(_orbitAngleH) * cos(_orbitAngleV) * _orbitDistance,
				cos(_orbitAngleH) * cos(_orbitAngleV) * _orbitDistance,
				sin(_orbitAngleV) * _orbitDistance
			];

			private _campos = (_per modeltoworldvisual (_per selectionPosition _curSel));
			_campos = _campos vectoradd _relPos;

			[_campos,false] call personCli_setCameraPos;
		} else {
			private _orbitAngleH = _img getVariable ["orbitAngleH", 0];
			private _orbitAngleV = _img getVariable ["orbitAngleV", 0];

			_img setvariable ["curOrbitAngleH", _orbitAngleH];
			_img setvariable ["curOrbitAngleV", _orbitAngleV];
		};
	};


	def(handleMovingObject)
	{
		private _img = self getv(imgRef);
		if (_img getVariable ["isDragActive",false]) then {
			getMousePosition params ["_xPos","_yPos"];
			private _lastPos = _img getVariable ["dragStart", [_xPos, _yPos]];
			private _currentPitch = _img getVariable ["currentPitch", 0];
			private _currentYaw = _img getVariable ["currentYaw", 0];
			private _object = call personCli_getLocalObject;
			private _pitch = _img getVariable ["pitch", 0];
			private _yaw = _img getVariable ["yaw", 0];

			private _dx = (_lastPos select 0) - _xPos;
			private _dy = (_lastPos select 1) - _yPos;

			private _sensitivity = 80;

			_currentPitch = _currentPitch - (-_dy * _sensitivity);
			_currentYaw = _currentYaw + (_dx * _sensitivity);
			
			_img setVariable ["currentPitch", _currentPitch];
			_img setVariable ["currentYaw", _currentYaw];
			_img setVariable ["pitch", _currentPitch];
			_img setVariable ["yaw", _currentYaw];

			_pitch = _currentPitch;
			_yaw = _currentYaw;

			private _dirUp = [_pitch, 0, _yaw ] call model_convertPithBankYawToVec;
			_object setVectorDirAndUp _dirUp;


			_img setVariable ["dragStart", [_xPos, _yPos]];
		} else {
			private _pitch = _img getVariable ["pitch", 0];
			private _yaw = _img getVariable ["yaw", 0];

			_img setVariable ["currentPitch", _pitch];
			_img setVariable ["currentYaw", _yaw];
		};
	};
endstruct