# Контейнеры RVEngine

Этот документ описывает специализированные контейнеры, используемые в RVEngine для эффективной работы с данными движка.

## Обзор

RVEngine предоставляет три основных контейнера:

1. **auto_array<T>** - динамический массив с аллокатором движка
2. **r_string** - строка с подсчётом ссылок
3. **rv_hashmap** - хэш-карта для пар ключ-значение

## auto_array<T>

Динамический массив, совместимый с аллокаторами движка.

### Определение

```cpp
template<class Type, class Allocator = rv_allocator<Type>>
class auto_array {
    Type* _data;
    size_t _size;
    size_t _capacity;
    Allocator _allocator;
public:
    // STL-совместимый интерфейс
};
```

### Создание и инициализация

```cpp
// Пустой массив
auto_array<int> arr1;

// С начальным размером
auto_array<float> arr2(10);  // 10 элементов

// Из итераторов
std::vector<int> vec = {1, 2, 3};
auto_array<int> arr3(vec.begin(), vec.end());

// Копирование
auto_array<int> arr4 = arr3;

// Перемещение
auto_array<int> arr5 = std::move(arr3);
```

### Основные операции

```cpp
auto_array<int> arr;

// Добавление элементов
arr.push_back(1);
arr.push_back(2);
arr.push_back(3);

// Резервирование памяти
arr.reserve(100);

// Изменение размера
arr.resize(50);

// Доступ по индексу
int first = arr[0];
int second = arr.at(1);  // С проверкой границ

// Размер и ёмкость
size_t size = arr.size();
size_t capacity = arr.capacity();
bool empty = arr.empty();

// Очистка
arr.clear();

// Удаление последнего
arr.pop_back();

// Вставка
arr.insert(arr.begin() + 1, 42);

// Удаление
arr.erase(arr.begin());
arr.erase(arr.begin(), arr.begin() + 3);
```

### Итерация

```cpp
auto_array<int> arr = {1, 2, 3, 4, 5};

// Range-based for
for (auto& element : arr) {
    std::cout << element << std::endl;
}

// Итераторы
for (auto it = arr.begin(); it != arr.end(); ++it) {
    std::cout << *it << std::endl;
}

// Обратные итераторы
for (auto it = arr.rbegin(); it != arr.rend(); ++it) {
    std::cout << *it << std::endl;
}
```

### Аллокаторы

```cpp
// Стандартный аллокатор движка
auto_array<int, rv_allocator<int>> arr1;

// Локальный аллокатор с буфером
auto_array<int, rv_allocator_local<int, 64>> arr2;
```

### Использование с game_value

```cpp
// auto_array<game_value> - основной тип для массивов
auto_array<game_value> arr;
arr.push_back(1);
arr.push_back("test");
arr.push_back(true);

// Получение из game_value
game_value val = std::vector{1, 2, 3};
auto_array<game_value>& arr_ref = val.to_array();

// Модификация
arr_ref.push_back(4);
arr_ref[0] = 100;
```

## r_string

Строка с подсчётом ссылок, совместимая с движком.

### Определение

```cpp
class r_string {
    compact_array<char> _ref;  // Внутреннее представление
public:
    // Конструкторы, операторы...
};
```

### Создание

```cpp
// Пустая строка
r_string str1;

// Из C-строки
r_string str2 = "Hello";

// Из std::string
std::string std_str = "World";
r_string str3 = std_str;

// Из string_view
std::string_view sv = "Test";
r_string str4 = sv;

// Копирование (дешёвое, использует refcount)
r_string str5 = str2;
```

### Основные операции

```cpp
r_string str = "Hello World";

// Размер
size_t len = str.length();
size_t size = str.size();
bool empty = str.empty();

// Доступ к символам
char first = str[0];
char last = str[str.size() - 1];

// Сравнение
if (str == "Hello World") { /*...*/ }
if (str != "Other") { /*...*/ }
if (str < "ZZZ") { /*...*/ }

// Очистка
str.clear();

// Конкатенация (через std::string)
std::string result = std::string(str) + " Additional";
r_string new_str = result;
```

