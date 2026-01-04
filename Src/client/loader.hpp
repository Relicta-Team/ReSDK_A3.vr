// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

_hrc_unicalNumber = "";
#ifdef ENABLE_HOT_RELOAD
	_hrc_unicalNumber = 'client_hrc_ver = ''__RAND_UINT64__'';';
#endif

//just save client version
_sha = LoadFile "src\REVISION";
if (_sha != "Unrevisioned") then {
	_sha = _sha select [0,7];
};
_prepversion = ((LoadFile "src\VERSION") splitString endl) select 0;
_ctx = compile format["client_version = '%1+%3'; client_compiledDate = '%2'; client_isLocked = false;",_prepversion,__DATE_STR__,_sha];
if !isNullVar(_canCallClientCode) then {call _ctx};
allClientContents pushback _ctx;
allClientModulePathes pushBack "runtime_version";

// !!!В определении модулей не поддерживается комментирование при внешней сборке клиента!!!

importClient("src\client\ClientRpc\clientrpc_init.sqf"); cmplog("CRPC")
importClient("src\client\ColorThemes\ColorThemes_init.sqf"); cmplog("Colors")//цветовые темы
importClient("src\client\WidgetSystem\widget_init.sqf"); cmplog("Widgets")
importClient("src\client\Rendering\Rendering_init.sqf"); cmplog("Render")
importClient("src\client\Lobby\lobbi_init.sqf"); cmplog("Lobby")
importClient("src\client\Chat\chat_init.sqf"); cmplog("Chat")
importClient("src\client\SoundSystem\Sound3d.sqf"); cmplog("Sound")
importClient("src\client\Inventory\inventory_init.sqf"); cmplog("Inventory")
importClient("src\client\InputSystem\input_init.sqf"); cmplog("Input")
importClient("src\client\Interactions\interact.sqf"); cmplog("Interact")
importClient("src\client\CraftMenu\craftmeun_init.sqf"); cmplog("Craft")
importClient("src\client\ClientStatistic\ClientStatistics_init.sqf"); cmplog("CStat") //только перед настройками
importClient("src\client\ClientData\ClientData.sqf"); cmplog("CDat")//В этом модуле НАСТРОЙКИ. Всё что используется в них должно быть ДО этого файла
importClient("src\client\Rendering\Camera\CameraControl.sqf"); cmplog("Camera")//только после clientData (потому что использует cd_cameraSetting)
importClient("src\client\StaminaControl\Stamina_init.sqf"); cmplog("Stamina")//только после ClientData (потому что использует cd_stamina...)
importClient("src\client\LightEngine\LightEngine.sqf"); cmplog("LightEngine")
importClient("src\client\VisualState\VisualState_init.sqf"); cmplog("VST") //visual states
importClient("src\client\BlastFx\BlastFX_init.sqf"); cmplog("BlastFX") //fast blast fx component
importClient("src\client\ProxyItems\ProxyItems.sqf"); cmplog("ProxIt")//proxypos of items
importClient("src\client\ProxyItems\RProx.sqf"); cmplog("RProxExtension")//proxy system v2. !load only after proxit
importClient("src\client\SyncMobData\SMD_init.sqf"); cmplog("SMD")//synced mobs
importClient("src\client\NetDisplays\NetDisplays.sqf"); cmplog("NetDisplays")
importClient("src\client\Hud\Hud_init.sqf"); cmplog("HUD")//ingame hud
importClient("src\client\GeometryFixer\GeometryFixer_init.sqf");cmplog("GeoFix") //fix lag geometry
importClient("src\client\LocalEffects\LocalEffects_init.sqf");cmplog("LocalEffects") //local effects system
importClient("src\client\PersonClient\PersonClient_init.sqf"); cmplog("Person") //local persons subsystem

importClient("src\client\NOEngineClient\NOEngineClientInit.sqf");cmplog("NOEngine")
importClient("src\client\VoiceSystem\VoiceSystem_init.sqf"); cmplog("Voice")//tfar interface
importClient("src\client\DiscordRPC\DiscordRPC_init.sqf");cmplog("Discord")
importClient("src\client\Traps\TrapsInit.sqf"); cmplog("traps") //система ловушек
importClient("src\client\OneSync\OneSync_init.sqf"); cmplog("OSync")//оптимизированная синхронизация
importClient("src\client\StrafeLock\StrafeLock_init.sqf"); cmplog("Strafe") //протект стрейфа

importClient("src\client\ClientInit\ClientInit.sqf"); cmplog("EntryPoint")//только в самом конце инитим клиента