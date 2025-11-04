# Архитектура RVEngine (Intercept)

## Введение

RVEngine использует архитектуру **Host/Client**, которая обеспечивает безопасное и эффективное взаимодействие между нативными плагинами и движком Arma 3 (Real Virtuality).

## Общая архитектура системы

```
┌──────────────────────────────────────────────────────────────┐
│                    Arma 3 (RV Engine)                        │
│  ┌────────────────────────────────────────────────────────┐  │
│  │            SQF Virtual Machine                         │  │
│  │  - Интерпретатор SQF кода                             │  │
│  │  - Хранилище переменных (namespaces)                  │  │
│  │  - Контекст выполнения (game_state, vm_context)      │  │
│  └────────────────────────┬───────────────────────────────┘  │
│                           │                                   │
│  ┌────────────────────────▼───────────────────────────────┐  │
│  │         Нативные SQF функции (C++)                     │  │
│  │  - player(), getPos(), createVehicle() и т.д.         │  │
│  │  - ~3000+ функций доступны через указатели            │  │
│  └────────────────────────┬───────────────────────────────┘  │
└───────────────────────────┼───────────────────────────────────┘
                            │
                ┌───────────▼────────────┐
                │   RVEngine Extension   │ ◄── Загружается через callExtension
                │   (intercept_x64.dll)  │
                └───────────┬────────────┘
                            │
                ┌───────────▼────────────┐
                │    HOST КОМПОНЕНТЫ     │
                ├────────────────────────┤
                │  • Loader              │ ◄── Сканирует память, находит функции
                │  • Invoker             │ ◄── Вызывает SQF функции
                │  • Controller          │ ◄── Управляет клиентами
                │  • Extensions          │ ◄── Загружает client плагины
                └───────────┬────────────┘
                            │
        ┏━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━┓
        ▼                                        ▼
┌───────────────────┐                   ┌───────────────────┐
│  Client Plugin 1  │                   │  Client Plugin 2  │
│  (your_plugin.dll)│                   │  (other_plugin.dll)│
├───────────────────┤                   ├───────────────────┤
│ • Использует      │                   │ • Использует      │
│   Intercept API   │                   │   Intercept API   │
│ • Регистрирует    │                   │ • Обрабатывает    │
│   команды         │                   │   события         │
│ • Обрабатывает    │                   │ • Создаёт типы    │
│   события         │                   │                   │
└───────────────────┘                   └───────────────────┘
```

## Host - Главный модуль

Host (`intercept_x64.dll`) — это сердце RVEngine. Он загружается движком Arma 3 как расширение и предоставляет инфраструктуру для работы клиентских плагинов.

### Основные компоненты Host

#### 1. Loader (Загрузчик)

**Расположение**: `src/host/loader/`

**Назначение**: Сканирует память процесса Arma 3 для поиска указателей на нативные SQF функции.

**Как работает**:

```
1. Запуск игры и загрузка RVEngine
2. Loader сканирует секции памяти процесса
3. Использует сигнатуры для поиска функций:
   - CommandScan.cpp - основной сканер
   - CommandScan214.cpp - специфичные паттерны
4. Находит функции по уникальным байтовым паттернам
5. Строит таблицу указателей на функции
```

**Ключевые классы**:
- `loader` - главный класс загрузчика
- `CommandScan` - сканер команд
- `MemorySection` - работа с секциями памяти

#### 2. Invoker (Вызыватель)

**Расположение**: `src/host/invoker/`

**Назначение**: Предоставляет механизм для вызова нативных SQF функций из C++ кода.

**Типы функций**:
- **Nular** - без аргументов: `player()`, `time()`
- **Unary** - один аргумент: `typeOf obj`, `count array`
- **Binary** - два аргумента: `obj setPos pos`, `array select index`

**Процесс вызова**:

```cpp
// Пример внутреннего вызова
game_value result = invoker::invoke_nular(nular_function_ptr, game_state);
game_value result = invoker::invoke_unary(unary_function_ptr, game_state, right_arg);
game_value result = invoker::invoke_binary(binary_function_ptr, game_state, left_arg, right_arg);
```

