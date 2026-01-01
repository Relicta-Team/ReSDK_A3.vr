// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

/*
Logger.Log("INIT");
float time = Time.TickTime;

CaveGenerator cave = new CaveGenerator(new Vector(2000f,2000f,10f),new Vector(2300f,2300f,10f));
cave.SetOptionGeneral(12,10,0.3f,0.3f);
cave.SetOptionBranches(1,1,15,0.15f);
cave.SetOptionSideBranches(0,1,4,0.2f);
cave.SetOptionEntry(new Vector(-1,0,0),new Vector(1,0,0));
cave.Generate();

time = Time.TickTime - time;
Logger.Log("Caves were generated. Time elapsed: " + time + "s");

time = Time.TickTime;

CaveGenerator cave2 = new CaveGenerator(new Vector(2310f,2300f,10f),new Vector(2500f,2200f,10f));
cave2.SetOptionGeneral(15,10,0.25f,0.25f);
cave2.SetOptionBranches(1,1,15,0.15f);
cave2.SetOptionSideBranches(3,1,4,0.2f);
cave2.SetOptionEntry(new Vector(-1,0,0),new Vector(1,0,0));
cave2.Generate();

time = Time.TickTime - time;
Logger.Log("Caves were generated. Time elapsed: " + time + "s");


 */
dfunc(load) = {
	
	{
		deleteVehicle _x;
	} foreach gvar(listCaveBlocks);
	
	_sizes = -500;
	[vector(2000,2000,10),vector(2000 + _sizes,2000 + _sizes,10)] cfunc(init);

	cave_setOptionGeneral(5,10,0.4,0.5);
	cave_setOptionBranches(2,1,15,0.35);
	cave_setOptionSideBranches(0,1,4,0.2);
	cave_setOptionEntry(vector(-1,0,0),vector(1,0,0));
	
	
	cfunc(generate);
};


dfunc(testLoad) = {
	_sizes = 2300;
	[vector(2000,2000,10),vector(2300,2300,10)] cfunc(init);

	cave_setOptionGeneral(0,10,0.4,0.5);
	cave_setOptionBranches(2,1,15,0.35);
	cave_setOptionSideBranches(0,1,4,0.2);
	cave_setOptionEntry(vector(-1,0,0),vector(1,0,0))
	
	cfunc(generate);
	
	[vector(2310,2310,10),vector(2500,2500,10)] cfunc(init);
	cave_setOptionGeneral(30,10,0.4,0.5);
	cfunc(generate);
};	

