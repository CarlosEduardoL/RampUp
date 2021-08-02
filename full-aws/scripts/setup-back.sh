#!/bin/bash
sudo apt-get update
sudo ansible
git clone -b configuration-management https://github.com/CarlosEduardoL/RampUp
cd RampUp/ansible || echo "fail $(ls)" && exit
ansible -i host -l tag_Name_Movies_front_instance site.yml -vvv -e db_host=${db_host} -e db_user="root" -e db_pass=${db_pass} -e tag=${tag}