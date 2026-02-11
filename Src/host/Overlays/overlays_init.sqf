// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\struct.hpp>
#include "overlay.hpp"

/*
	Overlay system

	Visualisation for inventory slots

	Controller -> LayerGroup -> Overlay

	Controller - это объект, хранящий все слои отображения
	LayerGroup - это упорядоченная группа оверлеев. По ним выбирается какой из оверлеев будет реально отображен на персонаже
	Overlay - это абстракция, отвечающая за реализацию отображения объекта для конкретного слоя
*/

//создает группу слоя для отображения
overlay_makeLayerGroup = {
	createHashMapFromArray [
		[OVERLAY_PRIORITY_BASE,null],
		[OVERLAY_PRIORITY_NORMAL,[]],
		[OVERLAY_PRIORITY_EXTERNAL,[]],
		[OVERLAY_GROUP_KEY_CURRENT,null]
	];
};

/*
	Добавляет оверлей в слой отображения
*/
overlay_register = {
	params ["_mob","_overlay"];

	private _controller = getVar(_mob,overlayController);
	private _layerId = _overlay getv(cover);
	private _map = _controller callp(getLayerGroup,_layerId);

	call {
		private _mode = _overlay getv(mode);
		if equals(_mode,OVERLAY_PRIORITY_BASE) exitWith {
			_map set [OVERLAY_PRIORITY_BASE,_overlay];
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

	[_mob,_layerId] call overlay_updateVisual;
};

/*
	Удаляет объект из слоя отображения
*/
overlay_unregister = {
	params ["_mob","_overlay"];
	private _controller = getVar(_mob,overlayController);
	private _layerId = _overlay getv(cover);
	private _map = _controller callp(getLayerGroup,_layerId);

	call {
		private _mode = _overlay getv(mode);
		if equals(_mode,OVERLAY_PRIORITY_BASE) exitWith {
			_map set [OVERLAY_PRIORITY_BASE,null];
		};
		private _list = _map get _mode;
		array_remove(_list,_overlay);
	};

	[_mob,_layerId] call overlay_updateVisual;
};


overlay_internal_getVisibleLayer = {
	params ["_layerGroup"];
	
	private _list = _layerGroup get OVERLAY_PRIORITY_EXTERNAL;
	if (count _list > 0) exitWith {
		array_selectlast(_list);
	};
	_list = _layerGroup get OVERLAY_PRIORITY_NORMAL;
	if (count _list > 0) exitWith {
		array_selectlast(_list);
	};
	private _baseLayer = _layerGroup get OVERLAY_PRIORITY_BASE;
	if !isNullVar(_baseLayer) exitWith {
		_baseLayer;
	};
	null;
};

/*
	Обновляет визуальное отображение для данного слоя
*/
overlay_updateVisual = {
	params ["_mob","_layerId"];

	private _controller = getVar(_mob,overlayController);
	private _queue = [_layerId];
	private _processed = [];

	while {count _queue > 0} do {
		private _currentLayer = _queue deleteAt 0;
		if (_currentLayer in _processed) then {continue};
		_processed pushBack _currentLayer;

		private _layerGroup = _controller callp(getLayerGroup,_currentLayer);
		private _currentOverlay = _layerGroup get OVERLAY_GROUP_KEY_CURRENT;
		private _nextOverlay = [_layerGroup] call overlay_internal_getVisibleLayer;

		if (isNullVar(_currentOverlay) && isNullVar(_nextOverlay)) then {continue};
		if (!isNullVar(_currentOverlay) && !isNullVar(_nextOverlay) && {equals(_currentOverlay,_nextOverlay)}) then {continue};

		if (!isNullVar(_currentOverlay)) then {
			{
				private _count = _controller callp(adjustSuppressionCount,_x arg -1);
				if (_count <= 0) then {
					_queue pushBackUnique _x;
				};
			} foreach (_currentOverlay getv(suppress));
		};

		_layerGroup set [OVERLAY_GROUP_KEY_CURRENT,_nextOverlay];

		if (isNullVar(_nextOverlay)) then {
			[_mob,_currentLayer] call overlay_resetEquipmentByLayerId;
			continue;
		};

		_nextOverlay callp(equipmentAdd,_mob);

		{
			_controller callp(adjustSuppressionCount,_x arg 1);
			[_mob,_x] call overlay_resetEquipmentByLayerId;
		} foreach (_nextOverlay getv(suppress));
	};
};

overlay_resetEquipmentByLayerId = {
	params ["_mob","_layerId"];
	private _actor = getVar(_mob,owner);
	if (_layerId == OVERLAY_LAYER_BODY) exitWith {
		removeUniform _actor;
	};
	if (_layerId == OVERLAY_LAYER_HEAD) exitWith {
		removeHeadgear _actor;
	};
	if (_layerId == OVERLAY_LAYER_FACE) exitWith {
		removeGoggles _actor;
	};
	if (_layerId == OVERLAY_LAYER_ARMOR) exitWith {
		removeVest _actor;
	};
	if (_layerId == OVERLAY_LAYER_BACKPACK) exitWith {
		removeBackpack _actor;
	};
};