# ReSDK_A3 Code Style Linter

## Тесты

```bash
# Запуск тестов
cd Third-party/linter
python test_linter.py

# Или с pytest
python -m pytest test_linter.py -v
```

---

Линтер для проверки соответствия кода стайлгайду проекта (CODE-STANDARDS.md).

## Требования

- Python 3.8+

## Использование

### Windows

```batch
cd Third-party\linter
run_linter.bat
```

### Linux/macOS

```bash
cd Third-party/linter
chmod +x run_linter.sh
./run_linter.sh
```

### Параметры командной строки

```
python linter.py [options]

Опции:
  -f, --file FILE          Проверить один файл
  -d, --directory DIR      Проверить директорию
  --root DIR               Корневая директория проекта
  --extensions EXT         Расширения файлов (по умолчанию: .sqf,.hpp,.cpp)
  --github-actions         Вывод в формате GitHub Actions
  --warnings-as-errors     Считать предупреждения ошибками
```

### Примеры

```bash
# Проверить весь проект
python linter.py

# Проверить один файл
python linter.py -f Src/host/CraftSystem/CraftSystem_init.sqf

# Проверить директорию
python linter.py -d Src/host/GameObjects

# Вывод для GitHub Actions
python linter.py --github-actions
```

## Проверки

### Ошибки (Error)

| Правило | Описание |
|---------|----------|
| `copyright-header` | Отсутствует или некорректный заголовок копирайта |
| `tabs-not-spaces` | Использование пробелов вместо табуляции для отступов |
| `if-then-format` | Некорректное форматирование if-then (then на новой строке) |
| `include-not-found` | Файл из #include не найден |

### Предупреждения (Warning)

| Правило | Описание |
|---------|----------|
| `macro-func-naming` | Макрофункция не в camelCase |
| `func-naming` | Функция модуля не соответствует паттерну moduleName_functionName |
| `local-var-declaration` | Локальная переменная без private/params/objParams |
| `class-member-indent` | Некорректный отступ члена класса |

## GitHub Actions

Для интеграции с CI создайте файл `.github/workflows/lint.yml`:

```yaml
name: Lint

on:
  pull_request:
    branches: [ main ]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'
      
      - name: Run linter
        run: python Third-party/linter/linter.py --github-actions
```

## Структура кода

```
Third-party/linter/
├── linter.py          # Основной скрипт линтера
├── run_linter.bat     # Windows runner
├── run_linter.sh      # Linux/macOS runner
└── README.md          # Документация
```

## Игнорирование файлов

Директория `Third-party/` автоматически исключается из проверки.
