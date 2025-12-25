#!/bin/bash
component=$1
environment=$2
yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible botocore boto3
sudo dnf update -y openssl\* openssh\* -y
sudo systemctl restart sshd
#ansible-pull -U https://github.com/pjuned/ansible_roles_with_template-tf.git -e component=$component -e env=$environment main-tf.yaml

/usr/local/bin/ansible-pull \ -U https://github.com/pjuned/ansible_roles_with_template-tf.git -e component=$component -e env=$environment main-tf.yaml