// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
	Структуры билдеров для агентов
	Создают сущности и выдают снаряжение
*/

struct(AgentBuilderBase)
	// класснейм создаваемого существа
	def(instanceType) "";
	// тип структуры агента
	def(agentType) "";

	// базовые навыки для существа (st,iq,dx,ht)
	def(getSkills) {
		[10,10,10,10]
	}

	def(getFirstName) { params ["_mob"]; ""}
	def(getSecondName) { params ["_mob"]; ""}

	def(getFace) { params ["_mob"]; pick faces_list_man}

	// дополнительный обработчик сущности (например выдача снаряжения)
	def(onApply) {
		params ["_mob"];
	}
endstruct

struct(AgentBuilderEater) base(AgentBuilderBase)
	def(instanceType) "GMPreyMobEater";
	def(agentType) "AgentEater";

	def(getFirstName) { params ["_mob"]; callFunc(_mob,getRandomNamePrefix) }
	def(getSecondName) { params ["_mob"]; "жрун"}

	def(getFace) { params ["_mob"]; ""}

	def(getSkills) {
		[randInt(11,14),randInt(6,11),randInt(10,14),randInt(10,13)]
	}

	def(onApply) {
		params ["_mob"];
		["Castoffs" + str randInt(1,3),_mob,INV_CLOTH] call createItemInInventory;
	}
endstruct