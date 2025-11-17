#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Ansible na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-ansible.sh
# @example:
#       bash script-ansible.sh
#-------------------------------------------------------------#

if command -v ansible >/dev/null 2>&1; then
    echo "✅ Program(ansible) already installed!";
    echo -e "--> Directory:" "$(command -v ansible)" "\n";
else
    echo -e "📦 Installing the program: ansible...\n";

    sudo add-apt-repository -y ppa:ansible/ansible;
    sudo apt-get update;

    sudo apt-get install -y ansible;

    ansible --version;

    sleep 1s;
fi

exit 0;
