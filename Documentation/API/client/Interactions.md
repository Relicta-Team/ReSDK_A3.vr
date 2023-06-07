# aim_cursor.sqf

## AIM_SIZE

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\aim_cursor.sqf at line 7](../../../Src/client/Interactions/aim_cursor.sqf#L7)
## interaction_aim_init

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 18](../../../Src/client/Interactions/aim_cursor.sqf#L18)
## interaction_aim_getStdPos

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 33](../../../Src/client/Interactions/aim_cursor.sqf#L33)
## interaction_aim_alphaUpdate

Type: function

Description: 
- Param: _r
- Param: _g
- Param: _b

File: [client\Interactions\aim_cursor.sqf at line 38](../../../Src/client/Interactions/aim_cursor.sqf#L38)
## interaction_aim_applyColorTheme

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 64](../../../Src/client/Interactions/aim_cursor.sqf#L64)
## interaction_aim_onUpdate

Type: function

Description: 


File: [client\Interactions\aim_cursor.sqf at line 68](../../../Src/client/Interactions/aim_cursor.sqf#L68)
# interact.hpp

## INTERACT_ITEM_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.35
```
File: [client\Interactions\interact.hpp at line 7](../../../Src/client/Interactions/interact.hpp#L7)
## INTERACT_ITEM_LEG_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.7
```
File: [client\Interactions\interact.hpp at line 8](../../../Src/client/Interactions/interact.hpp#L8)
## INTERACT_MOB_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.2
```
File: [client\Interactions\interact.hpp at line 9](../../../Src/client/Interactions/interact.hpp#L9)
## INTERACT_MOB_COLLECT_DIST

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\interact.hpp at line 10](../../../Src/client/Interactions/interact.hpp#L10)
## WORLD_CONTAINER_ALLOWDISTANCE

Type: constant

Description: 


Replaced value:
```sqf
INTERACT_ITEM_DISTANCE
```
File: [client\Interactions\interact.hpp at line 11](../../../Src/client/Interactions/interact.hpp#L11)
## INTERACT_DISTANCE

Type: constant

Description: 


Replaced value:
```sqf
1.35
```
File: [client\Interactions\interact.hpp at line 14](../../../Src/client/Interactions/interact.hpp#L14)
## getHeadMobPos(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
(mob modelToWorld (mob selectionPosition "head"))
```
File: [client\Interactions\interact.hpp at line 16](../../../Src/client/Interactions/interact.hpp#L16)
## getCenterMobPos(mob)

Type: constant

Description: 
- Param: mob

Replaced value:
```sqf
(mob modelToWorld (mob selectionPosition("spine3")))
```
File: [client\Interactions\interact.hpp at line 17](../../../Src/client/Interactions/interact.hpp#L17)
## isInteractible(targ)

Type: constant

Description: 
- Param: targ

Replaced value:
```sqf
((targ getVariable ["isInteractible",true] && inventory_isPressedInteractButton) || (typeof targ == BASIC_MOB_TYPE))
```
File: [client\Interactions\interact.hpp at line 19](../../../Src/client/Interactions/interact.hpp#L19)
## VERB_LASTCHECKEDOBJECTDATA_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
[objNull,[0,0,0],false]
```
File: [client\Interactions\interact.hpp at line 21](../../../Src/client/Interactions/interact.hpp#L21)
## INTERACT_LODS_CHECK_STANDART

Type: constant

Description: 


Replaced value:
```sqf
"ROADWAY","VIEW"
```
File: [client\Interactions\interact.hpp at line 24](../../../Src/client/Interactions/interact.hpp#L24)
## INTERACT_LODS_CHECK_GEOM

Type: constant

Description: #define INTERACT_LODS_CHECK_STANDART "ROADWAY","VIEW"


Replaced value:
```sqf
"GEOM","VIEW"
```
File: [client\Interactions\interact.hpp at line 25](../../../Src/client/Interactions/interact.hpp#L25)
## INTERACT_RPC_CLICK

Type: constant

Description: interact modes in rpc iact


Replaced value:
```sqf
0
```
File: [client\Interactions\interact.hpp at line 28](../../../Src/client/Interactions/interact.hpp#L28)
## INTERACT_RPC_ALTCLICK

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interact.hpp at line 29](../../../Src/client/Interactions/interact.hpp#L29)
## INTERACT_RPC_EXAMINE

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interact.hpp at line 30](../../../Src/client/Interactions/interact.hpp#L30)
## INTERACT_RPC_MAIN

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\interact.hpp at line 31](../../../Src/client/Interactions/interact.hpp#L31)
## INTERACT_RPC_EXTRA

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\Interactions\interact.hpp at line 32](../../../Src/client/Interactions/interact.hpp#L32)
## INTERACT_RPC_CLICK_SELF

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interact.hpp at line 33](../../../Src/client/Interactions/interact.hpp#L33)
## INTERACT_PROGRESS_TYPE_FULL

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact.hpp at line 41](../../../Src/client/Interactions/interact.hpp#L41)
## INTERACT_PROGRESS_TYPE_MEDIUM

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interact.hpp at line 42](../../../Src/client/Interactions/interact.hpp#L42)
## INTERACT_PROGRESS_TYPE_LAZY

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interact.hpp at line 43](../../../Src/client/Interactions/interact.hpp#L43)
## ATTACK_TYPE_ASSOC_HAND

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact.hpp at line 46](../../../Src/client/Interactions/interact.hpp#L46)
## ATTACK_TYPE_ASSOC_THRUST_ONLY

Type: constant

Description: только прямые


Replaced value:
```sqf
1
```
File: [client\Interactions\interact.hpp at line 48](../../../Src/client/Interactions/interact.hpp#L48)
## ATTACK_TYPE_ASSOC_SWING_ONLY

Type: constant

Description: только амплитудные


Replaced value:
```sqf
2
```
File: [client\Interactions\interact.hpp at line 50](../../../Src/client/Interactions/interact.hpp#L50)
## ATTACK_TYPE_ASSOC_STANDARD

Type: constant

Description: 2 стандартных режима


Replaced value:
```sqf
3
```
File: [client\Interactions\interact.hpp at line 52](../../../Src/client/Interactions/interact.hpp#L52)
## ATTACK_TYPE_ASSOC_WPN_HANDLE

Type: constant

Description: по сколько выстрелов можно делать WPN_[x]_[n] (ATTACK_TYPE_ASSOC_WPN_1_3 - 1 и 3)


Replaced value:
```sqf
4
```
File: [client\Interactions\interact.hpp at line 54](../../../Src/client/Interactions/interact.hpp#L54)
## ATTACK_TYPE_ASSOC_WPN_1

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interact.hpp at line 55](../../../Src/client/Interactions/interact.hpp#L55)
## ATTACK_TYPE_ASSOC_WPN_1_3

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\Interactions\interact.hpp at line 56](../../../Src/client/Interactions/interact.hpp#L56)
## ATTACK_TYPE_ASSOC_SWING_HANDLE

Type: constant

Description: 


Replaced value:
```sqf
7
```
File: [client\Interactions\interact.hpp at line 58](../../../Src/client/Interactions/interact.hpp#L58)
## ATTACK_TYPE_ASSOC_IS_SHOOTING(v)

Type: constant

Description: 
- Param: v

Replaced value:
```sqf
(v in [ATTACK_TYPE_ASSOC_WPN_1,ATTACK_TYPE_ASSOC_WPN_1_3])
```
File: [client\Interactions\interact.hpp at line 60](../../../Src/client/Interactions/interact.hpp#L60)
# interact.sqf

## __hardcoded_angle__

Type: constant

Description: private _angle = (getCameraViewDirection player) select 2;


Replaced value:
```sqf
-0.2
```
File: [client\Interactions\interact.sqf at line 254](../../../Src/client/Interactions/interact.sqf#L254)
## INTERACT_LOG_CANINTERACTWITHOBJECT

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interact.sqf at line 316](../../../Src/client/Interactions/interact.sqf#L316)
## interact_isActive

Type: function

Description: 
- Param: _conscious (optional, default true)
- Param: _stunned (optional, default false)

File: [client\Interactions\interact.sqf at line 42](../../../Src/client/Interactions/interact.sqf#L42)
## interact_onLMBPress

Type: function

Description: 
- Param: _isWorld (optional, default true)
- Param: _isSelfClick (optional, default false)

File: [client\Interactions\interact.sqf at line 48](../../../Src/client/Interactions/interact.sqf#L48)
## interact_onRMBPress

Type: function

Description: 
- Param: _isWorld (optional, default true)

File: [client\Interactions\interact.sqf at line 71](../../../Src/client/Interactions/interact.sqf#L71)
## interact_onMainAction

Type: function

Description: 
- Param: _obj
- Param: _posAtl

File: [client\Interactions\interact.sqf at line 99](../../../Src/client/Interactions/interact.sqf#L99)
## interact_onExtraAction

Type: function

Description: 
- Param: _obj
- Param: _posAtl

File: [client\Interactions\interact.sqf at line 114](../../../Src/client/Interactions/interact.sqf#L114)
## interact_sendAction

Type: function

Description: параметры: _isMouseMode - если включен то вектор направления будет браться от позиции мыши
- Param: _isMouseMode
- Param: _actionType

File: [client\Interactions\interact.sqf at line 130](../../../Src/client/Interactions/interact.sqf#L130)
## interact_setCombatMode

Type: function

Description: 
- Param: _newMode

File: [client\Interactions\interact.sqf at line 147](../../../Src/client/Interactions/interact.sqf#L147)
## interact_cursorObject

Type: function

Description: Получает цель. В отличии от cursorObject может поймать объект в этом же кадре при свапе видимости


File: [client\Interactions\interact.sqf at line 165](../../../Src/client/Interactions/interact.sqf#L165)
## interact_getCursorIntersectPos

Type: function

Description: Получает точку пересечения центра экрана в мир


File: [client\Interactions\interact.sqf at line 196](../../../Src/client/Interactions/interact.sqf#L196)
## interact_getIntersectData

Type: function

Description: Получает информацию об объекте пересечения в виде: [object, intersect position as ATL,vectorUp lod]
- Param: _ignored

File: [client\Interactions\interact.sqf at line 222](../../../Src/client/Interactions/interact.sqf#L222)
## interact_getMouseIntersectData

Type: function

Description: Функция аналогична interact_getIntersectData но по-умоному вычисляет позицию не из центра а из мыши (если возможно)
- Param: _ignored

File: [client\Interactions\interact.sqf at line 250](../../../Src/client/Interactions/interact.sqf#L250)
## interact_checkPosition

Type: function

Description: Проверяет дистанцию до позиции - может ли взаимодействовать по дистанции


File: [client\Interactions\interact.sqf at line 278](../../../Src/client/Interactions/interact.sqf#L278)
## interact_inScreenView

Type: function

Description: Проверяет видимость позиции в экране


File: [client\Interactions\interact.sqf at line 283](../../../Src/client/Interactions/interact.sqf#L283)
## interact_canTouchPosition

Type: function

Description: Иным образом функция является проверкой: может ли игрок дотянуться рукой до позиции
- Param: _posAtl
- Param: _ignored (optional, default objNull)

File: [client\Interactions\interact.sqf at line 289](../../../Src/client/Interactions/interact.sqf#L289)
## interact_canInteractWithObject

Type: function

Description: Основной обработчик возможности взаимодействия с пердметом. Включает в себя все стандартные проверки позиции, направления и пересечения
- Param: _object
- Param: _pos

File: [client\Interactions\interact.sqf at line 318](../../../Src/client/Interactions/interact.sqf#L318)
## interact_getNearPointForObject

Type: function

Description: Находит ближайшую точку на линии игрок->объект
- Param: _targetOrPos

File: [client\Interactions\interact.sqf at line 345](../../../Src/client/Interactions/interact.sqf#L345)
## interact_canUseInteract

Type: function

Description: Однако открыть меню интеракций и изменить какое-либо из значений (кроме интента) можно без этой проверки


File: [client\Interactions\interact.sqf at line 378](../../../Src/client/Interactions/interact.sqf#L378)
## interact_openMouseMode

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 383](../../../Src/client/Interactions/interact.sqf#L383)
## interact_closeMouseMode

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 408](../../../Src/client/Interactions/interact.sqf#L408)
## interact_closeMouseMode_handle

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 462](../../../Src/client/Interactions/interact.sqf#L462)
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

File: [client\Interactions\interact.sqf at line 477](../../../Src/client/Interactions/interact.sqf#L477)
## interact_getReachItem

Type: function

Description: 


File: [client\Interactions\interact.sqf at line 542](../../../Src/client/Interactions/interact.sqf#L542)
## setpostestmobinmouse

Type: function

> Exists if **DEBUG** defined

Description: 


File: [client\Interactions\interact.sqf at line 610](../../../Src/client/Interactions/interact.sqf#L610)
# interactCombat.hpp

## CS_MAP_INDEX_TEXT

Type: constant

Description: ключи для комбат стилей


Replaced value:
```sqf
0
```
File: [client\Interactions\interactCombat.hpp at line 8](../../../Src/client/Interactions/interactCombat.hpp#L8)
## CS_MAP_INDEX_COLOR

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interactCombat.hpp at line 9](../../../Src/client/Interactions/interactCombat.hpp#L9)
## CS_MAP_INDEX_ENUM

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactCombat.hpp at line 10](../../../Src/client/Interactions/interactCombat.hpp#L10)
## CS_MAP_INDEX_TEXT_RANGED

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\Interactions\interactCombat.hpp at line 11](../../../Src/client/Interactions/interactCombat.hpp#L11)
## curWidgets

Type: constant

Description: ссылки на массив в interactCombat_curWidgets


Replaced value:
```sqf
interactCombat_curWidgets
```
File: [client\Interactions\interactCombat.hpp at line 14](../../../Src/client/Interactions/interactCombat.hpp#L14)
## CM_CUR_IND_ATT

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interactCombat.hpp at line 16](../../../Src/client/Interactions/interactCombat.hpp#L16)
## CM_CUR_IND_DEF

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interactCombat.hpp at line 17](../../../Src/client/Interactions/interactCombat.hpp#L17)
## CM_CUR_IND_CS

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactCombat.hpp at line 18](../../../Src/client/Interactions/interactCombat.hpp#L18)
## CS_SIZE_H

Type: constant

Description: высота комбат меню


Replaced value:
```sqf
25
```
File: [client\Interactions\interactCombat.hpp at line 21](../../../Src/client/Interactions/interactCombat.hpp#L21)
## CS_SIZE_W

Type: constant

Description: ширина


Replaced value:
```sqf
30
```
File: [client\Interactions\interactCombat.hpp at line 23](../../../Src/client/Interactions/interactCombat.hpp#L23)
## TIME_TOLOAD_INTERACTCOMBAT

Type: constant

Description: 


Replaced value:
```sqf
0.05
```
File: [client\Interactions\interactCombat.hpp at line 26](../../../Src/client/Interactions/interactCombat.hpp#L26)
## TIME_TOUNLOAD_INTERACTCOMBAT

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Interactions\interactCombat.hpp at line 27](../../../Src/client/Interactions/interactCombat.hpp#L27)
## FADE_BUT_AT

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\Interactions\interactCombat.hpp at line 31](../../../Src/client/Interactions/interactCombat.hpp#L31)
## FADE_BUT_DEF

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\Interactions\interactCombat.hpp at line 32](../../../Src/client/Interactions/interactCombat.hpp#L32)
## FADE_BUT_CS

Type: constant

Description: 


Replaced value:
```sqf
0.8
```
File: [client\Interactions\interactCombat.hpp at line 33](../../../Src/client/Interactions/interactCombat.hpp#L33)
## TIME_BUT_AT

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactCombat.hpp at line 35](../../../Src/client/Interactions/interactCombat.hpp#L35)
## TIME_BUT_DEF

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactCombat.hpp at line 36](../../../Src/client/Interactions/interactCombat.hpp#L36)
## TIME_BUT_CS

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactCombat.hpp at line 37](../../../Src/client/Interactions/interactCombat.hpp#L37)
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
File: [client\Interactions\interactCombat.sqf at line 12](../../../Src/client/Interactions/interactCombat.sqf#L12)
## size_col

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactCombat.sqf at line 170](../../../Src/client/Interactions/interactCombat.sqf#L170)
## centerizeText(mes)

Type: constant

Description: 
- Param: mes

Replaced value:
```sqf
mes
```
File: [client\Interactions\interactCombat.sqf at line 171](../../../Src/client/Interactions/interactCombat.sqf#L171)
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
File: [client\Interactions\interactCombat.sqf at line 173](../../../Src/client/Interactions/interactCombat.sqf#L173)
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
File: [client\Interactions\interactCombat.sqf at line 179](../../../Src/client/Interactions/interactCombat.sqf#L179)
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
File: [client\Interactions\interactCombat.sqf at line 186](../../../Src/client/Interactions/interactCombat.sqf#L186)
## allocCombatStyle(pos,name,_mode)

Type: constant

Description: 
- Param: pos
- Param: name
- Param: _mode

Replaced value:
```sqf
\
		_butt = [_d,TEXT,pos,_ctg] call createWidget; \
		_butt setvariable ['mode',_mode]; \
		[_butt,name] call widgetSetText; \
		if (_mode == _curCSMode) then {_butt setFade FADE_BUT_CS; _butt commit 0; curWidgets set [CM_CUR_IND_CS,_butt]}; \
		_butt ctrlAddEventHandler ["MouseEnter",{ \
			params ["_but"]; _but setBackgroundColor [.15,.15,.15,.6]; \
		}]; \
		_butt ctrlAddEventHandler ["MouseExit",{ \
			params ["_but"]; _but setBackgroundColor [0,0,0,0]; \
		}]; \
		_butt ctrlAddEventHandler ["MouseButtonUp",interactCombat_onPressCS]; */
```
File: [client\Interactions\interactCombat.sqf at line 195](../../../Src/client/Interactions/interactCombat.sqf#L195)
## getMode(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid getVariable "mode"
```
File: [client\Interactions\interactCombat.sqf at line 289](../../../Src/client/Interactions/interactCombat.sqf#L289)
## interactCombat_initCombatStyles

Type: function

Description: 
- Param: _d
- Param: _pos
- Param: _index
- Param: _modeLoad (optional, default 0)

File: [client\Interactions\interactCombat.sqf at line 14](../../../Src/client/Interactions/interactCombat.sqf#L14)
## interactCombat_updateAttackTypes

Type: function

Description: 
- Param: _assocEnum (optional, default interactCombat_at_assocEnum)

File: [client\Interactions\interactCombat.sqf at line 71](../../../Src/client/Interactions/interactCombat.sqf#L71)
## interactCombat_load

Type: function

Description: 


File: [client\Interactions\interactCombat.sqf at line 158](../../../Src/client/Interactions/interactCombat.sqf#L158)
## interactCombat_onMouseMoving

Type: function

Description: Событие при движении мыши
- Param: _display

File: [client\Interactions\interactCombat.sqf at line 261](../../../Src/client/Interactions/interactCombat.sqf#L261)
## interactCombat_onPressCS

Type: function

Description: перегрузка метода принимет первый параметр как стиль
- Param: _ct
- Param: _butt

File: [client\Interactions\interactCombat.sqf at line 293](../../../Src/client/Interactions/interactCombat.sqf#L293)
## interactCombat_onPressDef

Type: function

Description: событие при нажатии на кнопку типа защиты
- Param: _ct
- Param: _butt

File: [client\Interactions\interactCombat.sqf at line 308](../../../Src/client/Interactions/interactCombat.sqf#L308)
## interactCombat_onPressAttType

Type: function

Description: событие при нажатии на кнопку типа атаки
- Param: _ct
- Param: _butt

File: [client\Interactions\interactCombat.sqf at line 330](../../../Src/client/Interactions/interactCombat.sqf#L330)
# interactCombat_defines.sqf

## addCStyle(_color,name,nameranged,_enum)

Type: constant

Description: 0 handed,1 shooting
- Param: _color
- Param: name
- Param: nameranged
- Param: _enum

Replaced value:
```sqf
['name','_color',_enum,'nameranged']
```
File: [client\Interactions\interactCombat_defines.sqf at line 12](../../../Src/client/Interactions/interactCombat_defines.sqf#L12)
# interactEmoteMenu.sqf

## INTERACT_EMOTE_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\Interactions\interactEmoteMenu.sqf at line 17](../../../Src/client/Interactions/interactEmoteMenu.sqf#L17)
## INTERACT_EMOTE_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\Interactions\interactEmoteMenu.sqf at line 18](../../../Src/client/Interactions/interactEmoteMenu.sqf#L18)
## interactEmote_load

Type: function

Description: 
- Param: 
- Param: _key

File: [client\Interactions\interactEmoteMenu.sqf at line 24](../../../Src/client/Interactions/interactEmoteMenu.sqf#L24)
## interactEmote_onListCategoryes

Type: function

Description: открыть лист категорий
- Param: _mode

File: [client\Interactions\interactEmoteMenu.sqf at line 164](../../../Src/client/Interactions/interactEmoteMenu.sqf#L164)
## interactEmote_cleanupInputText

Type: function

Description: 


File: [client\Interactions\interactEmoteMenu.sqf at line 230](../../../Src/client/Interactions/interactEmoteMenu.sqf#L230)
## interactEmote_getInputTextParams

Type: function

Description: Получение виджета инпута и текста в нём


File: [client\Interactions\interactEmoteMenu.sqf at line 236](../../../Src/client/Interactions/interactEmoteMenu.sqf#L236)
## interactEmote_handleInputText

Type: function

Description: Обработчик строки инпута. Возврат bool значений означает ошибку текста
- Param: _text

File: [client\Interactions\interactEmoteMenu.sqf at line 242](../../../Src/client/Interactions/interactEmoteMenu.sqf#L242)
## interactEmote_onSendEmote

Type: function

Description: 
- Param: _text

File: [client\Interactions\interactEmoteMenu.sqf at line 290](../../../Src/client/Interactions/interactEmoteMenu.sqf#L290)
## interactEmote_onMouseMoving

Type: function

Description: 
- Param: _display

File: [client\Interactions\interactEmoteMenu.sqf at line 305](../../../Src/client/Interactions/interactEmoteMenu.sqf#L305)
## interactEmote_switchActionMenu

Type: function

Description: 
- Param: _mode
- Param: _isSetMode (optional, default false)

File: [client\Interactions\interactEmoteMenu.sqf at line 329](../../../Src/client/Interactions/interactEmoteMenu.sqf#L329)
## interactEmote_loadActions

Type: function

Description: 


File: [client\Interactions\interactEmoteMenu.sqf at line 349](../../../Src/client/Interactions/interactEmoteMenu.sqf#L349)
## interactEmote_doEmoteAction

Type: function

Description: Отправка эмоута
- Param: _act

File: [client\Interactions\interactEmoteMenu.sqf at line 425](../../../Src/client/Interactions/interactEmoteMenu.sqf#L425)
## interactEmote_unloadActions

Type: function

Description: 
- Param: _acts

File: [client\Interactions\interactEmoteMenu.sqf at line 447](../../../Src/client/Interactions/interactEmoteMenu.sqf#L447)
# interactMenu.hpp

## SIZE_HITPART_ZONE

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interactMenu.hpp at line 8](../../../Src/client/Interactions/interactMenu.hpp#L8)
## map_hit(x,y)

Type: constant

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
[x,y,32,SIZE_HITPART_ZONE]
```
File: [client\Interactions\interactMenu.hpp at line 10](../../../Src/client/Interactions/interactMenu.hpp#L10)
## map_zonenames

Type: constant

Description: 


Replaced value:
```sqf
["Голова","Лицо","Рот","Шея","Торс","Живот","Пах"]
```
File: [client\Interactions\interactMenu.hpp at line 12](../../../Src/client/Interactions/interactMenu.hpp#L12)
## map_zoneindex

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_HEAD,TARGET_ZONE_FACE,TARGET_ZONE_MOUTH,TARGET_ZONE_NECK,TARGET_ZONE_TORSO,TARGET_ZONE_ABDOMEN,TARGET_ZONE_GROIN]
```
File: [client\Interactions\interactMenu.hpp at line 13](../../../Src/client/Interactions/interactMenu.hpp#L13)
## map_limbs

Type: constant

Description: 


Replaced value:
```sqf
[TARGET_ZONE_EYE_L,TARGET_ZONE_EYE_R,TARGET_ZONE_ARM_L,TARGET_ZONE_ARM_R,TARGET_ZONE_LEG_L,TARGET_ZONE_LEG_R]
```
File: [client\Interactions\interactMenu.hpp at line 15](../../../Src/client/Interactions/interactMenu.hpp#L15)
## CALLING_IN_DISPLAY_MODE

Type: constant

Description: 


Replaced value:
```sqf
true
```
File: [client\Interactions\interactMenu.hpp at line 17](../../../Src/client/Interactions/interactMenu.hpp#L17)
## TIME_TOLOAD_INTERACTMENU

Type: constant

Description: 


Replaced value:
```sqf
TIME_PREPARE_SLOTS
```
File: [client\Interactions\interactMenu.hpp at line 19](../../../Src/client/Interactions/interactMenu.hpp#L19)
## TIME_TOUNLOAD_INTERACTMENU

Type: constant

Description: 


Replaced value:
```sqf
TIME_PREPARE_SLOTS
```
File: [client\Interactions\interactMenu.hpp at line 20](../../../Src/client/Interactions/interactMenu.hpp#L20)
## FADEIN_SPECACT

Type: constant

Description: 


Replaced value:
```sqf
0.7
```
File: [client\Interactions\interactMenu.hpp at line 22](../../../Src/client/Interactions/interactMenu.hpp#L22)
## FADE_TIME

Type: constant

Description: 


Replaced value:
```sqf
0.1
```
File: [client\Interactions\interactMenu.hpp at line 23](../../../Src/client/Interactions/interactMenu.hpp#L23)
## FADE_FOR_SELECTED

Type: constant

Description: 


Replaced value:
```sqf
0.6
```
File: [client\Interactions\interactMenu.hpp at line 25](../../../Src/client/Interactions/interactMenu.hpp#L25)
## TIME_TO_INFADE

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Interactions\interactMenu.hpp at line 26](../../../Src/client/Interactions/interactMenu.hpp#L26)
## ACTION_SWITCHABLE

Type: constant

Description: типы действий. ACTION_SWITCHABLE - переключаемое, ACTION_PLAYING - проигрываемое


Replaced value:
```sqf
0
```
File: [client\Interactions\interactMenu.hpp at line 29](../../../Src/client/Interactions/interactMenu.hpp#L29)
## ACTION_PLAYING

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\Interactions\interactMenu.hpp at line 30](../../../Src/client/Interactions/interactMenu.hpp#L30)
# interactMenu.sqf

## DEBUG_USE_BORDERS

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interactMenu.sqf at line 16](../../../Src/client/Interactions/interactMenu.sqf#L16)
## debug_colorize(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor [random 1,random 1,random 1,1]
```
File: [client\Interactions\interactMenu.sqf at line 18](../../../Src/client/Interactions/interactMenu.sqf#L18)
## debug_colorizeButton(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor  [random 1,random 1,random 1,1]
```
File: [client\Interactions\interactMenu.sqf at line 19](../../../Src/client/Interactions/interactMenu.sqf#L19)
## colorizeCategory(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor [.3,.3,.3,.7]
```
File: [client\Interactions\interactMenu.sqf at line 21](../../../Src/client/Interactions/interactMenu.sqf#L21)
## colorizeButton(wid)

Type: constant

Description: 
- Param: wid

Replaced value:
```sqf
wid setBackgroundColor [.1,.1,.1,.7]
```
File: [client\Interactions\interactMenu.sqf at line 22](../../../Src/client/Interactions/interactMenu.sqf#L22)
## setButtonText(wid,text)

Type: constant

Description: setting text for attr (skill)
- Param: wid
- Param: text

Replaced value:
```sqf
wid ctrlSetStructuredText (parseText format["<t size='0.8' align='center' valign='middle'>%1</t>" arg text])
```
File: [client\Interactions\interactMenu.sqf at line 25](../../../Src/client/Interactions/interactMenu.sqf#L25)
## setCategText(wid,text)

Type: constant

Description: 
- Param: wid
- Param: text

Replaced value:
```sqf
wid ctrlSetStructuredText (parseText format ["<t size='0.8' align='center' valign='middle'>%1</t>" arg text])
```
File: [client\Interactions\interactMenu.sqf at line 26](../../../Src/client/Interactions/interactMenu.sqf#L26)
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
File: [client\Interactions\interactMenu.sqf at line 27](../../../Src/client/Interactions/interactMenu.sqf#L27)
## setText(wid,text)

Type: constant

Description: 
- Param: wid
- Param: text

Replaced value:
```sqf
[wid,text] call widgetSetText
```
File: [client\Interactions\interactMenu.sqf at line 28](../../../Src/client/Interactions/interactMenu.sqf#L28)
## WIDTH_ATTR

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\Interactions\interactMenu.sqf at line 30](../../../Src/client/Interactions/interactMenu.sqf#L30)
## HEIGHT_CATEGORY

Type: constant

Description: 


Replaced value:
```sqf
2.5
```
File: [client\Interactions\interactMenu.sqf at line 31](../../../Src/client/Interactions/interactMenu.sqf#L31)
## SIZE_INTENT_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\interactMenu.sqf at line 32](../../../Src/client/Interactions/interactMenu.sqf#L32)
## STD_BIAS_Y

Type: constant

Description: 


Replaced value:
```sqf
1.5
```
File: [client\Interactions\interactMenu.sqf at line 33](../../../Src/client/Interactions/interactMenu.sqf#L33)
## STD_BIAS_X

Type: constant

Description: 


Replaced value:
```sqf
1.5
```
File: [client\Interactions\interactMenu.sqf at line 34](../../../Src/client/Interactions/interactMenu.sqf#L34)
## createText(sizes)

Type: constant

Description: 
- Param: sizes

Replaced value:
```sqf
[_d,TEXT,sizes,_ctg] call createWidget
```
File: [client\Interactions\interactMenu.sqf at line 50](../../../Src/client/Interactions/interactMenu.sqf#L50)
## createButton(sizes)

Type: constant

Description: 
- Param: sizes

Replaced value:
```sqf
[_d,BUTTONMENU,sizes,_ctg] call createWidget
```
File: [client\Interactions\interactMenu.sqf at line 51](../../../Src/client/Interactions/interactMenu.sqf#L51)
## createSpecButton(sizes)

Type: constant

Description: 
- Param: sizes

Replaced value:
```sqf
[_d,BUTTONMENU,sizes,_ctgSpec] call createWidget
```
File: [client\Interactions\interactMenu.sqf at line 52](../../../Src/client/Interactions/interactMenu.sqf#L52)
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
File: [client\Interactions\interactMenu.sqf at line 54](../../../Src/client/Interactions/interactMenu.sqf#L54)
## MAX_SELECTIONS_TODOWN

Type: constant

Description: 


Replaced value:
```sqf
6
```
File: [client\Interactions\interactMenu.sqf at line 159](../../../Src/client/Interactions/interactMenu.sqf#L159)
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
File: [client\Interactions\interactMenu.sqf at line 161](../../../Src/client/Interactions/interactMenu.sqf#L161)
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
File: [client\Interactions\interactMenu.sqf at line 165](../../../Src/client/Interactions/interactMenu.sqf#L165)
## _specact_bias_x

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\Interactions\interactMenu.sqf at line 290](../../../Src/client/Interactions/interactMenu.sqf#L290)
## _specact_bias_y

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\Interactions\interactMenu.sqf at line 291](../../../Src/client/Interactions/interactMenu.sqf#L291)
## _specact_size_h

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\Interactions\interactMenu.sqf at line 292](../../../Src/client/Interactions/interactMenu.sqf#L292)
## interactMenu_load

Type: function

Description: 


File: [client\Interactions\interactMenu.sqf at line 40](../../../Src/client/Interactions/interactMenu.sqf#L40)
## interactMenu_onMouseMove

Type: function

Description: 
- Param: _display
- Param: _xPos
- Param: _yPos

File: [client\Interactions\interactMenu.sqf at line 245](../../../Src/client/Interactions/interactMenu.sqf#L245)
## interactMenu_unloadMenu

Type: function

Description: 


File: [client\Interactions\interactMenu.sqf at line 264](../../../Src/client/Interactions/interactMenu.sqf#L264)
## interactMenu_syncSpecialActions

Type: function

Description: 
- Param: _isInit (optional, default true)

File: [client\Interactions\interactMenu.sqf at line 272](../../../Src/client/Interactions/interactMenu.sqf#L272)
# interactMenu_defines.sqf

## INT_PATH(pt)

Type: constant

Description: 
- Param: pt

Replaced value:
```sqf
(PATH_PICTURE_FOLDER + "interact\" + 'pt' + ".paa" )
```
File: [client\Interactions\interactMenu_defines.sqf at line 17](../../../Src/client/Interactions/interactMenu_defines.sqf#L17)
# interactMenu_functions.sqf

## interactMenu_onUpdateSkills

Type: function

Description: 


File: [client\Interactions\interactMenu_functions.sqf at line 9](../../../Src/client/Interactions/interactMenu_functions.sqf#L9)
## interactMenu_getMemories

Type: function

Description: Запрос на получение воспоминаний
- Param: _mode

File: [client\Interactions\interactMenu_functions.sqf at line 34](../../../Src/client/Interactions/interactMenu_functions.sqf#L34)
## interactMenu_setSelection

Type: function

Description: 
- Param: _id
- Param: _button

File: [client\Interactions\interactMenu_functions.sqf at line 47](../../../Src/client/Interactions/interactMenu_functions.sqf#L47)
## interactMenu_syncCurSelection

Type: function

Description: 


File: [client\Interactions\interactMenu_functions.sqf at line 60](../../../Src/client/Interactions/interactMenu_functions.sqf#L60)
## interactMenu_onPressSpecAct

Type: function

Description: 
- Param: _ct
- Param: _butt

File: [client\Interactions\interactMenu_functions.sqf at line 84](../../../Src/client/Interactions/interactMenu_functions.sqf#L84)
# interact_component_shared.hpp

## getObjReference(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(obj getVariable ["ref","noref"])
```
File: [client\Interactions\interact_component_shared.hpp at line 7](../../../Src/client/Interactions/interact_component_shared.hpp#L7)
## getObjReferenceWithMob(obj)

Type: constant

Description: 
- Param: obj

Replaced value:
```sqf
(if (typeof obj == BASIC_MOB_TYPE) then {obj} else {getObjReference(obj)})
```
File: [client\Interactions\interact_component_shared.hpp at line 9](../../../Src/client/Interactions/interact_component_shared.hpp#L9)
# interact_deprecated.sqf

## nonSee(ind)

Type: constant

Description: 
- Param: ind

Replaced value:
```sqf
_pass##ind
```
File: [client\Interactions\interact_deprecated.sqf at line 61](../../../Src/client/Interactions/interact_deprecated.sqf#L61)
## useviswidgets

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interact_deprecated.sqf at line 93](../../../Src/client/Interactions/interact_deprecated.sqf#L93)
## mlp(selection)

Type: constant

Description: 
- Param: selection

Replaced value:
```sqf
#selection
```
File: [client\Interactions\interact_deprecated.sqf at line 196](../../../Src/client/Interactions/interact_deprecated.sqf#L196)
## DEBUG_ALLOW_DRAW_BBX

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interact_deprecated.sqf at line 252](../../../Src/client/Interactions/interact_deprecated.sqf#L252)
## DEBUG_DRAW_BBX_DISTANCE

Type: constant

Description: #define DEBUG_ALLOW_DRAW_BBX


Replaced value:
```sqf
10
```
File: [client\Interactions\interact_deprecated.sqf at line 253](../../../Src/client/Interactions/interact_deprecated.sqf#L253)
## interact_canHandReach

Type: function

Description: позиция достаточно близка чтобы тронуть рукой
- Param: _pos2
- Param: _dopDist (optional, default 0)

File: [client\Interactions\interact_deprecated.sqf at line 10](../../../Src/client/Interactions/interact_deprecated.sqf#L10)
## interact_canSeeObject

Type: function

Description: видно ли объект


File: [client\Interactions\interact_deprecated.sqf at line 28](../../../Src/client/Interactions/interact_deprecated.sqf#L28)
## interact_canSeeMob_handReach

Type: function

Description: #define useviswidgets
- Param: _target

File: [client\Interactions\interact_deprecated.sqf at line 95](../../../Src/client/Interactions/interact_deprecated.sqf#L95)
## interact_findNearPosMob

Type: function

Description: 
- Param: _mx
- Param: _my

File: [client\Interactions\interact_deprecated.sqf at line 194](../../../Src/client/Interactions/interact_deprecated.sqf#L194)
## interact_debug_drawBBX

Type: function

> Exists if **DEBUG_ALLOW_DRAW_BBX** defined

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 260](../../../Src/client/Interactions/interact_deprecated.sqf#L260)
## interact_debug_unboxDecal

Type: function

> Exists if **DEBUG_ALLOW_DRAW_BBX** defined

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 265](../../../Src/client/Interactions/interact_deprecated.sqf#L265)
## interact_debug_internal_drawBBXObject

Type: function

> Exists if **DEBUG_ALLOW_DRAW_BBX** defined

Description: 


File: [client\Interactions\interact_deprecated.sqf at line 270](../../../Src/client/Interactions/interact_deprecated.sqf#L270)
# interact_examine.sqf

## interact_examine

Type: function

Description: 


File: [client\Interactions\interact_examine.sqf at line 8](../../../Src/client/Interactions/interact_examine.sqf#L8)
## interact_pointTo

Type: function

Description: 


File: [client\Interactions\interact_examine.sqf at line 19](../../../Src/client/Interactions/interact_examine.sqf#L19)
# interact_grabbing.sqf

## INTERACT_GRAB_UPDATE_DELAY

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\Interactions\interact_grabbing.sqf at line 7](../../../Src/client/Interactions/interact_grabbing.sqf#L7)
## interact_grab_start

Type: function

Description: 
- Param: _src
- Param: _sidePos
- Param: _vDir
- Param: _sideIdx

File: [client\Interactions\interact_grabbing.sqf at line 16](../../../Src/client/Interactions/interact_grabbing.sqf#L16)
## interact_grab_onUpdate

Type: function

Description: 
- Param: _src
- Param: _sidePos
- Param: _vDir

File: [client\Interactions\interact_grabbing.sqf at line 26](../../../Src/client/Interactions/interact_grabbing.sqf#L26)
## interact_grab_stop

Type: function

Description: 
- Param: _idx

File: [client\Interactions\interact_grabbing.sqf at line 60](../../../Src/client/Interactions/interact_grabbing.sqf#L60)
# interact_mainhandle.sqf

## __log_mainhandle

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\interact_mainhandle.sqf at line 9](../../../Src/client/Interactions/interact_mainhandle.sqf#L9)
## ON_FINALIZE(reason)

Type: constant

> Exists if **__log_mainhandle** defined

Description: 
- Param: reason

Replaced value:
```sqf
warningformat("Abort - %1",reason);interact_mainHandleLock = true; nextFrame(_codeExit)
```
File: [client\Interactions\interact_mainhandle.sqf at line 16](../../../Src/client/Interactions/interact_mainhandle.sqf#L16)
## ON_FINALIZE(reason)

Type: constant

> Exists if **__log_mainhandle** not defined

Description: 
- Param: reason

Replaced value:
```sqf
interact_mainHandleLock = true;nextFrame(_codeExit)
```
File: [client\Interactions\interact_mainhandle.sqf at line 18](../../../Src/client/Interactions/interact_mainhandle.sqf#L18)
## checkExiter()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
if (_exiter) exitWith {}
```
File: [client\Interactions\interact_mainhandle.sqf at line 28](../../../Src/client/Interactions/interact_mainhandle.sqf#L28)
## setExiter(mode)

Type: constant

Description: 
- Param: mode

Replaced value:
```sqf
_exiter = mode
```
File: [client\Interactions\interact_mainhandle.sqf at line 29](../../../Src/client/Interactions/interact_mainhandle.sqf#L29)
# interact_resist.sqf

## interact_processResist

Type: function

Description: 


File: [client\Interactions\interact_resist.sqf at line 7](../../../Src/client/Interactions/interact_resist.sqf#L7)
# progress.sqf

## PROGRESS_DEBUG

Type: constant

Description: 


Replaced value:
```sqf

```
File: [client\Interactions\progress.sqf at line 7](../../../Src/client/Interactions/progress.sqf#L7)
## SIZEPROG

Type: constant

Description: #define PROGRESS_DEBUG


Replaced value:
```sqf
15
```
File: [client\Interactions\progress.sqf at line 9](../../../Src/client/Interactions/progress.sqf#L9)
## ONEPERCENTSIZE

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\progress.sqf at line 10](../../../Src/client/Interactions/progress.sqf#L10)
## PROGRADIUSPERCENT

Type: constant

Description: 


Replaced value:
```sqf
40
```
File: [client\Interactions\progress.sqf at line 11](../../../Src/client/Interactions/progress.sqf#L11)
## PROGRESS_MAX_DISTANCE_FALLDOWN

Type: constant

Description: 


Replaced value:
```sqf
0.2
```
File: [client\Interactions\progress.sqf at line 13](../../../Src/client/Interactions/progress.sqf#L13)
## PROGRESS_DISTANCE_TARGET_FALLDOWN

Type: constant

Description: 


Replaced value:
```sqf
0.01
```
File: [client\Interactions\progress.sqf at line 14](../../../Src/client/Interactions/progress.sqf#L14)
## TIME_TO_OUTFADE_PROGRESS

Type: constant

Description: 


Replaced value:
```sqf
0.000006
```
File: [client\Interactions\progress.sqf at line 17](../../../Src/client/Interactions/progress.sqf#L17)
## TIME_TO_SUCCESS_PROGRESS

Type: constant

Description: 


Replaced value:
```sqf
0.00003
```
File: [client\Interactions\progress.sqf at line 18](../../../Src/client/Interactions/progress.sqf#L18)
## TIME_TO_ABORT_PROGRESS

Type: constant

Description: 


Replaced value:
```sqf
0.00001
```
File: [client\Interactions\progress.sqf at line 19](../../../Src/client/Interactions/progress.sqf#L19)
## ROUNDSTEP

Type: constant

Description: 


Replaced value:
```sqf
10
```
File: [client\Interactions\progress.sqf at line 21](../../../Src/client/Interactions/progress.sqf#L21)
## ROUNDCOUNT

Type: constant

Description: 


Replaced value:
```sqf
(360 / ROUNDSTEP)
```
File: [client\Interactions\progress.sqf at line 22](../../../Src/client/Interactions/progress.sqf#L22)
## override_setpos_precent_w(h_value)

Type: constant

Description: 
- Param: h_value

Replaced value:
```sqf
transformSizeByAR(h_value)
```
File: [client\Interactions\progress.sqf at line 24](../../../Src/client/Interactions/progress.sqf#L24)
## interact_progress_countItms

Type: constant

Description: 


Replaced value:
```sqf
90
```
File: [client\Interactions\progress.sqf at line 33](../../../Src/client/Interactions/progress.sqf#L33)
## MAX_ALLOW_DISTANCE_CAM_OFFSET

Type: constant

Description: interact_progress_lastPlayerDir = 0;


Replaced value:
```sqf
0.01
```
File: [client\Interactions\progress.sqf at line 42](../../../Src/client/Interactions/progress.sqf#L42)
## interact_progress_checkActivity

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 94](../../../Src/client/Interactions/progress.sqf#L94)
## interact_progress_start

Type: function

Description: Запуск функции прогресса
- Param: _duration

File: [client\Interactions\progress.sqf at line 120](../../../Src/client/Interactions/progress.sqf#L120)
## interact_progress_onUpdate

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 141](../../../Src/client/Interactions/progress.sqf#L141)
## interact_progress_success

Type: function

Description: Прогресс выполнен


File: [client\Interactions\progress.sqf at line 170](../../../Src/client/Interactions/progress.sqf#L170)
## interact_progress_stop

Type: function

Description: Остановка прогресса
- Param: _sendToServerCancellationToken (optional, default false)
- Param: _fadeValue (optional, default 0)

File: [client\Interactions\progress.sqf at line 176](../../../Src/client/Interactions/progress.sqf#L176)
## interact_progress_init

Type: function

Description: initializer progress
- Param: _rs
- Param: _gs
- Param: _bs

File: [client\Interactions\progress.sqf at line 203](../../../Src/client/Interactions/progress.sqf#L203)
## interact_progress_applyColorTheme

Type: function

Description: 


File: [client\Interactions\progress.sqf at line 248](../../../Src/client/Interactions/progress.sqf#L248)
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
File: [client\Interactions\verbs.sqf at line 10](../../../Src/client/Interactions/verbs.sqf#L10)
## TIME_FADEIN_VERBMENU

Type: constant

Description: 


Replaced value:
```sqf
0.15
```
File: [client\Interactions\verbs.sqf at line 11](../../../Src/client/Interactions/verbs.sqf#L11)
## SIZE_WIND_W

Type: constant

Description: 


Replaced value:
```sqf
15
```
File: [client\Interactions\verbs.sqf at line 97](../../../Src/client/Interactions/verbs.sqf#L97)
## SIZE_WIND_H

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\Interactions\verbs.sqf at line 98](../../../Src/client/Interactions/verbs.sqf#L98)
## SIZE_BUTTON

Type: constant

Description: 


Replaced value:
```sqf
20
```
File: [client\Interactions\verbs.sqf at line 99](../../../Src/client/Interactions/verbs.sqf#L99)
## ON_FINALIZE(reason)

Type: constant

> Exists if **DEBUG** defined

Description: 
- Param: reason

Replaced value:
```sqf
warningformat("verb::onPickVerb() - Reason to closed: %1",reason);nextFrame(verb_unloadMenu)
```
File: [client\Interactions\verbs.sqf at line 186](../../../Src/client/Interactions/verbs.sqf#L186)
## ON_FINALIZE(reason)

Type: constant

> Exists if **DEBUG** not defined

Description: 
- Param: reason

Replaced value:
```sqf
nextFrame(verb_unloadMenu)
```
File: [client\Interactions\verbs.sqf at line 188](../../../Src/client/Interactions/verbs.sqf#L188)
## ON_FINALIZE(reason)

Type: constant

Description: 
- Param: reason

Replaced value:
```sqf
nextFrame(verb_unloadMenu)
```
File: [client\Interactions\verbs.sqf at line 190](../../../Src/client/Interactions/verbs.sqf#L190)
## interact_onLoadVerbs

Type: function

Description: 
- Param: _targetName
- Param: _verbList
- Param: _targetHash

File: [client\Interactions\verbs.sqf at line 13](../../../Src/client/Interactions/verbs.sqf#L13)
## verb_internal_checkBind

Type: function

Description: Проверка бинда и возвращение доп постфикса
- Param: _intorstr

File: [client\Interactions\verbs.sqf at line 70](../../../Src/client/Interactions/verbs.sqf#L70)
## verb_translate

Type: function

Description: 
- Param: _verb

File: [client\Interactions\verbs.sqf at line 82](../../../Src/client/Interactions/verbs.sqf#L82)
## verb_loadMenu

Type: function

Description: 
- Param: _translateList
- Param: _verbList
- Param: _targetName
- Param: _isInInventory (optional, default false)

File: [client\Interactions\verbs.sqf at line 94](../../../Src/client/Interactions/verbs.sqf#L94)
## verb_onPickVerb

Type: function

Description: Событие которое возникает при нажатии на кнопку действия
- Param: _control

File: [client\Interactions\verbs.sqf at line 182](../../../Src/client/Interactions/verbs.sqf#L182)
## verb_resetDataForND

Type: function

Description: 


File: [client\Interactions\verbs.sqf at line 223](../../../Src/client/Interactions/verbs.sqf#L223)
## verb_unloadMenu

Type: function

Description: 


File: [client\Interactions\verbs.sqf at line 232](../../../Src/client/Interactions/verbs.sqf#L232)
## verb_setHideInventory

Type: function

Description: 
- Param: _mode
- Param: _closeFlag (optional, default false)

File: [client\Interactions\verbs.sqf at line 256](../../../Src/client/Interactions/verbs.sqf#L256)
## isInsideVerbMenu

Type: function

Description: 


File: [client\Interactions\verbs.sqf at line 299](../../../Src/client/Interactions/verbs.sqf#L299)
