// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

#include "..\..\host\engine.hpp"
#include "..\..\host\text.hpp"
#include <..\ClientRpc\clientRpc.hpp>
#include "..\WidgetSystem\widgets.hpp"
#include <..\SoundSystem\Music.hpp>
#include "lobby.hpp"

namespace(Lobby,lobby_)

macro_def(lobby_disable_not_used_settings)
#define DISABLE_NOT_USED_SETTINGS

decl(bool)
isLobbyOpen = false;

decl(widget[])
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

decl(widget[])
lobby_charSetWidList = [];
decl(bool)
lobby_isOpenCharSetting = false;
decl(widegt[])
lobby_openedCharSetWidList = []; //этот лист для виджетов в режиме открытого меню конкрентной настройки

decl(widget[])
lobby_backgroundWidget = [widgetNull];

//lang question: how to get value (network issue)
//decl(string)
//lobby_background = "";

if (isMultiplayer) then {
	if isNull(lobby_background) then {
		lobby_background = PATH_PICTURE("lobby\black.paa");
	};
} else {
	lobby_background = PATH_PICTURE("lobby\black.paa");
};

decl(string)
lobby_background_local = PATH_PICTURE("lobby\black.paa");

decl(string[])
lobby_listResizingName = [];

decl(object)
lobby_charData = createLocation ["cba_namespacedummy",[100,100,100],0,0];

decl(mesh)
lobby_internal_rttcamera = "camera" camCreate [0,0,0];
decl(mesh)
lobby_internal_backwallObject = objNull;
decl(map<string;any[]>)
lobby_internal_backwallSettings = createHashMapFromArray [
	["white",[
		//back
		["ca\structures_e\wall\wall_l\wall_l1_2m5_ep1.p3d",[0,-0.7,0],0]
		//light:color,bias
		,[[0.96,0.94,0.9] ]
		]
	],
	["persian",[
		["ca\structures\wall\wall_cbrk_5.p3d",[0,-0.7,0],0]
		,[[0.48,0.86,0.78] ,[0.2,0.1,0.7]]
		]
	],
	["asian",[
		["a3\structures_f\walls\stone_4m_f.p3d",[0,-1.3,0],0]
		,[[0.82,0.61,0.36] ,[0.2,0.1,1.0]]
		]
	],
	["black",[
		["a3\structures_f_exp\walls\tin\tinwall_01_m_4m_v1_f.p3d",[0,-1.5,-1.3],0]
		,[[0.37,0.72,0.93] ,[0.2,0.1,1.0]]
		]
	]
];
//хранилище объектов
decl(map<string;mesh>)
lobby_internal_backwallObjects = createHashMap;

lobby_internal_backwallObjects = createHashMapFromArray ((keys lobby_internal_backwallSettings) apply {[_x,objNull]});
if (!isNull(lobby_internal_rttlight)) then {
	deletevehicle lobby_internal_rttlight;
};
decl(mesh)
lobby_internal_rttlight = objnull;


//net variables
decl(any[])
lobby_roleList = []; //Содержит список ролей с описанием, названием и айди

//lobby_handleMainThread = -1;
decl(float)
lobby_timeLeft = 0;
decl(any[])
lobby_RoleContenders = [];
decl(bool)
lobby_isReadyToPlay = false; //готовность к игре в лобби до начала раунда
decl(bool)
lobby_isSelectedEmbarkRole = false; //выбранная роль эмбарковая (только во время прогресса раунда)

decl(map<string;string>)
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

decl(string[])
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
	"Мельтешата — это крысы, по размерам чуть меньше кошки. В основном их разводят для употребления в пищу.",
	"Играйте свою роль так, как никогда.",
	"Используйте свою голову - пока она ещё на плечах.",
	"Победа - не всегда есть хорошо.",
	"Пробуйте на себе новые роли.",
	"Постоянный бег приближает вас к смерти.",
	"На запах мертвецов приходят жруны.",
	"Человек – существо социальное.",
	"Я бы сделал всё дабы выжить. А ты?",
	"Единственный плюс смерти — в следующую смену не нужно работать.",
	"Чтобы подать жалобу напиши боту в лс '/report меня убили' ",
	"Узнать id раунда можно  через F10 - getid",
    "Нужна помощь админа по ходу игры? F11",
	"Чтобы написать другим людям в OOC чат, F10 - 'nrp всем привет!'"
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

