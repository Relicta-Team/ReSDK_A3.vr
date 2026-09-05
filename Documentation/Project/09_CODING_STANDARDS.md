# Расширенные стандарты кодирования

Этот документ расширяет базовый [CODE-STANDARDS.md](../../CODE-STANDARDS.md) с дополнительными паттернами, анти-паттернами и особенностями работы с проектом.

## Базовые стандарты

См. [CODE-STANDARDS.md](../../CODE-STANDARDS.md) для базовых стандартов:
- Отступы и форматирование
- Именование
- Комментарии
- Объявления переменных и функций

### Использование макросов для сравнений

В проекте используются макросы вместо встроенных операторов Платформы для сравнений:
- Используйте `equals(a, b)` вместо `a isEqualTo b`
- Используйте `not_equals(a, b)` вместо `!a isEqualTo b`
- Используйте `equalTypes(a, b)` вместо `a isEqualType b`
- Используйте `not_equalTypes(a, b)` вместо `!a isEqualType b`

**Причины:**
- Макросы обеспечивают единообразие кода
- Макросы могут иметь дополнительные проверки и оптимизации
- Встроенные операторы Платформы (`isEqualTo`, `isEqualType`) в явном виде не используются в продакшене

### Использование заголовочных файлов (.h и .hpp)

В проекте используется различие между типами заголовочных файлов:

- **`.h`** - внутренние заголовочные файлы модуля, содержат определения, используемые только внутри этого модуля. Не предназначены для включения в других модулях
- **`.hpp`** - публичные заголовочные файлы, экспортирующие интерфейс модуля (макросы, константы, утилиты) для использования в других модулях

**Примеры:**

```sqf
// В модуле Networking/Network.hpp (публичный)
#define netSendVar(var,val,own) [var,val,own] call net_send

// В модуле Networking/Network.sqf (приватный)
#include "Network.hpp"  // Использует публичный хедер своего модуля

// В другом модуле
#include <..\Networking\Network.hpp>  // Использует публичный хедер из другого модуля
```

**Важно:**
- Не инклудьте `.h` файлы из других модулей
- Используйте `.hpp` для макросов, констант и утилит, которые должны быть доступны другим модулям
- Используйте `.h` для внутренних определений модуля

## Паттерны проектирования

### Модульная архитектура

Каждый модуль должен быть независимым или иметь очень слабую зависимость от других модулей:

```sqf
// Хорошо - модуль независим
myModule_process = {
    params ["_data"];
    // логика модуля
};

// Плохо - прямая зависимость от другого модуля
otherModule_process = {
    // использует внутренности другого модуля напрямую
};
```

Допускаются исключения в случае если есть обработка отсутствия зависимостей:

```sqf
myModule_process = {
    if !isNull(otherModule_function) then {
        call otherModule_function;
    } else {
        error("MyModule: otherModule_function is not available");
    };
};
```

### Использование ООП парадигмы

