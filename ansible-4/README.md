https://habr.com/ru/articles/735700/
https://docs.python-guide.org/dev/virtualenvs/


$ vagrant up
Bringing machine 'dbserver' up with 'virtualbox' provider...
Bringing machine 'appserver' up with 'virtualbox' provider...
==> dbserver: Box 'ubuntu/xenial64' could not be found. Attempting to find and install...
    dbserver: Box Provider: virtualbox
    dbserver: Box Version: >= 0
==> dbserver: Loading metadata for box 'ubuntu/xenial64'
    dbserver: URL: https://vagrant.elab.pro/ubuntu/xenial64
==> dbserver: Adding box 'ubuntu/xenial64' (v1.0.0) for provider: virtualbox
    dbserver: Downloading: http://vagrant.elab.pro:80/ubuntu/xenial64/1.0.0/virtualbox
==> dbserver: Successfully added box 'ubuntu/xenial64' (v1.0.0) for 'virtualbox'!
==> dbserver: Importing base box 'ubuntu/xenial64'...
==> dbserver: Matching MAC address for NAT networking...
==> dbserver: Checking if box 'ubuntu/xenial64' version '1.0.0' is up to date...
==> dbserver: Setting the name of the VM: ansible-4_dbserver_1698268430013_54318
==> dbserver: Clearing any previously set network interfaces...
==> dbserver: Preparing network interfaces based on configuration...
    dbserver: Adapter 1: nat
    dbserver: Adapter 2: hostonly
==> dbserver: Forwarding ports...
    dbserver: 22 (guest) => 2222 (host) (adapter 1)
==> dbserver: Running 'pre-boot' VM customizations...
==> dbserver: Booting VM...
==> dbserver: Waiting for machine to boot. This may take a few minutes...
    dbserver: SSH address: 127.0.0.1:2222
    dbserver: SSH username: vagrant
    dbserver: SSH auth method: private key
    dbserver: Warning: Connection reset. Retrying...
    dbserver: Warning: Remote connection disconnect. Retrying...
    dbserver: 
    dbserver: Vagrant insecure key detected. Vagrant will automatically replace
    dbserver: this with a newly generated keypair for better security.
    dbserver: 
    dbserver: Inserting generated public key within guest...
    dbserver: Removing insecure key from the guest if it's present...
    dbserver: Key inserted! Disconnecting and reconnecting using new SSH key...
==> dbserver: Machine booted and ready!
==> dbserver: Checking for guest additions in VM...
    dbserver: The guest additions on this VM do not match the installed version of
    dbserver: VirtualBox! In most cases this is fine, but in rare cases it can
    dbserver: prevent things such as shared folders from working properly. If you see
    dbserver: shared folder errors, please make sure the guest additions within the
    dbserver: virtual machine match the version of VirtualBox you have installed on
    dbserver: your host and reload your VM.
    dbserver: 
    dbserver: Guest Additions Version: 5.1.38
    dbserver: VirtualBox Version: 6.1
==> dbserver: Setting hostname...
==> dbserver: Configuring and enabling network interfaces...
==> dbserver: Mounting shared folders...
    dbserver: /vagrant => /home/andy/git/otus/devops/ansible-4
==> dbserver: Running provisioner: ansible...
    dbserver: Running ansible-playbook...
[DEPRECATION WARNING]: "include" is deprecated, use include_tasks/import_tasks 
instead. This feature will be removed in version 2.16. Deprecation warnings can
 be disabled by setting deprecation_warnings=False in ansible.cfg.
[WARNING]: While constructing a mapping from /home/andy/git/otus/devops/ansible
-4/roles/jdauphant.nginx/tasks/configuration.yml, line 62, column 3, found a
duplicate dict key (when). Using last defined value only.

PLAY [Configure MongoDB] *******************************************************

TASK [Gathering Facts] *********************************************************
ok: [dbserver]

TASK [db : Show info about the env this host belongs to] ***********************
ok: [dbserver] => {
    "msg": "This host is in local environment!!!"
}

TASK [db : Add APT key] ********************************************************
changed: [dbserver]

TASK [db : Add APT repository] *************************************************
changed: [dbserver]

TASK [db : Install mongodb package] ********************************************
changed: [dbserver]

TASK [db : Configure service supervisor] ***************************************
changed: [dbserver]

TASK [db : Change mongo config file] *******************************************
changed: [dbserver]

RUNNING HANDLER [db : reload systemd] ******************************************
ok: [dbserver]

RUNNING HANDLER [db : restart mongod] ******************************************
changed: [dbserver]
[WARNING]: Could not match supplied host pattern, ignoring: app

