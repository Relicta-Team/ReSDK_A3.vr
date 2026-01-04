// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\host\engine.hpp>
#include <..\..\host\oop.hpp>
#include <..\ClientRpc\clientRpc.hpp>
#include <GeometryFixer.h>

namespace(GeometryFixer,gf_)

//отключает лагалку ебаную (только для геометрии)
macro_def(gf_geosaverDisabled)
#define GEOMETRYFIXER_GEOSAVER_DISABLED
//отключает лифт (требуется фикс)
macro_def(gf_geosaverDisabled)
#define GEOMETRYFIXER_ROADWAY_DISABLED
//отключает армовскую коллизию сущностей
macro_def(gf_geosaverDisabled)
#define GEOMETRYFIXER_COLLISION_ALLOWED


#include "GeometryFixer_functions.sqf"

decl(vector3[])
gf_lastPositions = [vec3(0,0,0),vec3(0,0,0),vec3(0,0,0)];
decl(vector3)
gf_lastBufferedFallingPos = vec3(0,0,0);
//gf_lastFallingCheckCount = 0;
decl(int)
gf_handle_update = -1;
decl(bool)
gf_isCatchedFalling = false;
decl(float)
gf_lastFallingTime = 0;
decl(float)
gf_indexLastPos = 2;

decl(mesh)
gf_objRoadway = createSimpleObject ["ml_shabut\vr_geo\geopolsm.p3d",[0,0,0],true];

decl(bool)
gf_isLockedInputByWall = false;
decl(bool)
gf_isLockedInputByActor = false;

#ifdef GEOMETRY_FIXER_TRACE_POSITIONS
decl(any[])
gf_lastposArrows = ["Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0],"Sign_Arrow_F" createVehicleLocal [0,0,0]];
decl(mesh)
gf_lbfpArrow = "Sign_Arrow_F" createVehicleLocal [0,0,0];

decl(mesh)
gf_campos = "Sign_Arrow_F" createVehicleLocal [0,0,0];
decl(mesh)
gf_camtarget = "Sign_Arrow_F" createVehicleLocal [0,0,0];

decl(mesh)
gf_proneFrom = "Sign_Arrow_F" createVehicleLocal [0,0,0];
decl(mesh)
gf_proneTo = "Sign_Arrow_F" createVehicleLocal [0,0,0];
decl(mesh)
gf_proneSafePos = "Sign_Arrow_F" createVehicleLocal [0,0,0];
#endif