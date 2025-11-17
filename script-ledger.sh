#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Ledger Live na maquina.
# @fonts: https://shop.ledger.com/pages/ledger-wallet
#         https://download.live.ledger.com/index.html
#         https://shop.ledger.com/pt/pages/ledger-wallet
#         https://support.ledger.com/pt-BR/article/4404389606417-zd
#         https://support.ledger.com/pt-BR/article/4404389503889-zd
# @example:
#       bash script-ledger.sh
#-------------------------------------------------------------#

if command -v ledger-live.AppImage >/dev/null 2>&1; then
    echo "✅ Program(Ledger Live) already installed!";
    echo -e "--> Directory:" "$(command -v ledger-live.AppImage)" "\n";
else
    echo -e "📦 Installing the program: Ledger Live...\n";

    wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash;
    ls /etc/udev/rules.d;
    cat /etc/udev/rules.d/20-hw1.rules;

    sudo add-apt-repository -y universe;
    sudo apt update;
    sudo apt install -y libfuse2;

    wget "https://download.live.ledger.com/latest/linux" -O  ~/Downloads/ledger-live.AppImage;

    sudo mv ~/Downloads/ledger-live.AppImage /usr/local/bin/ledger-live.AppImage;
    sudo chmod +x /usr/local/bin/ledger-live.AppImage;

    mkdir -p ~/.local/share/icons;
    cp ./files/ledger-live/ledger-live.png ~/.local/share/icons/ledger-live.png;
    cp ./files/ledger-live/ledger-live.desktop ~/.local/share/applications/ledger-live.desktop;
    update-desktop-database -v ~/.local/share/applications;

    # Add menu Desktop:
    # gsettings set org.gnome.shell favorite-apps "$(gsettings get org.gnome.shell favorite-apps | sed s/.$//), 'ledger-live.desktop']";
fi

exit 0;
