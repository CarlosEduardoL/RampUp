#!/bin/bash
source ./scripts/install-dependencies.sh
proxy="192.168.33.50"
project="movie-analyst-ui"
# check if work directory exist or create it
mkdir -p /home/vagrant/ 
cd /home/vagrant/
# check if repo exist or download it
repo="/home/vagrant/$project"
[ -d $repo ] || git clone "https://github.com/juan-ruiz/$project.git"
chown -R vagrant $repo
# go to repo dir
cd $repo
sed -i 's/:3000//g' server.js
# Install npm dependencies
npm install
# run app on port 3000 if not running
curl localhost:$port &> /dev/null || ( export BACK_HOST="$proxy/back" && nodejs server.js ) &