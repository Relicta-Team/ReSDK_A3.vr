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

		if not_equals(_specFlag,"") exitwith {
			_img = [PICTURE,[0,0,100,90],_zone] call nd_regWidget;
			[null,_specFlag,true] call personCli_prepCamera;
			[_specFlag,_model] call personCli_setStat;
			[_img] call personCli_setPictureRenderTarget;
			_img ctrlEnable true;

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

			_img setvariable ["_per", call personCli_getLocalMob];
			_img setvariable ["_cFlag", personCli_const_cFlag];
			_img setvariable ["_cSelections", personCli_const_cSelections];
			_img setvariable ["_cPos", personCli_const_cPosList];
			_img setvariable ["_cPosTarget", personCli_const_cPosTargetList];

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

			private _cFlag = _img getVariable ["_cFlag", []];
			private _cPosTarget = _img getVariable ["_cPosTarget", []];
			private _cPos = _img getVariable ["_cPos", []];
			private _cPosTarget = _img getVariable ["_cPosTarget", []];
			private _curPos = _cPos select (_cFlag find _specFlag);
			private _curPosTarg = _cPosTarget select (_cFlag find _specFlag);
			_img setvariable ["distance", _curPosTarg distance _curPos];
			_img setvariable ["object", call perwsonCli_getLocalObject];

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
				private _cSelections = _img getVariable ["_cSelections", []];
				private _per = _img getVariable ["_per", personCli_getLocalMob];
				private _cFlag = _img getVariable ["_cFlag", []];
				private _specFlag = _img getVariable ["specFlag", "cloth"];
				private _cPos = _img getVariable ["_cPos", []];
				private _cPosTarget = _img getVariable ["_cPosTarget", []];
				private _curIndex = _cFlag find _specFlag;
				private _curPos = _cPos select _curIndex;
				private _curPosTarg = _cPosTarget select _curIndex;
				private _distance = _img getVariable ["distance", 1];
				private _curSel = _cSelections select (_cFlag find _specFlag);

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
					_minDistance = selectMin(_bb select 1);
					_maxDistance = selectMax(_bb select 1) * 5;
				};

				private _dirVector = _campos vectorDiff _curPosTarg;

				private _zoomSensitivity = 1;
				private _distChange = -(_val * 0.1) * (_distance * _zoomSensitivity);
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

				_campos = _campos vectoradd _curPosTarg vectoradd _relPos;

				[_campos] call personCli_setCameraPos;
				personCli_rttCamera setVectorDir _dirVector;
			}];

			cde_orbitHandle = {
				if (_img getVariable ["isOrbitActive", false]) then {
					getMousePosition params ["_xPos","_yPos"];
					private _lastPos = _img getVariable ["orbitStart", [0, 0]];
					private _orbitAngleH = _img getVariable ["orbitAngleH", 0];
					private _orbitAngleV = _img getVariable ["orbitAngleV", 0];
					private _specFlag = _img getVariable ["specFlag", "cloth"];
					private _sensitivity = 80;

					private _per = _img getVariable ["_per", personCli_getLocalMob];
					private _cFlag = _img getVariable ["_cFlag", []];
					private _cSelections = _img getVariable ["_cSelections", []];
					private _cPos = _img getVariable ["_cPos", []];
					private _cPosTarget = _img getVariable ["_cPosTarget", []];
					private _curPos = _cPos select (_cFlag find _specFlag);
					private _curPosTarg = _cPosTarget select (_cFlag find _specFlag);
					private _curSel = _cSelections select (_cFlag find _specFlag);

					private _curOrbitAngleH = _img getVariable ["curOrbitAngleH", 0];
					private _curOrbitAngleV = _img getVariable ["curOrbitAngleV", 0];

					private _orbitDistance = _img getVariable ["distance", 1];

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
					_campos = _campos vectoradd _curPosTarg vectoradd _relPos;

					[_campos] call personCli_setCameraPos;
				} else {
					private _orbitAngleH = _img getVariable ["orbitAngleH", 0];
					private _orbitAngleV = _img getVariable ["orbitAngleV", 0];

					_img setvariable ["curOrbitAngleH", _orbitAngleH];
					_img setvariable ["curOrbitAngleV", _orbitAngleV];
				};
			};

			cde_movingHandleObj = {
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

			startAsyncInvoke
			{
				params ["_img"];
				if isNullReference(_img) exitWith {true};
				call cde_orbitHandle;
				call cde_movingHandleObj;
				false
			},{},[_img]
			endAsyncInvoke


			_textWid = [(self getv(thisDisplay)),[0,90,100,10],_zone,true] call nd_addClosingButton;
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