**Потокобезопасность**: 
- Invoker использует блокировки для безопасного доступа из разных потоков
- `invoker_lock` класс для ручного управления блокировками

#### 3. Controller (Контроллер)

**Расположение**: `src/host/controller/`

**Назначение**: Управляет жизненным циклом клиентских плагинов, диспетчеризация событий.

**Функции**:
- Отслеживание состояния игры (миссия загружена, завершена и т.д.)
- Вызов lifecycle хуков у клиентов:
  - `pre_start()` - перед инициализацией функций
  - `post_start()` - после загрузки основных систем
  - `pre_init()` - перед инициализацией миссии
  - `post_init()` - после инициализации миссии
  - `on_frame()` - каждый кадр
  - `mission_ended()` - при завершении миссии
- Управление очередью событий

#### 4. Extensions (Расширения)

**Расположение**: `src/host/extensions/`

**Назначение**: Поиск, загрузка и управление клиентскими DLL плагинами.

**Процесс загрузки плагинов**:

```
1. Поиск DLL файлов в папке intercept/
2. Загрузка библиотеки через LoadLibrary
3. Поиск экспортируемых функций:
   - api_version()
   - assign_functions()
   - pre_start(), post_init() и др.
4. Передача указателей на Host функции клиенту
5. Инициализация клиента
6. Регистрация клиента в Controller
```

**Функции экспорта**:
- `search_extension` - поиск расширений в папках
- `load_extension` - загрузка конкретной DLL
- `unload_extension` - выгрузка DLL

## Client - Клиентская библиотека

Client — это статическая библиотека (`intercept_client.lib`), которую плагины линкуют в свой проект для доступа к RVEngine API.

### Структура Client

**Расположение**: `src/client/`

#### Основные компоненты:

1. **Типы данных** (`headers/shared/`)
   - `types.hpp` - game_value, game_data, script types
   - `client_types.hpp` - object, group, code и др.
   - `containers.hpp` - auto_array, r_string
   - `vector.hpp` - vector2, vector3

2. **SQF обёртки** (`headers/client/sqf/`)
   - Функции для каждой категории SQF команд
   - `core.hpp` - базовые команды
   - `units.hpp` - работа с юнитами
   - `vehicles.hpp` - работа с техникой
   - и т.д.

3. **Event Handlers** (`eventhandlers.hpp`)
   - Регистрация обработчиков событий
   - Автоматический вызов из Host

4. **Client интерфейс** (`client.hpp`)
   - Регистрация команд
   - Регистрация типов
   - Plugin interfaces

### Точка входа клиента

```cpp
// Эта функция вызывается Host при загрузке плагина
extern "C" {
    DLLEXPORT void CDECL assign_functions(
        const struct client_functions funcs, 
        r_string module_name
    ) {
        // Host передаёт указатели на свои функции
        intercept::client::host::functions = funcs;
        intercept::client::host::module_name = module_name;
        
        // Инициализация клиента
        intercept::client::__initialize();
    }
}
```

## Взаимодействие Host ↔ Client

### 1. Инициализация

```
┌────────────┐                              ┌────────────┐
│   Host     │                              │   Client   │
└─────┬──────┘                              └──────┬─────┘
      │                                            │
      │ 1. LoadLibrary(plugin.dll)                │
      ├───────────────────────────────────────────►
      │                                            │
      │ 2. Поиск assign_functions()               │
      ├───────────────────────────────────────────►
      │                                            │
      │ 3. Вызов assign_functions(funcs)          │
      ├───────────────────────────────────────────►
      │                                            │ 4. Сохранение указателей
      │                                            │    на Host функции
      │                                            │
      │ 5. Вызов api_version()                    │
      ├───────────────────────────────────────────►
      │                                            │
      │ 6. Возврат версии API                     │
      │◄───────────────────────────────────────────┤
      │                                            │
      │ 7. Вызов pre_start()                      │
      ├───────────────────────────────────────────►
      │                                            │ 8. Регистрация команд,
      │                                            │    типов и т.д.
```

