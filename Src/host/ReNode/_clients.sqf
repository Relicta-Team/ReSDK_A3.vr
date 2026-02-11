// ======================================================
// Copyright (c) 2017-2026 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

nodeModule_register("clients")

nodeModule_setPath("Клиенты.Утилиты")
nodeModule_setIcon("data\\icons\\icon_BluePrintEditor_Function_16px")
nodeModule_setColorStyle("PureFunction")
nodeModule_setExecType("pure")

//Клиенты.Объекты

//здесь копия потому что юзер может изменить исходный массив
["allClients","Все клиенты","(+cm_allClients)","array[ServerClient^]:Клиенты" opt 'mul=1',"Получает массив клиентов, находящихся на сервере в данный момент."] reg_nular

["allClientsCount","Клиентов на сервере","count cm_allClients","int:Количество" opt 'mul=1',"Получает количество кдиентов, подключенных к серверу в текущий момент."] reg_nular
["allClientsInGameCount","Клиентов в игре","count (call cm_getAllClientsInGame)","int:Количество" opt 'mul=1',"Получает количество клиентов, находящихся в игре в текущий момент."] reg_nular
["allClientsInLobby","Клиентов в лобби","count (call cm_getAllClientsInLobby)","int:Количество" opt 'mul=1',"Получает количество клиентов, находящихся в лобби в текущий момент."] reg_nular

["maxClients","Макс. клиентов","cm_maxClients","int:Количество" opt "mul=1","Получает максимальное количество клиентов, замеченное на сервере за текущий раунд. Иными словами, этот узел отображает пиковый онлайн в рамках одного раунда."] reg_nular

["getGameState","Состояние игры","gm_state","enum.GameState:Состояние игры","Получает текущий статус игры: выбор режима, подготовка, игра, конец"] reg_nular

["isGameStatePreload","Статус ""Выбора режима""","call gm_isRoundPreload","bool:Предзагрузка","Проверяет, является ли текущий статус игры выбором режима."] reg_nular
["isGameStateLobby","Статус ""Подготовка""","call gm_isRoundLobby","bool:Подготовка","Проверяет, является ли текущий статус игры подготовкой, когда раунд ещё не начался и клиенты распеределяются по ролям."] reg_nular
["isGameStateGame","Статус ""Игра""","call gm_isRoundPlaying","bool:Игра","Проверяет, является ли текущий статус игры процессом раунда."] reg_nular
["isGameStateEnd","Статус ""Конец раунда""","call gm_isRoundEnding","bool:Конец","Проверяет, является ли текущий статус игры концом раунда."] reg_nular

["getAllClientsByAccessLevel","Клиенты с уровнем доступа","[@in.1,@in.2] call cm_getAllClientsByAccessLevel",
    "enum.AccessLevel:Уровень доступа",
    "bool:Включить повышенные доступы:При включении данной опции будет осуществляться поиск клиентов с правами текущего уровня и всех уровней выше. Например, при поиске всех игроков с включенной опцией будут также получены и администраторы"
        opt 'def=false:require=0',
    "array[ServerClient^]:Клиенты",
"Получает массив клиентов с указанным уровнем доступа."
] reg_binary

["findClientByName","Найти клиента по никнейму","(@in.1) call cm_findClientByName","string:Никнейм","ServerClient^:Клиент",
"Выполняет поиск клиента на сервере по указанному никнейму. Если клиент с проверяемым никнеймом не найден возвращает @[object^ null-ссылку]"] reg_unary
//uid,
//! removed because steamid is obsoleted 
// ["findClientBySteamId","Найти клиента по SteamID","(@in.1) call cm_findClientByUid","string:SteamId","ServerClient^:Клиент",
// "Выполняет поиск клиента на сервере по указанному SteamID. Если клиент с проверяемым SteamID не найден возвращает @[object^ null-ссылку]"] reg_unary

nodeModule_setColorStyle("Function")
nodeModule_setExecType("all")
//! это impure функции. не забывать про оффсет портов из-за exec-ов

["cm_sendLobbyMessage","Сообщение в лобби","[@in.2,@in.3]call cm_sendLobbyMessage",
"string:Сообщение:Сообщение, которое будет выведено в лобби",
"enum.ChatMessageChannel:Тип:Тип сообщения чата",
nil,
"Отправляет сообщение в лобби. Данный узел предназначен для оповещения клиентов, находящихся в лобби."
] reg_binary

["cm_sendOOSMessage","Сообщение в чат","[@in.2,@in.3]call cm_sendOOSMessage",
"string:Сообщение:Сообщение, которое будет выведено в чат",
"enum.ChatMessageChannel:Тип:Тип сообщения чата",
nil,
"Отправляет сообщение в чат всем клиентам, находящимся на сервере."
] reg_binary