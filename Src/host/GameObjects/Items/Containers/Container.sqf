// ======================================================
// Copyright (c) 2017-2024 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\..\engine.hpp"
#include "..\..\..\oop.hpp"
#include <..\..\..\bitflags.hpp>
#include "..\..\..\ServerRpc\serverRpc.hpp"
#include "..\..\..\PointerSystem\pointers.hpp"
#include "..\..\..\text.hpp"
#include "..\..\GameConstants.hpp"

editor_attribute("InterfaceClass")
class(Container) extends(Item)

	#include "..\..\Interfaces\IContainer.Interface"

	editor_attribute("EditorVisible" arg "type:int" arg "range:1:100") editor_attribute("Tooltip" arg "Общее количество слотов в контейнере")
	var(countSlots,2);
	editor_attribute("EditorVisible" arg "custom_provider:size") editor_attribute("Tooltip" arg "Максимальный размер предметов\nкоторые можно поместить в контейнер")
	var(maxSize,ITEM_SIZE_TINY);

	func(onChangeLoc)
	{
		objParams();
		{
			callSelfParams(onContainerClose,_x);
			callFuncParams(_x,sendInfo,"onChangeLocContainer");
		} foreach getSelf(openedBy);

		setSelf(openedBy,[]);
	};


endclass
