#!/bin/bash
declare -a dependencies=("npm" "git" "nginx")
checkAndInstall() {
    [[ $(which $1) != "" ]] && echo "$1 is already installed, skip" || apt -qq install $1 -y
}
# Update apt
apt -qq update
# install dependencies
for dependency in ${dependencies[@]}
do  
    checkAndInstall $dependency
done
# check if work directory exist or create it
mkdir -p /home/vagrant/ 
cd /home/vagrant/
# check if repo exist or download it
[ -d "/home/vagrant/movie-analyst-api" ] || git clone https://github.com/juan-ruiz/movie-analyst-api
chown -R vagrant /home/vagrant/movie-analyst-api
# go to repo dir
cd /home/vagrant/movie-analyst-api
# Install npm dependencies
npm install
# run app on port 3000 if not running
[[ $(which netstat) != "" ]] || apt -qq install net-tools -y
echo $(curl localhost:3000 &> /dev/null || (export PORT=3000 && nodejs server.js)) &