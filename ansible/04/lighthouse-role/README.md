# Роль LightHouse для Ansible

Роль устанавливает Nginx и `unzip`, загружает закреплённую версию статических файлов LightHouse, настраивает сайт Nginx и включает его. Основа — задачи и шаблон из предыдущего playbook Netology MNT.

## Требования

- Ansible 2.14 или новее.
- Целевая система Ubuntu или Debian с systemd и доступом к GitHub codeload.
- Запуск с повышением привилегий: `become: true`.
- Роль сама устанавливает Nginx и `unzip`.

## Переменные роли

| Переменная | Значение по умолчанию | Назначение |
|---|---|---|
| `lighthouse_commit` | `d701335c25cd1bb9b5155711190bad8ab852c2ce` | Зафиксированный commit LightHouse, чтобы загрузка была воспроизводимой. |
| `lighthouse_archive_url` | Ссылка codeload для указанного commit | URL архива; можно заменить адресом зеркала. |
| `lighthouse_listen_port` | `80` | Порт HTTP, на котором Nginx принимает запросы. |
| `lighthouse_server_name` | `_` | Имя сайта в конфигурации Nginx. `_` означает сайт по умолчанию. |
| `lighthouse_web_root` | `/var/www/lighthouse-<commit>` | Каталог со статическими файлами сайта. |
| `lighthouse_site_name` | `lighthouse` | Имя файла в `sites-available` и ссылки в `sites-enabled`. |
| `lighthouse_packages` | `[nginx, unzip]` | Системные пакеты, которые устанавливает роль. |

Внутренние пути к архиву и каталогам Nginx находятся в `vars/main.yml`; обычно менять их не требуется.

## Пример использования

```yaml
- hosts: lighthouse
  become: true
  roles:
    - role: lighthouse
      tags: [lighthouse]
```

## Зависимости

Другие Ansible-роли не требуются. Nginx и `unzip` устанавливаются самой ролью.

## Лицензия

MIT
