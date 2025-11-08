# intercept.hpp

## EH(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
DLLEXPORT void CDECL x
```
File: [RVEngine\src\client\headers\intercept.hpp at line 29](../../../Src/RVEngine/src/client/headers/intercept.hpp#L29)
# shared.hpp

## ZERO_OUTPUT()

Type: constant

> Exists if **_DEBUG** defined

Description: 
- Param: 

Replaced value:
```sqf
{ memset(output, 0x00, outputSize); }
```
File: [RVEngine\src\client\headers\shared.hpp at line 24](../../../Src/RVEngine/src/client/headers/shared.hpp#L24)
## EXTENSION_RETURN()

Type: constant

> Exists if **_DEBUG** defined

Description: 
- Param: 

Replaced value:
```sqf
{output[outputSize-1] = 0x00; } return;
```
File: [RVEngine\src\client\headers\shared.hpp at line 25](../../../Src/RVEngine/src/client/headers/shared.hpp#L25)
## ZERO_OUTPUT()

Type: constant

> Exists if **_DEBUG** not defined

Description: 
- Param: 

Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\shared.hpp at line 27](../../../Src/RVEngine/src/client/headers/shared.hpp#L27)
## EXTENSION_RETURN()

Type: constant

> Exists if **_DEBUG** not defined

Description: 
- Param: 

Replaced value:
```sqf
return;
```
File: [RVEngine\src\client\headers\shared.hpp at line 28](../../../Src/RVEngine/src/client/headers/shared.hpp#L28)
## INTERCEPT_ASSERT

Type: constant

> Exists if **_DEBUG** defined

Description: 


Replaced value:
```sqf
assert()
```
File: [RVEngine\src\client\headers\shared.hpp at line 32](../../../Src/RVEngine/src/client/headers/shared.hpp#L32)
## INTERCEPT_ASSERT

Type: constant

> Exists if **_DEBUG** not defined

Description: 


Replaced value:
```sqf
intercept::runtime_assert()
```
File: [RVEngine\src\client\headers\shared.hpp at line 34](../../../Src/RVEngine/src/client/headers/shared.hpp#L34)
## CDECL

Type: constant

> Exists if **__GNUC__** defined

Description: 


Replaced value:
```sqf
__attribute__ ((__cdecl__))
```
File: [RVEngine\src\client\headers\shared.hpp at line 38](../../../Src/RVEngine/src/client/headers/shared.hpp#L38)
## CDECL

Type: constant

> Exists if **__GNUC__** not defined

Description: 


Replaced value:
```sqf
__cdecl
```
File: [RVEngine\src\client\headers\shared.hpp at line 41](../../../Src/RVEngine/src/client/headers/shared.hpp#L41)
## DLLEXPORT

Type: constant

> Exists if **__GNUC__** defined

Description: 


Replaced value:
```sqf
__attribute__((visibility("default")))
```
File: [RVEngine\src\client\headers\shared.hpp at line 45](../../../Src/RVEngine/src/client/headers/shared.hpp#L45)
## DLLEXPORT

Type: constant

> Exists if **__GNUC__** not defined

Description: 


Replaced value:
```sqf
__declspec(dllexport)
```
File: [RVEngine\src\client\headers\shared.hpp at line 47](../../../Src/RVEngine/src/client/headers/shared.hpp#L47)
# eventhandlers.hpp

## EH_Func_Args_Mission_Draw3D

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 106](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L106)
## EH_Func_Args_Mission_Ended

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::r_string end_type
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 107](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L107)
## EH_Func_Args_Mission_MPEnded

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 108](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L108)
## EH_Func_Args_Mission_Loaded

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
loaded_saveType save_type
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 109](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L109)
## EH_Func_Args_Mission_Map

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
bool mapIsOpened, bool mapIsForced
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 110](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L110)
## EH_Func_Args_Mission_HandleDisconnect

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, int id, types::r_string uid, types::r_string name
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 111](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L111)
## EH_Func_Args_Mission_EntityRespawned

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object newEntity, types::object oldEntity
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 112](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L112)
## EH_Func_Args_Mission_EntityKilled

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object killed, types::object killer, types::object instigator, bool useEffects
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 113](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L113)
## EH_Func_Args_Mission_EachFrame

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 114](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L114)
## EH_Func_Args_Mission_MapSingleClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::auto_array<types::object> units, types::vector3 pos, bool alt, bool shift
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 115](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L115)
## EH_Func_Args_Mission_HCGroupSelectionChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group group, bool isSelected
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 116](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L116)
## EH_Func_Args_Mission_CommandModeChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
bool isHighCommand, bool IsForced
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 117](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L117)
## EH_Func_Args_Mission_GroupIconClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
bool is3D, types::group group, int wpID, int mb, types::vector2 mousePos, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 118](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L118)
## EH_Func_Args_Mission_GroupIconOverEnter

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
bool is3D, types::group group, int wpID, int mb, types::vector2 mousePos, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 119](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L119)
## EH_Func_Args_Mission_GroupIconOverLeave

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
bool is3D, types::group group, int wpID, int mb, types::vector2 mousePos, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 120](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L120)
## EH_Func_Args_Mission_PlayerConnected

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
int id, types::r_string uid, types::r_string name, bool jip, int owner
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 121](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L121)
## EH_Func_Args_Mission_PlayerDisconnected

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
int id, types::r_string uid, types::r_string name, bool jip, int owner
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 122](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L122)
## EH_Func_Args_Mission_TeamSwitch

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object from, types::object to
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 123](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L123)
## EH_Func_Args_Mission_PreloadStarted

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 124](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L124)
## EH_Func_Args_Mission_PreloadFinished

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 125](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L125)
## EH_Func_Args_Mission_PlayerViewChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object oldBody, types::object newBody, types::object vehicleIn, types::object oldCameraOn, types::object newCameraOn, types::object UAV
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 126](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L126)
## EH_Func_Args_Mission_BuildingChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object from, types::object to, bool isRuin
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 127](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L127)
## EH_Func_Args_Mission_ControlsShifted

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object newController, types::object oldController, types::object vehicle, bool copilotEnabled, bool controlsUnlocked
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 128](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L128)
## EH_Func_Args_Mission_ExtensionCallback

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::r_string name, types::r_string function, types::r_string data
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 129](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L129)
## EH_Func_Args_Mission_HandleAccTime

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
float currentTimeAcc, float prevTimeAcc, bool messageSuppressed
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 130](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L130)
## EH_Func_Args_Mission_HandleChatMessage

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
int channel, int owner, types::r_string from, types::r_string text, types::object person, types::r_string name, types::r_string strID, bool forcedDisplay, bool isPlayerMessage, int sentenceType, int chatMessageType
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 131](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L131)
## EH_Func_Args_Mission_MarkerCreated

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::r_string marker, int channelNumber, types::object owner, bool local
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 132](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L132)
## EH_Func_Args_Mission_MarkerDeleted

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::r_string marker, bool local
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 133](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L133)
## EH_Func_Args_Mission_MarkerUpdated

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::r_string marker, bool local
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 134](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L134)
## EH_Func_Ret_Mission_HandleChatMessage

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
std::optional<std::variant<bool, types::sqf_string, types::auto_array<types::sqf_string>>>
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 135](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L135)
## EHDEF_MISSION(XX)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: Name,Function return value, Function Arguments
- Param: XX

Replaced value:
```sqf
\
    XX(BuildingChanged, void, EH_Func_Args_Mission_BuildingChanged)                                      \
    XX(CommandModeChanged, void, EH_Func_Args_Mission_CommandModeChanged)                                \
    XX(ControlsShifted, void, EH_Func_Args_Mission_ControlsShifted)                                      \
    XX(Draw3D, void, EH_Func_Args_Mission_Draw3D)                                                        \
    XX(EachFrame, void, EH_Func_Args_Mission_EachFrame)                                                  \
    XX(Ended, void, EH_Func_Args_Mission_Ended)                                                          \
    XX(MPEnded, void, EH_Func_Args_Mission_MPEnded)                                                      \
    XX(EntityKilled, void, EH_Func_Args_Mission_EntityKilled)                                            \
    XX(EntityRespawned, void, EH_Func_Args_Mission_EntityRespawned)                                      \
    XX(ExtensionCallback, void, EH_Func_Args_Mission_ExtensionCallback)                                  \
    XX(GroupIconClick, void, EH_Func_Args_Mission_GroupIconClick)                                        \
    XX(GroupIconOverEnter, void, EH_Func_Args_Mission_GroupIconOverEnter)                                \
    XX(GroupIconOverLeave, void, EH_Func_Args_Mission_GroupIconOverLeave)                                \
    XX(HandleAccTime, std::optional<bool>, EH_Func_Args_Mission_HandleAccTime)                           \
    XX(HandleChatMessage, EH_Func_Ret_Mission_HandleChatMessage, EH_Func_Args_Mission_HandleChatMessage) \
    XX(HandleDisconnect, std::optional<bool>, EH_Func_Args_Mission_HandleDisconnect)                     \
    XX(HCGroupSelectionChanged, void, EH_Func_Args_Mission_HCGroupSelectionChanged)                      \
    XX(Loaded, void, EH_Func_Args_Mission_Loaded)                                                        \
    XX(Map, void, EH_Func_Args_Mission_Map)                                                              \
    XX(MapSingleClick, void, EH_Func_Args_Mission_MapSingleClick)                                        \
    XX(MarkerCreated, void, EH_Func_Args_Mission_MarkerCreated)                                          \
    XX(MarkerDeleted, void, EH_Func_Args_Mission_MarkerDeleted)                                          \
    XX(MarkerUpdated, void, EH_Func_Args_Mission_MarkerUpdated)                                          \
    XX(PlayerConnected, void, EH_Func_Args_Mission_PlayerConnected)                                      \
    XX(PlayerDisconnected, void, EH_Func_Args_Mission_PlayerDisconnected)                                \
    XX(PlayerViewChanged, void, EH_Func_Args_Mission_PlayerViewChanged)                                  \
    XX(PreloadStarted, void, EH_Func_Args_Mission_PreloadStarted)                                        \
    XX(PreloadFinished, void, EH_Func_Args_Mission_PreloadFinished)                                      \
    XX(TeamSwitch, void, EH_Func_Args_Mission_TeamSwitch)
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 138](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L138)
## COMPILETIME_CHECK_ENUM_MISSION(name, retVal, funcArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: funcArg