PLAY [Configure App] ***********************************************************
skipping: no hosts matched

PLAY [Deploy App] **************************************************************
skipping: no hosts matched

PLAY RECAP *********************************************************************
dbserver                   : ok=9    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

==> appserver: Box 'ubuntu/xenial64' could not be found. Attempting to find and install...
    appserver: Box Provider: virtualbox
    appserver: Box Version: >= 0
==> appserver: Loading metadata for box 'ubuntu/xenial64'
    appserver: URL: https://vagrant.elab.pro/ubuntu/xenial64
==> appserver: Adding box 'ubuntu/xenial64' (v1.0.0) for provider: virtualbox
==> appserver: Importing base box 'ubuntu/xenial64'...
==> appserver: Matching MAC address for NAT networking...
==> appserver: Checking if box 'ubuntu/xenial64' version '1.0.0' is up to date...
==> appserver: Setting the name of the VM: ansible-4_appserver_1698268504305_51251
==> appserver: Fixed port collision for 22 => 2222. Now on port 2200.
==> appserver: Clearing any previously set network interfaces...
==> appserver: Preparing network interfaces based on configuration...
    appserver: Adapter 1: nat
    appserver: Adapter 2: hostonly
==> appserver: Forwarding ports...
    appserver: 22 (guest) => 2200 (host) (adapter 1)
==> appserver: Running 'pre-boot' VM customizations...
==> appserver: Booting VM...
==> appserver: Waiting for machine to boot. This may take a few minutes...
    appserver: SSH address: 127.0.0.1:2200
    appserver: SSH username: vagrant
    appserver: SSH auth method: private key
    appserver: Warning: Connection reset. Retrying...
    appserver: Warning: Remote connection disconnect. Retrying...
    appserver: 
    appserver: Vagrant insecure key detected. Vagrant will automatically replace
    appserver: this with a newly generated keypair for better security.
    appserver: 
    appserver: Inserting generated public key within guest...
    appserver: Removing insecure key from the guest if it's present...
    appserver: Key inserted! Disconnecting and reconnecting using new SSH key...
==> appserver: Machine booted and ready!
==> appserver: Checking for guest additions in VM...
    appserver: The guest additions on this VM do not match the installed version of
    appserver: VirtualBox! In most cases this is fine, but in rare cases it can
    appserver: prevent things such as shared folders from working properly. If you see
    appserver: shared folder errors, please make sure the guest additions within the
    appserver: virtual machine match the version of VirtualBox you have installed on
    appserver: your host and reload your VM.
    appserver: 
    appserver: Guest Additions Version: 5.1.38
    appserver: VirtualBox Version: 6.1
==> appserver: Setting hostname...
==> appserver: Configuring and enabling network interfaces...
==> appserver: Mounting shared folders...
    appserver: /vagrant => /home/andy/git/otus/devops/ansible-4
andy@test:~/git/otus/devops/ansible-4$ ssh appserver
ssh: Could not resolve hostname appserver: Name or service not known
andy@test:~/git/otus/devops/ansible-4$ vagrant ssh appserver
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

UA Infra: Extended Security Maintenance (ESM) is not enabled.

0 updates can be applied immediately.

45 additional security updates can be applied with UA Infra: ESM
Learn more about enabling UA Infra: ESM service for Ubuntu 16.04 at
https://ubuntu.com/16-04

New release '18.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@appserver:~$ telnet 192.168.56.10 27017
Trying 192.168.56.10...
Connected to 192.168.56.10.
Escape character is '^]'.

$ vagrant provision appserver
==> appserver: Running provisioner: ansible...
    appserver: Running ansible-playbook...
[DEPRECATION WARNING]: "include" is deprecated, use include_tasks/import_tasks 
instead. This feature will be removed in version 2.16. Deprecation warnings can
 be disabled by setting deprecation_warnings=False in ansible.cfg.
[WARNING]: While constructing a mapping from /home/andy/git/otus/devops/ansible
-4/roles/jdauphant.nginx/tasks/configuration.yml, line 62, column 3, found a
duplicate dict key (when). Using last defined value only.
[WARNING]: Could not match supplied host pattern, ignoring: db

PLAY [Configure MongoDB] *******************************************************
skipping: no hosts matched

PLAY [Configure App] ***********************************************************

TASK [Gathering Facts] *********************************************************
ok: [appserver]

TASK [app : Show info about the env this host belongs to] **********************
ok: [appserver] => {
    "msg": "This host is in local environment!!!"
}

TASK [app : Add APT repository] ************************************************
ok: [appserver]

TASK [app : Update and upgrade apt packages] ***********************************
ok: [appserver]

