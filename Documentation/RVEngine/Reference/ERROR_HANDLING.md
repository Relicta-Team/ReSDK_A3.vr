# Обработка ошибок

## Проверка типов

### game_state::error_check_type

```cpp
game_value my_function(game_state& state, game_value_parameter arg) {
    if (!state.error_check_type(arg, types::game_data_type::SCALAR)) {
        return {};  // Ошибка уже установлена
    }
    
    float num = arg;
    return num * 2;
}
```

### game_state::error_check_size

```cpp
if (!state.error_check_size(arg, 2)) {
    return {};  // "2 elements provided, N expected"
}
```

## Установка ошибок

### set_script_error

```cpp
state.set_script_error(
    game_state::game_evaluator::evaluator_error_type::type,
    "Expected SCALAR"
);
```

### Типы ошибок

```cpp
enum class evaluator_error_type {
    ok,                    // Нет ошибки
    gen,                   // Общая ошибка
    type,                  // Неверный тип
    dim,                   // Неверный размер массива
    div_zero,              // Деление на ноль
    foreign,               // Внешняя ошибка
    // ... другие
};
```

## Исключения

### game_value_conversion_error

```cpp
try {
    float num = game_value("not a number");
} catch (const game_value_conversion_error& e) {
    std::cerr << e.what() << std::endl;
}
```

## Безопасные паттерны

```cpp
// Проверка перед конвертацией
if (val.type_enum() == types::game_data_type::SCALAR) {
    float num = val;  // Безопасно
}

// Проверка на null
if (!obj.is_null()) {
    // Безопасно работать с объектом
}

// Optional возврат
std::optional<game_value> safe_get(const game_value& arr, size_t index) {
    if (arr.type_enum() != types::game_data_type::ARRAY) return std::nullopt;
    if (index >= arr.size()) return std::nullopt;
    return arr[index];
}
```

---

[Reference](README.md) | [Debugging](DEBUGGING.md)