### 2. Регистрация SQF команды

```cpp
// Client код
void intercept::pre_init() {
    client::host::register_sqf_command(
        "myCommand",
        "Description",
        my_function,
        game_data_type::SCALAR,
        game_data_type::SCALAR
    );
}
```

**Что происходит**:

```
1. Client вызывает host::register_sqf_command()
2. Через указатель вызывается sqf_functions::register_sqf_function()
3. Host создаёт обёртку для функции клиента
4. Регистрирует её в RV engine как SQF команду
5. При вызове из SQF → Host вызывает клиентскую функцию
```

### 3. Вызов SQF функции

```cpp
// Client код
object player = sqf::player();
```

**Что происходит**:

```
1. sqf::player() → вызывает client_functions.invoke_nular
2. Host получает запрос с указателем на функцию
3. invoker::invoke_nular() вызывает нативную функцию RV
4. Результат (game_value) возвращается клиенту
5. Преобразование game_value → object
```

### 4. Обработка событий

```cpp
// Client код
void intercept::killed(object& unit, object& killer) {
    // Обработка события
}
```

**Что происходит**:

```
1. В игре происходит событие (убийство юнита)
2. RV engine вызывает зарегистрированный eventHandler
3. Host получает событие через eventhandlers.cpp
4. Controller диспетчеризует событие всем клиентам
5. Вызывается killed() у каждого клиента
```

## Управление памятью

### Reference Counting

RVEngine использует систему подсчёта ссылок для управления временем жизни объектов:

```cpp
template<typename Type>
class ref {
    Type* _ref;
public:
    ref() : _ref(nullptr) {}
    ref(Type* new_ref) : _ref(new_ref) {
        if (_ref) _ref->add_ref();
    }
    ~ref() {
        if (_ref) _ref->release();
    }
    // ...
};
```

**Важные типы**:
- `game_value` - содержит `ref<game_data>`
- `game_data` - базовый класс с refcount
- `auto_array<T>` - массив с подсчётом ссылок

### Аллокаторы

RVEngine использует аллокаторы движка для совместимости:

```cpp
// Выделение памяти через движок
rv_allocator<Type>::create_single();
rv_allocator<Type>::destroy_deallocate(ptr);

// Pool аллокаторы для частых типов
rv_pool_allocator* pool_alloc_base;
```

## Потокобезопасность

### Проблема

RV engine **не является потокобезопасным**. Вызовы SQF функций должны происходить только из основного игрового потока.

### Решение

```cpp
// Пользовательский поток
std::thread worker([]{
    // НЕЛЬЗЯ: sqf::hint("Hello"); // CRASH!
    
    // ПРАВИЛЬНО: использовать очередь
    std::lock_guard<std::mutex> lock(queue_mutex);
    task_queue.push([]{ 
        sqf::hint("Hello"); 
    });
});

// В on_frame() (игровой поток)
void intercept::on_frame() {
    std::lock_guard<std::mutex> lock(queue_mutex);
    while (!task_queue.empty()) {
        task_queue.front()();
        task_queue.pop();
    }
}
```

### invoker_lock

```cpp
// Для защиты доступа к invoker
{
    client::invoker_lock lock;
    // Безопасно вызывать SQF функции
    sqf::hint("Protected call");
} // Автоматическая разблокировка
```

## Система типов

### Иерархия типов

```
serialize_class
    ├── game_data (refcount, I_debug_value)
    │   ├── game_data_number
    │   ├── game_data_bool
    │   ├── game_data_string
    │   ├── game_data_array
    │   ├── game_data_hashmap
    │   ├── game_data_code
    │   ├── game_data_object
    │   ├── game_data_group
    │   ├── game_data_config
    │   └── ... (другие типы)
    │
    ├── game_value
    │   └── ref<game_data> data
    │
    └── sqf_script_type
        ├── script_type_info* single_type
        └── compound_script_type_info* compound_type
```

### Конвертация типов