Используйте классы или структуры для сложных сущностей на сервере (для клиента вы можете использовать только struct-типы (см. [Структура модуля](03_SYNTAX_GUIDE.md#ограничения-клиентского-кода))):

```sqf
// Хорошо - используем классы
class(MyEntity) extends(BaseClass)
    var(data, []);
    
    func(process)
    {
        objParams();
        // логика обработки
    };
endclass

// Хорошо - используем структуры
struct(MyEntity)
    def(data) null
    def(init) {
        self setv(data,[]);
    }
    def(process) {
        // логика обработки
    }
endstruct

// Плохо - глобальные функции и переменные
myEntity_data = [];
myEntity_process = {
    // логика
};
```

### Инкапсуляция через методы

Используйте методы для доступа к данным:

```sqf
class(MyClass) extends(BaseClass)
    var(privateData, 0);
    
    // Публичный метод для доступа
    getter_func(getPrivateData, getSelf(privateData));
    
    func(setPrivateData)
    {
        objParams_1(_value);
        // Валидация
        if (_value >= 0) then {
            setSelf(privateData,_value);
        };
    };
endclass
```

## Рекомендации по именованию

Соблюдение единых правил именования улучшает читаемость кода и облегчает работу в команде.

### Именование типов (классов)

Используйте **PascalCase** для имен классов:

```sqf
// Хорошо
class(GameObject) extends(ManagedObject)
class(Item) extends(IDestructible)
class(ServerClient)
class(Intercom) extends(IStructRadioEDLogic)
```

**Интерфейсы** должны начинаться с префикса `I`:

```sqf
// Хорошо
class(IStruct) extends(IDestructible)
class(IDestructible) extends(GameObject)
class(IContainer)
class(IRadio)
```

**Исключения:**
- Базовые типы могут не иметь префикса `I` (например, `GameObject`, `Item`)
- Интерфейсы всегда должны иметь префикс `I`

### Именование структур

Используйте **PascalCase** для имен структур (аналогично классам):

```sqf
// Хорошо
struct(OverlayLayerController)
struct(OverlayBase)
struct(OverlayFace) base(OverlayBase)
struct(BABase)
struct(AgentBase)
```

**Именование членов структур:**

- **Публичные члены**: используют **camelCase** (без подчеркивания в начале)
  ```sqf
  struct(OverlayBase)
      def(priority) 0
      def(mode) OVERLAY_PRIORITY_NORMAL
      def(cover) OVERLAY_LAYER_BODY
      def(src) nullPtr;
  endstruct
  ```

- **Приватные члены**: должны начинаться с **подчеркивания** `_` и использовать **camelCase**
  ```sqf
  struct(OverlayLayerController)
      def(_allGroups) [];           // приватный член
      def(_suppressionCounters) [];  // приватный член
      
      def(getLayerGroup)            // публичный метод
      {
          params ["_layer"];
          self getv(_allGroups) get _layer
      }
  endstruct
  ```

**Правило:** Если член структуры предназначен только для внутреннего использования структурой, он должен начинаться с подчеркивания. Публичные члены (которые могут использоваться извне) не должны иметь подчеркивания.

### Именование функций и методов

Используйте **camelCase** для имен функций и методов. Имена должны начинаться с глагола, описывающего действие:

```sqf
// Хорошо
func(getName)
func(setWeight)
func(canAdd)
func(isInWorld)
func(onContainerOpen)
func(removeItem)
func(dropAllItemsInHands)
```

**Паттерны именования методов:**

- **Getter методы**: `get` + имя свойства
  ```sqf
  func(getName)
  func(getWeight)
  func(getRadioFrequencyKey)
  ```

- **Setter методы**: `set` + имя свойства
  ```sqf
  func(setWeight)
  func(setRadioFrequency)
  func(setRadioVolume)
  ```

- **Проверочные методы**: `is`/`can` + описание проверки
  ```sqf
  func(isInWorld)
  func(isItem)
  func(canAdd)
  func(canUseAsCraftSpace)
  ```

- **Обработчики событий**: `on` + название события
  ```sqf
  func(onContainerOpen)
  func(onContainerClose)
  func(onMoveInItem)
  func(onStopFlying)
  ```

- **Внутренние методы**: могут начинаться с `__` для обозначения приватности
  ```sqf
  func(__handlePreInitVars__)
  ```

### Именование переменных

#### Переменные классов

Используйте **camelCase** для переменных-членов классов:

```sqf
// Хорошо
var(name,null);
var(desc,null);
var(weight,0);
var(hp,0);
var(hpMax,0);
var(material,null);
var(germs,0);
```

#### Локальные переменные

Локальные переменные должны начинаться с **подчеркивания** `_` и использовать **camelCase**:

```sqf
// Хорошо
private ["_args", "_PREF", "_color"];
private ["_var", "_fnc", "_srcObj"];
private ["_radio", "_count"];

func(example) {
    objParams_1(_item);
    private _result = 0;
    private _tempValue = getSelf(weight);
    // ...
};
```

#### Глобальные переменные модулей

Глобальные переменные должны иметь **префикс модуля** (в полном или сокращенном виде) через подчеркивание для предотвращения конфликтов имен:

```sqf
// Хорошо

// inventory - Inventory module
inventory_containerData = [];

// cprint - Console print
cprint_isserver = isMultiplayer && isServer;
cprint_usestdout = true;

//le - Light engine (LightEngine module)
le_allLights = []; //all light points
```

**Плохо:**
```sqf
// Плохо - нет префикса модуля
counter = 0;
isServer = true;
```

#### Индикаторы типа для глобальных переменных-коллекций

Для улучшения читаемости кода рекомендуется использовать индикаторы типа (`_list`, `_map`) в именах глобальных переменных-коллекций. Эти индикаторы могут быть как суффиксами, так и частью имени в середине:

- **`_list`** - для глобальных массивов (списков)
  ```sqf
  // В конце имени (суффикс)
  verb_list = createHashMap;
  verb_inverted_list = createHashMap;
  begin_internal_hwcut_list = [];
  lobby_sprite_list = [];
  debug_objfalling_list = [];
  debug_openspace_list = [];
  
  // В середине имени
  soundengine_internal_debug_list_objs = [];
  sound3d_internal_list_soundBuff = [];
  smd_list_variables = [];
  smd_list_allSlots = [];
  ai_nav_internal_list_regionOffsets = [];
  server_gameAspects_list_nopicked = [];
  vs_list_langs = [];
  ```

- **`_map`** - для глобальных хэш-карт (HashMap)
  ```sqf
  // В конце имени (суффикс)
  ie_actions_map = createHashMap;
  medl_map = hashMapNew;
  logger_internal_map = hashMapNew;
  faith_map = createHashMap;
  ata_assoc_map = createHashMap;
  cm_commands_map = createHashMap;
  lobby_faithDesc_map = createHashMap;
  le_se_map = createHashMap;
  inventory_slotpos_map = [];
  
  // В середине имени
  vs_map_whohear = createHashMapFromArray [];
  vs_map_waveSpeakers = createHashMap;
  smd_internal_map_vis = createHashMapFromArray [];
  serverclient_internal_map_sysmes = createHashMapFromArray [];
  cm_map_ownerToDisIdAssoc = hashMapNew;
  cm_map_nickColor = createHashMap;
  cm_map_messagesColor = createHashMap;
  vsm_map_freqAndCode = createHashMap;
  vsm_map_inverted = createHashMap;
  ```

**Примечание:** Индикаторы типа необязательны, но их использование улучшает читаемость кода и явно указывает на тип данных переменной. Это особенно полезно для глобальных переменных, которые используются в разных частях кода. Индикаторы могут располагаться как в конце имени (суффикс), так и в середине, в зависимости от логической структуры имени переменной.

### Именование макросов и констант

Используйте **UPPER_SNAKE_CASE** для макросов и констант:

```sqf
// Хорошо
#define PLATFORM_VERSION '__GAME_VER__'
#define ISDEVBUILD false
#define REQ_GET_VERSION "getVersion"
#define CMD_CONNECT_VOICE "connectVoice"
#define REQ_IS_CONNECTED_VOICE "isConnectedVoice"
#define CMD_RADIO_ADD "addRadio"
```

**Паттерны для макросов:**

- **Версии и конфигурация**: `PLATFORM_VERSION`, `ISDEVBUILD`
- **Запросы (REQ)**: `REQ_GET_VERSION`, `REQ_IS_CONNECTED_VOICE`
- **Команды (CMD)**: `CMD_CONNECT_VOICE`, `CMD_RADIO_ADD`
- **Внутренние макросы**: могут начинаться с `__` для обозначения внутреннего использования
  ```sqf
  #define __pragma_preprocess preprocessFileLineNumbers
  #define __post_message_RB(m)
  ```

**Макросы в заголовочных файлах (.h/.hpp):**

Для макросов, которые экспортируются через заголовочные файлы (доступны другим модулям), **рекомендуется добавлять префикс модуля** в начале имени макроса:

```sqf
// Хорошо - макросы в NOEngine.h
#define chunk_owners 0
#define chunk_lastupdate 1
#define chunk_objectsData 2
#define chunk_getOwners(chunk) ((chunk) select chunk_owners)
#define chunk_isEmptyOwnerList(chunk) equals(chunk_getOwners(chunk),[])

// Хорошо - макросы в ReVoice.h
#define REQ_GET_VERSION "getVersion"
#define REQ_IS_CONNECTED_VOICE "isConnectedVoice"
#define CMD_CONNECT_VOICE "connectVoice"
#define CMD_RADIO_ADD "addRadio"
#define REQ_AUDIO_GET_ALL_SOUNDS_IDS "audioGetAllSoundsIds"
#define CMD_AUDIO_PLAY_SOUND "audioPlaySound"

// Хорошо - макросы в GamemodeManager.h
#define gprint(mes) conDllCall format["[GMM]:	%1 #0101",mes]
#define gprintformat(mes,fmt) gprint(format[mes arg fmt])
#define DEFAULT_TIME_TO_START 60
#define PRE_LOBBY_AWAIT_TIME 60*5
```

**Правило:** Если макрос определен в заголовочном файле и может быть использован другими модулями, добавьте префикс модуля (например, `chunk_`, `REQ_`, `CMD_`, `gprint` для GamemodeManager) для предотвращения конфликтов имен.

### Именование файлов

- Используйте **PascalCase** для файлов классов: `GameObject.sqf`, `Item.sqf`
- Используйте **snake_case** или **camelCase** для файлов с функциями: `functions.sqf`, `client.sqf`
- Файлы инлайн-интерфейсов могут иметь суффикс `.Interface`: `IRadio.Interface`, `IContainer.Interface`
- Файлы инициализации могут иметь суффикс `_init.sqf`: `ServerVoice_init.sqf`, `SMD_init.sqf`
- Файлы содержащие определения структур могут иметь суффикс `_struct.sqf` или `structs.sqf`: `MyEntity_struct.sqf`, `ExampleModule_structs.sqf`

### Общие принципы

1. **Используйте понятные имена**: имена должны ясно описывать назначение
2. **Избегайте сокращений**: предпочитайте полные слова (`getContainerClientInfo` вместо `getContClInfo`)
3. **Будьте последовательны**: используйте одинаковые паттерны для похожих сущностей
4. **Префиксы для модулей**: всегда используйте префиксы для глобальных переменных
5. **Подчеркивание для локальных**: всегда начинайте локальные переменные с `_`

## Анти-паттерны и что избегать

### Глобальные переменные без префикса

```sqf
// Плохо
counter = 0;

// Хорошо
myModule_counter = 0;
```

### Прямой доступ к внутренностям классов

```sqf
// Плохо - прямой доступ к полю
private _value = getVar(_obj,privateField);

// Хорошо - через публичный метод
private _value = callFunc(_obj,getPrivateField);
```

### Динамическое создание полей в конструкторе

```sqf
// Плохо - поле создается "на лету" в конструкторе
class(MyClass) extends(BaseClass)
    func(constructor)
    {
        objParams();
        setSelf(dynamicField, 123);  // Плохо: поле не объявлено явно
    };
endclass

// Хорошо - все поля объявлены явно в теле класса
class(MyClass) extends(BaseClass)
    var(dynamicField, 0);  // Хорошо: поле объявлено явно
    
    func(constructor)
    {
        objParams();
        setSelf(dynamicField, 123);  // Хорошо: устанавливаем значение уже объявленного поля
    };
endclass
```

**Почему это важно:**
- Структура класса должна быть видна сразу при чтении кода - все поля объявлены в одном месте
- Наследники класса могут полагаться на наличие определенных полей, которые должны быть явно объявлены
- Статический анализ и понимание кода становится невозможным, если поля определяются динамически
- Легко допустить ошибку, пытаясь использовать поле, которое еще не было инициализировано
- Усложняется отладка и поддержка кода - сложно понять, какие поля должны существовать у объекта

**Правило:** Все поля класса должны быть объявлены через `var()` в теле класса (между `class()` и `endclass`). `var()` и `func()` могут использоваться **только в теле класса**, но **не внутри методов**.

### Игнорирование objParams()

```sqf
// Плохо - this не определен
func(myMethod)
{
    private _val = getSelf(value); // ошибка!
};

// Хорошо
func(myMethod)
{
    objParams();
    private _val = getSelf(value);
};
```

### Дублирование кода

```sqf
// Плохо - дублирование
moduleA_process = {
    // логика
};

moduleB_process = {
    // та же логика
};

// Хорошо - вынесено в общую функцию
common_process = {
    // общая логика
};

moduleA_process = common_process;
moduleB_process = common_process;
```

### Игнорирование ошибок

```sqf
// Плохо - слепое добавление проверок везде без понимания контекста
myFunction = {
    params ["_obj"];
    // Неоправданная проверка - если _obj всегда валиден в этом контексте
    if (!valid(_obj)) then {
        error("MyModule: Invalid object");
    };
    callFunc(_obj,doSomething);
};

// Хорошо - проверка только там, где это действительно необходимо
myFunction = {
    params ["_obj"];
    // Проверка оправдана, если _obj может быть null (например, из внешнего источника)
    if (!valid(_obj)) exitWith {
        error("MyModule: Invalid object");
    };
    callFunc(_obj,doSomething);
};

// Также хорошо - если разработчик понимает, что _obj гарантированно валиден
myFunction = {
    params ["_obj"];  // _obj создан выше в коде и гарантированно валиден
    callFunc(_obj,doSomething);  // Проверка не нужна
};
```

**Важно:** Разработчик должен понимать контекст и добавлять проверки на null только там, где это действительно необходимо. Слепое добавление проверок везде - это признак непонимания кода и приводит к раздуванию кодовой базы без реальной пользы. Проверяйте объекты только в точках входа (публичные методы, обработчики событий, RPC), где данные могут прийти извне, а не в каждом внутреннем вызове.

### Где проверять на null

**Точки входа, где проверки обязательны:**

1. **Публичные методы классов** - когда метод вызывается извне:
```sqf
func(processItem)
{
    objParams_1(_item);
    // Проверка обязательна - _item приходит извне
    if (!valid(_item)) exitWith {
        error("MyClass: processItem: Invalid item provided");
    };
    // остальной код
};
```

2. **RPC обработчики** - данные приходят по сети:
```sqf
private _handler = {
    params ["_data", "_obj"];
    // Проверка обязательна - данные приходят по сети
    if (!valid(_obj)) exitWith {
        error("MyModule: Invalid object from client");
    };
    // обработка
};
rpcAdd("myAction", _handler);
```

3. **Обработчики событий** - события могут содержать null:
```sqf
func(onItemAdded)
{
    objParams_1(_item);
    // Проверка обязательна - событие может содержать null
    if (!valid(_item)) exitWith {
        warning("MyClass: onItemAdded: Item is null");
    };
    // обработка события
};
```

4. **Параметры функций модулей** - когда функция вызывается из других модулей:
```sqf
myModule_processData = {
    params ["_data"];
    // Проверка обязательна - функция публичная
    if (isNullVar(_data)) exitWith {
        error("MyModule: processData: Data is required");
    };
    // обработка
};
```

**Внутренние методы - проверки обычно не нужны:**
```sqf
func(internalHelper)
{
    objParams_1(_item);
    // Проверка не нужна - метод вызывается только внутри класса,
    // и вызывающий код уже проверил валидность
    callFunc(_item,doSomething);
};
```

**Рекомендация:** Проверяйте на null в точках входа (публичные методы, RPC, события), где данные могут прийти извне. Во внутренних методах, где вы контролируете все вызовы, проверки обычно избыточны.

## Особенности работы с OOP системой

### Использование наследования

```sqf
// Базовый класс
class(BaseItem) extends(Item)
    func(use)
    {
        objParams();
        log("BaseItem: Used");
    };
endclass

// Наследник
class(SpecificItem) extends(BaseItem)
    func(use)
    {
        objParams();
        // Вызов базового метода
        callSuper(BaseItem,use);
        // Дополнительная логика
        log("SpecificItem: Special action");
    };
endclass
```

### Работа с объектами

```sqf
// Создание объекта
private _obj = new(MyClass);

// Проверка валидности
if (!valid(_obj)) then {
    error("Failed to create object");
};

// Использование объекта
callFunc(_obj,doSomething);

// Удаление объекта
delete(_obj);
```

### Автоматическая очистка ресурсов

Используйте `autoref` для автоматической очистки ссылок на объекты при удалении объекта.

**Важное ограничение:** `autoref` работает **только для классов, унаследованных от `ManagedObject`**.

**Иерархия классов с поддержкой autoref:**
- `ManagedObject` - базовый класс для всех управляемых объектов
- `GameObject` - наследуется от `ManagedObject`, базовый класс для всех игровых объектов
- Все игровые объекты наследуются от `GameObject`:
  - `Item`, `IStruct`, `Decor`, `BasicMob`, `Mob` и их наследники
  - Все классы из модулей `GameObjects/`, `CombatSystem/` и других игровых систем
- `ObjectiveBase` - также наследуется от `ManagedObject`

**Как проверить, доступен ли autoref:**
- Если класс наследуется от `GameObject` или его наследников → `autoref` доступен
- Если класс наследуется от `ManagedObject` напрямую → `autoref` доступен
- Если класс не наследуется от `ManagedObject` → `autoref` недоступен

**Принцип работы:**
1. `autoref` - это модификатор, который помечает поле как автоматически очищаемое
2. При регистрации класса система собирает список всех полей с модификатором `autoref` в `__autoref_list`
3. При удалении объекта (вызов `delete()`) деструктор `ManagedObject` проверяет метод `enableAutoRefGC()` (возвращает `true` по умолчанию)
4. Если `enableAutoRefGC` включен, система проходит по всем полям из `__autoref_list` и очищает их в зависимости от типа:
   - **Массив объектов (`ARRAY`)**: Удаляет все объекты из массива через `delete()`, затем устанавливает массив в `["<AUTOREF_NAN>"]`
   - **Одиночный объект (`nullPtr` / `Location`)**: Удаляет объект через `delete()`
   - **Handle обновления (`SCALAR` > -1)**: Останавливает обновление через `stopUpdate()`

**Что очищает:**
- Ссылки на другие OOP объекты (одиночные или в массивах)
- Handles обновлений (`startUpdate`), чтобы предотвратить выполнение кода после удаления объекта

**Где используется в проекте:**
- **Оружие (`RangedWeapon.sqf`)**: Патрон в патроннике (`bullet`) и магазин (`magazine`) - при удалении оружия автоматически удаляются связанные патрон и магазин
- **Магазин (`Magazines.sqf`)**: Массив патронов (`content`) - при удалении магазина автоматически удаляются все патроны из массива
- **Ловушки (`ITrapItem`)**: Структура ловушки (`trapStruct`) - при удалении предмета-ловушки автоматически удаляется структура ловушки на карте
- **Части тела (`Bodyparts.sqf`)**: Наложенный бинт (`bandage`) - при удалении части тела автоматически удаляется наложенный на неё бинт
- **Сетевые дисплеи (`Mob.sqf`, `BasicMob.sqf`)**: Ссылки на открытые дисплеи - автоматически закрываются при удалении персонажа
- **Handles обновлений**: Handles от `startUpdate()` - автоматически останавливаются при удалении объекта, предотвращая выполнение кода после удаления

**Синтаксис:**
```sqf
// Пример 1: Одиночный объект (из RangedWeapon.sqf)
class(RangedWeapon) extends(Item)  // Item наследуется от GameObject -> ManagedObject
    autoref var(bullet, nullPtr);  // Патрон в патроннике - будет удален при удалении оружия
    autoref var(magazine, nullPtr);  // Магазин - будет удален при удалении оружия
endclass

// Пример 2: Массив объектов (из Magazines.sqf)
class(Magazine) extends(Item)
    autoref var(content, []);  // Массив патронов - все патроны будут удалены при удалении магазина
endclass

// Пример 3: Handle обновления (из Campfires.sqf)
class(Campfire) extends(IStruct)
    autoref var(handleUpdate, -1);  // Handle обновления - будет остановлен при удалении костра
endclass
```

**Когда использовать autoref:**

Используйте `autoref` для автоматической очистки ссылок на объекты, когда:
- ✅ Класс наследуется от `ManagedObject` (все игровые объекты)
- ✅ Поле содержит ссылку на один объект или массив объектов
- ✅ Очистка не требует дополнительной логики
- ✅ Вы хотите упростить код и не держать в голове необходимость очистки в деструкторе

**Когда использовать явную очистку в деструкторе:**

Используйте явную очистку, когда:
- ❌ Класс не наследуется от `ManagedObject`
- ❌ Требуется дополнительная логика при очистке (например, уведомление других объектов)
- ❌ Массив изменяется при удалении объектов (см. ограничения autoref)
- ❌ Нужен полный контроль над процессом очистки

**Рекомендация:** В большинстве случаев для игровых объектов (наследников `GameObject`) используйте `autoref` - это проще и безопаснее, чем ручная очистка.

**Ограничения и предупреждения:**
- **Критично:** Нельзя использовать для массивов, которые изменяются при удалении объектов (например, содержимое контейнера). Если объект в массиве при удалении вызывает методы, которые изменяют сам массив (например, `removeItem`), это приведет к смещению индексов и утечкам памяти. В таких случаях нужно использовать явную очистку в деструкторе:
```sqf
func(destructor)
{
    objParams();
    {
        delete(_x);
    } foreach array_copy(getSelf(content));  // Явная очистка с копированием массива
};
```
- `autoref` не работает для классов, которые не наследуются от `ManagedObject` (например, обычный `object`)

## Работа с памятью и производительностью

### Избегайте утечек памяти

Определяйте владельца очистки каждого временного объекта. Если вызываемый метод принимает объект и удаляет его, передавайте ему владение. Используйте `AutoObjectPtr` для очистки OOP-объекта при завершении времени жизни владеющей им ссылки; не добавляйте второго владельца очистки к существующему контракту передачи владения.

```sqf
// Плохо - объекты не удаляются
{
    private _obj = new(MyClass);
    // объект не удаляется
} forEach _array;

// Хорошо - удаление объектов
{
    private _obj = new(MyClass);
    // использование объекта
    delete(_obj);
} forEach _array;
```

### Оптимизация циклов

Для локального поиска мобов используйте `getMobsOnPosition` вместо перебора всех мобов. Предпочитайте проектные методы расстояния, когда их контракты аргументов подходят задаче; сохраняйте расчёты по явным точкам или положениям частей тела, если расстояние между объектами изменит требуемую геометрию.

```sqf
// Плохо - создание объектов в цикле
{
    private _obj = new(MyClass);
    callFunc(_obj,process, [_x]);
    delete(_obj);
} forEach _largeArray;

// Хорошо - переиспользование объекта
private _processor = new(MyClass);
{
    callFunc(_processor,process, [_x]);
} forEach _largeArray;
delete(_processor);
```

### Избегайте лишних проверок в горячих путях

```sqf
// В критичных местах используйте прямые проверки
#ifdef DEBUG
    if (!valid(_obj)) then {
        error("Invalid object");
    };
#endif

callFunc(_obj,criticalMethod);
```

## Сетевые взаимодействия и безопасность

### Валидация данных от клиента

```sqf
#include "serverRpc.hpp"  // На сервере

// На сервере - всегда валидируйте данные от клиента
private _clientActionHandler = {
    params ["_clientData"];
    
    // Валидация
    if (not_equalTypes(_clientData, [])) exitWith {
        error("Security: Invalid data from client");
    };
    
    // Обработка
};
rpcAdd("clientAction", _clientActionHandler);
```

### Проверка прав доступа

```sqf
// Проверяйте права перед выполнением действий
func(adminAction)
{
    objParams();
    
    if (!callFunc(_user,isAdmin)) exitWith {
        error("Security: Access denied");
    };
    
    // выполнение действия
};
```

### Защита от инъекций

```sqf
// Всегда валидируйте строковые входные данные
func(processInput)
{
    objParams_1(_input);
    
    // Валидация
    if (not_equalTypes(_input, "")) exitWith {
        error("Invalid input type");
    };
    
    // Обработка
};
```

## Примеры правильного и неправильного кода

### Пример 1: Работа с классами

```sqf
// Плохо
myGlobal_obj = createLocation [...];
myGlobal_obj setVariable ["value", 10];
private _val = myGlobal_obj getVariable "value";

// Хорошо
private _obj = new(MyClass);
setVar(_obj,value, 10);
private _val = getVar(_obj,value);
```

### Пример 2: Обработка ошибок

```sqf
// Плохо
func(processData)
{
    objParams_1(_data);
    // нет проверки
    private _result = _data select 0;
};

// Хорошо
func(processData)
{
    objParams_1(_data);
    FHEADER;
    if (not_equalTypes(_data, []) || count _data == 0) then {
        error("MyClass: Invalid data");
        RETURN([]);
    };
    private _result = _data select 0;
    RETURN(_result);
};
```

### Пример 3: Логирование

```sqf
// Плохо
systemChat "Error occurred";

// Хорошо
errorformat("MyModule: Error: %1", _errorMsg);
```

## Комментирование кода

### Комментарии для сложной логики

```sqf
// Вычисляем расстояние с учетом рельефа местности
// Используется алгоритм A* для поиска пути
private _distance = [_start, _end] call calculatePathDistance;
```

### Документирование функций

```sqf
/*
    Обрабатывает данные игрока
    
    Parameters:
        _player - объект игрока
        _data - данные для обработки
    
    Returns:
        Boolean - успех операции
*/
func(processPlayerData)
{
    objParams_2(_player,_data);
    // код
};
```

### TODO комментарии

```sqf
// TODO: Оптимизировать этот алгоритм
// TODO: Добавить поддержку новых типов данных
```

## Тестирование кода

### Модульное тестирование

```sqf
#ifdef DEBUG
    // Тестовые функции только в режиме отладки
    testModule_runTests = {
        // тесты
    };
#endif
```

### Проверка граничных условий

```sqf
func(divide)
{
    objParams_2(_a,_b);
    
    FHEADER;
    if (_b == 0) then {
        error("Math: Division by zero");
        RETURN(0);
    };
    
    _a / _b
};
```

## Что дальше?

- ➡️ [Особенности синтаксиса](03_SYNTAX_GUIDE.md) - синтаксические особенности
- ➡️ [Модульная система](04_MODULE_SYSTEM.md) - создание модулей по стандартам

