// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#define getEdenDisplay (findDisplay 313)
#define getEdenMenu (getEdenDisplay displayCtrl 120)
#define widgetNull controlnull

#define getDisplay (displayObjectRef select 0)
#define isDisplayOpen (!(getDisplay isEqualTo displaynull))

//widgets types

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

//macro helpers

#define setBackgroundColor ctrlSetBackgroundColor
#define setStructuredText ctrlSetStructuredText
#define setFade ctrlSetFade
#define getFade ctrlFade
#define commit ctrlCommit
#define isCommited ctrlCommitted
#define setFocus ctrlSetFocus

#define transformSizeByAR(val) ((val) / (getresolution select 4))
#define getWidthByHeightToSquare(val) transformSizeByAR(val)
//case sentivity
#define widgetGetPicture(val) ctrlText (val)
#define widgetGetText(val) ctrlText (val)

#define __widgetFadeReset(wid,time,fademode) wid setFade fademode; \
wid commit 0; \
wid setFade 0; \
wid commit time \

#define widgetFadeout(wid,time) __widgetFadeReset(wid,time,1)
#define widgetFadein(wid,time) (wid) setFade 1; (wid) commit time
#define widgetFadeNow(wid,value) (wid) setFade value; (wid) commit 0
#define widgetSetFade(wid,val,com) (wid) setFade val; (wid) commit com

//other
#define WIDGET_FULLSIZE [0,0,100,100]