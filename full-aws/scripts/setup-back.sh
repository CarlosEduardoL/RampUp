#!/bin/bash
{
  echo "DB_HOST=${dns}"
  echo "DB_USER=root"
  echo "DB_PASS=${pass}"
} > /home/ubuntu/.container.env
curl ${bastion}:5555/created --header "Content-Type: application/json" --request POST --data '{"Type":1, "Dns":"${dns}"}'