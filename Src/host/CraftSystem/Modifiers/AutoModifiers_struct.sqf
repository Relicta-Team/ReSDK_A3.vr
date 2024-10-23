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
	
	def(title) "Стандартный модификатор";
	def(description) "Стандартный модификатор установки хп, веса, качества";
	def(reqired_fields) []
	def(allowed_params) [
		["auto_all",[
			"type:boolean",
			"title:Включить все модификаторы",
			"description:Включает все модификаторы (включено по умолчанию)"
		]],
		["auto_ht",[
			"type:boolean",
			"title:Автокачество",
			"description:Автокачество (по умолчанию выключено)"
		]],
		["auto_weight",[
			"type:boolean",
			"title:Автовес",
			"description:Автовес (по умолчанию выключено)"
		]],
		["auto_hp",[
			"type:boolean",
			"title:Автоматическое хп",
			"description:Автоматическое хп результирующего объекта"
		]],
		["hp_from_skill",[
			"type:boolean",
			"title:Использовать вычисление текущего хп от величины успеха броска",
			"description:Использовать вычисление текущего хп от величины успеха броска"
		]],
		["auto_germs",[
			"type:boolean",
			"title:Автогрязь",
			"description:Автогрязь (по умолчанию выключено)"
		]]
	]

	def(auto_all) true
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
		
		//default used objects handler
		private _usedObjectsGet = {
			private _algorithmSelect = _this;
			private _oList = [];
			{_oList append _x; false} count ((_capturedCtx get "ingredients") apply _algorithmSelect);
			_oList;
		};
		private _allObjects = { _x callv(getObjects) } call _usedObjectsGet;
		private _usedObjects = { if (!(_x getv(destroy))) then {[]} else { _x callv(getObjects) }} call _usedObjectsGet;
		
		self callp(debugMessage,"Used: %1; All: %2" arg _usedObjects arg _allObjects);
		
		private _ctx = createHashMap;
		private _all = self getv(auto_all);
		
		if ((self getv(auto_germs)) || _all) then {
			private _germs = 0;
			{
				modvar(_germs) + getVar(_x,germs) * 1.2;
			} foreach _allObjects;
			private _midGerms = _germs/1.3;
			_ctx set ["germs",_midGerms];
		};
		if ((self getv(auto_weight)) || _all) then {
			private _wAll = 0;
			{
				modvar(_wAll) + callFunc(_x,getWeight);
			} foreach _usedObjects;
			_ctx set ["weight",_wAll];
		};
		//hp and ht
		if ((self getv(auto_hp)) || _all) then {
			//zerodivision fix
			if (count _usedObjects == 0) exitWith {};

			private _hpAll = 0;
			{
				modvar(_hpAll) + getVar(_x,hp);
			} foreach _usedObjects;
			_ctx set ["hp_mid",_hpAll/(count _usedObjects)];
		};
		if ((self getv(hp_from_skill)) || _all) then {
			_ctx set ["hp_from_skill",true];
		};
		if ((self getv(auto_ht)) || _all) then {
			//zerodivision fix
			if (count _usedObjects == 0) exitWith {};

			private _htAll = 0;
			{
				modvar(_htAll) + getVar(_x,ht);
			} foreach _usedObjects;
			_ctx set ["ht_mid",_htAll/(count _usedObjects)];
		};

		_ctx
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		
		if ("germs" in _ctx) then {
			callFuncParams(_itm,addGerms,_ctx get "germs");
			self callp(debugMessage,"Add %1 germs to %2" arg _ctx get "germs" arg _itm);
		};
		//! weight only before hp
		if ("weight" in _ctx) then {
			callFuncParams(_itm,setWeight,_ctx get "weight");
			self callp(debugMessage,"Set %1 weight to %2" arg _ctx get "weight" arg _itm);
		};

		//определяем качество
		if ("ht_mid" in _ctx) then {
			//craft without used skills
			if ((_craftContext get "used_skill")=="craft_success") exitWith {
				self callp(debugMessage,"Skip HT update because no skills used");
			};

			private _successAmnt = _craftContext get "success_amount";
			private _midHT = (_ctx get "ht_mid");
			private _newHT = round linearconversion [0,16,_successAmnt,((floor(_midHT/2))max 1),_midHT*2,true];
			
			setVar(_itm,ht,_newHT);
			self callp(debugMessage,"HT of %1 update: Success %2; mid %3; new %4" arg _itm arg _successAmnt arg _midHT arg _newHT);
		};
		//определяем хп
		if ("hp_mid" in _ctx) then {
			//craft without used skills
			if ((_craftContext get "used_skill")=="craft_success") exitWith {
				self callp(debugMessage,"Skip HP update because no skills used");
			};

			if ("hp_from_skill" in _ctx) then {
				private _successAmnt = _craftContext get "success_amount";
				private _midHP = _ctx get "hp_mid";
				private _newHP = round linearConversion [0,16,_successAmnt,(floor(_midHP/2))max 1,_midHP*2,true];
				setVar(_itm,hp,_newHP);
				setVar(_itm,hpMax,_midHP);

				self callp(debugMessage,"HP of %1 update: Success %2; mid %3; new %4" arg _itm arg _successAmnt arg _midHP arg _newHP);
			} else {
				callFunc(_itm,generateObjectHP);

				self callp(debugMessage,"HP of %1 REGENERATED: cur %1; max %2" arg _itm arg getVar(_itm,hp) arg getVar(_itm,hpMax));
			};
		};
	}
