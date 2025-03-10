// ======================================================
// Copyright (c) 2017-2025 the ReSDK_A3 project
// sdk.relicta.ru
// ======================================================

node_system_group("structs")

["SpawnPoint",[
    "enum.SpawnPointType:Тип спавна:Спавнпоинт:Тип точки спавна",
    "string:Имя спавна::Имя точки спавна"
],"
name:Точка спавна
desc:Данная структура предназначена для появления персонажей на указанных точках"] node_struct


["SpawnLocationConnection",[
    "enum.SpawnLocationConnectionType:Тип привязки:Не определено:Тип поиска объекта для привязки персонажа. Если указан тип привязки ""Не определено"" - привязка не будет выполнена.",
    "string:Глобальная ссылка::Уникальное имя объекта на карте для привязки (если выбран тип привязки ""Глобальная ссылка"").",
    "classname:Тип объекта:GameObject:Тип объекта для привязки (если выбран тип привязки ""Тип объекта""). При выборе привязки по типу на точке спана в небольшом радиусе будет выполнен поиск объекта с указанным типом.",
    "int:Номер сиденья:-1:Индекс (номер) места для посадки. Предназначено для двухместных и более сидений (например двухспальных кроватей). Значение, равное -1 игнорирует это свойство при привязке."
],"
name:Точка привязки
desc:Данная структура предназначена для привязки персонажей к объектам (стульям или кроватям). Работает совместно со структурой точки спавна. "+
"Когда указан тип привязки ""Глобальная ссылка"" будет осуществлён поиск объекта по по глобальной ссылке, а когда указан ""Тип объекта"" поиск выполнится по указанному типу. При привязке по типу в указанной точке спавна будет выполнен поиск объекта по указанному типу. Если объект по ссылке или по типу не найден - привязки не произойдёт и персонаж появится сразу на точке спавна.
"] node_struct

["BaseSkillsDef",
    [
        "vector2:Сила:[10,10]:Физический показатель персонажа. Все силовые действия зависят от этого базового навыка.",
        "vector2:Интеллект:[10,10]:Интеллектуальные способности персонажа. Все действия умственного труда зависят от этого базового навыка.",
        "vector2:Ловкость:[10,10]:Общая ловкость и проворность персонажа. Этот навык влияет на скорость и проворность персонажа.",
        "vector2:Здоровье:[10,10]:Жизненная сила и общее состояние персонажа."
    ],
"
name:Определение базовых атрибутов
namelib:Структура определения базовых атрибутов
desc:Структура четырех базовых атрибутов персонажа. Среднее значение каждого атрибута для обычного человека в ""современном мире"" равно 10. "+
"Каждый навык указывается в диапазоне от меньшего к большему. Например, сила от 7 до 10 означает, что персонаж может получить навык силы от 7 до 10 (выбирается случайное число).
"] node_struct



["SkillDef",
    [
        "enum.SkillType:Тип навыка:Усталость:Тип навыка для выдачи персонажу.",
        "vector2:Диапазон навыка:[0,1]:Диапазон значений навыка для выдачи персонажу."
    ],"
    name:Навык
    namelib:Определение вторичного навыка
    desc:Определение вторичного навыка. Такими например могут быть скрытность, хирургия, владение холодным оружием и т.д.
    "
] node_struct

//gamemode specific internal structs

["ConditionToStartGamemode",
[
    "bool:Запуск:false:Указывает можно ли запустить раунд",
    "string:Причина задержки:Без описания:Указываемая причина невозможности старта раунда при флаге запуска, равном ИСТИНЕ"
],
"name:Условие запуска
desc:Данная структура предназначена для проверки возможности начала раунда. Если запуск равен ИСТИНЕ, то таймер в лобби сбросится и выведется сообщение из причины задержки. В ином случае раунд будет запущен.
"] node_struct

["GamemodeFinishResult",
[
    "int:Результат:0:Результат конца раунда. Число, равное 0 означает, что раунд не завершен.",
    "string:Описание:Без описания:Текстовое описание результата конца раунда."
],
"name:Завершение раунда
desc:Данная структура предназначена для получения результата конца раунда.
"] node_struct

["NumeralString",
[
    "string:Им.падеж:Штука:Именительный падеж слова. Например 'день'",
    "string:Род.падеж:Штуки:Родительный падеж слова. Например 'дня'",
    "string:Предметов:Штук:Множественное число слова. Например 'дней'"
],
"name:Слова числительного
desc:Группа слов для определения количественного числительного. Представляет слова в падеже, зависимом от заданного числа и отвечающим на вопрос 'сколько'?
"] node_struct


["RollResult",
    [
        "int:Величина успеха:0:Величина успеха. Значения больше 0 означают, что бросок успешен.",
        "enum.DiceResult:Результат броска:1:Результат броска. Например, успех, провал, критический успех или критический провал.",
        "int:Выпавшее число:3:Сколько выпало на кубиках в момент броска."
    ],
"
    name:Бросок костей
    desc:Структура для хранения результата броска костей, включающая в себя величину успеха, тип броска и сколько выпало на кубиках в момент броска.
"
] node_struct

["Dices",
    [
        "int:Кубиков:1:Количество шестигранных кубиков",
        "int:Модификатор:0:Модификатор для брошенных кубиков. Добавляется к результату броска."
    ],
"
    name:Кубики
    desc:Структура для бросков костей (количество кубиков + модификатор).
"
] node_struct

["VisibilityResult",
    [
        "bool:Видимость:false:Видно ли цель",
        "enum.VisibilityMode:Уровень видимости:0:Насколько хорошо видно цель"
    ],
"
    name:Результат видимости
    desc:Структура результата видимости
"] node_struct