```cpp
// game_value может содержать любой тип
game_value val = 42.0f;              // number
game_value val = "hello";            // string
game_value val = true;               // bool
game_value val = std::vector{1,2,3}; // array

// Извлечение значений
float num = val;                // operator float()
std::string str = val;          // operator std::string()
auto& arr = val.to_array();     // ref to array

// Проверка типа
if (val.type_enum() == game_data_type::SCALAR) { /*...*/ }
```

## Жизненный цикл плагина

```
┌─────────────────────────────────────────────────────────────┐
│                    Lifecycle События                         │
└─────────────────────────────────────────────────────────────┘

1. Загрузка игры
   ↓
2. Загрузка RVEngine (Host)
   ↓
3. Host сканирует функции (Loader)
   ↓
4. Host ищет и загружает Client плагины (Extensions)
   ↓
5. assign_functions() → передача API клиенту
   ↓
6. pre_start() → регистрация команд/типов
   ↓
7. Загрузка основных систем игры
   ↓
8. post_start() → CBA XEH_preStart
   ↓
9. pre_pre_init() → перед pre_init
   ↓
10. pre_init() → CBA XEH_preInit
   ↓
11. Загрузка миссии
   ↓
12. post_init() → CBA XEH_postInit
   ↓
13. ┌─────────────────────────────┐
    │  ИГРОВОЙ ЦИКЛ              │
    │  on_frame() - каждый кадр  │
    │  События - при возникновении│
    └─────────────────────────────┘
   ↓
14. Завершение миссии
   ↓
15. mission_ended()
   ↓
16. Переход к шагу 11 (новая миссия) или выход
```

## Производительность

### Почему RVEngine быстрее SQF?

1. **Нативный код**: C++ компилируется в машинный код, SQF интерпретируется
2. **Прямые вызовы**: Обход SQF VM, прямой вызов функций движка
3. **Оптимизация компилятора**: MSVC/GCC оптимизируют C++ код
4. **Отсутствие парсинга**: Код уже скомпилирован, не требуется парсинг

### Сравнение производительности

| Операция | SQF | RVEngine | Прирост |
|----------|-----|----------|---------|
| Простой вызов функции | 1x | ~10-20x | 10-20x быстрее |
| Обработка массива (1000 эл.) | 1x | ~50-100x | 50-100x быстрее |
| Математические операции | 1x | ~100-200x | 100-200x быстрее |
| Создание объектов | 1x | ~5-10x | 5-10x быстрее |

## Расширенные возможности

### Plugin Interfaces

Механизм для взаимодействия между плагинами:

```cpp
// Plugin A регистрирует интерфейс
struct MyInterface {
    void (*do_something)(int value);
};

MyInterface my_api = { my_function };
client::host::register_plugin_interface("MyAPI", 1, &my_api);

// Plugin B запрашивает интерфейс
auto interface = client::host::request_plugin_interface("MyAPI", 1);
if (interface) {
    MyInterface* api = (MyInterface*)(*interface);
    api->do_something(42);
}
```

### Пользовательские типы данных

```cpp
class my_custom_type : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    int custom_value;
    
    // Переопределение виртуальных методов
    const sqf_script_type& type() const override;
    r_string to_string() const override;
    // ...
};

// Регистрация в pre_init()
auto [type_enum, script_type] = client::host::register_sqf_type(
    "MY_TYPE", "Мой тип", "Описание", "MyType", create_func
);
```

## Заключение

Архитектура Host/Client в RVEngine обеспечивает:

- ✅ **Безопасность**: Изоляция клиентов, контролируемый доступ к API
- ✅ **Производительность**: Нативные вызовы, минимальные накладные расходы
- ✅ **Гибкость**: Регистрация команд, типов, интерфейсов
- ✅ **Стабильность**: Управление памятью, потокобезопасность
- ✅ **Расширяемость**: Лёгкое добавление новых плагинов

Понимание этой архитектуры поможет вам создавать эффективные и надёжные плагины для Arma 3.

---

**Следующие шаги**: 
- [Быстрый старт для разработчиков](GETTING_STARTED.md)
- [Система типов данных](Types/README.md)
- [API для плагинов](API/README.md)

