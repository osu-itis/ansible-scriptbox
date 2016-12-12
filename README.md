# ansible-scriptbox

[![Build Status](https://jenkins.sig.oregonstate.edu/job/lint%20ansible-scriptbox/badge/icon)](https://jenkins.sig.oregonstate.edu/job/lint%20ansible-scriptbox/)

Ansible playbook for setting up Jenkins as a script hosting box.

## What Does This Playbook Do Exactly?

* installs and configures Python and virtualenvs
* installs and configures rbenv and ruby
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

## Inventory

We have separated production and staging hosts into separate inventory files:
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
* You have a CentOS7 box that has already been bootstrapped with the `ansible-master` [playbook](https://github.com/osu-itis/ansible-master).
* **Master Hosts Only!** This box is running Jenkins 2. (For best results, use [our ansible playbook](https://github.com/osu-itis/ansible-jenkins2) to install Jenkins.)

1. Add the hostname of the new box to the appropriate inventory file.
1. Run ansible-playbook on the appropriate inventory file, limited to the new hostname:

```
$ cd ansible-scriptbox
$ ansible-playbook -i inventory/stage site.yml --limit newhost.someplace.edu
```

### Update Script Deployments on Production or Stage Hosts

1. Run ansible-playbook on the appropriate inventory file:

```
$ cd ansible-scriptbox
$ ansible-playbook -i inventory/stage deploy.yml
```
