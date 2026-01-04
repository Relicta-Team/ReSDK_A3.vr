// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


vcom_camObject = objNull;
	vcom_defaultCamPos = [5,-45,30];
vcom_visualObject = objNull; //fact model

//for rendering helpers
vcom_logicObject = objNull; //we can attach any objects for this (dynamic)
vcom_targetObject = objNull;

vcom_observedObjects = [];
//Позиция в которой происходит симуляция обсервера
vcom_observ_centerPos = [1000,1000,10000]; //! do not change this variable
vcom_observ_stateLeftPanel = false;
vcom_observ_stateRightPanel = false;
vcom_observ_hasGeometry = false;
	vcom_observ_buttons = [[],[]];
	vcom_observ_camPos = [0,0,0];
	vcom_const_observ_buttons = {[[],[]]};


vcom_handler_draw3D = -1;
vcom_visual_canDrawLines = true;

vcom_windowMode = "";
vcom_widgets = [widgetNull]; //0 - main ctg, 1 - ngo widget
vcom_mainDisplay = [displayNull];

vcom_relposEditor_listPoints = [];

; //do not remove this
#include "Common.sqf"
#include "RelativePositionEditor.sqf"
#include "ScriptedEmitterEditor.sqf"
#include "ProxyEditor.sqf"