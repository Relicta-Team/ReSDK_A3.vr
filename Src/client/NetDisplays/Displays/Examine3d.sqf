// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\host\lang.hpp>

struct(Examine3d) base(NDBase)

    decl(specFlagList) [
        "obj",
        "cloth",
        "armor",
        "backpack",
        "mask",
        "helmet"
    ];

	decl(override) def(process)
	{
		params ["_args","_isFirstCall"];
		private _ctg = [_isFirstCall,30,20,false] call nd_stdLoad;
		call nd_cleanupData;
		
		_args params [["_model",""],["_text",""],["_specFlag","obj"]];
		
        private _sizeX = 80;
        private _sizeY = 90;
        private _zone = [WIDGETGROUP,[50-_sizeX/2,50-_sizeY/2,_sizeX,_sizeY],_ctg] call nd_regWidget;

        private _back = [BACKGROUND,WIDGET_FULLSIZE,_zone] call nd_regWidget;
		_back setBackgroundColor [.1,0.1,0.1,.8];

        private _tUp = [TEXT,[0,0,100,10],_zone] call nd_regWidget;
        [_tUp,format["<t align='center' size='1.2'>%1</t>",_text]] call widgetSetText;
		
        private _internalZone = [WIDGETGROUP,[0,10,100,80],_zone] call nd_regWidget;

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

    decl(_syncModelPos)
    {
        params ["_ctg"];
        private _obj = _ctg getvariable "model";
        private _scale = 1 / (getResolution select 5); // keep object the same size for any interface size
        private _distance = 30 * 4/3;
        if ((getResolution select 4) < (4/3)) then { _distance = _distance * (getResolution select 7); }; // eg 5x4
        private _base = ["3d", [
            (ctrlPosition _ctg) select 0,
            (ctrlPosition _ctg) select 1,
            _distance
        ], _scale] call widgetModel_objectHelper;
        _base = [((ctrlPosition _ctg) select 0) + (
            ((ctrlPosition _ctg) select 2)/2
        ),
            ((core_modelBBX getOrDefault [ctrlModel _obj,[0,0,1]]) select 2) * (_base select 1), 
            //_base select 1,
        ((ctrlPosition _ctg) select 1) + (
            ((ctrlPosition _ctg) select 3)/2
        )];
        
        _obj ctrlSetPosition _base;
        _obj ctrlSetModelScale _scale;
        _obj ctrlSetModelDirAndUp (([60,75,0] call model_convertPithBankYawToVec));

        _obj ctrlSetFadE rand(0.2,0.5);
        _obj ctrlCommit 0;
    }

endstruct