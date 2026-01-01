// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================
#include "..\engine.hpp"
#include "..\oop.hpp"
#include "..\struct.hpp"

struct(BinaryMapInstructions)

	def(_buffer) null;
	def(_bufferEnd) null;
	def(_errorCount) 0;
	def(_errorList) [];

	def(_generated) 0; 

	def(_allSpawnPoints) null;

	def(init)
	{
		self setv(_errorList,[]);
		self setv(_buffer,[]);
		self setv(_bufferEnd,[]);
		self setv(_allSpawnPoints,[]);
	}

	def(isSuccessBuild) {(self getv(_errorCount)) == 0}

	def(printErr)
	{
		private _mformat = format _this;
		
		error(_mformat);

		self callp(addError,_mformat);
	}

	def(addError)
	{
		params ["_message"];
		if !(_message in (self getv(_errorList))) then {
			self getv(_errorList) pushBack _message;
		};
		self setv(_errorCount,(self getv(_errorCount)) + 1);
	}

	def(prepareCode)
	{
		private _buff = array_copy(self getv(_buffer));
		private _buffEnd = self getv(_bufferEnd);
		_buff append _buffEnd;

		compile (_buff joinString "");
	}

	endstruct

// https://github.com/CBATeam/CBA_A3/issues/1352#issuecomment-665343452
dml_internal_eulerToVec = {
	params ["_rotation"];
	_rotation params ["_rotX", "_rotY", "_rotZ"];

	_vectorDirAndUp = [
		[
			(cos _rotY) * (sin _rotZ),
			(cos _rotX)*(cos _rotZ)+(sin _rotX)*(sin _rotY)*(sin _rotZ),
			-(sin _rotX)*(cos _rotZ)+(cos _rotX)*(sin _rotY)*(sin _rotZ)
		],
		[
			-sin _rotY, 
			(sin _rotX)*(cos _rotY), 
			(cos _rotX)*(cos _rotY)
		]
	];
	_vectorDirAndUp
};

dml_const_zOffset = 6.04903;

//загрузчик карты
dml_loadMap = {
	params ["_path"];
	([_path] call dml_parseMap) params ["_status","_instr"];
	if (_status) then {
		call _instr;
	};
};


//подготовка загрузочных инструкций
dml_parseMap = {
	params ["_mapPath"];
	_mapPath = [_mapPath,"\//",'\'] call regex_replace;

	traceformat("Attempt load config %1",_mapPath);

	private _cfg = LoadConfig _mapPath;
	private _cfgMap = _cfg call dml_prepMapConfig;
	private _bmap = struct_new(BinaryMapInstructions);

	[_cfgMap,_bmap] call dml_prepareMapBuffer;

	if !(_bmap callv(isSuccessBuild)) exitWith {
		setLastError("Error on loading map: " + _mapPath);
		[false,{}]
	};

	traceformat("Map parsing done; Objects %1",_bmap getv(_generated));

	[true,_bmap callv(prepareCode)];
};

dml_prepareMapBuffer = {
	params ["_cfg","_bmap"];
	private _objlist = [_cfg,"Mission\Entities"] call dml_internal_getPath;
	if isNullVar(_objlist) exitWith {
		_bmap callp(printErr,"Error on get object root tree");
	};

	[_bmap] call dml_internal_addMapHeaders;

	private _itCount = _objlist get "items";
	{
		if equalTypes(_y,hashMapNull) then {
			[_y,_bmap] call dml_internal_handleObj;
		};
	} foreach _objlist;
	
};

dml_internal_addMapHeaders = {
	params ["_bmap"];
	private _buffer = _bmap getv(_buffer);

	_buffer pushBack "go_editor_globalRefs = createHashMap;";
	_buffer pushBack endl;
	_buffer pushBack endl;
	private _ecodeInstr = "reditor_binding_fc = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		if (count _this == 0) then {
			callFuncReflect(_o,_m)
		} else {
			callFuncReflectParamsInline(_o,_m,_this)
		};
	} + "};
	reditor_binding_gv = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		getVarReflect(_o,_m)
	} + "};
	reditor_binding_sv = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		setVarReflect(_o,_m,_this)
	} + "};
	reditor_binding_gref = {" + toString {
		private _o = _this deleteAt 0;
		private _m = _this deleteAt 0;
		go_editor_globalRefs getOrDefault [_m,nullPtr];
	} + "};";
	_buffer pushBack _ecodeInstr;
	_buffer pushBack endl;
	_buffer pushBack endl;
};

