[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)
# DEPRECATED/LOOKING FOR MAINTAINERS -> to be archived soon

[![Actions Status - Master](https://github.com/juju4/ansible-rekall/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-rekall/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-rekall/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-rekall/actions?query=branch%3Adevel)

# Rekall ansible role

Ansible role to setup Rekall Memory Forensic Framework
http://www.rekall-forensic.com/
https://github.com/google/rekall

Warning! Rekall is [no longer maintained](https://github.com/google/rekall) since Oct 2020.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.2
 * 2.9

### Operating systems

Ubuntu 16.04, 18.04, 20.04, Centos7 and Centos8

## Example Playbook

Just include this role in your list.
For example

```
- hosts: all
  roles:
    - juju4.rekall
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.rekall
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.rekall/test/vagrant
$ vagrant up
$ vagrant ssh
```
or
```
$ pip install molecule docker
$ molecule test
$ MOLECULE_DISTRO=ubuntu:18.04 molecule test --destroy=never
```

## Troubleshooting & Known issues

* in kitchen lxd, rekall-server systemd services don't start correctly
```
Failed to kill control group /lxc/default-server-ubuntu-1604-1489354654/system.slice/system-rekall\x2dserver.
```
Works fine under kitchen vagrant (virtualbox)


## License

BSD 2-clause
