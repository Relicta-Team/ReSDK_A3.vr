# ActionsPseudonames.sqf

## setcat(catpref)

Type: constant

Description: 
- Param: catpref

Replaced value:
```sqf
__catprefix = #catpref;
```
File: [host\VerbSystem\ActionsPseudonames.sqf at line 50](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L50)
## reg(name,method)

Type: constant

Description: 
- Param: name
- Param: method

Replaced value:
```sqf
_ps = format[__catprefix +"_"+ 'name']; _met = #method ; \
ie_actions_map set [_ps,_met]; ie_actions_mapinverted set [_met,_ps];
```
File: [host\VerbSystem\ActionsPseudonames.sqf at line 51](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L51)
## ie_actions_map

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\VerbSystem\ActionsPseudonames.sqf at line 6](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L6)
## ie_actions_mapinverted

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\VerbSystem\ActionsPseudonames.sqf at line 7](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L7)
## ie_action_setPrefix

Type: function

Description: Установить префикс: "emt" call ie_aciton_setPrefix


File: [host\VerbSystem\ActionsPseudonames.sqf at line 17](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L17)
## ie_action_check

Type: function

Description: 
- Param: _n

File: [host\VerbSystem\ActionsPseudonames.sqf at line 21](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L21)
## ie_action_getCalledActionName

Type: function

Description: 


File: [host\VerbSystem\ActionsPseudonames.sqf at line 26](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L26)
## ie_action_call

Type: function

Description: 
- Param: _mob
- Param: _act

