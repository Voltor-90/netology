# Домашнее задание к занятию 1 «Введение в Ansible»

## Подготовка

- Ansible Core 2.14.18.
- Использован исходный playbook Netology из `08-ansible-01-base`, ветка `MNT-video`.
- Для проверки `prod.yml` использованы Docker-контейнеры с именами `centos7` и `ubuntu`.

## Основная часть

1. До изменения переменных выполнен запуск `ansible-playbook -i inventory/test.yml site.yml`. Для `localhost` значение `some_fact` было `12`. Результат: [скриншот 1](1.png).
2. Значение в `playbook/group_vars/all/examp.yml` изменено на `all default fact`. Повторный запуск тестового inventory показал новое значение: [скриншот 2](2.png).
3. Для дальнейших проверок использовано Docker-окружение с контейнерами `centos7` и `ubuntu`.
4. До изменения групповых переменных запуск `prod.yml` показал `some_fact = el` для `centos7` и `some_fact = deb` для `ubuntu`: [скриншот 4](4.png).
5. В `playbook/group_vars/el/examp.yml` задано `el default fact`, в `playbook/group_vars/deb/examp.yml` — `deb default fact`.
6. Повторный запуск `prod.yml` подтвердил значения для обеих групп: [скриншот 6](6.png).
7. Файлы переменных групп `deb` и `el` зашифрованы Ansible Vault паролем `netology`.
8. Playbook успешно запущен с запросом Vault-пароля; значения групп расшифрованы и применены: [скриншот 8](8.png).
9. Для выполнения задач на управляющем узле выбран connection plugin `ansible.builtin.local`, проверенный командой `ansible-doc -t connection local`.
10. В `playbook/inventory/prod.yml` добавлена группа `local` с `localhost` и `ansible_connection: local`.
11. Итоговый запуск с запросом Vault-пароля подтвердил значения на всех трёх хостах: `centos7` — `el default fact`, `ubuntu` — `deb default fact`, `localhost` — `all default fact`. `failed=0` для каждого: [скриншот 11](11.png).
12. Финальный коммит задания помечен отдельным тегом `08-ansible-01-base`. Публикация выполняется вместе с заданиями 02 и 03.
13. Скриншоты запусков команд приложены выше.

## Примечание по Docker-окружению

В запуске `prod.yml` хост `centos7` сообщил дистрибутив `Debian`, а Ansible вывел предупреждение о выборе Python-интерпретатора. Имя контейнера `centos7` само по себе не гарантирует, что внутри работает CentOS. При этом проверка групповых переменных и Ansible Vault завершилась успешно.

## Запуск

Из каталога `playbook/`:

```bash
ansible-playbook -i inventory/test.yml site.yml
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```

Для второго запуска ввести Vault-пароль `netology`.
