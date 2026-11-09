# MNT 08 — Работа с roles

## Решение

- Vector role: https://github.com/Voltor-90/vector-role
- LightHouse role: https://github.com/Voltor-90/lighthouse-role
- Playbook: https://github.com/Voltor-90/netology/tree/main/ansible/04/playbook

Роли Vector и LightHouse опубликованы. Playbook и файл ответа находятся в этом репозитории и публикуются отдельным коммитом только из `ansible/04`, без включения незакоммиченных изменений в `03` и `ter/03`. ClickHouse использует upstream-роль `AlexeySetevoi/ansible-clickhouse` версии `1.13`; отдельная задача playbook создаёт deployment-specific базу данных.

Теги ролей `1.0.0` указывают на коммиты Vector `c19476301022d9c0b4cbb488b8f875828593cb7e` и LightHouse `56967d2b82025a66bb7d1c8489acaf9d25180939`.

## Проверка

- `ansible-galaxy role install -r requirements.yml -p roles` — успешно установлены ClickHouse `1.13`, Vector `1.0.0`, LightHouse `1.0.0`.
- `ansible-playbook --syntax-check -i inventory/prod.yml site.yml` — успешно.
- `ansible-playbook --list-tags -i inventory/prod.yml site.yml` — теги ролей видны.
- `ansible-lint ../vector-role ../lighthouse-role` — 0 ошибок и предупреждений.
- Шаблоны Vector и Nginx LightHouse отрендерены; YAML Vector разобран успешно.
- Целевые ВМ удалены; inventory использует TEST-NET адреса, поэтому запуск на хостах, идемпотентность и сервисные проверки требуют пересоздания ВМ.

## Публикация

Роли опубликованы в публичных репозиториях с тегами `1.0.0`. Playbook и этот файл ответа публикуются из `ansible/04` в `Voltor-90/netology`; существующие незакоммиченные изменения других заданий не включаются.
