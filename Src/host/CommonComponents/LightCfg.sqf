// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include <..\engine.hpp>

lightSys_null_t = null;

//light config parser
lightSys_prepConfig = {
	params ["_content","_id","_refName",["_isServerPrep",false]];
	private _patHeader = "regScriptEmit\((\w+)\)";
	private _patFooter = "[\t ]*endScriptEmit[\t ]*$";
	private _patEmitAlias = "[\t ]*_emitAlias\(([^\)]*)\)";

	if !([_content,_patHeader] call regex_isMatch) exitWith {""};
	private _name = [_content,_patHeader,1] call regex_getFirstMatch;
	_content = [_content,_patHeader,format[ifcheck(_isServerPrep,lightSys_replacer_server_header,lightSys_replacer_client_header),_id]] call regex_replace;
	
	if !([_content,_patFooter] call regex_isMatch) exitWith {""};
	_content = [_content,_patFooter,lightSys_replacer_footer] call regex_replace;
	
	if !([_content,_patEmitAlias] call regex_isMatch) exitWith {""};
	_content = [_content,_patEmitAlias,"[""alias"",$1],"] call regex_replace;

	//serverside null_t replace
	_content = [_content,"[\t ]*null\,","(_server_scrEmit_EvtNull_t select 0),"] call regex_replace;

	refset(_refName,_name);

	_content
};

lightSys_registerConfig = {
	params ["_content",["_isServer",false]];
	private _rName = refcreate("");
	private _prepCfg = [_content,lightSys_cfgId_cur,_rName,_isServer] call lightSys_prepConfig;
	if (_prepCfg == "") exitWith {false};

	//register assoc
	private _nameval = refget(_rName);
	private _idval = lightSys_cfgId_cur;

	lightSys_assocCfg_keyId set [_idval,_nameval];
	lightSys_assocCfg_keyName set [_nameval,_idval];

	lightSys_cfgId_cur = lightSys_cfgId_cur + 1;

	//build config
	call compile _prepCfg;

	true
};

//%1 type(int)
lightSys_replacer_client_header = "
	_semDat = []; le_se_map set ['%1',_semDat]; le_conf_%1 = {
	params ['_source'];
	_source setvariable [""__config"",%1];
	private _allEmitters = [];
	_source setVariable [""__allEmitters"",_allEmitters];
	[(le_se_map get '%1')] call le_se_handleConfig;
};	_semDat append [
";

//здесь приходится обходить пробему undefined variable. в генераторе мы выбираем null значение
lightSys_replacer_server_header = "
	_server_scrEmit_EvtNull_t = [nil];
	_semDat = []; slt_map_scriptCfgs set ['%1',_semDat]; slt_cfg_id_%1 = {
		params ['_source'];
		(slt_map_scriptCfgs get '%1') call slt_handleScriptedCfg;
	}; _semDat append [
";

//common footer for scripted config
lightSys_replacer_footer = "] ;"; 

//assoc maps
lightSys_assocCfg_keyId = createHashMap;
lightSys_assocCfg_keyName = createHashMap;

//base config id
lightSys_cfgId_cur = 2100;

lightSys_preInitialize = {
	lightSys_cfgId_cur = 2100;
	lightSys_assocCfg_keyId = createHashMap;
	lightSys_assocCfg_keyName = createHashMap;
};

//get cfg name by id
lightSys_getConfigNameById = {
	params ["_id"];
	lightSys_assocCfg_keyId getOrDefault [_id,""]
};

//get cfg id by name
lightSys_getConfigIdByName = {
	params ["_name"];
	#ifdef EDITOR
	if !(_name in lightSys_assocCfg_keyName) exitWith {
		errorformat("Unknown config name: %1",_name);
		setLastError("Unknown config name: " + _name + "; Loaded configs: " + (str count lightSys_assocCfg_keyName));
		-1
	};
	#endif
	lightSys_assocCfg_keyName getorDefault [_name,-1]
};