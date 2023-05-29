// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\engine.hpp>
#include <..\..\oop.hpp>
#include <..\..\text.hpp>
#include <..\..\..\client\WidgetSystem\widgets.hpp>

#include "EditorDebug_datahandler.sqf"
#include "EditorDebug_visual.sqf"

editorDebug_isEnabled = false; //not working correctly (position wrong). need fix

editorDebug_handlerUpdate = -1;


call editorDebug_init;
