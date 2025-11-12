// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\struct.hpp>
#include "overlay.hpp"

struct(OverlayLayerController)

	def(_allGroups) [];

	def(init)
	{
		private _arr = [];
		{
			_arr set [_x,call overlay_makeLayerGroup];
		} foreach OVERLAY_LAYER_LIST_ALL;
	}

	def(getLayerGroup)
	{
		params ["_layer"]; //as OVERLAY_LAYER_*
		self getv(_allGroups) get _layer
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
	def(mode) OVERLAY_PRIORITY_NORMAL
	def(layer) OVERLAY_LAYER_BODY

	def(init)
	{
		params ["_engCfg",["_priority",0]];
		self setv(engineConfig,_engCfg);
		self setv(priority,_priority);
	}

	def(equipmentAdd)
	{
		params ["_actor","_item"];
	}
endstruct

struct(OverlayHead) base(OverlayBase)
	def(layer) OVERLAY_LAYER_HEAD
	def(equipmentAdd)
	{
		params ["_actor","_item"];
		_actor addHeadgear getVar(_item,armaClass);
	}
endstruct

struct(OverlayFace) base(OverlayBase)
	def(layer) OVERLAY_LAYER_FACE
	def(equipmentAdd)
	{
		params ["_actor","_item"];
		_actor addGoggles getVar(_item,armaClass);
	}
endstruct

struct(OverlayBody) base(OverlayBase)
	def(layer) OVERLAY_LAYER_BODY
	def(equipmentAdd)
	{
		params ["_actor","_item"];
		_actor forceAddUniform getVar(_item,armaClass);
	}
endstruct

struct(OverlayArmor) base(OverlayBase)
	def(layer) OVERLAY_LAYER_ARMOR
	def(equipmentAdd)
	{
		params ["_actor","_item"];
		_actor addVest getVar(_item,armaClass);
	}
endstruct

struct(OverlayBackpack) base(OverlayBase)
	def(layer) OVERLAY_LAYER_BACKPACK
	def(equipmentAdd)
	{
		params ["_actor","_item"];
		_actor addBackpackGlobal getVar(_item,armaClass);
	}
endstruct