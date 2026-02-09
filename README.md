# Содержимое репозитория

| Файл | Описание |
|------|--------|
| `setup.sql` | Создание всех таблиц |
| `view.sql` | Представление `active_employees_info` (отдел кадров) |
| `function.sql` | Функция `add_product_with_movement` (складской учёт) |
| `trigger_salary.sql` | Триггер `log_salary_change` (аудит зарплаты) |
| `cursor.sql` | Курсор `batch_salary_increase` (пакетное повышение зарплаты) |
| `audit_jsonb.sql` | Триггер `audit_data_changes` (полноценный аудит с JSONB) |

## Результаты выполнения

### 1. Представление `active_employees_info`
![Результат представления](1_view.png)

### 2. Функция `add_product_with_movement`
![Результат функции](2_function.png)

### 3. Триггер аудита зарплаты
![Результат триггера зарплаты](3_trigger_salary.png)

### 4. Курсор для пакетной обработки
![Результат курсора](4_cursor.png)

### 5. Полноценный аудит с JSONB
![Результат JSONB-аудита](5.1_audit_jsonb.png, 5.1_audit_jsonb.png)

Все компоненты протестированы в pgAdmin. Работает корректно.
