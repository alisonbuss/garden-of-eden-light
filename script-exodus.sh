#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Exodus Wallet na maquina.
# @fonts: https://www.exodus.com
#         https://www.exodus.com/desktop
#         https://www.exodus.com/releases
# @example:
#       bash script-exodus.sh
#-------------------------------------------------------------#

if command -v exodus >/dev/null 2>&1; then
    echo "✅ Program(Exodus Wallet) already installed!";
    echo -e "--> Directory:" "$(command -v exodus)" "\n";
else
    echo -e "📦 Installing the program: Exodus Wallet...\n";

    wget -U Mozilla "https://downloads.exodus.com/releases/exodus-linux-x64-25.46.5.deb" -O  ~/Downloads/exodus-wallet.deb;

    sudo dpkg -i ~/Downloads/exodus-wallet.deb;
    sudo apt install -f;

    sleep 1s;

    exodus --version;
fi

exit 0;