### Конвертация

```cpp
r_string r_str = "Test";

// В std::string
std::string std_str = std::string(r_str);
std::string std_str2 = r_str.operator std::string();

// В string_view
std::string_view sv = std::string_view(r_str);

// В C-строку
const char* c_str = r_str.c_str();
```

### Хэширование

```cpp
r_string str = "test";

// Получить хэш
size_t hash = str.hash();

// Использование в unordered_map
std::unordered_map<r_string, int> map;
map[str] = 42;
```

### Производительность

- **Копирование**: O(1) благодаря refcount
- **Сравнение**: O(n) где n - длина строки
- **Доступ по индексу**: O(1)
- **Хэширование**: O(n) при первом вызове, затем кэшируется

## rv_hashmap

Хэш-карта для пар ключ-значение типа game_value.

### Определение

```cpp
using rv_hashmap = internal_hashmap<
    game_data_hashmap_pair<game_value>,
    auto_array<game_data_hashmap_pair<game_value>>,
    game_data_hashmap_traits<game_value>
>;

// Пара ключ-значение
template<class Type>
struct game_data_hashmap_pair {
    Type key;
    Type value;
    
    game_data_hashmap_pair() = default;
    game_data_hashmap_pair(const Type& k_, const Type& v_) 
        : key(k_), value(v_) {}
};
```

### Создание

```cpp
// Пустая хэш-карта
rv_hashmap map;

// С начальной ёмкостью
rv_hashmap map2(100);
```

### Операции

```cpp
rv_hashmap map;

// Вставка
map.insert({game_value("key1"), game_value(42)});
map.insert({game_value("key2"), game_value("value")});

// Поиск
game_value key = "key1";
auto it = map.find(key);
if (it != map.end()) {
    game_value value = it->value;  // 42
}

// Удаление
map.remove(key);

// Проверка наличия
if (map.contains(key)) {
    // Ключ существует
}

// Размер
size_t count = map.size();
bool empty = map.empty();

// Очистка
map.clear();
```

### Итерация

```cpp
rv_hashmap map;
map.insert({game_value("key1"), game_value(1)});
map.insert({game_value("key2"), game_value(2)});

// Range-based for
for (auto& pair : map) {
    game_value key = pair.key;
    game_value value = pair.value;
    
    std::cout << std::string(key) << " = " 
              << static_cast<float>(value) << std::endl;
}

// Итераторы
for (auto it = map.begin(); it != map.end(); ++it) {
    game_value key = it->key;
    game_value value = it->value;
}
```

### Использование с game_value

```cpp
// Создание хэш-карты
rv_hashmap map;
map.insert({game_value("name"), game_value("John")});
map.insert({game_value("age"), game_value(30)});
map.insert({game_value("active"), game_value(true)});

// Обёртка в game_value
game_value map_val = map;

// Передача в SQF
sqf::set_variable(sqf::mission_namespace(), "myMap", map_val);

// Получение из SQF
game_value retrieved = sqf::get_variable(sqf::mission_namespace(), "myMap");
rv_hashmap& retrieved_map = retrieved.to_hashmap();

// Доступ к данным
auto it = retrieved_map.find(game_value("name"));
if (it != retrieved_map.end()) {
    std::string name = it->value;  // "John"
}
```

## Аллокаторы

### rv_allocator<T>

Стандартный аллокатор для работы с памятью движка:

```cpp
template<typename Type>
struct rv_allocator {
    static Type* allocate(size_t count);
    static void deallocate(Type* ptr);
    
    static Type* create_single();
    static Type* create_array(size_t count);
    
    static void destroy_deallocate(Type* ptr);
    static void destroy_deallocate_array(Type* ptr, size_t count);
};

// Использование
int* ptr = rv_allocator<int>::create_single();
*ptr = 42;
rv_allocator<int>::destroy_deallocate(ptr);
```

### rv_allocator_local<T, Size>

