// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\engine.hpp"
#include "..\..\oop.hpp"
#include "..\..\struct.hpp"
#include "..\..\text.hpp"
#include "..\..\GameObjects\GameConstants.hpp"

#define TRACE_MESSAGES

#ifdef TRACE_MESSAGES
	#define debug(m) trace(m)
	#define debugformat(m,f) traceformat(m,f)
#else
	#define debug(m)
	#define debugformat(m,f)
#endif

struct(FryingPanSystem) base(BaseWorldProcessorCraftSystem)
	def(systemType) "frying_pan"

	def(procStage) 0 //default, 1 found campfire, 2 found recipe, 3 cooking

	def_null(campfireTransform) //CraftSerializedTransform
	def_null(sourceTransform) //CraftSerializedTransform
	def_null(tempObjectTransform) //CraftSerializedTransform
	def_null(craftResult) //CraftRecipeResult
	def_null(craftResultCtx);//hashmap
	def(processTimeLeft) 0

	def(toString)
	{
		#ifdef EDITOR
		private _b = callbase(toString);
		text format["%1 [stage:%2, time:%3]",_b,self getv(procStage),self getv(processTimeLeft)]
		#else
		callbase(toString)
		#endif
	}

	def(init)
	{
		params ["_src"];
		self setv(sourceTransform,struct_newp(CraftSerializedTransform,_src));
		self setv(campfireTransform,struct_newp(CraftSerializedTransform,nullPtr));
		self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,nullPtr));
	}

	def(process)
	{
		private _stage = self getv(procStage);
		debugformat("frypan: curstage %1",_stage)
		if (_stage == 0) exitWith {
			self callv(findNearCampfire);
		};
		if (_stage == 1) exitwith {
			self callv(findRecipe);
		};
		if (_stage == 2) exitWith {
			self callv(processCreation);
		};
	}

	def(findNearCampfire)
	{
		private _itList = (self callp(getObjects,"IDestructible" arg 0.4))
			//filter firelights
			select {
				callFunc(_x,isFireLight)
				&& {callFunc(_x,isInWorld)}
				&& {callFunc(_x,isStruct)}
			};
		private _src = self getv(src);

		//sortby distance [near...far]
		private _nearList = [_itList,{callFunc(_x,getDistanceTo,_src)}] call sortBy;
		if (count _nearList == 0) exitWith {
			debugformat("frypan: no campfire found",_src)
			//todo optimize
			self setv(procStage,0);
		};
		private _near = _nearList select 0; //select first

		self setv(campfireTransform,struct_newp(CraftSerializedTransform,_near));
		self getv(sourceTransform) callv(updateTransform);
		self setv(procStage,1);

		debugformat("frypan: found campfire %1",_near)
	}

	def(collectDistance) 0.25;

	def(findRecipe)
	{
		//reset stage if campfire invalid
		if !(self getv(campfireTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};

		private _pos = callFunc(self getv(src),getPos);
		private _objList = ["IDestructible",_pos,self getv(collectDistance),true,true] call getGameObjectOnPosition;
		//sort by distance, removing source
		_objList = [_objList - [self getv(src)],{callFunc(_x,getPos) distance _pos}] call sortBy;
		
		debugformat("frypan: near objects: %1",_objList)

		//define possible recipes
		private _possibleRecipes = self callp(_getRecipes,_objList);
		debugformat("Possible recipes: %1",_possibleRecipes)
		
		//check recipes
		private _curRecipes = []; //vec2(recipe,components)
		
		{
			private _robj = _x;
			private _leftComponents = array_copy(_robj getv(components)) apply {_x callv(createIngredientTempValidator)};

			{
				private _objIngredient = _x;
				{
					//skips ready
					if (_x callv(isReadyIngredient)) then {continue};

					if (_x callp(isValidIngredient,_objIngredient)) exitWith {
						_x callp(handleValidIngredient,_objIngredient);
					};
				} foreach _leftComponents;
			} foreach _objList;

			private _canCraft = all_of(_leftComponents apply {_x callv(canCraftFromIngredient)});
			if (_canCraft) then {
				_curRecipes pushBack [_robj,_leftComponents];
			};

		} foreach _possibleRecipes;
		assert_str(count _curRecipes <= 1,format vec3("Too many possible recipes (%2): %1",_curRecipes apply {_x select 1},count _curRecipes));

		if (count _curRecipes == 0) exitWith {
			//not found recipe	
		};

		private _robj = _curRecipes select 0 select 0;
		private _leftComponents = _curRecipes select 0 select 1;

		//found cooker
		private _possibleCookers = createHashMap;//<hashUser,count>
		private _possibleCookersPtr = createhashMap;//<hashUser,ptr>
		private _pUsr = null;
		private _hashUsr = null;
		{
			{
				_pUsr = callFunc(_x select 0,getLastTouched);
				_hashUsr = getVar(_pUsr,pointer);
				if !(_hashUsr in _possibleCookers) then {
					_possibleCookers set [_hashUsr,0];
					_possibleCookersPtr set [_hashUsr,_pUsr];
				};

				_possibleCookers set [_hashUsr,(_possibleCookers get _hashUsr) + 1];
			} foreach (_x getv(_foundItems));
		} foreach _leftComponents;

		_possibleCookers = _possibleCookers toArray false;
		_possibleCookers = [_possibleCookers,{_x select 1}] call sortBy;
		debugformat("frypan: possible cookers: %1",_possibleCookers)
		if (count _possibleCookers == 0) exitWith {
			setLastError("Possible cookers is empty");
		};

		//save cooker
		private _cooker = _possibleCookersPtr get (_possibleCookers select 0 select 0);
		self setv(usr,_cooker);
		private _refSuccess = refcreate(0);
		private _canCraftBySkills = _robj callp(checkCraftSkills,_cooker arg _refSuccess);

		private _allPoses = [];
		//use components and calculate tempobject pos
		{
			{
				_allPoses pushBack callFunc(_x select 0,getPos);
			} foreach (_x getv(_foundItems));

			_x callv(onComponentUsed); //use component
		} foreach _leftComponents;
		//create temp cooking
		private _midPos = [_allPoses] call getPosListCenter;
		if equals(_midPos,vec3(0,0,0)) then {_midPos = callFunc(self getv(src),getPos)};
		private _tempItem = ["OrganicDebris1",_midPos] call createGameObjectInWorld;
		setVar(_tempItem,_lockedCanIgnite,true);
		self setv(tempObjectTransform,struct_newp(CraftSerializedTransform,_tempItem));
		//allocate time
		self setv(processTimeLeft,10); //TODO remove magic number (time creating)
		self setv(procStage,2);

		//set result
		self setv(craftResult,_robj getv(result));
		private _ctx = createHashMapFromArray [
			["position",_midPos],
			["user",self getv(usr)],
			["recipe",_robj],
			["used_skill",_refSuccess select 0],
			["success_amount",getRollAmount(_refSuccess select 1)],
			["roll_result",getRollType(_refSuccess select 1)],
			["amount_3d6",getRollDiceAmount(_refSuccess select 1)],
			["components_copy",_leftComponents]
		];
		self setv(craftResultCtx,_ctx);
	}

	def(processCreation)
	{
		if !(self getv(campfireTransform) callv(isValid)) exitWith {
			self setv(procStage,0); //reset to find campfire
		};
		if !(self getv(sourceTransform) callv(isValid)) exitWith {
			self setv(procStage,0);
		};
		if !(self getv(tempObjectTransform) callv(isValid)) exitWith {
			self setv(procStage,1); //reset to find items
		};
		self modv(processTimeLeft, - 1);

		if ((self getv(processTimeLeft)) <= 0) then {
			delete(self getv(tempObjectTransform) getv(_origObject));
			self setv(procStage,1); //reset to found item
			private _ctx = self getv(craftResultCtx);
			self getv(craftResult) callp(onCrafted,_ctx);
		};
	}

endstruct