#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do GitKraken na maquina
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-gitkraken.sh
# @example:
#       bash script-gitkraken.sh
#-------------------------------------------------------------#

if command -v gitkraken >/dev/null 2>&1; then
    echo "✅ Program(gitkraken) already installed!";
    echo -e "--> Directory:" "$(command -v gitkraken)" "\n";
else
    echo -e "📦 Installing the program: gitkraken...\n";

    wget "https://release.gitkraken.com/linux/gitkraken-amd64.deb" -O ~/Downloads/gitkraken.deb;

    sudo dpkg -i ~/Downloads/gitkraken.deb;
	sudo apt install -f;

    sleep 1s;

    echo "GitKraken version:" $(gitkraken --version);
fi

exit 0;
