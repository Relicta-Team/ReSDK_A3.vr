// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

//загружает поведение из yaml файла
ai_goap_loadYaml = {
	params ["_yamlName","_refData"];
	
	private _path = "src\host\AI\GOAP\AIConfigs\" + _yamlName;
	private _yaml = [_yamlName] call yaml_loadFile;
	if !isNullVar(_yaml) then {
		refset(_refData,_yaml);
	};

	!isNullVar(_yaml)
};