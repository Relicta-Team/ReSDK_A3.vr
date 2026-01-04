// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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
	def(required_fields) []
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

//internal struct for number|string(as precent) value
struct(CraftModifier_numprecValue)
	def(realValue) 0
	def(isPrecentage) false
	def(init)
	{
		params ["_val"];
		if equalTypes(_val,"") then {
			self setv(isPrecentage,true);
			self setv(realValue,parseNumberSafe(_val));
		} else {
			self setv(realValue,_val);
		};
	}

	def(getValueFrom)
	{
		params ["_from"];
		if (self getv(isPrecentage)) then {
			precentage(_from,self getv(realValue))
		} else {
			(self getv(realValue));
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
		-- not needed now --
		reagents_whitelist: [Milk]
		reagents_blacklist: []
*/
struct(CraftModifier::transfer_reagents) base(CraftModifierAbstract)
	def(title) "Передача реагентов"
	def(description) "Модификатор передает реагенты из исходных ингредиентов в результат крафта."
	def(required_fields) []
	def(allowed_params) [
		// ["reagents_whitelist",[
		// 		"type:array",
		// 		"title:Разрешенные реагенты",
		// 		"description:Список разрешенных реагентов для передачи. Указанные в этом списке реагенты будут переданы. Остальные исключаются. По умолчанию передает все реагенты",
		// 		["examples",[
		// 			[],["Milk","Water"],["Blood"]
		// 		]]
		// 	]
		// ],
		// ["reagents_blacklist",[
		// 	"type:array",
		// 	"title:Запрещенные реагенты",
		// 	"description:Список запрещенных реагентов для передачи. Указанные в этом списке реагенты будут исключены. Остальные передаются. По умолчанию передает все реагенты",
		// 	["examples",[
		// 		[],["Milk","Water"],["Blood"]
		// 	]]
		// ]],
		["precentage_loss",
			[
				"title:Процент потери реагентов",
				"description:Сколько процентов от реагентов потеряется при крафте. Это значение применяется после передачи из ингредиентов в результаты. Если предметов больше 1 то каждый теряет столько процентов, сколько указано в этом параметре.",
				"type:number",
				["default",0],
				["examples",[0,50,75,100]]
			]
		],
		["loss_from_skills",[
				"title:Потеря реагентов от успешности",
				"description:По умолчанию выключено. Потеря реагентов от успешности крафта. Чем выше скилл крафтера, тем меньше потеря. Этот параметр накладывается после процентной потери precentage_loss (если указано) для каждого из результирующих предметов.",
				"type:boolean",
				["default",false]
			]
		],
		["partial_transfer",[
			"title:Частичная передача",
			"description:Частичная передача от get_from_all. По умолчанию включено. Если опция включена, то каждый из результирующих предметов (если их несколько) получает часть реагентов от всех ингредиентов. Например, если на выходе получается 2 предмета то при передачи 100% каждый из предметов будет иметь лишь 50% от всех реагентов из требуемых ингредиентов.",
			"type:boolean",
			["default",true]
		]],
		["delete_on_empty",[
			"title:Удалить опустошенные реагент-контейнеры",
			"description:Удалять реагент-контейнеры, если после передачи в них не осталось содержимого. По умолчанию включено.",
			"type:boolean",
			["default",true]
		]],
		["get_from_all",[
				"title:Передача из всех",
				"description:Передача реагентов (единиц или процентов) из всех реагент-контейнеров. Значение 100% означает полную передачу. Обратите внимание, что на способ работы этого параметра влияет partial_transfer. Взаимоисключаемое с get_from.",
				["type",["number","string"]],
				["default",100],
				["examples",[5,"40%"]]
			]
		]
		,["get_from",[
				"title:Передача по тегам",
				"description:Передача реагентов (единиц или процентов) из реагент-контейнеров с указанными тегами. Если объект по тегу не является реагент-контейнером, то передача не произойдёт. Взаимоисключаемое с get_from_all.",
				"type:object",
				["additionalProperties",false],
				["patternProperties", 
					toMap [
						["^[a-zA-Z]+$", toMap [
							["type",["number","string"]],
							["examples",[15,"30%"]]
						]]
					]
				],
				["properties", toMap []],
				["examples",
					[toMap [
						["TAGGED_OBJECT_1",70],
						["TAG_2","50%"]
					]]
				]
			]
		]
	]

	def(precentage_loss) 0 //процент потери для всех
	def(loss_from_skills) false //потеря от навыков
	def(get_from_all) "100%" //сколько процентов или реагентов отдаём
	def(partial_transfer) true //частичная передача (get_from_all/count)
	def(delete_on_empty) true //удалять пустые
	def(_use_get_from_all) false
	def(get_from) [] //dict of metatags
	def(_use_get_from) false
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
		if (_name == "get_from_all") exitWith {
			self callp(addParam,_name arg _val arg [0 arg ""]);
			self setv(_use_get_from_all,true);
		};
		if (_name in ["partial_transfer","delete_on_empty"]) exitWith {
			self callp(addParam,_name arg _val arg false);
		};
		if (_name == "get_from") exitWith {
			self callp(addParam,_name arg _val arg [hashMapNull]);
			self setv(_use_get_from,true);

			if equals(self getv(_use_get_from),self getv(_use_get_from_all)) then {
				self callp(setParseError,"get_from и get_from_all не могут быть объявлены одновременно");
			};
		};
	}

	def(createModifierContext)
	{
		params ["_capturedCtx"];

		private _mapAll = createhashMap;
		private _mapRemove = createhashMap;
		private _canDeleteListCheck = [];
		private _cachedRemover = [];
		{
			private _ingr = _x;
			{
				private _itm = _x;
				if !callFunc(_itm,isReagentContainer) then {continue};
				private _useGetFrom = self getv(_use_get_from);
				private _useGetFromAll = self getv(_use_get_from_all);
				if (_useGetFromAll || _useGetFrom) then {
					if (_useGetFrom && {equals(_ingr getv(metaTag),"")}) exitWith {break};
					private _val = "100%";
					if (_useGetFrom) then {
						private _tag = _ingr getv(metaTag);
						if (_tag in (self getv(get_from))) then {
							_val = (self getv(get_from) get _tag);
						} else {
							break;
						};
					} else {
						_val = self getv(get_from_all);
					};
					private _fromValObj = struct_newp(CraftModifier_numprecValue,_val);
					private _lossValue = _fromValObj callp(getValueFrom,callFunc(_itm,getFilledSpace));
					self callp(debugMessage,"loss value %1 from %2" arg _lossValue arg _val);
					if (_lossValue > 0) then {
						private _delReagents = callFuncParams(_itm,removeReagentsAndReturn,_lossValue);
						{
							_x params ["_reag","_val"];
							if !(_reag in _mapRemove) then {
								_mapRemove set [_reag,0];
							};
							_mapRemove set [_reag,(_mapRemove get _reag) + _val];
						} foreach _delReagents;
						
						if (callFunc(_itm,getFilledSpace)==0) then {
							//жидкостные контейнеры больше не будут удаляться
							if isTypeOf(_itm,IReagentNDItem) exitWith {};
							_canDeleteListCheck pushBack _itm;
						};

						//restore reagents in case of user progress canceled
						{
							_x params ["_reag","_val"];
							callFuncParams(_itm,addReagent,_reag arg _val);
						} foreach _delReagents;
						//and store cache for removing
						_cachedRemover pushBack [_itm,_delReagents];
					};
				};

			} foreach (_ingr callv(getObjects));
		} foreach (_capturedCtx get "ingredients");
		
		
		self callp(debugMessage,"captured reagents to add: %1" arg _mapRemove);
		_mapAll set ["MAP_ADD_REAGENTS",_mapRemove];
		_mapAll set ["LIST_CAN_DELETE_IF_EMPTY",_canDeleteListCheck];
		_mapAll set ["CACHE_REMOVE_REAGENTS",_cachedRemover];

		_mapAll
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		
		if !callFunc(_itm,isReagentContainer) exitWith {
			self callp(debugMessage,"Skipped non-reagent item %1" arg _itm)
		};

		private _ctxCopy = array_copy(_ctx);
		private _mapToAdd = _ctxCopy deleteAt "MAP_ADD_REAGENTS";
		private _delEmptyList = _ctxCopy deleteAt "LIST_CAN_DELETE_IF_EMPTY";
		private _cacheRemover = _ctxCopy deleteAt "CACHE_REMOVE_REAGENTS";
		private _countItems = _craftContext get "result_count";
		self callp(debugMessage,"count items %1; add reagents %2" arg _countItems arg _mapToAdd);
		
		callFunc(_itm,clearReagentSpace);
		private _newCapacity = 0;
		{
			private _toAdd = ifcheck(self getv(partial_transfer),_y/_countItems,_y);
			modvar(_newCapacity) + _toAdd;
		} foreach _mapToAdd;
		callFuncParams(_itm,setCapacity,_newCapacity);

		{
			private _toAdd = ifcheck(self getv(partial_transfer),_y/_countItems,_y);
			callFuncParams(_itm,addReagent, _x arg _y);
		} foreach _mapToAdd;

		private _precentageLoss = self getv(precentage_loss);

		if (self getv(loss_from_skills)) then {
			if ((_craftContext get "used_skill")=="craft_success") exitWith {};
			private _successAmount = _craftContext get "success_amount";
			private _pval = round linearconversion [0,16,_successAmount,0,100,true];
			modvar(_precentageLoss) + _pval;
		};

		if (_precentageLoss > 0) then {
			private _premove = precentage(callFunc(_itm,getFilledSpace),_precentageLoss);
			callFuncParams(_itm,removeReagents, _premove);
			if (callFunc(_itm,getFilledSpace)==0) exitWith {
				//todo reagents empty. what we do in this case?
			};
		};

		if (self getv(delete_on_empty)) then {
			{
				if !isNullReference(_x) then {
					delete(_x);
				};
			} foreach _delEmptyList;
		};

		//remove after all processed
		{
			_x params ["_item","_rlist"];
			if !isNullReference(_item) then {
				{
					_x params ["_rg","_vl"];
					callFuncParams(_item,removeReagent, _rg arg _vl);
				} foreach _rlist;
			};
		} foreach _cacheRemover;
	}

endstruct


struct(CraftModifier::replace_reagent) base(CraftModifierAbstract)
	def(title) "Замена реагента"
	def(description) "Модификатор заменяет реагент в результате крафта."
	def(required_fields) ["from","to"]
	def(allowed_params) [
		["from",[
			"type:string",
			"title:Исходный реагент",
			"description:Исходный реагент который будем заменять на to",
			"default:Nutriment",
			["examples",["Nutriment","Milk"]]
		]],
		["to",[
			"type:string",
			"title:Новый реагент",
			"description:Новый реагент, который будет заменять исходный",
			"default:Nutriment",
			["examples",["Nutriment","Milk"]]
		]]
	]

	def(from) ""
	def(to) ""

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name in ["from","to"]) exitWith {
			self callp(addParam,_name arg _val arg "");
		};
	};

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		if !callFunc(_itm,isReagentContainer) exitWith {};
		private _from = self getv(from);
		if (_from == "") exitWith {};
		private _to = self getv(to);
		if (_to == "") exitWith {};

		callFuncParams(_itm,replaceReagent,_from arg _to);
	};
