# Макросы

## INTERCEPT_SDK_API_VERSION

Текущая версия API:

```cpp
int intercept::api_version() {
    return INTERCEPT_SDK_API_VERSION;
}
```

## DLLEXPORT / CDECL

Экспорт функций:

```cpp
extern "C" {
    DLLEXPORT int CDECL api_version();
}

// Раскрывается в:
// extern "C" __declspec(dllexport) int __cdecl api_version();
```

## RV_GENERIC_OBJECT_DEC

Создание клиентских типов:

```cpp
RV_GENERIC_OBJECT_DEC(object);

// Раскрывается в:
class object : public internal_object {
public:
    object();
    object(const game_value& value);
    object(const object& copy);
    object(object&& move);
    object& operator=(object&& move);
    object& operator=(const object& copy);
};
```

---

[Reference](README.md) | [Memory Management](MEMORY_MANAGEMENT.md)

