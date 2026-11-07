# Домашнее задание к занятию 3 «Использование Ansible»

## Выполненные пункты задания

1. Подготовлены три Ubuntu-ВМ в Yandex Cloud: ClickHouse (`ru-central1-a`), Vector (`ru-central1-e`) и LightHouse (`ru-central1-d`).
2. В `site.yml` есть отдельный play для LightHouse: установка Nginx и `unzip`, загрузка архива LightHouse по закреплённому commit, распаковка статики, настройка виртуального хоста, отключение сайта Nginx по умолчанию и запуск сервиса.
3. Использованы `apt`, `get_url`, `unarchive`, `template`, `file`, `systemd` и handler для перезапуска служб.
4. Inventory: `playbook/inventory/prod.yml`.
5. `ansible-lint site.yml` — пройдено.
6. `ansible-playbook --syntax-check -i inventory/prod.yml site.yml` — пройдено.
7. `ansible-playbook --check --diff -i inventory/prod.yml site.yml` — завершился без ошибок. Check mode не устанавливает пакеты, не скачивает и не запускает сервисы; эти задачи корректно пропускаются. Изменения шаблонов показываются через diff.
8. Полный запуск `ansible-playbook --diff -i inventory/prod.yml site.yml` — завершился успешно на всех трёх хостах. ClickHouse и Vector уже были в целевом состоянии после предыдущего частичного запуска; на LightHouse применены оставшиеся изменения, включая установку `unzip`.
9. Повторный полный запуск `--diff` — `changed=0`, `failed=0`, `unreachable=0` на всех хостах.
10. Подготовлен этот README. Финальный коммит задания помечается отдельным тегом `08-ansible-03-yandex`; публикация выполняется после заданий 01 и 02.

## Структура

- `playbook/site.yml` — три play: ClickHouse, Vector, LightHouse.
- `playbook/inventory/prod.yml` — inventory действующих ВМ.
- `playbook/group_vars/<группа>/vars.yml` — переменные компонентов.
- `playbook/templates/` — конфигурации Vector, его systemd unit и виртуального хоста Nginx.

## Переменные и теги

- ClickHouse: `clickhouse_repository_channel`, `clickhouse_repository_key_url`, `clickhouse_packages`, `clickhouse_database`.
- Vector: `vector_version`, `vector_arch`, `vector_download_url`, `vector_data_dir`.
- LightHouse: `lighthouse_commit`, `lighthouse_archive_url`, `lighthouse_listen_port`, `lighthouse_server_name`.
- Теги: `clickhouse`, `vector`, `lighthouse`; например, `ansible-playbook --tags lighthouse ...`.

Все play используют `become: true`.

## SSH и inventory

В текущем inventory указаны публичные IP ВМ на 7 ноября 2026 года. После пересоздания ВМ адреса могут измениться — обновите `ansible_host`.

Во время диагностики установлено, что фактический адрес источника SSH отличался от адреса, который возвращал сервис проверки IP. На гостевой ВМ зафиксирован peer `83.234.158.97`. В группе безопасности SSH разрешён только с наблюдавшихся адресов `/32`; правило `0.0.0.0/0` для порта 22 не создавалось.

В inventory заданы `ansible_ssh_common_args: "-o IPQoS=none"` и `ansible_ssh_retries: 10`: в этой среде SSH-соединения иногда закрывались до баннера, хотя `sshd` на ВМ был запущен. После добавления сетевых адресов в точечный allowlist и этих параметров `ansible -m ping` прошёл для всех трёх хостов.

## Проверки работающих сервисов

- ClickHouse: `systemctl is-active clickhouse-server` вернул `active`; запрос `EXISTS DATABASE logs` вернул `1`.
- Vector: `systemctl is-active vector` вернул `active`; версия — `0.61.0`.
- LightHouse: `systemctl is-active nginx` вернул `active`; HTTP-проверки изнутри ВМ и по публичному адресу вернули `200`, размер ответа — 6766 байт.
- `ansible -i inventory/prod.yml all -m ping` — `pong` от всех трёх хостов.

## Текущее состояние облака

Все три лабораторные ВМ оставлены включёнными и настроенными для проверки. Вычислительные ресурсы и диски могут тарифицироваться. Задание публикуется в GitHub отдельным коммитом и тегом `08-ansible-03-yandex` после заданий 01 и 02.
