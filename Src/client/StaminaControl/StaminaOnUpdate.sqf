// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//Данный код вызывает ошибку прогресса
//[getMainBar,[0,0 + rand(-10,10) + stamina_mainbar_size_h / 2]/*,stamina_widgetUpdate / 2*/] call widgetSetPositionOnly;

_ctg = getCtgBar;
_precent = call stamina_convCurToPrec;
if (_precent >= 100) then {
	
	if (_ctg getVariable ["isVisible",false]) then {
		/*if (!(_ctg getVariable ["prepToSetInvisible",false])) then {
			_ctg setVariable ["prepToSetInvisible",true];
			_ctg setVariable ["timeToSetInvisible",tickTime + 5];
		};
		if (tickTime < (_ctg getvariable ["timeToSetInvisible",tickTime + 5])) exitWith {};*/
		_ctg setVariable ["isVisible",false];
		_ctg setFade 1;
		_ctg commit stamina_fadetime_mainctg;
	};
	
} else {
	if !(_ctg getVariable ["isVisible",false]) then {
		_ctg setVariable ["isVisible",true];
		_ctg setFade 0;
		_ctg commit stamina_fadetime_mainctg;
		
		//_ctg setVariable ["prepToSetInvisible",false];
	};
};

if (stamina_lastVal != cd_stamina_cur) then {
	
	call stamina_syncVisual;
	stamina_lastVal = cd_stamina_cur;
};