File: [host\VerbSystem\ActionsPseudonames.sqf at line 28](../../../Src/host/VerbSystem/ActionsPseudonames.sqf#L28)
# loadBeforeOOPInit.sqf

## ie_actions_list_preInitActions

Type: Variable

Description: 


Initial value:
```sqf
[]
```
File: [host\VerbSystem\loadBeforeOOPInit.sqf at line 8](../../../Src/host/VerbSystem/loadBeforeOOPInit.sqf#L8)
## ie_actions_regNew

Type: function

Description: ["wrld","sniff","onActWorld"] call ie_actions_regNew;
- Param: _catprefix
- Param: _name
- Param: _met

File: [host\VerbSystem\loadBeforeOOPInit.sqf at line 12](../../../Src/host/VerbSystem/loadBeforeOOPInit.sqf#L12)
## verbs_parse_strToListOfNum

Type: function

Description: 
- Param: _strData

File: [host\VerbSystem\loadBeforeOOPInit.sqf at line 18](../../../Src/host/VerbSystem/loadBeforeOOPInit.sqf#L18)
# verbs.sqf

## verbs_funcData

Type: Variable

Description: 


Initial value:
```sqf
createHashMap //only before init verbsCondAndAct.sqf
```
File: [host\VerbSystem\verbs.sqf at line 15](../../../Src/host/VerbSystem/verbs.sqf#L15)
## verb_act_undefinded

Type: function

Description: 
- Param: this
- Param: _usr
- Param: _client

File: [host\VerbSystem\verbs.sqf at line 82](../../../Src/host/VerbSystem/verbs.sqf#L82)
## verb_tryCollectVerbs

Type: function

Description: условия на добавления вербов и отправкой клиенту
- Param: _mob
- Param: _targ

File: [host\VerbSystem\verbs.sqf at line 145](../../../Src/host/VerbSystem/verbs.sqf#L145)
## verb_getTypeById

Type: function

Description: 
- Param: _id

File: [host\VerbSystem\verbs.sqf at line 202](../../../Src/host/VerbSystem/verbs.sqf#L202)
# verbsCondAndAct.h

## usr

Type: constant

Description: кто вызывает


Replaced value:
```sqf
_usr
```
File: [host\VerbSystem\verbsCondAndAct.h at line 9](../../../Src/host/VerbSystem/verbsCondAndAct.h#L9)
## src

Type: constant

Description: источник верба (предмет или другой моб)


Replaced value:
```sqf
_src
```
File: [host\VerbSystem\verbsCondAndAct.h at line 11](../../../Src/host/VerbSystem/verbsCondAndAct.h#L11)
## this

Type: constant

Description: #define verbCondParams() params ["_src","_usr"]


Replaced value:
```sqf
src
```
File: [host\VerbSystem\verbsCondAndAct.h at line 13](../../../Src/host/VerbSystem/verbsCondAndAct.h#L13)
## isSrcInInventory

Type: constant

Description: #define TEMP_DEF_FUNC(name) func(name) {verbCondParams(); true};


Replaced value:
```sqf
(getSelf(loc) isEqualType nullPtr)
```
File: [host\VerbSystem\verbsCondAndAct.h at line 15](../../../Src/host/VerbSystem/verbsCondAndAct.h#L15)
## isSrcInHands

Type: constant

Description: TODO getSelf(slot) == INV_HAND_..


Replaced value:
```sqf
(call{_i_slots = getVar(usr,slots); equals(_i_slots select INV_HAND_L,src) || equals(_i_slots select INV_HAND_R,src)})
```
File: [host\VerbSystem\verbsCondAndAct.h at line 17](../../../Src/host/VerbSystem/verbsCondAndAct.h#L17)
## FLAGS(args)

Type: constant

Description: FLAGS(F_INVENTORY or F_HANDS and F_INUSR);
- Param: args

Replaced value:
```sqf
if (args) exitWith {false}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 20](../../../Src/host/VerbSystem/verbsCondAndAct.h#L20)
## F_INVENTORY

Type: constant

Description: флаг указывает что действие с предметом может быть выполнено только в инвентаре


Replaced value:
```sqf
!isSrcInInventory
```
File: [host\VerbSystem\verbsCondAndAct.h at line 23](../../../Src/host/VerbSystem/verbsCondAndAct.h#L23)
## F_HANDS

Type: constant

Description: указывает, что действие с предметом может быть выполнено только если предмет в руках


Replaced value:
```sqf
!isSrcInHands
```
File: [host\VerbSystem\verbsCondAndAct.h at line 25](../../../Src/host/VerbSystem/verbsCondAndAct.h#L25)
## F_NONHANDS

Type: constant

Description: такое действие может быть выполно только если предмет не в руках


Replaced value:
```sqf
isSrcInHands
```
File: [host\VerbSystem\verbsCondAndAct.h at line 27](../../../Src/host/VerbSystem/verbsCondAndAct.h#L27)
## F_WORLD

Type: constant

Description: такое действие может быть выполнено только если предмет в мире


Replaced value:
```sqf
(!(getSelf(loc) isEqualType objnull))
```
File: [host\VerbSystem\verbsCondAndAct.h at line 29](../../../Src/host/VerbSystem/verbsCondAndAct.h#L29)
## F_INUSR

Type: constant

Description: такое действие может быть выполнено если предмет в юзере


Replaced value:
```sqf
(!(getSelf(loc) isequalto usr))
```
File: [host\VerbSystem\verbsCondAndAct.h at line 31](../../../Src/host/VerbSystem/verbsCondAndAct.h#L31)
## F_CONTAINER

Type: constant

Description: такое действие может быть выполнено если предмет в контейнере


Replaced value:
```sqf
(F_INVENTORY && {!isTypeOf(getSelf(loc),Container)})
```
File: [host\VerbSystem\verbsCondAndAct.h at line 33](../../../Src/host/VerbSystem/verbsCondAndAct.h#L33)
## ONLY_INVENTORY

Type: constant

Description: этот флаг указывает что верб может быть задействован только если источник в инвентаре


Replaced value:
```sqf
if (!isSrcInInventory) exitWith {false}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 36](../../../Src/host/VerbSystem/verbsCondAndAct.h#L36)
## ONLY_WORLD

Type: constant

Description: этот флаг указывает что верб может быть задействован только если источник в мире


Replaced value:
```sqf
if (isSrcInInventory) exitWith {false}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 38](../../../Src/host/VerbSystem/verbsCondAndAct.h#L38)
## ONLY_HANDS

Type: constant

Description: этот флаг указывает что верб может быть задействован только если источник в руках


Replaced value:
```sqf
if (!isSrcInHands) exitWith {false}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 40](../../../Src/host/VerbSystem/verbsCondAndAct.h#L40)
## ONLY_SELF

Type: constant

Description: этот флаг указывает что верб может быть задействован только для самого себя


Replaced value:
```sqf
if not_equals(src,usr) exitWith {false}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 42](../../../Src/host/VerbSystem/verbsCondAndAct.h#L42)
## skipCond(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
if (cond) exitWith {false}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 44](../../../Src/host/VerbSystem/verbsCondAndAct.h#L44)
## successCond(cond)

Type: constant

Description: 
- Param: cond

Replaced value:
```sqf
if (cond) exitWith {true}
```
File: [host\VerbSystem\verbsCondAndAct.h at line 45](../../../Src/host/VerbSystem/verbsCondAndAct.h#L45)
## callbackObject

Type: constant

Description: #define src this


Replaced value:
```sqf
_client
```
File: [host\VerbSystem\verbsCondAndAct.h at line 52](../../../Src/host/VerbSystem/verbsCondAndAct.h#L52)
## ___provide_verb_regmes__

Type: constant

Description: -----------------common--------------------


Replaced value:
```sqf
["Registered verb '%1'",_lastVerbName] call logInfo
```
File: [host\VerbSystem\verbsCondAndAct.h at line 58](../../../Src/host/VerbSystem/verbsCondAndAct.h#L58)
## VERB(class)

Type: constant

Description: 
- Param: class

Replaced value:
```sqf
_data = [{true},{true},{true}]; _lastVerbName = 'class';_lastVerb = [_lastVerbName,_data]; [{
```
File: [host\VerbSystem\verbsCondAndAct.h at line 60](../../../Src/host/VerbSystem/verbsCondAndAct.h#L60)
## act

Type: constant

Description: 


Replaced value:
```sqf
true}]; _data set [1,{ params ['this','usr','callbackObject'];
```
File: [host\VerbSystem\verbsCondAndAct.h at line 62](../../../Src/host/VerbSystem/verbsCondAndAct.h#L62)
## cond

Type: constant

Description: 


Replaced value:
```sqf
true}]; _data set [0,{
```
File: [host\VerbSystem\verbsCondAndAct.h at line 64](../../../Src/host/VerbSystem/verbsCondAndAct.h#L64)
## name

Type: constant

Description: 


Replaced value:
```sqf
true}]; _data set [2,{
```
File: [host\VerbSystem\verbsCondAndAct.h at line 66](../../../Src/host/VerbSystem/verbsCondAndAct.h#L66)
## setName(newstr)

Type: constant

Description: 
- Param: newstr

Replaced value:
```sqf
_redirName = newstr
```
File: [host\VerbSystem\verbsCondAndAct.h at line 68](../../../Src/host/VerbSystem/verbsCondAndAct.h#L68)
## ENDVERB

Type: constant

Description: 


Replaced value:
```sqf
true}]; verbs_funcData set _lastVerb; ___provide_verb_regmes__;
```
File: [host\VerbSystem\verbsCondAndAct.h at line 70](../../../Src/host/VerbSystem/verbsCondAndAct.h#L70)
# verbsDefine.sqf

## verb(class,name,verbargs)

Type: constant

Description: 
- Param: class
- Param: name
- Param: verbargs

Replaced value:
```sqf
_lastVerbClassName = 'class'; verb_list set [_lastVerbClassName,[name,_verbLastIndex,verbargs]]; verb_inverted_list set [_verbLastIndex,_lastVerbClassName]; INC(_verbLastIndex);
```
File: [host\VerbSystem\verbsDefine.sqf at line 8](../../../Src/host/VerbSystem/verbsDefine.sqf#L8)
## noargs

Type: constant

Description: 


Replaced value:
```sqf
null
```
File: [host\VerbSystem\verbsDefine.sqf at line 10](../../../Src/host/VerbSystem/verbsDefine.sqf#L10)
## verb_list

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\VerbSystem\verbsDefine.sqf at line 12](../../../Src/host/VerbSystem/verbsDefine.sqf#L12)
## verb_inverted_list

Type: Variable

Description: 


Initial value:
```sqf
createHashMap
```
File: [host\VerbSystem\verbsDefine.sqf at line 13](../../../Src/host/VerbSystem/verbsDefine.sqf#L13)