dml_const_enum_instancerNames = ["InitItem","InitStruct","InitDecor"];
dml_const_tab = toString [9];

dml_internal_handleObj = {
	params ["_mapDat","_bmap"];

	private _dataType = _mapDat get "datatype";//group(mob),object
	private _id = _mapDat getOrDefault ["id","ERR_UNDEFINED"];
	
	//handle layer
	if (_dataType=="layer") exitWith {
		//empty layer skip
		if !("entities" in _mapDat) exitWith {};

		private _objlist = _mapDat get "entities";
		private _atlOffset = _mapDat get "atloffset";
		private _itCount = _objlist get "items";
		traceformat("Loading layer: %1",_mapDat get "name");
		{
			if equalTypes(_y,hashMapNull) then {
				[_y,_bmap] call dml_internal_handleObj;
			};
		} foreach _objlist;
	};

	if (_dataType!="object")exitWith {
		traceformat("Skipped loading id %1 (type %2)",_id arg _dataType);
		true
	};

	#define deserializeHashData(val) (call (call compile val))
	#define sizeof_float 5


	//deser hash: call (call compile _serializedData)
	private _posI = _mapDat get "positioninfo" get "position"; //x,z,y
	private _atlOffset = _mapDat get "atloffset";
	_posI = [_posI select 0,_posI select 2,(_posI select 1) - _atlOffset];
	private _rotI = _mapDat get "positioninfo" get "angles";
	private _hashData = _mapDat get "attributes" get "init";
	private _otype = _mapDat get "type"; //normal classname

	private _hd = deserializeHashData(_hashData);
	if ("missionName" in _hd && {_otype == "Land_Orange_01_F"}) exitWith {
		private _mapVersion = _hd get "version";
		//??todo check map version??
		
	};

	if (count _hd == 0) exitWith {
		_bmap callp(printErr,format vec2("Empty data for object with id %1",_id));
	};
	private _class = _hd get "class";
	if !isImplementClass(_class) exitWith {
		_bmap callp(printErr,format vec3("Unknown class %1 for object with id %2",_class,_id));
	};

	private _instancer = dml_const_enum_instancerNames select ([_class,"",true,"getChunkType"] call oop_getFieldBaseValue);
	assert_str(!isNullVar(_instancer),"Unknown chunk type for class " + _class);

	private _counterNotNeedLvar = 0;
	private _realocModel = "";
	private _isEffectModel = false;

	//reassign model
	private _mpath = [_class,"model",true,"getModel"] call oop_getFieldBaseValue;

	if ((_mpath select [0,1]) == "\") then {
		_mpath = _mpath select [1,count _mpath];
	};
	
	private _mPathFromCfg = core_cfg2model getvariable _otype;
	if isNullVar(_mPathFromCfg) exitWith {
		_bmap callp(printErr,format vec3("Cant find model for config %2 with id %1",_id,_otype));	
	};
	
	private _model = ifcheck(".p3d" in _mpath,_mPathFromCfg,_otype);
	if ((_model select [0,1]) == "\") then {
		_model = _model select [1,count _model];
	};
	_isEffectModel = "land_vr_block_" in (tolower _otype);
	if (_mpath != _model && !_isEffectModel) then {
		INC(_counterNotNeedLvar);
		_realocModel = _model;
	};

	private _pos = _posI;//todo check convert to atl, for example -> z-side:: 10.4 => 4.3
	//TODO convert euler angles to vdir/vup
	
	([_rotI] call dml_internal_eulerToVec) params ["_pVD","_pVU"];
	private _vdir = 0;
	private _vup = [0,0,1];

	private _randSpawn = false;
	private _randSpawnString = "";
	private _randPos = false;
	private _randPosString = "";
	private _objcustomdata = [];
	private _initCodeArgs = [];
		private _addPreInitHandler = false;

	if (_realocModel != "") then {
		_initCodeArgs pushBack (format["%1 setvariable ['%2','%3'];",'_thisObj','model',_realocModel]);
	};

	private _customProps = _hd getOrDefault ["customProps",[]];

	//get native preinit vars
	private _sysvars = [];
	private _tObj = typeGetFromString(_class);
	private _arrAdd = null;
	{
		_arrAdd = typeGetVar(typeGetFromString(_x),__handleNativePreInitVars__);
			
		if !isNullVar(_arrAdd) then {
			if equalTypes(_arrAdd,{}) then {
				_sysvars append (call _arrAdd);
			};
		};
		if (_x == "gameobject") then {break};
	} foreach typeGetVar(_tObj,__inhlist);
	_sysvars = _sysvars apply {tolower _x};
	_sysvars = _sysvars arrayintersect _sysvars;
	
	{
		[_x,_y] params ["_name","_val"];

		if (_name == "spawnPointName" && {_class == "SpawnPoint"}) then {
			private _ind = (_bmap getv(_allSpawnPoints)) findif {_x == _val};

			if (_ind != -1) exitWith {
				_bmap callp(printErr,format vec2("SpawnPoint %1 double define",_val));
			};
			if (":" in _val) exitWith {
				_bmap callp(printErr,format vec2("SpawnPoint %1 has wrong name; Unexpected ':'",_val));
			};
			if !("spawnpointname" in _customProps) then {
				_bmap callp(printErr,format vec2("SpawnPoint %1 without 'spawnpointname' property",_val));
			};
			
			(_bmap getv(_allSpawnPoints)) pushBack _val;
			continue;
		};
		if (_name == "spawnPointName" && {_class == "CollectionSpawnPoint"}) then {
			if (":" in _val) exitWith {
				_bmap callp(printErr,format vec2("CollectionSpawnPoint %1 has wrong name; Unexpected ':'",_val));
			};
			if !("spawnpointname" in _customProps) then {
				_bmap callp(printErr,format vec2("CollectionSpawnPoint %1 without 'spawnpointname' property",_val));
			};
			continue;
		};

		//serialize string
		if equalTypes(_val,"") then {_val = str _val};

		if (_name == "model") then {continue};
		if (_name == "light") then {
			//! light can parse only from editor
			private _realVal = _val select [1,count _val - 2];
			private _cfgName = "#ERR#";
			if (is3DEN) then {
				_cfgName = [_realVal,"#ERR#"] call vcom_emit_io_parseScriptedConfigName;
			};
			if (_cfgName != "#ERR#") then {
				if (is3DEN) then {
					if !(call vcom_emit_io_isEnumConfigsLoaded) then {
						[true] call vcom_emit_io_loadEnumAssoc;
					};
					private _idxlight = (keys vcom_emit_io_enumAssocKeyStr) findif {_cfgName==_x};
					if (_idxlight == -1) exitWith {
						_bmap callp(printErr,format vec2("Cant find light %1",_realVal));
						continue;
					};

					_val = format["%1 call lightSys_getConfigIdByName",_val];
				} else {
					_bmap callp(printErr,format vec2("Light validation is not supported in non-editor %1",_realVal));
				};
			} else {
				_bmap callp(printErr,format vec2("Cant resolve light name %1",_realVal));
			};
		};
		if ("@preinit" in _name) then {
			_addPreInitHandler = true;
			_initCodeArgs pushBack (format["%1 setvariable ['%2',%3];",'_thisObj',_name,_val]);
			continue;
		};
		if (tolower _name in _sysvars) then {
			_addPreInitHandler = true;
			_initCodeArgs pushBack (format["%1 setvariable ['%2',%3];",'_thisObj',_name,_val]);
			continue;
		};
		if (_name == "lightIsEnabled" || _name == "light") then {
			_initCodeArgs pushBack (format["%1 setvariable ['%2',%3];",'_thisObj',_name,_val]);
			continue;
		};
		if (_x == "__effinit") then {
			INC(_counterNotNeedLvar);
			_objcustomdata pushBack (format["[%1,%2] call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable 'setEffectType');","%1",_val]);
			continue;
		};

		_objcustomdata pushBack (format["%1 setvariable ['%2',%3];","%1",_name,_val]);

	} foreach _customProps;

	private _code_init = _hd get "code_onInit";
	private _tryErrorOnInit = false;
	private _customCodeOnInit = "";
	if !isNullVar(_code_init) exitWith {
		if (is3DEN) then {
			private _retStrCode = [_code_init,false] call golib_code_prepareInstructions;
			if (_retStrCode == "!ERROR!") exitWith {
				_bmap callp(printErr,format vec2("ECode compile error at id %1",_id));
			};

			INC(_counterNotNeedLvar);

			_objcustomdata pushBackUnique "";
			_customCodeOnInit = _retStrCode;
		} else {
			_bmap callp(printErr,format vec2("ECode instructions not supported; Error class %1",_class));
		};
	};

	//* electronic device connection
	private _edConnected = _hd get "edConnected";
	if !isNullVar(_edConnected) then {
		{
			INC(_counterNotNeedLvar);
			_objcustomdata pushBack (format["[%1,go_editor_globalRefs get ""%2""] call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable 'addConnection');","%1",_x]);
		} foreach _edConnected;
	};

	//* Container content
	private _containerContent = _hd get "containerContent";
	if !isNullVar(_containerContent) then {
		{
			INC(_counterNotNeedLvar);
			_x params ["_hashItem","_count"];
			_hashItem = deserializeHashData(_hashItem);
			private _stringStruct = format["'%1',%2,%3",_hashItem get "class",_count,_hashItem getOrDefault ["prob",100]];
			private _arrAtrs = [];
			{
				[_x,_y] params ["_key","_val"];
				_arrAtrs pushback ["var",_key,_val];
			} foreach (_hashItem get "customProps");

			if (count _arrAtrs > 0) then {
				_stringStruct = _stringStruct + "," + str _arrAtrs;
			};

			_objcustomdata pushBack (format["[%1,%2] call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable 'createItemInContainer');","%1",_stringStruct]);
		} foreach _containerContent;
	};

	if (_tryErrorOnInit) exitWith {};

	private _atlPos = _pos;
	private _poses = ((_atlPos select 0) toFixed sizeof_float) + ((_atlPos select 1) toFixed sizeof_float) + ((_atlPos select 2) toFixed sizeof_float);
	private _varname = "_" + (_poses splitString "-." joinString "_");

	// * Global reference
	private _registeredMark = "";

	if ("rdir" in _hd) then {
		_vdir = "random 360";
	};
	if ("prob" in _hd) then {
		private _val = (_hd get "prob") / 100; //проценты в нормализованные знач.
		_randSpawn = true;
		_randSpawnString = format["if ((random 1) < %1) then {" + endl + dml_const_tab + "%2};" + endl,_val,"%1"];
	};
	if ("rpos" in _hd) then {
		private _val = (_hd get "rpos");
		_randPos = true;
		_randPosString = format["%1 call{__v = _this select [0,3];__r = random 360;__v = __v vectorAdd [sin __r * %2,cos __r * %2,0];if (count _this > 3) then {__v = __v + [true]};__v}","%1",_val];
	};
	if ("mark" in _hd) then {
		_registeredMark = _hd get "mark";
		_initCodeArgs pushBack format["go_editor_globalRefs set [""%1"",%2];",_registeredMark,"_thisObj"] + endl;
	};

	if not_equals(_vup,vec3(0,0,1)) then {
		//! TODO getPosWorld impl
		_pos = _pos + [true]; // convert poscoords
		private __probNewDir = [0,0,1];//!vectorDir _obj
		private _zPosVDir = parseNumber((__probNewDir select 2) toFixed 1);
		private _editedVdir = false;
		if equalTypes(_vdir,"") then {_editedVdir = true}; //if rdir enabled then do not override vdir

		if (_zPosVDir <= -0.85 || _zPosVDir >= 0.85 && !_editedVdir) then {
			_vdir = __probNewDir;
			_editedVdir = true;
		};

		//!---------- rule2 transform serialization check 
		// if (mm_use_alg2_vdir_check) then {
		// 	private _transformVec = _obj call core_getPitchBankYaw;//do not use relative transform: _obj call golib_om_getRotation;
		// 	//if (!_editedVdir && {(_transformVec select [0,2] apply {(abs _x) toFixed 0}) isNOTEQUALTO ["0","0"]}) then {
		// 	if (!_editedVdir && {{_x=="0"}count(_transformVec apply {(abs _x) toFixed 0})<2 }) then {
		// 		//post comparator rule: 2 fixed elements equals
		// 		private _tempRes = 0;
		// 		private _cmparr = _transformVec apply {_tempRes=parseNumber(abs _x toFixed 0);ifcheck(_tempRes<=2,"0",_tempRes toFixed 0)};
		// 		private _condit = false;
		// 		{
		// 			private _thisX = _x;
		// 			if ({_x == _thisX}count _cmparr >= 2) exitwith {_condit = true};
		// 		} foreach _cmparr;
		// 		if (_condit) exitwith {}; //exit from vdir check scope

		// 		_vdir = __probNewDir;//(str __probNewDir) +"/* "+str _cmparr+" */" ;
		// 		_editedVdir = true;
		// 		eden_debug_vuplist pushBack _obj;
		// 	};
		// };
	};

	private _addictPost = "";
	if (_realocModel != "") then {
		_addictPost = " ;'REALOC MODEL';";
	};
	if (_isEffectModel) then {
		_addictPost = " ;'EFFECT';";
	};

	if (_addPreInitHandler) then {
		_initCodeArgs pushBack (
			format["%1 call (%1 getvariable '"+PROTOTYPE_VAR_NAME+"' getvariable '__handlePreInitVars__');","_thisObj"]
		)
	};

	//pre init code initializer
	_initCode = if (count _initCodeArgs > 0) then {", {" + (_initCodeArgs joinString " ")+"}"} else {""};

	//* BINARIZE
	if (_counterNotNeedLvar > 0) then {
		//do need create lvar
		if (_randPos) then {
			_pos = format[_randPosString,_pos];
		};	
		
		private _inst = format["['%1',%2,%3,%4%7] call %5; %6" + endl,_class,_pos,_vdir,_vup,_instancer,_addictPost,_initCode];

		if (_randSpawn) then {
			_inst = format[_randSpawnString,_inst];
		};

		(_bmap getv(_buffer)) pushBack format["%1 = %2",_varname,_inst];

		if (count _objcustomdata > 0) then {
			private _buffEnd = _bmap getv(_bufferEnd);
			_buffEnd pushBack format["if (!isNil'%1') then {" + endl,_varname];

			{
				_buffEnd pushBack (dml_const_tab + format[_x,_varName] + endl);
			} foreach _objcustomdata;

			

			if (_customCodeOnInit != "") then {
				_buffEnd pushBack ("_o="+_varName+";"+endl);
				_buffEnd pushBack (_customCodeOnInit + endl);
			};
			
			_buffEnd pushBack ("};" + endl);
		};

	} else {

		if (_randPos) then {
			_pos = format[_randPosString,_pos];
		};

		private _inst = format["['%1',%2,%3,%4%7] call %5; %6" + endl,_class,_pos,_vdir,_vup,_instancer,_addictPost,_initCode];

		if (_randSpawn) then {
			_inst = format[_randSpawnString,_inst];
		};

		//not need create lvar
		(_bmap getv(_buffer)) pushBack _inst;
	};

	_bmap setv(_generated,(_bmap getv(_generated)) + 1);
};

dml_internal_getPath = {
	params ["_cfg","_pathList"];
	if equalTypes(_pathList,"") then {
		_pathList = _pathList splitString " \/.:>";
	};
	private _curcfg = _cfg;
	private _key = null;
	{
		_key = toLowerANSI _x;
		if !(_key in _curcfg) exitWith {_curcfg = null};
		_curcfg = _curcfg get _key;
	} foreach _pathList;
	_curcfg
};

dml_prepMapConfig = {
	params ["_cfgClass"];

	private _result = createHashMap;
	private _props = configProperties [_cfgClass, "true", true];
	// note: Hashmaps are case-sensitive so configName cases have to be consistent (e.g. all lowercase)
	{
		if (isNumber _x)	then { _result set [toLowerANSI configName _x, getNumber _x];	continue; };
		if (isText _x)		then { _result set [toLowerANSI configName _x, getText _x];		continue; };
		if (isArray _x)		then { _result set [toLowerANSI configName _x, getArray _x];	continue; };
	} forEach _props;

	private _classes = "true" configClasses _cfgClass;
	{
		_result set [toLowerANSI configName _x, _x call dml_prepMapConfig];
	} forEach _classes;

	_result;
};