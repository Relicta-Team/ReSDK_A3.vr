# blockedButtons.hpp

## ACT(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
actionKeys #name
```
File: [client\WidgetSystem\blockedButtons.hpp at line 6](../../../Src/client/WidgetSystem/blockedButtons.hpp#L6)
## GROUP_ACTIONS

Type: constant

Description: Пользовательские меню?!


Replaced value:
```sqf
ACT(CommandingMenu1) + ACT(CommandingMenu2) + ACT(CommandingMenu3) + ACT(CommandingMenu4) + ACT(CommandingMenu5) \
 + ACT(CommandingMenu6) + ACT(CommandingMenu7) + ACT(CommandingMenu8) + ACT(CommandingMenu9) + ACT(CommandingMenu0) + \
 ACT(CommandingMenuSelect1) + ACT(CommandingMenuSelect2) + ACT(CommandingMenuSelect3) + ACT(CommandingMenuSelect4) + \
 ACT(CommandingMenuSelect5) + ACT(CommandingMenuSelect6) + ACT(CommandingMenuSelect7) + ACT(CommandingMenuSelect8) + \
 ACT(CommandingMenuSelect9) + ACT(CommandingMenuSelect0) + \
 ACT(prevAction) + ACT(nextAction) + ACT(Action) + ACT(ActionContext) + ACT(defaultAction)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 9](../../../Src/client/WidgetSystem/blockedButtons.hpp#L9)
## GROUP_COMMA_MENU

Type: constant

Description: команды на F1-F12


Replaced value:
```sqf
ACT(SelectGroupUnit1) + ACT(SelectGroupUnit2) + ACT(SelectGroupUnit3) + \
ACT(SelectGroupUnit4) + ACT(SelectGroupUnit5) + ACT(SelectGroupUnit6) + ACT(SelectGroupUnit7) + \
ACT(SelectGroupUnit8) + ACT(SelectGroupUnit9) + ACT(SelectGroupUnit0) + ACT(selectAll)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 17](../../../Src/client/WidgetSystem/blockedButtons.hpp#L17)
## SIMPLE_PLAYER_INTERACTION

Type: constant

Description: инвентарь и другое пользовательское взаимодействие


Replaced value:
```sqf
ACT(showMap) + ACT(gear) + ACT(navigateMenu) + ACT(EvasiveLeft) + ACT(EvasiveRight) + \
 ACT(Salute) + ACT(SitDown) + ACT(networkStats) + ACT(networkPlayers)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 22](../../../Src/client/WidgetSystem/blockedButtons.hpp#L22)
## ESCAPE_BUTTONS

Type: constant

Description: эскейп


Replaced value:
```sqf
ACT(ingamePause)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 28](../../../Src/client/WidgetSystem/blockedButtons.hpp#L28)
## FORBIDDEN_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(GROUP_ACTIONS + GROUP_COMMA_MENU + SIMPLE_PLAYER_INTERACTION)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 30](../../../Src/client/WidgetSystem/blockedButtons.hpp#L30)
## FORBIDDEN_BUTTONS_SCROLL

Type: constant

Description: 


Replaced value:
```sqf
ACT(prevAction) + ACT(nextAction) + ACT(Action) + ACT(ActionContext) + ACT(defaultAction)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 31](../../../Src/client/WidgetSystem/blockedButtons.hpp#L31)
## ADDRULE_FORBIDDEN_BUTTONS(forkey)

Type: constant

Description: temporary fix for VM
- Param: forkey

Replaced value:
```sqf
(forkey in FORBIDDEN_BUTTONS)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 33](../../../Src/client/WidgetSystem/blockedButtons.hpp#L33)
## ADDRULE_FORBIDDEN_SCROLL(forkey)

Type: constant

Description: 
- Param: forkey

Replaced value:
```sqf
(forkey in FORBIDDEN_BUTTONS_SCROLL)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 34](../../../Src/client/WidgetSystem/blockedButtons.hpp#L34)
## CAN_MOVE_BUTTONS

Type: constant

Description: movement actions


Replaced value:
```sqf
(ACT(MoveForward) + ACT(MoveBack) + ACT(TurnLeft) + ACT(TurnRight) + \
 ACT(MoveFastForward) + ACT(MoveSlowForward) + ACT(turbo) + ACT(TurboToggle) + ACT(MoveLeft) + ACT(MoveRight) + ACT(GetOver))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 39](../../../Src/client/WidgetSystem/blockedButtons.hpp#L39)
## CHANGE_STANCE_BUTTONS

Type: constant

Description: 


Replaced value:
```sqf
(ACT(AdjustUp) + ACT(AdjustDown) + ACT(Crouch) + ACT(Stand) + ACT(MoveUp) + ACT(MoveDown))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 42](../../../Src/client/WidgetSystem/blockedButtons.hpp#L42)
## FAST_DROP_BUTTONS

Type: constant

Description: прыжок на землю в беге


Replaced value:
```sqf
(ACT(Crouch) + ACT(MoveDown))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 44](../../../Src/client/WidgetSystem/blockedButtons.hpp#L44)
## SIDEWAYS_MOVEMENT_BUTTONS

Type: constant

Description: защита от стрейфа тупых школьников


Replaced value:
```sqf
(ACT(TurnLeft) + ACT(TurnRight))
```
File: [client\WidgetSystem\blockedButtons.hpp at line 46](../../../Src/client/WidgetSystem/blockedButtons.hpp#L46)
## ADDRULE_FORBIDDEN_BUTTONS(forkey)

Type: constant

> Exists if **_SQFVM** defined

Description: temporary fix for VM
- Param: forkey

Replaced value:
```sqf
(forkey in GROUP_ACTIONS || forkey in GROUP_COMMA_MENU || forkey in SIMPLE_PLAYER_INTERACTION)
```
File: [client\WidgetSystem\blockedButtons.hpp at line 51](../../../Src/client/WidgetSystem/blockedButtons.hpp#L51)
# defines.sqf

## HEIGHT_WINDOW_DRAGGER

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\WidgetSystem\defines.sqf at line 30](../../../Src/client/WidgetSystem/defines.sqf#L30)
## createWidget_closeButton

Type: function

Description: 
- Param: _display
- Param: _text (optional, default "Закрыть")
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 12](../../../Src/client/WidgetSystem/defines.sqf#L12)
## createWidget_window

Type: function

Description: 
- Param: _display
- Param: _type
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 32](../../../Src/client/WidgetSystem/defines.sqf#L32)
## createWidget_square

Type: function

Description: указывать ширину не нужно...
- Param: _display
- Param: _type
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 50](../../../Src/client/WidgetSystem/defines.sqf#L50)
## createCtWidget

Type: function

Description: theme creator
- Param: _name
- Param: _params

File: [client\WidgetSystem\defines.sqf at line 66](../../../Src/client/WidgetSystem/defines.sqf#L66)
## createWidget_backImpl

Type: function

Description: ========================== api ==========================
- Param: _d
- Param: _pos
- Param: _ctg

File: [client\WidgetSystem\defines.sqf at line 73](../../../Src/client/WidgetSystem/defines.sqf#L73)
## createWidget_back

Type: function

Description: 
- Param: _d
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 78](../../../Src/client/WidgetSystem/defines.sqf#L78)
## createWidget_back2

Type: function

Description: 
- Param: _d
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\defines.sqf at line 85](../../../Src/client/WidgetSystem/defines.sqf#L85)
## createWidget_title

Type: function

Description: 
- Param: _d
- Param: _pos
- Param: _parent
- Param: _text (optional, default "")

File: [client\WidgetSystem\defines.sqf at line 92](../../../Src/client/WidgetSystem/defines.sqf#L92)
## createWidget_button

Type: function

Description: 
- Param: _d
- Param: _pos
- Param: _ctg
- Param: _txt

File: [client\WidgetSystem\defines.sqf at line 100](../../../Src/client/WidgetSystem/defines.sqf#L100)
# functions.sqf

## HOME_PROTECT

Type: constant

Description: 


Replaced value:
```sqf
if (_key == KEY_HOME) then {call displayClose};
```
File: [client\WidgetSystem\functions.sqf at line 18](../../../Src/client/WidgetSystem/functions.sqf#L18)
## INDEX_TYPE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\WidgetSystem\functions.sqf at line 83](../../../Src/client/WidgetSystem/functions.sqf#L83)
## INDEX_CUSTOM

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\WidgetSystem\functions.sqf at line 84](../../../Src/client/WidgetSystem/functions.sqf#L84)
## precent_to_real(proc_val)

Type: constant

Description: 
- Param: proc_val

Replaced value:
```sqf
(proc_val / 100)
```
File: [client\WidgetSystem\functions.sqf at line 485](../../../Src/client/WidgetSystem/functions.sqf#L485)
## STARTX

Type: constant

Description: Находится на экране


Replaced value:
```sqf
(0 * safezoneW + safezoneX)
```
File: [client\WidgetSystem\functions.sqf at line 510](../../../Src/client/WidgetSystem/functions.sqf#L510)
## STARTY

Type: constant

Description: 


Replaced value:
```sqf
(0 * safezoneH + safezoneY)
```
File: [client\WidgetSystem\functions.sqf at line 511](../../../Src/client/WidgetSystem/functions.sqf#L511)
## DIAPAZONX

Type: constant

Description: 


Replaced value:
```sqf
((1 * safezoneW + safezoneX) - STARTX)
```
File: [client\WidgetSystem\functions.sqf at line 512](../../../Src/client/WidgetSystem/functions.sqf#L512)
## DIAPAZONY

Type: constant

Description: 


Replaced value:
```sqf
((1 * safezoneH + safezoneY) - STARTY)
```
File: [client\WidgetSystem\functions.sqf at line 513](../../../Src/client/WidgetSystem/functions.sqf#L513)
## checkRange(numberToCheck,bottom,top)

Type: constant

Description: 
- Param: numberToCheck
- Param: bottom
- Param: top

Replaced value:
```sqf
(numberToCheck >= bottom && numberToCheck <= top)
```
File: [client\WidgetSystem\functions.sqf at line 623](../../../Src/client/WidgetSystem/functions.sqf#L623)
## low_protect

Type: constant

Description: 


Replaced value:
```sqf
0.9
```
File: [client\WidgetSystem\functions.sqf at line 624](../../../Src/client/WidgetSystem/functions.sqf#L624)
## max_protect

Type: constant

Description: 


Replaced value:
```sqf
1.1
```
File: [client\WidgetSystem\functions.sqf at line 625](../../../Src/client/WidgetSystem/functions.sqf#L625)
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
File: [client\WidgetSystem\functions.sqf at line 657](../../../Src/client/WidgetSystem/functions.sqf#L657)
## hasEnabledBlackScreen

Type: Variable

Description: other screen support


Initial value:
```sqf
false
```
File: [client\WidgetSystem\functions.sqf at line 569](../../../Src/client/WidgetSystem/functions.sqf#L569)
## displayOpen

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 20](../../../Src/client/WidgetSystem/functions.sqf#L20)
## dynamicDisplayOpen

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 48](../../../Src/client/WidgetSystem/functions.sqf#L48)
## displayClose

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 74](../../../Src/client/WidgetSystem/functions.sqf#L74)
## createWidget

Type: function

Description: 
- Param: _display
- Param: _type
- Param: _pos
- Param: _parent

File: [client\WidgetSystem\functions.sqf at line 78](../../../Src/client/WidgetSystem/functions.sqf#L78)
## deleteWidget

Type: function

Description: 
- Param: _widget
- Param: _nextFrame (optional, default false)

File: [client\WidgetSystem\functions.sqf at line 144](../../../Src/client/WidgetSystem/functions.sqf#L144)
## widgetSetPosition

Type: function

Description: Устанавливает новую позицию виджету
- Param: _widget
- Param: _posarray
- Param: _time (optional, default -1)

File: [client\WidgetSystem\functions.sqf at line 162](../../../Src/client/WidgetSystem/functions.sqf#L162)
## widgetPosPrecentToSafezone

Type: function

Description: 
- Param: _widget
- Param: _prec
- Param: _index

File: [client\WidgetSystem\functions.sqf at line 203](../../../Src/client/WidgetSystem/functions.sqf#L203)
## widgetSetPositionOnly

Type: function

Description: 
- Param: _widget
- Param: _posarray
- Param: _time (optional, default -1)

File: [client\WidgetSystem\functions.sqf at line 238](../../../Src/client/WidgetSystem/functions.sqf#L238)
## widgetGetPosition

Type: function

Description: Получает позицию виджета
- Param: _xp
- Param: _yp
- Param: _wp
- Param: _hp

File: [client\WidgetSystem\functions.sqf at line 278](../../../Src/client/WidgetSystem/functions.sqf#L278)
## isMouseInsideWidget

Type: function

Description: Проверяет находится ли мышь внутри контрола
- Param: _wid

File: [client\WidgetSystem\functions.sqf at line 310](../../../Src/client/WidgetSystem/functions.sqf#L310)
## isMouseInsidePosition

Type: function

Description: 
- Param: _xe
- Param: _ye
- Param: _xe2
- Param: _ye2

File: [client\WidgetSystem\functions.sqf at line 372](../../../Src/client/WidgetSystem/functions.sqf#L372)
## getMousePositionInWidget

Type: function

Description: Получает позицию мыши внутри виджета


File: [client\WidgetSystem\functions.sqf at line 388](../../../Src/client/WidgetSystem/functions.sqf#L388)
## widgetSetText

Type: function

Description: 
- Param: _obj
- Param: _text

File: [client\WidgetSystem\functions.sqf at line 436](../../../Src/client/WidgetSystem/functions.sqf#L436)
## widgetSetPicture

Type: function

Description: 
- Param: _obj
- Param: _text

File: [client\WidgetSystem\functions.sqf at line 448](../../../Src/client/WidgetSystem/functions.sqf#L448)
## widgetGetTextHeight

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 454](../../../Src/client/WidgetSystem/functions.sqf#L454)
## widgetWGScrolldown

Type: function

Description: скроллинг контрол группы WIDGETGROUP_H
- Param: _wid

File: [client\WidgetSystem\functions.sqf at line 473](../../../Src/client/WidgetSystem/functions.sqf#L473)
## mouseSetPosition

Type: function

Description: =================== MOUSE HELPERS =====================
- Param: _xpos
- Param: _ypos

File: [client\WidgetSystem\functions.sqf at line 483](../../../Src/client/WidgetSystem/functions.sqf#L483)
## mouseGetPosition

Type: function

Description: 
- Param: _mX
- Param: _mY

File: [client\WidgetSystem\functions.sqf at line 489](../../../Src/client/WidgetSystem/functions.sqf#L489)
## convertScreenCoords

Type: function

Description: 


File: [client\WidgetSystem\functions.sqf at line 505](../../../Src/client/WidgetSystem/functions.sqf#L505)
## positionWorldToScreen

Type: function

Description: Конвертация мировой позиции в экранные координаты. Всегда возвращает vec2


File: [client\WidgetSystem\functions.sqf at line 522](../../../Src/client/WidgetSystem/functions.sqf#L522)
## getScreenPointToWorld

Type: function

Description: screenToWorld scripted alternative (ray to distance, not surface)
- Param: _screenPos (optional, default getMousePosition)
- Param: _mulDist (optional, default 1000)

File: [client\WidgetSystem\functions.sqf at line 527](../../../Src/client/WidgetSystem/functions.sqf#L527)
## isPointInScreenPosition

Type: function

Description: Проверяет находится ли позиция внутри другой позиции. Отсчёт позиции с верхнего левого угла всегда
- Param: _point
- Param: _sp

File: [client\WidgetSystem\functions.sqf at line 543](../../../Src/client/WidgetSystem/functions.sqf#L543)
## canSeeScreenPoint

Type: function

Description: Можно ли видеть точку на экране


File: [client\WidgetSystem\functions.sqf at line 558](../../../Src/client/WidgetSystem/functions.sqf#L558)
## hasObjectInScene

Type: function

Description: видно ли объект в сцене. Лучше всего работает с малыми объектами
- Param: _xPos
- Param: _yPos

File: [client\WidgetSystem\functions.sqf at line 563](../../../Src/client/WidgetSystem/functions.sqf#L563)
## setBlackScreenGUI

Type: function

Description: 
- Param: _mode
- Param: _time (optional, default 0.001)

File: [client\WidgetSystem\functions.sqf at line 571](../../../Src/client/WidgetSystem/functions.sqf#L571)
## setVisibleHUD

Type: function

Description: 
- Param: _mode

File: [client\WidgetSystem\functions.sqf at line 586](../../../Src/client/WidgetSystem/functions.sqf#L586)
## widget_antiGammaCheck

Type: function

Description: false is not allowed values


File: [client\WidgetSystem\functions.sqf at line 613](../../../Src/client/WidgetSystem/functions.sqf#L613)
## widget_createDisconnectMessage

Type: function

Description: 
- Param: _args

File: [client\WidgetSystem\functions.sqf at line 635](../../../Src/client/WidgetSystem/functions.sqf#L635)
## widget_registerInput

Type: function

Description: специальная функция регистрации переноса каретки по нажатию enter
- Param: _w
- Param: _key

File: [client\WidgetSystem\functions.sqf at line 671](../../../Src/client/WidgetSystem/functions.sqf#L671)
## widgetModel_objectHelper

Type: function

Description: 
- Param: _func
- Param: _array
- Param: _scale (optional, default 1)

File: [client\WidgetSystem\functions.sqf at line 709](../../../Src/client/WidgetSystem/functions.sqf#L709)
# widgets.hpp

## widgetNull

Type: constant

Description: 


Replaced value:
```sqf
controlnull
```
File: [client\WidgetSystem\widgets.hpp at line 7](../../../Src/client/WidgetSystem/widgets.hpp#L7)
## getGUI

Type: constant

Description: 


Replaced value:
```sqf
(uinamespace getvariable ["gui",DisplayNull])
```
File: [client\WidgetSystem\widgets.hpp at line 9](../../../Src/client/WidgetSystem/widgets.hpp#L9)
## getDisplay

Type: constant

Description: 


Replaced value:
```sqf
(findDisplay 10000)
```
File: [client\WidgetSystem\widgets.hpp at line 10](../../../Src/client/WidgetSystem/widgets.hpp#L10)
## isDisplayOpen

Type: constant

Description: 


Replaced value:
```sqf
(!(getDisplay isEqualTo displaynull))
```
File: [client\WidgetSystem\widgets.hpp at line 11](../../../Src/client/WidgetSystem/widgets.hpp#L11)
## LISTBOX

Type: constant

Description: widgets types


Replaced value:
```sqf
"RscListBox"
```
File: [client\WidgetSystem\widgets.hpp at line 16](../../../Src/client/WidgetSystem/widgets.hpp#L16)
## TEXT

Type: constant

Description: 


Replaced value:
```sqf
"RscStructuredText"
```
File: [client\WidgetSystem\widgets.hpp at line 17](../../../Src/client/WidgetSystem/widgets.hpp#L17)
## PICTURE

Type: constant

Description: 


Replaced value:
```sqf
"RscPicture"
```
File: [client\WidgetSystem\widgets.hpp at line 18](../../../Src/client/WidgetSystem/widgets.hpp#L18)
## ACTIVEPICTURE

Type: constant

Description: 


Replaced value:
```sqf
"RscActivePicture"
```
File: [client\WidgetSystem\widgets.hpp at line 19](../../../Src/client/WidgetSystem/widgets.hpp#L19)
## BUTTON

Type: constant

Description: 


Replaced value:
```sqf
"RLCTRscButton"
```
File: [client\WidgetSystem\widgets.hpp at line 20](../../../Src/client/WidgetSystem/widgets.hpp#L20)
## BUTTONMENU

Type: constant

Description: 


Replaced value:
```sqf
"RLCTRscButtonMenu"
```
File: [client\WidgetSystem\widgets.hpp at line 21](../../../Src/client/WidgetSystem/widgets.hpp#L21)
## INPUT

Type: constant

Description: 


Replaced value:
```sqf
"RscEdit"
```
File: [client\WidgetSystem\widgets.hpp at line 22](../../../Src/client/WidgetSystem/widgets.hpp#L22)
## INPUTMULTI

Type: constant

Description: 


Replaced value:
```sqf
"RscEditMulti"
```
File: [client\WidgetSystem\widgets.hpp at line 23](../../../Src/client/WidgetSystem/widgets.hpp#L23)
## INPUTMULTIV2

Type: constant

Description: 


Replaced value:
```sqf
"!RscEditMulti!inphndl"
```
File: [client\WidgetSystem\widgets.hpp at line 24](../../../Src/client/WidgetSystem/widgets.hpp#L24)
## INPUTCHAT

Type: constant

Description: 


Replaced value:
```sqf
"RscEditChat"
```
File: [client\WidgetSystem\widgets.hpp at line 25](../../../Src/client/WidgetSystem/widgets.hpp#L25)
## WIDGETGROUP

Type: constant

Description: 


Replaced value:
```sqf
"RscControlsGroupNoScrollbars_NEW"
```
File: [client\WidgetSystem\widgets.hpp at line 26](../../../Src/client/WidgetSystem/widgets.hpp#L26)
## WIDGETGROUPSCROLLS

Type: constant

Description: 


Replaced value:
```sqf
"RscControlsGroup"
```
File: [client\WidgetSystem\widgets.hpp at line 27](../../../Src/client/WidgetSystem/widgets.hpp#L27)
## WIDGETGROUP_H

Type: constant

Description: 


Replaced value:
```sqf
"RscControlsGroupNoHScrollbars"
```
File: [client\WidgetSystem\widgets.hpp at line 28](../../../Src/client/WidgetSystem/widgets.hpp#L28)
## BACKGROUND

Type: constant

Description: 


Replaced value:
```sqf
("!" + TEXT + "!background")
```
File: [client\WidgetSystem\widgets.hpp at line 29](../../../Src/client/WidgetSystem/widgets.hpp#L29)
## SLIDERW

Type: constant

Description: 


Replaced value:
```sqf
"RscSlider"
```
File: [client\WidgetSystem\widgets.hpp at line 30](../../../Src/client/WidgetSystem/widgets.hpp#L30)
## SLIDERWNEW

Type: constant

Description: 


Replaced value:
```sqf
"RscSliderNew"
```
File: [client\WidgetSystem\widgets.hpp at line 31](../../../Src/client/WidgetSystem/widgets.hpp#L31)
## SLIDERH

Type: constant

Description: 


Replaced value:
```sqf
"RscSliderH"
```
File: [client\WidgetSystem\widgets.hpp at line 32](../../../Src/client/WidgetSystem/widgets.hpp#L32)
## CHECKBOX

Type: constant

Description: 


Replaced value:
```sqf
"RscCheckBox"
```
File: [client\WidgetSystem\widgets.hpp at line 33](../../../Src/client/WidgetSystem/widgets.hpp#L33)
## setBackgroundColor

Type: constant

Description: macro helpers


Replaced value:
```sqf
ctrlSetBackgroundColor
```
File: [client\WidgetSystem\widgets.hpp at line 38](../../../Src/client/WidgetSystem/widgets.hpp#L38)
## setStructuredText

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetStructuredText
```
File: [client\WidgetSystem\widgets.hpp at line 39](../../../Src/client/WidgetSystem/widgets.hpp#L39)
## setFade

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetFade
```
File: [client\WidgetSystem\widgets.hpp at line 40](../../../Src/client/WidgetSystem/widgets.hpp#L40)
## getFade

Type: constant

Description: 


Replaced value:
```sqf
ctrlFade
```
File: [client\WidgetSystem\widgets.hpp at line 41](../../../Src/client/WidgetSystem/widgets.hpp#L41)
## commit

Type: constant

Description: 


Replaced value:
```sqf
ctrlCommit
```
File: [client\WidgetSystem\widgets.hpp at line 42](../../../Src/client/WidgetSystem/widgets.hpp#L42)
## isCommited

Type: constant

Description: 


Replaced value:
```sqf
ctrlCommitted
```
File: [client\WidgetSystem\widgets.hpp at line 43](../../../Src/client/WidgetSystem/widgets.hpp#L43)
## setFocus

Type: constant

Description: 


Replaced value:
```sqf
ctrlSetFocus
```
File: [client\WidgetSystem\widgets.hpp at line 44](../../../Src/client/WidgetSystem/widgets.hpp#L44)
## transformSizeByAR(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
((val) / (getresolution select 4))
```
File: [client\WidgetSystem\widgets.hpp at line 46](../../../Src/client/WidgetSystem/widgets.hpp#L46)
## getWidthByHeightToSquare(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
transformSizeByAR(val)
```
File: [client\WidgetSystem\widgets.hpp at line 47](../../../Src/client/WidgetSystem/widgets.hpp#L47)
## widgetGetPicture(val)

Type: constant

Description: case sentivity
- Param: val

Replaced value:
```sqf
ctrlText (val)
```
File: [client\WidgetSystem\widgets.hpp at line 49](../../../Src/client/WidgetSystem/widgets.hpp#L49)
## widgetGetText(val)

Type: constant

Description: 
- Param: val

Replaced value:
```sqf
ctrlText (val)
```
File: [client\WidgetSystem\widgets.hpp at line 50](../../../Src/client/WidgetSystem/widgets.hpp#L50)
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
File: [client\WidgetSystem\widgets.hpp at line 52](../../../Src/client/WidgetSystem/widgets.hpp#L52)
## widgetFadeout(wid,time)

Type: constant

Description: 
- Param: wid
- Param: time

Replaced value:
```sqf
__widgetFadeReset(wid,time,1)
```
File: [client\WidgetSystem\widgets.hpp at line 57](../../../Src/client/WidgetSystem/widgets.hpp#L57)
## widgetFadein(wid,time)

Type: constant

Description: 
- Param: wid
- Param: time

Replaced value:
```sqf
wid setFade 1; wid commit time
```
File: [client\WidgetSystem\widgets.hpp at line 58](../../../Src/client/WidgetSystem/widgets.hpp#L58)
## widgetFadeNow(wid,value)

Type: constant

Description: 
- Param: wid
- Param: value

Replaced value:
```sqf
wid setFade value; wid commit 0
```
File: [client\WidgetSystem\widgets.hpp at line 59](../../../Src/client/WidgetSystem/widgets.hpp#L59)
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
File: [client\WidgetSystem\widgets.hpp at line 60](../../../Src/client/WidgetSystem/widgets.hpp#L60)
## WIDGET_FULLSIZE

Type: constant

Description: other


Replaced value:
```sqf
[0,0,100,100]
```
File: [client\WidgetSystem\widgets.hpp at line 63](../../../Src/client/WidgetSystem/widgets.hpp#L63)
# widget_eventSystem.sqf

## display_internal_onCloseEventList

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\WidgetSystem\widget_eventSystem.sqf at line 8](../../../Src/client/WidgetSystem/widget_eventSystem.sqf#L8)
## displayAddCloseEvent

Type: function

Description: 
- Param: _code

File: [client\WidgetSystem\widget_eventSystem.sqf at line 10](../../../Src/client/WidgetSystem/widget_eventSystem.sqf#L10)
## displayCallCloseEvent

Type: function

Description: 


File: [client\WidgetSystem\widget_eventSystem.sqf at line 15](../../../Src/client/WidgetSystem/widget_eventSystem.sqf#L15)
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
File: [client\WidgetSystem\widget_init.sqf at line 109](../../../Src/client/WidgetSystem/widget_init.sqf#L109)
## removealldisplayevents

Type: function

Description: 


File: [client\WidgetSystem\widget_init.sqf at line 20](../../../Src/client/WidgetSystem/widget_init.sqf#L20)
