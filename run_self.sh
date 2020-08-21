#!/bin/bash

rm -f ansible.log
ansible-playbook -vv -i hosts self.yml "$@" 
