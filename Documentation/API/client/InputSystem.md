# InputAssoc.sqf

## bindKey(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
input_map_keyName set [name,val];
```
File: [client\InputSystem\InputAssoc.sqf at line 18](../../../Src/client/InputSystem/InputAssoc.sqf#L18)
## mouse_key_prefix

Type: constant

Description: 


Replaced value:
```sqf
"@"
```
File: [client\InputSystem\InputAssoc.sqf at line 20](../../../Src/client/InputSystem/InputAssoc.sqf#L20)
## bindMouse(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
bindKey(mouse_key_prefix  + name,val)
```
File: [client\InputSystem\InputAssoc.sqf at line 22](../../../Src/client/InputSystem/InputAssoc.sqf#L22)
## input_map_keyName

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\InputSystem\InputAssoc.sqf at line 13](../../../Src/client/InputSystem/InputAssoc.sqf#L13)
## input_keyList_reversedAssoc

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\InputSystem\InputAssoc.sqf at line 15](../../../Src/client/InputSystem/InputAssoc.sqf#L15)
## input_getKeyValue

Type: function

Description: 
- Param: _str
- Param: _isMouse

File: [client\InputSystem\InputAssoc.sqf at line 196](../../../Src/client/InputSystem/InputAssoc.sqf#L196)
## input_getAllKeyNames

Type: function

Description: 
- Param: _idx

File: [client\InputSystem\InputAssoc.sqf at line 212](../../../Src/client/InputSystem/InputAssoc.sqf#L212)
# inputHelper.sqf

## INPUTHELPER_WIDGET_SIZE_W

Type: constant

Description: 


Replaced value:
```sqf
30
```
File: [client\InputSystem\inputHelper.sqf at line 15](../../../Src/client/InputSystem/inputHelper.sqf#L15)
## INPUTHELPER_WIDGET_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
13
```
File: [client\InputSystem\inputHelper.sqf at line 17](../../../Src/client/InputSystem/inputHelper.sqf#L17)
## inputHelper_enabled

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\InputSystem\inputHelper.sqf at line 20](../../../Src/client/InputSystem/inputHelper.sqf#L20)
## inputHelper_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\InputSystem\inputHelper.sqf at line 23](../../../Src/client/InputSystem/inputHelper.sqf#L23)
## inputHelper_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\InputSystem\inputHelper.sqf at line 25](../../../Src/client/InputSystem/inputHelper.sqf#L25)
## inputHelper_firstRunTaskId

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\InputSystem\inputHelper.sqf at line 27](../../../Src/client/InputSystem/inputHelper.sqf#L27)
## inputHelper_isSuccessCurrentTask

Type: Variable

Description: 


Initial value:
```sqf
false //системная переменная для выполнения внутренней задачи
```
File: [client\InputSystem\inputHelper.sqf at line 30](../../../Src/client/InputSystem/inputHelper.sqf#L30)
## inputHelper_basicTask

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\InputSystem\inputHelper.sqf at line 34](../../../Src/client/InputSystem/inputHelper.sqf#L34)
## inputHelper_init

Type: function

Description: 


File: [client\InputSystem\inputHelper.sqf at line 43](../../../Src/client/InputSystem/inputHelper.sqf#L43)
## inputHelper_showNotification

Type: function

Description: 
- Param: _text
- Param: _timeOrCode

File: [client\InputSystem\inputHelper.sqf at line 74](../../../Src/client/InputSystem/inputHelper.sqf#L74)
## inputHelper_internal_sortWidgets

Type: function

Description: 


File: [client\InputSystem\inputHelper.sqf at line 95](../../../Src/client/InputSystem/inputHelper.sqf#L95)
# inputKeyHandlers.hpp

## KEYBIND_INDEX_NAME

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 12](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L12)
## KEYBIND_INDEX_DESC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 13](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L13)
## KEYBIND_INDEX_CURRENT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 14](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L14)
## KEYBIND_INDEX_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 15](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L15)
## KEYBIND_INDEX_VARNAME

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 16](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L16)
## KEYBIND_INDEX_SERIALIZED

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 17](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L17)
## KEYDATA_INDEX_KEY

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 22](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L22)
## KEYDATA_INDEX_SHIFT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 23](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L23)
## KEYDATA_INDEX_CTRL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 24](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L24)
## KEYDATA_INDEX_ALT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 25](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L25)
## KEYDATA_INDEX_ISMOUSE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 26](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L26)
## unpackKeyData(_dat)

Type: constant

Description: 
- Param: _dat

Replaced value:
```sqf
_dat select [1,4]
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 31](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L31)
## doPrepareKeyData(pars)

Type: constant

Description: 
- Param: pars

Replaced value:
```sqf
input__ikdp = unpackKeyData(pars)
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 34](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L34)
## isPressedKey(_key,variable)

Type: constant

Description: 
- Param: _key
- Param: variable

Replaced value:
```sqf
([_key,variable,true] call input_checkKeyState)
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 38](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L38)
## isPressed(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
isPressedKey(input__ikdp,var)
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 38](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L38)
# inputKeyHandlers.sqf

## kb(name,desc,defkey,varname)

Type: constant

Description: 
- Param: name
- Param: desc
- Param: defkey
- Param: varname

Replaced value:
```sqf
[name,desc,defkey,defkey,call{missionnamespace setvariable [varname,defkey]; varname},defkey]
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 16](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L16)
## keybind(value,shift,ctrl,alt,isMouse)

Type: constant

Description: 
- Param: value
- Param: shift
- Param: ctrl
- Param: alt
- Param: isMouse

Replaced value:
```sqf
[value,shift,ctrl,alt,isMouse]
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 18](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L18)
## std_key(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
keybind([name arg false] call input_getKeyValue,false,false,false,false)
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 21](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L21)
## std_keyArgs(name,shift,ctrl,alt,isMouse)

