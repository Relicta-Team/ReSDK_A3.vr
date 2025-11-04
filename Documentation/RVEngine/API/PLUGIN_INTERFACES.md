# Интерфейсы плагинов

Система интерфейсов позволяет плагинам взаимодействовать друг с другом.

## Регистрация интерфейса

### Plugin A - предоставляет интерфейс

```cpp
// Определение интерфейса
struct MyPluginAPI {
    void (*do_something)(int value);
    int (*get_data)(const char* name);
};

// Реализация функций
void do_something_impl(int value) {
    sqf::hint("Value: " + std::to_string(value));
}

int get_data_impl(const char* name) {
    return 42;
}

// Создание экземпляра API
MyPluginAPI g_api = {
    do_something_impl,
    get_data_impl
};

// Регистрация
void intercept::register_interfaces() {
    auto result = client::host::register_plugin_interface(
        "MyPlugin",     // Имя интерфейса
        1,              // Версия API
        &g_api          // Указатель на интерфейс
    );
    
    if (result == register_plugin_interface_result::success) {
        sqf::system_chat("Interface registered");
    }
}
```

## Использование интерфейса

### Plugin B - использует интерфейс

```cpp
void intercept::post_init() {
    // Запрос интерфейса
    auto interface = client::host::request_plugin_interface("MyPlugin", 1);
    
    if (interface) {
        // Приведение к типу
        MyPluginAPI* api = static_cast<MyPluginAPI*>(*interface);
        
        // Использование
        api->do_something(100);
        int data = api->get_data("test");
        
        sqf::system_chat("Got data: " + std::to_string(data));
    } else {
        sqf::hint("MyPlugin interface not found");
    }
}
```

## Список интерфейсов

```cpp
auto [module_name, versions] = client::host::list_plugin_interfaces("MyPlugin");

// module_name - имя модуля, зарегистрировавшего интерфейс
// versions - auto_array<uint32_t> доступных версий

for (uint32_t version : versions) {
    std::cout << "Version: " << version << std::endl;
}
```

## Результаты регистрации

```cpp
enum class register_plugin_interface_result {
    success,                                      // Успешно
    interface_already_registered,                 // Уже зарегистрирован
    interface_name_occupied_by_other_module,      // Имя занято
    invalid_interface_class                       // Неверный класс
};
```

## Версионирование

```cpp
// Plugin A - версия 1
struct MyAPI_v1 {
    void (*func1)();
};

// Plugin A - версия 2 (добавлена func2)
struct MyAPI_v2 {
    void (*func1)();
    void (*func2)(int arg);
};

void intercept::register_interfaces() {
    client::host::register_plugin_interface("MyAPI", 1, &api_v1);
    client::host::register_plugin_interface("MyAPI", 2, &api_v2);
}

// Plugin B - может запросить нужную версию
auto api_v1 = client::host::request_plugin_interface("MyAPI", 1);
auto api_v2 = client::host::request_plugin_interface("MyAPI", 2);
```

---

[API README](README.md) | [Threading](THREADING.md) | [Custom Types](CUSTOM_TYPES.md)

