# #!/bin/bash
# component=$1
# environment=$2
yum install python3.11-devel python3.11-pip -y
pip3.11 install ansible botocore boto3
sudo dnf update -y openssl\* openssh\* -y
sudo systemctl restart sshd
#ansible-pull -U https://github.com/pjuned/ansible_roles_with_template-tf.git -e component=$component -e env=$environment main-tf.yaml

# /usr/local/bin/ansible-pull \ -U https://github.com/pjuned/ansible_roles_with_template-tf.git -e component=$component -e env=$environment main-tf.yaml



#!/bin/bash

component=$1
env=$2
dnf install ansible -y
#ansible-pull -U https://github.com/daws-86s/ansible-roboshop-roles-tf.git -e component=$component main.yaml
# git clone ansible-playbook
# cd ansible-playbook
# ansible-playbook -i inventory main.yaml

REPO_URL=https://github.com/pjuned/ansible_roles_with_template-tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible_roles_with_template-tf

mkdir -p $REPO_DIR
mkdir -p /var/log/roboshop/
touch ansible.log

cd $REPO_DIR

# check if ansible repo is already cloned or not

if [ -d $ANSIBLE_DIR ]; then

    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi

ansible-playbook -e component=$component -e env=$env main-tf.yaml