# Extensions - Загрузка плагинов

Extensions отвечает за поиск, загрузку и управление клиентскими DLL плагинами.

## Основные функции

В `src/host/extensions/extensions.hpp`:

```cpp
// Поиск расширений
void search_extensions(const std::string& path);

// Загрузка расширения
bool load_extension(const std::string& path);

// Выгрузка расширения
void unload_extension(const std::string& module_name);
```

## Процесс загрузки

```
1. Поиск DLL файлов в папке intercept/
2. LoadLibrary(dll_path)
3. GetProcAddress("api_version")
4. Проверка версии API
5. GetProcAddress("assign_functions")
6. Вызов assign_functions(client_functions, module_name)
7. Поиск lifecycle хуков (pre_init, post_init и т.д.)
8. Регистрация клиента в Controller
```

## Экспортируемые функции

Клиент должен экспортировать:

```cpp
// ОБЯЗАТЕЛЬНАЯ
DLLEXPORT int CDECL api_version();

// ОБЯЗАТЕЛЬНАЯ (вызывается Host)
DLLEXPORT void CDECL assign_functions(
    const client_functions funcs,
    r_string module_name
);

// Опциональные lifecycle хуки
DLLEXPORT void CDECL pre_start();
DLLEXPORT void CDECL post_start();
DLLEXPORT void CDECL pre_init();
DLLEXPORT void CDECL post_init();
DLLEXPORT void CDECL on_frame();
DLLEXPORT void CDECL mission_ended();
// ... и другие
```

## Структура папок

```
Arma 3/
└── @YourMod/
    ├── intercept_x64.dll         ← Host
    └── intercept/                ← Папка для плагинов
        ├── plugin1_x64.dll
        ├── plugin2_x64.dll
        └── plugin3_x64.dll
```

## Передача API

```cpp
// Host создаёт структуру с указателями
client_functions funcs;
funcs.invoke_nular = &invoker::invoke_nular;
funcs.invoke_unary = &invoker::invoke_unary;
funcs.register_sqf_function = &sqf_functions::register_sqf_function;
// ... другие функции

// Вызывает у клиента
client.assign_functions(funcs, "plugin_name");

// Клиент сохраняет
namespace intercept::client::host {
    client_functions functions = funcs;
    r_string module_name = "plugin_name";
}
```

## Проверка версии

```cpp
int client_version = client.api_version();
int host_version = INTERCEPT_SDK_API_VERSION;

if (client_version != host_version) {
    // Несовместимые версии!
    log_error("Version mismatch");
    unload_extension(dll_path);
}
```

---

[Host README](README.md) | [Loader](LOADER.md)