dfunc(preyLoad) = {
	
	_sizes = -250;
	[vector(2000,2000,10),vector(2000 + _sizes,2000 + _sizes,10)] cfunc(init);

	cave_setOptionGeneral(5,10,0.5,0.5);
	cave_setOptionBranches(4,1,18,0.4);
	cave_setOptionSideBranches(2,1,4,0.3);
	cave_setOptionEntry(vector(0,0,0),vector(0,0,0));
	
	//debug cleanup
	if (!isNIL{gvar(objectsList)}) then {
		{
			if callFunc(_x,isDecor) then {
				[_x] call deleteDecor;
			};
			if callFunc(_x,isStruct) then {
				[_x] call deleteStructure;
			};
			if callFunc(_x,isItem) then {	
				delete(_x);
			};
			
		} foreach gvar(objectsList);
	};
	gvar(objectsList) = [];
	gvar(randPoses) = [];
	gvar(backupedPoses) = [];
	
	/*
	initDecor = {
		params ["_class","_pos","_dir","_vec",["_initCode",{}]];
		
	['Decor',
		[3683.55,3664.84,33.8468],325.658,[0,0,1], 
		{_thisObj setvariable ['model','ml\ml_object_new\model_14_10\propeller.p3d'];}
	] call InitDecor;
	*/
	
	#define setmdl(strvar) setSelf(model,strvar) 
	#define structmdl(p) ["IStruct",{setmdl(p)}]
	#define structmdlname(p,n) ["IStruct",{setmdl(p); setSelf(name,n)}]
	
	_probMushroom = 30;
		_mushroomCount = 6;
		_mushroomInit = ["Meatflower","Blevanton","Slimehat","Gnilokornik","Zhivoglot","Yaichnik","Svetlolik","Tumannik","Egg"];
	_probStone = 60;
		_stoneCount = 4;
		_stoneInit = [
			["IStruct",{setmdl("a3\rocks_f_exp\lavastones\lavastonecluster_small_f.p3d"); setSelf(name,"Камень")}],
			structmdlname("a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d","Камень"),
			//"a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d"
			structmdlname("a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d","Камень"),
			//"a3\rocks_f\water\w_sharpstone_02.p3d"
			structmdlname("a3\rocks_f\water\w_sharpstone_02.p3d","Камень"),
			//"a3\rocks_f\water\w_sharpstones_erosion.p3d" 
			structmdlname("a3\rocks_f\water\w_sharpstones_erosion.p3d","Камень"),
			["IStruct",{setmdl("a3\rocks_f\water\w_sharprock_apart.p3d"); setSelf(name,"Груда камней")},vec3(0,0,rand(-3,-6))]
		];
	_probGarbage = 40;
		_garbageCount = 3;
		_garbageInit = [
			["IStruct",{setmdl(pick ["a3\structures_f_enoch\military\training\craterlong_02_f.p3d" arg "a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d"])}],
			//arg "apalon\metro_a3\surfaces\gryazoookass.p3d" - non usable
			["IStruct",{setmdl(pick ["ml_shabut\nvprops\gryazyuka5.p3d" arg "ml_shabut\nvprops\gryazyuka3.p3d" arg "ml_shabut\nvprops\gryazyuka4.p3d" ])}]
		];
		
	_probHouse = 27;
		_houseCount = 1;
		_houseInit = [
			["IStruct",{setmdl("ca\buildings2\houseblocks\houseblock_c\houseblock_c5_ruins.p3d")}],
			["IStruct",{setmdl("a3\structures_f_enoch\industrial\farms\barn_03_large_ruins_f.p3d")}],
			structmdl("a3\structures_f_exp\civilian\slum_01\slum_01_ruins_f.p3d"),
			structmdl("ca\buildings\ruins\stanice_ruins.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house02_ruins_f.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house03_ruins_f.p3d"),
			structmdl("a3\structures_f\households\addons\garage_v1_ruins_f.p3d"),
			structmdl("a3\structures_f_enoch\ruins\houseruin_small_01_f.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house03_f.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house01_f.p3d"),
			structmdl("a3\structures_f\households\stone_small\stone_housesmall_v1_ruins_f.p3d"),
			structmdl("a3\structures_f\households\stone_shed\stone_shed_v1_ruins_f.p3d"),
			structmdl("ca\buildings\dum_zboreny_total.p3d"),
			structmdl("ca\buildings2\houseblocks\houseblock_d\houseblock_d2_ruins.p3d"),
			structmdl("a3\structures_f_enoch\military\bunkers\bunker_02_light_double_f.p3d"),
			structmdl("a3\structures_f_enoch\military\bunkers\bunker_02_light_right_f.p3d"),
			structmdl("a3\structures_f_enoch\military\bunkers\bunker_02_light_left_f.p3d")
		];
		
	_probVegetation = 80;
		_vegetationCount = 7;
		_vegetationInit = [
			structmdl("ml\ml_object_new\shabbat\nowoederewo.p3d"),
			structmdl("ml\ml_object_new\shabbat\gardentree.p3d"),
			structmdl("ml\ml_object_new\model_24\derevo.p3d"),
			structmdl("ml\ml_object_new\model_24\yolka.p3d"),
			//testing
			structmdl("veg_gliese\g2_off.p3d"),
			structmdl("veg_gliese\bb1.p3d"),
			structmdl("veg_gliese\hrock1.p3d"),
			structmdl("veg_gliese\br1.p3d"),
			structmdl("veg_gliese\t1.p3d"),
			structmdl("veg_gliese\t2.p3d"),
			structmdl("veg_gliese\t3.p3d"),
			structmdl("veg_gliese\tp1.p3d"),
			structmdl("veg_gliese\ts1.p3d"),
			structmdl("veg_gliese\tt1.p3d"),
			structmdl("veg_gliese\tw1.p3d"),
			structmdl("veg_gliese\tw2.p3d"),
			structmdl("veg_gliese\tx1.p3d"),
			structmdl("veg_gliese\tx2.p3d"),
			structmdl("veg_gliese\tx3.p3d"),
			structmdl("veg_gliese\tx7.p3d"),
			structmdl("veg_gliese\tx9.p3d"),
			structmdl("egl_gliese_misc\crystal1.p3d"),
			structmdl("egl_gliese_misc\crystal3.p3d"),
			structmdl("egl_gliese_misc\crystal4.p3d"),
			structmdl("egl_gliese_misc\crystal5.p3d"),
			structmdl("egl_gliese_misc\crystal6.p3d"),
			structmdl("egl_gliese_misc\crystal7.p3d")
		];
	
	gvar(preCreate) = {
		
	};

	gvar(handleCreate) = {
		
		if (_k == 0) then {
			if (_j > 15 || _i > 15) then {
				if (
					getGrid(_i,_j,_k) && 
					getGrid(_i+1,_j,_k) && 
					getGrid(_i,_j+1,_k) && 
					getGrid(_i-1,_j,_k) && 
					getGrid(_i,_j-1,_k) &&
					//other
					getGrid(_i+1,_j+1,_k) &&
					getGrid(_i-1,_j-1,_k) &&
					getGrid(_i+1,_j-1,_k) &&
					getGrid(_i-1,_j+1,_k)
				) then {
					gvar(randPoses) pushBack (_vPos vectorAdd [0,0,5.5]);
				} else {
					gvar(backupedPoses) pushBack (_vPos vectorAdd [0,0,0]);
				};
			};
		};
		
		_cube = ["BlockDirt",_vPos, pick[0,90,180,270],[0,0,1]] call initDecor;
		gvar(objectsList) pushBack _cube;
		
		if (_k != 0) exitWith {};
		
		#define ALG_ITEM 0
		#define ALG_STRUCT 1
		#define ALG_DEC 2
		#define GLOBADD(probVal,getInitializer,getCounter,vector_pos,vector_dir,alg_idx) \
		if prob(probVal) then { \
			_cur = getInitializer; \
			_isArray = equalTypes(_cur,[]); \
			_cls = ifcheck(_isArray,_cur select 0,_cur); \
			_inicode = ifcheck(_isArray,_cur select 1,{}); \
			_posvecadd = ifcheck(_isArray && {count _cur >= 3},_cur select 2,vec3(0,0,0)); \
			_algCODE = if (alg_idx == ALG_ITEM) then {{[_cls,_newpos,random 360,false,_newvec] call createItemInWorld}} else { \
				if (alg_idx == ALG_STRUCT)then {{[_cls,_newpos,random 360,_newvec,_inicode] call initStruct}} else { \
					{[_cls,_newpos,random 360,_newvec,_inicode] call initDecor} \
				} \
			}; \
			for "_i" from 1 to randInt(1,getCounter) do { \
				_newpos = (_vPos vectorAdd vector_pos) vectorAdd _posvecadd; \
				_newvec = vector_dir; \
				gvar(objectsList) pushBack (call _algCODE); \
			}; \
		}; 
		
		GLOBADD(
			_probGarbage,
			pick _garbageInit,
			_garbageCount,
			vec3(rand(-5,5),rand(-5,5),rand(0.25,-0.7)),
			vec3(0,0,1),
			ALG_STRUCT
		)
		GLOBADD(
			_probMushroom,
			pick _mushroomInit,
			_mushroomCount,
			vec3(rand(-5,5),rand(-5,5),rand(-0.1,-0.28)),
			vec3(rand(0,0),rand(0,0),rand(-1,1)),
			ALG_ITEM
		)
		GLOBADD(
			_probStone,
			pick _stoneInit,
			_stoneCount,
			vec3(rand(-5,5),rand(-5,5),rand(0.1,-0.6)),
			vec3(0,0,1),
			ALG_STRUCT
		)
		GLOBADD(
			_probVegetation,
			pick _vegetationInit,
			_vegetationCount,
			vec3(rand(-5,5),rand(-5,5),rand(-6,-1)),
			vec3(0,0,1),
			ALG_STRUCT
		)
		GLOBADD(
			_probHouse,
			pick _houseInit,
			_houseCount,
			vec3(rand(-5,5),rand(-5,5),rand(1.3,-4.6)),
			vec3(0,0,1),
			ALG_DEC
		)
	};
	gvar(postCreate) = {
		if (count gvar(randPoses) == 0) then {
			_pos = pick gvar(backupedPoses);
			{
				if (!callFunc(_x,isMob) && callFunc(_x,getClassName)!="BlockDirt") then {
					delete(_x);
				};
			} foreach (["GameObject",_pos,15,true,true] call getGameObjectOnPosition);
			
			_o = ["OldWoodenBox",_pos,random 360,vec3(0,0,1),{setSelf(name,"Ящичек")}] call initStruct;
			setVar(gm_currentMode,container,_o);
			gvar(objectsList) pushBack _o;
			{
				_npos = _pos vectorAdd [sin (_x) * 2.5,cos (_x) * 2.5,0];
				_o = ["Campfire",_npos,random 360,vec3(0,0,1),{setSelf(name,"Святой костёр")}] call initStruct;
				gvar(objectsList) pushBack _o;
			} foreach [0,120,240];
			
		} else {
			_pos = pick gvar(randPoses);
			_pos = _pos vectorAdd vec3(0,0,rand(-2,-3.5));
			
			//first rem all objects in this place
			{
				if (!callFunc(_x,isMob) && callFunc(_x,getClassName)!="BlockDirt") then {
					delete(_x);
				};
			} foreach (["GameObject",_pos,18,true,true] call getGameObjectOnPosition);
			
			_o = ["Decor",_pos,pick[0,90,180,270],vec3(0,0,1),{setSelf(model,"a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d")}] call initDecor;
			gvar(objectsList) pushBack _o;
			
			_posesBase = [
				[-4.15137,-3.24512,1.23779],
				[-5.58301,2.52417,1.23779],
				[2.52075,0.587769,1.23779],
				[-0.276367,-4.03662,1.71859],
				[6.39355,-4.19275,1.23779],
				[2.87671,2.72986,1.2908],
				[4.79211,4.55273,-2.47259],
				[6.2323,-4.64124,-2.47259],
				[-0.159058,-4.17627,-2.47259],
				[2.61987,4.45667,-2.47259],
				[-0.239258,4.67944,-2.47259],
				[-5.5968,4.73047,-1.76803],
				[-2.78186,0.809448,-2.47259],
				[-2.41333,-4.27429,-2.44751]
			];
			
			{
				getVar(gm_currentMode,relicProbSpawnpos) pushBack (getVar(_o,loc) modelToWorld _x);
			} foreach _posesBase;
			
			_relativePos = pick _posesBase;
			
			_posCont = getVar(_o,loc) modelToWorld _relativePos;
			_o = ["OldWoodenBox",_posCont,random 360,vec3(0,0,1),{setSelf(name,"Ящичек")}] call initStruct;
			setVar(gm_currentMode,container,_o);
			gvar(objectsList) pushBack _o;
		};
		
		{
			if (!callFunc(_x,isMob) && callFunc(_x,getClassName)!="BlockDirt") then {
				delete(_x);
			};
		} foreach (["GameObject",[1999.64,1998.8,10.5404],15,true,true] call getGameObjectOnPosition);
		
		//make base
		_basePos = [2000,2000,10];
		{
			_x params ["_p","_d"];
			_o = ["IStruct",_basePos vectorAdd _p,_d,vec3(0,0,1),{setSelf(model,"ml_shabut\nvprops\nv_barik2.p3d")}] call initStruct;
			gvar(objectsList) pushBack _o;
		} foreach [
			[[6,-3,0],90],
			[[6,+4,0],270],
			[[3,6,0],180],
			[[-4,6,0],0]
		];
		
		{
			//gvar(objectsList) pushBack (createMesh( ["a3\structures_f\civ\camping\fireplace_f.p3d" arg _x arg false]))
		} foreach gvar(randPoses);
		
		gvar(backupedPoses) = [];
		gvar(randPoses) = [];
	};
	
	
	cfunc(generate);
};


