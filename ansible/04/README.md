# Домашнее задание MNT 08 — «Работа с ролями Ansible»

Ссылки на решение:

- Vector, версия `1.0.2`: https://github.com/Voltor-90/vector-role/tree/1.0.2
- LightHouse, версия `1.0.2`: https://github.com/Voltor-90/lighthouse-role/tree/1.0.2
- Playbook: https://github.com/Voltor-90/netology/tree/main/ansible/04/playbook

Я вынес настройку Vector и LightHouse в отдельные роли. Для ClickHouse использовал готовую роль `AlexeySetevoi/ansible-clickhouse` версии `1.13`, а создание базы `logs` оставил отдельной задачей в playbook.

В README ролей описал параметры и добавил примеры использования. Версии своих ролей закрепил тегами `1.0.2`; playbook скачивает их из `requirements.yml`.

Playbook прошёл syntax-check, роли — ansible-lint. Полный запуск и проверку повторного выполнения на ВМ не проводил: учебные машины удалены, а адреса в inventory сейчас тестовые. Для такой проверки ВМ нужно создать снова и обновить inventory.
