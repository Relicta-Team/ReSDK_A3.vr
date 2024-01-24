//src:bbbf0ce8-c22c-4d54-93e4-d5f64032bc7c:Graphs\Roles\RAdventurerGMTemplateScripted.graph
//gdate:2024-01-24 18:57:36.038220
#include ".\resdk_graph.h"


editor_attribute("NodeClass")
class(RAdventurerGMTemplateScripted) extends(ScriptedRole)
// Code generated:

//p_field: name
["name",toString {"Приключенец"}] call pc_oop_regvar;
//p_field: desc
["desc",toString {"Он здесь чтобы повеселиться."}] call pc_oop_regvar;
//p_field: descInGame (default from ScriptedRole)
//p_field: classMan (default from ScriptedRole)
//p_field: classWoman (default from ScriptedRole)
//p_field: returnInLobbyAfterDead
["returnInLobbyAfterDead",toString {true}] call pc_oop_regvar;
//p_field: _deadTimeout (default from ScriptedRole)
//p_field: count
["count",toString {2}] call pc_oop_regvar;
//p_field: _currentBaseSkills
["_currentBaseSkills",toString {[[ 9.0, 9.0 ], [ 10.0, 12.0 ], [ 12.0, 16.0 ], [ 10.0, 12.0 ]]}] call pc_oop_regvar;
//p_field: _currentOtherSkills
["_currentOtherSkills",toString {[ [4/*enum.SkillType:Рукопашный бой*/, [ 1.0, 5.0 ]], [15/*enum.SkillType:Дробовики*/, [ 1.0, 5.0 ]], [26/*enum.SkillType:Скрытность*/, [ 1.0, 5.0 ]] ]}] call pc_oop_regvar;
//p_field: _currentSpawnLocation
["_currentSpawnLocation",toString {[0/*enum.SpawnPointType:Спавнпоинт*/, "base"]}] call pc_oop_regvar;
//p_field: _currentConnectedTo (default from ScriptedRole)
//p_entry: methods.ScriptedRole.getEquipment_0
func(getEquipment) {
    params ['this', "_lvar_0_0"];
     
    SCOPENAME "exec"; if !((tolower ((pt_Mob)getvariable "classname")) in ((_lvar_0_0) getvariable "proto" getvariable ("__inhlist_map"))) exitWith {}; private _lvar_1_0 = _lvar_0_0; private _lvar_2_0 = ["NomadCloth12", _lvar_1_0, 4/*enum.InventorySlot:Одеяния*/] call createItemInInventory; _lvar_2_0 setVariable ["name", "Одежда приключенца"]; for "_lvar_4_0" from (1) to ([2, 5]call randomInt) do {
        private _lvar_5_0 = ["Bandage", _lvar_2_0] call createItemInContainer;
        _lvar_5_0 setVariable ["name", [ "Бинтик ", format["%1", _lvar_4_0] ] joinString ""]; private _lvar_7_0 = ["Shotgun", _lvar_1_0, 0/*enum.InventorySlot:Спина*/] call createItemInInventory;
    };
};
//p_entry: methods.ScriptedRole._onAssignedWrapper_0
func(_onAssignedWrapper) {
    params ['this', "_lvar_0_0", "_lvar_0_1", "_lvar_0_2"];
     
    SCOPENAME "exec"; [_lvar_0_1, [ "Привет ", _lvar_0_0 getVariable "name" ] joinString "", 1/*enum.ChatMessageChannel:Лог*/] call ((_lvar_0_1) getVariable PROTOTYPE_VAR_NAME getVariable "_localSayWrapper");
};
//p_entry: methods.ScriptedRole._onDeadBasicWrapper_0
func(_onDeadBasicWrapper) {
    params ['this', "_lvar_0_0", "_lvar_0_1"];
     
    SCOPENAME "exec"; _thisobj setVariable ["_deadTimeout", 30];
};
endclass