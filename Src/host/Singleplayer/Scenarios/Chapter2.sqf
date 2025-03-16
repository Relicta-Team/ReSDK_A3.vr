// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "Scenario.h"

//startpos: cpt2_pos_start

//wait for gate open
//cpt2_obj_gate -gate ref
["cpt2_begin",{

}] call sp_addScene;

["cpt2_trg_hunger",{
    {

    } call sp_threadStart;
}] call sp_addScene;

//cpt2_obj_kol_wallbeforecooking -invisible wall before cooking guide
//cpt2_obj_cellbeforefall - решетка дверь перед падением вниз
//cpt2_obj_rottenboards -rotten boards ref

//cpt2_trg_kol_insidehole - trigger on enter inside hole

//cpt2_obj_doorfinal --final door

/*
anims:
Acts_JetsMarshallingStop_loop - new handsup anim
Acts_JetsMarshallingEmergencyStop_loop - лось
Acts_JetsMarshallingClear_loop - приветствие

ApanPercMstpSnonWnonDnon_G01
ApanPercMstpSnonWnonDnon_G02
ApanPercMstpSnonWnonDnon_G03
*/