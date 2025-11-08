# Инструкция по сборке и развертыванию RVEngine

Это руководство описывает процесс сборки RVEngine (Intercept) из исходного кода и развертывания собранных файлов в Arma 3.

## Содержание

- [Системные требования](#системные-требования)
- [Подготовка окружения](#подготовка-окружения)
- [Клонирование репозитория](#клонирование-репозитория)
- [Генерация проекта](#генерация-проекта)
- [Сборка проекта](#сборка-проекта)
- [Развертывание](#развертывание)
- [Рабочие процессы](#рабочие-процессы)
- [Troubleshooting](#troubleshooting)

## Системные требования

### Обязательное ПО

- **Операционная система**: Windows 10/11 (x64)
- **Visual Studio 2022** или новее
  - Выберите "Разработка классических приложений на C++" при установке
  - Убедитесь, что включены MSVC компилятор и Windows SDK
- **CMake** версии 3.8 или выше
  - Скачать: https://cmake.org/download/
  - При установке выберите "Add CMake to system PATH"
- **Git** для работы с репозиторием

### Рекомендуемое ПО

- **Visual Studio Code** с расширением CMake Tools (опционально)
- **Ninja Build System** для более быстрой сборки (опционально)

### Дисковое пространство

- Исходный код: ~50 МБ
- Сгенерированные файлы проекта: ~200 МБ
- Собранные бинарники (Debug + Release): ~100 МБ

## Подготовка окружения

### Проверка установки CMake

Откройте командную строку и выполните:

```bash
cmake --version
```

Вы должны увидеть версию CMake (не ниже 3.8):

```
cmake version 3.27.0
```

### Проверка Visual Studio

Убедитесь, что установлен компилятор MSVC:

```bash
cl
```

Если команда не найдена, запустите **Developer Command Prompt for VS 2022** из меню Пуск.

## Клонирование репозитория

### Вариант 1: HTTPS

```bash
git clone https://github.com/intercept/intercept.git
cd intercept
```

### Вариант 2: SSH

```bash
git clone git@github.com:intercept/intercept.git
cd intercept
```

### Инициализация подмодулей (если есть)

```bash
git submodule update --init --recursive
```

## Генерация проекта

CMake создаёт файлы проекта для вашей IDE на основе `CMakeLists.txt`.

### Метод 1: Командная строка (Рекомендуется)

```bash
# Создать папку для сборки
cmake -B build -G "Visual Studio 17 2022" -A x64

# Опции:
# -B build          - папка для генерации
# -G "..."          - генератор (Visual Studio 2022)
# -A x64            - архитектура (64-бит)
```

### Метод 2: CMake GUI

1. Запустите `cmake-gui`
2. **Where is the source code**: Путь к папке с RVEngine
3. **Where to build the binaries**: Путь к папке `build` (создастся автоматически)
4. Нажмите **Configure**
5. Выберите **Visual Studio 17 2022** и **x64**
6. Нажмите **Generate**

### Метод 3: Используя предоставленные скрипты

В папке RVEngine есть готовые batch-скрипты:

```bash
GENERATE_VCPROJ.bat
```

Этот скрипт:
- Проверяет наличие CMake
- Создаёт папку `vcproj64`
- Генерирует проект Visual Studio 2022 (x64)

### Настройка опций сборки

При генерации можно указать дополнительные опции:

```bash
cmake -B build -G "Visual Studio 17 2022" -A x64 ^
    -DDEVEL=ON ^
    -DUSE_STATIC_LINKING=ON ^
    -DBUILD_PLUGINS=ON
```

**Доступные опции**:

| Опция | Описание | По умолчанию |
|-------|----------|--------------|
| `DEVEL` | Режим разработки | ON |
| `USE_STATIC_LINKING` | Статическая линковка CRT | ON |
| `USE_64BIT_BUILD` | 64-битная сборка | ON |
| `BUILD_PLUGINS` | Собирать плагины | ON |

## Сборка проекта

После генерации проекта можно собрать бинарники.

### Метод 1: CMake из командной строки

```bash
# Сборка Release конфигурации
cmake --build build --config Release

# Сборка Debug конфигурации
cmake --build build --config Debug

# Параллельная сборка (быстрее)
cmake --build build --config Release -j 8
```

### Метод 2: Visual Studio

1. Откройте `build/Intercept.sln` в Visual Studio
2. Выберите конфигурацию (Debug или Release) в верхней панели
3. Меню **Build** → **Build Solution** (или `Ctrl+Shift+B`)

### Метод 3: Используя скрипты

```bash
# Сборка Release (по умолчанию)
BUILD.bat

# Сборка Debug
BUILD.bat Debug

# Сборка Release (явно)
BUILD.bat Release
```

### Результаты сборки

После успешной сборки файлы будут расположены в:

```
build/
└── build/
    ├── Debug/              (если собирали Debug)
    │   ├── intercept/
    │   │   ├── intercept_x64.dll         ← Host библиотека
    │   │   ├── intercept_x64.pdb         ← Отладочные символы
    │   │   └── intercept_x64_static.dll  ← Статическая версия (опционально)
    │   ├── plugins/
    │   │   └── rv_client_x64.dll         ← Пример плагина
    │   └── intercept_client/
    │       └── intercept_client.lib      ← Библиотека для линковки плагинов
    └── Release/            (если собирали Release)
        └── (аналогичная структура)
```

### Время сборки

- **Первая сборка**: 5-15 минут (зависит от CPU)
- **Инкрементальная сборка**: 30 секунд - 2 минуты
- **Чистая пересборка**: 5-15 минут

## Развертывание

### Структура развертывания в Arma 3

RVEngine устанавливается как мод Arma 3:

```
Arma 3/
└── @YourModName/
    ├── intercept_x64.dll           ← Host (обязательно)
    └── intercept/                  ← Папка для клиентских плагинов
        ├── your_plugin_x64.dll
        └── another_plugin_x64.dll
```

### Ручное развертывание

1. Создайте папку мода в Arma 3:
   ```
   C:\Program Files (x86)\Steam\steamapps\common\Arma 3\@YourMod\
   ```

2. Скопируйте Host:
   ```bash
   copy build\build\Release\intercept\intercept_x64.dll "C:\...\Arma 3\@YourMod\"
   ```

3. Создайте папку `intercept`:
   ```bash
   mkdir "C:\...\Arma 3\@YourMod\intercept"
   ```

4. Скопируйте плагины:
   ```bash
   copy build\build\Release\plugins\*.dll "C:\...\Arma 3\@YourMod\intercept\"
   ```

### Автоматическое развертывание (DEPLOY.bat)

Скрипт `DEPLOY.bat` автоматизирует процесс развертывания.

#### Использование

```bash
# Развернуть только Host (Release)
DEPLOY.bat

# Развернуть только Host (Debug)
DEPLOY.bat -D

# Развернуть Host + плагины (Release)
DEPLOY.bat -R -P

# Развернуть Host + плагины (Debug)
DEPLOY.bat -D -P

# Развернуть только плагины (Release)
DEPLOY.bat -PO

# Развернуть только плагины (Debug)
DEPLOY.bat -D -PO
```

#### Настройка целевого пути

Отредактируйте `DEPLOY.bat` и измените переменную `TARGET_PATH`:

```batch
set "TARGET_PATH=C:\Program Files (x86)\Steam\steamapps\common\Arma 3\@YourMod"
```

### Проверка развертывания

После развертывания структура должна выглядеть так:

```
@YourMod/
├── intercept_x64.dll       ← ~500 KB (Release) или ~2 MB (Debug)
└── intercept/
    └── your_plugin_x64.dll ← Размер зависит от плагина
```

## Рабочие процессы

### Первая настройка проекта

```bash
# 1. Клонировать репозиторий
git clone https://github.com/intercept/intercept.git
cd intercept

# 2. Сгенерировать проект
cmake -B build -G "Visual Studio 17 2022" -A x64

# 3. Собрать Release версию
cmake --build build --config Release

# 4. Развернуть в Arma 3
# Вручную скопируйте файлы или используйте DEPLOY.bat
```

### Разработка плагина

```bash
# 1. Внести изменения в код плагина

# 2. Собрать Debug версию (быстрее)
cmake --build build --config Debug

# 3. Развернуть только плагины
DEPLOY.bat -D -PO

# 4. Запустить Arma 3 и протестировать
```

### Обновление только Host

```bash
# 1. Внести изменения в код Host

# 2. Собрать Release
cmake --build build --config Release

# 3. Развернуть только Host (без плагинов)
DEPLOY.bat -R
```

### Полное обновление

```bash
# 1. Внести изменения

# 2. Собрать Release
cmake --build build --config Release

# 3. Развернуть все (Host + плагины)
DEPLOY.bat -R -P
```

### Чистая пересборка

```bash
# Вариант 1: Удалить папку build
rm -rf build
cmake -B build -G "Visual Studio 17 2022" -A x64
cmake --build build --config Release

# Вариант 2: Использовать CMake clean
cmake --build build --target clean
cmake --build build --config Release

# Вариант 3: Использовать скрипт
CLEAN.bat
GENERATE_VCPROJ.bat
BUILD.bat Release
```

### Сборка под несколько конфигураций

```bash
# Собрать и Debug, и Release
cmake --build build --config Debug
cmake --build build --config Release

# Теперь можно переключаться между ними без пересборки
DEPLOY.bat -D    # Развернуть Debug
DEPLOY.bat -R    # Развернуть Release
```

## Troubleshooting

### Проблема: CMake не найден

**Ошибка**:
```
'cmake' is not recognized as an internal or external command
```

**Решение**:
1. Переустановите CMake и выберите "Add to PATH"
2. Или добавьте вручную в PATH: `C:\Program Files\CMake\bin`
3. Перезапустите командную строку

### Проблема: Компилятор не найден

**Ошибка**:
```
No CMAKE_CXX_COMPILER could be found
```

**Решение**:
1. Установите Visual Studio 2022 с компонентом "C++ Desktop Development"
2. Используйте **Developer Command Prompt for VS 2022**
3. Или укажите компилятор явно:
   ```bash
   cmake -B build -G "Visual Studio 17 2022" -A x64 ^
       -DCMAKE_CXX_COMPILER="C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.35.32215/bin/Hostx64/x64/cl.exe"
   ```

### Проблема: Ошибки линковки

**Ошибка**:
```
LNK2001: unresolved external symbol
```

**Решение**:
1. Проверьте, что собираете правильную конфигурацию (Debug vs Release)
2. Очистите и пересоберите проект:
   ```bash
   cmake --build build --target clean
   cmake --build build --config Release
   ```
3. Проверьте, что все подмодули обновлены:
   ```bash
   git submodule update --init --recursive
   ```

### Проблема: Проект не генерируется

**Ошибка**:
```
CMake Error: Could not find CMAKE_ROOT
```

**Решение**:
1. Удалите папку `build` и попробуйте снова
2. Убедитесь, что используете CMake 3.8+
3. Попробуйте сгенерировать в другой папке:
   ```bash
   cmake -B build_new -G "Visual Studio 17 2022" -A x64
   ```

### Проблема: Медленная сборка

**Решения**:
1. Используйте параллельную сборку:
   ```bash
   cmake --build build --config Release -j 8
   ```
2. Установите Ninja Build System:
   ```bash
   cmake -B build -G Ninja
   ninja -C build
   ```
3. Используйте инкрементальную сборку (не очищайте build/)
4. Закройте ненужные программы во время сборки

### Проблема: Файлы не разверты

ваются

**Решение**:
1. Проверьте путь в `DEPLOY.bat`
2. Убедитесь, что файлы собраны:
   ```bash
   dir build\build\Release\intercept\
   ```
3. Запустите DEPLOY.bat с правами администратора
4. Проверьте, что Arma 3 закрыта (файлы могут быть заблокированы)

### Проблема: Плагин не загружается в Arma 3

**Решение**:
1. Проверьте структуру папок:
   ```
   @YourMod/
   ├── intercept_x64.dll       ← Должен быть в корне
   └── intercept/              ← Папка обязательна
       └── plugin_x64.dll
   ```
2. Убедитесь, что используется x64 версия
3. Проверьте зависимости DLL (используйте Dependency Walker)
4. Проверьте, что реализована функция `api_version()`

### Проблема: Версия API не совпадает

**Ошибка**:
```
API version mismatch: Host=X, Client=Y
```

**Решение**:
1. Пересоберите и Host, и Client
2. Убедитесь, что используете одну версию Intercept
3. Очистите старые файлы из Arma 3
4. Проверьте, что `INTERCEPT_SDK_API_VERSION` совпадает

## Дополнительные опции сборки

### Статическая линковка

По умолчанию RVEngine использует статическую линковку CRT:

```bash
cmake -B build -G "Visual Studio 17 2022" -A x64 -DUSE_STATIC_LINKING=ON
```

Это уменьшает зависимости и размер DLL.

### Отключение плагинов

Если не нужно собирать example плагины:

```bash
cmake -B build -G "Visual Studio 17 2022" -A x64 -DBUILD_PLUGINS=OFF
```

### Профилирование сборки

Для анализа времени сборки:

```bash
cmake --build build --config Release -- /p:CL_MPCount=8 /verbosity:detailed
```

## Интеграция с CI/CD

### GitHub Actions пример

```yaml
name: Build RVEngine

on: [push, pull_request]

jobs:
  build:
    runs-on: windows-latest
    
    steps:
    - uses: actions/checkout@v3
      with:
        submodules: recursive
    
    - name: Setup CMake
      uses: lukka/get-cmake@latest
    
    - name: Configure
      run: cmake -B build -G "Visual Studio 17 2022" -A x64
    
    - name: Build
      run: cmake --build build --config Release
    
    - name: Upload artifacts
      uses: actions/upload-artifact@v3
      with:
        name: intercept-binaries
        path: build/build/Release/
```

## Заключение

Теперь вы знаете, как:
- ✅ Установить необходимое ПО
- ✅ Сгенерировать проект CMake
- ✅ Собрать RVEngine из исходников
- ✅ Развернуть собранные файлы в Arma 3
- ✅ Решать типичные проблемы при сборке

**Следующие шаги**:
- [Создание первого плагина](GETTING_STARTED.md)
- [Архитектура системы](ARCHITECTURE.md)
- [API для разработчиков](API/README.md)

---

Если у вас возникли проблемы, не описанные в этом руководстве:
1. Проверьте [Issues на GitHub](https://github.com/intercept/intercept/issues)
2. Посетите [Discord сообщество](https://discord.com/invite/qF5qUacg63)
3. Создайте новый Issue с подробным описанием проблемы