TASK [app : Install ruby and rubygems and required packages] *******************
ok: [appserver] => (item=ruby-full)
ok: [appserver] => (item=build-essential)
ok: [appserver] => (item=git)
ok: [appserver] => (item=policykit-1)
ok: [appserver] => (item=rvm)

TASK [app : Install bundler 1.16.1] ********************************************
ok: [appserver]

TASK [app : Add config for DB connection] **************************************
changed: [appserver]

TASK [app : Add unit file for Puma] ********************************************
changed: [appserver]

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

andy@test:~/git/otus/devops/ansible-4$ curl http://192.168.56.20
<!DOCTYPE html>
<html lang='en'>
<head>
<meta charset='utf-8'>
<meta content='IE=Edge,chrome=1' http-equiv='X-UA-Compatible'>
<meta content='width=device-width, initial-scale=1.0' name='viewport'>
<title>Monolith Reddit :: All posts</title>
<link crossorigin='anonymous' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css' integrity='sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7' rel='stylesheet' type='text/css'>
<link crossorigin='anonymous' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css' integrity='sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r' rel='stylesheet' type='text/css'>
<script crossorigin='anonymous' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js' integrity='sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS'></script>
<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js'></script>
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

-------------------------------------------------------
Molecule
-------------------------------------------------------
pip install --user pipenv
pipenv install requests

https://docs.python-guide.org/dev/virtualenvs/

https://virtualenvwrapper.readthedocs.io/en/latest/install.html

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh

-------------------------------------------------------
pip install molecule-vagrant

https://github.com/ansible-community/molecule-vagrant

molecule init scenario -r db -d vagrant
molecule create

(venv) andy@test:~/git/otus/devops/ansible-4/roles/db$ molecule create
WARNING  The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration.
INFO     default scenario test matrix: dependency, create, prepare
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/andy/.cache/ansible-compat/7bdc25/modules:/home/andy/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/andy/.cache/ansible-compat/7bdc25/collections:/home/andy/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/andy/.cache/ansible-compat/7bdc25/roles:/home/andy/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/andy/.cache/ansible-compat/7bdc25/roles/voytenkov.db symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > create

PLAY [Create] ******************************************************************

TASK [Create molecule instance(s)] *********************************************
changed: [localhost]

TASK [Populate instance config dict] *******************************************
ok: [localhost] => (item={'Host': 'instance', 'HostName': '127.0.0.1', 'User': 'vagrant', 'Port': '2222', 'UserKnownHostsFile': '/dev/null', 'StrictHostKeyChecking': 'no', 'PasswordAuthentication': 'no', 'IdentityFile': '/home/andy/.cache/molecule/db/default/.vagrant/machines/instance/virtualbox/private_key', 'IdentitiesOnly': 'yes', 'LogLevel': 'FATAL'})

TASK [Convert instance config dict to a list] **********************************
ok: [localhost]

TASK [Dump instance config] ****************************************************
changed: [localhost]

PLAY RECAP *********************************************************************
localhost                  : ok=4    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Running default > prepare

PLAY [Prepare] *****************************************************************

TASK [Bootstrap python for Ansible] ********************************************
ok: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=1    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

$ molecule list
WARNING  The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration.
INFO     Running default > list
                ╷             ╷                  ╷               ╷         ╷            
  Instance Name │ Driver Name │ Provisioner Name │ Scenario Name │ Created │ Converged  
╶───────────────┼─────────────┼──────────────────┼───────────────┼─────────┼───────────╴
  instance      │ vagrant     │ ansible          │ default       │ true    │ false      
                ╵             ╵                  ╵               ╵         ╵            

molecule login -h instance

$ molecule login -h instance
WARNING  The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration.
INFO     Running default > login
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

UA Infra: Extended Security Maintenance (ESM) is not enabled.

0 updates can be applied immediately.

45 additional security updates can be applied with UA Infra: ESM
Learn more about enabling UA Infra: ESM service for Ubuntu 16.04 at
https://ubuntu.com/16-04

New release '18.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Fri Oct 27 13:16:45 2023 from 10.0.2.2

$ molecule converge
WARNING  The scenario config file ('/home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/molecule.yml') has been modified since the scenario was created. If recent changes are important, reset the scenario with 'molecule destroy' to clean up created items or 'molecule reset' to clear current configuration.
INFO     default scenario test matrix: dependency, create, prepare, converge
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/andy/.cache/ansible-compat/7bdc25/modules:/home/andy/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/andy/.cache/ansible-compat/7bdc25/collections:/home/andy/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/andy/.cache/ansible-compat/7bdc25/roles:/home/andy/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/andy/.cache/ansible-compat/7bdc25/roles/voytenkov.db symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > create
WARNING  Skipping, instances already created.
INFO     Running default > prepare
WARNING  Skipping, instances already prepared.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include db] **************************************************************
[DEPRECATION WARNING]: "include" is deprecated, use include_tasks/import_tasks 
instead. This feature will be removed in version 2.16. Deprecation warnings can
 be disabled by setting deprecation_warnings=False in ansible.cfg.

