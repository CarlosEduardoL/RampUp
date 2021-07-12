#!/bin/bash
echo "Installing Nginx"
[[ $(which nginx) != "" ]] && echo "nginx is already installed, skip" || apt -qq install nginx -y >> /dev/null
mv -f temp/nginx/* /etc/nginx/ && systemctl reload nginx && rm -rf temp