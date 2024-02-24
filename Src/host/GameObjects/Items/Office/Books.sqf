// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\..\text.hpp>
#include <..\..\GameConstants.hpp>

/*
["relicta_models\models\interier\props\book7.p3d",
"relicta_models\models\interier\props\book8.p3d",
"relicta_models\models\interier\props\book5.p3d",
"relicta_models\models\interier\props\book4.p3d",
"relicta_models\models\interier\props\book3.p3d",
"relicta_models\models\interier\props\book2.p3d",
"relicta_models\models\interier\props\book1.p3d",
"relicta_models\models\interier\props\book6.p3d"]
*/

editor_attribute("InterfaceClass")
class(IPaperItemBase) extends(Item)
	func(doBurn)
	{
		objParams_2(_srcFire,_usr);
		if (callFunc(_srcFire,isFireLight) && getVar(_srcFire,lightIsEnabled)) then {
			callSelfParams(worldSay,callSelf(getName) + " сгорает в огне." arg "info");
			delete(this);
			true
		} else {
			false
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);
		if callFunc(_with,isFireLight) then {
			callSelfParams(doBurn,_with arg _usr);
		};
	};

	getter_func(canRead,true);

endclass

editor_attribute("InterfaceClass")
class(IWritableContentItem) extends(IPaperItemBase)
	#include "..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"Book");
	var_exprval(ndInteractDistance,INTERACT_DISTANCE);

	var(content,""); //text in book
	getterconst_func(getMaxLen,1024*3);

	getter_func(canWrite,forceUnicode 0; (count getSelf(content))<callSelf(getMaxLen));

	func(canApplyText)
	{
		objParams_2(_txtToAdd,_ref);
		forceUnicode 0;
		private _curCount = (count getSelf(content))+(count _txtToAdd);
		private _canAdd = _curCount < callSelf(getMaxLen);

		if !isNullVar(_ref) then {
			refset(_ref,_curCount - callSelf(getMaxLen));
		};

		_canAdd
	};

	getter_func(getContent,getSelf(content)); //getting text in book

	func(onChangeLoc)
	{
		objParams();
		callSelf(closeNDisplayForAllMobs);
	};

endclass

class(Book) extends(IWritableContentItem)
	var(name,"Книга");
	var(ndName,"Book");
	var(model,"relicta_models\models\interier\props\book6.p3d");

	//getterconst_func(onePaperSize,256); //length one piper size

endclass

/*
["a3\structures_f\items\documents\file1_f.p3d",
"a3\structures_f\items\documents\file2_f.p3d"]
["ml_shabut\exoduss\blocknotkom.p3d",
"ml_shabut\exoduss\bukhuchet.p3d"]
*/