TASK [db : Show info about the env this host belongs to] ***********************
ok: [instance] => {
    "msg": "This host is in local environment!!!"
}

TASK [db : Add APT key] ********************************************************
changed: [instance]

TASK [db : Add APT repository] *************************************************
changed: [instance]

TASK [db : Install mongodb package] ********************************************
changed: [instance]

TASK [db : Configure service supervisor] ***************************************
changed: [instance]

TASK [db : Change mongo config file] *******************************************
changed: [instance]

RUNNING HANDLER [db : reload systemd] ******************************************
ok: [instance]

RUNNING HANDLER [db : restart mongod] ******************************************
changed: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=9    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

-------------------------------------------------------------------------------------------

$ molecule login -h instance
INFO     Running default > login
Welcome to Ubuntu 16.04.7 LTS (GNU/Linux 4.4.0-210-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

UA Infra: Extended Security Maintenance (ESM) is not enabled.

0 updates can be applied immediately.

45 additional security updates can be applied with UA Infra: ESM
Learn more about enabling UA Infra: ESM service for Ubuntu 16.04 at
https://ubuntu.com/16-04

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

New release '18.04.6 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Fri Oct 27 13:38:46 2023 from 10.0.2.2

-------------------------------------------------------------------------------------------

$ molecule converge
INFO     default scenario test matrix: dependency, create, prepare, converge
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/andy/.cache/ansible-compat/7bdc25/modules:/home/andy/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/andy/.cache/ansible-compat/7bdc25/collections:/home/andy/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/andy/.cache/ansible-compat/7bdc25/roles:/home/andy/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/andy/.cache/ansible-compat/7bdc25/roles/voytenkov.db symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > dependency
WARNING  Skipping, missing the requirements file.
WARNING  Skipping, missing the requirements file.
INFO     Running default > create
WARNING  Skipping, instances already created.
INFO     Running default > prepare
WARNING  Skipping, instances already prepared.
INFO     Running default > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include db] **************************************************************
[DEPRECATION WARNING]: "include" is deprecated, use include_tasks/import_tasks 
instead. This feature will be removed in version 2.16. Deprecation warnings can
 be disabled by setting deprecation_warnings=False in ansible.cfg.

TASK [db : Show info about the env this host belongs to] ***********************
ok: [instance] => {
    "msg": "This host is in local environment!!!"
}

TASK [db : Add APT key] ********************************************************
changed: [instance]

TASK [db : Add APT repository] *************************************************
changed: [instance]

TASK [db : Install mongodb package] ********************************************
changed: [instance]

TASK [db : Configure service supervisor] ***************************************
changed: [instance]

TASK [db : Change mongo config file] *******************************************
changed: [instance]

RUNNING HANDLER [db : reload systemd] ******************************************
ok: [instance]

RUNNING HANDLER [db : restart mongod] ******************************************
changed: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=9    changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

---------------------------------------------------------------------------------
$ molecule verify
INFO     default scenario test matrix: verify
INFO     Performing prerun with role_name_check=0...
INFO     Set ANSIBLE_LIBRARY=/home/andy/.cache/ansible-compat/7bdc25/modules:/home/andy/.ansible/plugins/modules:/usr/share/ansible/plugins/modules
INFO     Set ANSIBLE_COLLECTIONS_PATH=/home/andy/.cache/ansible-compat/7bdc25/collections:/home/andy/.ansible/collections:/usr/share/ansible/collections
INFO     Set ANSIBLE_ROLES_PATH=/home/andy/.cache/ansible-compat/7bdc25/roles:/home/andy/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles
INFO     Using /home/andy/.cache/ansible-compat/7bdc25/roles/voytenkov.db symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Running default > verify
INFO     Executing Testinfra tests found in /home/andy/git/otus/devops/ansible-4/roles/db/molecule/default/tests/...
============================= test session starts ==============================
platform linux -- Python 3.8.10, pytest-7.4.3, pluggy-1.3.0
rootdir: /home/andy
plugins: testinfra-8.1.0
collected 3 items

molecule/default/tests/test_default.py ...                               [100%]

============================== 3 passed in 1.64s ===============================
INFO     Verifier completed successfully.

