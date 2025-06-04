// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

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
		
		_args params [["_model",""],["_text",""],["_specFlag","obj"]];

        if (!([_model,"\"] call stringStartWith)) then {
            _model = "\" + _model;
        };

        private _back = [BACKGROUND,WIDGET_FULLSIZE,_zone] call nd_regWidget;
		_back setBackgroundColor [.1,0.1,0.1,.8];

        private _tUp = [TEXT,[0,0,100,10],_zone] call nd_regWidget;
        [_tUp,format["<t align='center' size='1.2'>%1</t>",_text]] call widgetSetText;
		
        private _internalZone = [WIDGETGROUP,[0,10,100,80],_zone] call nd_regWidget;
        _internalZone setvariable ["dragStart",[0,0]];
        _internalZone setvariable ["isDragActive",false];
        _internalZone setvariable ["pitch",0];
        _internalZone setvariable ["bank",0];

        _internalZone ctrlAddEventHandler ["MouseButtonDown",{
            params ["_internalZone"];
            _pressPos = getMousePosition;
            _internalZone setvariable ["isDragActive",true];
            _internalZone setvariable ["dragStart",_pressPos];
        }];
        _internalZone ctrlAddEventHandler ["MouseButtonUp",{
            params ["_internalZone"];
            _internalZone setvariable ["isDragActive",false];
        }];
        _internalZone ctrlAddEventHandler ["MouseMoving", {
            params ["_internalZone", "_xPos", "_yPos"];
            
            if (_internalZone getVariable ["isDragActive",false]) then {
                private _lastPos = _internalZone getVariable ["dragStart", [_xPos, _yPos]];
                private _dx = _xPos - (_lastPos select 0);
                private _dy = _yPos - (_lastPos select 1);

                // масштаб чувствительности
                private _sensitivity = 60;

                // Получение текущих углов
                private _currentPitch = _internalZone getVariable ["pitch", 0];
                private _currentBank = _internalZone getVariable ["bank", 0];

                _currentPitch = _currentPitch - _dy * _sensitivity;
                _currentBank = _currentBank + _dx * _sensitivity;

                // Сохраняем
                _internalZone setVariable ["pitch", _currentPitch];
                _internalZone setVariable ["bank", _currentBank];

                // Применение вращения к модели
                nd_internal_currentStructObj callp(_syncModelPos,_internalZone);
                // private _mdl = _ctrl getVariable ["model", objNull];
                // if (!isNull _mdl) then {
                //     _mdl ctrlSetModelDirAndUp [[_currentPitch, _currentBank, 0], [0,1,0]];
                // };

                _ctrl setVariable ["dragStart", [_xPos, _yPos]];
            };
        }];


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

        // Глубина на основе размера BBX (по z, т.е. высоте модели)
        private _bbx = core_modelBBX getOrDefault [ctrlModel _obj, [0, 0, 1]];
        private _depthAdjust = (_bbx select 2) * _distance;

        // Установка позиции в формате: [x, z (depth), y]
        _centerX = 0.5;
        _centerY = 0.5;
        _obj ctrlSetPosition [_centerX, _depthAdjust, _centerY];

        // Масштаб
        _obj ctrlSetModelScale _scale;

        // Применяем углы
        private _pitch = _ctg getVariable ["pitch", 0];
        private _bank = _ctg getVariable ["bank", 0];
        private _dirUp = [_pitch, _bank, 0] call model_convertPithBankYawToVec;
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