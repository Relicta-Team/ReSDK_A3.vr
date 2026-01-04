// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>
#include <..\Networking\Network.hpp>
#include <..\GameObjects\GameConstants.hpp>
#include <..\..\client\Inventory\inventory.hpp>

#define skill(name,val) ['name',val]
#define skillrand(name,min,max) ['name',[min,max]]

#define regKeyInUniform(cloth,owners,name__) callFuncParams(cloth,createItemInContainer,"Key" arg null arg null arg [vec3("var","keyOwner",owners) arg vec3("var","name",name__)])

#define load(path) loadFile("src\host\GameModes\" + (path))

#define rolerep(pm,potvred,otvet) [pm,potvred,otvet]
#define ROLEREP_INDEX_LOCATION 0
#define ROLEREP_INDEX_POTENTIALHARM 1
#define ROLEREP_INDEX_RESPONIBILITY 2