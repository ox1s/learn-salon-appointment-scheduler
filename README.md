# freeCodeCamp - Проект "Salon Appointment Scheduler"

## Обзор

Этот репозиторий содержит решение для проекта "Salon Appointment Scheduler" из сертификационного курса "Relational Database" на freeCodeCamp.

**Цель проекта:** Создать интерактивный Bash-скрипт, который позволяет пользователям записываться на услуги в салоне, используя базу данных PostgreSQL для хранения информации о клиентах, услугах и записях.

**Ссылка на задание:** [Relational Database Certification](https://www.freecodecamp.org/learn/relational-database/) 

## Технологии и Навыки

*   **Языки:** Bash, SQL (PostgreSQL)
*   **База данных:** PostgreSQL
*   **Инструменты:** `psql`, `grep`, `sed`, `read`, `while`, `if` (Bash)
*   **Концепции:** Работа с реляционными БД, внешние ключи, CRUD-операции из скрипта, обработка пользовательского ввода, условная логика, работа с текстовым выводом.

## Установка и Запуск

1.  **Предварительные требования:**
    *   Установленный PostgreSQL.
    *   Установленный Bash (обычно есть по умолчанию в Linux/macOS/WSL).

2.  **Настройка Базы Данных:**
    *   **Подключитесь к psql от имени суперпользователя PostgreSQL** (обычно `postgres`):
        ```bash
        sudo -u postgres psql
        ```
    *   **Создайте базу данных `salon`** (если она еще не создана):
        ```sql
        CREATE DATABASE salon;
        ```
    *   **Выйдите из psql:**
        ```sql
        \q
        ```
    *   **Восстановите структуру таблиц и начальные данные** из файла дампа `salon.sql` (файл должен находиться в текущей директории):
        ```bash
        sudo -u postgres psql -d salon < salon.sql
        ```
3.  **Запуск Скрипта:**
    *   **Сделайте скрипт исполняемым** (если еще не сделали):
        ```bash
        chmod +x salon.sh
        ```
    *   **Запустите скрипт:**
        ```bash
        ./salon.sh
        ```
    *   *(Примечание: Скрипт `salon.sh` использует команду `psql` для взаимодействия с базой данных. По умолчанию, `psql` пытается подключиться от имени текущего пользователя Linux. Если ваш Linux-пользователь не имеет прав для подключения к базе `salon`, вам может потребоваться либо настроить аутентификацию в `pg_hba.conf`, либо запускать скрипт через `sudo -u postgres ./salon.sh`, либо передавать имя пользователя и пароль через переменные окружения или параметры `psql` внутри скрипта. В учебном окружении freeCodeCamp это упрощено.)*

## Ключевые Реализованные Функции

*   Отображение списка услуг из базы данных.
*   Запрос ID услуги у пользователя.
*   Проверка существования клиента по номеру телефона в БД.
*   Добавление нового клиента (если не найден).
*   Запрос времени записи.
*   Добавление записи о визите в таблицу `appointments` с использованием `customer_id` и `service_id`.
*   Вывод подтверждающего сообщения с деталями записи.

## Выводы / Чему научилась

В ходе выполнения этого проекта я отработала навыки взаимодействия Bash-скриптов с PostgreSQL, научилась выполнять SQL-запросы из командной строки, обрабатывать пользовательский ввод и применять условную логику для разных сценариев. Также закрепила понимание внешних ключей и базовых операций с БД.
