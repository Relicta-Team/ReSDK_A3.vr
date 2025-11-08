# API для плагинов RVEngine

Этот раздел описывает API, доступный для разработки плагинов (Client DLL) в RVEngine.

## Обзор

RVEngine Client API предоставляет следующие возможности:

1. **[Вызов SQF команд](SQF_COMMANDS.md)** - Доступ к ~3000+ функций движка
2. **[Жизненный цикл плагина](LIFECYCLE.md)** - Хуки для инициализации и обработки событий
3. **[Обработчики событий](EVENT_HANDLERS.md)** - Реакция на игровые события
4. **[Регистрация команд](CUSTOM_COMMANDS.md)** - Создание собственных SQF функций
5. **[Пользовательские типы](CUSTOM_TYPES.md)** - Создание новых типов данных
6. **[Интерфейсы плагинов](PLUGIN_INTERFACES.md)** - Взаимодействие между плагинами
7. **[Многопоточность](THREADING.md)** - Безопасная работа с потоками

## Точка входа плагина

Каждый плагин должен экспортировать функцию `api_version()`:

```cpp
#include <intercept.hpp>

// ОБЯЗАТЕЛЬНАЯ функция
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}
```

## Структура плагина

Минимальный плагин выглядит так:

```cpp
#include <intercept.hpp>
#include <Windows.h>

using namespace intercept;

// ============= API VERSION =============
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

// ============= LIFECYCLE HOOKS =============
void intercept::pre_init() {
    // Регистрация команд и типов
}

void intercept::post_init() {
    sqf::system_chat("Plugin loaded!");
}

void intercept::on_frame() {
    // Вызывается каждый кадр
}

// ============= DLL ENTRY POINT =============
BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

## Пространства имён

```cpp
namespace intercept {
    // Точки входа плагина (api_version, pre_init и т.д.)
    
    namespace types {
        // Типы данных (game_value, object, group и т.д.)
    }
    
    namespace sqf {
        // Обёртки SQF функций (player(), getPos() и т.д.)
    }
    
    namespace client {
        // Client-side API
        
        namespace host {
            // Взаимодействие с Host
        }
    }
}
```

## Доступные модули

### 1. SQF Commands

Вызов нативных функций движка:

```cpp
// Nular (без аргументов)
types::object player = sqf::player();
float time = sqf::time();

// Unary (один аргумент)
r_string name = sqf::name(player);
types::vector3 pos = sqf::get_pos(player);

// Binary (два аргумента)
sqf::set_pos(player, {100, 100, 0});
sqf::set_damage(player, 0.5f);
```

**Подробнее:** [Вызов SQF команд](SQF_COMMANDS.md)

### 2. Lifecycle Hooks

Функции, вызываемые Host в определённые моменты:

```cpp
// Перед инициализацией функций
void intercept::pre_start() { }

// После загрузки основных систем
void intercept::post_start() { }

// Перед инициализацией миссии
void intercept::pre_init() {
    // Регистрация команд
}

// После инициализации миссии
void intercept::post_init() {
    sqf::hint("Ready!");
}

// Каждый кадр
void intercept::on_frame() {
    // Основная логика
}

// При завершении миссии
void intercept::mission_ended() {
    // Очистка
}
```

**Подробнее:** [Жизненный цикл плагина](LIFECYCLE.md)

### 3. Event Handlers

Обработка игровых событий:

```cpp
// Убийство юнита
void intercept::killed(types::object& unit, types::object& killer) {
    r_string name = sqf::name(unit);
    sqf::system_chat(std::string(name) + " killed");
}

// Выстрел
void intercept::fired(
    types::object& unit,
    r_string weapon,
    r_string muzzle,
    r_string mode,
    r_string ammo,
    r_string magazine,
    types::object& projectile
) {
    sqf::hint("Weapon fired: " + std::string(weapon));
}

// Повреждение
void intercept::hit(types::object& unit, types::object& caused_by, float damage) {
    sqf::set_damage(unit, sqf::damage(unit) - damage * 0.5f);  // Снизить урон
}
```

**Подробнее:** [Обработчики событий](EVENT_HANDLERS.md)

### 4. Custom Commands

Регистрация собственных SQF функций:

```cpp
// Binary команда
game_value my_add(game_state& state, game_value_parameter left, game_value_parameter right) {
    float a = left;
    float b = right;
    return a + b;
}

void intercept::pre_init() {
    client::host::register_sqf_command(
        "myAdd",                           // Имя в SQF
        "Складывает два числа",            // Описание
        my_add,                            // Указатель на функцию
        types::game_data_type::SCALAR,     // Тип возврата
        types::game_data_type::SCALAR,     // Тип левого аргумента
        types::game_data_type::SCALAR      // Тип правого аргумента
    );
}

// В SQF: _result = 5 myAdd 10;  // 15
```

**Подробнее:** [Регистрация команд](CUSTOM_COMMANDS.md)

### 5. Custom Types

Создание пользовательских типов данных:

```cpp
class my_custom_type : public game_data {
public:
    static uintptr_t type_def;
    static uintptr_t data_type_def;
    
    int my_value;
    r_string my_name;
    
    // Переопределение виртуальных методов
    const sqf_script_type& type() const override;
    r_string to_string() const override;
    // ...
};

void intercept::pre_init() {
    auto [type_enum, script_type] = client::host::register_sqf_type(
        "MY_TYPE",
        "Мой пользовательский тип",
        "Описание",
        "MyType",
        create_my_type
    );
    
    my_custom_type::type_def = script_type->get_vtable();
}
```

**Подробнее:** [Пользовательские типы](CUSTOM_TYPES.md)

### 6. Plugin Interfaces

Взаимодействие между плагинами:

```cpp
// Plugin A - регистрация интерфейса
struct MyAPI {
    void (*do_something)(int value);
};

