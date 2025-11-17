#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do DBeaver na maquina
# @fonts: https://dbeaver.io/download/
# @example:
#       bash script-dbeaver-community.sh
#-------------------------------------------------------------#

if command -v dbeaver-ce >/dev/null 2>&1; then
    echo "✅ Program(dbeaver-ce) already installed!";
    echo -e "--> Directory:" "$(command -v dbeaver-ce)" "\n";
else
    echo -e "📦 Installing the program: dbeaver-ce...\n";

    wget "https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb" -O ~/Downloads/dbeaver-ce.deb;

    sudo dpkg -i ~/Downloads/dbeaver-ce.deb;
	sudo apt install -f;

    sleep 1s;

    dbeaver-ce --version;
fi

exit 0;
