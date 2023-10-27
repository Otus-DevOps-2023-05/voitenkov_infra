Репозиторий для работы над домашними заданиями в рамках курса **"DevOps практики и инструменты"**

**Содержание:**
<a name="top"></a>  
1. [Подготовка инфраструктуры](#infra)  
2. [ДЗ № 3 - Знакомство с облачной инфраструктурой](#hw3)  
3. [ДЗ № 4 - Основные сервисы Yandex Cloud](#hw4)
4. [ДЗ № 5 - Модели управления инфраструктурой. Подготовка образов с помощью Packer](#hw5)
5. [ДЗ № 6 - Знакомство с Terraform](#hw6)
6. [ДЗ № 7 - Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform](#hw7)
7. [ДЗ № 8 - Управление конфигурацией. Знакомство с Ansible](#hw8)
8. [ДЗ № 9 - Продолжение знакомства с Ansible templates, handlers, dynamic inventory, vault, tags](#hw9)
9. [ДЗ №10 - Ansible роли, управление настройками нескольких окружений и best practices](#hw10)  
10. [ДЗ №11 - Локальная разработка Ansible ролей с Vagrant. Тестирование конфигурации](#hw11)  
---
<a name="infra"></a>
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

<a name="hw3"></a>
# Выполнено ДЗ № 3 - Знакомство с облачной инфраструктурой

 - [x] Основное ДЗ
 - [x] Дополнительное задание (ssh someinternalhost и alias someinternalhost)
 - [ ] Дополнительное задание (валидный сертификат для панели управления VPN-сервера Pritunl)

## В процессе сделано:

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

См. выше.

## Как проверить работоспособность:
```
bastion_IP = 158.160.113.188
someinternalhost_IP = 192.168.10.5
```

<a name="hw4"></a>
# Выполнено ДЗ № 4 - Основные сервисы Yandex Cloud

 - [x] Основное ДЗ
 - [x] Дополнительное задание (startup script)

## В процессе сделано:

Так как с развертыванием ресурсов с использованием yandex CLI и Terraform я знаком, сразу делаю Terraform'ом, а startup script прописываем в userdata Cloud-Init.
Bash-скрипты проверит тест.

### Дополнительное задание

cм. [startup script.sh](startup_script.sh).  
но я сделал лучше [infrastructure/templates/ubuntu-reddit-app.yml.tftpl](infrastructure/templates/ubuntu-reddit-app.yml.tftpl)

## Как запустить проект:

`terraform apply`

## Как проверить работоспособность:
```
testapp_IP = 158.160.51.150
testapp_port = 9292
```

<a name="hw5"></a>
# Выполнено ДЗ № 5 - Модели управления инфраструктурой. Подготовка образов с помощью Packer

 - [x] Основное ДЗ
 - [x] ⭐ Построение bake-образа
 - [x] ⭐ Автоматизация создания ВМ

## В процессе сделано:

1. Создание файла-шаблона Packer. Использую IAM-key для service account Terraform, так как он имеет права на фолдер.
2. Сборка образа:  
   `packer build ./ubuntu16.json`
3. Проверка образа - создание ВМ. Использовал Terraform, прописав вместо образа Ubuntu наш собранный Packer'ом образ. Приложение доступно через веб.
4. Параметризация образа и сборка нового образа на базе образа, собранного на шаге 2:  
   `packer build -var-file=variables.json ./ubuntu16var.json`

 ## ⭐ Построение bake-образа

 cм. [packer/immutable.json](packer/immutable.json)  
 Создаем скриптом службу, для копирования необходимых для службы файлов используется File provisioner.
 Запускаем:  
 `packer build -var-file=variables.json ./immutable.json`

 Проверяем:
```shell
appuser@reddit-app:~$ sudo systemctl status reddit
● reddit.service - Reddit App Service
   Loaded: loaded (/etc/systemd/system/reddit.service; enabled; vendor preset: enabled)
   Active: active (running) since Tue 2023-09-26 13:20:21 UTC; 4min 32s ago
 Main PID: 658 (ruby2.3)
   CGroup: /system.slice/reddit.service
           └─658 puma 3.10.0 (tcp://0.0.0.0:9292) [reddit

Sep 26 13:20:30 reddit-app puma[658]: D, [2023-09-26T13:20:30.355917 #658] DEBUG -- : MONGODB | Server description for 127.0.0.1:27017 changed from 'unkn
Sep 26 13:20:30 reddit-app puma[658]: D, [2023-09-26T13:20:30.356031 #658] DEBUG -- : MONGODB | There was a change in the members of the 'single' topolog
Sep 26 13:21:15 reddit-app puma[658]: D, [2023-09-26T13:21:15.986139 #658] DEBUG -- : MONGODB | 127.0.0.1:27017 | user_posts.find | STARTED | {"find"=>"p
Sep 26 13:21:15 reddit-app puma[658]: D, [2023-09-26T13:21:15.987295 #658] DEBUG -- : MONGODB | 127.0.0.1:27017 | user_posts.find | SUCCEEDED | 0.0010156
Sep 26 13:21:16 reddit-app puma[658]: 95.55.223.43 - - [26/Sep/2023:13:21:16 +0000] "GET / HTTP/1.1" 200 1861 0.3093
Sep 26 13:21:16 reddit-app puma[658]: 95.55.223.43 - - [26/Sep/2023:13:21:16 +0000] "GET /favicon.ico HTTP/1.1" 404 475 0.0013
```
 
## ⭐ Автоматизация создания ВМ

cм. [config-scripts/create-reddit-vm.sh](config-scripts/create-reddit-vm.sh)  
Но я использовал Terraform.

## Как запустить проект:

`terraform apply`

## Как проверить работоспособность:

<a name="hw6"></a>
# Выполнено ДЗ № 6 - Знакомство с Terraform

 - [x] Основное ДЗ
 - [x] ⭐⭐ Network Load Balancer 
 
## В процессе сделано:

1. Настроен Terraform проект.
2. Изучен новые для меня команды:
   - terraform fmt
   - terraform refresh
   - terraform taint  
4. Задеплоены инстанс ВМ:
   - input variables (параметризация)
   - output variables
   - настроен remote-exec provisioner, приложение деплоится при развертывании инстанса.
   - проверен доступ по SSH
     
 ## ⭐⭐ Network Load Balancer 

1. Изучены возможности HCL:
   - метааргументы count, for_each
   - цикл for
   - self
   - dynamic block
2. Задеплоены 2 инстанса в целевой группе и Network Load Balancer  cм. [terraform/lb.tf](terraform/lb.tf)  
3. Проверена работа балансировки отключением службы на одном из инстансов: приложение доступно с другого инстанса.

**Вопрос**: какие проблемы вы видите в такой конфигурации приложения?  
**Ответ**: две существующие отдельно друг от друга и не связанные базы данных. Данные сохраняются случайным образом то в одну, то в другую базу и не реплицируются.

## Как запустить проект:

`terraform apply`

## Как проверить работоспособность:

<a name="hw7"></a>
# Выполнено ДЗ № 7 - Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform

 - [x] Основное ДЗ
 - [x] ⭐ хранение стейт файла в удаленном бекенде
 - [x] ⭐⭐восстанавливаем Provisioners
 
## В процессе сделано:

1. Проект разделен на 2 модуля: app и db
2. Созданы 2 проекта для Stage и Prod окружений

## ⭐ хранение стейт файла в удаленном бекенде

Хранилище S3 для TF State File у меня используется изначально. Для домашки скопировал в:  
[terraform/prod/backend.tf](terraform/prod/backend.tf)  
[terraform/stage/backend.tf](terraform/stage/backend.tf)

## ⭐⭐восстанавливаем Provisioners

В модули добавлены скрипты для настройки внешнего доступа к MongoDB и настройки приложения Reddit для работы с MongoDB по сети. 

## Как запустить проект:

`terraform apply`

## Как проверить работоспособность:

<a name="hw8"></a>
# Выполнено ДЗ № 8 - Управление конфигурацией. Знакомство с Ansible

 - [x] Основное ДЗ
 - [x] Задание со ⭐ Dynamic Inventory

## В процессе сделано:

- установлен Ansible
- протестированы команды из методички
- протестирована работа со статическим Inventory
- протестирован Playbook clone.yml. Здесь подробнее. На вопрос, что изменилось и почему, отвечаю. Сначала репозиторий **reddit** присутствовал и задача не запускалась. После удаления каталога **reddit** соответствующей косандой Ansible, при запуске Playbook репозиторий был склонирован:
```shell
$ ansible-playbook clone.yml

PLAY [Clone] ****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [reddit-app]

TASK [Clone repo] ***********************************************************************************************************************************************************************************************
ok: [reddit-app]

PLAY RECAP ******************************************************************************************************************************************************************************************************
reddit-app                 : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

andy@res-3:~/git/otus/devops/voitenkov_infra/ansible$ ansible app -m command -a 'rm -rf ~/reddit'
reddit-app | CHANGED | rc=0 >>

andy@res-3:~/git/otus/devops/voitenkov_infra/ansible$ ansible-playbook clone.yml

PLAY [Clone] ****************************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [reddit-app]

TASK [Clone repo] ***********************************************************************************************************************************************************************************************
changed: [reddit-app]

PLAY RECAP ******************************************************************************************************************************************************************************************************
reddit-app                 : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### Задание со ⭐ Dynamic Inventory

Мы делаем имитатор скрипта Dynamic Inventory, писать полноценный скрипт задачи не было. Можно было сделать на Python или Bash, но мы не ищем легких путей. Делаем скрипт на... Go :) [ansible/dynamic.go](ansible/dynamic.go)
Запускаем, локально работает:
```shell
$ ansible all -m ping
reddit-db | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
reddit-app | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```
Но тесты сваливаются, так как там нет go, gorun и зависимостей, поэтому для тестов пишем скрипт на Python [ansible/dynamic.py](ansible/dynamic.py).

P.S. По отличиям схем JSON Static и Dynamic Inventory:  
Static:  
- структура: группа-хост-переменные
  
Dynamic:  
- добавлен обязательный блок _ meta _ с переменными для каждого хоста, список переменных может быть пустым
- в блоке группа-хост нет переменных
- добавлена обязательная группа **ungrouped**, куда попадают хосты, не попавшие ни в одну группу
- описание групп сложнее, добавлена группа **all** и промежуточный уровень **children** для подгрупп, подгруппы с хостами идут отдельными списками

## Как запустить проект:

`terraform apply`

## Как проверить работоспособность:

<a name="hw9"></a>
# Выполнено ДЗ № 9 - Продолжение знакомства с Ansible templates, handlers, dynamic inventory, vault, tags

 - [x] Основное ДЗ
 - [x] Задание со ⭐ Dynamic Inventory

## В процессе сделано:

- Протестировал все предложенные варианты конфигурирования инфраструктуры с использованием Ansible.
- Протестировал provision в Packer с использованием плейбуков Ansible.

### Задание со ⭐ Dynamic Inventory

Установил плагин yc_compute из предложенного в методичке репозитория, настроил конфигурацию плагина, включая keyed_groups. Все отлично, все работает, правда пришлось пошаманить:
```shell
$ ansible-inventory --graph
@all:
  |--@ungrouped:
  |--@app:
  |  |--fhm8rvl0jok1tj95tauo.auto.internal
  |--@b1gcgnan15o6dc5q7d1r:
  |  |--fhm8rvl0jok1tj95tauo.auto.internal
  |  |--fhmdmaogjlgnh1kgku1g.auto.internal
  |--@db:
  |  |--fhmdmaogjlgnh1kgku1g.auto.internal

$ ansible all -m ping
fhmdmaogjlgnh1kgku1g.auto.internal | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
fhm8rvl0jok1tj95tauo.auto.internal | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
```

## Как запустить проект:

`terraform apply`

## Как проверить работоспособность:

<a name="hw10"></a>
# Выполнено ДЗ № 10 - Ansible роли, управление настройками нескольких окружений и best practices

 - [x] Основное ДЗ
 - [ ] Задание с ⭐⭐ Настройка ~Travis CI~ GitHub Actions

## В процессе сделано:

1. Перенёс созданные плейбуки в раздельные роли
2. Описал Stage и Prod окружения
3. Использовал коммьюнити роль **nginx**:
  
Сайт работает по 80 порту через Nginx:
![Reddit-Nginx](/images/hw10-reddit.png)  

4. Задействовал Ansible Vault для шифрования конфигураций, содержащих чувствительные данные

Результаты по плейбуку users:
```shell
ubuntu@fhmdmaogjlgnh1kgku1g:~$ sudo cat /etc/passwd | grep qauser
qauser:x:1002:1003::/home/qauser:

$ ansible-playbook playbooks/site.yml --check
[WARNING]: While constructing a mapping from /home/andy/git/otus/devops/ansible-3/roles/jdauphant.nginx/tasks/configuration.yml, line 62, column 3, found a duplicate dict key (when). Using last defined value
only.

PLAY [Configure MongoDB] ****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [fhmdmaogjlgnh1kgku1g.auto.internal]

TASK [db : Show info about the env this host belongs to] ********************************************************************************************************************************************************
ok: [fhmdmaogjlgnh1kgku1g.auto.internal] => {
    "msg": "This host is in stage environment!!!"
}

...

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [fhm8rvl0jok1tj95tauo.auto.internal]
ok: [fhmdmaogjlgnh1kgku1g.auto.internal]

TASK [create users] *********************************************************************************************************************************************************************************************
changed: [fhm8rvl0jok1tj95tauo.auto.internal] => (item={'key': 'admin', 'value': {'password': 'qwerty123', 'groups': 'sudo'}})
changed: [fhmdmaogjlgnh1kgku1g.auto.internal] => (item={'key': 'admin', 'value': {'password': 'qwerty123', 'groups': 'sudo'}})
changed: [fhm8rvl0jok1tj95tauo.auto.internal] => (item={'key': 'qauser', 'value': {'password': 'test123'}})
changed: [fhmdmaogjlgnh1kgku1g.auto.internal] => (item={'key': 'qauser', 'value': {'password': 'test123'}})

PLAY RECAP ******************************************************************************************************************************************************************************************************
fhm8rvl0jok1tj95tauo.auto.internal : ok=23   changed=1    unreachable=0    failed=0    skipped=17   rescued=0    ignored=0
fhmdmaogjlgnh1kgku1g.auto.internal : ok=5    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

### Задание с ⭐⭐ Настройка ~Travis CI~ GitHub Actions

Так как регистрация в Travis CI в данный момент недоступна, изучаем аналогичный функционал GutHub Actions.  
Запускаем на своем раннере, terraform не может подключиться к зеркалу, ansible-lint выводит ошибку `an AnsibleCollectionFinder has not been installed in this process`.  
Можно было бы собрать свой docker-образ, но не стал уже. Главное, что разобрался как работать с GitHub Actions.  
Выполнял на зеркале репозитория, пример конфига для Actions в [my_tests.yaml](my_tests.yaml).

## Как запустить проект:

## Как проверить работоспособность:

<a name="hw11"></a>
# Выполнено ДЗ № 11 - Локальная разработка Ansible ролей с Vagrant. Тестирование конфигурации

 - [x] Основное ДЗ
 - [x] Задание с ⭐ Дополните конфигурацию Vagrant для корректной работы проксирования приложения с помощью nginx
 - [ ] Задание с ⭐ Подключение Travis CI для автоматического прогона тестов

## В процессе сделано:

1. Развернул тестовый стенд приложения на Vagrant'е.
2. Доработал роли Ansible для провижининга в Vagrant'е.
3. Развернул виртуальное окружение Python VENV
4. Развернул Ansible Molecule, Pytest-Testinfra и зависимости.
5. Провел тестирование ролей при помощи Molecule, Pytest-Testinfra и Vagrant
6. Переключение сбора образов Packer на использование ролей

### Ansible Provision в Vagrant

```shell
$ vagrant up Bringing machine 'dbserver' up with 'virtualbox' provider... Bringing machine 'appserver' up with 'virtualbox' provider... ==> dbserver: Box 'ubuntu/xenial64' could not be found. Attempting to find and install... dbserver: Box Provider: virtualbox dbserver: Box Version: >= 0 ==> dbserver: Loading metadata for box 'ubuntu/xenial64' dbserver: URL: https://vagrant.elab.pro/ubuntu/xenial64 ==> dbserver: Adding box 'ubuntu/xenial64' (v1.0.0) for provider:
...
PLAY [Configure MongoDB] *******************************************************
TASK [Gathering Facts] ********************************************************* ok: [dbserver]
TASK [db : Show info about the env this host belongs to] *********************** ok: [dbserver] => { "msg": "This host is in local environment!!!" }
TASK [db : Add APT key] ******************************************************** changed: [dbserver]
TASK [db : Add APT repository] ************************************************* changed: [dbserver]
TASK [db : Install mongodb package] ******************************************** changed: [dbserver]
TASK [db : Configure service supervisor] *************************************** changed: [dbserver]
TASK [db : Change mongo config file] ******************************************* changed: [dbserver]
RUNNING HANDLER [db : reload systemd] ****************************************** ok: [dbserver]
RUNNING HANDLER [db : restart mongod] ****************************************** changed: [dbserver] [WARNING]: Could not match supplied host pattern, ignoring: app
PLAY [Configure App] *********************************************************** skipping: no hosts matched
PLAY [Deploy App] ************************************************************** skipping: no hosts matched
PLAY RECAP ********************************************************************* dbserver : ok=9 changed=6 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
==> appserver: Box 'ubuntu/xenial64' could not be found. Attempting to find and install... appserver: Box Provider:
...
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)
```
MongoDB работает:
```shell
vagrant@appserver:~$ telnet 192.168.56.10 27017 Trying 192.168.56.10... Connected to 192.168.56.10. Escape character is '^]'.
```
### Задание с ⭐ Дополните конфигурацию Vagrant для корректной работы проксирования приложения с помощью nginx

Задеплоил Nginx, передал через **ansible.extra_vars = "extra_vars.yml"** переменные для настройки роли для проксирования приложения Reddit Monolith.
```shell
$ vagrant provision appserver
==> appserver: Running provisioner: ansible...
    appserver: Running ansible-playbook...
PLAY [Configure MongoDB] *******************************************************
...
TASK [jdauphant.nginx : include_vars] ******************************************
ok: [appserver] => (item=/home/andy/git/otus/devops/ansible-4/roles/jdauphant.nginx/vars/../vars/Debian.yml)
TASK [jdauphant.nginx : include_tasks] *****************************************
skipping: [appserver]
TASK [jdauphant.nginx : include_tasks] *****************************************
skipping: [appserver]
TASK [jdauphant.nginx : include_tasks] *****************************************
included: /home/andy/git/otus/devops/ansible-4/roles/jdauphant.nginx/tasks/installation.packages.yml for appserver
TASK [jdauphant.nginx : Install the epel packages for EL distributions] ********
skipping: [appserver]
TASK [jdauphant.nginx : Install the nginx packages from official repo for EL distributions] ***
skipping: [appserver]
TASK [jdauphant.nginx : Install the nginx packages for all other distributions] ***
changed: [appserver]
TASK [jdauphant.nginx : Create the directories for site specific configurations] ***
ok: [appserver] => (item=sites-available)
ok: [appserver] => (item=sites-enabled)
changed: [appserver] => (item=auth_basic)
ok: [appserver] => (item=conf.d)
changed: [appserver] => (item=conf.d/stream)
ok: [appserver] => (item=snippets)
changed: [appserver] => (item=modules-available)
changed: [appserver] => (item=modules-enabled)
TASK [jdauphant.nginx : Ensure log directory exist] ****************************
ok: [appserver]
TASK [jdauphant.nginx : include_tasks] *****************************************
included: /home/andy/git/otus/devops/ansible-4/roles/jdauphant.nginx/tasks/remove-defaults.yml for appserver
TASK [jdauphant.nginx : Disable the default site] ******************************
changed: [appserver]
TASK [jdauphant.nginx : Disable the default site (on newer nginx versions)] ****
skipping: [appserver]
TASK [jdauphant.nginx : Remove the default configuration] **********************
ok: [appserver]
TASK [jdauphant.nginx : include_tasks] *****************************************
skipping: [appserver]
TASK [jdauphant.nginx : Remove unwanted sites] *********************************
TASK [jdauphant.nginx : Remove unwanted conf] **********************************
TASK [jdauphant.nginx : Remove unwanted snippets] ******************************
TASK [jdauphant.nginx : Remove unwanted auth_basic_files] **********************
TASK [jdauphant.nginx : Copy the nginx configuration file] *********************
changed: [appserver]
TASK [jdauphant.nginx : Ensure auth_basic files created] ***********************
TASK [jdauphant.nginx : Create the configurations for sites] *******************
changed: [appserver] => (item={'key': 'default', 'value': ['listen 80', 'server_name "reddit"', 'location / { proxy_pass http://127.0.0.1:9292; }']})
TASK [jdauphant.nginx : Create links for sites-enabled] ************************
changed: [appserver] => (item={'key': 'default', 'value': ['listen 80', 'server_name "reddit"', 'location / { proxy_pass http://127.0.0.1:9292; }']})
TASK [jdauphant.nginx : Create the configurations for independent config file] ***
TASK [jdauphant.nginx : Create configuration snippets] *************************
TASK [jdauphant.nginx : Create the configurations for independent config file for streams] ***
TASK [jdauphant.nginx : Create links for modules-enabled] **********************
TASK [jdauphant.nginx : include_tasks] *****************************************
skipping: [appserver]
TASK [jdauphant.nginx : include_tasks] *****************************************
skipping: [appserver]
TASK [jdauphant.nginx : Start the nginx service] *******************************
changed: [appserver]
RUNNING HANDLER [app : reload systemd] *****************************************
ok: [appserver]
RUNNING HANDLER [app : restart puma] *******************************************
changed: [appserver]
RUNNING HANDLER [jdauphant.nginx : restart nginx] ******************************
changed: [appserver] => {
    "msg": "checking config first"
}
RUNNING HANDLER [jdauphant.nginx : reload nginx] *******************************
changed: [appserver] => {
    "msg": "checking config first"
}
RUNNING HANDLER [jdauphant.nginx : check nginx configuration] ******************
ok: [appserver]
RUNNING HANDLER [jdauphant.nginx : restart nginx - after config check] *********
changed: [appserver]
RUNNING HANDLER [jdauphant.nginx : reload nginx - after config check] **********
changed: [appserver]
PLAY [Deploy App] **************************************************************
TASK [Gathering Facts] *********************************************************
ok: [appserver]
TASK [Update and upgrade apt packages] *****************************************
ok: [appserver]
TASK [Install git] *************************************************************
ok: [appserver]
TASK [Fetch the latest version of application code] ****************************
changed: [appserver]

TASK [bundle install] **********************************************************
changed: [appserver]

RUNNING HANDLER [restart puma] *************************************************
changed: [appserver]

PLAY RECAP *********************************************************************
appserver                  : ok=33   changed=17   unreachable=0    failed=0    skipped=17   rescued=0    ignored=0   
```

Сайт Reddit курлится по 80 порту:
```shell
$ curl http://192.168.56.20
<!DOCTYPE html>
<html lang='en'>
<head>
</head>
<body>
<div class='navbar navbar-default navbar-static-top'>
<div class='container'>
<div class='navbar-header'>
<button class='navbar-toggle' data-target='.navbar-responsive-collapse' data-toggle='collapse' type='button'>
<span class='icon-bar'></span>
<span class='icon-bar'></span>
<span class='icon-bar'></span>
</button>
<a class='navbar-brand' href='/'>Monolith Reddit</a>
```

### Тестирование ролей при помощи Molecule, Pytest-Testinfra и Vagrant

Инициализация:

```shell
molecule init scenario -r db -d vagrant molecule create

(venv) andy@test:~/git/otus/devops/ansible-4/roles/db$ molecule create WARNING The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration. INFO default scenario test matrix: dependency, create, prepare INFO Performing prerun with role_name_check=0... INFO Set ANSIBLE_LIBRARY=/home/andy/.cache/ansible-compat/7bdc25/modules:/home/andy/.ansible/plugins/modules:/usr/share/ansible/plugins/modules INFO Set ANSIBLE_COLLECTIONS_PATH=/home/andy/.cache/ansible-compat/7bdc25/collections:/home/andy/.ansible/collections:/usr/share/ansible/collections INFO Set ANSIBLE_ROLES_PATH=/home/andy/.cache/ansible-compat/7bdc25/roles:/home/andy/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles INFO Using /home/andy/.cache/ansible-compat/7bdc25/roles/voytenkov.db symlink to current repository in order to enable Ansible to find the role using its expected full name. INFO Running default > dependency WARNING Skipping, missing the requirements file. WARNING Skipping, missing the requirements file. INFO Running default > create
PLAY [Create] ******************************************************************
TASK [Create molecule instance(s)] ********************************************* changed: [localhost]
TASK [Populate instance config dict] ******************************************* ok: [localhost] => (item={'Host': 'instance', 'HostName': '127.0.0.1', 'User': 'vagrant', 'Port': '2222', 'UserKnownHostsFile': '/dev/null', 'StrictHostKeyChecking': 'no', 'PasswordAuthentication': 'no', 'IdentityFile': '/home/andy/.cache/molecule/db/default/.vagrant/machines/instance/virtualbox/private_key', 'IdentitiesOnly': 'yes', 'LogLevel': 'FATAL'})
TASK [Convert instance config dict to a list] ********************************** ok: [localhost]
TASK [Dump instance config] **************************************************** changed: [localhost]
PLAY RECAP ********************************************************************* localhost : ok=4 changed=2 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
INFO Running default > prepare
PLAY [Prepare] *****************************************************************
TASK [Bootstrap python for Ansible] ******************************************** ok: [instance]
PLAY RECAP ********************************************************************* instance : ok=1 changed=0 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
```
Логинимся в тестовый инстанс в Vagrant:
```shell
$ molecule login -h instance WARNING The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration. INFO Running default > login

Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)
```

Запускаем **Convergence**:

```shell
$ molecule converge WARNING The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration.
INFO Running default > converge
PLAY [Converge] ****************************************************************
TASK [Gathering Facts] ********************************************************* ok: [instance]
TASK [Include db] ************************************************************** [DEPRECATION WARNING]: "include" is deprecated, use include_tasks/import_tasks instead. This feature will be removed in version 2.16. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
TASK [db : Show info about the env this host belongs to] *********************** ok: [instance] => { "msg": "This host is in local environment!!!" }
TASK [db : Add APT key] ******************************************************** changed: [instance]
TASK [db : Add APT repository] ************************************************* changed: [instance]
TASK [db : Install mongodb package] ******************************************** changed: [instance]
TASK [db : Configure service supervisor] *************************************** changed: [instance]
TASK [db : Change mongo config file] ******************************************* changed: [instance]
RUNNING HANDLER [db : reload systemd] ****************************************** ok: [instance]
RUNNING HANDLER [db : restart mongod] ****************************************** changed: [instance]
PLAY RECAP ********************************************************************* instance : ok=9 changed=6 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
```
Прогоняем тесты, также проверял, что тесты фейлятся, если задавать некорректные значения:
```shell
$ molecule verify INFO default scenario test matrix: verify INFO Performing prerun with role_name_check=0... INFO Set ANSIBLE_LIBRARY=/home/andy/.cache/ansible-compat/7bdc25/modules:/home/andy/.ansible/plugins/modules:/usr/share/ansible/plugins/modules INFO Set ANSIBLE_COLLECTIONS_PATH=/home/andy/.cache/ansible-compat/7bdc25/collections:/home/andy/.ansible/collections:/usr/share/ansible/collections INFO Set ANSIBLE_ROLES_PATH=/home/andy/.cache/ansible-compat/7bdc25/roles:/home/andy/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles INFO Using /home/andy/.cache/ansible-compat/7bdc25/roles/voytenkov.db symlink to current repository in order to enable Ansible to find the role using its expected full name. INFO Running default > verify INFO Executing Testinfra tests found in /home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/tests/... ============================= test session starts ============================== platform linux -- Python 3.8.10, pytest-7.4.3, pluggy-1.3.0 rootdir: /home/andy plugins: testinfra-8.1.0 collected 3 items

molecule/default/tests/test_default.py ... [100%]

============================== 3 passed in 1.64s =============================== INFO Verifier completed successfully.
```

## Как запустить проект:

## Как проверить работоспособность:

## PR checklist:
 - [x] Выставлен label с темой домашнего задания
