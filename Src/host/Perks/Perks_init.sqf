// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include <..\text.hpp>

//перки называются Perk[name]
class(PerkBase)
	var(name,"Навык");
	var(desc,"Это мой навык");
	var(meInfo,"У меня есть навык!");
	//TODO можно добавить владельца и список у каких персонажей есть этот перк
	
	func(onGetPerk)
	{
		objParams_1(_usr);
	};
	
	func(onLossPerk)
	{
		objParams_1(_usr);
	};
endclass

class(PerkSeeInDark) extends(PerkBase)
	var(name,"Ночное зрение");
	var(desc,"Позволяет видеть в темноте");
	var(meInfo,"Тьма мне не помеха - я могу отлично видеть в полной темноте");
endclass


class(PerkSignLang) extends(PerkBase)
	var(name,"Язык жестов");
	var(desc,"Позволяет общаться с помощью жестов");
	var(meInfo,"Ты владеешь языком жестов");
	
	func(onGetPerk)
	{
		objParams_1(_usr);
		super();
		callFuncParams(_usr,addAction,"Мир" arg "Язык жестов" arg "wrld_inputedsignlang");
	};
	func(onLossPerk)
	{
		objParams_1(_usr);
		super();
		callFuncParams(_usr,removeAction,"wrld_inputedsignlang");
	};
	
endclass

class(PerkOneHandShooter) extends(PerkBase)
	var(name,"Контроль оружия");
	var(desc,"Позволяет стрелять длинным оружием держа его одной рукой");
	var(meInfo,"Ты можешь контролировать стрельбу из винтовок и дробовиков одной рукой");
endclass