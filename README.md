Репозиторий для работы над домашними заданиями в рамках курса **"DevOps практики и инструменты"**

**Содержание:**
<a name="top"></a>
1. [ДЗ № 3 - Знакомство с облачной инфраструктурой](#hw3)

---
<a name="hw3"></a>
# Выполнено ДЗ № 3 - Знакомство с облачной инфраструктурой

 - [x] Основное ДЗ
 - [x] Дополнительное задание (ssh someinternalhost и alias someinternalhost)
 - [ ] Дополнительное задание (валидный сертификат для панели управления VPN-сервера Pritunl)

## В процессе сделано:

### Подготовка инфраструктуры

Использованы мои наработки из дипломного проекта по курсу **DevOps для эксплуатации и разработки**.

Инфраструктура поднимается в облаке Yandex Cloud. Вся инфраструктура разворачивается по методолгии IaaC с использованием Terraform:
1. Административное облако **organization** для размещения административного фолдера **adm-folder** для ресурсов уровня организации (облака)
2. **adm-folder** в облаке **organization** для размещения объектного хранилища, на котором сохраняется Terraform state уровня 1 (организация и описание облаков для проектов)
3. Облако проекта **otus-kuber** для размещения административного фолдера **adm-folder** для ресурсов уровня проекта (фолдеры) и фолдеров окружений проекта
4. **adm-folder** в облаке **otus-devops** для размещения объектного хранилища, на котором сохраняется Terraform state уровня 2 (облако проекта и описание фолдеров окружений проекта)
5. **infra-folder** в облаке **otus-devops** для размещения объектного хранилища, на котором сохраняется Terraform state уровня 3 (фолдер Development окружения проекта и описание ресурсов этого фолдера)
6. Ресурсы **Infra** окружения проекта:
  - сеть и подсеть
  - сервисные аккаунты
  - группы безопасности
  - инстансы ВМ
  - зона и записи DNS

Подробнее по инфраструктурной части см. [infrastructure/README.md](infrastructure/README.md)

### Подключение к виртуальной машине с использованием приватного ключа

```shell
$ ssh appuser@158.160.113.188
...
Warning: Permanently added '158.160.113.188' (ED25519) to the list of known hosts.
Enter passphrase for key '/home/andy/.ssh/id_rsa':
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-163-generic x86_64)
```

### Используем Bastion host для прямого подключения к инстансам внутренней сети

```shell
$ eval $(ssh-agent)
Agent pid 93343

$ ssh-add -L
The agent has no identities.

$ ssh-add ~/.ssh/id_rsa
Enter passphrase for /home/andy/.ssh/id_rsa:
Identity added: /home/andy/.ssh/id_rsa (/home/andy/.ssh/id_rsa)

$ ssh -i ~/.ssh/id_rsa -A appuser@158.160.113.188
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-163-generic x86_64)
```

### Используем Bastion host для сквозного подключения

```shell
appuser@bastion:~$ ssh 192.168.10.5
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-159-generic x86_64)
...
appuser@someinternalhost:~$ hostname
someinternalhost
```

### Подключение к локальной машине в удаленной приватной сети через bastion-host

Варианты с одной командой:
1. Через сквозной терминал:  
`$ ssh -i ~/.ssh/id_rsa -A -t appuser@158.160.113.188 \ ssh 192.168.10.5`

3. Подключение с использованием bastion-host'а как Proxy:  
`$ ssh -i ~/.ssh/id_rsa 192.168.10.5 -o "proxycommand ssh -W %h:%p appuser@158.160.113.188"`

5. Подключение через jump-host:  
`$ ssh -i ~/.ssh/id_rsa -A -J appuser@158.160.113.188 appuser@192.168.10.5`

### Дополнительное задание

#### ssh someinternalhost

Для создания простого подключения по SSH необходимо добавить следующую конфигурацию в файл `~/.ssh/config`:
```
Host someinternalhost
    ProxyJump appuser@158.160.113.188
    HostName 192.168.10.5
    User appuser
    IdentityFile ~/.ssh/id_rsa
```
Проверяем:
```shell
$ ssh someinternalhost
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-159-generic x86_64)

appuser@someinternalhost:~$ hostname
someinternalhost
```
#### доступ по алиасу someinternalhost

Для создания алиаса необходимо выполнить следующую команду
`$ alias someinternalhost='ssh someinternalhost'`

### VPN-сервер для серверов Yandex Cloud

1. Установка VPN-сервера pritunl и базы mongodb

Запускаем скрипт [VPN/setupvpn.sh](VPN/setupvpn.sh)

2. Запуск настройки через web-интерфейс [https://bastion.voytenkov.ru/setup](https://bastion.voytenkov.ru/setup)

3. Добавление User'а, организации и сервера.

4. При прикреплении User'a к серверу сгенерируется конфигурация для подключения через OpenVPN, доступная для скачивания.
См. [VPN/cloud-bastion.ovpn](VPN/cloud-bastion.ovpn)

5. Устанавливаем OpenVPN клиента, импортируем конфигурацию и подключаемся.

6. Проверяем из Windows Terminal:
```ssh
PS C:\Users\Admin> ssh -i ~/.ssh/id_rsa appuser@192.168.10.5
Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-159-generic x86_64)
appuser@someinternalhost:~$
```

## Как запустить проект:

## Как проверить работоспособность:
```
bastion_IP = 158.160.113.188
someinternalhost_IP = 192.168.10.5
```

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