Replaced value:
```sqf
static_assert(eventhandlers_mission::name >= eventhandlers_mission::BuildingChanged);
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 169](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L169)
## EH_Add_Mission_definition(name, retVal, fncArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: fncArg

Replaced value:
```sqf
\
    template <>                                                                                                                                                     \
    struct __addMissionEventHandler_Impl<eventhandlers_mission::name> {                                                                                             \
        using fncType = std::function<retVal(fncArg)>;                                                                                                              \
        [[nodiscard]] static EHIdentifier add(std::function<retVal(fncArg)> function) {                                                                             \
            auto ident = addScriptEH(eventhandlers_mission::name);                                                                                                  \
            funcMapMissionEH[ident] = {eventhandlers_mission::name, std::make_shared<std::function<void()>>(*reinterpret_cast<std::function<void()>*>(&function))}; \
            return ident;                                                                                                                                           \
        }                                                                                                                                                           \
    };
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 225](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L225)
## EH_Func_Args_Object_AnimChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string anim
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 254](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L254)
## EH_Func_Args_Object_AnimDone

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string anim
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 255](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L255)
## EH_Func_Args_Object_AnimStateChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string anim
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 256](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L256)
## EH_Func_Args_Object_ContainerClosed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object container, types::object player
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 257](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L257)
## EH_Func_Args_Object_ContainerOpened

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object container, types::object player
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 258](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L258)
## EH_Func_Args_Object_ControlsShifted

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, types::object newController, types::object oldController
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 259](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L259)
## EH_Func_Args_Object_Dammaged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string, float damage, float hitPartIndex, types::r_string hitPoint, types::object shooter, types::object projectile
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 260](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L260)
## EH_Func_Args_Object_Deleted

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object entity
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 261](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L261)
## EH_Func_Args_Object_Engine

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, bool engineState
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 262](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L262)
## EH_Func_Args_Object_EpeContact

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object object1, types::object object2, types::object select1, types::object select2, float force
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 263](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L263)
## EH_Func_Args_Object_EpeContactEnd

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object object1, types::object object2, types::object select1, types::object select2, float force
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 264](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L264)
## EH_Func_Args_Object_EpeContactStart

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object object1, types::object object2, types::object select1, types::object select2, float force
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 265](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L265)
## EH_Func_Args_Object_Explosion

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, float damage
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 266](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L266)
## EH_Func_Args_Object_Fired

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string weapon, types::r_string muzzle, types::r_string mode, types::r_string ammo, types::r_string magazine, types::object projectile, types::object gunner
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 267](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L267)
## EH_Func_Args_Object_FiredMan

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string weapon, types::r_string muzzle, types::r_string mode, types::r_string ammo, types::r_string magazine, types::object projectile, types::object vehicle
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 268](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L268)
## EH_Func_Args_Object_FiredNear

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object vehicle, float distance, types::r_string weapon, types::r_string muzzle, types::r_string mode, types::r_string ammo, types::object gunner
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 269](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L269)
## EH_Func_Args_Object_Fuel

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, bool fuelState
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 270](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L270)
## EH_Func_Args_Object_Gear

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, bool gearState
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 271](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L271)
## EH_Func_Args_Object_GetIn

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, get_in_position position, types::object unit, types::rv_turret_path turret_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 277](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L277)
## EH_Func_Args_Object_GetInMan

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, get_in_position position, types::object unit, types::rv_turret_path turret_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 278](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L278)
## EH_Func_Args_Object_GetOut

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, get_in_position position, types::object unit, types::rv_turret_path turret_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 279](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L279)
## EH_Func_Args_Object_GetOutMan

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, get_in_position position, types::object unit, types::rv_turret_path turret_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 280](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L280)
## EH_Func_Args_Object_HandleDamage

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::r_string hitSelection, float dmage, types::object source, types::r_string projectile, float hitPartIndex, types::object instigator, types::r_string hitPoint
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 281](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L281)
## EH_Func_Args_Object_HandleHeal

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object healer, bool healerCanHeal
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 282](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L282)
## EH_Func_Args_Object_HandleRating

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, float rating
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 283](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L283)
## EH_Func_Args_Object_HandleScore

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object object_, float score
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 284](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L284)
## EH_Func_Args_Object_Hit

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object causedBy, float damage, types::object instigator
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 285](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L285)
## EH_Func_Args_Object_HitPart

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
std::vector<eventhandler_hit_part_type>;
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 315](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L315)
## EH_Func_Args_Object_Init

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 316](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L316)
## EH_Func_Args_Object_HandleIdentity

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 317](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L317)
## EH_Func_Args_Object_IncomingMissile

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object target, types::r_string ammo, types::object vehicle, types::object instigator
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 318](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L318)
## EH_Func_Args_Object_InventoryClosed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object targetContainer
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 319](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L319)
## EH_Func_Args_Object_InventoryOpened

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object targetContainer, types::object secondaryContainer
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 320](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L320)
## EH_Func_Args_Object_Killed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object killer, types::object instigator, bool useEffects
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 321](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L321)
## EH_Func_Args_Object_LandedTouchDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object plane, float airportID
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 322](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L322)
## EH_Func_Args_Object_LandedStopped

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object plane, float airportID
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 323](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L323)
## EH_Func_Args_Object_Landing

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object plane, float airportID, bool isCarrier
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 324](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L324)
## EH_Func_Args_Object_LandingCanceled

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object plane, float airportID, bool isCarrier
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 325](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L325)
## EH_Func_Args_Object_Local

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object object_, bool local
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 326](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L326)
## EH_Func_Args_Object_PostReset

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 327](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L327)
## EH_Func_Args_Object_Put

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object container, types::r_string item
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 328](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L328)
## EH_Func_Args_Object_Reloaded

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: #TODO correct type for new/oldMagazine


Replaced value:
```sqf
types::object entity, types::r_string weapon, types::r_string muzzle, types::r_string, types::auto_array<types::game_value> newMagazine, types::auto_array<types::game_value> oldMagazine
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 330](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L330)
## EH_Func_Args_Object_Respawn

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object corpse
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 331](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L331)
## EH_Func_Args_Object_RopeAttach

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object object1, types::object rope, types::object object2
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 332](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L332)
## EH_Func_Args_Object_RopeBreak

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object object1, types::object rope, types::object object2
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 333](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L333)
## EH_Func_Args_Object_SeatSwitched

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, types::object unit1, types::object unit2
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 334](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L334)
## EH_Func_Args_Object_SeatSwitchedMan

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, types::object unit1, types::object unit2
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 335](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L335)
## EH_Func_Args_Object_SoundPlayed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, sound_played_origin soundCode
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 352](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L352)
## EH_Func_Args_Object_Take

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object container, types::r_string item
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 353](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L353)
## EH_Func_Args_Object_TaskSetAsCurrent

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::task task_
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 354](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L354)
## EH_Func_Args_Object_TurnIn

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, types::object unit, types::rv_turret_path turret_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 355](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L355)
## EH_Func_Args_Object_TurnOut

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, types::object unit, types::rv_turret_path turret_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 356](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L356)
## EH_Func_Args_Object_WeaponAssembled

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object weapon
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 357](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L357)
## EH_Func_Args_Object_WeaponDisassembled

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object primaryBag, types::object secondarybag
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 358](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L358)
## EH_Func_Args_Object_WeaponDeployed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, bool isDeployed
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 359](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L359)
## EH_Func_Args_Object_WeaponRested

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, bool isRested
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 360](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L360)
## EH_Func_Args_Object_Disassembled

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object entity, types::object primaryBag, types::object secondaryBag
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 361](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L361)
## EH_Func_Args_Object_PathCalculated

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object agent, types::auto_array<types::vector3> path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 362](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L362)
## EH_Func_Args_Object_PeriscopeElevationChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object vehicle, types::rv_turret_path turret, float elevation, float direction, bool userIsBlocked
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 363](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L363)
## EH_Func_Args_Object_Suppressed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, float distance, types::object shooter, types::object instigator, types::object ammoObject, types::r_string ammoClassName, types::config ammoConfig
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 364](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L364)
## EHDEF_OBJECT(XX)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: Name,Function return value, Function Arguments
- Param: XX

Replaced value:
```sqf
\
    XX(AnimChanged, void, EH_Func_Args_Object_AnimChanged)                             \
    XX(AnimDone, void, EH_Func_Args_Object_AnimDone)                                   \
    XX(AnimStateChanged, void, EH_Func_Args_Object_AnimStateChanged)                   \
    XX(ContainerClosed, void, EH_Func_Args_Object_ContainerClosed)                     \
    XX(ContainerOpened, void, EH_Func_Args_Object_ContainerOpened)                     \
    XX(ControlsShifted, void, EH_Func_Args_Object_ControlsShifted)                     \
    XX(Dammaged, void, EH_Func_Args_Object_Dammaged)                                   \
    XX(Deleted, void, EH_Func_Args_Object_Deleted)                                     \
    XX(Disassembled, void, EH_Func_Args_Object_Disassembled)                           \
    XX(Engine, void, EH_Func_Args_Object_Engine)                                       \
    XX(EpeContact, void, EH_Func_Args_Object_EpeContact)                               \
    XX(EpeContactEnd, void, EH_Func_Args_Object_EpeContactEnd)                         \
    XX(EpeContactStart, void, EH_Func_Args_Object_EpeContactStart)                     \
    XX(Explosion, void, EH_Func_Args_Object_Explosion)                                 \
    XX(Fired, void, EH_Func_Args_Object_Fired)                                         \
    XX(FiredMan, void, EH_Func_Args_Object_FiredMan)                                   \
    XX(FiredNear, void, EH_Func_Args_Object_FiredNear)                                 \
    XX(Fuel, void, EH_Func_Args_Object_Fuel)                                           \
    XX(Gear, void, EH_Func_Args_Object_Gear)                                           \
    XX(GetIn, void, EH_Func_Args_Object_GetIn)                                         \
    XX(GetInMan, void, EH_Func_Args_Object_GetInMan)                                   \
    XX(GetOut, void, EH_Func_Args_Object_GetOut)                                       \
    XX(GetOutMan, void, EH_Func_Args_Object_GetOutMan)                                 \
    XX(HandleDamage, std::optional<float>, EH_Func_Args_Object_HandleDamage)           \
    XX(HandleHeal, void, EH_Func_Args_Object_HandleHeal)                               \
    XX(HandleIdentity, std::optional<bool>, EH_Func_Args_Object_HandleIdentity)        \
    XX(HandleRating, std::optional<float>, EH_Func_Args_Object_HandleRating)           \
    XX(HandleScore, std::optional<bool>, EH_Func_Args_Object_HandleScore)              \
    XX(Hit, void, EH_Func_Args_Object_Hit)                                             \
    XX(Init, void, EH_Func_Args_Object_Init)                                           \
    XX(IncomingMissile, void, EH_Func_Args_Object_IncomingMissile)                     \
    XX(InventoryClosed, void, EH_Func_Args_Object_InventoryClosed)                     \
    XX(InventoryOpened, void, EH_Func_Args_Object_InventoryOpened)                     \
    XX(Killed, void, EH_Func_Args_Object_Killed)                                       \
    XX(LandedTouchDown, void, EH_Func_Args_Object_LandedTouchDown)                     \
    XX(LandedStopped, void, EH_Func_Args_Object_LandedStopped)                         \
    XX(Landing, void, EH_Func_Args_Object_Landing)                                     \
    XX(LandingCanceled, void, EH_Func_Args_Object_LandingCanceled)                     \
    XX(Local, void, EH_Func_Args_Object_Local)                                         \
    XX(PathCalculated, void, EH_Func_Args_Object_PathCalculated)                       \
    XX(PeriscopeElevationChanged, void, EH_Func_Args_Object_PeriscopeElevationChanged) \
    XX(PostReset, void, EH_Func_Args_Object_PostReset)                                 \
    XX(Put, void, EH_Func_Args_Object_Put)                                             \
    XX(Reloaded, void, EH_Func_Args_Object_Reloaded)                                   \
    XX(Respawn, void, EH_Func_Args_Object_Respawn)                                     \
    XX(RopeAttach, void, EH_Func_Args_Object_RopeAttach)                               \
    XX(RopeBreak, void, EH_Func_Args_Object_RopeBreak)                                 \
    XX(SeatSwitched, void, EH_Func_Args_Object_SeatSwitched)                           \
    XX(SeatSwitchedMan, void, EH_Func_Args_Object_SeatSwitchedMan)                     \
    XX(SoundPlayed, void, EH_Func_Args_Object_SoundPlayed)                             \
    XX(Suppressed, void, EH_Func_Args_Object_Suppressed)                               \
    XX(Take, void, EH_Func_Args_Object_Take)                                           \
    XX(TaskSetAsCurrent, void, EH_Func_Args_Object_TaskSetAsCurrent)                   \
    XX(TurnIn, void, EH_Func_Args_Object_TurnIn)                                       \
    XX(TurnOut, void, EH_Func_Args_Object_TurnOut)                                     \
    XX(WeaponAssembled, void, EH_Func_Args_Object_WeaponAssembled)                     \
    XX(WeaponDisassembled, void, EH_Func_Args_Object_WeaponDisassembled)               \
    XX(WeaponDeployed, void, EH_Func_Args_Object_WeaponDeployed)                       \
    XX(WeaponRested, void, EH_Func_Args_Object_WeaponRested)
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 368](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L368)
## COMPILETIME_CHECK_ENUM_OBJECT(name, retVal, funcArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: XX(HitPart, void, EH_Func_Args_Object_HitPart)
- Param: name
- Param: retVal
- Param: funcArg

