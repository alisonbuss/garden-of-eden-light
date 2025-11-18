#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Insomnia Client.
# @fonts: https://insomnia.rest/download
# @example:
#       bash script-insomnia.sh
#-------------------------------------------------------------#

if command -v insomnia >/dev/null 2>&1; then
    echo "✅ Program(Insomnia) already installed!";
    echo -e "--> Directory:" "$(command -v insomnia)" "\n";
else
    echo -e "📦 Installing the program: Insomnia...\n";

    wget "https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website" -O ~/Downloads/insomnia-desktop.deb;

    sudo dpkg -i ~/Downloads/insomnia-desktop.deb;
    sudo apt install -f;
fi

exit 0;
