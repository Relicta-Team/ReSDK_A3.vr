// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

//TODO столы и полки наследуются от спец.типа который имеет функции получения позиции поверхности 
//TODO это нужно для спавна объектов на поверхностях

// ::Мебель
editor_attribute("InterfaceClass")
class(Furniture) extends(StructureBasicCategory) endclass
// Стулья +++(IChair)

// Ящики << container(SContainer)
// Шкафы << container(SContainer)
// Тумбочки << container(SContainer)
// Кровати << bedbase << sitablestruct(BedBase)
// Диваны << multisitable(SofaBase)
// Скамейки << multisitable(BenchBase)