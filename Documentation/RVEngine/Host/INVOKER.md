# Invoker - Система вызовов

Invoker предоставляет механизм для безопасного вызова нативных SQF функций из C++.

## Основной класс

В `src/host/invoker/invoker.hpp`:

```cpp
class invoker {
public:
    // Вызов nular функций
    static game_value invoke_nular(nular_function function,
                                    game_state& state);
    
    // Вызов unary функций
    static game_value invoke_unary(unary_function function,
                                    game_state& state,
                                    game_value_parameter arg);
    
    // Вызов binary функций
    static game_value invoke_binary(binary_function function,
                                     game_state& state,
                                     game_value_parameter left,
                                     game_value_parameter right);
};
```

## Потокобезопасность

Invoker использует блокировки для защиты:

```cpp
class invoker_lock {
public:
    explicit invoker_lock(bool delayed = false);
    ~invoker_lock();
    
    void lock();
    void unlock();
    
private:
    bool _locked;
};
```

### Использование

```cpp
// Автоматическая блокировка
{
    invoker_lock lock;
    game_value result = invoker::invoke_nular(func, state);
} // Автоматическая разблокировка

// Отложенная блокировка
invoker_lock lock(true);
// ... подготовка ...
lock.lock();
// ... вызовы ...
lock.unlock();
```

## sqf_functions

Обёртка над Invoker в `src/host/invoker/sqf_functions.hpp`:

```cpp
class sqf_functions {
public:
    // Регистрация пользовательских функций
    registered_sqf_function register_sqf_function(
        std::string_view name,
        std::string_view description,
        WrapperFunctionBinary function,
        game_data_type return_type,
        game_data_type left_type,
        game_data_type right_type
    );
    
    // ... для unary и nular
};
```

## Процесс вызова

```
1. Client вызывает sqf::function_name(args)
2. sqf:: обёртка вызывает client_functions.invoke_*
3. Через указатель вызывается invoker::invoke_*
4. invoker блокирует mutex
5. Вызывается нативная функция движка
6. Результат возвращается клиенту
7. invoker разблокирует mutex
```

## Регистрация команд

```cpp
// Пользовательская функция
game_value my_function(game_state& state, 
                       game_value_parameter arg) {
    return arg;
}

// Регистрация
auto handle = sqf_functions::get().register_sqf_function(
    "myCommand",
    "Description",
    my_function,
    game_data_type::SCALAR,
    game_data_type::SCALAR
);
```

## client_functions

Структура передаваемая клиентам:

```cpp
struct client_functions {
    // Вызов функций
    game_value (*invoke_nular)(nular_function);
    game_value (*invoke_unary)(unary_function, game_value_parameter);
    game_value (*invoke_binary)(binary_function, game_value_parameter, game_value_parameter);
    
    // Регистрация
    registered_sqf_function (*register_sqf_function)(/* ... */);
    
    // ... другие функции
};
```

---

[Host README](README.md) | [Controller](CONTROLLER.md)

