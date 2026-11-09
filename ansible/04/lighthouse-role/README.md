# Установка LightHouse

Роль загружает статические файлы LightHouse, устанавливает Nginx и `unzip`, настраивает сайт и запускает Nginx. Роль рассчитана на Ubuntu или Debian с systemd; для выполнения нужны Ansible 2.14+ и `become: true`.

## Параметры

| Переменная | По умолчанию | Что меняет |
|---|---|---|
| `lighthouse_commit` | `d701335c25cd1bb9b5155711190bad8ab852c2ce` | Версию LightHouse. Commit закреплён, поэтому при повторном запуске скачивается тот же исходный код. |
| `lighthouse_archive_url` | URL codeload для указанного commit | Адрес архива; можно заменить зеркалом. |
| `lighthouse_listen_port` | `80` | Порт Nginx. |
| `lighthouse_server_name` | `_` | Имя сайта в Nginx; `_` задаёт сайт по умолчанию. |
| `lighthouse_web_root` | `/var/www/lighthouse-<commit>` | Каталог со страницей LightHouse. |
| `lighthouse_site_name` | `lighthouse` | Имя файла конфигурации сайта и ссылки в `sites-enabled`. |
| `lighthouse_packages` | `[nginx, unzip]` | Пакеты, которые устанавливает роль. |

Служебные пути к архиву и каталогам Nginx заданы в `vars/main.yml`.

## Пример

```yaml
- name: Установить LightHouse
  hosts: lighthouse
  become: true
  roles:
    - role: lighthouse
      tags: [lighthouse]
```

Другие Ansible-роли не нужны: Nginx и `unzip` устанавливаются здесь же.

Лицензия: MIT.