dfunc(dirtpitLoad) = {
	private _posStart = [3786,3835 +20,24];

	private _sizes = 250;
	//[[3780,3850] ,[3900,4000,24]] cfunc(init);

//3786.04,3845.04,
	_sizes = -400;
	[vector(3825.57,3877.5+10,24),vector(3825.57 + _sizes,3877.5 + _sizes*2,24)] cfunc(init);

	cave_setOptionGeneral(5,10,0.5,0.5);
	cave_setOptionBranches(4,1,18,0.4);
	cave_setOptionSideBranches(2,1,4,0.3);
	cave_setOptionEntry(vector(0,0,0),vector(0,-1,0));
	
	//debug cleanup
	if (!isNIL{gvar(objectsList)}) then {
		{
			if callFunc(_x,isDecor) then {
				[_x] call deleteDecor;
			};
			if callFunc(_x,isStruct) then {
				[_x] call deleteStructure;
			};
			if callFunc(_x,isItem) then {	
				delete(_x);
			};
			
		} foreach gvar(objectsList);
	};
	gvar(objectsList) = [];
	gvar(randPoses) = [];
	gvar(backupedPoses) = [];
	
	/*
	initDecor = {
		params ["_class","_pos","_dir","_vec",["_initCode",{}]];
		
	['Decor',
		[3683.55,3664.84,33.8468],325.658,[0,0,1], 
		{_thisObj setvariable ['model','ml\ml_object_new\model_14_10\propeller.p3d'];}
	] call InitDecor;
	*/
	
	#define setmdl(strvar) setSelf(model,strvar) 
	#define structmdl(p) ["IStruct",{setmdl(p)}]
	#define structmdlname(p,n) ["IStruct",{setmdl(p); setSelf(name,n)}]
	
	_probMushroom = 30;
		_mushroomCount = 6;
		_mushroomInit = ["Meatflower","Blevanton","Slimehat","Gnilokornik","Zhivoglot","Yaichnik","Svetlolik","Tumannik","Egg"];
	_probStone = 60;
		_stoneCount = 4;
		_stoneInit = [
			["IStruct",{setmdl("a3\rocks_f_exp\lavastones\lavastonecluster_small_f.p3d"); setSelf(name,"Камень")}],
			structmdlname("a3\rocks_f_exp\lavastones\lavastonecluster_large_f.p3d","Камень"),
			//"a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d"
			structmdlname("a3\rocks_f_exp\lavastones\lavaboulder_02_f.p3d","Камень"),
			//"a3\rocks_f\water\w_sharpstone_02.p3d"
			structmdlname("a3\rocks_f\water\w_sharpstone_02.p3d","Камень"),
			//"a3\rocks_f\water\w_sharpstones_erosion.p3d" 
			structmdlname("a3\rocks_f\water\w_sharpstones_erosion.p3d","Камень"),
			["IStruct",{setmdl("a3\rocks_f\water\w_sharprock_apart.p3d"); setSelf(name,"Груда камней")},vec3(0,0,rand(-3,-6))]
		];
	_probGarbage = 40;
		_garbageCount = 3;
		_garbageInit = [
			["IStruct",{setmdl(pick ["a3\structures_f_enoch\military\training\craterlong_02_f.p3d" arg "a3\structures_f_enoch\industrial\agriculture\manurepile_01_f.p3d"])}],
			//arg "apalon\metro_a3\surfaces\gryazoookass.p3d" - non usable
			["IStruct",{setmdl(pick ["ml_shabut\nvprops\gryazyuka5.p3d" arg "ml_shabut\nvprops\gryazyuka3.p3d" arg "ml_shabut\nvprops\gryazyuka4.p3d" ])}]
		];
		
	_probHouse = 27;
		_houseCount = 1;
		_houseInit = [
			["IStruct",{setmdl("ca\buildings2\houseblocks\houseblock_c\houseblock_c5_ruins.p3d")}],
			["IStruct",{setmdl("a3\structures_f_enoch\industrial\farms\barn_03_large_ruins_f.p3d")}],
			structmdl("a3\structures_f_exp\civilian\slum_01\slum_01_ruins_f.p3d"),
			structmdl("ca\buildings\ruins\stanice_ruins.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house02_ruins_f.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house03_ruins_f.p3d"),
			structmdl("a3\structures_f\households\addons\garage_v1_ruins_f.p3d"),
			structmdl("a3\structures_f_enoch\ruins\houseruin_small_01_f.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house03_f.p3d"),
			structmdl("a3\structures_f\households\slum\slum_house01_f.p3d"),
			structmdl("a3\structures_f\households\stone_small\stone_housesmall_v1_ruins_f.p3d"),
			structmdl("a3\structures_f\households\stone_shed\stone_shed_v1_ruins_f.p3d"),
			structmdl("ca\buildings\dum_zboreny_total.p3d"),
			structmdl("ca\buildings2\houseblocks\houseblock_d\houseblock_d2_ruins.p3d"),
			structmdl("a3\structures_f_enoch\military\bunkers\bunker_02_light_double_f.p3d"),
			structmdl("a3\structures_f_enoch\military\bunkers\bunker_02_light_right_f.p3d"),
			structmdl("a3\structures_f_enoch\military\bunkers\bunker_02_light_left_f.p3d")
		];
		
	_probVegetation = 80;
		_vegetationCount = 7;
		_vegetationInit = [
			structmdl("ml\ml_object_new\shabbat\nowoederewo.p3d"),
			structmdl("ml\ml_object_new\shabbat\gardentree.p3d"),
			structmdl("ml\ml_object_new\model_24\derevo.p3d"),
			structmdl("ml\ml_object_new\model_24\yolka.p3d"),
			//testing
			structmdl("veg_gliese\g2_off.p3d"),
			structmdl("veg_gliese\bb1.p3d"),
			structmdl("veg_gliese\hrock1.p3d"),
			structmdl("veg_gliese\br1.p3d"),
			structmdl("veg_gliese\t1.p3d"),
			structmdl("veg_gliese\t2.p3d"),
			structmdl("veg_gliese\t3.p3d"),
			structmdl("veg_gliese\tp1.p3d"),
			structmdl("veg_gliese\ts1.p3d"),
			structmdl("veg_gliese\tt1.p3d"),
			structmdl("veg_gliese\tw1.p3d"),
			structmdl("veg_gliese\tw2.p3d"),
			structmdl("veg_gliese\tx1.p3d"),
			structmdl("veg_gliese\tx2.p3d"),
			structmdl("veg_gliese\tx3.p3d"),
			structmdl("veg_gliese\tx7.p3d"),
			structmdl("veg_gliese\tx9.p3d"),
			structmdl("egl_gliese_misc\crystal1.p3d"),
			structmdl("egl_gliese_misc\crystal3.p3d"),
			structmdl("egl_gliese_misc\crystal4.p3d"),
			structmdl("egl_gliese_misc\crystal5.p3d"),
			structmdl("egl_gliese_misc\crystal6.p3d"),
			structmdl("egl_gliese_misc\crystal7.p3d")
		];
	
	gvar(preCreate) = {
		
	};

	gvar(handleCreate) = {
		
		if (_k == 0) then {
			if (_j > 15 || _i > 15) then {
				if (
					getGrid(_i,_j,_k) && 
					getGrid(_i+1,_j,_k) && 
					getGrid(_i,_j+1,_k) && 
					getGrid(_i-1,_j,_k) && 
					getGrid(_i,_j-1,_k) &&
					//other
					getGrid(_i+1,_j+1,_k) &&
					getGrid(_i-1,_j-1,_k) &&
					getGrid(_i+1,_j-1,_k) &&
					getGrid(_i-1,_j+1,_k)
				) then {
					gvar(randPoses) pushBack (_vPos vectorAdd [0,0,5.5]);
				} else {
					gvar(backupedPoses) pushBack (_vPos vectorAdd [0,0,0]);
				};
			};
		};
		
		_cube = ["BlockDirt",_vPos, pick[0,90,180,270],[0,0,1]] call initDecor;
		gvar(objectsList) pushBack _cube;
		
		if (_k != 0) exitWith {};
		
		#define ALG_ITEM 0
		#define ALG_STRUCT 1
		#define ALG_DEC 2
		#define GLOBADD(probVal,getInitializer,getCounter,vector_pos,vector_dir,alg_idx) \
		if prob(probVal) then { \
			_cur = getInitializer; \
			_isArray = equalTypes(_cur,[]); \
			_cls = ifcheck(_isArray,_cur select 0,_cur); \
			_inicode = ifcheck(_isArray,_cur select 1,{}); \
			_posvecadd = ifcheck(_isArray && {count _cur >= 3},_cur select 2,vec3(0,0,0)); \
			_algCODE = if (alg_idx == ALG_ITEM) then {{[_cls,_newpos,random 360,false,_newvec] call createItemInWorld}} else { \
				if (alg_idx == ALG_STRUCT)then {{[_cls,_newpos,random 360,_newvec,_inicode] call initStruct}} else { \
					{[_cls,_newpos,random 360,_newvec,_inicode] call initDecor} \
				} \
			}; \
			for "_i" from 1 to randInt(1,getCounter) do { \
				_newpos = (_vPos vectorAdd vector_pos) vectorAdd _posvecadd; \
				_newvec = vector_dir; \
				gvar(objectsList) pushBack (call _algCODE); \
			}; \
		}; 
		
		GLOBADD(
			_probGarbage,
			pick _garbageInit,
			_garbageCount,
			vec3(rand(-5,5),rand(-5,5),rand(0.25,-0.7)),
			vec3(0,0,1),
			ALG_STRUCT
		)
		GLOBADD(
			_probMushroom,
			pick _mushroomInit,
			_mushroomCount,
			vec3(rand(-5,5),rand(-5,5),rand(-0.1,-0.28)),
			vec3(rand(0,0),rand(0,0),rand(-1,1)),
			ALG_ITEM
		)
		GLOBADD(
			_probStone,
			pick _stoneInit,
			_stoneCount,
			vec3(rand(-5,5),rand(-5,5),rand(0.1,-0.6)),
			vec3(0,0,1),
			ALG_STRUCT
		)
		GLOBADD(
			_probVegetation,
			pick _vegetationInit,
			_vegetationCount,
			vec3(rand(-5,5),rand(-5,5),rand(-6,-1)),
			vec3(0,0,1),
			ALG_STRUCT
		)
		GLOBADD(
			_probHouse,
			pick _houseInit,
			_houseCount,
			vec3(rand(-5,5),rand(-5,5),rand(1.3,-4.6)),
			vec3(0,0,1),
			ALG_DEC
		)
	};
	gvar(postCreate) = {
		if (count gvar(randPoses) == 0) then {
			_pos = pick gvar(backupedPoses);
			{
				if (!callFunc(_x,isMob) && callFunc(_x,getClassName)!="BlockDirt") then {
					delete(_x);
				};
			} foreach (["GameObject",_pos,15,true,true] call getGameObjectOnPosition);
			
			_o = ["OldWoodenBox",_pos,random 360,vec3(0,0,1),{setSelf(name,"Ящичек")}] call initStruct;
			setVar(gm_currentMode,container,_o);
			gvar(objectsList) pushBack _o;
			{
				_npos = _pos vectorAdd [sin (_x) * 2.5,cos (_x) * 2.5,0];
				_o = ["Campfire",_npos,random 360,vec3(0,0,1),{setSelf(name,"Святой костёр")}] call initStruct;
				gvar(objectsList) pushBack _o;
			} foreach [0,120,240];
			
		} else {
			_pos = pick gvar(randPoses);
			_pos = _pos vectorAdd vec3(0,0,rand(-2,-3.5));
			
			//first rem all objects in this place
			{
				if (!callFunc(_x,isMob) && callFunc(_x,getClassName)!="BlockDirt") then {
					delete(_x);
				};
			} foreach (["GameObject",_pos,18,true,true] call getGameObjectOnPosition);
			
			_o = ["Decor",_pos,pick[0,90,180,270],vec3(0,0,1),{setSelf(model,"a3\structures_f_enoch\ruins\houseruin_small_02_f.p3d")}] call initDecor;
			gvar(objectsList) pushBack _o;
			
			_posesBase = [
				[-4.15137,-3.24512,1.23779],
				[-5.58301,2.52417,1.23779],
				[2.52075,0.587769,1.23779],
				[-0.276367,-4.03662,1.71859],
				[6.39355,-4.19275,1.23779],
				[2.87671,2.72986,1.2908],
				[4.79211,4.55273,-2.47259],
				[6.2323,-4.64124,-2.47259],
				[-0.159058,-4.17627,-2.47259],
				[2.61987,4.45667,-2.47259],
				[-0.239258,4.67944,-2.47259],
				[-5.5968,4.73047,-1.76803],
				[-2.78186,0.809448,-2.47259],
				[-2.41333,-4.27429,-2.44751]
			];
			
			{
				getVar(gm_currentMode,relicProbSpawnpos) pushBack (getVar(_o,loc) modelToWorld _x);
			} foreach _posesBase;
			
			_relativePos = pick _posesBase;
			
			_posCont = getVar(_o,loc) modelToWorld _relativePos;
			_o = ["OldWoodenBox",_posCont,random 360,vec3(0,0,1),{setSelf(name,"Ящичек")}] call initStruct;
			setVar(gm_currentMode,container,_o);
			gvar(objectsList) pushBack _o;
		};
		
		{
			if (!callFunc(_x,isMob) && callFunc(_x,getClassName)!="BlockDirt") then {
				delete(_x);
			};
		} foreach (["GameObject",[1999.64,1998.8,10.5404],15,true,true] call getGameObjectOnPosition);
		
		//make base
		_basePos = [2000,2000,10];
		{
			_x params ["_p","_d"];
			_o = ["IStruct",_basePos vectorAdd _p,_d,vec3(0,0,1),{setSelf(model,"ml_shabut\nvprops\nv_barik2.p3d")}] call initStruct;
			gvar(objectsList) pushBack _o;
		} foreach [
			[[6,-3,0],90],
			[[6,+4,0],270],
			[[3,6,0],180],
			[[-4,6,0],0]
		];
		
		{
			//gvar(objectsList) pushBack (createMesh( ["a3\structures_f\civ\camping\fireplace_f.p3d" arg _x arg false]))
		} foreach gvar(randPoses);
		
		gvar(backupedPoses) = [];
		gvar(randPoses) = [];
	};
	
	
	cfunc(generate);
};