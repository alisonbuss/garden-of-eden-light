#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Proton VPN na maquina.
# @fonts: https://protonvpn.com/support/linux-vpn-setup
#         https://protonvpn.com/support/official-linux-vpn-ubuntu
#         https://repo.protonvpn.com/debian/dists/stable/main/binary-all
# @example:
#       bash script-protonvpn.sh
#-------------------------------------------------------------#

if command -v protonvpn-app >/dev/null 2>&1; then
    echo "✅ Program(Proton VPN) already installed!";
    echo -e "--> Directory:" "$(command -v protonvpn-app)" "\n";
else
    echo -e "📦 Installing the program: Proton VPN...\n";

    # Install Proton VPN Desktop:
    wget "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb" -O  ~/Downloads/protonvpn-stable-release.deb;

    sudo dpkg -i ~/Downloads/protonvpn-stable-release.deb;

    sudo apt update;

    sudo apt install -y proton-vpn-gnome-desktop;

    sleep 1s;

    protonvpn-app --version;

    # # Install Proton VPN CLI:
    # wget "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-cli_3.13.0-1_all.deb" -O  ~/Downloads/protonvpn-cli.deb;
    # sudo dpkg -i ~/Downloads/protonvpn-cli.deb;
    # sudo apt install -y -f;
    # sudo apt update;
    # sudo apt install -y protonvpn-cli;

    # # Commands:
    # # https://linuxcommandlibrary.com/man/protonvpn-cli
    # protonvpn-cli --version;
fi

exit 0;
