// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================



// TODO: change render distance for smd_allInGameMobs

esc_settings_loader_graphic = {
	if (esc_settings_curIndex == 0) exitWith {};

	#define setting_element_size_x 10

	private _ctg = getSettingsList;

	private _setList = count cd_settingsKeyboard;
	private _d = getDisplay;

	call esc_settings_clearSettingList;

	private _data = [];
};
