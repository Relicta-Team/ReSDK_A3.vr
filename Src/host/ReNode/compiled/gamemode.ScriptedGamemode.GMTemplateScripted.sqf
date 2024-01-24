//src:d3c01b1b-c286-49fc-b939-1eef1398f2ec:Graphs\Gamemodes\GMTemplateScripted.graph
//gdate:2024-01-24 18:55:44.497688
#include ".\resdk_graph.h"


editor_attribute("NodeClass")
class(GMTemplateScripted) extends(ScriptedGamemode)
// Code generated:

//p_field: name
["name",toString {"Тестовый режим ReNode"}] call pc_oop_regvar;
//p_field: desc
["desc",toString {"Реализация GMTemplate на ReNode"}] call pc_oop_regvar;
//p_field: descExtended
["descExtended",toString {"Режим без описания"}] call pc_oop_regvar;
//p_field: canAddAspect (default from ScriptedGamemode)
//p_field: duration
["duration",toString {1500}] call pc_oop_regvar;
//p_const: getMapName
func(getMapName) { "Template" };
//p_const: isPlayableGamemode
func(isPlayableGamemode) { false };
//p_const: _getRolesWrapper
func(_getRolesWrapper) { [ "RAdventurerGMTemplateScripted" ] };
//p_entry: methods.ScriptedGamemode.preSetup_0
func(preSetup) {
    params ['this'];
     
    SCOPENAME "exec";
};
//p_entry: methods.ScriptedGamemode.postSetup_0
func(postSetup) {
    params ['this'];
     
    SCOPENAME "exec";
};
//p_entry: methods.ScriptedGamemode.onTick_0
func(onTick) {
    params ['this'];
     
    SCOPENAME "exec";
};
//p_entry: methods.ScriptedGamemode._checkFinishWrapper_0
func(_checkFinishWrapper) {
    params ['this'];
     
    SCOPENAME "exec";
};
//p_entry: methods.ScriptedGamemode.onFinish_0
func(onFinish) {
    params ['this'];
     
    SCOPENAME "exec";
};
endclass