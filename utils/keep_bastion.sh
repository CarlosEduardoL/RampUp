#!/bin/bash
for i in $(terraform state list | grep -v "bastion\|data\|key"); do
  terraform destroy -auto-approve -target="$i"
done