Аллокатор с локальным буфером:

```cpp
template<typename Type, size_t LocalSize>
class rv_allocator_local {
    // Использует стек для малых массивов
    // Переключается на heap для больших
};

// Использование
auto_array<int, rv_allocator_local<int, 64>> arr;
// Первые 64 элемента на стеке
```

### rv_pool_allocator

Pool аллокатор для часто создаваемых типов:

```cpp
class rv_pool_allocator {
public:
    void* allocate(size_t size);
    void deallocate(void* ptr);
};

// Используется в game_data типах
game_data_number::operator new(size_t sz) {
    return pool_alloc_base->allocate(sz);
}
```

## Практические примеры

### Эффективная работа с большими массивами

```cpp
// ✅ Хорошо: резервирование памяти
auto_array<game_value> create_large_array(size_t size) {
    auto_array<game_value> arr;
    arr.reserve(size);  // Одна аллокация
    
    for (size_t i = 0; i < size; i++) {
        arr.push_back(i);
    }
    
    return arr;  // Move semantics
}

// ❌ Плохо: множественные реаллокации
auto_array<game_value> create_large_array_bad(size_t size) {
    auto_array<game_value> arr;
    
    for (size_t i = 0; i < size; i++) {
        arr.push_back(i);  // Много реаллокаций!
    }
    
    return arr;
}
```

### Работа со строками

```cpp
// Создание временных строк
r_string format_message(const r_string& name, int value) {
    // Используем std::string для манипуляций
    std::string temp = std::string(name) + ": " + std::to_string(value);
    return r_string(temp);  // Одна копия
}

// Использование
r_string msg = format_message("Health", 100);
sqf::hint(msg);
```

### Построение хэш-карты из массива

```cpp
rv_hashmap array_to_map(const auto_array<game_value>& arr) {
    rv_hashmap map;
    map.reserve(arr.size() / 2);  // Предполагаем пары
    
    for (size_t i = 0; i + 1 < arr.size(); i += 2) {
        game_value key = arr[i];
        game_value value = arr[i + 1];
        map.insert({key, value});
    }
    
    return map;
}
```

## Производительность

### Сравнение контейнеров

| Операция | auto_array | std::vector | r_string | std::string |
|----------|------------|-------------|----------|-------------|
| Создание | ~10ns | ~10ns | ~10ns | ~10ns |
| Копирование малого | ~50ns | ~50ns | ~5ns (refcount) | ~50ns |
| Копирование большого | O(n) | O(n) | ~5ns (refcount) | O(n) |
| push_back | ~30ns | ~30ns | - | - |
| Доступ [] | ~5ns | ~5ns | ~5ns | ~5ns |

### Рекомендации

1. **Резервируйте память** для известных размеров:
   ```cpp
   auto_array<game_value> arr;
   arr.reserve(expected_size);
   ```

2. **Используйте move семантику**:
   ```cpp
   auto_array<game_value> arr = create_array();  // Move
   ```

3. **Избегайте частых реаллокаций**:
   ```cpp
   // Плохо
   for (int i = 0; i < 1000; i++) {
       arr.push_back(i);  // Много реаллокаций
   }
   
   // Хорошо
   arr.reserve(1000);
   for (int i = 0; i < 1000; i++) {
       arr.push_back(i);  // Одна аллокация
   }
   ```

4. **Используйте r_string для передачи**:
   ```cpp
   // Дешёвое копирование благодаря refcount
   r_string get_name() {
       static r_string name = "Player";
       return name;  // Только инкремент счётчика
   }
   ```

## Заключение

Контейнеры RVEngine обеспечивают:

- ✅ Совместимость с движком Arma 3
- ✅ Эффективное управление памятью
- ✅ STL-подобный интерфейс
- ✅ Оптимизацию для частых операций

---

**Следующие шаги:**
- [Клиентские типы](CLIENT_TYPES.md)
- [Конвертация типов](CONVERSIONS.md)
- [game_value](GAME_VALUE.md)

