#!/bin/bash
# Dependencies
declare -a dependencies=("npm" "git")
# Check if the dependency is instaled, if not intall it
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