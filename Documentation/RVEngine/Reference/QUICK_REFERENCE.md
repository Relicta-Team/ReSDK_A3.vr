# Краткий справочник API

Быстрый доступ к наиболее используемым методам и полям.

## game_value

### Публичное поле data

```cpp
class game_value {
public:
    ref<game_data> data;  // Прямой доступ к данным
};
```

**Использование:**

```cpp
game_value val = 42.0f;

// Доступ к ref<game_data>
ref<game_data>& data_ref = val.data;

// Проверка
if (val.data) { /* не null */ }
if (val.data.is_null()) { /* null */ }

// Методы через ->
val.data->to_string();
val.data->type_as_string();
val.data->get_hash();

// Замена данных
val.data = new game_data_string("test");

// Очистка
val.data.free();
val.data = nullptr;
val.clear();  // Удобный метод
```

### Метод get_as<T>()

Получение типизированного `ref<T>`:

```cpp
// Сигнатура
template<class T>
ref<T> get_as();

template<class T>
const ref<T> get_as() const;
```

**Использование:**

```cpp
game_value val = 42.0f;

// Получить типизированный указатель
ref<game_data_number> num = val.get_as<game_data_number>();

if (num) {
    num->number = 100.0f;  // Модификация
}

// Для всех типов
val.get_as<game_data_number>();      // Числа
val.get_as<game_data_string>();      // Строки
val.get_as<game_data_array>();       // Массивы
val.get_as<game_data_object>();      // Объекты
val.get_as<game_data_code>();        // Код
val.get_as<game_data_hashmap>();     // Хэш-карты
// ... и другие
```

**⚠️ Важно**: НЕ проверяет тип автоматически! Всегда проверяйте результат:

```cpp
// ✅ Правильно
auto num = val.get_as<game_data_number>();
if (num) {
    float value = num->number;
}

// ❌ Опасно
float value = val.get_as<game_data_number>()->number;  // Может быть nullptr!
```

### Другие методы доступа

```cpp
// Удобные методы для частых типов
auto_array<game_value>& to_array() const;    // Для ARRAY
rv_hashmap& to_hashmap() const;               // Для HASHMAP

// Доступ по индексу (только для ARRAY)
game_value& operator[](size_t i) const;
std::optional<game_value> get(size_t i) const;  // Безопасный доступ
```

## ref<T>

### Методы доступа к указателю

```cpp
ref<game_data> data = new game_data_number(42);

// Получить сырой указатель
Type* ptr = data.get();              // ✅ Рекомендуется
Type* ptr = data.getRef();           // ❌ Deprecated

// Оператор ->
data->to_string();
data->get_hash();

// Неявная конвертация
Type* raw = data;  // operator Type*()
```

### Методы проверки

```cpp
// Проверка на null
if (data.is_null()) { /* null */ }
if (data) { /* не null */ }
if (!data) { /* null */ }

// Счётчик ссылок
size_t count = data.ref_count();
```

### Методы управления

```cpp
// Освобождение
data.free();  // release() + установка в nullptr

// Обмен
ref<game_data> other;
data.swap(other);
```

## Таблица методов

### ref<T> методы

| Метод | Возврат | Описание |
|-------|---------|----------|
| `get()` | `T*` | Получить сырой указатель |
| `getRef()` | `T*` | ❌ Deprecated, используйте `get()` |
| `operator->()` | `T*` | Доступ к членам |
| `operator T*()` | `T*` | Неявная конвертация |
| `is_null()` | `bool` | Проверка на nullptr |
| `operator bool()` | `bool` | Неявная проверка (!= nullptr) |
| `ref_count()` | `size_t` | Счётчик ссылок |
| `free()` | `void` | Освободить и установить nullptr |
| `swap(ref&)` | `void` | Обменять содержимое |

### game_value методы доступа к данным

| Метод | Возврат | Описание |
|-------|---------|----------|
| `get_as<T>()` | `ref<T>` | Типизированный ref, проверка вручную |
| `data` (поле) | `ref<game_data>` | Прямой доступ к ref |
| `data.get()` | `game_data*` | Сырой указатель на данные |
| `to_array()` | `auto_array<game_value>&` | Ссылка на массив (только ARRAY) |
| `to_hashmap()` | `rv_hashmap&` | Ссылка на хэш-карту (только HASHMAP) |
| `operator[](i)` | `game_value&` | Элемент массива (только ARRAY) |
| `get(i)` | `optional<game_value>` | Безопасный доступ к элементу |

## Примеры использования

### Пример 1: Чтение данных

```cpp
game_value val = 42.0f;

// Способ 1: Через get_as<>
auto num = val.get_as<game_data_number>();
if (num) {
    float value = num->number;
}

// Способ 2: Через data.get()
if (auto* raw = val.data.get()) {
    if (auto* num = static_cast<game_data_number*>(raw)) {
        float value = num->number;
    }
}

// Способ 3: Через операторы конвертации (проще!)
float value = val;  // Автоматическая конвертация
```

### Пример 2: Модификация данных

```cpp
game_value val = 42.0f;

// Модификация через get_as<>
auto num = val.get_as<game_data_number>();
if (num) {
    num->number = 100.0f;
}

// Проверка
float new_value = val;  // 100.0
```

### Пример 3: Замена типа

```cpp
game_value val = 42.0f;

// Полная замена данных
val.data = new game_data_string("Hello");

// Теперь тип изменился
std::string str = val;  // "Hello"
```

### Пример 4: Работа с массивами

```cpp
game_value arr = std::vector{1, 2, 3};

// Через get_as<>
auto arr_data = arr.get_as<game_data_array>();
if (arr_data) {
    arr_data->data.push_back(4);
}

// Или проще через to_array()
auto& array_ref = arr.to_array();
array_ref.push_back(5);
```

## Рекомендации

### ✅ Предпочитайте

1. `data.get()` вместо `data.getRef()`
2. `get_as<T>()` для типизированного доступа
3. `to_array()` / `to_hashmap()` для массивов/карт
4. Проверку `if (ref)` вместо `if (!ref.is_null())`

### ⚠️ Осторожно

1. `get_as<T>()` НЕ проверяет тип - всегда проверяйте результат
2. `data.get()` возвращает сырой указатель - не храните без `ref<>`
3. При замене `val.data` старые данные автоматически освобождаются

### ❌ Избегайте

1. `getRef()` - deprecated, используйте `get()`
2. Сырые указатели без проверок на null
3. Прямое `static_cast` без проверки типа

---

[Reference README](README.md) | [Memory Management](MEMORY_MANAGEMENT.md) | [game_value](../Types/GAME_VALUE.md)

