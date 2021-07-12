#!/bin/bash
source ./scripts/install-dependencies.sh
project="movie-analyst-api"
# check if work directory exist or create it
mkdir -p /home/vagrant/ 
cd /home/vagrant/
# check if repo exist or download it
repo="/home/vagrant/$project"
[ -d $repo ] || git clone "https://github.com/juan-ruiz/$project.git"
chown -R vagrant $repo
# go to repo dir
cd $repo
# Install npm dependencies
npm install
# run app on port 3000 if not running
port="3000" # app port
curl localhost:$port &> /dev/null || ( export PORT=$port && pm2 start server.js )