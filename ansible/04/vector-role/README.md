# Роль Vector для Ansible

Эта роль устанавливает Vector из архива выбранной версии, настраивает службу systemd, размещает конфигурацию и запускает службу. Основа — задачи и шаблоны из предыдущего playbook Netology MNT.

## Требования

- Ansible 2.14 или новее.
- Целевая система Ubuntu или Debian с systemd и доступом к URL архива Vector.
- Запуск с повышением привилегий: `become: true`.

## Переменные роли

| Переменная | Значение по умолчанию | Назначение |
|---|---|---|
| `vector_version` | `0.61.0` | Версия Vector. |
| `vector_arch` | `x86_64-unknown-linux-musl` | Архитектура сборки в архиве. |
| `vector_download_url` | Формируется из версии и архитектуры | Ссылка на архив; можно заменить ссылкой на зеркало. |
| `vector_data_dir` | `/var/lib/vector` | Каталог данных Vector. |
| `vector_config_dir` | `/etc/vector` | Каталог конфигурации. |
| `vector_install_dir` | `/opt/vector` | Каталог установки распакованного Vector. |
| `vector_service_user` / `vector_service_group` | `vector` | Системный пользователь и группа службы. |
| `vector_config` | Пример: источник тестовых JSON-логов и вывод в консоль | Полная конфигурация Vector в виде YAML-структуры. Роль преобразует её в YAML. |

Служебные пути `vector_archive_path`, `vector_binary_path` и `vector_systemd_unit` задаются в `vars/main.yml`; обычно их не нужно переопределять.

## Пример использования

```yaml
- hosts: vector
  become: true
  roles:
    - role: vector
      tags: [vector]
```

Переопределяйте значения по умолчанию в inventory, `group_vars` или непосредственно в параметрах роли. Встроенная конфигурация Vector — демонстрационная; для реального сбора логов задайте свою переменную `vector_config`.

## Лицензия

MIT
