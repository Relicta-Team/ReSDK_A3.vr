// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
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

#define __CONST_WRITABLE_ITEM_CONTENT_MAX_LEN__ 1024*10

editor_attribute("InterfaceClass")
class(IPaperItemBase) extends(Item)
	var(material,"MatPaper");
	var(weight,gramm(10));
	var(size,ITEM_SIZE_SMALL);
	
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
	"
		name:Хранящий текст предмет
		desc:Базовый класс для любого, хранящего текст предмета. Обычно от этого класса унаследованы листки бумаги, книги, документы и т.д.
		path:Игровые объекты.Текстовые
	" node_class
	
	#include "..\..\Interfaces\INetDisplay.Interface"
	var(ndName,"Book");
	var_exprval(ndInteractDistance,INTERACT_DISTANCE);


	"
		name:Текстовое содержимое
		desc:Текст, содержащийся в книге, бумаге или любом другом предмете, способном хранить текст.
		prop:get
		classprop:1
		return:string:Текстовое содержимое
	" node_var
	var(content,""); //text in book

	"
		name:Максимальная длина текста
		desc:Максимальная допустимая длина текста в книге или листке бумаги. На данный момент константна и равна "+(str (__CONST_WRITABLE_ITEM_CONTENT_MAX_LEN__))+" символам.
		type:get
		lockoverride:1
		return:int:Максимальная длина текста
	" node_met
	getterconst_func(getMaxLen,__CONST_WRITABLE_ITEM_CONTENT_MAX_LEN__);

	"
		name:Можно записать
		desc:Возвращает истину, если в хранилище текста можно добавить дополнительные данные.
		type:get
		lockoverride:1
		return:bool:Можно записать
	" node_met
	getter_func(canWrite,forceUnicode 1; (count getSelf(content))<callSelf(getMaxLen));

	"
		name:Можно прочитать
		desc:Возвращает истину, если есть возможность открыть хранилище текста для чтения персонажем.
		type:get
		lockoverride:1
		return:bool:Можно прочитать
	" node_met
	getter_func(canRead,true);

	func(canApplyText)
	{
		objParams_2(_txtToAdd,_ref);
		forceUnicode 0; //enable full
		private _curCount = (count getSelf(content))+(count _txtToAdd);
		forceUnicode -1; //reset
		private _canAdd = _curCount <= callSelf(getMaxLen);

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

	"
		name:Добавить текст
		desc:Добавляет текст в хранилище текста.
		type:method
		lockoverride:1
		in:string:Текст:Добавляемый текст
		in:ItemWritter:Писатель:Объект, которым пишется текст (например, ручка). Обычно отвечает за то, какой будет стиль и цвет текста. Если параметр не указан - добавленный текст будет добавлен стандартным черным цветом.
			opt:require=-1
		return:bool:Возвращает истину, если текст добавлен.
	" node_met
	func(appendText)
	{
		objParams_2(_data,_writter);

		if !callSelfParams(canApplyText,_data) exitWith {false};

		//fix format nextlines
		//! only after validate size (temporary fix)
		_data = _data splitString endl joinString sbr;

		if (!isNullVar(_writter) && {!isNullReference(_writter)}) then {
			_data = callFuncParams(_writter,applyColorToText,_data);
		};

		//write data
		modSelf(content, + _data);
		callSelf(updateNDisplay);
	};

	//editor paper data
	editor_attribute("alias" arg "Содержимое")
	editor_attribute("Tooltip" arg "Данные записанные в объекте, способном хранить текст.")
	editor_attribute("EditorVisible" arg "type:string" arg "stringmaxsize:"+str(__CONST_WRITABLE_ITEM_CONTENT_MAX_LEN__))
	var(preinit@__content,""); //системная переменная для установки ключей через редактор

	func(__handlePreInitVars__)
	{
		objParams();
		super();
		private _ct = getSelf(preinit@__content);
		if (_ct!="") then {
			callSelfParams(appendText,_ct);
			setSelf(preinit@__content,null);
		};
	};

endclass

/*
["a3\structures_f\items\documents\file1_f.p3d",
"a3\structures_f\items\documents\file2_f.p3d"]
["ml_shabut\exoduss\blocknotkom.p3d",
"ml_shabut\exoduss\bukhuchet.p3d"]
*/

class(Paper) extends(IWritableContentItem)
	"
		name:Листок
		desc:Базовый класс для листа бумаги.
		path:Игровые объекты.Текстовые
	" node_class

	var(name,"Листок");
	var(desc,"");
	var(model,"a3\weapons_f_orange\ammo\leaflet_05_old_f.p3d");
	var(content,"");
	var(ndName,"Paper");
	var_exprval(ndInteractDistance,INTERACT_DISTANCE);
	var(weight,gramm(5));
	var(size,ITEM_SIZE_SMALL);

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
					// forceUnicode 1; //not needed
					private _ft = format["Всё не уместится. Нужно убрать %1 символов.",refget(_lenStr)];
					callFuncParams(_usr,localSay,_ft arg "error");
				};


				//До применения цвета ставим деск
				if (getSelf(desc) == "") then {
					forceUnicode 1; //enable for select
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
	var(model,"a3\structures_f\items\documents\notepad_f.p3d")
	var(name,"Блокнот");
	var(dr,1);
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(100));
endclass

class(Documents) extends(Paper)
	var(model,"a3\structures_f\items\documents\file2_f.p3d")
	var(name,"Документы");
	var(size,ITEM_SIZE_SMALL);
	var(weight,gramm(170));
endclass

class(Documents1) extends(Paper)
	var(model,"a3\structures_f\items\documents\file1_f.p3d")
	var(name,"Документы");
endclass

class(Folder) extends(Book)
	var(name,"Папка");
	var(weight,gramm(220));
	var(size,ITEM_SIZE_MEDIUM);
	var(dr,1);
endclass

class(Book) extends(Paper)
	"
		name:Книга
		desc:Базовый класс для книги.
		path:Игровые объекты.Текстовые
	" node_class
	var(name,"Книга");
	//var(ndName,"Book");
	var(model,"relicta_models\models\interier\props\book6.p3d");

	var(size,ITEM_SIZE_MEDIUM);
	var(weight,gramm(350));
	var(dr,2);

	getter_func(canWrite,false);

	//getterconst_func(onePaperSize,256); //length one piper size

endclass


class(PaperHolder) extends(IPaperItemBase)
	var(model,"a3\weapons_f_orange\ammo\leaflet_05_stack_f.p3d")
	var(name,"Стопка бумаги");
	var(countBlanks,20);
	var(weight,0.5);
	var(size,ITEM_SIZE_MEDIUM);
	getter_func(objectHealthType,OBJECT_TYPE_COMPLEX);

	func(constructor)
	{
		objParams();
		setSelf(weight,getFieldBaseValue("Paper","weight") * getSelf(countBlanks));
		callSelf(generateObjectHP);
	};

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
