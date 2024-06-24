
//for testing use: ["InheritedStruct"] call struct_new;
struct(InheritedStruct) base(TestStruct)

endstruct

//for testing use: ["TestStruct"] call struct_new;
struct(TestStruct)
	def(created) 0;
	def(constructor)
	{
		self set(created,tickTime);
		logformat("%1 created",self);
		self call(testprint);
	}

	def(destructor)
	{
		logformat("%1 destroyed",self);
	}

	def(testprint)
	{
		logformat("Structure message %1",self)
	}
	
	def(str)
	{
		format["Object %1:%2",typename(self),self get(created)]
	}
endstruct