endstruct

struct(CraftModifier::execute_code) base(CraftModifierAbstract)
	def(title) "Выполнение кода"
	def(description) "Выполняет код модификатора."
	def(required_fields) []
	def(allowed_params)
	[
		["code",[
			"type:string",
			"title:Инструкции",
			"description:Инструкции кода, которые будут выполнены после создания результата"
		]],
		["before_code",[
			"type:string",
			"title:Инструкции перед созданием результата",
			"description:Инструкции кода, которые будут выполнены до создания результата. Инструкции вызываются непосредственно при захвате контекста модификаторов."
		]]
	]

	def(compiled_code_result) {} 
	def(compiled_code_preinit) {}

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name == "code") exitWith {
			private _cde = [_val] call csys_internal_generateYamlExpr;
			if isNullVar(_cde) exitWith {
				self callp(setParseError,"Error on generating code");
			};
			self setv(compiled_code_result,_cde);
		};

		if (_name == "before_code") exitWith {
			private _cde = [_val] call csys_internal_generateYamlExpr;
			if isNullVar(_cde) exitWith {
				self callp(setParseError,"Error on generating precode");
			};
			self setv(compiled_code_preinit,_cde);
		};
	}

	def(createModifierContext)
	{
		params ["_capturedCtx"];
		private _map = callbase(createModifierContext);
		private _tags = _ctx;
		_tags set ["result",nullPtr];
		call (self getv(compiled_code_preinit));
		_map
	}

	def(collectTagInfo)
	{
		params ["_tagMap","_tagName","_objects"];
		_tagMap set [_tagName,_objects select 0];
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		private _tags = _ctx;
		_tags set ["result",_itm];
		call (self getv(compiled_code_result));
	}
