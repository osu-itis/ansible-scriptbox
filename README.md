# ansible-scriptbox

Ansible playbook for a generic script hosting box. This replaces `vaccessbuild`.

## What Does This Playbook Do Exactly?

* configures CentOS, creates script user account, installs git and corkscrew
* installs and configures Python and virtualenvs
* deploys `citrix-taskmaster` script

## TODO

* install and configure Ruby and rbenv
* deploy `vmware-rbscripts`

## Usage

First, bootstrap a CentOS7 box and run the `ansible-master` playbook.

Then:

```
$ cd ansible-scriptbox
$ ansible-playbook -i hosts site.yml
```
