#!/bin/bash
curl ${bastion}:5555/created --header "Content-Type: application/json" --request POST --data '{"Type":0, "Dns":"${dns}"}'