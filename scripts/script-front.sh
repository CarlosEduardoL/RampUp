#!/bin/bash
source ./scripts/install-dependencies.sh
back=$1
project="movie-analyst-ui"
# check if work directory exist or create it
mkdir -p /home/vagrant/ 
cd /home/vagrant/
# check if repo exist or download it
repo="/home/vagrant/$project"
echo "cloning project on $repo"
[ -d $repo ] || git clone "https://github.com/juan-ruiz/$project.git"
chown -R vagrant $repo
# go to repo dir
cd $repo
# Install npm dependencies
npm install
# run app on port 3030 if not running
curl localhost:3030 &> /dev/null || ( export BACK_HOST="$back" && pm2 start server.js )