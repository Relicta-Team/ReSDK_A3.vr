// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\struct.hpp>
#include "overlay.hpp"

/*
!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!! WARNING:
! THIS FILE CURRENTLY NOT ADDED INTO LOADER !
!!!!!!!!!!!!!!!!!!!!!!!!!!
*/

//создает группу слоя для отображения
overlay_makeLayerGroup = {
	createHashMapFromArray [
		[OVERLAY_PRIORITY_BASE,[]],
		[OVERLAY_PRIORITY_NORMAL,[]],
		[OVERLAY_PRIORITY_EXTERNAL,[]]
	];
};

/*
	Добавляет объект в слой отображения
*/
overlay_register = {
	params ["_mob","_controller","_item"];

	if not_equals(_overlay getv(layer),_controller getv(targetLayer)) exitWith {};
	private _map = _controller getv(_overlayGroup);
	call {
		private _mode = _overlay getv(mode);
		if equals(_mode,OVERLAY_PRIORITY_BASE) exitWith {
			_map get OVERLAY_PRIORITY_BASE insert [0,[_overlay]];
		};
		if equals(_mode,OVERLAY_PRIORITY_NORMAL) exitWith {
			private _normalList = _map get OVERLAY_PRIORITY_NORMAL;
			_normalList pushBack _overlay;

			//sort by priority
			_normalList = [_normalList,{_x getv(priority)}] call sortBy;
			_map set [OVERLAY_PRIORITY_NORMAL,_normalList];
		};
		if equals(_mode,OVERLAY_PRIORITY_EXTERNAL) exitWith {
			_map get OVERLAY_PRIORITY_EXTERNAL pushBack _overlay;
		};
	};
};

/*
	Удаляет объект из слоя отображения
*/
overlay_unregister = {
	params ["_mob","_controller","_item"];
};


overlay_internal_getVisibleItem = {
	params ["_controller"];
	private _map = _controller getv(_overlayGroup);
	private _list = _map get OVERLAY_PRIORITY_EXTERNAL;
	if (count _list > 0) exitWith {
		array_selectlast(_list);
	};
	_list = _map get OVERLAY_PRIORITY_NORMAL;
	if (count _list > 0) exitWith {
		array_selectlast(_list);
	};
	_list = _map get OVERLAY_PRIORITY_BASE;
	if (count _list > 0) exitWith {
		array_selectlast(_list);
	};
};

/*
	Обновляет визуальное отображение для данного слоя
*/
overlay_updateVisual = {
	params ["_mob","_item"];
};