// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================


//----------------condition flags------------------
//кто вызывает
#define usr _usr
//источник верба (предмет или другой моб)
#define src _src
//#define verbCondParams() params ["_src","_usr"]
#define this src
//#define TEMP_DEF_FUNC(name) func(name) {verbCondParams(); true};
#define isSrcInInventory (getSelf(loc) isEqualType nullPtr)
//TODO getSelf(slot) == INV_HAND_..
#define isSrcInHands (call{_i_slots = getVar(usr,slots); equals(_i_slots select INV_HAND_L,src) || equals(_i_slots select INV_HAND_R,src)})

//FLAGS(F_INVENTORY or F_HANDS and F_INUSR);
#define FLAGS(args) if (args) exitWith {false}

//флаг указывает что действие с предметом может быть выполнено только в инвентаре
#define F_INVENTORY !isSrcInInventory
//указывает, что действие с предметом может быть выполнено только если предмет в руках
#define F_HANDS !isSrcInHands
//такое действие может быть выполно только если предмет не в руках
#define F_NONHANDS isSrcInHands
//такое действие может быть выполнено только если предмет в мире
#define F_WORLD (!(getSelf(loc) isEqualType objnull))
//такое действие может быть выполнено если предмет в юзере
#define F_INUSR (!(getSelf(loc) isequalto usr))
//такое действие может быть выполнено если предмет в контейнере
#define F_CONTAINER (F_INVENTORY && {!isTypeOf(getSelf(loc),Container)})

//этот флаг указывает что верб может быть задействован только если источник в инвентаре
#define ONLY_INVENTORY if (!isSrcInInventory) exitWith {false}
//этот флаг указывает что верб может быть задействован только если источник в мире
#define ONLY_WORLD if (isSrcInInventory) exitWith {false}
//этот флаг указывает что верб может быть задействован только если источник в руках
#define ONLY_HANDS if (!isSrcInHands) exitWith {false}
//этот флаг указывает что верб может быть задействован только для самого себя
#define ONLY_SELF if not_equals(src,usr) exitWith {false}

#define skipCond(cond) if (cond) exitWith {false}
#define successCond(cond) if (cond) exitWith {true}


//-------------actions macros-------------------
//#define ACTION(name) verb_act_##name = { params ['this',"_usr","_client"];
//#define usr _usr
//#define src this
#define callbackObject _client



//-----------------common--------------------

#define ___provide_verb_regmes__ ["Registered verb '%1'",_lastVerbName] call logInfo

#define VERB(class) _data = [{true},{true},{true}]; _lastVerbName = 'class';_lastVerb = [_lastVerbName,_data]; [{

#define act true}]; _data set [1,{ params ['this','usr','callbackObject'];

#define cond true}]; _data set [0,{
	
#define name true}]; _data set [2,{

#define setName(newstr) _redirName = newstr

#define ENDVERB true}]; verbs_funcData set _lastVerb; ___provide_verb_regmes__;
