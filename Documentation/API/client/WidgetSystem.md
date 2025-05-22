# blockedButtons.hpp

## ACT(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
actionKeys #name
```
File: [client\WidgetSystem\blockedButtons.hpp at line 11](../../../Src/client/WidgetSystem/blockedButtons.hpp#L11)
## GROUP_ACTIONS

Type: constant

Description: 


Replaced value:
```sqf
ACT(CommandingMenu1) + ACT(CommandingMenu2) + ACT(CommandingMenu3) + ACT(CommandingMenu4) + ACT(CommandingMenu5) \
 + ACT(CommandingMenu6) + ACT(CommandingMenu7) + ACT(CommandingMenu8) + ACT(CommandingMenu9) + ACT(CommandingMenu0) + \
 ACT(CommandingMenuSelect1) + ACT(CommandingMenuSelect2) + ACT(CommandingMenuSelect3) + ACT(CommandingMenuSelect4) + \
 ACT(CommandingMenuSelect5) + ACT(CommandingMenuSelect6) + ACT(CommandingMenuSelect7) + ACT(CommandingMenuSelect8) + \
 ACT(CommandingMenuSelect9) + ACT(CommandingMenuSelect0) + \
 ACT(prevAction) + ACT(nextAction) + ACT(Action) + ACT(ActionContext) + ACT(defaultAction)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 15](../../../Src/client/WidgetSystem/blockedButtons.hpp#L15)
## GROUP_COMMA_MENU

Type: constant

Description: 


Replaced value:
```sqf
ACT(SelectGroupUnit1) + ACT(SelectGroupUnit2) + ACT(SelectGroupUnit3) + \
ACT(SelectGroupUnit4) + ACT(SelectGroupUnit5) + ACT(SelectGroupUnit6) + ACT(SelectGroupUnit7) + \
ACT(SelectGroupUnit8) + ACT(SelectGroupUnit9) + ACT(SelectGroupUnit0) + ACT(selectAll)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 24](../../../Src/client/WidgetSystem/blockedButtons.hpp#L24)
## SIMPLE_PLAYER_INTERACTION

Type: constant

Description: 


Replaced value:
```sqf
ACT(showMap) + ACT(gear) + ACT(navigateMenu) + ACT(EvasiveLeft) + ACT(EvasiveRight) + \
 ACT(Salute) + ACT(SitDown) + ACT(networkStats) + ACT(networkPlayers)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 30](../../../Src/client/WidgetSystem/blockedButtons.hpp#L30)
## ESCAPE_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
ACT(ingamePause)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 39](../../../Src/client/WidgetSystem/blockedButtons.hpp#L39)
## FORBIDDEN_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(GROUP_ACTIONS + GROUP_COMMA_MENU + SIMPLE_PLAYER_INTERACTION)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 42](../../../Src/client/WidgetSystem/blockedButtons.hpp#L42)
## FORBIDDEN_BUTTONS_SCROLL

Type: constant

Description: 


Replaced value:
```sqf
ACT(prevAction) + ACT(nextAction) + ACT(Action) + ACT(ActionContext) + ACT(defaultAction)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 44](../../../Src/client/WidgetSystem/blockedButtons.hpp#L44)
## ADDRULE_FORBIDDEN_BUTTONS(forkey)

Type: constant

Description: 
- Param: forkey

Replaced value:
```sqf
(forkey in FORBIDDEN_BUTTONS)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 47](../../../Src/client/WidgetSystem/blockedButtons.hpp#L47)
## ADDRULE_FORBIDDEN_SCROLL(forkey)

Type: constant

Description: 
- Param: forkey

Replaced value:
```sqf
(forkey in FORBIDDEN_BUTTONS_SCROLL)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 49](../../../Src/client/WidgetSystem/blockedButtons.hpp#L49)
## LEFT_MOVE_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
( ACT(TurnLeft) )
```
File: [client\WidgetSystem\blockedButtons.hpp at line 54](../../../Src/client/WidgetSystem/blockedButtons.hpp#L54)
## RIGHT_MOVE_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
( ACT(TurnRight) )
```
File: [client\WidgetSystem\blockedButtons.hpp at line 56](../../../Src/client/WidgetSystem/blockedButtons.hpp#L56)
## MOVE_FORWARD_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
( ACT(MoveForward) + ACT(MoveFastForward) + ACT(MoveSlowForward) )
```
File: [client\WidgetSystem\blockedButtons.hpp at line 59](../../../Src/client/WidgetSystem/blockedButtons.hpp#L59)
## CAN_MOVE_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(ACT(MoveForward) + ACT(MoveBack) + ACT(TurnLeft) + ACT(TurnRight) + \
 ACT(MoveFastForward) + ACT(MoveSlowForward) + ACT(turbo) + ACT(TurboToggle) + ACT(MoveLeft) + ACT(MoveRight) + ACT(GetOver))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 63](../../../Src/client/WidgetSystem/blockedButtons.hpp#L63)
## CHANGE_STANCE_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(ACT(AdjustUp) + ACT(AdjustDown) + ACT(Crouch) + ACT(Stand) + ACT(MoveUp) + ACT(MoveDown))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 67](../../../Src/client/WidgetSystem/blockedButtons.hpp#L67)
## FAST_DROP_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(ACT(Crouch) + ACT(MoveDown))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 70](../../../Src/client/WidgetSystem/blockedButtons.hpp#L70)
## SIDEWAYS_MOVEMENT_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(ACT(TurnLeft) + ACT(TurnRight))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 73](../../../Src/client/WidgetSystem/blockedButtons.hpp#L73)
# defines.sqf

## HEIGHT_WINDOW_DRAGGER

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\WidgetSystem\defines.sqf at line 37](../../../Src/client/WidgetSystem/defines.sqf#L37)
## createWidget_closeButton

Type: function

Description: 
- Param: _display
- Param: _text (optional, default "Закрыть")
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 17](../../../Src/client/WidgetSystem/defines.sqf#L17)
## createWidget_window

Type: function

Description: 
- Param: _display
- Param: _type
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 41](../../../Src/client/WidgetSystem/defines.sqf#L41)
## createWidget_square

Type: function

Description: 
- Param: _display
- Param: _type
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 61](../../../Src/client/WidgetSystem/defines.sqf#L61)
# functions.sqf

## HOME_PROTECT

Type: constant

Description: 


Replaced value:
```sqf
if (_key == KEY_HOME) then {call displayClose}
```
File: [client\WidgetSystem\functions.sqf at line 23](../../../Src/client/WidgetSystem/functions.sqf#L23)
## INDEX_TYPE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\WidgetSystem\functions.sqf at line 101](../../../Src/client/WidgetSystem/functions.sqf#L101)
## INDEX_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\WidgetSystem\functions.sqf at line 102](../../../Src/client/WidgetSystem/functions.sqf#L102)
## precent_to_real(proc_val)

Type: constant

Description: 
- Param: proc_val

Replaced value:
```sqf
(proc_val / 100)
```
File: [client\WidgetSystem\functions.sqf at line 525](../../../Src/client/WidgetSystem/functions.sqf#L525)
## STARTX

Type: constant

Description: Находится на экране


Replaced value:
```sqf
(0 * safezoneW + safezoneX)
```
File: [client\WidgetSystem\functions.sqf at line 554](../../../Src/client/WidgetSystem/functions.sqf#L554)
## STARTY

Type: constant

Description: 


Replaced value:
```sqf
(0 * safezoneH + safezoneY)
```
File: [client\WidgetSystem\functions.sqf at line 555](../../../Src/client/WidgetSystem/functions.sqf#L555)
## DIAPAZONX

Type: constant

Description: 


Replaced value:
```sqf
((1 * safezoneW + safezoneX) - STARTX)
```
File: [client\WidgetSystem\functions.sqf at line 556](../../../Src/client/WidgetSystem/functions.sqf#L556)
## DIAPAZONY

Type: constant

Description: 


Replaced value:
```sqf
((1 * safezoneH + safezoneY) - STARTY)
```
File: [client\WidgetSystem\functions.sqf at line 557](../../../Src/client/WidgetSystem/functions.sqf#L557)
## low_protect

Type: constant

Description: 


Replaced value:
```sqf
0.9
```
File: [client\WidgetSystem\functions.sqf at line 675](../../../Src/client/WidgetSystem/functions.sqf#L675)
## max_protect

Type: constant

Description: 


Replaced value:
```sqf
1.1
```
File: [client\WidgetSystem\functions.sqf at line 677](../../../Src/client/WidgetSystem/functions.sqf#L677)
## setwt(wid,_t,_sz)

Type: constant

Description: 
- Param: wid
- Param: _t
- Param: _sz

Replaced value:
```sqf
[wid,format["<t align='center' size='%2'>%1</t>",_t,_sz]] call widgetSetText
```
File: [client\WidgetSystem\functions.sqf at line 760](../../../Src/client/WidgetSystem/functions.sqf#L760)
## hasEnabledBlackScreen

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\WidgetSystem\functions.sqf at line 627](../../../Src/client/WidgetSystem/functions.sqf#L627)
## widget_antiGamma_lastError

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\WidgetSystem\functions.sqf at line 672](../../../Src/client/WidgetSystem/functions.sqf#L672)
## displayOpen

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 27](../../../Src/client/WidgetSystem/functions.sqf#L27)
## dynamicDisplayOpen

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 57](../../../Src/client/WidgetSystem/functions.sqf#L57)
## displayClose

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 90](../../../Src/client/WidgetSystem/functions.sqf#L90)
## createWidget

Type: function

Description: 
- Param: _display
- Param: _type
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\functions.sqf at line 96](../../../Src/client/WidgetSystem/functions.sqf#L96)
## deleteWidget

Type: function

Description: 
- Param: _widget
- Param: _nextFrame (optional, default false)

File: [client\WidgetSystem\functions.sqf at line 164](../../../Src/client/WidgetSystem/functions.sqf#L164)
## widgetSetPosition

Type: function

Description: 
- Param: _widget
- Param: _posarray
- Param: _time (optional, default -1)

File: [client\WidgetSystem\functions.sqf at line 183](../../../Src/client/WidgetSystem/functions.sqf#L183)
## widgetPosPrecentToSafezone

Type: function

Description: 
- Param: _widget
- Param: _prec
- Param: _index

File: [client\WidgetSystem\functions.sqf at line 226](../../../Src/client/WidgetSystem/functions.sqf#L226)
## widgetSetPositionOnly

Type: function

Description: 
- Param: _widget
- Param: _posarray
- Param: _time (optional, default -1)

File: [client\WidgetSystem\functions.sqf at line 263](../../../Src/client/WidgetSystem/functions.sqf#L263)
## widgetGetPosition

Type: function

Description: 
- Param: _xp
- Param: _yp
- Param: _wp
- Param: _hp

File: [client\WidgetSystem\functions.sqf at line 304](../../../Src/client/WidgetSystem/functions.sqf#L304)
## isMouseInsideWidget

Type: function

Description: 
- Param: _wid

File: [client\WidgetSystem\functions.sqf at line 337](../../../Src/client/WidgetSystem/functions.sqf#L337)
## isMouseInsidePosition

Type: function

Description: 
- Param: _xe
- Param: _ye
- Param: _xe2
- Param: _ye2

File: [client\WidgetSystem\functions.sqf at line 401](../../../Src/client/WidgetSystem/functions.sqf#L401)
## getMousePositionInWidget

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 418](../../../Src/client/WidgetSystem/functions.sqf#L418)
## widgetSetText

Type: function

Description: 
- Param: _obj
- Param: _text

File: [client\WidgetSystem\functions.sqf at line 468](../../../Src/client/WidgetSystem/functions.sqf#L468)
## widgetSetPicture

Type: function

Description: 
- Param: _obj
- Param: _text

File: [client\WidgetSystem\functions.sqf at line 482](../../../Src/client/WidgetSystem/functions.sqf#L482)
## widgetGetTextHeight

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 490](../../../Src/client/WidgetSystem/functions.sqf#L490)
## widgetWGScrolldown

Type: function

Description: 
- Param: _wid

File: [client\WidgetSystem\functions.sqf at line 510](../../../Src/client/WidgetSystem/functions.sqf#L510)
## mouseSetPosition

Type: function

Description: 
- Param: _xpos
- Param: _ypos

File: [client\WidgetSystem\functions.sqf at line 523](../../../Src/client/WidgetSystem/functions.sqf#L523)
## mouseGetPosition

Type: function

Description: 
- Param: _mX
- Param: _mY

File: [client\WidgetSystem\functions.sqf at line 531](../../../Src/client/WidgetSystem/functions.sqf#L531)
## convertScreenCoords

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 549](../../../Src/client/WidgetSystem/functions.sqf#L549)
## positionWorldToScreen

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 567](../../../Src/client/WidgetSystem/functions.sqf#L567)
## screenPosToWorldPoint

Type: function

Description: 
- Param: _spos (optional, default getMousePosition)
- Param: _distanceMul (optional, default 1000)
- Param: _fromNative (optional, default true)

File: [client\WidgetSystem\functions.sqf at line 589](../../../Src/client/WidgetSystem/functions.sqf#L589)
## isPointInScreenPosition

Type: function

Description: 
- Param: _point
- Param: _sp

File: [client\WidgetSystem\functions.sqf at line 598](../../../Src/client/WidgetSystem/functions.sqf#L598)
## canSeeScreenPoint

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 614](../../../Src/client/WidgetSystem/functions.sqf#L614)
## hasObjectInScene

Type: function

Description: 
- Param: _xPos
- Param: _yPos

File: [client\WidgetSystem\functions.sqf at line 620](../../../Src/client/WidgetSystem/functions.sqf#L620)
## setBlackScreenGUI

Type: function

Description: 
- Param: _mode
- Param: _time (optional, default 0.001)

File: [client\WidgetSystem\functions.sqf at line 631](../../../Src/client/WidgetSystem/functions.sqf#L631)
## setVisibleHUD

Type: function

Description: 
- Param: _mode

File: [client\WidgetSystem\functions.sqf at line 646](../../../Src/client/WidgetSystem/functions.sqf#L646)
## widget_antiGammaCheck

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 681](../../../Src/client/WidgetSystem/functions.sqf#L681)
## widget_createDisconnectMessage

Type: function

Description: 
- Param: _args

File: [client\WidgetSystem\functions.sqf at line 738](../../../Src/client/WidgetSystem/functions.sqf#L738)
## widget_registerInput

Type: function

Description: 
- Param: _w
- Param: _key

File: [client\WidgetSystem\functions.sqf at line 775](../../../Src/client/WidgetSystem/functions.sqf#L775)
## widgetModel_objectHelper

Type: function

Description: 
- Param: _func
- Param: _array
- Param: _scale (optional, default 1)

File: [client\WidgetSystem\functions.sqf at line 815](../../../Src/client/WidgetSystem/functions.sqf#L815)
## widgetSetMouseMoveColors

Type: function

Description: 
- Param: _w
- Param: _out
- Param: _in

File: [client\WidgetSystem\functions.sqf at line 864](../../../Src/client/WidgetSystem/functions.sqf#L864)
# widgets.hpp

## widgetNull

Type: constant

Description: 


Replaced value:
```sqf
controlnull
```
File: [client\WidgetSystem\widgets.hpp at line 10](../../../Src/client/WidgetSystem/widgets.hpp#L10)
## getGUI

Type: constant

Description: 


Replaced value:
```sqf
(uinamespace getvariable ["gui",DisplayNull])
```
File: [client\WidgetSystem\widgets.hpp at line 13](../../../Src/client/WidgetSystem/widgets.hpp#L13)
## getDisplay

Type: constant

Description: 


Replaced value:
```sqf
(findDisplay 10000)
```
File: [client\WidgetSystem\widgets.hpp at line 15](../../../Src/client/WidgetSystem/widgets.hpp#L15)
## isDisplayOpen

Type: constant

Description: 


Replaced value:
```sqf
(!(getDisplay isEqualTo displaynull))
```
File: [client\WidgetSystem\widgets.hpp at line 17](../../../Src/client/WidgetSystem/widgets.hpp#L17)
## LISTBOX

Type: constant

Description: 


Replaced value:
```sqf
"RscListBox"
```
File: [client\WidgetSystem\widgets.hpp at line 23](../../../Src/client/WidgetSystem/widgets.hpp#L23)
## TEXT

Type: constant

Description: 


Replaced value:
```sqf
"RscStructuredText"
```
File: [client\WidgetSystem\widgets.hpp at line 24](../../../Src/client/WidgetSystem/widgets.hpp#L24)
## PICTURE

Type: constant

Description: 


Replaced value:
```sqf
"RscPicture"
```
File: [client\WidgetSystem\widgets.hpp at line 25](../../../Src/client/WidgetSystem/widgets.hpp#L25)
## ACTIVEPICTURE

Type: constant

Description: 


Replaced value:
```sqf
"RscActivePicture"
```
File: [client\WidgetSystem\widgets.hpp at line 26](../../../Src/client/WidgetSystem/widgets.hpp#L26)
## BUTTON

Type: constant

Description: 


Replaced value:
```sqf
"RLCTRscButton"
```
File: [client\WidgetSystem\widgets.hpp at line 27](../../../Src/client/WidgetSystem/widgets.hpp#L27)
## BUTTONMENU

Type: constant

Description: 


Replaced value:
```sqf
"RLCTRscButtonMenu"
```
File: [client\WidgetSystem\widgets.hpp at line 28](../../../Src/client/WidgetSystem/widgets.hpp#L28)
## INPUT

Type: constant

Description: 


Replaced value:
```sqf
"RscEdit"
```
File: [client\WidgetSystem\widgets.hpp at line 29](../../../Src/client/WidgetSystem/widgets.hpp#L29)
## INPUTMULTI

Type: constant

Description: 


Replaced value:
```sqf
"RscEditMulti"
```
File: [client\WidgetSystem\widgets.hpp at line 30](../../../Src/client/WidgetSystem/widgets.hpp#L30)
## INPUTMULTIV2

Type: constant

Description: 


Replaced value:
```sqf
"!RscEditMulti!inphndl"
```
File: [client\WidgetSystem\widgets.hpp at line 31](../../../Src/client/WidgetSystem/widgets.hpp#L31)
## INPUTCHAT

Type: constant

Description: 


Replaced value:
```sqf
"RscEditChat"
```
File: [client\WidgetSystem\widgets.hpp at line 32](../../../Src/client/WidgetSystem/widgets.hpp#L32)
## WIDGETGROUP

Type: constant

Description: 


Replaced value:
```sqf
"RscControlsGroupNoScrollbars_NEW"
```
File: [client\WidgetSystem\widgets.hpp at line 33](../../../Src/client/WidgetSystem/widgets.hpp#L33)
## WIDGETGROUPSCROLLS

Type: constant

Description: 


Replaced value:
```sqf
"RscControlsGroup"
```
File: [client\WidgetSystem\widgets.hpp at line 34](../../../Src/client/WidgetSystem/widgets.hpp#L34)
## WIDGETGROUP_H

Type: constant

Description: 


Replaced value:
```sqf
"RscControlsGroupNoHScrollbars"
```
File: [client\WidgetSystem\widgets.hpp at line 35](../../../Src/client/WidgetSystem/widgets.hpp#L35)
## BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
("!" + TEXT + "!background")
```
File: [client\WidgetSystem\widgets.hpp at line 36](../../../Src/client/WidgetSystem/widgets.hpp#L36)
## SLIDERW

Type: constant

Description: 


Replaced value:
```sqf
"RscSlider"
```
File: [client\WidgetSystem\widgets.hpp at line 37](../../../Src/client/WidgetSystem/widgets.hpp#L37)
## SLIDERWNEW

Type: constant

Description: 


Replaced value:
```sqf
"RscSliderNew"
```
File: [client\WidgetSystem\widgets.hpp at line 38](../../../Src/client/WidgetSystem/widgets.hpp#L38)
## SLIDERH

Type: constant

Description: 


Replaced value:
```sqf
"RscSliderH"
```
File: [client\WidgetSystem\widgets.hpp at line 39](../../../Src/client/WidgetSystem/widgets.hpp#L39)
## CHECKBOX

Type: constant

Description: 


Replaced value:
```sqf
"RscCheckBox"
```
File: [client\WidgetSystem\widgets.hpp at line 40](../../../Src/client/WidgetSystem/widgets.hpp#L40)
## setBackgroundColor

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetBackgroundColor
```
File: [client\WidgetSystem\widgets.hpp at line 45](../../../Src/client/WidgetSystem/widgets.hpp#L45)
## setStructuredText

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetStructuredText
```
File: [client\WidgetSystem\widgets.hpp at line 47](../../../Src/client/WidgetSystem/widgets.hpp#L47)
## setFade

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetFade
```
File: [client\WidgetSystem\widgets.hpp at line 49](../../../Src/client/WidgetSystem/widgets.hpp#L49)
## getFade

Type: constant

Description: 


Replaced value:
```sqf
ctrlFade
```
File: [client\WidgetSystem\widgets.hpp at line 51](../../../Src/client/WidgetSystem/widgets.hpp#L51)
## commit

Type: constant

Description: 


Replaced value:
```sqf
ctrlCommit
```
File: [client\WidgetSystem\widgets.hpp at line 53](../../../Src/client/WidgetSystem/widgets.hpp#L53)
## isCommited

Type: constant

Description: 


Replaced value:
```sqf
ctrlCommitted
```
File: [client\WidgetSystem\widgets.hpp at line 55](../../../Src/client/WidgetSystem/widgets.hpp#L55)
## setFocus

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetFocus
```
File: [client\WidgetSystem\widgets.hpp at line 57](../../../Src/client/WidgetSystem/widgets.hpp#L57)
## transformSizeByAR(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
((val) / (getresolution select 4))
```
File: [client\WidgetSystem\widgets.hpp at line 60](../../../Src/client/WidgetSystem/widgets.hpp#L60)
## getWidthByHeightToSquare(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
transformSizeByAR(val)
```
File: [client\WidgetSystem\widgets.hpp at line 62](../../../Src/client/WidgetSystem/widgets.hpp#L62)
## widgetGetPicture(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
ctrlText (val)
```
File: [client\WidgetSystem\widgets.hpp at line 65](../../../Src/client/WidgetSystem/widgets.hpp#L65)
## widgetGetText(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
ctrlText (val)
```
File: [client\WidgetSystem\widgets.hpp at line 67](../../../Src/client/WidgetSystem/widgets.hpp#L67)
## __widgetFadeReset(wid,time,fademode)

Type: constant

Description: 
- Param: wid
- Param: time
- Param: fademode

Replaced value:
```sqf
wid setFade fademode; \
wid commit 0; \
wid setFade 0; \
wid commit time \

```
File: [client\WidgetSystem\widgets.hpp at line 70](../../../Src/client/WidgetSystem/widgets.hpp#L70)
## widgetFadeout(wid,time)

Type: constant

Description: 
- Param: wid
- Param: time

Replaced value:
```sqf
__widgetFadeReset(wid,time,1)
```
File: [client\WidgetSystem\widgets.hpp at line 76](../../../Src/client/WidgetSystem/widgets.hpp#L76)
## widgetFadein(wid,time)

Type: constant

Description: 
- Param: wid
- Param: time

Replaced value:
```sqf
wid setFade 1; wid commit time
```
File: [client\WidgetSystem\widgets.hpp at line 78](../../../Src/client/WidgetSystem/widgets.hpp#L78)
## widgetFadeNow(wid,value)

Type: constant

Description: 
- Param: wid
- Param: value

Replaced value:
```sqf
wid setFade value; wid commit 0
```
File: [client\WidgetSystem\widgets.hpp at line 80](../../../Src/client/WidgetSystem/widgets.hpp#L80)
## widgetSetFade(wid,val,com)

Type: constant

Description: 
- Param: wid
- Param: val
- Param: com

Replaced value:
```sqf
wid setFade val; wid commit com
```
File: [client\WidgetSystem\widgets.hpp at line 82](../../../Src/client/WidgetSystem/widgets.hpp#L82)
## WIDGET_FULLSIZE

Type: constant

Description: 


Replaced value:
```sqf
[0,0,100,100]
```
File: [client\WidgetSystem\widgets.hpp at line 86](../../../Src/client/WidgetSystem/widgets.hpp#L86)
# widget_init.sqf

## precent_to_real(proc_val)

Type: constant

> Exists if **DEBUG** defined

Description: 
- Param: proc_val

Replaced value:
```sqf
(proc_val / 100)
```
File: [client\WidgetSystem\widget_init.sqf at line 114](../../../Src/client/WidgetSystem/widget_init.sqf#L114)
## removealldisplayevents

Type: function

Description: 


File: [client\WidgetSystem\widget_init.sqf at line 22](../../../Src/client/WidgetSystem/widget_init.sqf#L22)
# _iconviewer.sqf

## fn_iconViewer

Type: function

Description: 
- Param: _mode (optional, default "", expected types: ['""'])
- Param: _args (optional, default [], expected types: [[]])

File: [client\WidgetSystem\_iconviewer.sqf at line 6](../../../Src/client/WidgetSystem/_iconviewer.sqf#L6)
