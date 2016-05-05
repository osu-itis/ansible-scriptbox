# ansible-scriptbox

Ansible playbook for a generic script hosting box. This replaces `vaccessbuild`.

## What Does This Playbook Do Exactly?

* configures CentOS, creates script user account, installs git and corkscrew
* installs and configures Python and virtualenvs
* installs and configures rbenv and ruby
* deploys `citrixcc-taskmaster` script
* deploys `vmware-rbscripts`

## Configuration

In `group_vars/all`:

```
---
common:
    scripts_home: /home/scripts
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

## Usage

1. Bootstrap a CentOS7 box and run the `ansible-master` [playbook](https://github.com/osu-itis/ansible-master).
1. Add the hostname of the new box to the `hosts` inventory file.
1. Run ansible:

```
$ cd ansible-scriptbox
$ ansible-playbook -i hosts site.yml
```