Replaced value:
```sqf
static_assert(eventhandlers_object::name >= eventhandlers_object::AnimChanged);
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 431](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L431)
## EH_Add_Object_definition(name, retVal, fncArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: fncArg

Replaced value:
```sqf
\
    template <>                                                                                                                                                   \
    struct __addEventHandler_Impl<eventhandlers_object::name> {                                                                                                   \
        using fncType = std::function<retVal(fncArg)>;                                                                                                            \
        [[nodiscard]] static EHIdentifier add(types::object obj, std::function<retVal(fncArg)> function) {                                                        \
            auto ident = addScriptEH(obj, eventhandlers_object::name);                                                                                            \
            funcMapObjectEH[ident] = {eventhandlers_object::name, std::make_shared<std::function<void()>>(*reinterpret_cast<std::function<void()>*>(&function))}; \
            return ident;                                                                                                                                         \
        }                                                                                                                                                         \
    };
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 513](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L513)
## EH_Func_Args_Ctrl_Draw

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control map
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 556](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L556)
## EH_Func_Args_Ctrl_MouseButtonDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int button, float x_pos, float y_pos, bool Shift, bool Ctrl, bool Alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 557](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L557)
## EH_Func_Args_Ctrl_MouseButtonUp

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int button, float x_pos, float y_pos, bool Shift, bool Ctrl, bool Alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 558](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L558)
## EH_Func_Args_Ctrl_MouseButtonClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int button, float x_pos, float y_pos, bool Shift, bool Ctrl, bool Alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 559](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L559)
## EH_Func_Args_Ctrl_MouseButtonDblClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int button, float x_pos, float y_pos, bool Shift, bool Ctrl, bool Alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 560](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L560)
## EH_Func_Args_Ctrl_MouseMoving

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float x_pos, float y_pos, bool mouse_over
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 561](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L561)
## EH_Func_Args_Ctrl_MouseHolding

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float x_pos, float y_pos, bool mouse_over
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 562](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L562)
## EH_Func_Args_Ctrl_ButtonClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 563](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L563)
## EH_Func_Args_Ctrl_ButtonDblClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 564](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L564)
## EH_Func_Args_Ctrl_ButtonDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 565](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L565)
## EH_Func_Args_Ctrl_ButtonUp

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 566](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L566)
## EH_Func_Args_Ctrl_CanDestroy

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float exitCode
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 567](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L567)
## EH_Func_Args_Ctrl_Char

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int charCode 
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 568](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L568)
## EH_Func_Args_Ctrl_CheckBoxesSelChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int selectedIndex, int currentIndex
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 569](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L569)
## EH_Func_Args_Ctrl_CheckedChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control checkBox, bool checked
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 570](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L570)
## EH_Func_Args_Ctrl_Destroy

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float exitCode
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 571](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L571)
## EH_Func_Args_Ctrl_HTMLLink

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::r_string url
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 572](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L572)
## EH_Func_Args_Ctrl_IMEChar

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int char_code
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 573](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L573)
## EH_Func_Args_Ctrl_IMEComposition

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int char_code
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 574](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L574)
## EH_Func_Args_Ctrl_KeyDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int keyCode, bool shift_held, bool ctrl_held, bool alt_held
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 575](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L575)
## EH_Func_Args_Ctrl_KeyUp

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int keyCode, bool shift_held, bool ctrl_held, bool alt_held
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 576](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L576)
## EH_Func_Args_Ctrl_KillFocus

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 577](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L577)
## EH_Func_Args_Ctrl_LBDblClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int selected_index
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 578](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L578)
## EH_Func_Args_Ctrl_LBDrag

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<event_handlers_listbox_info> listBoxInfo
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 592](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L592)
## EH_Func_Args_Ctrl_LBDragging

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float x_pos, float y_pos, int ctrlIDC, types::auto_array<event_handlers_listbox_info> listBoxInfo
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 593](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L593)
## EH_Func_Args_Ctrl_LBDrop

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float x_pos, float y_pos, int ctrlIDC, types::auto_array<event_handlers_listbox_info> listBoxInfo
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 594](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L594)
## EH_Func_Args_Ctrl_LBListSelChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int selected_index
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 595](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L595)
## EH_Func_Args_Ctrl_LBSelChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int selected_index
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 596](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L596)
## EH_Func_Args_Ctrl_Load

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::config ctrl_config
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 597](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L597)
## EH_Func_Args_Ctrl_MenuSelected

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int menu_id
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 598](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L598)
## EH_Func_Args_Ctrl_MouseEnter

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 599](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L599)
## EH_Func_Args_Ctrl_MouseExit

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 600](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L600)
## EH_Func_Args_Ctrl_MouseZChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float scroll_val
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 601](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L601)
## EH_Func_Args_Ctrl_ObjectMoved

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::vector3 offset_vector
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 602](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L602)
## EH_Func_Args_Ctrl_SetFocus

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 603](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L603)
## EH_Func_Args_Ctrl_SliderPosChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, float new_value
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 604](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L604)
## EH_Func_Args_Ctrl_ToolBoxSelChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, int selected_index
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 605](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L605)
## EH_Func_Args_Ctrl_TreeCollapsed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<int> tree_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 606](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L606)
## EH_Func_Args_Ctrl_TreeDblClick

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<int> tree_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 607](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L607)
## EH_Func_Args_Ctrl_TreeExpanded

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<int> tree_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 608](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L608)
## EH_Func_Args_Ctrl_TreeLButtonDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 609](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L609)
## EH_Func_Args_Ctrl_TreeMouseExit

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 610](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L610)
## EH_Func_Args_Ctrl_TreeMouseHold

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<int> tree_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 611](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L611)
## EH_Func_Args_Ctrl_TreeMouseMove

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<int> tree_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 612](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L612)
## EH_Func_Args_Ctrl_TreeSelChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl, types::auto_array<int> tree_path
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 613](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L613)
## EH_Func_Args_Ctrl_VideoStopped

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::control ctrl
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 614](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L614)
## EHDEF_CTRL(XX)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: Name,Function return value, Function Arguments
- Param: XX

Replaced value:
```sqf
\
    XX(ButtonClick, std::optional<bool>, EH_Func_Args_Ctrl_ButtonClick)                 \
    XX(ButtonDblClick, void, EH_Func_Args_Ctrl_ButtonDblClick)                          \
    XX(ButtonDown, void, EH_Func_Args_Ctrl_ButtonDown)                                  \
    XX(ButtonUp, void, EH_Func_Args_Ctrl_ButtonUp)                                      \
    XX(CanDestroy, std::optional<bool>, EH_Func_Args_Ctrl_CanDestroy)                   \
    XX(Char, void, EH_Func_Args_Ctrl_Char)                                              \
    XX(CheckBoxesSelChanged, void, EH_Func_Args_Ctrl_CheckBoxesSelChanged)              \
    XX(CheckedChanged, void, EH_Func_Args_Ctrl_CheckedChanged)                          \
    XX(Destroy, void, EH_Func_Args_Ctrl_Destroy)                                        \
    XX(Draw, void, EH_Func_Args_Ctrl_Draw)                                              \
    XX(HTMLLink, void, EH_Func_Args_Ctrl_HTMLLink)                                      \
    XX(IMEChar, void, EH_Func_Args_Ctrl_IMEChar)                                        \
    XX(IMEComposition, void, EH_Func_Args_Ctrl_IMEComposition)                          \
    XX(KeyDown, std::optional<bool>, EH_Func_Args_Ctrl_KeyDown)                         \
    XX(KeyUp, std::optional<bool>, EH_Func_Args_Ctrl_KeyUp)                             \
    XX(KillFocus, void, EH_Func_Args_Ctrl_KillFocus)                                    \
    XX(LBDblClick, void, EH_Func_Args_Ctrl_LBDblClick)                                  \
    XX(LBDrag, void, EH_Func_Args_Ctrl_LBDrag)                                          \
    XX(LBDragging, void, EH_Func_Args_Ctrl_LBDragging)                                  \
    XX(LBDrop, void, EH_Func_Args_Ctrl_LBDrop)                                          \
    XX(LBListSelChanged, void, EH_Func_Args_Ctrl_LBListSelChanged)                      \
    XX(LBSelChanged, void, EH_Func_Args_Ctrl_LBSelChanged)                              \
    XX(Load, void, EH_Func_Args_Ctrl_Load)                                              \
    XX(MenuSelected, void, EH_Func_Args_Ctrl_MenuSelected)                              \
    XX(MouseButtonClick, std::optional<bool>, EH_Func_Args_Ctrl_MouseButtonClick)       \
    XX(MouseButtonDblClick, std::optional<bool>, EH_Func_Args_Ctrl_MouseButtonDblClick) \
    XX(MouseButtonDown, std::optional<bool>, EH_Func_Args_Ctrl_MouseButtonDown)         \
    XX(MouseButtonUp, std::optional<bool>, EH_Func_Args_Ctrl_MouseButtonUp)             \
    XX(MouseEnter, void, EH_Func_Args_Ctrl_MouseEnter)                                  \
    XX(MouseExit, void, EH_Func_Args_Ctrl_MouseExit)                                    \
    XX(MouseHolding, void, EH_Func_Args_Ctrl_MouseHolding)                              \
    XX(MouseMoving, void, EH_Func_Args_Ctrl_MouseMoving)                                \
    XX(MouseZChanged, void, EH_Func_Args_Ctrl_MouseZChanged)                            \
    XX(ObjectMoved, void, EH_Func_Args_Ctrl_ObjectMoved)                                \
    XX(SetFocus, void, EH_Func_Args_Ctrl_SetFocus)                                      \
    XX(SliderPosChanged, void, EH_Func_Args_Ctrl_SliderPosChanged)                      \
    XX(ToolBoxSelChanged, void, EH_Func_Args_Ctrl_ToolBoxSelChanged)                    \
    XX(TreeCollapsed, void, EH_Func_Args_Ctrl_TreeCollapsed)                            \
    XX(TreeDblClick, void, EH_Func_Args_Ctrl_TreeDblClick)                              \
    XX(TreeExpanded, void, EH_Func_Args_Ctrl_TreeExpanded)                              \
    XX(TreeLButtonDown, void, EH_Func_Args_Ctrl_TreeLButtonDown)                        \
    XX(TreeMouseExit, void, EH_Func_Args_Ctrl_TreeMouseExit)                            \
    XX(TreeMouseHold, void, EH_Func_Args_Ctrl_TreeMouseHold)                            \
    XX(TreeMouseMove, void, EH_Func_Args_Ctrl_TreeMouseMove)                            \
    XX(TreeSelChanged, void, EH_Func_Args_Ctrl_TreeSelChanged)                          \
    XX(VideoStopped, void, EH_Func_Args_Ctrl_VideoStopped)
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 619](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L619)
## COMPILETIME_CHECK_ENUM_CTRL(name, retVal, funcArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: funcArg

Replaced value:
```sqf
static_assert(eventhandlers_ctrl::name >= eventhandlers_ctrl::ButtonClick);
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 667](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L667)
## EH_Add_Ctrl_definition(name, retVal, fncArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: fncArg

Replaced value:
```sqf
\
    template <>                                                                                                                                               \
    struct __ctrlAddEventHandler_Impl<eventhandlers_ctrl::name> {                                                                                             \
        using fncType = std::function<retVal(fncArg)>;                                                                                                        \
        [[nodiscard]] static EHIdentifier add(types::control ctrl, std::function<retVal(fncArg)> function) {                                                  \
            auto ident = addScriptEH(ctrl, eventhandlers_ctrl::name);                                                                                         \
            funcMapCtrlEH[ident] = {eventhandlers_ctrl::name, std::make_shared<std::function<void()>>(*reinterpret_cast<std::function<void()>*>(&function))}; \
            return ident;                                                                                                                                     \
        }                                                                                                                                                     \
    };
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 736](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L736)
## EH_Func_Args_MP_MPHit

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object caused_by, float damage, types::object instigator
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 765](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L765)
## EH_Func_Args_MP_MPKilled

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object killer, types::object instigator, bool use_effects
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 766](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L766)
## EH_Func_Args_MP_MPRespawn

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::object unit, types::object corpse
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 767](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L767)
## EHDEF_MP(XX)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: Name,Function return value, Function Arguments
- Param: XX

Replaced value:
```sqf
\
    XX(MPHit, void, EH_Func_Args_MP_MPHit)       \
    XX(MPKilled, void, EH_Func_Args_MP_MPKilled) \
    XX(MPRespawn, types::vector3, EH_Func_Args_MP_MPRespawn)
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 770](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L770)
## COMPILETIME_CHECK_ENUM_MP(name, retVal, funcArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: funcArg

