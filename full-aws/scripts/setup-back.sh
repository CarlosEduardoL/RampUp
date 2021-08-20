#!/bin/bash
{
  echo "${dns}"
  echo "root"
  echo "${pass}"
} > /home/ubuntu/.container.env
curl ${bastion}:5555/created --header "Content-Type: application/json" --request POST --data '{"Type":1, "Dns":"${dns}"}'