MyAPI api = { my_function };
client::host::register_plugin_interface("MyAPI", 1, &api);

// Plugin B - использование интерфейса
auto interface = client::host::request_plugin_interface("MyAPI", 1);
if (interface) {
    MyAPI* api = (MyAPI*)(*interface);
    api->do_something(42);
}
```

**Подробнее:** [Интерфейсы плагинов](PLUGIN_INTERFACES.md)

### 7. Threading

Безопасная работа с потоками:

```cpp
std::thread worker([]{
    // Обработка данных в фоне
    std::vector<int> data = process_heavy_task();
    
    // Добавить результат в очередь для on_frame
    {
        std::lock_guard<std::mutex> lock(queue_mutex);
        results_queue.push(data);
    }
});

void intercept::on_frame() {
    // Забрать результаты из очереди
    std::lock_guard<std::mutex> lock(queue_mutex);
    while (!results_queue.empty()) {
        auto data = results_queue.front();
        results_queue.pop();
        
        // Безопасно использовать SQF функции
        sqf::hint("Task completed");
    }
}
```

**Подробнее:** [Многопоточность](THREADING.md)

## Важные концепции

### game_state

Передаётся в функции для доступа к состоянию игры:

```cpp
game_value my_command(game_state& state, game_value_parameter arg) {
    // Получение локальных переменных
    game_value var = state.get_local_variable("_myVar");
    
    // Установка локальных переменных
    state.set_local_variable("_result", 42);
    
    // Установка ошибок
    if (/* условие ошибки */) {
        state.set_script_error(
            game_state::game_evaluator::evaluator_error_type::type,
            "Expected SCALAR"
        );
        return {};
    }
    
    return {};
}
```

### invoker_lock

Защита доступа к Invoker:

```cpp
{
    client::invoker_lock lock;
    // Безопасно вызывать SQF функции из других потоков
    sqf::hint("Protected call");
} // Автоматическая разблокировка
```

### Обработка ошибок

```cpp
// Проверка типов
game_value my_function(game_state& state, game_value_parameter arg) {
    if (!state.error_check_type(arg, types::game_data_type::SCALAR)) {
        return {};  // Ошибка уже установлена
    }
    
    float num = arg;
    return num * 2;
}

// Проверка размера массива
if (!state.error_check_size(arg, 2)) {
    return {};  // Ошибка: массив слишком мал
}
```

## Лучшие практики

### ✅ Рекомендуется

```cpp
// 1. Проверять типы аргументов
if (arg.type_enum() != types::game_data_type::SCALAR) {
    return {};
}

// 2. Использовать ссылки
void process(const game_value& val) { }

// 3. Кэшировать часто используемые значения
types::object player = sqf::player();  // Один раз
for (int i = 0; i < 100; i++) {
    // Используем кэшированный player
}

// 4. Резервировать память для массивов
auto_array<game_value> arr;
arr.reserve(1000);

// 5. Проверять на null
if (!obj.is_null()) {
    // Безопасно
}
```

### ❌ Не рекомендуется

```cpp
// 1. Вызывать SQF из других потоков без защиты
std::thread([]{ sqf::hint("BAD!"); });  // CRASH!

// 2. Множественные обращения к SQF в цикле
for (int i = 0; i < 100; i++) {
    sqf::player();  // Медленно!
}

// 3. Игнорировать проверку типов
float num = arg;  // Может быть не SCALAR!

// 4. Создавать временные объекты в циклах
for (int i = 0; i < 1000; i++) {
    game_value val = i;  // Много аллокаций
    arr.push_back(val);
}
```

## Примеры

### Hello World плагин

```cpp
#include <intercept.hpp>

int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

void intercept::post_init() {
    sqf::system_chat("Hello from RVEngine!");
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

### Обработка позиции игрока

```cpp
void intercept::on_frame() {
    static int counter = 0;
    if (++counter < 300) return;  // Каждые ~5 секунд
    counter = 0;
    
    types::object player = sqf::player();
    if (player.is_null()) return;
    
    types::vector3 pos = sqf::get_pos(player);
    std::string msg = "Position: " + 
        std::to_string(static_cast<int>(pos.x)) + ", " +
        std::to_string(static_cast<int>(pos.y));
    
    sqf::system_chat(msg);
}
```

## Документация разделов

Подробная информация по каждому модулю:

1. **[Вызов SQF команд](SQF_COMMANDS.md)** - Обёртки всех SQF функций
2. **[Жизненный цикл](LIFECYCLE.md)** - pre_init, post_init, on_frame и др.
3. **[Event Handlers](EVENT_HANDLERS.md)** - killed, fired, hit и др.
4. **[Регистрация команд](CUSTOM_COMMANDS.md)** - Создание своих SQF функций
5. **[Пользовательские типы](CUSTOM_TYPES.md)** - Новые типы данных
6. **[Plugin Interfaces](PLUGIN_INTERFACES.md)** - Межплагинное взаимодействие
7. **[Threading](THREADING.md)** - Многопоточность и безопасность

## Следующие шаги

После изучения API рекомендуется:

1. [Примеры использования](../Examples/README.md) - Практические примеры
2. [Система типов](../Types/README.md) - Детальное изучение типов
3. [Справочные материалы](../Reference/README.md) - Макросы, отладка, лучшие практики

---

**Важно:** Весь код должен выполняться быстро, чтобы не вызывать просадки FPS. Избегайте тяжёлых операций в `on_frame()`.

