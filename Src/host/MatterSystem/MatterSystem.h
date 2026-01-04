// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

// math helpers
#define throwFloor(a,b) (floor(a * 10^b) / 10^b)
#define throwCeil(a,b) (ceil(a * 10^b) / 10^b)
#define throwRound(a,b) (round(a * 10^b) / 10^b)


#define __nativecall "MatterSystem" callExtension

#define __validate(space,errtypemes) if (_className in space) exitWith {errorformat("[MatterSystem]: Generic error on loading %1 -> %2 already exists",errtypemes arg _className); appExit(APPEXIT_REASON_RUNTIMEERROR)}

#define __class_activator_provider(name,space,errtypemes) _newMatter = createHashMap; _className = #name; __validate(space,errtypemes); space set [_className,_newMatter]; _newMatter set ["classname",_className]; _newMatter set ["inherit","NOTYPE"];
#define __class_activator_provider_NOSTR(name,space,errtypemes) _newMatter = createHashMap; _className = name; __validate(space,errtypemes); space set [_className,_newMatter]; _newMatter set ["classname",_className]; _newMatter set ["inherit","NOTYPE"];

#define matter(name) __class_activator_provider(name,ms_map_allMatters,"reagent")

#define react(name) __class_activator_provider(name,ms_map_allReactions,"reaction")

#define reactgen INC(ms_internal_react_gen); __class_activator_provider_NOSTR("react_gen_" + str ms_internal_react_gen,ms_map_allReactions,"reaction")

#define prop(__p,val) _fieldName = #__p; if ((_fieldName in _newMatter)) exitWith {errorformat("MatterSystem - Cant initialize property <%1> ===> property <%2> already defined",_className arg _fieldName)}; _newMatter set [_fieldName,val];

#define extends(name) _newMatter set ["inherit",#name];

#define callExtend(__class,func) call(ms_map_allMatters get #__class get #func)

#define def(funcname) _lastfunc = [#funcname , {

#define end }]; _newMatter set _lastfunc;

//сколько осталось этого реагента
#define amount __amount__

#define thisSpace _ms
// внешняя переменная всегда должна быть такой
#define thisMatter _matterObj

// для миксинга данных
#define MIXING_DATA_CTX __NEW_DATA__
#define MIXING_DATA_NAME __MD_NAME__
#define MIXING_DATA_CONTAINER __mdata__
