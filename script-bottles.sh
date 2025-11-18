#!/bin/bash

# ⚠️ @DEPENDENCIES: [ script-flatpak.sh ]

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do bottles(Run Windows in a Bottle) na maquina.
# @fonts: https://flathub.org/apps/com.usebottles.bottles
#         https://www.youtube.com/watch?v=96b1CdB6OHE
# @example:
#       bash script-bottles.sh
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
readonly FLATPAK_BOTTLES="/var/lib/flatpak/exports/bin/com.usebottles.bottles";

if command -v $FLATPAK_BOTTLES >/dev/null 2>&1; then
    echo "✅ Program(Bottles) already installed!";
    echo -e "--> Directory:" "$(command -v $FLATPAK_BOTTLES)" "\n";
else
    echo -e "📦 Installing the program: Bottles...\n";

    sudo flatpak install flathub com.usebottles.bottles -y;

    flatpak run com.usebottles.bottles --version;

    sleep 1s;

    flatpak info com.usebottles.bottles;

    # Wine In Docker
    # https://leimao.github.io/blog/Docker-Wine

    # Executando o WineHQ dentro de um contêiner docker
    # https://dev.to/flpslv/running-winehq-inside-a-docker-container-52ej
fi

exit 0;