endstruct


struct(CraftModifier::add_reagent) base(CraftModifierAbstract)
	def(title) "Добавление реагента"
	def(description) "Модификатор добавляет реагент в результат крафта."
	def(required_fields) ["reagent","amount"]
	def(allowed_params) [
		["reagent",[
			"type:string",
			"title:Реагент",
			"description:Реагент, который будет добавлен в результат крафта",
			["examples",["Nutriment","Milk"]]
		]],
		["amount",[
			"type:number",
			"title:Количество",
			"description:Количество добавляемого реагента",
			["default",1],
			["minimum",0.1],
			["maximum",99999]
		]],
		["expand_capacity",[
			"type:boolean",
			"title:Расширить емкость",
			"description:Расширить емкость реагент-контейнера если не удается добавить amount реагента. По умолчанию включено.",
			["default",true]
		]]
	]

	def(reagent) ""
	def(amount) 1
	def(expand_capacity) true

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name == "reagent") exitWith {
			self callp(addParam,_name arg _val arg "");
		};
		if (_name == "amount") exitWith {
			self callp(addParam,_name arg _val arg 1);
		};
		if (_name == "expand_capacity") exitWith {
			self callp(addParam,_name arg _val arg true);
		};
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		if (self getv(reagent) == "") exitWith {};
		if !callFunc(_itm,isReagentContainer) exitWith {};

		if (self getv(expand_capacity)) then {
			private _curCap = callFunc(_itm,getCapacity);
			if (callFunc(_itm,getFreeSpace)==0) then {
				callFuncParams(_itm,setCapacity,_curCap + (self getv(amount)));
			};
		};

		callFuncParams(_itm,addReagent,self getv(reagent) arg self getv(amount));
	}


endstruct

struct(CraftModifier::set_model) base(CraftModifierAbstract)
	def(title) "Установка модели"
	def(description) "Модификатор устанавливает модель в результат крафта."
	def(required_fields) ["value"]
	def(allowed_params) [
		["value",[
			"type:string",
			"title:Модель",
			"description:Путь до модели, которая будет установлена результирующему предмету"
		]]
	]

	//reset value macro from oop.hpp
	#undef value

	def(value) ""

	def(onParameter)
	{
		params ["_name","_val"];
		if (_name == "value") exitWith {
			self callp(addParam,_name arg _val arg "");
		};
	}

	def(onApply)
	{
		params ["_itm","_usr","_ctx","_craftContext"];
		if (self getv(value) == "") exitWith {};
		callFuncParams(_itm,setModel,self getv(value));
	}
endstruct