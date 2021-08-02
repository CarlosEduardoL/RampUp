#!/bin/bash
sudo apt-get update
sudo apt-get install ansible -y
git clone -b configuration-management https://github.com/CarlosEduardoL/RampUp
cd RampUp/ansible
ansible-playbook -i host -l tag_Name_Movies_back_instance site.yml -vvv -e db_host=${db_host} -e db_user="root" -e db_pass=${db_pass} -e tag=${tag}