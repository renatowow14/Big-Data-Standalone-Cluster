#!/bin/bash

# Install your public key in remote hosts
# 
# Process:
#  - Parse an Ansible inventory file from stdin to obtain the host list
#  - Run ssh-keyscan on all hosts, adding output to $MY_KNOWN_HOSTS file
#  - Execute an Ansible playbook to install $MY_PUB_KEY in the remote host
#
# Requires Ansible, sshpass, and ssh-keyscan

# exit on error
set -e

##### VARS #####
MY_USERNAME=`whoami`
MY_PUB_KEY=`cat ~/.ssh/id_rsa.pub`
MY_KNOWN_HOSTS=~/.ssh/known_hosts
MY_VAULT_PW_FILE=/home/renato/bigdata-docker/Hadoop/Hadoop-Docker-Cluster/ansible/.vault_password
################

if [ -z "$1" ]
then
    echo "Usage: $0 [path to Ansible inventory]"
    exit 99
fi

# Use Ansible to parse the inventory file to a string of hosts
HOSTS=`ansible all -i $1 --list-hosts --vault-password-file=$MY_VAULT_PW_FILE | sed '/hosts.*:/d; s/ //g'`

# Add each host key to known hosts
while read -r line; do
    ssh-keyscan -t ssh-rsa  $line >> $MY_KNOWN_HOSTS
done <<< "$HOSTS"

# Remove duplicates added from the keyscan
sort $MY_KNOWN_HOSTS | uniq > $MY_KNOWN_HOSTS.uniq
mv $MY_KNOWN_HOSTS{.uniq,}

# Kick off an Ansible playbook to copy your public key to the remote hosts
TMP_PLAYBOOK=$(mktemp) || { echo "Failed to create temp Ansible Playbook"; exit 1; }
cat <<EOF > $TMP_PLAYBOOK
---
- name: Install SSH key
  hosts: all
  become_user: root
  tasks:
    - name: Add your authorized key on remote hosts
      authorized_key:
        user: "{{ my_username|trim }}"
        key: "{{ my_public_key|trim }}"
EOF

ansible-playbook -i $1 $TMP_PLAYBOOK --ask-pass --vault-password-file=$MY_VAULT_PW_FILE \
  -e "my_username=$MY_USERNAME" \
  -e "my_public_key=\"$MY_PUB_KEY\""

rm -f $TMP_PLAYBOOK