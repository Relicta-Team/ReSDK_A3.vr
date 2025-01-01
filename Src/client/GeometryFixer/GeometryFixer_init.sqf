// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\oop.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <GeometryFixer.h>

//отключает лагалку ебаную (только для геометрии)
#define GEOMETRYFIXER_GEOSAVER_DISABLED
//отключает лифт (требуется фикс)
#define GEOMETRYFIXER_ROADWAY_DISABLED
//отключает армовскую коллизию сущностей
#define GEOMETRYFIXER_COLLISION_ALLOWED


#include "GeometryFixer_functions.sqf"

gf_lastPositions = [vec3(0,0,0),vec3(0,0,0),vec3(0,0,0)];
gf_lastBufferedFallingPos = vec3(0,0,0);
//gf_lastFallingCheckCount = 0;
gf_handle_update = -1;
gf_isCatchedFalling = false;
gf_lastFallingTime = 0;

gf_indexLastPos = 2;

gf_objRoadway = createSimpleObject ["ml_shabut\vr_geo\geopolsm.p3d",[0,0,0],true];

gf_isLockedInputByWall = false;
gf_isLockedInputByActor = false;

#ifdef GEOMETRY_FIXER_TRACE_POSITIONS
gf_lastposArrows = ["Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0]];
gf_lbfpArrow = "Sign_Arrow_F" createVehicleLocal [0,0,0];

gf_campos = "Sign_Arrow_F" createVehicleLocal [0,0,0];
gf_camtarget = "Sign_Arrow_F" createVehicleLocal [0,0,0];

gf_proneFrom = "Sign_Arrow_F" createVehicleLocal [0,0,0];
gf_proneTo = "Sign_Arrow_F" createVehicleLocal [0,0,0];
gf_proneSafePos = "Sign_Arrow_F" createVehicleLocal [0,0,0];
#endif