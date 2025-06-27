#include <definer.hpp>

import RscButton;
import RscButtonMenu;

class RLCTRscButtonMenu : RscButtonMenu {
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
};

class RLCTRscButton : RscButton {
	soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
	soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
	soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
	soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0,0};
};

class RscWebBrowser
{
	type = 106; // 106
	idc = -1;
	deletable = 0;
	style = 0;
	x = 0;
	y = 0;
	w = 1;
	h = 1;
	allowExternalURL = 1;
	allowExternalContent = 1;
	colorBackground[]= {1,1,1,1};
	url = "https://relicta.ru";
};

class MyButton {
	idc = -1;
	type = CT_BUTTON;
	style = ST_CENTER;
	default = false;
	font = "TahomaB"; //Ringbear
	sizeEx = 0.03;
	colorText[] = { 0, 0, 0, 1 };
	colorFocused[] = { 1, 1, 1, 1 };		// border color for focused state
	colorDisabled[] = { 0, 0, 1, 0.7 };		// text color for disabled state
	colorBackground[] = { 1, 1, 1, 0.8 };
	colorBackgroundDisabled[] = { 1, 1, 1, 0.5 };	// background color for disabled state
	colorBackgroundActive[] = { 1, 1, 1, 1 };		// background color for active state
	offsetX = 0;
	offsetY = 0;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0.5 };
	colorBorder[] = { 0, 0, 0, 1 };
	borderSize = 0;
	soundEnter[] = { "", 0, 1 };	// no sound
	soundPush[] = { "", 0, 1 };
	soundClick[] = { "", 0, 1 };	// no sound
	soundEscape[] = { "", 0, 1 };	// no sound
	x = 0.4; y = 0.475;
	w = 0.2; h = 0.05;
	text = "Close";
};
class Structured {
	style = ST_MULTI;
	type = CT_STRUCTURED_TEXT;
	idc = -1;
	colorBackground[] = { 1, 1, 1, 0 };
	x = 0.1;
	y = 0.1;
	w = 0.3;
	h = 0.1;
	//size = (            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
	size = 1 * safezoneH;
	text = "";
	class Attributes {
	 // font = "EtelkaNarrowMediumPro";
	  //color = "#000000";
	  align = "center";
	  valign = "bottom";
	//  shadow = false;
	//  shadowColor = "#ff0000";
	//  size = "1.8";
	};
}


class RscControlsGroupNoScrollbars;

class RscControlsGroupNoScrollbars_NEW  {
	idc = -1;

	style = 16;
	type = 15;
	deletable = 1;
	fade = 0;
	autoScrollEnabled = 0;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	class Controls {};
	onMouseZChanged = "";
	onMouseMoving = "";
	onMouseHolding = "";
	onMouseButtonDown = "";
	onMouseButtonUp = "";
	class HScrollbar {
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		color[] = {1, 1, 1,0 };
		colorActive[] = {1, 1, 1, 0};
		colorDisabled[] = {1, 1, 1, 0};

		autoScrollDelay = 0;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		scrollSpeed = 0;
		height = 0;
		width = 0;
		shadow = 0;
	};
	class VScrollbar {
		arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
		arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
		border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
		thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
		idc = 1900;
		color[] = {1, 0, 0, 0};
		colorActive[] = {1, 1, 1, 0};
		colorDisabled[] = {1, 1, 1, 0};
		autoScrollDelay = 0;
		autoScrollEnabled = 0;
		autoScrollRewind = 0;
		autoScrollSpeed = -1;
		scrollSpeed = 0;
		height = 0;
		width = 0;
		shadow = 0;
	};
	
};

class RscEdit {
	type = 2;
	style = "0x00 + 0x40";
	x = 0.4;
	y = 0.3;
	w = 0.3;
	h = 0.04;
	sizeEx = 0.04;
	autocomplete = "";
	text="";
	font = "PuristaMedium";
	canModify = true; 
	forceDrawCaret = false;
	colorSelection[] = {0,1,0,1};
	colorText[] = {1,1,1,1};
	colorDisabled[] = {1,1,1,1}; 
	colorBackground[] = {0,0,0,0.5}; 
};

class RscEditChat : RscEdit {
	maxChars = 256;
};

class RscEditMulti: RscEdit
{
	style=16;
};

class RscEditNewSizeEx : RscEdit {
	sizeEx = __EVAL(0.013 / (getResolution select 5));
};


class RscSliderNew {
	idc = -1;
    type = 43;
    style = 1024;
    x = 0.4;
    y = 0.3;
    w = 0.3;
    h = 0.04;
    arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
    border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
    thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
    color[] = {1,1,1,0.5};
    coloractive[] = {1,1,1,1};
    sliderPosition = 5;
    sliderRange[] = {1,10};
    sliderStep = 1;
    lineSize = 1;
};

// class RscControlsGroup;

// class RscControlsGroupRLCT {
	// type = CT_CONTROLS_GROUP;
	// idc = -1;

	// style = 16;
  //type = 15;
// /* 	class VScrollbar {};
	
	// class HScrollbar {};
	
	// class ScrollBar {}; */
// };

//useless
/* class MyRscStructuredText {
  idc = -1; 
  type = CT_STRUCTURED_TEXT;  // defined constant
  style = ST_CENTER;            // defined constant
  colorBackground[] = { 1, 1, 1, 1 }; 
  x = 0.1; 
  y = 0.1; 
  w = 0.3; 
  h = 0.1; 
  size = 0.018;
  text = "";
  class Attributes {
    color = "#000000";
    align = "center";
    valign = "middle";
    shadow = false;
    shadowColor = "#ff0000";
    size = "1";
  };
}; */