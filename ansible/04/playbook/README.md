# Playbook: ClickHouse, Vector и LightHouse

Playbook собирает три отдельные роли. ClickHouse устанавливается ролью `AlexeySetevoi/ansible-clickhouse` версии `1.13`; после неё отдельная задача создаёт базу `logs`. Vector и LightHouse настраиваются своими ролями. Роль LightHouse сама устанавливает Nginx.

## Запуск

Сначала скачайте роли, затем примените playbook:

```sh
ansible-galaxy role install -r requirements.yml -p roles
ansible-playbook site.yml
```

Перед запуском замените адреса `192.0.2.10`–`192.0.2.12` в `inventory/prod.yml` на IP своих серверов. Сейчас там TEST-NET адреса для примера — подключиться к ним нельзя.

## Где что настроено

- `requirements.yml` — источники и версии ролей.
- `inventory/prod.yml` — серверы и группы `clickhouse`, `vector`, `lighthouse`.
- `group_vars/` — параметры каждого продукта.
- `site.yml` — порядок запуска ролей и задача создания базы данных.

Запустить только один компонент можно тегом, например:

```sh
ansible-playbook site.yml --tags lighthouse
```

Доступны теги `clickhouse`, `database`, `vector` и `lighthouse`. Тег `database` запускает только задачу создания базы ClickHouse.

## Проверки

Playbook прошёл `ansible-playbook --syntax-check`; зависимости скачиваются через `ansible-galaxy`, роли прошли `ansible-lint`. Облачные ВМ удалены, поэтому здесь не проверялся запуск на серверах и повторное выполнение для проверки идемпотентности. Для этого нужно заново создать ВМ и обновить inventory.
