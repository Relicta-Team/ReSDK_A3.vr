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
File: [client\InputSystem\InputAssoc.sqf at line 13](../../../Src/client/InputSystem/InputAssoc.sqf#L13)
## bindMouse(name,val)

Type: constant

Description: 
- Param: name
- Param: val

Replaced value:
```sqf
bindKey(mouse_key_prefix  + name,val)
```
File: [client\InputSystem\InputAssoc.sqf at line 14](../../../Src/client/InputSystem/InputAssoc.sqf#L14)
## mouse_key_prefix

Type: constant

Description: 


Replaced value:
```sqf
"@"
```
File: [client\InputSystem\InputAssoc.sqf at line 15](../../../Src/client/InputSystem/InputAssoc.sqf#L15)
## input_map_keyName

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\InputSystem\InputAssoc.sqf at line 10](../../../Src/client/InputSystem/InputAssoc.sqf#L10)
## input_keyList_reversedAssoc

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\InputSystem\InputAssoc.sqf at line 11](../../../Src/client/InputSystem/InputAssoc.sqf#L11)
## input_getKeyValue

Type: function

Description: Получает значение ключа из клавиатуры
- Param: _str
- Param: _isMouse

File: [client\InputSystem\InputAssoc.sqf at line 188](../../../Src/client/InputSystem/InputAssoc.sqf#L188)
## input_getAllKeyNames

Type: function

Description: Получает массив всех названий кнопок
- Param: _idx

File: [client\InputSystem\InputAssoc.sqf at line 203](../../../Src/client/InputSystem/InputAssoc.sqf#L203)
# inputHelper.sqf

## INPUTHELPER_WIDGET_SIZE_W

Type: constant

Description: Помощь по управлению


Replaced value:
```sqf
30
```
File: [client\InputSystem\inputHelper.sqf at line 12](../../../Src/client/InputSystem/inputHelper.sqf#L12)
## INPUTHELPER_WIDGET_SIZE_H

Type: constant

Description: 


Replaced value:
```sqf
13
```
File: [client\InputSystem\inputHelper.sqf at line 13](../../../Src/client/InputSystem/inputHelper.sqf#L13)
## inputHelper_enabled

Type: Variable

Description: 


Initial value:
```sqf
true
```
File: [client\InputSystem\inputHelper.sqf at line 15](../../../Src/client/InputSystem/inputHelper.sqf#L15)
## inputHelper_handleUpdate

Type: Variable

Description: 


Initial value:
```sqf
-1
```
File: [client\InputSystem\inputHelper.sqf at line 17](../../../Src/client/InputSystem/inputHelper.sqf#L17)
## inputHelper_widgets

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [client\InputSystem\inputHelper.sqf at line 18](../../../Src/client/InputSystem/inputHelper.sqf#L18)
## inputHelper_firstRunTaskId

Type: Variable

Description: 


Initial value:
```sqf
0
```
File: [client\InputSystem\inputHelper.sqf at line 19](../../../Src/client/InputSystem/inputHelper.sqf#L19)
## inputHelper_isSuccessCurrentTask

Type: Variable

Description: 


Initial value:
```sqf
false //системная переменная для выполнения внутренней задачи
```
File: [client\InputSystem\inputHelper.sqf at line 21](../../../Src/client/InputSystem/inputHelper.sqf#L21)
## inputHelper_basicTask

Type: Variable

Description: Базовые задачи это первый вход


Initial value:
```sqf
[...
```
File: [client\InputSystem\inputHelper.sqf at line 24](../../../Src/client/InputSystem/inputHelper.sqf#L24)
## inputHelper_init

Type: function

Description: 


File: [client\InputSystem\inputHelper.sqf at line 32](../../../Src/client/InputSystem/inputHelper.sqf#L32)
## inputHelper_showNotification

Type: function

Description: 
- Param: _text
- Param: _timeOrCode

File: [client\InputSystem\inputHelper.sqf at line 63](../../../Src/client/InputSystem/inputHelper.sqf#L63)
## inputHelper_internal_sortWidgets

Type: function

Description: 


File: [client\InputSystem\inputHelper.sqf at line 83](../../../Src/client/InputSystem/inputHelper.sqf#L83)
# inputKeyHandlers.hpp

## KEYBIND_INDEX_NAME

Type: constant

Description: // [name,desc,current,default,variable]


Replaced value:
```sqf
0
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 9](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L9)
## KEYBIND_INDEX_DESC

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 10](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L10)
## KEYBIND_INDEX_CURRENT

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 11](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L11)
## KEYBIND_INDEX_DEFAULT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 12](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L12)
## KEYBIND_INDEX_VARNAME

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 13](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L13)
## KEYBIND_INDEX_SERIALIZED

Type: constant

Description: 


Replaced value:
```sqf
5
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 14](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L14)
## KEYDATA_INDEX_KEY

Type: constant

Description: [value,shift,ctrl,alt,isMouse]


Replaced value:
```sqf
0
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 17](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L17)
## KEYDATA_INDEX_SHIFT

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 18](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L18)
## KEYDATA_INDEX_CTRL

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 19](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L19)
## KEYDATA_INDEX_ALT

Type: constant

Description: 


Replaced value:
```sqf
3
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 20](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L20)
## KEYDATA_INDEX_ISMOUSE

Type: constant

Description: 


Replaced value:
```sqf
4
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 21](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L21)
## unpackKeyData(_dat)

Type: constant

Description: Распаковывает массив клавиш
- Param: _dat

Replaced value:
```sqf
_dat select [1,4]
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 24](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L24)
## doPrepareKeyData()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
__ikdp = unpackKeyData(_this)
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 26](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L26)
## isPressed(var)

Type: constant

Description: Проверяет состояние кейдаты
- Param: var

Replaced value:
```sqf
isPressedKey(__ikdp,var)
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 27](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L27)
## isPressedKey(_key,variable)

Type: constant

Description: Проверяет состояние кейдаты
- Param: _key
- Param: variable

Replaced value:
```sqf
([_key,variable,true] call input_checkKeyState)
```
File: [client\InputSystem\inputKeyHandlers.hpp at line 30](../../../Src/client/InputSystem/inputKeyHandlers.hpp#L30)
# inputKeyHandlers.sqf

## kb(name,desc,defkey,varname)

Type: constant

Description: [name,desc,current,default,variable]
- Param: name
- Param: desc
- Param: defkey
- Param: varname

Replaced value:
```sqf
[name,desc,defkey,defkey,call{varname = defkey; 'varname'},defkey]
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 10](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L10)
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
File: [client\InputSystem\inputKeyHandlers.sqf at line 11](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L11)
## std_key(name)

Type: constant

Description: 
- Param: name

Replaced value:
```sqf
keybind([name arg false] call input_getKeyValue,false,false,false,false)
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 13](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L13)
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
File: [client\InputSystem\inputKeyHandlers.sqf at line 14](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L14)
## cd_settingsKeyboard

Type: Variable

Description: Список кейбиндов


Initial value:
```sqf
[...
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 17](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L17)
## input_internal_map_act2kb

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 42](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L42)
## input_map_spamProtect

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [client\InputSystem\inputKeyHandlers.sqf at line 123](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L123)
## input_updateAllKeyBinds

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 47](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L47)
## input_checkKeyState

Type: function

Description: 
- Param: _keyData
- Param: _state
- Param: _doRemKeyState (optional, default false)

File: [client\InputSystem\inputKeyHandlers.sqf at line 107](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L107)
## input_spamProtect

Type: function

Description: 
- Param: _strname
- Param: _timeout (optional, default 0.3)

File: [client\InputSystem\inputKeyHandlers.sqf at line 125](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L125)
## input_passThroughWallsProtect

Type: function

Description: temorary wall pass through walls


File: [client\InputSystem\inputKeyHandlers.sqf at line 142](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L142)
## input_movementCheck

Type: function

Description: Проверяет пользовательский инпут. true означает что клавиша заблокирована
- Param: _key

File: [client\InputSystem\inputKeyHandlers.sqf at line 158](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L158)
## input_internal_isChangeStance

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 221](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L221)
## input_internal_isMovingButton

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 222](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L222)
## input_internal_isMovingForward

Type: function

Description: 


File: [client\InputSystem\inputKeyHandlers.sqf at line 223](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L223)
## input_getKeyNameByInputName

Type: function

Description: 
- Param: _inp

File: [client\InputSystem\inputKeyHandlers.sqf at line 225](../../../Src/client/InputSystem/inputKeyHandlers.sqf#L225)
# inputManager.sqf

## isPressed(var)

Type: constant

Description: 
- Param: var

Replaced value:
```sqf
isPressedKey(_kupc,var)
```
File: [client\InputSystem\inputManager.sqf at line 60](../../../Src/client/InputSystem/inputManager.sqf#L60)
## attr

Type: constant

> Exists if **DEBUG** defined

Description: };


Replaced value:
```sqf
([#st,#ht,#dx,#iq,#fp,#will,#per,#hp] select ind_stat)
```
File: [client\InputSystem\inputManager.sqf at line 136](../../../Src/client/InputSystem/inputManager.sqf#L136)
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
File: [client\InputSystem\inputManager.sqf at line 137](../../../Src/client/InputSystem/inputManager.sqf#L137)
## onGameInputs_Down

Type: function

Description: invokeAfterDelay({inventory_isHoldMode = true},2);
- Param: 
- Param: _key
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\InputSystem\inputManager.sqf at line 10](../../../Src/client/InputSystem/inputManager.sqf#L10)
## onGameKeyInputs

Type: function

Description: клавиши в режиме игры
- Param: 
- Param: _key
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\InputSystem\inputManager.sqf at line 41](../../../Src/client/InputSystem/inputManager.sqf#L41)
## onGameMouseInputs

Type: function

Description: мышь в режиме игры
- Param: 
- Param: _button
- Param: 
- Param: 
- Param: _shift
- Param: _ctrl
- Param: _alt

File: [client\InputSystem\inputManager.sqf at line 166](../../../Src/client/InputSystem/inputManager.sqf#L166)
# input_init.sqf

## input_catchedEscape

Type: Variable

Description: 


Initial value:
```sqf
false
```
File: [client\InputSystem\input_init.sqf at line 21](../../../Src/client/InputSystem/input_init.sqf#L21)
## input_internal_handleNativeEsc

Type: Variable

Description: Хандлить ли нативную паузу


Initial value:
```sqf
false
```
File: [client\InputSystem\input_init.sqf at line 26](../../../Src/client/InputSystem/input_init.sqf#L26)
