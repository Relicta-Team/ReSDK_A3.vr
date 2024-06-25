
//for testing use: ["InheritedStruct"] call struct_alloc;
struct(InheritedStruct) base(TestStruct)

endstruct

//for testing use: ["TestStruct"] call struct_alloc;
struct(TestStruct)
	def(created) 0;
	def(init)
	{
		self setv(created,tickTime);
		logformat("%1 created",self);
		self callv(testprint);
	}

	def(del)
	{
		logformat("%1 destroyed",self);
	}

	def(testprint)
	{
		logformat("Structure message %1",self)
	}
	
	def(str)
	{
		format["Object %1:%2",typename(self),self getv(created)]
	}
endstruct