class(Paper) extends(IWritableContentItem)
	var(name,"Листок");
	var(desc,"");
	var(model,"a3\weapons_f_orange\ammo\leaflet_05_old_f.p3d");
	var(content,"");
	var(ndName,"Paper");
	var_exprval(ndInteractDistance,INTERACT_DISTANCE);
	var(weight,gramm(5));

	getter_func(getPickupSound,vec2("updown\paper_up"+str randInt(1,3),getRandomPitchInRange(.85,1.3)));
	getter_func(getDropSound,vec2("updown\paper_down"+str randInt(1,2),getRandomPitchInRange(.85,1.3)));
	getter_func(getPutdownSound,vec2("updown\paper_down"+str randInt(1,2),getRandomPitchInRange(.85,1.3)));

	getter_func(getEquipSound,vec2("updown\paper_up"+str randInt(1,3),getRandomPitchInRange(.85,1.3)));
	getter_func(getUnequipSound,vec2("updown\paper_up"+str randInt(1,3),getRandomPitchInRange(.85,1.3)));

	var_array(usrsWithWriters); //vec2: mob, ref writer

	func(getHandAnim)
	{
		objParams();
		if callSelf(isInWorld) exitwith {super()};
		if !array_exists(getSelf(ndOpenedBy),getSelf(loc)) exitwith {super()};
		ITEM_HANDANIM_TORCH
	};

	func(openNDisplayImplBackend)
	{
		objParams_1(_usr);
		callSuper(IWritableContentItem,openNDisplayImplBackend);
		if equals(_usr,getSelf(loc)) then {
			callFuncParams(_usr,syncSmdSlot,getSelf(slot));
		};
	};

	func(closeNDisplayImplBackend)
	{
		objParams_1(_usr);
		callSuper(IWritableContentItem,closeNDisplayImplBackend);
		private _idx = callSelfParams(findIndexUserWithWritter,_usr);
		if (_idx != -1) then {
			getSelf(usrsWithWriters) deleteAt _idx;
		};
		if equals(_usr,getSelf(loc)) then {
			callFuncParams(_usr,syncSmdSlot,getSelf(slot));
		};
	};

	func(findIndexUserWithWritter)
	{
		objParams_1(_usr);
		getSelf(usrsWithWriters) findIf {equals(_x select 0,_usr)}
	};

	/*
		Работа бумаги:
			Главные условия:
			- читающий и пишуший открывают один и тот же сетевой дисплей
			- пишуший может дополнять текст
			- когда пишущий дополнил текст, другие пишушие не потеряют свой текст. он буферизуется пока не закрыт ND
			- читающие просто видяет все изменения на бумаге

	*/

	func(getNDInfo) {
		objParams();

		if !isNullVar(__writemode__) exitWith {
			[true,getSelf(content)];
		};

		[getSelf(content)]
	};

	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);

		_inp params ["_mode","_data"];
		call {
			if (_mode == 0) exitWith {

				private _idx = callSelfParams(findIndexUserWithWritter,_usr);
				if (_idx == -1) exitWith {
					callFuncParams(_usr,localSay,pick vec3("Писать-то нечем.","А чем записать?!","Мне нечем написать это...") arg "error");
				};

				(getSelf(usrsWithWriters) select _idx) params ["_usrCached","_writter"];
				if not_equals(getVar(_writter,loc),_usr) exitWith {
					callFuncParams(_usr,localSay,pick vec3("Писать-то нечем.","А чем записать?!","Мне нечем написать это...") arg "error");
				};

				//Проверим размер буфера
				private _lenStr = refcreate(0);
				if !callSelfParams(canApplyText,_data arg _lenStr) exitWith {
					forceUnicode 1;
					private _ft = format["Всё не уместится. Нужно убрать %1 символов.",refget(_lenStr)];
					callFuncParams(_usr,localSay,_ft arg "error");
				};


				//До применения цвета ставим деск
				if (getSelf(desc) == "") then {
					forceUnicode 1;
					setSelf(desc,"Там видно текст: " + (_data select vec2(0,16)) + "...");

					//Статистика по запискам в раунде
					modVar(gm_currentMode,notesCreated, + 1);
				};

				_data = callFuncParams(_writter,applyColorToText,_data);

				//write data
				modSelf(content, + _data);
				callSelf(updateNDisplay);
			};
		};
	};

	func(onInteractWith)
	{
		objParams_2(_with,_usr);

		callSuper(IWritableContentItem,onInteractWith);

		if isTypeOf(_with,ItemWritter) exitWith {

			if !callSelf(canWrite) exitWith {
				callFuncParams(_usr,localSay,"Тут нельзя писать." arg "error");
			};

			getSelf(usrsWithWriters) pushBack vec2(_usr,_with);
			private __writemode__ = true;
			if callSelf(isInWorld) then {
				callFuncParams(this,openNDisplay,_usr);
			} else {
				callFuncParams(this,openNDisplayInternal,_usr arg getVar(_usr,owner))
			};
		};
	};
	getter_func(getMainActionName,"Прочитать");
	getter_func(canUseMainAction,callFunc(_usr,isMob) || isTypeOf(_usr,MobGhost)); //странная логика работы. без проверки типа почему-то призрак не может видеть действие
	func(onMainAction)
	{
		objParams_1(_usr);

		if !callSelf(canRead) exitWith {};

		if callSelf(isInWorld) then {
			callFuncParams(this,openNDisplay,_usr);
		} else {
			callFuncParams(this,openNDisplayInternal,_usr arg getVar(_usr,owner))
		};
	};

