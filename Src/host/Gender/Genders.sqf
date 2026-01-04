// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>
#include <..\oop.hpp>
#include "Gender.hpp"

//человеческое имя
class(HumanNaming) attributeParams(initGlobalSingleton,"naming_default")
	
	var(кто,"Человек");
	var(кого,"Человека");
	var(кому,"Человеку");
	var(вин,"Человека");
	var(кем,"Человеком");
	var(ком,"Человеке");

	func(enumNamingToText)
	{
		objParams_1(_eval);
		["кто","кого","кому","вин","кем","ком"] select _eval
	};
	
endclass

// Конвертация гендера из типа int в object
gender_enumToObject = {
	params [["_genderEnum",GENDER_MALE]];
	if (_genderEnum == GENDER_MALE) exitWith {gender_male};
	if (_genderEnum == GENDER_FEMALE) exitWith {gender_female};
	gender_neuter
};

gender_objectToEnum = {
	params [["_genderObj",gender_male]];
	callFunc(_genderObj,getGenderId);
};

/*
	!!! ВНИМАНИЕ !!!
	Так работает компилятор что слова в нижнем регистре
	Но из-за движка большие и русские буквы идут как разные переменные.
	Для доступа к полям типа Gender_base которые обозваны как русские -
	использовать только НИЖНИЙ РЕГИСТР
*/

class(Gender_base)
	"
		name:Пол сущности
		path:Игровая логика.Характеристики.Пол
	"
	node_class
	"
		name:Местоимение 'Он'
		prop:get
		return:string:'Он'
		defval:Он
	" node_var
	var(Он,"Он"); //и
	"
		name:Местоимение 'Его'
		prop:get
		return:string:'Его'
		defval:Его
	" node_var
	var(Его,"Его"); //р
	"
		name:Местоимение 'Него'
		prop:get
		return:string:'Него'
		defval:Него
	" node_var
	var(Него,"Него"); //рп
	"
		name:Местоимение 'Ему'
		prop:get
		return:string:'Ему'
		defval:Ему
	" node_var
	var(Ему,"Ему"); //д
	"
		name:Местоимение 'Нему'
		prop:get
		return:string:'Нему'
		defval:Нему
	" node_var
	var(Нему,"Нему"); //дп
	
	var(кто,"Мужчина");
	var(кого,"Мужчины");
	var(кому,"Мужчине");
	var(вин,"Мужчину");
	var(кем,"Мужчиной");
	var(ком,"Мужчине");
	
	"
		name:Пол сущности (сокращенно)
		prop:get
		return:string:Сокращенное имя пола, например 'м' для мужского.
		defval:м
	" node_var
	var(пол,"м");
	"
		name:Пол сущности
		prop:get
		return:string:Пол сущности
		defval:мужской
	" node_var
	var(пол_целиком,"мужской");
	
	getterconst_func(ageText,["дитя" arg "юноша" arg "взрослый" arg "зрелый" arg "пожилой" arg "старик"]);
	
	func(getAgeIndex)
	{
		objParams_1(_age);
		if (_age <= 18) exitWith {0};
		if (_age <= 25) exitWith {1};
		if (_age <= 35) exitWith {2};
		if (_age <= 47) exitWith {3};
		if (_age <= 65) exitWith {4};
		5
	};
	
	func(isMiddleAge)
	{
		objParams_1(_num);
		callSelfParams(getAgeIndex,_num) == 2
	};
	
	"
		name:Описание возраста
		desc:Данный узел определяет описание возраста сущности.
		type:get
		lockoverride:1
		in:int:Возраст
		return:string:Описание возраста
	" node_met
	func(getAgeText)
	{
		objParams_1(_num);
		callSelf(ageText) select callSelfParams(getAgeIndex,_num);
	};

	getterconst_func(getGenderId,GENDER_MALE);
	
endclass

class(Gender_male) extends(Gender_base) 
	attributeParams(initGlobalSingleton,"gender_male")

	getterconst_func(getGenderId,GENDER_MALE);
endclass

class(Gender_female) extends(Gender_base)

	getterconst_func(getGenderId,GENDER_FEMALE);

	attributeParams(initGlobalSingleton,"gender_female")
	
	var(Он,"Она");
	var(Его,"Её");
	var(Него,"Неё");
	var(Ему,"Ей");
	var(Нему,"Ней");
	
	var(кто,"Женщина");
	var(кого,"Женщины");
	var(кому,"Женщине");
	var(вин,"Женщину");
	var(кем,"Женщиной");
	var(ком,"Женщине");
	
	var(пол,"ж")
	var(пол_целиком,"женский");
	
	getterconst_func(ageText,["дитя" arg "девушка" arg "взрослая" arg "зрелая" arg "пожилая" arg "старуха"]);
endclass

class(Gender_neuter) extends(Gender_base)

	getterconst_func(getGenderId,GENDER_NEUTER);

	attributeParams(initGlobalSingleton,"gender_neuter")
	
	var(Он,"Оно");
	var(Его,"Его");
	var(Него,"Него");
	var(Ему,"Ему");
	var(Нему,"Нему");
	
	var(пол,"?")
	var(пол_целиком,"неизвестный");
	
	var(кто,"Существо");
	var(кого,"Существа");
	var(кому,"Существу");
	var(вин,"Существо");
	var(кем,"Существом");
	var(ком,"Существе");
	
	getterconst_func(ageText,["молодое" arg "подросшее" arg "взрослое" arg "зрелое" arg "пожилое" arg "старое"]);
endclass