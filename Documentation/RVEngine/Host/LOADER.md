# Loader - Система загрузки

Loader сканирует память процесса Arma 3 для поиска указателей на нативные SQF функции.

## Процесс загрузки

1. RVEngine загружается как extension
2. Loader запускает сканирование памяти
3. Использует байтовые сигнатуры для поиска функций
4. Строит таблицу указателей на ~3000+ функций
5. Предоставляет указатели Invoker для вызовов

## Основные классы

### loader

Главный класс загрузчика в `src/host/loader/loader.hpp`:

```cpp
class loader {
public:
    bool get_function(std::string_view name, 
                      unary_function& function,
                      const std::string_view right_arg_type);
    
    bool get_function(std::string_view name,
                      binary_function& function,
                      const std::string_view left_arg_type,
                      const std::string_view right_arg_type);
    
    bool get_function(std::string_view name,
                      nular_function& function);
};
```

### CommandScan

Сканер команд в `src/host/loader/CommandScan.hpp`:

```cpp
class CommandScan {
public:
    void scanCommands();
    void findCommands();
    // Поиск функций по сигнатурам
};
```

## Сигнатуры

Loader использует уникальные байтовые паттерны для идентификации функций:

```cpp
// Пример сигнатуры (упрощённо)
const uint8_t pattern[] = {
    0x48, 0x89, 0x5C, 0x24, 0x08,  // mov [rsp+8], rbx
    0x57,                          // push rdi
    0x48, 0x83, 0xEC, 0x20         // sub rsp, 20h
};
```

## MemorySection

Работа с секциями памяти в `src/host/loader/MemorySection.hpp`:

```cpp
class MemorySection {
public:
    void* start_address;
    size_t size;
    
    bool contains(void* address);
    // Сканирование секции
};
```

## Процесс сканирования

```
1. Получить список секций памяти процесса
2. Для каждой секции:
   - Проверить права доступа (читаемая, исполняемая)
   - Сканировать на наличие сигнатур
   - При нахождении - извлечь указатель на функцию
3. Сохранить указатели в таблице
4. Предоставить доступ через get_function()
```

## Типы функций

### Nular Functions

```cpp
using nular_function = game_value (*)(game_state&);

// Пример
game_value player_func(game_state& state) {
    // Возвращает объект игрока
}
```

### Unary Functions

```cpp
using unary_function = game_value (*)(game_state&, game_value_parameter);

// Пример
game_value name_func(game_state& state, game_value_parameter unit) {
    // Возвращает имя юнита
}
```

### Binary Functions

```cpp
using binary_function = game_value (*)(game_state&, 
                                         game_value_parameter,
                                         game_value_parameter);

// Пример  
game_value setPos_func(game_state& state, 
                       game_value_parameter unit,
                       game_value_parameter position) {
    // Устанавливает позицию
}
```

## Совместимость с версиями

Loader поддерживает разные версии Arma 3 через:

- Множественные сигнатуры для одной функции
- Версионные проверки
- Fallback механизмы

```cpp
// CommandScan214.cpp - специфичные сигнатуры для версии 2.14
```

---

[Host README](README.md) | [Invoker](INVOKER.md)

