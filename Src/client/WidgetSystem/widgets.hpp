// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\lang.hpp>

namespace(WidgetSystem,widget_)

#define widgetNull controlnull

macro_func(widget_getGUI,display())
#define getGUI (uinamespace getvariable ["gui",DisplayNull])
macro_func(widget_getDisplay,display())
#define getDisplay (findDisplay 10000)
macro_func(widget_isDisplayOpen,bool())
#define isDisplayOpen (!(getDisplay isEqualTo displaynull))


//widgets types

enum(WidgetType,_)
#define LISTBOX "RscListBox"
#define TEXT "RscStructuredText"
#define PICTURE "RscPicture"
#define ACTIVEPICTURE "RscActivePicture"
#define BUTTON "RLCTRscButton"
#define BUTTONMENU "RLCTRscButtonMenu"
#define INPUT "RscEdit"
#define INPUTMULTI "RscEditMulti"
#define INPUTMULTIV2 "!RscEditMulti!inphndl"
#define INPUTCHAT "RscEditChat"
#define WIDGETGROUP "RscControlsGroupNoScrollbars_NEW"
#define WIDGETGROUPSCROLLS "RscControlsGroup"
#define WIDGETGROUP_H "RscControlsGroupNoHScrollbars"
#define BACKGROUND ("!" + TEXT + "!background")
#define SLIDERW "RscSlider"
#define SLIDERWNEW "RscSliderNew"
#define SLIDERH "RscSliderH"
#define CHECKBOX "RscCheckBox"


//macro helpers
inline_macro
#define setBackgroundColor ctrlSetBackgroundColor
inline_macro
#define setStructuredText ctrlSetStructuredText
inline_macro
#define setFade ctrlSetFade
inline_macro
#define getFade ctrlFade
inline_macro
#define commit ctrlCommit
inline_macro
#define isCommited ctrlCommitted
inline_macro
#define setFocus ctrlSetFocus

macro_func(widget_transformSizeByAspectRatio,float(float))
#define transformSizeByAR(val) ((val) / (getresolution select 4))
macro_func(widget_getWidthByHeightToSquare,float(float))
#define getWidthByHeightToSquare(val) transformSizeByAR(val)
//case sentivity
inline_macro
#define widgetGetPicture(val) ctrlText (val)
inline_macro
#define widgetGetText(val) ctrlText (val)

inline_macro
#define __widgetFadeReset(wid,time,fademode) wid setFade fademode; \
wid commit 0; \
wid setFade 0; \
wid commit time \

macro_func(widget_fadeOut,void(widget;float))
#define widgetFadeout(wid,time) __widgetFadeReset(wid,time,1)
macro_func(widget_fadeIn,void(widget;float))
#define widgetFadein(wid,time) wid setFade 1; wid commit time
macro_func(widget_fadeNow,void(widget;float))
#define widgetFadeNow(wid,value) wid setFade value; wid commit 0
macro_func(widget_setFadeAt,void(widget;float;float))
#define widgetSetFade(wid,val,com) wid setFade val; wid commit com

//other
macro_const(widget_fullSize)
#define WIDGET_FULLSIZE [0,0,100,100]