Replaced value:
```sqf
static_assert(eventhandlers_mp::name >= eventhandlers_mp::MPHit);
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 775](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L775)
## EH_Add_MP_definition(name, retVal, fncArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: fncArg

Replaced value:
```sqf
\
    template <>                                                                                                                                               \
    struct __addMPEventHandler_Impl<eventhandlers_mp::name> {                                                                                             \
        using fncType = std::function<retVal(fncArg)>;                                                                                                        \
        [[nodiscard]] static EHIdentifier add(types::object unit, std::function<retVal(fncArg)> function) {                                                  \
            auto ident = addScriptEH(unit, eventhandlers_mp::name);                                                                                         \
            funcMapMPEH[ident] = {eventhandlers_mp::name, std::make_shared<std::function<void()>>(*reinterpret_cast<std::function<void()>*>(&function))}; \
            return ident;                                                                                                                                     \
        }                                                                                                                                                     \
    };
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 801](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L801)
## EH_Func_Args_Display_Load

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 831](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L831)
## EH_Func_Args_Display_Unload

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, float exit_code
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 832](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L832)
## EH_Func_Args_Display_ChildDestroyed

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, types::display closed_disp, float exit_code
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 833](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L833)
## EH_Func_Args_Display_KeyDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, int dik, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 834](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L834)
## EH_Func_Args_Display_KeyUp

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, int dik, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 835](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L835)
## EH_Func_Args_Display_MouseMoving

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, float delta_x, float delta_y
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 836](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L836)
## EH_Func_Args_Display_MouseZChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, float change
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 837](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L837)
## EH_Func_Args_Display_MouseButtonDown

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, int button, float x_pos, float y_pos, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 838](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L838)
## EH_Func_Args_Display_MouseButtonUp

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, int button, float x_pos, float y_pos, bool shift, bool ctrl, bool alt
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 839](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L839)
## EH_Func_Args_Display_MouseHolding

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, float x_pos, float y_pos
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 840](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L840)
## EH_Func_Args_Display_Char

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::display disp, int char_code
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 841](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L841)
## EHDEF_Display(XX)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: Name,Function return value, Function Arguments
- Param: XX

Replaced value:
```sqf
\
    XX(Char, void, EH_Func_Args_Display_Char)                                      \
    XX(ChildDestroyed, void, EH_Func_Args_Display_ChildDestroyed)                  \
    XX(KeyDown, std::optional<bool>, EH_Func_Args_Display_KeyDown)                 \
    XX(KeyUp, std::optional<bool>, EH_Func_Args_Display_KeyUp)                     \
    XX(Load, void, EH_Func_Args_Display_Load)                                      \
    XX(MouseButtonDown, std::optional<bool>, EH_Func_Args_Display_MouseButtonDown) \
    XX(MouseButtonUp, std::optional<bool>, EH_Func_Args_Display_MouseButtonUp)     \
    XX(MouseHolding, void, EH_Func_Args_Display_MouseHolding)                      \
    XX(MouseMoving, void, EH_Func_Args_Display_MouseMoving)                        \
    XX(MouseZChanged, void, EH_Func_Args_Display_MouseZChanged)                    \
    XX(Unload, void, EH_Func_Args_Display_Unload)
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 845](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L845)
## COMPILETIME_CHECK_ENUM_Display(name, retVal, funcArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: funcArg

Replaced value:
```sqf
static_assert(eventhandlers_display::name >= eventhandlers_display::Char);
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 858](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L858)
## EH_Add_Display_definition(name, retVal, fncArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: fncArg

Replaced value:
```sqf
\
    template <>                                                                                                                                               \
    struct __displayAddEventHandler_Impl<eventhandlers_display::name> {                                                                                             \
        using fncType = std::function<retVal(fncArg)>;                                                                                                        \
        [[nodiscard]] static EHIdentifier add(types::display disp, std::function<retVal(fncArg)> function) {                                                  \
            auto ident = addScriptEH(disp, eventhandlers_display::name);                                                                                         \
            funcMapDisplayEH[ident] = {eventhandlers_display::name, std::make_shared<std::function<void()>>(*reinterpret_cast<std::function<void()>*>(&function))}; \
            return ident;                                                                                                                                     \
        }                                                                                                                                                     \
    };
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 892](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L892)
## EH_Func_Args_Group_UnitJoined

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object newUnit
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 921](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L921)
## EH_Func_Args_Group_UnitLeft

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object oldUnit
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 922](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L922)
## EH_Func_Args_Group_VehicleAdded

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object newVehicle
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 923](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L923)
## EH_Func_Args_Group_VehicleRemoved

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object oldVehicle
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 924](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L924)
## EH_Func_Args_Group_Empty

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 925](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L925)
## EH_Func_Args_Group_Deleted

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 926](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L926)
## EH_Func_Args_Group_Local

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 927](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L927)
## EH_Func_Args_Group_CombatModeChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::r_string newMode
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 928](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L928)
## EH_Func_Args_Group_CommandChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::r_string newCommand
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 929](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L929)
## EH_Func_Args_Group_FormationChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::r_string newFormation
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 930](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L930)
## EH_Func_Args_Group_SpeedModeChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::r_string newSpeedmode
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 931](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L931)
## EH_Func_Args_Group_EnableAttackChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, bool attackEnabled
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 932](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L932)
## EH_Func_Args_Group_LeaderChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object newLeader
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 933](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L933)
## EH_Func_Args_Group_GroupIdChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::r_string newGroupID
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 934](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L934)
## EH_Func_Args_Group_KnowsAboutChanged

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object targetUnit, int newKnowsAbout, int oldKnowsAbout
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 935](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L935)
## EH_Func_Args_Group_WaypointComplete

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, int waypointIndex
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 936](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L936)
## EH_Func_Args_Group_Fleeing

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, bool fleeingNow
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 937](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L937)
## EH_Func_Args_Group_EnemyDetected

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


Replaced value:
```sqf
types::group grp, types::object newTarget
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 938](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L938)
## EHDEF_Group(XX)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: Name,Function return value, Function Arguments
- Param: XX

Replaced value:
```sqf
\
    XX(UnitJoined, void, EH_Func_Args_Group_UnitJoined)                                      \
    XX(UnitLeft, void, EH_Func_Args_Group_UnitLeft)                                      \
    XX(VehicleAdded, void, EH_Func_Args_Group_VehicleAdded)                                      \
    XX(VehicleRemoved, void, EH_Func_Args_Group_VehicleRemoved)                                      \
    XX(Empty, void, EH_Func_Args_Group_Empty)                                      \
    XX(Deleted, void, EH_Func_Args_Group_Deleted)                                      \
    XX(Local, void, EH_Func_Args_Group_Local)                                      \
    XX(CombatModeChanged, void, EH_Func_Args_Group_CombatModeChanged)                                      \
    XX(CommandChanged, void, EH_Func_Args_Group_CommandChanged)                                      \
    XX(FormationChanged, void, EH_Func_Args_Group_FormationChanged)                                      \
    XX(SpeedModeChanged, void, EH_Func_Args_Group_SpeedModeChanged)                                      \
    XX(EnableAttackChanged, void, EH_Func_Args_Group_EnableAttackChanged)                                      \
    XX(LeaderChanged, void, EH_Func_Args_Group_LeaderChanged)                                      \
    XX(GroupIdChanged, void, EH_Func_Args_Group_GroupIdChanged)                                      \
    XX(KnowsAboutChanged, void, EH_Func_Args_Group_KnowsAboutChanged)                                      \
    XX(WaypointComplete, void, EH_Func_Args_Group_WaypointComplete)                                      \
    XX(Fleeing, void, EH_Func_Args_Group_Fleeing)                                      \
    XX(EnemyDetected, void, EH_Func_Args_Group_EnemyDetected)
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 942](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L942)
## COMPILETIME_CHECK_ENUM_Group(name, retVal, funcArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: funcArg

Replaced value:
```sqf
static_assert(eventhandlers_group::name >= eventhandlers_group::UnitJoined);
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 962](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L962)
## EH_Add_Group_definition(name, retVal, fncArg)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: fncArg

