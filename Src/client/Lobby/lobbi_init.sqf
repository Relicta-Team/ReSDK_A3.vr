// ======================================================
// Copyright (c) 2017-2023 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\text.hpp"
#include <..\ClientRpc\clientRpc.hpp>
#include "..\WidgetSystem\widgets.hpp"
#include <..\SoundSystem\Music.hpp>
#include "lobby.hpp"

#define DISABLE_NOT_USED_SETTINGS

isLobbyOpen = false;
lobby_widgetList = [
	widgetNull, // background main
	widgetNull, //text field
	widgetNull, //wg text field
	wigdetNull, //setting ctg
	widgetNull, //button send
	widgetNull, //input chat
	widgetNull, //ready/connect button
	widgetNull //main settings ctg
];

lobby_charSetWidList = [];
lobby_isOpenCharSetting = false;
lobby_openedCharSetWidList = []; //этот лист для виджетов в режиме открытого меню конкрентной настройки

lobby_backgroundWidget = [widgetNull];
if (isMultiplayer) then {
	if isNull(lobby_background) then {
		lobby_background = PATH_PICTURE("lobby\black.paa");
	};
} else {
	lobby_background = PATH_PICTURE("lobby\black.paa");
};
lobby_background_local = PATH_PICTURE("lobby\black.paa");

lobby_listResizingName = [];

lobby_charData = createLocation ["cba_namespacedummy",[100,100,100],0,0];

//net variables
lobby_roleList = []; //Содержит список ролей с описанием, названием и айди

//lobby_handleMainThread = -1;
lobby_timeLeft = 0;
lobby_RoleContenders = [];
lobby_isReadyToPlay = false; //готовность к игре в лобби до начала раунда
lobby_isSelectedEmbarkRole = false; //выбранная роль эмбарковая (только во время прогресса раунда)

lobby_faithDesc_map = createHashMap; //клиентские описания вероисповеданий
lobby_faithDesc_map set ["akkuzat",
	"Аккузат - вера, широко распространённая за пределами Норы. 
	Её последователи верят, что слепое бесстрашие и вера есть величайшие 
	благодетели, в то время как страхи и сомнения — самые тяжкие грехи. 
	Ненавидимы Фугу."];

lobby_faithDesc_map set ["fugu",
	"Фугу — официальная религия Норы Номер Пять. 
	Её приспешники убеждены, что лишь страх и трепет есть величайшая 
	добродетель, поскольку именно он толкает человеческое существо на 
	величайшие деяния, а слепая вера и бесстрашие — губительные пороки. 
	Ненавидимы Аккузат."];
	
lobby_faithDesc_map set ["kult",
	"Оккультисты — приверженцы многочисленных туннельных и пещерных культов, 
	коим несть числа. Отношение к ним разнится, но как Фугу, так и Аккузат 
	считают их еретиками и в лучшем случае относятся презрительно."];

lobby_loading_allHints = [
	"Самый большой город Сети - Канава.",
	"Не будь мудаком.",
	"Выполняйте поручения руководящих ролей, они раздают их не просто так.",
	"Никто из ныне живых никогда не видел солнца и не выходил на поверхность.",
	"Не забывайте следить за нуждами персонажа, чтобы его тело не подвело вас в самый неподходящий момент.",
	"Не стесняйтесь пробовать новые образы и роли. Разнообразие — вкуснейшая специя к блюду жизни!",
	"В словах и поступках персонажа всегда исходите из его мотивации.",
	"Руководящие роли не только командуют, но и задают тон игры, создают ролевые ситуации. Имейте это в виду!",
	"Человек с оружием — серьезная угроза, если вы безоружны. Не стоит зря рисковать своей жизнью.",
	"Разделяйте игру и реальность, персонажей и игроков.",
	"Убить другого персонажа — слишком простой и малоинтересный выбор. Не гнушайтесь дать второй шанс.",
	"Мельтешата — это крысы, по размерам чуть меньше кошки. В основном их разводят для употребления в пищу."
];

#include "sprite_renderer.sqf"
#include "CharSettings.sqf"
#include "functions.sqf"
#include "Events.sqf"
#include "SystemSettings.sqf"


//#define test_lobby

#ifdef test_lobby

	call lobbyOpen;
	
	
	invokeAfterDelay({call lobbyClose},5);

#endif

