# Netology MNT 08 — роли Ansible

В этом каталоге находится playbook, который применяет роли ClickHouse, Vector и LightHouse.

## Как устроено решение

- ClickHouse устанавливается готовой ролью `AlexeySetevoi/ansible-clickhouse` версии `1.13`. После неё отдельная задача создаёт базу `logs` — это настройка именно этого проекта.
- Vector настраивается отдельной ролью `vector`.
- LightHouse настраивается отдельной ролью `lighthouse`; эта роль также ставит Nginx и настраивает сайт. Ролям Vector и ClickHouse она не зависит.
- Настройки хостов и компонентов находятся в `inventory/prod.yml` и `group_vars/`.
- Зависимости и версии ролей перечислены в `requirements.yml`.

## Установка и запуск

Зависимости закреплены на опубликованных версиях. Чтобы скачать их и запустить playbook:

```sh
ansible-galaxy role install -r requirements.yml -p roles
ansible-playbook site.yml
```

Перед запуском на реальных серверах замените тестовые адреса в `inventory/prod.yml` на действительные IP-адреса. Адреса `192.0.2.10`–`192.0.2.12` зарезервированы для документации и не являются адресами ваших ВМ.

## Теги

- `clickhouse` — установка ClickHouse и создание базы данных.
- `database` — только задача создания базы данных ClickHouse.
- `vector` — установка и настройка Vector.
- `lighthouse` — установка и настройка LightHouse.

Например, чтобы применить только LightHouse:

```sh
ansible-playbook site.yml --tags lighthouse
```

## Ответы по заданию и ссылки

1. Зависимости включают роль ClickHouse версии `1.13` и опубликованные роли Vector и LightHouse, закреплённые на версии `1.0.1`.
2. Роли созданы через `ansible-galaxy role init`; у каждой есть задачи, значения по умолчанию, внутренние переменные, handlers, шаблоны и README.
3. Playbook использует роли и теги. Задача создания базы данных ClickHouse размещена отдельно после роли.
4. Репозитории:
   - Vector (`1.0.1`): https://github.com/Voltor-90/vector-role/tree/1.0.1
   - LightHouse (`1.0.1`): https://github.com/Voltor-90/lighthouse-role/tree/1.0.1
   - Playbook: https://github.com/Voltor-90/netology/tree/main/ansible/04/playbook

Файл ответа для отправки преподавателю: `../README.md`.

## Что проверено

- Роли устанавливаются командой `ansible-galaxy role install -r requirements.yml -p roles`.
- Синтаксис playbook проверен командой `ansible-playbook --syntax-check -i inventory/prod.yml site.yml`.
- Линтер ролей завершился без ошибок и предупреждений.
- Облачные ВМ удалены. Поэтому выполнение на серверах, повторный запуск для проверки идемпотентности и проверка HTTP/служб потребуют пересоздания ВМ и обновления inventory.
