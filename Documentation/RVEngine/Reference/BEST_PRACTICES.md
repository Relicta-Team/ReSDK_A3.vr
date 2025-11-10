# Лучшие практики

## Производительность

### ✅ Рекомендуется

```cpp
// Кэшировать часто используемые значения
types::object player = sqf::player();  // Один раз
for (int i = 0; i < 100; i++) {
    // Использовать кэшированное значение
}

// Резервировать память
auto_array<game_value> arr;
arr.reserve(1000);

// Использовать ссылки
void process(const game_value& val) { }

// Move semantics
game_value create() {
    return game_value(42);
}
```

### ❌ Не рекомендуется

```cpp
// Множественные вызовы в цикле
for (int i = 0; i < 100; i++) {
    sqf::player();  // Медленно!
}

// Копирование по значению
void process(game_value val) { }

// Множественные реаллокации
for (int i = 0; i < 1000; i++) {
    arr.push_back(i);  // Много реаллокаций
}
```

## Потокобезопасность

### ✅ Правильно

```cpp
std::thread([]{
    auto result = compute();  // Безопасно
    
    {
        std::lock_guard<std::mutex> lock(g_mutex);
        g_queue.push(result);
    }
}).detach();

void intercept::on_frame() {
    std::lock_guard<std::mutex> lock(g_mutex);
    while (!g_queue.empty()) {
        auto result = g_queue.front();
        g_queue.pop();
        sqf::hint("Done");  // Безопасно
    }
}
```

### ❌ Неправильно

```cpp
std::thread([]{
    sqf::hint("BAD!");  // CRASH!
}).detach();
```

## Проверка данных

### ✅ Всегда проверяйте

```cpp
// Типы
if (!state.error_check_type(arg, types::game_data_type::SCALAR)) {
    return {};
}

// Null
if (obj.is_null()) {
    return {};
}

// Размер массива
if (!state.error_check_size(arr, 2)) {
    return {};
}
```

## Управление памятью

### ✅ Используйте ref<>

```cpp
ref<game_data> data = new game_data_number(42);
// Автоматическое управление
```

### ❌ Избегайте сырых указателей

```cpp
game_data* data = new game_data_number(42);
// Нужно вручную delete!
```

## on_frame()

### ✅ Лёгкая логика

```cpp
void intercept::on_frame() {
    static int counter = 0;
    if (++counter < 300) return;  // Раз в ~5 сек
    counter = 0;
    
    // Лёгкая операция
    check_player_position();
}
```

### ❌ Тяжёлые операции

```cpp
void intercept::on_frame() {
    // Это выполняется 60 раз в секунду!
    for (int i = 0; i < 10000; i++) {
        heavy_computation();  // Плохо!
    }
}
```

## Структура кода

### Организация

```cpp
// Хорошо: разделение на модули
namespace my_plugin {
    namespace commands {
        game_value my_command(/* ... */) { }
    }
    
    namespace events {
        void on_killed(/* ... */) { }
    }
    
    namespace utils {
        void log(const std::string& msg) { }
    }
}
```

### Инициализация

```cpp
// Регистрация в pre_init
void intercept::pre_init() {
    register_commands();
    register_types();
}

// Данные в post_init
void intercept::post_init() {
    g_player = sqf::player();
    initialize_systems();
}
```

## Документация

```cpp
/**
 * @brief Удваивает число
 * @param state Состояние игры
 * @param arg Число для удвоения
 * @return Удвоенное число
 */
game_value double_number(game_state& state, game_value_parameter arg) {
    if (!state.error_check_type(arg, types::game_data_type::SCALAR)) {
        return {};
    }
    
    float num = arg;
    return num * 2;
}
```

## Тестирование

### Unit тесты

```cpp
void test_my_function() {
    game_value input = 21;
    game_value result = my_function(input);
    
    assert(static_cast<float>(result) == 42);
}

void intercept::post_init() {
    test_my_function();
    sqf::system_chat("Tests passed");
}
```

## Заключение

Следование этим практикам обеспечит:
- ✅ Высокую производительность
- ✅ Стабильность
- ✅ Удобство поддержки
- ✅ Безопасность

---

[Reference](README.md) | [Examples](../Examples/README.md) | [Main README](../README.md)

