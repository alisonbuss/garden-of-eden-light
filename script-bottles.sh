#!/bin/bash

# ⚠️ @DEPENDENCIES: [ script-flatpak.sh ]

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do bottles(Run Windows in a Bottle) na maquina.
# @fonts: https://flathub.org/apps/com.usebottles.bottles
#         https://www.youtube.com/watch?v=96b1CdB6OHE
# @example:
#       bash script-bottles.sh
#-------------------------------------------------------------#

if command -v flatpak run com.usebottles.bottles >/dev/null 2>&1; then
    echo "✅ Program(Bottles) already installed!";
    echo -e "--> Directory:" "$(command -v flatpak run com.usebottles.bottles)" "\n";
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
