// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

init_function(prox_internal_onUpdateTransform)
{
	// ["onFrame",{
	// 	if !(call prox_isItemLoaded) exitWith {
	// 		//["Объект не загружен"] call showError;
	// 	};
	// 	private _sname = prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_SELNAME;
	// 	private _posOffset = prox_curCfgPos;

	// 	//prox_centerObj
	// 	private _itmObj = prox_itemObj;
	// 	private _centerObj = prox_centerObj;
	// 	private _centerOffset = prox_centerObjOffset;
		
	// 	_selPos = prox_targetObj selectionPosition [_sname,"Memory"];
	// 	_vsel = prox_targetObj selectionVectorDirAndUp [_sname,"Memory"];

	// 	_itmObj setposatl (prox_targetObj modelToWorldVisual (_selPos vectoradd _posOffset));
	// 	_itmObj setVectorDirAndUp _vsel;//(([_vsel]+prox_curCfgVec) call BIS_fnc_transformVectorDirAndUp);


	// }] call Core_addEventHandler;

	
	// ["onDraw",{
	// 	call prox_syncItemObjTransform
	// }] call Core_addEventHandler;
}

function(prox_syncItemObjTransform)
{
	if !(call prox_isItemLoaded) exitWith {
		//["Объект не загружен"] call showError;
	};
	//if (true) exitWith {};
	private _posOffset = prox_curCfgPos;

	//prox_centerObj
	private _itmObj = prox_itemObj;
	private _centerObj = prox_centerObj;
	private _centerOffset = prox_centerObjOffset;


	/*
		1. Аттачим центральный объект к прокси слоту
		2. аттачим предмет к центральному объекту
	*/

	_centerObj attachTo [
		prox_targetObj,
		_posOffset,
		prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_SELNAME,
		true];

	//! это самый оптимальный вариант для вращения, но должно быть ограничение для определнных осей 90 градусов
	[_centerObj,prox_curCfgVec] call BIS_fnc_setObjectRotation;
	
	//[_centerObj,prox_curCfgVec] call model_SetPitchBankYaw;
	//_centerObj setVectorDirAndUp (([null]+prox_curCfgVec) call BIS_fnc_transformVectorDirAndUp);

	//fix lag vector
	_centerObj attachTo [
		prox_targetObj,
		_posOffset,
		prox_slotListData select prox_curSelection select PROX_SDATA_INDEX_SELNAME,
		true];
	
	_itmObj attachTo [_centerObj,_centerOffset];
}
