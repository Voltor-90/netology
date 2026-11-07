# Домашнее задание к занятию 2 «Работа с Playbook»

## Назначение

Playbook устанавливает ClickHouse на хост группы `clickhouse`, создаёт базу `logs`, затем устанавливает Vector на хост группы `vector`, разворачивает его конфигурацию и запускает systemd-службу. Vector получает тестовые события `demo_logs` и выводит их в консольный sink.

## Структура

- `playbook/site.yml` — два play для ClickHouse и Vector.
- `playbook/inventory/prod.yml` — Docker-хосты `clickhouse-01` и `vector-01`.
- `playbook/group_vars/clickhouse/vars.yml` — параметры ClickHouse.
- `playbook/group_vars/vector/vars.yml` — параметры Vector.
- `playbook/templates/vector.yaml.j2` — конфигурация Vector.
- `playbook/templates/vector.service.j2` — systemd unit Vector.

Для подключения используется `community.docker.docker`. Контейнеры в этой лабораторной запускаются на локальном Docker-хосте.

## Переменные

`group_vars/clickhouse/vars.yml`:

- `clickhouse_version` — версия ClickHouse (`22.3.3.44`).
- `clickhouse_packages` — устанавливаемые RPM-пакеты.

`group_vars/vector/vars.yml`:

- `vector_version` — версия Vector (`0.61.0`).
- `vector_arch` — целевая архитектура архива (`x86_64-unknown-linux-musl`).
- `vector_download_url` — URL архива Vector, формируемый из версии и архитектуры.
- `vector_data_dir` — каталог данных Vector.

## Запуск и проверка

Из каталога `playbook/`:

```bash
ansible-lint site.yml
ansible-playbook --syntax-check -i inventory/prod.yml site.yml
ansible-playbook -i inventory/prod.yml site.yml --check
ansible-playbook -i inventory/prod.yml site.yml --check --diff
ansible-playbook -i inventory/prod.yml site.yml --diff
```

Первый обычный запуск устанавливает компоненты и создаёт базу `logs`. Повторный запуск с `--diff` должен быть идемпотентным: `changed=0` на обоих хостах.

В `--check` ожидаемы пропуски задач загрузки, распаковки и запуска служб: они намеренно не выполняют установку в режиме проверки. Ansible также может предупредить, что группа `vector` ещё не создана: check mode только моделирует создание системной группы и не применяет её.

## Теги

- `clickhouse` — выполнить play установки ClickHouse.
- `vector` — выполнить play установки Vector.

Примеры выборочного запуска:

```bash
ansible-playbook -i inventory/prod.yml site.yml --tags clickhouse
ansible-playbook -i inventory/prod.yml site.yml --tags vector
```

## Результаты и скриншоты

5. Проверка `ansible-lint site.yml`: [5.png](5.png).

6. Режим проверки: [6.1.png](6.1.png), [6.2.png](6.2.png).

7. Первый запуск с `--diff`: ClickHouse — [7.1.png](7.1.png), Vector и итоговый recap — [7.2.png](7.2.png).

8. Повторный запуск с `--diff`: `changed=0`, `failed=0` для обоих хостов — [8.1.png](8.1.png).

## Примечания

- Контейнеры `clickhouse-01` и `vector-01` должны быть запущены до запуска playbook; для systemd в контейнерах используется образ с systemd.
- Установка ClickHouse использует официальные RPM-файлы по HTTPS. Для установки локальных RPM в учебном playbook отключена проверка GPG-подписи (`disable_gpg_check: true`); не переносить эту настройку в production без проверки доверенной цепочки пакетов.
- Финальный коммит задания помечен тегом `08-ansible-02-playbook`; публикация выполняется по очереди вместе с заданиями 01 и 03.
