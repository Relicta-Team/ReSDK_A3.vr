// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\struct.hpp>
#include "overlay.hpp"

/*
	Основной контроллер слоёв отображения. Хранит слои
*/
struct(OverlayLayerController)

	def(_allGroups) [];
	def(_suppressionCounters) [];

	def(init)
	{
		private _arr = [];
		_arr resize (count OVERLAY_LAYER_LIST_ALL); //reserve space
		{
			_arr set [_x,call overlay_makeLayerGroup];
		} foreach OVERLAY_LAYER_LIST_ALL;
		self setv(_allGroups,_arr);

		private _suppressions = [];
		_suppressions resize (count OVERLAY_LAYER_LIST_ALL);
		{
			_suppressions set [_x,0];
		} foreach OVERLAY_LAYER_LIST_ALL;
		self setv(_suppressionCounters,_suppressions);
	}

	def(getLayerGroup)
	{
		params ["_layer"]; //as OVERLAY_LAYER_*
		self getv(_allGroups) get _layer
	}

	def(adjustSuppressionCount)
	{
		params ["_layer","_delta"];
		private _arr = self getv(_suppressionCounters);
		private _newValue = (_arr get _layer) + _delta;
		if (_newValue < 0) then {
			_newValue = 0;
		};
		_arr set [_layer,_newValue];
		_newValue
	}

endstruct

/*
	Базовый класс для всех слоев отображения

	class(EquipmentItemMask)
		var(overlay,struct_newp(OverlayFace,50 arg OVERLAY_PRIORITY_EXTERNAL));
	endclass
*/
struct(OverlayBase)
	def(priority) 0
	def(mode) OVERLAY_PRIORITY_NORMAL //тип оверлея (базовый, нормальный, внешний)
	def(cover) OVERLAY_LAYER_BODY //покрываемый слой (в какой слой вставляется этот оверлей)
	def(suppress) [] //список слоев которые должны быть скрыты, например противогаз скрывает слой лица

	def(src) nullPtr; //источник оверлея (объект, который его создал)

	def(init)
	{
		params [["_priority",self getv(priority)],["_mode",self getv(mode)]];
		self setv(priority,_priority);
		self setv(mode,_mode);
	}

	def(str)
	{
		struct_typename(self);
	}

	def(equipmentAdd)
	{
		params ["_actor"];
	}
endstruct

struct(OverlayHead) base(OverlayBase)
	def(cover) OVERLAY_LAYER_HEAD
	def(equipmentAdd)
	{
		params ["_actor"];
		_actor addHeadgear getVar(self getv(src),armaClass);
	}
endstruct

struct(OverlayFace) base(OverlayBase)
	def(cover) OVERLAY_LAYER_FACE
	def(equipmentAdd)
	{
		params ["_actor"];
		_actor addGoggles getVar(self getv(src),armaClass);
	}
endstruct

struct(OverlayBody) base(OverlayBase)
	def(cover) OVERLAY_LAYER_BODY
	def(equipmentAdd)
	{
		params ["_actor"];
		_actor forceAddUniform getVar(self getv(src),armaClass);
	}
endstruct

struct(OverlayArmor) base(OverlayBase)
	def(cover) OVERLAY_LAYER_ARMOR
	def(equipmentAdd)
	{
		params ["_actor"];
		_actor addVest getVar(self getv(src),armaClass);
	}
endstruct

struct(OverlayBackpack) base(OverlayBase)
	def(cover) OVERLAY_LAYER_BACKPACK
	def(equipmentAdd)
	{
		params ["_actor"];
		_actor addBackpackGlobal getVar(self getv(src),armaClass);
	}
endstruct