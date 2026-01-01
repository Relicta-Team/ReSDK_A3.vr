// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================




function(inspector_internal_onFrame)
{
	if !isNullReference(inspector_internal_lastWidgetTransformPos select 0) then {
		//set main vars
		_wid = inspector_internal_lastWidgetTransformPos select 0;
		private _objWorld = _wid getVariable "_refWorldObj";
		private _data = [_objWorld] call golib_getHashData;
		
		//code...		
		if isNull(_wid getVariable "transform_lastPoint") exitWith {};
		_mPos = call mouseGetPosition select 1;
		_targPos = _wid getVariable "transform_lastPoint";
		
		_deval = 0.01;
		
		_factor = if (_mPos>_targPos) then {
			linearConversion[_targPos,_targPos+20,_mPos,-_deval,0]
		} else {
			linearConversion[_targPos,_targPos-20,_mPos,0,_deval]
		};
		//["factor %1",_factor] call printTrace;
		_idx = _wid getVariable "transform_index";
		_oldPos = getPosWorld _objWorld;
		_oldPos set [_idx,(_oldPos select _idx) + _factor];
		_objWorld setPosWorld _oldPos;
		(_wid getVariable "input") ctrlSetText str (((ASLToAGL _oldPos) select _idx) + _factor);
		
		
		if (inputMouse 0 == 0) then {
			inspector_internal_lastWidgetTransformPos = [widgetNull];
			_transName = _wid getVariable "transform_name";
			_transIndex = _wid getVariable "transform_index";
			_real = _objWorld call golib_om_getPosition;
			_objWorld setPosAtl _real;
			[_objWorld,_real] call golib_om_setPosition;
		};
		
	};

}