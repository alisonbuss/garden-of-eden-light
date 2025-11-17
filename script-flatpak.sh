#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Flatpak na maquina.
# @fonts: https://flathub.org/pt-BR/setup/Ubuntu
# @example:
#       bash script-flatpak.sh
#-------------------------------------------------------------#

if command -v flatpak >/dev/null 2>&1; then
    echo "✅ Program(flatpak) already installed!";
    echo -e "--> Directory:" "$(command -v flatpak)" "\n";
else
    echo -e "📦 Installing the program: flatpak...\n";

    sudo apt install -y flatpak;

    flatpak --version;

    sudo apt install -y gnome-software-plugin-flatpak;

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo;

    sleep 1s;
fi

exit 0;
