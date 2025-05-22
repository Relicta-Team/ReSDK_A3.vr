# aim_cursor.sqf

## AIM_SIZE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\aim_cursor.sqf at line 11](../../../Src/client/Interactions/aim_cursor.sqf#L11)
## interact_aim_disableGlobal

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\aim_cursor.sqf at line 14](../../../Src/client/Interactions/aim_cursor.sqf#L14)
## interaction_aim_handle

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Interactions\aim_cursor.sqf at line 17](../../../Src/client/Interactions/aim_cursor.sqf#L17)
## interaction_aim_alphaUpdHandle

Type: Variable

Description: TODO dynamic change opacity


Initial value:
```sqf
-1
```
File: [client\Interactions\aim_cursor.sqf at line 19](../../../Src/client/Interactions/aim_cursor.sqf#L19)
## interaction_aim_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\Interactions\aim_cursor.sqf at line 22](../../../Src/client/Interactions/aim_cursor.sqf#L22)
## interaction_aim_init

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 29](../../../Src/client/Interactions/aim_cursor.sqf#L29)
## interaction_aim_getStdPos

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 45](../../../Src/client/Interactions/aim_cursor.sqf#L45)
## interaction_aim_alphaUpdate

Type: function

Description: 
- Param: _r
- Param: _g
- Param: _b

File: [client\Interactions\aim_cursor.sqf at line 51](../../../Src/client/Interactions/aim_cursor.sqf#L51)
## interaction_aim_applyColorTheme

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 78](../../../Src/client/Interactions/aim_cursor.sqf#L78)
## interaction_aim_onUpdate

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 83](../../../Src/client/Interactions/aim_cursor.sqf#L83)
# interact.hpp

## INTERACT_ITEM_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.35
```
File: [client\Interactions\interact.hpp at line 11](../../../Src/client/Interactions/interact.hpp#L11)
## INTERACT_ITEM_LEG_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.7
```
File: [client\Interactions\interact.hpp at line 13](../../../Src/client/Interactions/interact.hpp#L13)
## INTERACT_MOB_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.2
```
File: [client\Interactions\interact.hpp at line 15](../../../Src/client/Interactions/interact.hpp#L15)
## INTERACT_MOB_COLLECT_DIST

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\interact.hpp at line 17](../../../Src/client/Interactions/interact.hpp#L17)
## WORLD_CONTAINER_ALLOWDISTANCE

Type: constant

Description: 


Replaced value:
```sqf
INTERACT_ITEM_DISTANCE
```
File: [client\Interactions\interact.hpp at line 19](../../../Src/client/Interactions/interact.hpp#L19)
## INTERACT_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.35
```
File: [client\Interactions\interact.hpp at line 22](../../../Src/client/Interactions/interact.hpp#L22)
## getHeadMobPos(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
(mob modelToWorld (mob selectionPosition "head"))
```
File: [client\Interactions\interact.hpp at line 25](../../../Src/client/Interactions/interact.hpp#L25)
## getCenterMobPos(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
(mob modelToWorld (mob selectionPosition("spine3")))
```
File: [client\Interactions\interact.hpp at line 27](../../../Src/client/Interactions/interact.hpp#L27)
## isInteractible(targ)

Type: constant

Description: 
- Param: targ

Replaced value:
```sqf
((targ getVariable ["isInteractible",true] && inventory_isPressedInteractButton) || (typeof targ == BASIC_MOB_TYPE))
```
File: [client\Interactions\interact.hpp at line 30](../../../Src/client/Interactions/interact.hpp#L30)
## VERB_LASTCHECKEDOBJECTDATA_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
[objNull,[0,0,0],false]
```
File: [client\Interactions\interact.hpp at line 33](../../../Src/client/Interactions/interact.hpp#L33)
## INTERACT_LODS_CHECK_STANDART

Type: constant

Description: 


Replaced value:
```sqf
"VIEW","FIRE"/*interact_lods_check_standart*/
```
File: [client\Interactions\interact.hpp at line 36](../../../Src/client/Interactions/interact.hpp#L36)
## INTERACT_LODS_CHECK_GEOM

Type: constant

Description: 


Replaced value:
```sqf
"GEOM","VIEW"/*interact_lods_check_geom*/
```
File: [client\Interactions\interact.hpp at line 39](../../../Src/client/Interactions/interact.hpp#L39)
## INTERACT_RPC_CLICK

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact.hpp at line 43](../../../Src/client/Interactions/interact.hpp#L43)
## INTERACT_RPC_ALTCLICK

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interact.hpp at line 44](../../../Src/client/Interactions/interact.hpp#L44)
## INTERACT_RPC_EXAMINE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interact.hpp at line 45](../../../Src/client/Interactions/interact.hpp#L45)
## INTERACT_RPC_MAIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\interact.hpp at line 46](../../../Src/client/Interactions/interact.hpp#L46)
## INTERACT_RPC_EXTRA

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Interactions\interact.hpp at line 47](../../../Src/client/Interactions/interact.hpp#L47)
## INTERACT_RPC_CLICK_SELF

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interact.hpp at line 48](../../../Src/client/Interactions/interact.hpp#L48)
## INTERACT_PROGRESS_TYPE_FULL

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact.hpp at line 58](../../../Src/client/Interactions/interact.hpp#L58)
## INTERACT_PROGRESS_TYPE_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interact.hpp at line 59](../../../Src/client/Interactions/interact.hpp#L59)
## INTERACT_PROGRESS_TYPE_LAZY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interact.hpp at line 60](../../../Src/client/Interactions/interact.hpp#L60)
## ATTACK_TYPE_ASSOC_HAND

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact.hpp at line 64](../../../Src/client/Interactions/interact.hpp#L64)
## ATTACK_TYPE_ASSOC_THRUST_ONLY

Type: constant

Description: только прямые


Replaced value:
```sqf
1
```
File: [client\Interactions\interact.hpp at line 66](../../../Src/client/Interactions/interact.hpp#L66)
## ATTACK_TYPE_ASSOC_SWING_ONLY

Type: constant

Description: только амплитудные


Replaced value:
```sqf
2
```
File: [client\Interactions\interact.hpp at line 68](../../../Src/client/Interactions/interact.hpp#L68)
## ATTACK_TYPE_ASSOC_STANDARD

Type: constant

Description: 2 стандартных режима


Replaced value:
```sqf
3
```
File: [client\Interactions\interact.hpp at line 70](../../../Src/client/Interactions/interact.hpp#L70)
## ATTACK_TYPE_ASSOC_WPN_HANDLE

Type: constant

Description: по сколько выстрелов можно делать WPN_[x]_[n] (ATTACK_TYPE_ASSOC_WPN_1_3 - 1 и 3)


Replaced value:
```sqf
4
```
File: [client\Interactions\interact.hpp at line 72](../../../Src/client/Interactions/interact.hpp#L72)
## ATTACK_TYPE_ASSOC_WPN_1

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interact.hpp at line 73](../../../Src/client/Interactions/interact.hpp#L73)
## ATTACK_TYPE_ASSOC_WPN_1_3

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\Interactions\interact.hpp at line 74](../../../Src/client/Interactions/interact.hpp#L74)
## ATTACK_TYPE_ASSOC_SWING_HANDLE

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\Interactions\interact.hpp at line 76](../../../Src/client/Interactions/interact.hpp#L76)
## ATTACK_TYPE_ASSOC_IS_SHOOTING(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
(v in [ATTACK_TYPE_ASSOC_WPN_1,ATTACK_TYPE_ASSOC_WPN_1_3])
```
File: [client\Interactions\interact.hpp at line 80](../../../Src/client/Interactions/interact.hpp#L80)
# interact.sqf

## __hardcoded_angle__

Type: constant

Description: private _angle = (getCameraViewDirection player) select 2;


Replaced value:
```sqf
-0.2
```
File: [client\Interactions\interact.sqf at line 292](../../../Src/client/Interactions/interact.sqf#L292)
## verb_internal_bufferedObjData

Type: Variable

Description: это инвентарный мировой верб


Initial value:
```sqf
[[objNUll,vec3(0,0,0),false],[50,50]]
```
File: [client\Interactions\interact.sqf at line 112](../../../Src/client/Interactions/interact.sqf#L112)
## verb_internal_isAwaitWorldVerb

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interact.sqf at line 114](../../../Src/client/Interactions/interact.sqf#L114)
## interact_isOpenMousemode

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interact.sqf at line 490](../../../Src/client/Interactions/interact.sqf#L490)
## interact_isMouseModeActive

Type: Variable

Description: reset mousemode


Initial value:
```sqf
true //допускается ли активность режима мышь/мир
```
File: [client\Interactions\interact.sqf at line 492](../../../Src/client/Interactions/interact.sqf#L492)
## interact_isActive

Type: function

Description: 
- Param: _conscious (optional, default true)
- Param: _stunned (optional, default false)

File: [client\Interactions\interact.sqf at line 47](../../../Src/client/Interactions/interact.sqf#L47)
## interact_onLMBPress

Type: function

Description: 
- Param: _isWorld (optional, default true)
- Param: _isSelfClick (optional, default false)

File: [client\Interactions\interact.sqf at line 54](../../../Src/client/Interactions/interact.sqf#L54)
## interact_onRMBPress

Type: function

Description: 
- Param: _isWorld (optional, default true)

File: [client\Interactions\interact.sqf at line 78](../../../Src/client/Interactions/interact.sqf#L78)
## interact_onMainAction

Type: function

Description: 
- Param: _obj
- Param: _posAtl

File: [client\Interactions\interact.sqf at line 117](../../../Src/client/Interactions/interact.sqf#L117)
## interact_onExtraAction

Type: function

Description: 
- Param: _obj
- Param: _posAtl

File: [client\Interactions\interact.sqf at line 133](../../../Src/client/Interactions/interact.sqf#L133)
## interact_sendAction

Type: function

Description: 
- Param: _isMouseMode
- Param: _actionType

File: [client\Interactions\interact.sqf at line 150](../../../Src/client/Interactions/interact.sqf#L150)
## interact_setCombatMode

Type: function

Description: 
- Param: _newMode

File: [client\Interactions\interact.sqf at line 181](../../../Src/client/Interactions/interact.sqf#L181)
## interact_cursorObject

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 200](../../../Src/client/Interactions/interact.sqf#L200)
## interact_getCursorIntersectPos

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 232](../../../Src/client/Interactions/interact.sqf#L232)
## interact_getIntersectData

Type: function

Description: 
- Param: _ignored

File: [client\Interactions\interact.sqf at line 259](../../../Src/client/Interactions/interact.sqf#L259)
## interact_getMouseIntersectData

Type: function

Description: 
- Param: _ignored

File: [client\Interactions\interact.sqf at line 288](../../../Src/client/Interactions/interact.sqf#L288)
## interact_getRayCastData

Type: function

Description: 
- Param: _startPos
- Param: _endPos
- Param: _ig1 (optional, default objnull)
- Param: _ig2 (optional, default objnull)

File: [client\Interactions\interact.sqf at line 317](../../../Src/client/Interactions/interact.sqf#L317)
## interact_checkPosition

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 346](../../../Src/client/Interactions/interact.sqf#L346)
## interact_inScreenView

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 352](../../../Src/client/Interactions/interact.sqf#L352)
## interact_getHeadDirection

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 358](../../../Src/client/Interactions/interact.sqf#L358)
## interact_canTouchPosition

Type: function

Description: 
- Param: _posAtl
- Param: _ignored (optional, default objNull)

File: [client\Interactions\interact.sqf at line 387](../../../Src/client/Interactions/interact.sqf#L387)
## interact_canInteractWithObject

Type: function

Description: 
- Param: _object
- Param: _pos

File: [client\Interactions\interact.sqf at line 417](../../../Src/client/Interactions/interact.sqf#L417)
## interact_getNearPointForObject

Type: function

Description: 
- Param: _targetOrPos

File: [client\Interactions\interact.sqf at line 445](../../../Src/client/Interactions/interact.sqf#L445)
## interact_getIntersectionCount

Type: function

Description: 
- Param: _targetPos

File: [client\Interactions\interact.sqf at line 469](../../../Src/client/Interactions/interact.sqf#L469)
## interact_canUseInteract

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 497](../../../Src/client/Interactions/interact.sqf#L497)
## interact_openMouseMode

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 503](../../../Src/client/Interactions/interact.sqf#L503)
## interact_closeMouseMode

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 529](../../../Src/client/Interactions/interact.sqf#L529)
## interact_closeMouseMode_handle

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 584](../../../Src/client/Interactions/interact.sqf#L584)
## interact_onMouseButtonUp

Type: function

Description: 
- Param: _d
- Param: _key
- Param: _xPos
- Param: _yPos
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\Interactions\interact.sqf at line 600](../../../Src/client/Interactions/interact.sqf#L600)
## interact_getReachItem

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 678](../../../Src/client/Interactions/interact.sqf#L678)
## setpostestmobinmouse

Type: function

> Exists if **DEBUG** defined

Description: 


File: [client\Interactions\interact.sqf at line 747](../../../Src/client/Interactions/interact.sqf#L747)
# interactCombat.hpp

## CS_MAP_INDEX_TEXT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interactCombat.hpp at line 13](../../../Src/client/Interactions/interactCombat.hpp#L13)
## CS_MAP_INDEX_COLOR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interactCombat.hpp at line 14](../../../Src/client/Interactions/interactCombat.hpp#L14)
## CS_MAP_INDEX_ENUM

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactCombat.hpp at line 15](../../../Src/client/Interactions/interactCombat.hpp#L15)
## CS_MAP_INDEX_TEXT_RANGED

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\interactCombat.hpp at line 16](../../../Src/client/Interactions/interactCombat.hpp#L16)
## curWidgets

Type: constant

Description: 


Replaced value:
```sqf
interactCombat_curWidgets
```
File: [client\Interactions\interactCombat.hpp at line 21](../../../Src/client/Interactions/interactCombat.hpp#L21)
## CM_CUR_IND_ATT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interactCombat.hpp at line 24](../../../Src/client/Interactions/interactCombat.hpp#L24)
## CM_CUR_IND_DEF

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interactCombat.hpp at line 25](../../../Src/client/Interactions/interactCombat.hpp#L25)
## CM_CUR_IND_CS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactCombat.hpp at line 26](../../../Src/client/Interactions/interactCombat.hpp#L26)
## CS_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
25
```
File: [client\Interactions\interactCombat.hpp at line 31](../../../Src/client/Interactions/interactCombat.hpp#L31)
## CS_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\Interactions\interactCombat.hpp at line 34](../../../Src/client/Interactions/interactCombat.hpp#L34)
## TIME_TOLOAD_INTERACTCOMBAT

Type: constant

Description: 


Replaced value:
```sqf
0.05
```
File: [client\Interactions\interactCombat.hpp at line 37](../../../Src/client/Interactions/interactCombat.hpp#L37)
## TIME_TOUNLOAD_INTERACTCOMBAT

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Interactions\interactCombat.hpp at line 39](../../../Src/client/Interactions/interactCombat.hpp#L39)
## FADE_BUT_AT

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\Interactions\interactCombat.hpp at line 43](../../../Src/client/Interactions/interactCombat.hpp#L43)
## FADE_BUT_DEF

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\Interactions\interactCombat.hpp at line 44](../../../Src/client/Interactions/interactCombat.hpp#L44)
## FADE_BUT_CS

Type: constant

Description: 


Replaced value:
```sqf
0.8
```
File: [client\Interactions\interactCombat.hpp at line 45](../../../Src/client/Interactions/interactCombat.hpp#L45)
## TIME_BUT_AT

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactCombat.hpp at line 49](../../../Src/client/Interactions/interactCombat.hpp#L49)
## TIME_BUT_DEF

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactCombat.hpp at line 50](../../../Src/client/Interactions/interactCombat.hpp#L50)
## TIME_BUT_CS

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactCombat.hpp at line 51](../../../Src/client/Interactions/interactCombat.hpp#L51)
# interactCombat.sqf

## vec4(x,y,w,h)

Type: constant

Description: 
- Param: x
- Param: y
- Param: w
- Param: h

Replaced value:
```sqf
[x,y,w,h]
```
File: [client\Interactions\interactCombat.sqf at line 9](../../../Src/client/Interactions/interactCombat.sqf#L9)
## size_def_w

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\Interactions\interactCombat.sqf at line 17](../../../Src/client/Interactions/interactCombat.sqf#L17)
## size_col

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactCombat.sqf at line 178](../../../Src/client/Interactions/interactCombat.sqf#L178)
## centerizeText(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
mes
```
File: [client\Interactions\interactCombat.sqf at line 180](../../../Src/client/Interactions/interactCombat.sqf#L180)
## setFadeIfMode(checked,enum,fade,index)

Type: constant

Description: 
- Param: checked
- Param: enum
- Param: fade
- Param: index

Replaced value:
```sqf
\
		if (equals(checked,enum)) then { \
			_butt setFade fade; _butt commit 0; \
			curWidgets set [index,_butt]; \
		}
```
File: [client\Interactions\interactCombat.sqf at line 183](../../../Src/client/Interactions/interactCombat.sqf#L183)
## allocDefButton(sizes,name,_mode)

Type: constant

Description: 
- Param: sizes
- Param: name
- Param: _mode

Replaced value:
```sqf
\
		_butt = [_d,BUTTON,sizes,_ctg] call createWidget; \
		_butt setvariable ['mode',_mode]; \
		_butt ctrlSetText name; \
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressDef]; \
		_butt ctrlSetTextColor [0.275,0.58,0,1]
```
File: [client\Interactions\interactCombat.sqf at line 190](../../../Src/client/Interactions/interactCombat.sqf#L190)
## allocAttTypeButton(sizes,name,_mode)

Type: constant

Description: 
- Param: sizes
- Param: name
- Param: _mode

Replaced value:
```sqf
\
		_butt = [_d,BUTTON,sizes,_ctg] call createWidget; \
		_butt setvariable ['mode',_mode]; \
		_butt ctrlSetText name; \
		interactCombat_map_attTypeWidgets set [_mode,_butt]; \
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressAttType]; \
		_butt ctrlSetTextColor [0.886,0,0.282,1]
```
File: [client\Interactions\interactCombat.sqf at line 197](../../../Src/client/Interactions/interactCombat.sqf#L197)
## getMode(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid getVariable "mode"
```
File: [client\Interactions\interactCombat.sqf at line 302](../../../Src/client/Interactions/interactCombat.sqf#L302)
## interactCombat_initCombatStyles

Type: function

Description: 
- Param: _d
- Param: _pos
- Param: _index
- Param: _modeLoad (optional, default 0)

File: [client\Interactions\interactCombat.sqf at line 20](../../../Src/client/Interactions/interactCombat.sqf#L20)
## interactCombat_updateAttackTypes

Type: function

Description: 
- Param: _assocEnum (optional, default interactCombat_at_assocEnum)

File: [client\Interactions\interactCombat.sqf at line 78](../../../Src/client/Interactions/interactCombat.sqf#L78)
## interactCombat_load

Type: function

Description: 


File: [client\Interactions\interactCombat.sqf at line 166](../../../Src/client/Interactions/interactCombat.sqf#L166)
## interactCombat_onMouseMoving

Type: function

Description: 
- Param: _display

File: [client\Interactions\interactCombat.sqf at line 273](../../../Src/client/Interactions/interactCombat.sqf#L273)
## interactCombat_onPressCS

Type: function

Description: 
- Param: _ct
- Param: _butt

File: [client\Interactions\interactCombat.sqf at line 307](../../../Src/client/Interactions/interactCombat.sqf#L307)
## interactCombat_onPressDef

Type: function

Description: 
- Param: _ct
- Param: _butt

File: [client\Interactions\interactCombat.sqf at line 323](../../../Src/client/Interactions/interactCombat.sqf#L323)
## interactCombat_onPressAttType

Type: function

Description: 
- Param: _ct
- Param: _butt

File: [client\Interactions\interactCombat.sqf at line 346](../../../Src/client/Interactions/interactCombat.sqf#L346)
## interactCombat_syncView_onSBH

Type: function

Description: 
- Param: _buffer

File: [client\Interactions\interactCombat.sqf at line 356](../../../Src/client/Interactions/interactCombat.sqf#L356)
# interactCombat_defines.sqf

## addCStyle(_color,name,nameranged,_enum)

Type: constant

Description: 
- Param: _color
- Param: name
- Param: nameranged
- Param: _enum

Replaced value:
```sqf
['name','_color',_enum,'nameranged']
```
File: [client\Interactions\interactCombat_defines.sqf at line 20](../../../Src/client/Interactions/interactCombat_defines.sqf#L20)
## interactCombat_disableGlobal

Type: Variable

Description: 


Initial value:
```sqf
false //true means upper combat menu is not shown
```
File: [client\Interactions\interactCombat_defines.sqf at line 11](../../../Src/client/Interactions/interactCombat_defines.sqf#L11)
## interactCombat_isLoadedMenu

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interactCombat_defines.sqf at line 14](../../../Src/client/Interactions/interactCombat_defines.sqf#L14)
## interactCombat_csModesType

Type: Variable

Description: 


Initial value:
```sqf
0 //0 handed,1 shooting
```
File: [client\Interactions\interactCombat_defines.sqf at line 17](../../../Src/client/Interactions/interactCombat_defines.sqf#L17)
## interactCombat_styleMap

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Interactions\interactCombat_defines.sqf at line 22](../../../Src/client/Interactions/interactCombat_defines.sqf#L22)
## interactCombat_map_widgetStyles

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Interactions\interactCombat_defines.sqf at line 49](../../../Src/client/Interactions/interactCombat_defines.sqf#L49)
## interactCombat_hud_map_Styles

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Interactions\interactCombat_defines.sqf at line 51](../../../Src/client/Interactions/interactCombat_defines.sqf#L51)
## interactCombat_curWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull]
```
File: [client\Interactions\interactCombat_defines.sqf at line 63](../../../Src/client/Interactions/interactCombat_defines.sqf#L63)
## interactCombat_at_list_types

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\interactCombat_defines.sqf at line 66](../../../Src/client/Interactions/interactCombat_defines.sqf#L66)
## interactCombat_at_assocEnum

Type: Variable

Description: 


Initial value:
```sqf
ATTACK_TYPE_ASSOC_HAND
```
File: [client\Interactions\interactCombat_defines.sqf at line 68](../../../Src/client/Interactions/interactCombat_defines.sqf#L68)
## interactCombat_map_attTypeWidgets

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\Interactions\interactCombat_defines.sqf at line 71](../../../Src/client/Interactions/interactCombat_defines.sqf#L71)
## interactCombat_at_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\interactCombat_defines.sqf at line 76](../../../Src/client/Interactions/interactCombat_defines.sqf#L76)
# interactEmoteMenu.sqf

## INTERACT_EMOTE_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\Interactions\interactEmoteMenu.sqf at line 30](../../../Src/client/Interactions/interactEmoteMenu.sqf#L30)
## INTERACT_EMOTE_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\Interactions\interactEmoteMenu.sqf at line 32](../../../Src/client/Interactions/interactEmoteMenu.sqf#L32)
## interactEmote_disableGlobal

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interactEmoteMenu.sqf at line 11](../../../Src/client/Interactions/interactEmoteMenu.sqf#L11)
## interactEmote_isLoadedMenu

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interactEmoteMenu.sqf at line 14](../../../Src/client/Interactions/interactEmoteMenu.sqf#L14)
## interactEmote_inputText

Type: Variable

Description: 


Initial value:
```sqf
""
```
File: [client\Interactions\interactEmoteMenu.sqf at line 17](../../../Src/client/Interactions/interactEmoteMenu.sqf#L17)
## interactEmote_curTabIdx

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Interactions\interactEmoteMenu.sqf at line 20](../../../Src/client/Interactions/interactEmoteMenu.sqf#L20)
## interactEmote_actions

Type: Variable

Description: 


Initial value:
```sqf
[["Эмоции","Эмоция:emt_1"]]
```
File: [client\Interactions\interactEmoteMenu.sqf at line 23](../../../Src/client/Interactions/interactEmoteMenu.sqf#L23)
## interactEmote_generatedActs

Type: Variable

Description: 


Initial value:
```sqf
[] //not used
```
File: [client\Interactions\interactEmoteMenu.sqf at line 25](../../../Src/client/Interactions/interactEmoteMenu.sqf#L25)
## interactEmote_act_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\interactEmoteMenu.sqf at line 27](../../../Src/client/Interactions/interactEmoteMenu.sqf#L27)
## interactEmote_load

Type: function

Description: 
- Param: 
- Param: _key

File: [client\Interactions\interactEmoteMenu.sqf at line 39](../../../Src/client/Interactions/interactEmoteMenu.sqf#L39)
## interactEmote_onListCategoryes

Type: function

Description: 
- Param: _mode

File: [client\Interactions\interactEmoteMenu.sqf at line 197](../../../Src/client/Interactions/interactEmoteMenu.sqf#L197)
## interactEmote_cleanupInputText

Type: function

Description: 


File: [client\Interactions\interactEmoteMenu.sqf at line 271](../../../Src/client/Interactions/interactEmoteMenu.sqf#L271)
## interactEmote_getInputTextParams

Type: function

Description: 


File: [client\Interactions\interactEmoteMenu.sqf at line 278](../../../Src/client/Interactions/interactEmoteMenu.sqf#L278)
## interactEmote_handleInputText

Type: function

Description: 
- Param: _text

File: [client\Interactions\interactEmoteMenu.sqf at line 285](../../../Src/client/Interactions/interactEmoteMenu.sqf#L285)
## interactEmote_onSendEmote

Type: function

Description: 
- Param: _text

File: [client\Interactions\interactEmoteMenu.sqf at line 334](../../../Src/client/Interactions/interactEmoteMenu.sqf#L334)
## interactEmote_onMouseMoving

Type: function

Description: 
- Param: _display

File: [client\Interactions\interactEmoteMenu.sqf at line 350](../../../Src/client/Interactions/interactEmoteMenu.sqf#L350)
## interactEmote_switchActionMenu

Type: function

Description: 
- Param: _mode
- Param: _isSetMode (optional, default false)

File: [client\Interactions\interactEmoteMenu.sqf at line 375](../../../Src/client/Interactions/interactEmoteMenu.sqf#L375)
## interactEmote_loadActions

Type: function

Description: 


File: [client\Interactions\interactEmoteMenu.sqf at line 396](../../../Src/client/Interactions/interactEmoteMenu.sqf#L396)
## interactEmote_doEmoteAction

Type: function

Description: 
- Param: _act

File: [client\Interactions\interactEmoteMenu.sqf at line 478](../../../Src/client/Interactions/interactEmoteMenu.sqf#L478)
## interactEmote_unloadActions

Type: function

Description: 
- Param: _acts

File: [client\Interactions\interactEmoteMenu.sqf at line 502](../../../Src/client/Interactions/interactEmoteMenu.sqf#L502)
## interactEmote_RpcLoadEmotes

Type: function

Description: 


File: [client\Interactions\interactEmoteMenu.sqf at line 507](../../../Src/client/Interactions/interactEmoteMenu.sqf#L507)
## interactEmote_RpcUpdateCateg

Type: function

Description: 
- Param: _cat
- Param: _list

File: [client\Interactions\interactEmoteMenu.sqf at line 516](../../../Src/client/Interactions/interactEmoteMenu.sqf#L516)
# interactMenu.hpp

## SIZE_HITPART_ZONE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interactMenu.hpp at line 13](../../../Src/client/Interactions/interactMenu.hpp#L13)
## map_hit(x,y)

Type: constant

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
[x,y,32,SIZE_HITPART_ZONE]
```
File: [client\Interactions\interactMenu.hpp at line 16](../../../Src/client/Interactions/interactMenu.hpp#L16)
## map_zonenames

Type: constant

Description: 


Replaced value:
```sqf
["Голова","Лицо","Рот","Шея","Торс","Живот","Пах"]
```
File: [client\Interactions\interactMenu.hpp at line 19](../../../Src/client/Interactions/interactMenu.hpp#L19)
## map_zoneindex

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_MOUTH,TARGET_ZONE_NECK,TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN,TARGET_ZONE_GROIN]
```
File: [client\Interactions\interactMenu.hpp at line 21](../../../Src/client/Interactions/interactMenu.hpp#L21)
## map_limbs

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_EYE_L,TARGET_ZONE_EYE_R,TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R,TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R]
```
File: [client\Interactions\interactMenu.hpp at line 24](../../../Src/client/Interactions/interactMenu.hpp#L24)
## CALLING_IN_DISPLAY_MODE

Type: constant

Description: 


Replaced value:
```sqf
true
```
File: [client\Interactions\interactMenu.hpp at line 27](../../../Src/client/Interactions/interactMenu.hpp#L27)
## TIME_TOLOAD_INTERACTMENU

Type: constant

Description: 


Replaced value:
```sqf
TIME_PREPARE_SLOTS
```
File: [client\Interactions\interactMenu.hpp at line 30](../../../Src/client/Interactions/interactMenu.hpp#L30)
## TIME_TOUNLOAD_INTERACTMENU

Type: constant

Description: 


Replaced value:
```sqf
TIME_PREPARE_SLOTS
```
File: [client\Interactions\interactMenu.hpp at line 33](../../../Src/client/Interactions/interactMenu.hpp#L33)
## FADEIN_SPECACT

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\Interactions\interactMenu.hpp at line 36](../../../Src/client/Interactions/interactMenu.hpp#L36)
## FADE_TIME

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactMenu.hpp at line 38](../../../Src/client/Interactions/interactMenu.hpp#L38)
## FADE_FOR_SELECTED

Type: constant

Description: 


Replaced value:
```sqf
0.6
```
File: [client\Interactions\interactMenu.hpp at line 41](../../../Src/client/Interactions/interactMenu.hpp#L41)
## TIME_TO_INFADE

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Interactions\interactMenu.hpp at line 44](../../../Src/client/Interactions/interactMenu.hpp#L44)
## ACTION_SWITCHABLE

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interactMenu.hpp at line 48](../../../Src/client/Interactions/interactMenu.hpp#L48)
## ACTION_PLAYING

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interactMenu.hpp at line 49](../../../Src/client/Interactions/interactMenu.hpp#L49)
# interactMenu.sqf

## DEBUG_USE_BORDERS

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interactMenu.sqf at line 17](../../../Src/client/Interactions/interactMenu.sqf#L17)
## debug_colorize(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor [random 1,random 1,random 1,1]
```
File: [client\Interactions\interactMenu.sqf at line 20](../../../Src/client/Interactions/interactMenu.sqf#L20)
## debug_colorizeButton(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor  [random 1,random 1,random 1,1]
```
File: [client\Interactions\interactMenu.sqf at line 22](../../../Src/client/Interactions/interactMenu.sqf#L22)
## colorizeCategory(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor [.3,.3,.3,.7]
```
File: [client\Interactions\interactMenu.sqf at line 25](../../../Src/client/Interactions/interactMenu.sqf#L25)
## colorizeButton(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor [.1,.1,.1,.7]
```
File: [client\Interactions\interactMenu.sqf at line 27](../../../Src/client/Interactions/interactMenu.sqf#L27)
## setButtonText(wid,text)

Type: constant

Description: 
- Param: wid
- Param: text

Replaced value:
```sqf
wid ctrlSetStructuredText (parseText format["<t size='0.8' align='center' valign='middle'>%1</t>" arg text])
```
File: [client\Interactions\interactMenu.sqf at line 31](../../../Src/client/Interactions/interactMenu.sqf#L31)
## setCategText(wid,text)

Type: constant

Description: 
- Param: wid
- Param: text

Replaced value:
```sqf
wid ctrlSetStructuredText (parseText format ["<t size='0.8' align='center' valign='middle'>%1</t>" arg text])
```
File: [client\Interactions\interactMenu.sqf at line 33](../../../Src/client/Interactions/interactMenu.sqf#L33)
## setAttrText(wid,text,addit)

Type: constant

Description: 
- Param: wid
- Param: text
- Param: addit

Replaced value:
```sqf
setText(wid,format["<t size='1.2'>%1</t><t size='0.8'>%2</t>" arg text arg addit])
```
File: [client\Interactions\interactMenu.sqf at line 35](../../../Src/client/Interactions/interactMenu.sqf#L35)
## setText(wid,text)

Type: constant

Description: 
- Param: wid
- Param: text

Replaced value:
```sqf
[wid,text] call widgetSetText
```
File: [client\Interactions\interactMenu.sqf at line 37](../../../Src/client/Interactions/interactMenu.sqf#L37)
## WIDTH_ATTR

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\Interactions\interactMenu.sqf at line 40](../../../Src/client/Interactions/interactMenu.sqf#L40)
## HEIGHT_CATEGORY

Type: constant

Description: 


Replaced value:
```sqf
2.5
```
File: [client\Interactions\interactMenu.sqf at line 42](../../../Src/client/Interactions/interactMenu.sqf#L42)
## SIZE_INTENT_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\interactMenu.sqf at line 44](../../../Src/client/Interactions/interactMenu.sqf#L44)
## STD_BIAS_Y

Type: constant

Description: 


Replaced value:
```sqf
1.5
```
File: [client\Interactions\interactMenu.sqf at line 46](../../../Src/client/Interactions/interactMenu.sqf#L46)
## STD_BIAS_X

Type: constant

Description: 


Replaced value:
```sqf
1.5
```
File: [client\Interactions\interactMenu.sqf at line 48](../../../Src/client/Interactions/interactMenu.sqf#L48)
## createText(sizes)

Type: constant

Description: 
- Param: sizes

Replaced value:
```sqf
[_d,TEXT,sizes,_ctg] call createWidget
```
File: [client\Interactions\interactMenu.sqf at line 64](../../../Src/client/Interactions/interactMenu.sqf#L64)
## createButton(sizes)

Type: constant

Description: 
- Param: sizes

Replaced value:
```sqf
[_d,BUTTONMENU,sizes,_ctg] call createWidget
```
File: [client\Interactions\interactMenu.sqf at line 65](../../../Src/client/Interactions/interactMenu.sqf#L65)
## createSpecButton(sizes)

Type: constant

Description: 
- Param: sizes

Replaced value:
```sqf
[_d,BUTTONMENU,sizes,_ctgSpec] call createWidget
```
File: [client\Interactions\interactMenu.sqf at line 66](../../../Src/client/Interactions/interactMenu.sqf#L66)
## vec4(x,y,w,h)

Type: constant

Description: 
- Param: x
- Param: y
- Param: w
- Param: h

Replaced value:
```sqf
[x,y,w,h]
```
File: [client\Interactions\interactMenu.sqf at line 68](../../../Src/client/Interactions/interactMenu.sqf#L68)
## MAX_SELECTIONS_TODOWN

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\Interactions\interactMenu.sqf at line 174](../../../Src/client/Interactions/interactMenu.sqf#L174)
## allocSelectionId(wid,sel)

Type: constant

Description: 
- Param: wid
- Param: sel

Replaced value:
```sqf
wid setvariable ['id',sel]; \
	wid ctrlAddEventHandler ["MouseButtonUp",{params ["_w","_button"]; \
	[_w getVariable 'id',_button] call interactMenu_setSelection}];
```
File: [client\Interactions\interactMenu.sqf at line 177](../../../Src/client/Interactions/interactMenu.sqf#L177)
## allocSelectionId_limb(wid,sel)

Type: constant

Description: 
- Param: wid
- Param: sel

Replaced value:
```sqf
allocSelectionId(wid,sel); \
	INC(_counter); interactMenu_selectionWidgets set [MAX_SELECTIONS_TODOWN + _counter,_butt];
```
File: [client\Interactions\interactMenu.sqf at line 182](../../../Src/client/Interactions/interactMenu.sqf#L182)
## _specact_bias_x

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interactMenu.sqf at line 311](../../../Src/client/Interactions/interactMenu.sqf#L311)
## _specact_bias_y

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactMenu.sqf at line 313](../../../Src/client/Interactions/interactMenu.sqf#L313)
## _specact_size_h

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\Interactions\interactMenu.sqf at line 315](../../../Src/client/Interactions/interactMenu.sqf#L315)
## interactMenu_load

Type: function

Description: 


File: [client\Interactions\interactMenu.sqf at line 54](../../../Src/client/Interactions/interactMenu.sqf#L54)
## interactMenu_onMouseMove

Type: function

Description: 
- Param: _display
- Param: _xPos
- Param: _yPos

File: [client\Interactions\interactMenu.sqf at line 263](../../../Src/client/Interactions/interactMenu.sqf#L263)
## interactMenu_unloadMenu

Type: function

Description: 


File: [client\Interactions\interactMenu.sqf at line 283](../../../Src/client/Interactions/interactMenu.sqf#L283)
## interactMenu_syncSpecialActions

Type: function

Description: 
- Param: _isInit (optional, default true)

File: [client\Interactions\interactMenu.sqf at line 292](../../../Src/client/Interactions/interactMenu.sqf#L292)
# interactMenu_defines.sqf

## INT_PATH(pt)

Type: constant

Description: 
- Param: pt

Replaced value:
```sqf
(PATH_PICTURE_FOLDER + "interact\" + pt + ".paa" )
```
File: [client\Interactions\interactMenu_defines.sqf at line 27](../../../Src/client/Interactions/interactMenu_defines.sqf#L27)
## interactMenu_disableGlobal

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interactMenu_defines.sqf at line 11](../../../Src/client/Interactions/interactMenu_defines.sqf#L11)
## interactMenu_isLoadedMenu

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interactMenu_defines.sqf at line 15](../../../Src/client/Interactions/interactMenu_defines.sqf#L15)
## interactMenu_skillWidgets

Type: Variable

Description: 


Initial value:
```sqf
_interactMenu_skillWidgets apply ...
```
File: [client\Interactions\interactMenu_defines.sqf at line 22](../../../Src/client/Interactions/interactMenu_defines.sqf#L22)
## interactMenu_skillNames

Type: Variable

Description: 


Initial value:
```sqf
["СЛ","ИН","ЛВ","ЗД","ВНС","ВОЛЯ","ВОС","ЖЗ"]
```
File: [client\Interactions\interactMenu_defines.sqf at line 24](../../../Src/client/Interactions/interactMenu_defines.sqf#L24)
## interactMenu_intentPath

Type: Variable

Description: 


Initial value:
```sqf
[INT_PATH("help"),INT_PATH("grab"),INT_PATH("harm")]
```
File: [client\Interactions\interactMenu_defines.sqf at line 30](../../../Src/client/Interactions/interactMenu_defines.sqf#L30)
## interactMenu_intentWidgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull,widgetNull]
```
File: [client\Interactions\interactMenu_defines.sqf at line 33](../../../Src/client/Interactions/interactMenu_defines.sqf#L33)
## interactMenu_activeIntent

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull] //ссылка на виджет активного
```
File: [client\Interactions\interactMenu_defines.sqf at line 35](../../../Src/client/Interactions/interactMenu_defines.sqf#L35)
## interactMenu_intentActiveColors

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Interactions\interactMenu_defines.sqf at line 37](../../../Src/client/Interactions/interactMenu_defines.sqf#L37)
## interactMenu_selectionWidgets

Type: Variable

Description: 


Initial value:
```sqf
_sels apply ...
```
File: [client\Interactions\interactMenu_defines.sqf at line 48](../../../Src/client/Interactions/interactMenu_defines.sqf#L48)
## interactMenu_activeSelectionWidget

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull] //виджет активной зоны
```
File: [client\Interactions\interactMenu_defines.sqf at line 50](../../../Src/client/Interactions/interactMenu_defines.sqf#L50)
## interactMenu_specialActions

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Interactions\interactMenu_defines.sqf at line 54](../../../Src/client/Interactions/interactMenu_defines.sqf#L54)
## interactMenu_specialActions_map_hud

Type: Variable

Description: 


Initial value:
```sqf
createHashMapFromArray [...
```
File: [client\Interactions\interactMenu_defines.sqf at line 69](../../../Src/client/Interactions/interactMenu_defines.sqf#L69)
## interactMenu_curActiveSpecAct

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull]
```
File: [client\Interactions\interactMenu_defines.sqf at line 79](../../../Src/client/Interactions/interactMenu_defines.sqf#L79)
## interactMenu_specActWidgets

Type: Variable

Description: 


Initial value:
```sqf
_nmap apply ...
```
File: [client\Interactions\interactMenu_defines.sqf at line 87](../../../Src/client/Interactions/interactMenu_defines.sqf#L87)
# interactMenu_functions.sqf

## interactMenu_onUpdateSkills

Type: function

Description: 


File: [client\Interactions\interactMenu_functions.sqf at line 13](../../../Src/client/Interactions/interactMenu_functions.sqf#L13)
## interactMenu_getMemories

Type: function

Description: 
- Param: _mode

File: [client\Interactions\interactMenu_functions.sqf at line 39](../../../Src/client/Interactions/interactMenu_functions.sqf#L39)
## interactMenu_setSelection

Type: function

Description: 
- Param: _id
- Param: _button

File: [client\Interactions\interactMenu_functions.sqf at line 53](../../../Src/client/Interactions/interactMenu_functions.sqf#L53)
## interactMenu_syncCurSelection

Type: function

Description: 


File: [client\Interactions\interactMenu_functions.sqf at line 67](../../../Src/client/Interactions/interactMenu_functions.sqf#L67)
## interactMenu_onPressSpecAct

Type: function

Description: 
- Param: _ct
- Param: _butt

File: [client\Interactions\interactMenu_functions.sqf at line 92](../../../Src/client/Interactions/interactMenu_functions.sqf#L92)
# interact_component_shared.hpp

## getObjReference(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(obj getVariable ["ref","noref"])
```
File: [client\Interactions\interact_component_shared.hpp at line 11](../../../Src/client/Interactions/interact_component_shared.hpp#L11)
## getObjReferenceWithMob(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(if (typeof obj == BASIC_MOB_TYPE) then {obj} else {getObjReference(obj)})
```
File: [client\Interactions\interact_component_shared.hpp at line 14](../../../Src/client/Interactions/interact_component_shared.hpp#L14)
# interact_deprecated.sqf

## mlp(selection)

Type: constant

Description: 
- Param: selection

Replaced value:
```sqf
#selection
```
File: [client\Interactions\interact_deprecated.sqf at line 206](../../../Src/client/Interactions/interact_deprecated.sqf#L206)
## DEBUG_DRAW_BBX_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\interact_deprecated.sqf at line 264](../../../Src/client/Interactions/interact_deprecated.sqf#L264)
## interact_debug_viswidgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\interact_deprecated.sqf at line 98](../../../Src/client/Interactions/interact_deprecated.sqf#L98)
## interact_canHandReach

Type: function

Description: 
- Param: _pos2
- Param: _dopDist (optional, default 0)

File: [client\Interactions\interact_deprecated.sqf at line 14](../../../Src/client/Interactions/interact_deprecated.sqf#L14)
## interact_canSeeObject

Type: function

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 33](../../../Src/client/Interactions/interact_deprecated.sqf#L33)
## interact_canSeeMob_handReach

Type: function

Description: 
- Param: _target

File: [client\Interactions\interact_deprecated.sqf at line 102](../../../Src/client/Interactions/interact_deprecated.sqf#L102)
## interact_findNearPosMob

Type: function

Description: 
- Param: _mx
- Param: _my

File: [client\Interactions\interact_deprecated.sqf at line 203](../../../Src/client/Interactions/interact_deprecated.sqf#L203)
## interact_debug_drawBBX

Type: function

> Exists if **DEBUG_ALLOW_DRAW_BBX** defined

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 272](../../../Src/client/Interactions/interact_deprecated.sqf#L272)
## interact_debug_unboxDecal

Type: function

> Exists if **DEBUG_ALLOW_DRAW_BBX** defined

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 278](../../../Src/client/Interactions/interact_deprecated.sqf#L278)
## interact_debug_internal_drawBBXObject

Type: function

> Exists if **DEBUG_ALLOW_DRAW_BBX** defined

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 284](../../../Src/client/Interactions/interact_deprecated.sqf#L284)
# interact_examine.sqf

## interact_examine

Type: function

Description: 


File: [client\Interactions\interact_examine.sqf at line 11](../../../Src/client/Interactions/interact_examine.sqf#L11)
## interact_pointTo

Type: function

Description: 


File: [client\Interactions\interact_examine.sqf at line 32](../../../Src/client/Interactions/interact_examine.sqf#L32)
# interact_grabbing.sqf

## INTERACT_GRAB_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact_grabbing.sqf at line 11](../../../Src/client/Interactions/interact_grabbing.sqf#L11)
## interact_grab_handleupdate

Type: Variable

Description: 


Initial value:
```sqf
vec2(-1,-1)
```
File: [client\Interactions\interact_grabbing.sqf at line 13](../../../Src/client/Interactions/interact_grabbing.sqf#L13)
## interact_grab_bias

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\Interactions\interact_grabbing.sqf at line 15](../../../Src/client/Interactions/interact_grabbing.sqf#L15)
## interact_grab_dir

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\Interactions\interact_grabbing.sqf at line 17](../../../Src/client/Interactions/interact_grabbing.sqf#L17)
## interact_grab_mobObj

Type: Variable

Description: 


Initial value:
```sqf
objNUll
```
File: [client\Interactions\interact_grabbing.sqf at line 19](../../../Src/client/Interactions/interact_grabbing.sqf#L19)
## interact_grab_isGrabbed

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interact_grabbing.sqf at line 22](../../../Src/client/Interactions/interact_grabbing.sqf#L22)
## interact_grab_start

Type: function

Description: 
- Param: _src
- Param: _sidePos
- Param: _vDir
- Param: _sideIdx

File: [client\Interactions\interact_grabbing.sqf at line 25](../../../Src/client/Interactions/interact_grabbing.sqf#L25)
## interact_grab_onUpdate

Type: function

Description: 
- Param: _src
- Param: _sidePos
- Param: _vDir

File: [client\Interactions\interact_grabbing.sqf at line 36](../../../Src/client/Interactions/interact_grabbing.sqf#L36)
## interact_grab_stop

Type: function

Description: 
- Param: _idx

File: [client\Interactions\interact_grabbing.sqf at line 71](../../../Src/client/Interactions/interact_grabbing.sqf#L71)
# interact_mainhandle.sqf

## __log_mainhandle

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interact_mainhandle.sqf at line 12](../../../Src/client/Interactions/interact_mainhandle.sqf#L12)
## ON_FINALIZE(reason)

Type: constant

> Exists if **__log_mainhandle** defined

Description: 
- Param: reason

Replaced value:
```sqf
warningformat("Abort - %1",reason);interact_mainHandleLock = true; nextFrame(_codeExit)
```
File: [client\Interactions\interact_mainhandle.sqf at line 20](../../../Src/client/Interactions/interact_mainhandle.sqf#L20)
## ON_FINALIZE(reason)

Type: constant

> Exists if **__log_mainhandle** not defined

Description: 
- Param: reason

Replaced value:
```sqf
interact_mainHandleLock = true;nextFrame(_codeExit)
```
File: [client\Interactions\interact_mainhandle.sqf at line 22](../../../Src/client/Interactions/interact_mainhandle.sqf#L22)
## checkExiter()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
if (_exiter) exitWith {}
```
File: [client\Interactions\interact_mainhandle.sqf at line 33](../../../Src/client/Interactions/interact_mainhandle.sqf#L33)
## setExiter(mode)

Type: constant

Description: 
- Param: mode

Replaced value:
```sqf
_exiter = mode
```
File: [client\Interactions\interact_mainhandle.sqf at line 34](../../../Src/client/Interactions/interact_mainhandle.sqf#L34)
## interact_mainHandleLock

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\interact_mainhandle.sqf at line 26](../../../Src/client/Interactions/interact_mainhandle.sqf#L26)
# interact_onScreenObjects.sqf

## FLOAT_MAX

Type: constant

Description: 


Replaced value:
```sqf
3.40282346639e+38 // Using 32-bit floats
```
File: [client\Interactions\interact_onScreenObjects.sqf at line 159](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L159)
## interact_internal_onscreenObjs

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\interact_onScreenObjects.sqf at line 11](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L11)
## interact_addOnScreenCapturedObject

Type: function

Description: 
- Param: _wobj

File: [client\Interactions\interact_onScreenObjects.sqf at line 14](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L14)
## interact_removeOnScreenCapturedObject

Type: function

Description: 
- Param: _wobj

File: [client\Interactions\interact_onScreenObjects.sqf at line 21](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L21)
## interact_getOnSceenCapturedObject

Type: function

Description: 
- Param: _isMouseMode (optional, default false)
- Param: _getRealPtr (optional, default true)
- Param: _refOutWorldObj

File: [client\Interactions\interact_onScreenObjects.sqf at line 28](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L28)
## interact_isInSphere

Type: function

Description: 
- Param: _startPos (optional, default [])
- Param: _rayDir (optional, default [])
- Param: _sphPos (optional, default [])
- Param: _sphereRadius (optional, default -1)

File: [client\Interactions\interact_onScreenObjects.sqf at line 133](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L133)
## interact_isPointInSphere

Type: function

Description: 
- Param: _spherePos
- Param: _sphereRadius
- Param: _point

File: [client\Interactions\interact_onScreenObjects.sqf at line 189](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L189)
## interact_isPointInCone

Type: function

Description: 
- Param: _coneStartPos
- Param: _coneEndPos
- Param: _outerAngle
- Param: _point

File: [client\Interactions\interact_onScreenObjects.sqf at line 200](../../../Src/client/Interactions/interact_onScreenObjects.sqf#L200)
# interact_resist.sqf

## interact_processResist

Type: function

Description: 


File: [client\Interactions\interact_resist.sqf at line 11](../../../Src/client/Interactions/interact_resist.sqf#L11)
# progress.sqf

## SIZEPROG

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\Interactions\progress.sqf at line 12](../../../Src/client/Interactions/progress.sqf#L12)
## ONEPERCENTSIZE

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\progress.sqf at line 14](../../../Src/client/Interactions/progress.sqf#L14)
## PROGRADIUSPERCENT

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\Interactions\progress.sqf at line 17](../../../Src/client/Interactions/progress.sqf#L17)
## PROGRESS_MAX_DISTANCE_FALLDOWN

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Interactions\progress.sqf at line 20](../../../Src/client/Interactions/progress.sqf#L20)
## PROGRESS_DISTANCE_TARGET_FALLDOWN

Type: constant

Description: 


Replaced value:
```sqf
0.01
```
File: [client\Interactions\progress.sqf at line 22](../../../Src/client/Interactions/progress.sqf#L22)
## TIME_TO_OUTFADE_PROGRESS

Type: constant

Description: 


Replaced value:
```sqf
0.000006
```
File: [client\Interactions\progress.sqf at line 25](../../../Src/client/Interactions/progress.sqf#L25)
## TIME_TO_SUCCESS_PROGRESS

Type: constant

Description: 


Replaced value:
```sqf
0.00003
```
File: [client\Interactions\progress.sqf at line 27](../../../Src/client/Interactions/progress.sqf#L27)
## TIME_TO_ABORT_PROGRESS

Type: constant

Description: 


Replaced value:
```sqf
0.00001
```
File: [client\Interactions\progress.sqf at line 29](../../../Src/client/Interactions/progress.sqf#L29)
## ROUNDSTEP

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\progress.sqf at line 32](../../../Src/client/Interactions/progress.sqf#L32)
## ROUNDCOUNT

Type: constant

Description: 


Replaced value:
```sqf
(360 / ROUNDSTEP)
```
File: [client\Interactions\progress.sqf at line 34](../../../Src/client/Interactions/progress.sqf#L34)
## override_setpos_precent_w(h_value)

Type: constant

Description: 
- Param: h_value

Replaced value:
```sqf
transformSizeByAR(h_value)
```
File: [client\Interactions\progress.sqf at line 37](../../../Src/client/Interactions/progress.sqf#L37)
## MAX_ALLOW_DISTANCE_CAM_OFFSET

Type: constant

Description: 


Replaced value:
```sqf
0.01
```
File: [client\Interactions\progress.sqf at line 64](../../../Src/client/Interactions/progress.sqf#L64)
## interact_progress_hasProcessed

Type: Variable

Description: interact_progress_curItmIndex = 0;


Initial value:
```sqf
false
```
File: [client\Interactions\progress.sqf at line 44](../../../Src/client/Interactions/progress.sqf#L44)
## interact_progress_countItms

Type: Variable

Description: 


Initial value:
```sqf
0 //use inline interact_progress_countItms
```
File: [client\Interactions\progress.sqf at line 47](../../../Src/client/Interactions/progress.sqf#L47)
## interact_progress_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Interactions\progress.sqf at line 50](../../../Src/client/Interactions/progress.sqf#L50)
## interact_progress_tick

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Interactions\progress.sqf at line 53](../../../Src/client/Interactions/progress.sqf#L53)
## interact_progress_pData

Type: Variable

Description: 


Initial value:
```sqf
["",objnull] //ref to player, and ptr to target
```
File: [client\Interactions\progress.sqf at line 55](../../../Src/client/Interactions/progress.sqf#L55)
## interact_progress_lastTargetPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\Interactions\progress.sqf at line 57](../../../Src/client/Interactions/progress.sqf#L57)
## interact_progress_lastPlayerPos

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\Interactions\progress.sqf at line 59](../../../Src/client/Interactions/progress.sqf#L59)
## interact_progress_lastScreenPoint

Type: Variable

Description: 


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\Interactions\progress.sqf at line 61](../../../Src/client/Interactions/progress.sqf#L61)
## interact_progress_renderPos

Type: Variable

Description: interact_progress_lastPlayerDir = getDir player;


Initial value:
```sqf
vec3(0,0,0)
```
File: [client\Interactions\progress.sqf at line 66](../../../Src/client/Interactions/progress.sqf#L66)
## interact_progress_lastProgressType

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\Interactions\progress.sqf at line 68](../../../Src/client/Interactions/progress.sqf#L68)
## interact_progress_checkDelegates

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\Interactions\progress.sqf at line 126](../../../Src/client/Interactions/progress.sqf#L126)
## interact_progress_startColor

Type: Variable

Description: 


Initial value:
```sqf
[0,0.427,0.298,1]
```
File: [client\Interactions\progress.sqf at line 227](../../../Src/client/Interactions/progress.sqf#L227)
## interact_progress_endColor

Type: Variable

Description: 


Initial value:
```sqf
[0.11,0.161,0.043,1]
```
File: [client\Interactions\progress.sqf at line 229](../../../Src/client/Interactions/progress.sqf#L229)
## interact_progress_widgets

Type: Variable

Description: 


Initial value:
```sqf
[widgetNull,widgetNull] //ctg,text
```
File: [client\Interactions\progress.sqf at line 231](../../../Src/client/Interactions/progress.sqf#L231)
## interact_progress_allItems

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\progress.sqf at line 233](../../../Src/client/Interactions/progress.sqf#L233)
## interact_progress_startProg

Type: function

Description: 
- Param: _ptrPlayer
- Param: _target
- Param: _checkType
- Param: _duration

File: [client\Interactions\progress.sqf at line 79](../../../Src/client/Interactions/progress.sqf#L79)
## interact_progress_cancelProgress

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 115](../../../Src/client/Interactions/progress.sqf#L115)
## interact_progress_start

Type: function

Description: 
- Param: _duration

File: [client\Interactions\progress.sqf at line 148](../../../Src/client/Interactions/progress.sqf#L148)
## interact_progress_onUpdate

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 170](../../../Src/client/Interactions/progress.sqf#L170)
## interact_progress_success

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 200](../../../Src/client/Interactions/progress.sqf#L200)
## interact_progress_stop

Type: function

Description: 
- Param: _sendToServerCancellationToken (optional, default false)
- Param: _fadeValue (optional, default 0)

File: [client\Interactions\progress.sqf at line 207](../../../Src/client/Interactions/progress.sqf#L207)
## interact_progress_init

Type: function

Description: 
- Param: _rs
- Param: _gs
- Param: _bs

File: [client\Interactions\progress.sqf at line 239](../../../Src/client/Interactions/progress.sqf#L239)
## interact_progress_applyColorTheme

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 285](../../../Src/client/Interactions/progress.sqf#L285)
# RayCastConcept.sqf

## getPosObjFromList(idx)

Type: constant

Description: ret vec2 relative pos from camera
- Param: idx

Replaced value:
```sqf
((rc_listObject select idx) getVariable "curVal")
```
File: [client\Interactions\RayCastConcept.sqf at line 79](../../../Src/client/Interactions/RayCastConcept.sqf#L79)
## rc_list

Type: Variable

Description: 


Initial value:
```sqf
[vec2(-1,1),vec2(1,1), //upper left, upper right...
```
File: [client\Interactions\RayCastConcept.sqf at line 7](../../../Src/client/Interactions/RayCastConcept.sqf#L7)
## rc_modelPath

Type: Variable

Description: lower left, lower right


Initial value:
```sqf
"a3\structures_f_epa\items\food\canteen_f.p3d"
```
File: [client\Interactions\RayCastConcept.sqf at line 10](../../../Src/client/Interactions/RayCastConcept.sqf#L10)
## rc_listObject

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\RayCastConcept.sqf at line 12](../../../Src/client/Interactions/RayCastConcept.sqf#L12)
## rc_forwardDistance

Type: Variable

Description: 


Initial value:
```sqf
5
```
File: [client\Interactions\RayCastConcept.sqf at line 14](../../../Src/client/Interactions/RayCastConcept.sqf#L14)
## rc_multiplyBias

Type: Variable

Description: 


Initial value:
```sqf
0.005
```
File: [client\Interactions\RayCastConcept.sqf at line 16](../../../Src/client/Interactions/RayCastConcept.sqf#L16)
## rc_updateVec4PosPerFrame

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\Interactions\RayCastConcept.sqf at line 18](../../../Src/client/Interactions/RayCastConcept.sqf#L18)
## rc_3dCursor

Type: Variable

Description: 


Initial value:
```sqf
"Sign_Arrow_F" createVehicle [0,0,0]
```
File: [client\Interactions\RayCastConcept.sqf at line 20](../../../Src/client/Interactions/RayCastConcept.sqf#L20)
## needchange

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\RayCastConcept.sqf at line 97](../../../Src/client/Interactions/RayCastConcept.sqf#L97)
## newvalue

Type: Variable

Description: 


Initial value:
```sqf
1
```
File: [client\Interactions\RayCastConcept.sqf at line 98](../../../Src/client/Interactions/RayCastConcept.sqf#L98)
## vecbias

Type: Variable

Description: 


Initial value:
```sqf
[0,0,0]
```
File: [client\Interactions\RayCastConcept.sqf at line 99](../../../Src/client/Interactions/RayCastConcept.sqf#L99)
## rc_init

Type: function

Description: 


File: [client\Interactions\RayCastConcept.sqf at line 22](../../../Src/client/Interactions/RayCastConcept.sqf#L22)
## rc_getConvertedPos

Type: function

Description: 
- Param: _xPos
- Param: _yPos

File: [client\Interactions\RayCastConcept.sqf at line 75](../../../Src/client/Interactions/RayCastConcept.sqf#L75)
# verbs.sqf

## TIME_FADEOUT_VERBMENU

Type: constant

Description: 


Replaced value:
```sqf
0.15
```
File: [client\Interactions\verbs.sqf at line 15](../../../Src/client/Interactions/verbs.sqf#L15)
## TIME_FADEIN_VERBMENU

Type: constant

Description: 


Replaced value:
```sqf
0.15
```
File: [client\Interactions\verbs.sqf at line 17](../../../Src/client/Interactions/verbs.sqf#L17)
## SIZE_WIND_W

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\Interactions\verbs.sqf at line 107](../../../Src/client/Interactions/verbs.sqf#L107)
## SIZE_WIND_H

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\Interactions\verbs.sqf at line 108](../../../Src/client/Interactions/verbs.sqf#L108)
## SIZE_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\Interactions\verbs.sqf at line 109](../../../Src/client/Interactions/verbs.sqf#L109)
## verb_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\Interactions\verbs.sqf at line 320](../../../Src/client/Interactions/verbs.sqf#L320)
## verb_lastclickedpos

Type: Variable

Description: Последняя позиция мыши


Initial value:
```sqf
[0,0]
```
File: [client\Interactions\verbs.sqf at line 322](../../../Src/client/Interactions/verbs.sqf#L322)
## verb_isMenuLoaded

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\Interactions\verbs.sqf at line 324](../../../Src/client/Interactions/verbs.sqf#L324)
## verb_lastTargetObjectData

Type: Variable

Description: deprecated variable


Initial value:
```sqf
[objnull,[0,0,0]] //колбэк дата последнего захваченного объекта
```
File: [client\Interactions\verbs.sqf at line 329](../../../Src/client/Interactions/verbs.sqf#L329)
## verb_lastCheckedObjectData

Type: Variable

Description: Последняя позиция объекта


Initial value:
```sqf
VERB_LASTCHECKEDOBJECTDATA_DEFAULT //[object reference,interact bias pos (use (object modeltoworld pos)),ismob]
```
File: [client\Interactions\verbs.sqf at line 332](../../../Src/client/Interactions/verbs.sqf#L332)
## interact_onLoadVerbs

Type: function

Description: 
- Param: _targetName
- Param: _verbList
- Param: _targetHash

File: [client\Interactions\verbs.sqf at line 20](../../../Src/client/Interactions/verbs.sqf#L20)
## verb_internal_checkBind

Type: function

Description: 
- Param: _intorstr

File: [client\Interactions\verbs.sqf at line 78](../../../Src/client/Interactions/verbs.sqf#L78)
## verb_translate

Type: function

Description: 
- Param: _verb

File: [client\Interactions\verbs.sqf at line 91](../../../Src/client/Interactions/verbs.sqf#L91)
## verb_loadMenu

Type: function

Description: 
- Param: _translateList
- Param: _verbList
- Param: _targetName
- Param: _isInInventory (optional, default false)

File: [client\Interactions\verbs.sqf at line 104](../../../Src/client/Interactions/verbs.sqf#L104)
## verb_onPickVerb

Type: function

Description: 
- Param: _control

File: [client\Interactions\verbs.sqf at line 193](../../../Src/client/Interactions/verbs.sqf#L193)
## verb_resetDataForND

Type: function

Description: 


File: [client\Interactions\verbs.sqf at line 236](../../../Src/client/Interactions/verbs.sqf#L236)
## verb_unloadMenu

Type: function

Description: 


File: [client\Interactions\verbs.sqf at line 246](../../../Src/client/Interactions/verbs.sqf#L246)
## verb_setHideInventory

Type: function

Description: 
- Param: _mode
- Param: _closeFlag (optional, default false)

File: [client\Interactions\verbs.sqf at line 271](../../../Src/client/Interactions/verbs.sqf#L271)
## verb_isInsideVerbMenu

Type: function

Description: 


File: [client\Interactions\verbs.sqf at line 315](../../../Src/client/Interactions/verbs.sqf#L315)
