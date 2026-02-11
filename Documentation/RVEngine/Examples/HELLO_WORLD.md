# Hello World - Простейший плагин

Создание минимального плагина, выводящего сообщение при загрузке.

## main.cpp

```cpp
#include <intercept.hpp>

using namespace intercept;

// ОБЯЗАТЕЛЬНАЯ функция
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}

// Вызывается после инициализации миссии
void intercept::post_init() {
    sqf::system_chat("Hello from RVEngine!");
    sqf::hint("Plugin loaded successfully");
}

// DLL entry point
BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved) {
    return TRUE;
}
```

## CMakeLists.txt

```cmake
cmake_minimum_required(VERSION 3.8)
project(hello_world)

set(CMAKE_CXX_STANDARD 17)
set(INTERCEPT_PATH "path/to/intercept" CACHE PATH "Path to intercept")

find_package(intercept REQUIRED PATHS "${INTERCEPT_PATH}/build")

add_library(hello_world SHARED main.cpp)
target_link_libraries(hello_world PRIVATE intercept::client)

set_target_properties(hello_world PROPERTIES
    OUTPUT_NAME "hello_world_x64"
    PREFIX ""
    SUFFIX ".dll"
)
```

## Сборка

```bash
cmake -B build -G "Visual Studio 17 2022" -A x64 -DINTERCEPT_PATH="path/to/intercept"
cmake --build build --config Release
```

## Установка

```
Arma 3/@YourMod/
├── intercept_x64.dll
└── intercept/
    └── hello_world_x64.dll
```

## Тестирование

1. Запустить Arma 3 с модом
2. Открыть редактор
3. Поместить юнит игрока
4. Preview
5. Увидеть сообщение "Hello from RVEngine!"

---

[Examples](README.md) | [Custom Command](CUSTOM_COMMAND.md)

