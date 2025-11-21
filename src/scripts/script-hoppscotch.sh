#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Hoppscotch Client.
# @fonts: https://hoppscotch.com/download
# @example:
#       bash script-hoppscotch.sh
#-------------------------------------------------------------#

if command -v hoppscotch-desktop >/dev/null 2>&1; then
    echo "✅ Program(hoppscotch-desktop) already installed!";
    echo -e "--> Directory:" "$(command -v hoppscotch-desktop)" "\n";
else
    echo -e "📦 Installing the program: hoppscotch-desktop...\n";

    wget "https://github.com/hoppscotch/releases/releases/latest/download/Hoppscotch_linux_x64.deb" -O ~/Downloads/hoppscotch-desktop.deb;

    sudo dpkg -i ~/Downloads/hoppscotch-desktop.deb;
    sudo apt install -f;

    sleep 1s;
fi

exit 0;
