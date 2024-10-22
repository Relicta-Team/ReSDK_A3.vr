// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"


/*
	default

	Стандартный модификатор установки хп, веса, качества
	параметры
		auto_all - включить все модификаторы (по умолчанию выключено)
		auto_ht - автокачество (по умолчанию )
		auto_weight - автовес
		auto_hp - автоматическое хп (! сейчас завязано на весе)
		hp_from_skill - использовать вычисление текущего хп от величины успеха броска
		auto_germs - автогрязь
*/
struct(CraftModifier::default) base(CraftModifierAbstract)
	
	def(auto_all) false
	def(auto_ht) false
	def(auto_hp) false
	def(auto_weight) false
	def(auto_germs) false

	def(hp_from_skill) false

	def(onParameter)
	{
		params ["_paramName","_paramValue"];
		if (_paramName == "auto_all") exitWith {
			if not_equalTypes(_paramValue,true) exitWith {
				self callp(setParseError,"auto_all must be boolean");
			};
			self setv(auto_all,_paramValue);	
		};
		if (_paramName in ["auto_ht","auto_hp","auto_weight","auto_germs","hp_from_skill"]) exitWith {
			if not_equalTypes(_paramValue,true) exitWith {
				self callp(setParseError,_paramName + " must be boolean");
			};
			self set [_paramName,_paramValue];
		};
		false
	}
	
	def(createModifierContext)
	{
		params ["_capturedCtx"];
		private _objs = [];
		{
			_objs append (_x);
			false
		} count (_capturedCtx get "ingredients") apply {_x callv(getObjects)};
		
		private _ctx = createHashMap;
		private _all = self getv(auto_all);
		
		if ((self getv(auto_germs)) || _all) then {
			private _germs = 0;
			{
				modvar(_germs) + getVar(_objs,germs) * 1.2;
			} foreach _objs;
			private _midGerms = _germs/1.3;
			_ctx set ["germs",_midGerms];
		};
		if ((self getv(auto_weight)) || _all) then {
			private _wAll = 0;
			{
				modvar(_wAll) + callFunc(_x,getWeight);
			} foreach _objs;
			_ctx set ["weight",_wAll];
		};
		//hp and ht
		if ((self getv(auto_hp)) || _all) then {
			private _hpAll = 0;
			{
				modvar(_hpAll) + getVar(_objs,hp);
			} foreach _objs;
			_ctx set ["hp_mid",_htAll/(count _objs)];
		};
		if ((self getv(hp_from_skill)) || _all) then {
			_ctx set ["hp_from_skill",true];
		};
		if ((self getv(auto_ht)) || _all) then {
			private _htAll = 0;
			{
				modvar(_htAll) + getVar(_objs,ht);
			} foreach _objs;
			_ctx set ["ht_mid",_htAll/(count _objs)];
		};

		_ctx
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		
		if ("germs" in _ctx) then {
			callFuncParams(_itm,addGerms,_ctx get "germs");
		};
		//! weight only before hp
		if ("weight" in _ctx) then {
			callFuncParams(_itm,setWeight,_ctx get "weight");
		};

		//определяем качество
		if ("ht" in _ctx) then {
			private _successAmnt = _craftContext get "success_amount";
			private _midHT = _ctx get "ht_mid";
			private _newHT = round linearconversion [0,16,_successAmnt,(_midHT-10)max 1,_midHT,true];
			setVar(_itm,ht,_newHT);
		};
		//определяем хп
		if ("hp" in _ctx) then {
			if ("hp_from_skill" in _ctx) then {
				private _successAmnt = _craftContext get "success_amount";
				private _midHP = _ctx get "hp_mid";
				private _newHP = round linearConversion [0,16,_successAmnt,(_midHP-10)max 1,_midHP,true];
				setVar(_itm,hp,_newHP);
				setVar(_itm,hpMax,_midHP);
			} else {
				callFunc(_itm,generateObjectHP);
			};
		};
	}
endstruct