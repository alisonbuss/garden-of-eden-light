#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do AWS CLI na maquina.
# @fonts: https://docs.aws.amazon.com/cli/v1/userguide/install-linux.html
# @example:
#       bash script-aws.sh
#-------------------------------------------------------------#

if command -v aws >/dev/null 2>&1; then
    echo "✅ Program(aws) already installed!";
    echo -e "--> Directory:" "$(command -v aws)" "\n";
else
    echo -e "📦 Installing the program: aws...\n";

    wget "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -O ~/Downloads/awscli-bundle.zip;

    unzip -o ~/Downloads/awscli-bundle.zip -d ~/Downloads;

    sudo python3 ~/Downloads/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws;

    aws --version;

    sleep 1s;
fi

exit 0;
