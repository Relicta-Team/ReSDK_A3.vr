// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Craft Object System (COS)

	Это система создания объектов из рецептов через меню или по условиям

	Компонент позволяет реализовать такие системы как:
		- готовка на сковороде у любых источников огня
		- запекание в печи
		- ковка
		- перегонка самогона
		и т.д.

	Системы делятся на следующие:
		- Internal - работают с объектами в виртуальных пулах
		- WorldProcessor - работают с объектами в мире

*/

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

// basic type 
struct(BaseCraftSystem)
	def(_type) "" //string representation of system type

	def(src) nullPtr //source game object
	def(usr) nullPtr //user last activator or world objects last owner

	def(process)
	{

	}

endstruct