#!/bin/bash
cd ../ansible/playbooks || (echo fail && exit)
file="host$RANDOM"
echo -e "[bastion]\n$1" > $file
ansible-playbook -i $file -e db_pass="$2" -e address="$3" -e tag="0.0.1" --private-key ~/.ssh/id_rsa -u ubuntu bastion.yml
rm -f $file