endclass

class(Notepad) extends(Paper)
	var(name,"Блокнот");
endclass

class(Folder) extends(Book)
	var(name,"Папка");
endclass


class(PaperHolder) extends(IPaperItemBase)
	var(model,"a3\weapons_f_orange\ammo\leaflet_05_stack_f.p3d")
	var(name,"Стопка бумаги");
	var(countBlanks,20);
	var(weight,0);

	func(getWeight)
	{
		objParams();
		getFieldBaseValue("Paper","weight") * getSelf(countBlanks)
	};

	func(getDescFor)
	{
		objParams_1(_usr);
		private _cnt = getSelf(countBlanks);
		callSuper(IPaperItemBase,getDescFor) + sbr + "Осталось " + str _cnt + ([_cnt,[" лист"," листа"," листов"]] call toNumeralString);
	};
	getter_func(getMainActionName,"Взять листок");
	func(onMainAction)
	{
		objParams_1(_usr);
		private _paper = new(Paper);
		if (callFuncParams(_usr,addItem,_paper)) then {
			modSelf(countBlanks, -1);
			callSelf(onWeightChanged);
			if (getSelf(countBlanks) == 0) then {
				delete(this);
			};
		} else {
			delete(_paper);
		};
	};

endclass

#ifdef EDITOR
class(BookChemReactions) extends(Book)
	getterconst_func(getName,"Секретные знания");
	var(ndName,"ChemReactionsInfo");

	func(getNDInfo)
	{
		objParams();

		if isNullVar(_internalReference) exitWith {[1]};

		#define gv(func) _y get #func
		private _data = [];
		private _dataReagents = [];
		private _dataReactions = [];

		_data set [0,_dataReagents];
		_data set [1,_dataReactions];

		{
			_dataReagents pushBack [gv(classname),
			gv(name),gv(scienceName),gv(slangName),gv(state),
			gv(chilling_products),
			gv(chilling_point),
			gv(heating_products),
			gv(heating_point)
			]
		} foreach ms_map_allMatters;

		private _reqItems = null;
		{
			_reqItems = [];
			{
				_fieldList = (missionNamespace getvariable ["pt_"+(_x select 0),nullPtr]) getVariable ["__fields",[]];
				_idx = _fieldList findif {(_x select 0) == "name"};
				if (_idx == -1) then {
					_reqItems pushBack [_x select 0,_x select 1];
				} else {
					_reqItems pushBack [((_fieldList select _idx) select 1) splitString """" select 0,_x select 1];
				};

			} foreach (gv(required_items));

			_dataReactions pushBack [gv(classname),
				gv(name),
				gv(result),gv(result_amount),
				gv(required_reagents),gv(catalysts),gv(inhibitors),
				gv(reaction_type),
				gv(minimum_temperature),gv(maximum_temperature),
				_reqItems
			];
		} foreach ms_map_allReactions;

		_data
	};

	func(onHandleNDInput)
	{
		objParams_2(_usr,_inp);
		_inp params ["_mode","_needSendData"];

		if (_needSendData) then {
			private _internalReference = true;
			callSelf(updateNDisplay);
		} else {
			callSelf(updateNDisplay);
		};
	};

	func(onMainAction)
	{
		objParams_1(_usr);

		if (!callSelf(isInWorld) && equals(getSelf(loc),_usr)) exitWith {
			callSelfParams(openNDisplayInternal,_usr);
		};
	};

endclass
#endif
