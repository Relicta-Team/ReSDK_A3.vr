// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



class(GameObject) 
	editor_attribute("Tooltip" arg "Some name for basic object") 
	var(name,"Object");
	
endclass


class(ChildObject_1) extends(GameObject)
	var(name,"Child");
endclass

class(ChildObject_3) extends(GameObject)
	
endclass

class(ObjectOther) extends(ChildObject_1)
	
endclass

class(ObjectOtherInternal) extends(ObjectOther)
	
endclass

class(ChildObject_2) extends(GameObject)
	editor_attribute("InternalImpl")
	var(someinternal,-1);
endclass

class(ChildObject_2_internal) extends(ChildObject_2)
	
endclass