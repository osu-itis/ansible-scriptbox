# ansible-scriptbox

Ansible playbook for setting up Jenkins as a script hosting box.

## What Does This Playbook Do Exactly?

* installs and configures Python and virtualenvs
* installs and configures rbenv and ruby
* installs perl modules
* deploys `citrixcc-taskmaster` script
* deploys `vmware-rbscripts`

## Configuration

Example group config file `group_vars/prod`:

```
---
common:
    jenkins_home: /var/lib/jenkins
    scripts_dir: /opt/scripts
    ruby_version: 2.1.7
    oracle_instantclient_packages:
        - oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
        - oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
        - oracle-instantclient11.2-odbc-11.2.0.4.0-1.x86_64.rpm
        - oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm
citrixcc_taskmaster:
    git_repo_url: "https://github.com/osu-sig/citrixcc-taskmaster.git"
    version: changeme_to_sha1_hash_or_tag_name
    endpoint_base: "https://cmdctrhost.someplace.edu/nitro/v1/"
    username: changeme
    password: changeme
vmware_rbscripts:
    git_repo_url: "https://github.com/osu-sig/vmware-rbscripts.git"
    version: changeme_to_sha1_hash_or_tag_name
```

### Configuration for Perl Environments

`DBD::Oracle` requires Oracle instant client to be installed. Before running this playbook, [download the required packages from Oracle](http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html) for `basic`, `devel`, `odbc`, and `sqlplus` and place them in `/tmp/` on your local machine. Then, update the appropriate `group_vars` file with the correct filenames.

## Inventory

We have separated production and staging hosts into different inventory files:
* `inventory/prod`
* `inventory/stage`

Example inventory file:

```
[stage]
jenk-vs01.someplace.edu
jenk-slave-vs01.someplace.edu
```

## Usage

### Add New Master or Slave

**Assumptions:**
* You have a CentOS7 box that has been bootstrapped with the `ansible-master` [playbook](https://github.com/osu-itis/ansible-master).
* **If this box is going to be the master server,** it should already be running Jenkins 2. (For best results, use [our ansible playbook](https://github.com/osu-itis/ansible-jenkins2) to install Jenkins.)

1. Add the hostname of the new box to the appropriate inventory file.
1. Run ansible-playbook on the appropriate inventory file, limited to the new hostname:

```
$ ansible-playbook -i inventory/stage site.yml --limit newhost.someplace.edu
```

**If you do not limit by hostname, the playbook will run on all hosts in the environment, which is probably not what you want.**

### Update Script Deployments on Hosts

1. Run ansible-playbook on the appropriate inventory file:

```
$ ansible-playbook -i inventory/stage deploy.yml
```

### Install a Specific Language Environment on a Specific Host

By default, this playbook will install all language environments (python, ruby, perl) on all hosts. You can choose specific environments to install on specific hosts using the `-l` and `-t` flags.

* Use the `-l` flag to specify the target host. If not defined, the playbook will run on all hosts in the inventory file.
* Use the `-t` flag to specify the environment to install. Supported values are: `perl`, `ruby`, `python`

```
$ ansible-playbook -i inventory/stage site.yml -l targethost.someplace.edu -t perl
```
