#!/bin/bash
# Dependencies
declare -a dependencies=("npm" "git" "curl")
echo "the required dependencies for the app are [${dependencies[@]}]"
# Check if the dependency is installed, if not install it
checkAndInstall() {
    [[ $(which $1) != "" ]] && echo "$1 is already installed, skip" || apt -qq install $1 -y &> /dev/null
}
# Update apt
apt -qq update
# install dependencies
for dependency in ${dependencies[@]}
do  
    echo "Installing $dependency"
    checkAndInstall $dependency
done
# Install pm2
echo "Installing pm2"
[[ $(which pm2) != "" ]] && echo "pm2 is already installed, skip" || npm install pm2 -g