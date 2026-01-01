// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include "..\engine.hpp"
#include "..\oop.hpp"

;// editor region safe start

/*
    Dynamic Object Library Loader
    Данный компонент позволяет реализовать частичную загрузку классов с помощью сборок.
    Компонент работает как в среде симуляции, так и в редакторе ReEditor
*/
doll_initComponent = {
    doll_list_loadedAssembly = createHashMap; //key:asmName, val: listOfTypes


    doll_const_path_asmLibDirectory = ""; //путь до библиотек
};

doll_loadAssembly = {
    params ["_asmName",["_flags",""]];
};

doll_unloadAssembly = {
    params ["_asmName"];
};