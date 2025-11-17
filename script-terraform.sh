#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Terraform na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-terraform.sh
# @example:
#       bash script-terraform.sh
#-------------------------------------------------------------#

if command -v terraform >/dev/null 2>&1; then
    echo "✅ Program(terraform) already installed!";
    echo -e "--> Directory:" "$(command -v terraform)" "\n";
else
    echo -e "📦 Installing the program: terraform...\n";

    wget "https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip" -O ~/Downloads/terraform_amd64.zip;

    sudo unzip -o ~/Downloads/terraform_amd64.zip -d /usr/local/bin/;

    mkdir -p ~/.terraform;

    # Install tool for creating diagrams/graphs using Graphviz + Terraform.
    sudo apt install -y graphviz;

    terraform --version;

    sleep 1s;
fi

exit 0;
