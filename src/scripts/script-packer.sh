#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Packer na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-packer.sh
# @example:
#       bash script-packer.sh
#-------------------------------------------------------------#

if command -v packer >/dev/null 2>&1; then
    echo "✅ Program(packer) already installed!";
    echo -e "--> Directory:" "$(command -v packer)" "\n";
else
    echo -e "📦 Installing the program: packer...\n";

    wget "https://releases.hashicorp.com/packer/1.13.1/packer_1.13.1_linux_amd64.zip" -O ~/Downloads/packer_amd64.zip;

    sudo unzip -o ~/Downloads/packer_amd64.zip -d /usr/local/bin/;

    mkdir -p ~/.packer;

    packer --version;

    sleep 1s;
fi

exit 0;
