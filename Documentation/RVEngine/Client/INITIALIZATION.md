# Инициализация клиента

## Точка входа

```cpp
extern "C" {
    DLLEXPORT void CDECL assign_functions(
        const client_functions funcs,
        r_string module_name
    );
}
```

Вызывается Host при загрузке. Реализация в `client.cpp`:

```cpp
void assign_functions(const client_functions funcs, r_string module_name) {
    intercept::client::host::functions = funcs;
    intercept::client::host::module_name = module_name;
    intercept::client::__initialize();
}
```

## __initialize()

Внутренняя инициализация client библиотеки:

```cpp
void __initialize() {
    // Инициализация vtable для game_value
    __internal::set_game_value_vtable(/* ... */);
    
    // Инициализация типов
    // Подготовка SQF обёрток
}
```

## Минимальный плагин

```cpp
#include <intercept.hpp>

int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

---

[Client README](README.md) | [Host Interface](HOST_INTERFACE.md)

