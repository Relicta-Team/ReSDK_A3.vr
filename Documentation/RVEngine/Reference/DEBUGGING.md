# Отладка плагинов

## Visual Studio Debugger

### Настройка

1. Project Properties → Debugging
2. Command: `C:\...\Arma 3\arma3_x64.exe`
3. Command Arguments: `"-mod=@YourMod" -window`
4. Working Directory: `C:\...\Arma 3\`

### Использование

```cpp
// Breakpoints
void intercept::on_frame() {
    int x = 42;  // ← Поставить breakpoint
    sqf::hint(std::to_string(x));
}
```

Нажать F5 для запуска с отладчиком.

## Логирование

### В файл

```cpp
#include <fstream>

std::ofstream log_file("plugin_log.txt", std::ios::app);

void log(const std::string& msg) {
    log_file << msg << std::endl;
    log_file.flush();
}

void intercept::on_frame() {
    log("Frame executed");
}
```

### В SQF

```cpp
sqf::diag_log("Debug message from C++");
sqf::system_chat("Info message");
sqf::hint("Important info");
```

## Проверка типов

```cpp
void debug_value(const game_value& val) {
    if (val.data) {
        auto type = val.type_enum();
        auto type_str = val.data->type_as_string();
        auto value_str = val.data->to_string();
        
        log("Type: " + std::string(type_str));
        log("Value: " + std::string(value_str));
    } else {
        log("Value is nil");
    }
}
```

## ArmaDebugEngine

Интеграция с ArmaDebugEngine для просмотра переменных:

```cpp
class I_debug_value {
    virtual void getTypeStr(char* buffer, int len) const = 0;
    virtual void getValue(unsigned int base, char* buffer, int len) const = 0;
};
```

## Dependency Walker

Проверка зависимостей DLL:
1. Открыть plugin_x64.dll в Dependency Walker
2. Проверить отсутствующие зависимости
3. Убедиться, что DLL x64

## Performance Profiling

```cpp
#include <chrono>

void intercept::on_frame() {
    auto start = std::chrono::high_resolution_clock::now();
    
    // Ваш код
    heavy_function();
    
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    
    if (duration.count() > 1000) {  // > 1ms
        log("Warning: slow function " + std::to_string(duration.count()) + " μs");
    }
}
```

---

[Reference](README.md) | [Best Practices](BEST_PRACTICES.md)