Type: constant

Description: 
- Param: name
- Param: shift
- Param: ctrl
- Param: alt
- Param: isMouse

Replaced value:
```sqf
keybind([name arg false] call input_getKeyValue,shift,ctrl,alt,isMouse)
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 23](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L23)
## input__ikdp

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 11](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L11)
## cd_settingsKeyboard

Type: Variable

Description: 


Initial value:
```sqf
[...
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 27](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L27)
## input_internal_map_act2kb

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 53](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L53)
## input_map_spamProtect

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 137](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L137)
## input_updateAllKeyBinds

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 59](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L59)
## input_internal_onLoadKeyBinds

Type: function

Description: 
- Param: _kbList

File: [client\InputSystem\inputKeyHandlers.sqf at line 79](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L79)
## input_checkKeyState

Type: function

Description: 
- Param: _keyData
- Param: _state
- Param: _doRemKeyState (optional, default false)

File: [client\InputSystem\inputKeyHandlers.sqf at line 120](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L120)
## input_spamProtect

Type: function

Description: 
- Param: _strname
- Param: _timeout (optional, default 0.3)

File: [client\InputSystem\inputKeyHandlers.sqf at line 140](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L140)
## input_passThroughWallsProtect

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 158](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L158)
## input_movementCheck

Type: function

Description: 
- Param: _key

File: [client\InputSystem\inputKeyHandlers.sqf at line 175](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L175)
## input_internal_isChangeStance

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 247](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L247)
## input_internal_isMovingButton

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 249](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L249)
## input_internal_isMovingForward

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 251](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L251)
## input_getKeyNameByInputName

Type: function

Description: 
- Param: _inp

File: [client\InputSystem\inputKeyHandlers.sqf at line 254](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L254)
# inputManager.sqf

## isPressed(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
isPressedKey(_kupc,var)
```
File: [client\InputSystem\inputManager.sqf at line 78](../../../Src/client/InputSystem/inputManager.sqf#L78)
## attr

Type: constant

> Exists if **DEBUG** defined

Description: };


Replaced value:
```sqf
([#st,#ht,#dx,#iq,#fp,#will,#per,#hp] select ind_stat)
```
File: [client\InputSystem\inputManager.sqf at line 154](../../../Src/client/InputSystem/inputManager.sqf#L154)
## dbg_addAtr(name,amount)

Type: constant

> Exists if **DEBUG** defined

Description: 
- Param: name
- Param: amount

Replaced value:
```sqf
[(player),amount] call ((player) getVariable 'proto' getVariable ('add'+ name))
```
File: [client\InputSystem\inputManager.sqf at line 155](../../../Src/client/InputSystem/inputManager.sqf#L155)
## onGameInputs_Down

Type: function

Description: 
- Param: 
- Param: _key
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\InputSystem\inputManager.sqf at line 12](../../../Src/client/InputSystem/inputManager.sqf#L12)
## onGameKeyInputs

Type: function

Description: 
- Param: 
- Param: _key
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\InputSystem\inputManager.sqf at line 59](../../../Src/client/InputSystem/inputManager.sqf#L59)
## onGameMouseInputs

Type: function

Description: 
- Param: 
- Param: _button
- Param: 
- Param: 
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\InputSystem\inputManager.sqf at line 185](../../../Src/client/InputSystem/inputManager.sqf#L185)
# input_init.sqf

## input_catchedEscape

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\InputSystem\input_init.sqf at line 23](../../../Src/client/InputSystem/input_init.sqf#L23)
## input_internal_handleNativeEsc

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\InputSystem\input_init.sqf at line 29](../../../Src/client/InputSystem/input_init.sqf#L29)