Replaced value:
```sqf
\
    template <>                                                                                                                                                     \
    struct __groupAddEventHandler_Impl<eventhandlers_group::name> {                                                                                             \
        using fncType = std::function<retVal(fncArg)>;                                                                                                              \
        [[nodiscard]] static EHIdentifier add(types::group grp, std::function<retVal(fncArg)> function) {                                                        \
            auto ident = addScriptEH(grp, eventhandlers_group::name);                                                                                            \
            funcMapGroupEH[ident] = {eventhandlers_group::name, std::make_shared<std::function<void()>>(*reinterpret_cast<std::function<void()>*>(&function))}; \
            return ident;                                                                                                                                           \
        }                                                                                                                                                           \
    };
```
File: [RVEngine\src\client\headers\client\eventhandlers.hpp at line 1003](../../../Src/RVEngine/src/client/headers/client/eventhandlers.hpp#L1003)
# ai.hpp

## markers_

Type: function

Description: 


File: [RVEngine\src\client\headers\client\sqf\ai.hpp at line 131](../../../Src/RVEngine/src/client/headers/client/sqf/ai.hpp#L131)
# sound.hpp

## markers_

Type: function

Description: 


File: [RVEngine\src\client\headers\client\sqf\sound.hpp at line 69](../../../Src/RVEngine/src/client/headers/client/sqf/sound.hpp#L69)
# sqf.hpp

## __XXXSQF_QUOTE(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
#__VA_ARGS__
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 33](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L33)
## __XXXSQF_EXPAND_AND_QUOTE(str)

Type: constant

Description: 
- Param: str

Replaced value:
```sqf
__XXXSQF_QUOTE(str)
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 34](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L34)
## __XXXSQF_L1(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
__SQF(##__VA_ARGS__##)__SQF
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 35](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L35)
## __XXXSQF_L2(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
__XXXSQF_EXPAND_AND_QUOTE(__XXXSQF_L1(__VA_ARGS__))
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 36](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L36)
## __XXXSQF_CAT(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
a##b
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 38](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L38)
## __XXXSQF_EXPAND_AND_CAT(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
__XXXSQF_CAT(a,b)
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 39](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L39)
## __XXXSQF_ARG(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
__XXXSQF_EXPAND_AND_CAT(R,__XXXSQF_L2(__VA_ARGS__))
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 41](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L41)
## __SQF(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
__inline_sqf_helper_launcher::generate(__XXXSQF_ARG(__VA_ARGS__))
```
File: [RVEngine\src\client\headers\client\sqf\sqf.hpp at line 43](../../../Src/RVEngine/src/client/headers/client/sqf/sqf.hpp#L43)
# tasks.hpp

## parent_task_

Type: function

Description: 


File: [RVEngine\src\client\headers\client\sqf\tasks.hpp at line 53](../../../Src/RVEngine/src/client/headers/client/sqf/tasks.hpp#L53)
# units.hpp

## markers_

Type: function

Description: 


File: [RVEngine\src\client\headers\client\sqf\units.hpp at line 94](../../../Src/RVEngine/src/client/headers/client/sqf/units.hpp#L94)
# vehicles.hpp

## markers_

Type: function

Description: 


File: [RVEngine\src\client\headers\client\sqf\vehicles.hpp at line 447](../../../Src/RVEngine/src/client/headers/client/sqf/vehicles.hpp#L447)
# client_types.hpp

## RV_GENERIC_OBJECT_DEC(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
class type : public internal_object {\
        public:\
            type();\
            type(const game_value &value_);\
            type(const type &copy_);\
            type(const internal_object &copy_) = delete;/*prevents code(object()) You can't convert object to code!*/\
            type(type &&move_);\
            type & operator = (type &&move_);\
            type & operator = (const type &copy_);\
        }
```
File: [RVEngine\src\client\headers\shared\client_types.hpp at line 21](../../../Src/RVEngine/src/client/headers/shared/client_types.hpp#L21)
## DEFINE_HASH_FUNCTION_FOR_CLASS(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
template <> struct hash<intercept::types::type> { \
        size_t operator()(const intercept::types::type& x) const { \
            return x.get_hash(); \
        } \
    }; 
```
File: [RVEngine\src\client\headers\shared\client_types.hpp at line 525](../../../Src/RVEngine/src/client/headers/shared/client_types.hpp#L525)
# functions.hpp

## INTERCEPT_SDK_API_VERSION

Type: constant

Description: 3: Pass type pointers instead of instance for register_sqf_type/register_compound_sqf_type


Replaced value:
```sqf
3
```
File: [RVEngine\src\client\headers\shared\functions.hpp at line 23](../../../Src/RVEngine/src/client/headers/shared/functions.hpp#L23)
# eventhandlers.cpp

## EHMISS_CASE(name, retVal, args)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: args

Replaced value:
```sqf
\
    case eventhandlers_mission::name: typeStr = #name##sv; break;
```
File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 210](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L210)
## EHOBJ_CASE(name, retVal, args)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: args

Replaced value:
```sqf
\
    case eventhandlers_object::name: typeStr = #name##sv; break;
```
File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 541](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L541)
## EHCTRL_CASE(name, retVal, args)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: args

Replaced value:
```sqf
\
    case eventhandlers_ctrl::name: typeStr = #name##sv; break;
```
File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 681](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L681)
## EHMP_CASE(name, retVal, args)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: args

Replaced value:
```sqf
\
    case eventhandlers_mp::name: typeStr = #name##sv; break;
```
File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 740](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L740)
## EHDisplay_CASE(name, retVal, args)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: args

Replaced value:
```sqf
\
    case eventhandlers_display::name: typeStr = #name##sv; break;
```
File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 830](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L830)
## EHGroup_CASE(name, retVal, args)

Type: constant

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 
- Param: name
- Param: retVal
- Param: args

Replaced value:
```sqf
\
    case eventhandlers_group::name: typeStr = #name##sv; break;
```
File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 948](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L948)
## type_

Type: function

> Exists if **INTERCEPT_NO_SQF** not defined

Description: 


File: [RVEngine\src\client\intercept\client\eventhandlers.cpp at line 101](../../../Src/RVEngine/src/client/intercept/client/eventhandlers.cpp#L101)
# client_types.cpp

## RV_GENERIC_OBJECT_DEF(type)

Type: constant

Description: 
- Param: type

Replaced value:
```sqf
type::type() : internal_object() {}\
    type::type(const game_value & value_) : internal_object(value_) {}\
    type::type(const type &copy_) : internal_object(copy_) {}\
    type::type(type && move_) : internal_object(std::move(move_)) {}\
    type & type::operator=(type && move_) {\
        if (this == &move_)\
            return *this;\
        game_value::operator=(std::move(move_));\
        return *this;\
    }\
    type & type::operator=(const type & copy_) {\
        game_value::operator=(copy_);\
        return *this;\
    }
```
File: [RVEngine\src\client\intercept\shared\client_types.cpp at line 37](../../../Src/RVEngine/src/client/intercept/shared/client_types.cpp#L37)
# containers.cpp

## GET_ENGINE_ALLOCATOR

Type: constant

Description: 


Replaced value:
```sqf
client::host::functions.get_engine_allocator()
```
File: [RVEngine\src\client\intercept\shared\containers.cpp at line 9](../../../Src/RVEngine/src/client/intercept/shared/containers.cpp#L9)
# types.cpp

## GET_ENGINE_ALLOCATOR

Type: constant

Description: 


Replaced value:
```sqf
client::host::functions.get_engine_allocator()
```
File: [RVEngine\src\client\intercept\shared\types.cpp at line 12](../../../Src/RVEngine/src/client/intercept/shared/types.cpp#L12)
# common.hpp

## ZERO_OUTPUT()

Type: constant

> Exists if **_DEBUG** defined

Description: 
- Param: 

Replaced value:
```sqf
{ memset(output, 0x00, outputSize); }
```
File: [RVEngine\src\host\common\common.hpp at line 17](../../../Src/RVEngine/src/host/common/common.hpp#L17)
## EXTENSION_RETURN()

Type: constant

> Exists if **_DEBUG** defined

Description: Needed to bypass Arma erroring because in debug uninitialized memory will be filled with marker, and Arma checks for null char at end to detect buffer overflow
- Param: 

Replaced value:
```sqf
{output[outputSize-1] = 0x00; } return;
```
File: [RVEngine\src\host\common\common.hpp at line 19](../../../Src/RVEngine/src/host/common/common.hpp#L19)
## ZERO_OUTPUT()

Type: constant

> Exists if **_DEBUG** not defined

Description: 
- Param: 

Replaced value:
```sqf

```
File: [RVEngine\src\host\common\common.hpp at line 21](../../../Src/RVEngine/src/host/common/common.hpp#L21)
## EXTENSION_RETURN()

Type: constant

> Exists if **_DEBUG** not defined

Description: Needed to bypass Arma erroring because in debug uninitialized memory will be filled with marker, and Arma checks for null char at end to detect buffer overflow
- Param: 

Replaced value:
```sqf
return;
```
File: [RVEngine\src\host\common\common.hpp at line 22](../../../Src/RVEngine/src/host/common/common.hpp#L22)
## sleep(x)

Type: constant

> Exists if **_WIN32** defined

Description: 
- Param: x

Replaced value:
```sqf
Sleep(x)
```
File: [RVEngine\src\host\common\common.hpp at line 26](../../../Src/RVEngine/src/host/common/common.hpp#L26)
## INTERCEPT_ASSERT

Type: constant

> Exists if **_DEBUG** defined

Description: 


Replaced value:
```sqf
assert()
```
File: [RVEngine\src\host\common\common.hpp at line 66](../../../Src/RVEngine/src/host/common/common.hpp#L66)
## INTERCEPT_ASSERT

Type: constant

> Exists if **_DEBUG** not defined

Description: 


Replaced value:
```sqf
intercept::runtime_assert()
```
File: [RVEngine\src\host\common\common.hpp at line 68](../../../Src/RVEngine/src/host/common/common.hpp#L68)
# easyloggingc++.hpp

## SPDLOG_TRACE_ON

Type: constant

> Exists if **_DEBUG** defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 13](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L13)
## _SILENCE_CXX17_OLD_ALLOCATOR_MEMBERS_DEPRECATION_WARNING

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 15](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L15)
## TRACE(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
SPDLOG_TRACE(logging::logfile, __VA_ARGS__)
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 17](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L17)
## TRACE_IF(flag, ...)

Type: constant

Description: 
- Param: flag
- Param: ...

Replaced value:
```sqf
SPDLOG_TRACE(logging::logfile, flag, __VA_ARGS__))
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 18](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L18)
## INFO

Type: constant

Description: 


Replaced value:
```sqf
logging::logfile->info
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 20](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L20)
## DEBUG

Type: constant

Description: 


Replaced value:
```sqf
logging::logfile->debug
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 21](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L21)
## WARNING

Type: constant

Description: 


Replaced value:
```sqf
logging::logfile->warn
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 22](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L22)
## ERROR

Type: constant

Description: 


Replaced value:
```sqf
logging::logfile->error
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 26](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L26)
## LOG(LEVEL, ...)

Type: constant

Description: 
- Param: LEVEL
- Param: ...

Replaced value:
```sqf
LEVEL(__VA_ARGS__)
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 28](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L28)
## INITIALIZE_EASYLOGGINGPP

Type: constant

Description: 


Replaced value:
```sqf
std::shared_ptr<spdlog::logger> logging::logfile{};
```
File: [RVEngine\src\host\common\easyloggingc++.hpp at line 30](../../../Src/RVEngine/src/host/common/easyloggingc++.hpp#L30)
# logging.hpp

## ELPP_THREAD_SAFE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\logging.hpp at line 2](../../../Src/RVEngine/src/host/common/logging.hpp#L2)
## ELPP_FORCE_USE_STD_THREAD

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\logging.hpp at line 3](../../../Src/RVEngine/src/host/common/logging.hpp#L3)
## ELPP_NO_DEFAULT_LOG_FILE

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\logging.hpp at line 4](../../../Src/RVEngine/src/host/common/logging.hpp#L4)
## ELPP_DISABLE_DEFAULT_CRASH_HANDLING

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\logging.hpp at line 5](../../../Src/RVEngine/src/host/common/logging.hpp#L5)
# singleton.hpp

## __forceinline

Type: constant

> Exists if **__GNUC__** defined

Description: 


Replaced value:
```sqf
__attribute__((always_inline))
```
File: [RVEngine\src\host\common\singleton.hpp at line 8](../../../Src/RVEngine/src/host/common/singleton.hpp#L8)
# common.h

## SPDLOG_NOEXCEPT

Type: constant

Description: 


Replaced value:
```sqf
noexcept
```
File: [RVEngine\src\host\common\system\spdlog\common.h at line 28](../../../Src/RVEngine/src/host/common/system/spdlog/common.h#L28)
## SPDLOG_CONSTEXPR

Type: constant

Description: 


Replaced value:
```sqf
constexpr
```
File: [RVEngine\src\host\common\system\spdlog\common.h at line 29](../../../Src/RVEngine/src/host/common/system/spdlog/common.h#L29)
## SPDLOG_FINAL

Type: constant

Description: 


Replaced value:
```sqf
final
```
File: [RVEngine\src\host\common\system\spdlog\common.h at line 36](../../../Src/RVEngine/src/host/common/system/spdlog/common.h#L36)
## SPDLOG_DEPRECATED

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\common.h at line 44](../../../Src/RVEngine/src/host/common/system/spdlog/common.h#L44)
## SPDLOG_LEVEL_NAMES

Type: constant

Description: 


Replaced value:
```sqf
{ "trace", "debug", "info",  "warning", "error", "critical", "off" }
```
File: [RVEngine\src\host\common\system\spdlog\common.h at line 86](../../../Src/RVEngine/src/host/common/system/spdlog/common.h#L86)
# spdlog.h

## SPDLOG_VERSION

Type: constant

Description: 


Replaced value:
```sqf
"0.16.3"
```
File: [RVEngine\src\host\common\system\spdlog\spdlog.h at line 10](../../../Src/RVEngine/src/host/common/system/spdlog/spdlog.h#L10)
# os.h

## NOMINMAX

Type: constant

> Exists if **NOMINMAX** not defined

Description: 


Replaced value:
```sqf
//prevent windows redefining min/max
```
File: [RVEngine\src\host\common\system\spdlog\details\os.h at line 24](../../../Src/RVEngine/src/host/common/system/spdlog/details/os.h#L24)
## WIN32_LEAN_AND_MEAN

Type: constant

> Exists if **WIN32_LEAN_AND_MEAN** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\details\os.h at line 28](../../../Src/RVEngine/src/host/common/system/spdlog/details/os.h#L28)
## __has_feature(x)

Type: constant

> Exists if **__has_feature** not defined

Description: Clang - feature checking macros.
- Param: x

Replaced value:
```sqf
0  // Compatibility with non-clang compilers.
```
File: [RVEngine\src\host\common\system\spdlog\details\os.h at line 53](../../../Src/RVEngine/src/host/common/system/spdlog/details/os.h#L53)
## SPDLOG_EOL

Type: constant

> Exists if **_WIN32** defined

Description: 


Replaced value:
```sqf
"\r\n"
```
File: [RVEngine\src\host\common\system\spdlog\details\os.h at line 137](../../../Src/RVEngine/src/host/common/system/spdlog/details/os.h#L137)
## SPDLOG_EOL

Type: constant

> Exists if **_WIN32** not defined

Description: 


Replaced value:
```sqf
"\n"
```
File: [RVEngine\src\host\common\system\spdlog\details\os.h at line 139](../../../Src/RVEngine/src/host/common/system/spdlog/details/os.h#L139)
## SPDLOG_FILENAME_T(s)

Type: constant

Description: 
- Param: s

Replaced value:
```sqf
s
```
File: [RVEngine\src\host\common\system\spdlog\details\os.h at line 386](../../../Src/RVEngine/src/host/common/system/spdlog/details/os.h#L386)
# fmt.h

## FMT_HEADER_ONLY

Type: constant

> Exists if **FMT_HEADER_ONLY** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\fmt.h at line 16](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/fmt.h#L16)
## FMT_USE_WINDOWS_H

Type: constant

> Exists if **FMT_USE_WINDOWS_H** not defined

Description: 


Replaced value:
```sqf
0
```
File: [RVEngine\src\host\common\system\spdlog\fmt\fmt.h at line 19](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/fmt.h#L19)
# format.h

## FMT_FORMAT_H_

Type: constant

> Exists if **FMT_FORMAT_H_** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 29](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L29)
## FMT_INCLUDE

Type: constant

> Exists if **FMT_FORMAT_H_** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 31](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L31)
## FMT_VERSION

Type: constant

> Exists if **FMT_FORMAT_H_** not defined

Description: The fmt library version in the form major * 10000 + minor * 100 + patch.


Replaced value:
```sqf
40100
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 46](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L46)
## FMT_SPECIALIZE_MAKE_UNSIGNED(T, U)

Type: constant

Description: 
- Param: T
- Param: U

Replaced value:
```sqf
\
  template <> \
  struct MakeUnsigned<T> { typedef U Type; }
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 698](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L698)
## FMT_DISABLE_CONVERSION_TO_INT(Type)

Type: constant

Description: 
- Param: Type

Replaced value:
```sqf
\
  template <> \
  struct ConvertToInt<Type> {  enum { value = 0 }; }
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1266](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1266)
## FMT_CONCAT(a, b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
a##b
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1312](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1312)
## FMT_MAKE_VALUE_(Type, field, TYPE, rhs)

Type: constant

Description: 
- Param: Type
- Param: field
- Param: TYPE
- Param: rhs

Replaced value:
```sqf
\
  MakeValue(Type value) { field = rhs; } \
  static uint64_t type(Type) { return Arg::TYPE; }
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1395](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1395)
## FMT_MAKE_VALUE(Type, field, TYPE)

Type: constant

Description: 
- Param: Type
- Param: field
- Param: TYPE

Replaced value:
```sqf
\
  FMT_MAKE_VALUE_(Type, field, TYPE, value)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1395](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1395)
## FMT_MAKE_STR_VALUE(Type, TYPE)

Type: constant

Description: 
- Param: Type
- Param: TYPE

Replaced value:
```sqf
\
  MakeValue(Type value) { set_string(value); } \
  static uint64_t type(Type) { return Arg::TYPE; }
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1461](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1461)
## FMT_MAKE_WSTR_VALUE(Type, TYPE)

Type: constant

Description: 
- Param: Type
- Param: TYPE

Replaced value:
```sqf
\
  MakeValue(typename WCharHelper<Type, Char>::Supported value) { \
    set_string(value); \
  } \
  static uint64_t type(Type) { return Arg::TYPE; }
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1478](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1478)
## FMT_DISPATCH(call)

Type: constant

Description: 
- Param: call

Replaced value:
```sqf
static_cast<Impl*>(this)->call
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1632](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1632)
## FMT_DEFINE_INT_FORMATTERS(TYPE)

Type: constant

Description: 
- Param: TYPE

Replaced value:
```sqf
\
inline IntFormatSpec<TYPE, TypeSpec<'b'> > bin(TYPE value) { \
  return IntFormatSpec<TYPE, TypeSpec<'b'> >(value, TypeSpec<'b'>()); \
} \
 \
inline IntFormatSpec<TYPE, TypeSpec<'o'> > oct(TYPE value) { \
  return IntFormatSpec<TYPE, TypeSpec<'o'> >(value, TypeSpec<'o'>()); \
} \
 \
inline IntFormatSpec<TYPE, TypeSpec<'x'> > hex(TYPE value) { \
  return IntFormatSpec<TYPE, TypeSpec<'x'> >(value, TypeSpec<'x'>()); \
} \
 \
inline IntFormatSpec<TYPE, TypeSpec<'X'> > hexu(TYPE value) { \
  return IntFormatSpec<TYPE, TypeSpec<'X'> >(value, TypeSpec<'X'>()); \
} \
 \
template <char TYPE_CODE> \
inline IntFormatSpec<TYPE, AlignTypeSpec<TYPE_CODE> > pad( \
    IntFormatSpec<TYPE, TypeSpec<TYPE_CODE> > f, unsigned width) { \
  return IntFormatSpec<TYPE, AlignTypeSpec<TYPE_CODE> >( \
      f.value(), AlignTypeSpec<TYPE_CODE>(width, ' ')); \
} \
 \
/* For compatibility with older compilers we provide two overloads for pad, */ \
/* one that takes a fill character and one that doesn't. In the future this */ \
/* can be replaced with one overload making the template argument Char      */ \
/* default to char (C++11). */ \
template <char TYPE_CODE, typename Char> \
inline IntFormatSpec<TYPE, AlignTypeSpec<TYPE_CODE>, Char> pad( \
    IntFormatSpec<TYPE, TypeSpec<TYPE_CODE>, Char> f, \
    unsigned width, Char fill) { \
  return IntFormatSpec<TYPE, AlignTypeSpec<TYPE_CODE>, Char>( \
      f.value(), AlignTypeSpec<TYPE_CODE>(width, fill)); \
} \
 \
inline IntFormatSpec<TYPE, AlignTypeSpec<0> > pad( \
    TYPE value, unsigned width) { \
  return IntFormatSpec<TYPE, AlignTypeSpec<0> >( \
      value, AlignTypeSpec<0>(width, ' ')); \
} \
 \
template <typename Char> \
inline IntFormatSpec<TYPE, AlignTypeSpec<0>, Char> pad( \
   TYPE value, unsigned width, Char fill) { \
 return IntFormatSpec<TYPE, AlignTypeSpec<0>, Char>( \
     value, AlignTypeSpec<0>(width, fill)); \
}
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 1938](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L1938)
## FMT_FOR_EACH1(f, x0)

Type: constant

Description: (argument, index).
- Param: f
- Param: x0

Replaced value:
```sqf
f(x0, 0)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2504](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2504)
## FMT_FOR_EACH2(f, x0, x1)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1

Replaced value:
```sqf
\
  FMT_FOR_EACH1(f, x0), f(x1, 1)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2505](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2505)
## FMT_FOR_EACH3(f, x0, x1, x2)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2

Replaced value:
```sqf
\
  FMT_FOR_EACH2(f, x0 ,x1), f(x2, 2)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2507](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2507)
## FMT_FOR_EACH4(f, x0, x1, x2, x3)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3

Replaced value:
```sqf
\
  FMT_FOR_EACH3(f, x0, x1, x2), f(x3, 3)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2509](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2509)
## FMT_FOR_EACH5(f, x0, x1, x2, x3, x4)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3
- Param: x4

Replaced value:
```sqf
\
  FMT_FOR_EACH4(f, x0, x1, x2, x3), f(x4, 4)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2511](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2511)
## FMT_FOR_EACH6(f, x0, x1, x2, x3, x4, x5)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3
- Param: x4
- Param: x5

Replaced value:
```sqf
\
  FMT_FOR_EACH5(f, x0, x1, x2, x3, x4), f(x5, 5)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2513](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2513)
## FMT_FOR_EACH7(f, x0, x1, x2, x3, x4, x5, x6)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3
- Param: x4
- Param: x5
- Param: x6

Replaced value:
```sqf
\
  FMT_FOR_EACH6(f, x0, x1, x2, x3, x4, x5), f(x6, 6)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2515](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2515)
## FMT_FOR_EACH8(f, x0, x1, x2, x3, x4, x5, x6, x7)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3
- Param: x4
- Param: x5
- Param: x6
- Param: x7

Replaced value:
```sqf
\
  FMT_FOR_EACH7(f, x0, x1, x2, x3, x4, x5, x6), f(x7, 7)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2517](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2517)
## FMT_FOR_EACH9(f, x0, x1, x2, x3, x4, x5, x6, x7, x8)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3
- Param: x4
- Param: x5
- Param: x6
- Param: x7
- Param: x8

Replaced value:
```sqf
\
  FMT_FOR_EACH8(f, x0, x1, x2, x3, x4, x5, x6, x7), f(x8, 8)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2519](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2519)
## FMT_FOR_EACH10(f, x0, x1, x2, x3, x4, x5, x6, x7, x8, x9)

Type: constant

Description: 
- Param: f
- Param: x0
- Param: x1
- Param: x2
- Param: x3
- Param: x4
- Param: x5
- Param: x6
- Param: x7
- Param: x8
- Param: x9

Replaced value:
```sqf
\
  FMT_FOR_EACH9(f, x0, x1, x2, x3, x4, x5, x6, x7, x8), f(x9, 9)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2521](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2521)
## FMT_EXPAND(args)

Type: constant

Description: This is used to work around VC++ bugs in handling variadic macros.
- Param: args

Replaced value:
```sqf
args
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3619](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3619)
## FMT_NARG(...)

Type: constant

Description: Based on https://groups.google.com/forum/#!topic/comp.std.c/d-6Mj5Lko_s.
- Param: ...

Replaced value:
```sqf
FMT_NARG_(__VA_ARGS__, FMT_RSEQ_N())
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3623](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3623)
## FMT_NARG_(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
FMT_EXPAND(FMT_ARG_N(__VA_ARGS__))
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3624](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3624)
## FMT_ARG_N(_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, N, ...)

Type: constant

Description: 
- Param: _1
- Param: _2
- Param: _3
- Param: _4
- Param: _5
- Param: _6
- Param: _7
- Param: _8
- Param: _9
- Param: _10
- Param: N
- Param: ...

Replaced value:
```sqf
N
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3625](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3625)
## FMT_RSEQ_N()

Type: constant

Description: 
- Param: 

Replaced value:
```sqf
10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3626](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3626)
## FMT_FOR_EACH_(N, f, ...)

Type: constant

Description: 
- Param: N
- Param: f
- Param: ...

Replaced value:
```sqf
\
  FMT_EXPAND(FMT_CONCAT(FMT_FOR_EACH, N)(f, __VA_ARGS__))
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3628](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3628)
## FMT_FOR_EACH(f, ...)

Type: constant

Description: (argument, index).
- Param: f
- Param: ...

Replaced value:
```sqf
\
  FMT_EXPAND(FMT_FOR_EACH_(FMT_NARG(__VA_ARGS__), f, __VA_ARGS__))
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2504](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2504)
## FMT_ADD_ARG_NAME(type, index)

Type: constant

Description: 
- Param: type
- Param: index

Replaced value:
```sqf
type arg##index
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3633](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3633)
## FMT_GET_ARG_NAME(type, index)

Type: constant

Description: 
- Param: type
- Param: index

Replaced value:
```sqf
arg##index
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3634](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3634)
## FMT_VARIADIC(ReturnType, func, ...)

Type: constant

Description: 
- Param: ReturnType
- Param: func
- Param: ...

Replaced value:
```sqf
\
  FMT_VARIADIC_(, char, ReturnType, func, return func, __VA_ARGS__)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3708](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3708)
## FMT_VARIADIC_CONST(ReturnType, func, ...)

Type: constant

Description: 
- Param: ReturnType
- Param: func
- Param: ...

Replaced value:
```sqf
\
  FMT_VARIADIC_(const, char, ReturnType, func, return func, __VA_ARGS__)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3711](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3711)
## FMT_VARIADIC_W(ReturnType, func, ...)

Type: constant

Description: 
- Param: ReturnType
- Param: func
- Param: ...

Replaced value:
```sqf
\
  FMT_VARIADIC_(, wchar_t, ReturnType, func, return func, __VA_ARGS__)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3714](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3714)
## FMT_VARIADIC_CONST_W(ReturnType, func, ...)

Type: constant

Description: 
- Param: ReturnType
- Param: func
- Param: ...

Replaced value:
```sqf
\
  FMT_VARIADIC_(const, wchar_t, ReturnType, func, return func, __VA_ARGS__)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3717](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3717)
## FMT_CAPTURE_ARG_(id, index)

Type: constant

Description: 
- Param: id
- Param: index

Replaced value:
```sqf
::fmt::arg(#id, id)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3720](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3720)
## FMT_CAPTURE_ARG_W_(id, index)

Type: constant

Description: 
- Param: id
- Param: index

Replaced value:
```sqf
::fmt::arg(L###id, id)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3722](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3722)
## FMT_CAPTURE(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
FMT_FOR_EACH(FMT_CAPTURE_ARG_, __VA_ARGS__)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3720](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3720)
## FMT_CAPTURE_W(...)

Type: constant

Description: 
- Param: ...

Replaced value:
```sqf
FMT_FOR_EACH(FMT_CAPTURE_ARG_W_, __VA_ARGS__)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 3740](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L3740)
## start

Type: Variable

Description: 


Initial value:
```sqf
s = format(s, arg)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 4028](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L4028)
## format_str

Type: Variable

Description: 


Initial value:
```sqf
end + 1
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 4090](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L4090)
## str

Type: function

Description: 


File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2115](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2115)
## array

Type: function

Description: 


File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\format.h at line 2483](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/format.h#L2483)
# ostream.h

## FMT_OSTREAM_H_

Type: constant

> Exists if **FMT_OSTREAM_H_** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\ostream.h at line 11](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/ostream.h#L11)
# posix.h

## FMT_POSIX_H_

Type: constant

> Exists if **FMT_POSIX_H_** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\posix.h at line 11](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/posix.h#L11)
## FMT_RETRY(result, expression)

Type: constant

Description: 
- Param: result
- Param: expression

Replaced value:
```sqf
FMT_RETRY_VAL(result, expression, -1)
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\posix.h at line 65](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/posix.h#L65)
# printf.h

## FMT_PRINTF_H_

Type: constant

> Exists if **FMT_PRINTF_H_** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\printf.h at line 11](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/printf.h#L11)
# time.h

## FMT_TIME_H_

Type: constant

> Exists if **FMT_TIME_H_** not defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\time.h at line 11](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/time.h#L11)
## format_str

Type: Variable

Description: 


Initial value:
```sqf
end + 1
```
File: [RVEngine\src\host\common\system\spdlog\fmt\bundled\time.h at line 55](../../../Src/RVEngine/src/host/common/system/spdlog/fmt/bundled/time.h#L55)
# android_sink.h

## SPDLOG_ANDROID_RETRIES

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [RVEngine\src\host\common\system\spdlog\sinks\android_sink.h at line 20](../../../Src/RVEngine/src/host/common/system/spdlog/sinks/android_sink.h#L20)
# controller.cpp

## DEBUG_DISPATCH(x, y)

Type: constant

> Exists if **_DEBUG** defined

Description: 
- Param: x
- Param: y

Replaced value:
```sqf
{ std::string empty; _debug_display->call(x, arguments(y), empty); }
```
File: [RVEngine\src\host\controller\controller.cpp at line 10](../../../Src/RVEngine/src/host/controller/controller.cpp#L10)
## DEBUG_DISPATCH(x, y)

Type: constant

> Exists if **_DEBUG** not defined

Description: 
- Param: x
- Param: y

Replaced value:
```sqf

```
File: [RVEngine\src\host\controller\controller.cpp at line 12](../../../Src/RVEngine/src/host/controller/controller.cpp#L12)
# extensions.cpp

## PLUGIN_MIN_API_VERSION

Type: constant

Description: 3: Pass type pointers instead of instance for register_sqf_type/register_compound_sqf_type


Replaced value:
```sqf
2
```
File: [RVEngine\src\host\extensions\extensions.cpp at line 14](../../../Src/RVEngine/src/host/extensions/extensions.cpp#L14)
## GET_PROC_ADDR

Type: constant

> Exists if **__linux__** defined

Description: 


Replaced value:
```sqf
dlsym
```
File: [RVEngine\src\host\extensions\extensions.cpp at line 243](../../../Src/RVEngine/src/host/extensions/extensions.cpp#L243)
## GET_PROC_ADDR

Type: constant

> Exists if **__linux__** not defined

Description: 


Replaced value:
```sqf
GetProcAddress
```
File: [RVEngine\src\host\extensions\extensions.cpp at line 245](../../../Src/RVEngine/src/host/extensions/extensions.cpp#L245)
## EH_PROC_DEF(name, ...)

Type: constant

Description: 
- Param: name
- Param: ...

Replaced value:
```sqf
new_module.eventhandlers.name = (module::name##_func)GET_PROC_ADDR(dllHandle, #name);
```
File: [RVEngine\src\host\extensions\extensions.cpp at line 302](../../../Src/RVEngine/src/host/extensions/extensions.cpp#L302)
# extensions.hpp

## DLL_HANDLE

Type: constant

Description: 


Replaced value:
```sqf
HMODULE
```
File: [RVEngine\src\host\extensions\extensions.hpp at line 27](../../../Src/RVEngine/src/host/extensions/extensions.hpp#L27)
## EXP_FNC_typedef(name, ...)

Type: constant

Description: 
- Param: name
- Param: ...

Replaced value:
```sqf
typedef void(CDECL * name##_func)(__VA_ARGS__);
```
File: [RVEngine\src\host\extensions\extensions.hpp at line 30](../../../Src/RVEngine/src/host/extensions/extensions.hpp#L30)
## EXP_FNC_STRUCT_DEF(name, ...)

Type: constant

Description: 
- Param: name
- Param: ...

Replaced value:
```sqf
name##_func name;
```
File: [RVEngine\src\host\extensions\extensions.hpp at line 31](../../../Src/RVEngine/src/host/extensions/extensions.hpp#L31)
## EH_LIST(XX)

Type: constant

Description: name,arguments...
- Param: XX

Replaced value:
```sqf
\
    XX(anim_changed, object &unit_, r_string anim_name_)                                                                                  \
    XX(anim_done, object &unit_, r_string anim_name_)                                                                                     \
    XX(anim_state_changed, object &unit_, r_string anim_name_)                                                                            \
    XX(container_closed, object &container_, object &player_)                                                                             \
    XX(controls_shifted, object &vehicle_, object &new_controller_, object &old_controller_)                                              \
    XX(dammaged, object &unit_, r_string selection_name_, float damage_)                                                                  \
    XX(engine, object &vehicle_, bool engine_state_)                                                                                      \
    XX(epe_contact, object &object1_, object &object2_, r_string selection1_, r_string selection2_, float force_)                         \
    XX(epe_contact_end, object &object1_, object &object2_, r_string selection1_, r_string selection2_, float force_)                     \
    XX(epe_contact_start, object &object1_, object &object2_, r_string selection1_, r_string selection2_, float force_)                   \
    XX(explosion, object &vehicle_, float damage_)                                                                                        \
    XX(fired, object &unit_, r_string weapon_, r_string muzzle_, r_string mode_, r_string ammo_, r_string magazine, object &projectile_)  \
    XX(fired_near, object &unit_, object &firer_, float distance_, r_string weapon_, r_string muzzle_, r_string mode_, r_string ammo_)    \
    XX(fuel, object &vehicle_, bool fuel_state_)                                                                                          \
    XX(gear, object &vehicle_, bool gear_state_)                                                                                          \
    XX(get_in, object &vehicle_, r_string position_, object &unit_, rv_turret_path turret_path)                                           \
    XX(get_out, object &vehicle_, r_string position_, object &unit_, rv_turret_path turret_path)                                          \
    XX(handle_damage, object &unit_, r_string selection_name_, float damage_, object &source_, r_string projectile_, int hit_part_index_) \
    XX(handle_heal, object &unit_, object &healder_, bool healer_can_heal_)                                                               \
    XX(handle_rating, object &unit_, float rating_)                                                                                       \
    XX(handle_score, object &unit_, object &object_, float score_)                                                                        \
    XX(hit, object &unit_, object &caused_by_, float damage_)                                                                             \
    XX(hit_part, auto_array<hit_part_data> &data_)                                                                                        \
    XX(init, object &unit_)                                                                                                               \
    XX(incoming_missile, object &unit_, r_string ammo_, object &firer_)                                                                   \
    XX(inventory_closed, object &object_, object &container_)                                                                             \
    XX(inventory_opened, object &object_, object &container_)                                                                             \
    XX(killed, object &unit_, object &killer_)                                                                                            \
    XX(landed_touch_down, object &plane_, int airport_id_)                                                                                \
    XX(landed_stopped, object &plane_, int airport_id_)                                                                                   \
    XX(local, object &object_, bool local_)                                                                                               \
    XX(post_reset)                                                                                                                        \
    XX(put, object &unit_, object &container_, r_string item_)                                                                            \
    XX(respawn, object &unit_, object &corpse_)                                                                                           \
    XX(rope_attach, object &object1, object &rope_, object &object2_)                                                                     \
    XX(rope_break, object &object1, object &rope_, object &object2_)                                                                      \
    XX(seat_switched, object &vehicle_, object &unit1_, object &unit2_)                                                                   \
    XX(sound_played, object &unit_, int sound_code_)                                                                                      \
    XX(take, object &unit_, object &container_, r_string item_)                                                                           \
    XX(task_set_as_current, object &unit_, task &task_)                                                                                   \
    XX(weapon_assembled, object &unit_, object &weapon_)                                                                                  \
    XX(weapon_disassembled, object &unit_, object &primary_bag_, object &secondary_bag_)                                                  \
    XX(weapon_deployed, object &unit_, bool is_deployed_)                                                                                 \
    XX(weapon_rested, object &unit_, bool is_rested_)
```
File: [RVEngine\src\host\extensions\extensions.hpp at line 90](../../../Src/RVEngine/src/host/extensions/extensions.hpp#L90)
# search.cpp

## STATUS_INFO_LENGTH_MISMATCH

Type: constant

Description: Don't want to use a different ERROR macro than intended


Replaced value:
```sqf
0xc0000004
```
File: [RVEngine\src\host\extensions\search.cpp at line 137](../../../Src/RVEngine/src/host/extensions/search.cpp#L137)
## SystemHandleInformation

Type: constant

Description: 


Replaced value:
```sqf
16
```
File: [RVEngine\src\host\extensions\search.cpp at line 139](../../../Src/RVEngine/src/host/extensions/search.cpp#L139)
## SystemHandleInformationEx

Type: constant

Description: 


Replaced value:
```sqf
64
```
File: [RVEngine\src\host\extensions\search.cpp at line 140](../../../Src/RVEngine/src/host/extensions/search.cpp#L140)
## ObjectBasicInformation

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [RVEngine\src\host\extensions\search.cpp at line 142](../../../Src/RVEngine/src/host/extensions/search.cpp#L142)
## ObjectNameInformation

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [RVEngine\src\host\extensions\search.cpp at line 143](../../../Src/RVEngine/src/host/extensions/search.cpp#L143)
## ObjectTypeInformation

Type: constant

Description: 


Replaced value:
```sqf
2
```
File: [RVEngine\src\host\extensions\search.cpp at line 144](../../../Src/RVEngine/src/host/extensions/search.cpp#L144)
# signing.cpp

## policy2

Type: function

> Exists if **__linux__** not defined

Description: 


File: [RVEngine\src\host\extensions\signing.cpp at line 275](../../../Src/RVEngine/src/host/extensions/signing.cpp#L275)
## status2

Type: function

> Exists if **__linux__** not defined

Description: 


File: [RVEngine\src\host\extensions\signing.cpp at line 279](../../../Src/RVEngine/src/host/extensions/signing.cpp#L279)
## policy

Type: function

> Exists if **__linux__** not defined

Description: 


File: [RVEngine\src\host\extensions\signing.cpp at line 281](../../../Src/RVEngine/src/host/extensions/signing.cpp#L281)
## status

Type: function

> Exists if **__linux__** not defined

Description: 


File: [RVEngine\src\host\extensions\signing.cpp at line 284](../../../Src/RVEngine/src/host/extensions/signing.cpp#L284)
## returnCode

Type: function

> Exists if **__linux__** not defined

Description: 


File: [RVEngine\src\host\extensions\signing.cpp at line 306](../../../Src/RVEngine/src/host/extensions/signing.cpp#L306)
# signing.hpp

## CERT_ENTER

Type: constant

> Exists if **__linux__** not defined

Description: 


Replaced value:
```sqf
\
    HMODULE hmod;                                                                                                                               \
    if (auto pcToHeader = GetProcAddress(GetModuleHandleA("ntdll"), "RtlPcToFileHeader"); pcToHeader) {                                         \
        if (reinterpret_cast<void*(NTAPI *)(_In_ PVOID PcValue, _Out_ PVOID * BaseOfImage)>(pcToHeader)(_ReturnAddress(), (void**)&hmod)) {     \
            intercept::cert::current_security_class = intercept::extensions::get().get_module_security_class(reinterpret_cast<uintptr_t>(hmod));\
        }}
```
File: [RVEngine\src\host\extensions\signing.hpp at line 33](../../../Src/RVEngine/src/host/extensions/signing.hpp#L33)
## CERT_EXIT

Type: constant

> Exists if **__linux__** not defined

Description: 


Replaced value:
```sqf
intercept::cert::current_security_class = intercept::cert::signing::security_class::not_signed;
```
File: [RVEngine\src\host\extensions\signing.hpp at line 39](../../../Src/RVEngine/src/host/extensions/signing.hpp#L39)
## CERT_ENTER

Type: constant

> Exists if **__linux__** defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\extensions\signing.hpp at line 45](../../../Src/RVEngine/src/host/extensions/signing.hpp#L45)
## CERT_EXIT

Type: constant

> Exists if **__linux__** defined

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\extensions\signing.hpp at line 46](../../../Src/RVEngine/src/host/extensions/signing.hpp#L46)
# eventhandlers.cpp

## EH_EVENT_DEF(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
invoker::get().add_eventhandler(#x, std::bind(&eventhandlers::x, std::placeholders::_1));
```
File: [RVEngine\src\host\invoker\eventhandlers.cpp at line 22](../../../Src/RVEngine/src/host/invoker/eventhandlers.cpp#L22)
## EH_START(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
void eventhandlers::x(game_value_parameter args_) {\
        for (auto& module : extensions::get().modules()) {\
            if (module.second.eventhandlers.x) module.second.eventhandlers.x
```
File: [RVEngine\src\host\invoker\eventhandlers.cpp at line 136](../../../Src/RVEngine/src/host/invoker/eventhandlers.cpp#L136)
## EH_END

Type: constant

Description: 


Replaced value:
```sqf
;\
        }\
    }
```
File: [RVEngine\src\host\invoker\eventhandlers.cpp at line 140](../../../Src/RVEngine/src/host/invoker/eventhandlers.cpp#L140)
# eventhandlers.hpp

## EH_CLASS_DEF(x)

Type: constant

Description: 
- Param: x

Replaced value:
```sqf
static void x(game_value_parameter args_)
```
File: [RVEngine\src\host\invoker\eventhandlers.hpp at line 38](../../../Src/RVEngine/src/host/invoker/eventhandlers.hpp#L38)
# invoker.cpp

## structure

Type: function

Description: #TODO add nothing and Nil


File: [RVEngine\src\host\invoker\invoker.cpp at line 374](../../../Src/RVEngine/src/host/invoker/invoker.cpp#L374)
# sqf_functions.cpp

## UNUSED_FUNC_SWITCH_FOR_GAMETYPES(ptr,type)

Type: constant

Description: 
- Param: ptr
- Param: type

Replaced value:
```sqf
\
switch (_returnType) { \
    case GameDataType::SCALAR: \
        ptr->_operator->procedure_addr = reinterpret_cast<decltype(ptr->_operator->procedure_addr)>(&unusedSQFFunction<GameDataType::SCALAR>::type); \
    break; \
    case GameDataType::BOOL: \
        ptr->_operator->procedure_addr = reinterpret_cast<decltype(ptr->_operator->procedure_addr)>(&unusedSQFFunction<GameDataType::BOOL>::type); \
        break; \
    case GameDataType::ARRAY: \
        ptr->_operator->procedure_addr = reinterpret_cast<decltype(ptr->_operator->procedure_addr)>(&unusedSQFFunction<GameDataType::ARRAY>::type); \
        break; \
    case GameDataType::STRING: \
        ptr->_operator->procedure_addr = reinterpret_cast<decltype(ptr->_operator->procedure_addr)>(&unusedSQFFunction<GameDataType::STRING>::type); \
        break; \
    case GameDataType::OBJECT: \
        ptr->_operator->procedure_addr = reinterpret_cast<decltype(ptr->_operator->procedure_addr)>(&unusedSQFFunction<GameDataType::OBJECT>::type); \
        break; \
}
```
File: [RVEngine\src\host\invoker\sqf_functions.cpp at line 59](../../../Src/RVEngine/src/host/invoker/sqf_functions.cpp#L59)
# CommandScan.cpp

## CMDSC_TYPE

Type: constant

Description: 


Replaced value:
```sqf
Base
```
File: [RVEngine\src\host\loader\CommandScan.cpp at line 8](../../../Src/RVEngine/src/host/loader/CommandScan.cpp#L8)
## CT_VERSION

Type: constant

Description: 


Replaced value:
```sqf
0
```
File: [RVEngine\src\host\loader\CommandScan.cpp at line 9](../../../Src/RVEngine/src/host/loader/CommandScan.cpp#L9)
# CommandScan.hpp

## CMDSC_TYPE

Type: constant

> Exists if **CMDSC_TYPE** not defined

Description: 


Replaced value:
```sqf
Base
```
File: [RVEngine\src\host\loader\CommandScan.hpp at line 6](../../../Src/RVEngine/src/host/loader/CommandScan.hpp#L6)
## CONCAT_(a,b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
a ## b
```
File: [RVEngine\src\host\loader\CommandScan.hpp at line 10](../../../Src/RVEngine/src/host/loader/CommandScan.hpp#L10)
## CONCAT(a, b)

Type: constant

Description: 
- Param: a
- Param: b

Replaced value:
```sqf
CONCAT_(a,b)
```
File: [RVEngine\src\host\loader\CommandScan.hpp at line 10](../../../Src/RVEngine/src/host/loader/CommandScan.hpp#L10)
## BASE_NAMESPACE

Type: constant

Description: 


Replaced value:
```sqf
CONCAT(__CT, CMDSC_TYPE)
```
File: [RVEngine\src\host\loader\CommandScan.hpp at line 13](../../../Src/RVEngine/src/host/loader/CommandScan.hpp#L13)
# CommandScan214.cpp

## CMDSC_TYPE

Type: constant

Description: 


Replaced value:
```sqf
214
```
File: [RVEngine\src\host\loader\CommandScan214.cpp at line 10](../../../Src/RVEngine/src/host/loader/CommandScan214.cpp#L10)
## CT_VERSION

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [RVEngine\src\host\loader\CommandScan214.cpp at line 11](../../../Src/RVEngine/src/host/loader/CommandScan214.cpp#L11)
# CommandTypes.hpp

## CT_VERSION

Type: constant

> Exists if **CT_VERSION** not defined

Description: 


Replaced value:
```sqf
0
```
File: [RVEngine\src\host\loader\CommandTypes.hpp at line 5](../../../Src/RVEngine/src/host/loader/CommandTypes.hpp#L5)
# CommandTypesDynamic.hpp

## CT_NOALLOC

Type: constant

Description: This is old file set up to turn static memory address lookups, into dynamic ones that can switch based on a bool being set or not. This can be used to adjust for game updates changing structure sizes


Replaced value:
```sqf

```
File: [RVEngine\src\host\loader\CommandTypesDynamic.hpp at line 5](../../../Src/RVEngine/src/host/loader/CommandTypesDynamic.hpp#L5)
## CT_VERSION

Type: constant

Description: 


Replaced value:
```sqf
1
```
File: [RVEngine\src\host\loader\CommandTypesDynamic.hpp at line 14](../../../Src/RVEngine/src/host/loader/CommandTypesDynamic.hpp#L14)
# loader.cpp

## DEBUG_PTR(n)

Type: constant

> Exists if **LOADER_DEBUG** defined

Description: 
- Param: n

Replaced value:
```sqf
std::cerr << "intercept::loader: " << #n << ": 0x" << std::hex << n << std::endl
```
File: [RVEngine\src\host\loader\loader.cpp at line 26](../../../Src/RVEngine/src/host/loader/loader.cpp#L26)
## DEBUG_PTR(n)

Type: constant

> Exists if **LOADER_DEBUG** not defined

Description: 
- Param: n

Replaced value:
```sqf

```
File: [RVEngine\src\host\loader\loader.cpp at line 28](../../../Src/RVEngine/src/host/loader/loader.cpp#L28)
# MemorySection.cpp

## modInfo

Type: function

Description: 


File: [RVEngine\src\host\loader\MemorySection.cpp at line 13](../../../Src/RVEngine/src/host/loader/MemorySection.cpp#L13)
# ptraccess.h

## IsBadWritePtr(p,n)

Type: constant

> Exists if **__cplusplus** defined

Description: 
- Param: p
- Param: n

Replaced value:
```sqf
(!CheckAccess<dwWriteRights>(p,n))
```
File: [RVEngine\src\host\loader\ptraccess.h at line 41](../../../Src/RVEngine/src/host/loader/ptraccess.h#L41)
## IsBadReadPtr(p,n)

Type: constant

> Exists if **__cplusplus** defined

Description: 
- Param: p
- Param: n

Replaced value:
```sqf
(!CheckAccess<dwReadRights>(p,n))
```
File: [RVEngine\src\host\loader\ptraccess.h at line 42](../../../Src/RVEngine/src/host/loader/ptraccess.h#L42)
## IsBadStringPtrW(p,n)

Type: constant

> Exists if **__cplusplus** defined

Description: 
- Param: p
- Param: n

Replaced value:
```sqf
(!CheckAccess<dwReadRights>(p,n*2))
```
File: [RVEngine\src\host\loader\ptraccess.h at line 43](../../../Src/RVEngine/src/host/loader/ptraccess.h#L43)
## __CUSTOM_ISBADREADPTR

Type: constant

Description: 


Replaced value:
```sqf

```
File: [RVEngine\src\host\loader\ptraccess.h at line 46](../../../Src/RVEngine/src/host/loader/ptraccess.h#L46)
# main.cpp

## search_pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\main.cpp at line 181](../../../Src/RVEngine/src/plugins/rv_client/main.cpp#L181)
## target_pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\main.cpp at line 216](../../../Src/RVEngine/src/plugins/rv_client/main.cpp#L216)
## start_pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\main.cpp at line 251](../../../Src/RVEngine/src/plugins/rv_client/main.cpp#L251)
## end_pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\main.cpp at line 258](../../../Src/RVEngine/src/plugins/rv_client/main.cpp#L258)
## pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\main.cpp at line 181](../../../Src/RVEngine/src/plugins/rv_client/main.cpp#L181)
# navigation.cpp

## v1

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\navigation.cpp at line 425](../../../Src/RVEngine/src/plugins/rv_client/navigation.cpp#L425)
## v2

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\navigation.cpp at line 431](../../../Src/RVEngine/src/plugins/rv_client/navigation.cpp#L431)
## gv_pos1

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\navigation.cpp at line 462](../../../Src/RVEngine/src/plugins/rv_client/navigation.cpp#L462)
## gv_pos2

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\navigation.cpp at line 468](../../../Src/RVEngine/src/plugins/rv_client/navigation.cpp#L468)
# navigation_region.cpp

## prev_pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\navigation_region.cpp at line 502](../../../Src/RVEngine/src/plugins/rv_client/navigation_region.cpp#L502)
## hit_pos

Type: function

Description: 


File: [RVEngine\src\plugins\rv_client\navigation_region.cpp at line 509](../../../Src/RVEngine/src/plugins/rv_client/navigation_region.cpp#L509)
