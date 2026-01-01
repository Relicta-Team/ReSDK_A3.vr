// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>

editor_attribute("InterfaceClass") editor_attribute("HiddenClass")
class(IContainerStruct) extends(Furniture)
	var(name,"Контейнер");
	#include "..\..\Interfaces\IContainer.Interface"
	editor_attribute("EditorVisible" arg "type:int" arg "range:1:100") editor_attribute("Tooltip" arg "Общее количество слотов в контейнере")
	var(countSlots,20);
	editor_attribute("EditorVisible" arg "custom_provider:size") editor_attribute("Tooltip" arg "Максимальный размер предметов\nкоторые можно поместить в контейнер")
	var(maxSize,ITEM_SIZE_MEDIUM);
endclass

editor_attribute("InterfaceClass")
class(SContainer) extends(IContainerStruct)
	var_exprval(countSlots,DEFAULT_BOX_STORAGE); //количество слотов (доступный объём контейнера)
	var(maxSize,ITEM_SIZE_BIG); //максимальный допустимый объем предмета для укладки в контейнер
	var(dr,2);
endclass

//virtual
class(Virt_ChemBlender) extends(IContainerStruct)
	var_exprval(countSlots,DEFAULT_ITEMBAG_STORAGE);
	var(name,"Раздатчик таблеток");
	var(chemBlender,nullPtr);//reference to electical device
	
	func(canAdd)
	{
		objParams_1(_item);
		private _canAdd = callSuper(IContainerStruct,canAdd);
		if (_canAdd) then {isTypeOf(_item,Pill)} else {false}
	};
	
	getter_func(getContainerMainData,vec3(callSelf(getName),getVar(getSelf(chemBlender),pointer),true));
endclass


//================== Others ==================

class(KeyHolder) extends(SContainer)
	var(name,"Ключница");
	var(model,"ml_shabut\exodus\sdaykey.p3d");
	var(material,"MatSynt");
	var(dr,1);
endclass

class(InfoBoard) extends(KeyHolder)
	var(name,"Доска информации");
	var(model,"ml_shabut\exodus\infotablicka.p3d");
	var(material,"MatWood");
	var(canUseContainer,false);

	func(canEmplaceItem)
	{
		objParams_5(_obj,_pos,_dir,_vup,_usr);
		if (isTypeOf(_obj,Paper) || isTypeOf(_obj,ItemWritter)) exitWith {true};
		super()
	};
	
endclass

class(Hanger) extends(InfoBoard)
	var(name,"Вешалка");
	var(model,"ml_shabut\exodusss\veshalochechka.p3d");
	var(material,"MatMetal");

	func(canEmplaceItem)
	{
		objParams_5(_obj,_pos,_dir,_vup,_usr);
		if (isTypeOf(_obj,Cloth)) exitWith {true};
		super()
	};

endclass	



























