# Установка Vector

Роль ставит Vector из архива, кладёт конфигурацию и systemd unit, затем запускает службу. Исходные задачи и шаблоны взяты из предыдущей работы по курсу и разнесены по структуре роли.

## Перед запуском

Нужны Ansible 2.14+, Ubuntu или Debian с systemd и доступом к адресу загрузки Vector. Роль запускается с `become: true`.

## Параметры

| Переменная | По умолчанию | Что меняет |
|---|---|---|
| `vector_version` | `0.61.0` | Версию устанавливаемого Vector. |
| `vector_arch` | `x86_64-unknown-linux-musl` | Архитектуру архива. |
| `vector_download_url` | Собирается из версии и архитектуры | URL архива. При необходимости укажите зеркало. |
| `vector_data_dir` | `/var/lib/vector` | Каталог данных Vector. |
| `vector_config_dir` | `/etc/vector` | Каталог конфигурации. |
| `vector_install_dir` | `/opt/vector` | Куда распаковывается Vector. |
| `vector_service_user`, `vector_service_group` | `vector` | Пользователя и группу службы. |
| `vector_config` | Тестовые логи → консоль | Конфигурацию Vector. Передайте YAML-совместимый словарь. |

В `vars/main.yml` лежат внутренние пути к архиву, бинарному файлу и unit-файлу. Обычно менять их не нужно.

## Пример

```yaml
- name: Установить Vector
  hosts: vector
  become: true
  roles:
    - role: vector
      tags: [vector]
```

По умолчанию роль настраивает тестовый источник логов и выводит их в консоль. Для своего сценария переопределите `vector_config` в `group_vars` или в playbook.

Лицензия: MIT.
