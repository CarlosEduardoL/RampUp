#!/bin/bash
[[ $(which nginx) != "" ]] && echo "nginx is already installed, skip" || apt -qq install nginx -y