endstruct

/*
	Передача реагентов
	
	Example
		precentage_loss: 20
		loss_from_skills: true
		get_from_all: 30 #precents
		get_from:
			TAG: precentvalue
		reagents_whitelist: [Milk]
		reagents_blacklist: []
*/
struct(CraftModifier::transfer_reagents) base(CraftModifierAbstract)
	def(title) "Передача реагентов"
	def(description) "Модификатор передает реагенты из исходных ингредиентов в результат крафта"
	def(reqired_fields) []
	def(allowed_params) [
		["reagents_whitelist",[
				"type:array",
				"title:Разрешенные реагенты",
				"description:Список разрешенных реагентов для передачи. Указанные в этом списке реагенты будут переданы. Остальные исключаются. По умолчанию передает все реагенты",
				"example":[
					[],["Milk","Water"],["Blood"]
				]
			]
		],
		["reagents_blacklist",[
			"type:array",
			"title:Запрещенные реагенты",
			"description:Список запрещенных реагентов для передачи. Указанные в этом списке реагенты будут исключены. Остальные передаются. По умолчанию передает все реагенты",
			"example":[
				[],["Milk","Water"],["Blood"]
			]
		]],
		["precentage_loss",
			[
				"title:Процент потери реагентов",
				"description:Сколько процентов от реагентов потеряется при крафте. Это значение накладывается поверх переданных реагентов с помощью get_from_all и get_from",
				"type:number",
				["default",0],
				["example",[0,50,75,100]]
			]
		],
		["loss_from_skills",[
				"title:Потеря реагентов от успешности",
				"description:Потеря реагентов от успешности крафта. Чем выше скилл крафтера, тем меньше потеря",
				"type:bool",
				["default",false]
			]
		],
		["get_from_all",[
				"title:Передача из всех",
				"description:Передача реагентов (единиц или процентов) из всех реагент-контейнеров. Значение 100% означает полную передачу. Если указано число (количество единиц)",
				["type",["number","string"]],
				["default",100],
				["example",[5,"40%"]]
			]
		],
		["get_from",[
				"title:Передача по тегам",
				"description:Передача процентных значений реагентов из реагент-контейнеров с указанными тегами. Если объект по тегу не является реагент-контейнером, то передача не произойдёт."
				"type:object",
				["additionalProperties",false],
				["properties", createHashMapFromArray [
					["patternProperties", 
						createHashMapFromArray [
							["^[a-zA-Z]+$", createHashMapFromArray [
								["type",["number","string"]],
								["example",[15,"30%"]]
							]]
						]
					]
				]]
				["example",
					createHashMapFromArray [
						["TAGGED_OBJECT_1",70],
						["TAG_2","50%"]
					]
				]
			]
		]
	]

	def(precentage_loss) 0
	def(loss_from_skills) false
	def(get_from_all) "100%"
	def(get_from) []
	def(reagents_whitelist) []
	def(reagents_blacklist) []

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name in "precentage_loss") exitWith {
			self callp(addParam,_name arg _val arg 0);
		};
		if (_name == "loss_from_skills") exitWith {
			self callp(addParam,_name arg _val arg false);
		};
	}

	def(createModifierContext)
	{
		params ["_capturedCtx"];
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
	}

endstruct