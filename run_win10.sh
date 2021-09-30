#!/bin/bash

rm -f ansible.log
ansible-playbook -vv -i hosts win10.yml "$@"
