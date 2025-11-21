#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Flatpak na maquina.
# @fonts: https://flatpak.org
#         https://flatpak.org/setup
#         https://flathub.org/pt-BR/setup/Ubuntu
#         https://flathub.org/en/apps/com.github.tchx84.Flatseal
# @example:
#       bash script-flatpak.sh
#-------------------------------------------------------------#
#
# Nesses diretórios, você encontrará os links simbólicos dos binários executáveis do Flatpak:
#
# Para instalação em todo o sistema:
# $ ls /var/lib/flatpak/exports/bin/
#
# Para instalação por usuário:
# $ ls ~/.local/share/flatpak/exports/bin/
#

if command -v flatpak >/dev/null 2>&1; then
    echo "✅ Program(flatpak) already installed!";
    echo -e "--> Directory:" "$(command -v flatpak)" "\n";
else
    echo -e "📦 Installing the program: flatpak...\n";

    sudo apt install -y flatpak;
    sudo apt install -y gnome-software-plugin-flatpak;

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo;

    sleep 1s;

    # Flatseal é um utilitário gráfico para gerenciar permissões de seus aplicativos Flatpak.
    sudo flatpak install flathub com.github.tchx84.Flatseal -y;

    sleep 1s;

    flatpak --version;
    flatpak list;
fi

exit 0;
