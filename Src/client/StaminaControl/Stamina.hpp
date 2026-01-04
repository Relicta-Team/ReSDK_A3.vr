// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(StaminaSystem,stamina_)

//Тестовый режим отображения и изменения
//#define stamina_debug
macro_const(stamina_widgetBiasX)
#define stamina_bias_x 1
macro_const(stamina_widgetBiasY)
#define stamina_bias_y 1

macro_const(stamina_widgetSizeH)
#define stamina_size_h 2
macro_const(stamina_widgetSizeW)
#define stamina_size_w 20

macro_const(stamina_borderSizeX)
#define stamina_border_size_x 1
macro_const(stamina_borderSizeY)
#define stamina_border_size_y 15

macro_const(stamina_mainbarSizeH)
#define stamina_mainbar_size_h 50

macro_func(stamina_getMainBar,widget())
#define getMainBar (stamina_widgets select 0)
macro_func(stamina_getBackroundBar,widget())
#define getBackroundBar (stamina_widgets select 1)
macro_func(stamina_getCtgBar,widget())
#define getCtgBar (stamina_widgets select 2)
macro_func(stamina_getLowValueBar,widget())
#define getLowValueBar (stamina_widgets select 3)

macro_const(stamina_widgetUpdateDelay)
#define stamina_widgetUpdate 0.12

macro_const(stamina_fadetime_mainctg)
#define stamina_fadetime_mainctg 0.5
