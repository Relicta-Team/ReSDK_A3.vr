# Взаимодействие с Host

Client взаимодействует с Host через `client::host` namespace.

## client::host

```cpp
namespace intercept::client::host {
    extern client_functions functions;  // Указатели на Host функции
    extern r_string module_name;        // Имя плагина
    
    // Регистрация команд
    registered_sqf_function register_sqf_command(/* ... */);
    
    // Регистрация типов
    std::pair<game_data_type, sqf_script_type*> register_sqf_type(/* ... */);
    sqf_script_type* register_compound_sqf_type(/* ... */);
    
    // Plugin interfaces
    register_plugin_interface_result register_plugin_interface(/* ... */);
    std::pair<r_string, auto_array<uint32_t>> list_plugin_interfaces(/* ... */);
    std::optional<void*> request_plugin_interface(/* ... */);
}
```

## client_functions

Структура с указателями на Host функции:

```cpp
struct client_functions {
    // Вызов SQF
    game_value (*invoke_nular)(nular_function);
    game_value (*invoke_unary)(unary_function, game_value_parameter);
    game_value (*invoke_binary)(binary_function, game_value_parameter, game_value_parameter);
    
    // Регистрация
    registered_sqf_function (*register_sqf_function)(/* ... */);
    
    // ... другие функции
};
```

## Использование

```cpp
void intercept::pre_init() {
    // Через client::host вызываются Host функции
    client::host::register_sqf_command(
        "myCommand",
        "Description",
        my_function,
        game_data_type::SCALAR
    );
}
```

---

[Client README](README.md) | [Initialization](INITIALIZATION.md)

