// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\oop.hpp"
#include "..\engine.hpp"


class(TestGameClass) 

	var(strval,"Hello world!");
	var(anot,1);
	var(isObject,false);

	func(testPrint)
	{
		objParams();

		error(getSelf(strval));
	};

	func(ParamsTest)
	{
		objParams_1(_message);

		systemChat _message;
	};
	
	func(constructor)
	{
		error("class inited!");
	};
	
	func(destructor)
	{
		error("on delete child");
	};
	
	func(override_test)
	{
		objParams();
		
		super(override_test);
	};

endclass

class(object) 

	_mother = TYPE_SUPER_BASE;
	func(TEST)
	{
		objParams();
		warning(str getSelf(isobject));
	};
	
	func(constructor)
	{
		objParams();
		error("object inited! ");
	};
	
	func(destructor)
	{
		error("on delete BASE");
	};
	
	var(isobject,true);
	
	func(override_test)
	{
		objParams();
		warning("basic overrinden member");
	};
	
	
endclass