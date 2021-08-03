#!/bin/bash
sudo apt-get update
sudo apt-get install ansible -y
git clone -b configuration-management https://github.com/CarlosEduardoL/RampUp
cd RampUp/ansible
ansible-playbook -i 127.0.0.1, -l Movies_front_instance site.yml -vvv -e back_host=${back_host} -e tag=${tag}