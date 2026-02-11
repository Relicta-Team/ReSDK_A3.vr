// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//перезагрузка листа по текущей категории инвентаря
function(prox_inv_loadInventoryList)
{
	private _switcher = prox_inv_widgetCurrentList select 0;
	private _lb = prox_inv_widgetCurrentList select 1;
	lbclear _lb;

	{
		private _itm = _lb lbadd _x;
	} foreach (prox_inv_types select prox_inv_curTypeIdx select 2);

	_lb lbSetCurSel (prox_inv_dataCurIndexes select prox_inv_curTypeIdx);
}

//полная перезагрузка слотов инвентаря
function(prox_inv_onChangeCurrentInventoryItem)
{
	{
		_x params ["_n","","_lvals","_codeUnload","_codeLoad"];
		_curVal = _lvals select (prox_inv_dataCurIndexes select _foreachIndex);
		
		call _codeUnload;
		
		if (_curVal!="") then {
			_curVal call _codeLoad;
		};
	} foreach prox_inv_types;

	call prox_syncItemObjTransform;
}
