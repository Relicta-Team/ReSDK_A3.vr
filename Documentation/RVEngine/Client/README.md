# Client - Клиентская библиотека

Client (`intercept_client.lib`) — статическая библиотека для разработки плагинов.

## Структура

```
src/client/
├── headers/            ← Заголовочные файлы
│   ├── intercept.hpp  ← Главный include
│   ├── shared/        ← Типы данных
│   └── client/        ← Client API
│       └── sqf/       ← SQF обёртки
└── intercept/         ← Реализация
    ├── client/        ← Client логика
    └── shared/        ← Общий код
```

## Главный заголовок

```cpp
#include <intercept.hpp>  // Всё что нужно
```

Включает:
- `shared.hpp` - Базовые типы
- `client/client.hpp` - Client API
- `client/sqf/sqf.hpp` - SQF функции
- `shared/types.hpp` - Типы данных

## Линковка

В CMake:

```cmake
target_link_libraries(your_plugin PRIVATE intercept::client)
```

---

[Initialization](INITIALIZATION.md) | [Host Interface](HOST_INTERFACE.md)

