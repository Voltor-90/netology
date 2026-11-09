# Домашнее задание MNT 08 — «Работа с ролями Ansible»

## Ссылки на решение

- Роль Vector, версия `1.0.1`: https://github.com/Voltor-90/vector-role/tree/1.0.1
- Роль LightHouse, версия `1.0.1`: https://github.com/Voltor-90/lighthouse-role/tree/1.0.1
- Playbook: https://github.com/Voltor-90/netology/tree/main/ansible/04/playbook

## Что сделано

Старый playbook разделён на роли: отдельная роль настраивает Vector, другая — LightHouse. Для ClickHouse используется готовая роль `AlexeySetevoi/ansible-clickhouse` версии `1.13`. После неё playbook отдельной задачей создаёт базу данных `logs`.

В каждой собственной роли есть задачи установки и настройки, обработчики перезапуска служб, шаблоны конфигураций и README на русском языке с описанием параметров и примером использования. Версии ролей опубликованы с семантическим тегом `1.0.1`; playbook устанавливает именно эти версии через `requirements.yml`.

## Проверки

- Все три зависимости установлены через `ansible-galaxy role install -r requirements.yml -p roles`.
- `ansible-playbook --syntax-check -i inventory/prod.yml site.yml` завершился успешно.
- `ansible-lint` для ролей завершился без ошибок и предупреждений.
- Шаблоны Vector и Nginx LightHouse отрендерены; получившийся YAML конфигурации Vector разобран без ошибок.

Целевые облачные ВМ удалены. В inventory стоят специальные тестовые адреса, поэтому запуск на серверах, проверка идемпотентности и проверка работающих служб требуют пересоздания ВМ и замены адресов.
