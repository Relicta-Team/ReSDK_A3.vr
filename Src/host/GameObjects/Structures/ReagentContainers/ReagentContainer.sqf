// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\..\..\engine.hpp>
#include <..\..\..\oop.hpp>
#include <..\..\GameConstants.hpp>


class(IStructReagentCont) extends(IStruct)
	#include "..\..\Interfaces\IReagentContainer.Interface"
	var(reagents,vec2(this,5) call ms_create);
endclass

class(IndustrialDropper) extends(IStructReagentCont)
	var(name,"Капельница");
	getterconst_func(transferAmount,[1 arg 2 arg 3 arg 4 arg 5]);
	var(reagents,vec2(this,80) call ms_create);
	var(material,"MatMetal");
endclass
