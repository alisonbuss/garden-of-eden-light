#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do TradingView Desktop na maquina.
# @fonts: https://br.tradingview.com
#         https://br.tradingview.com/desktop
#         https://www.tradingview.com/support/solutions/43000728898-how-to-install-and-update-desktop-app-on-linux/
# @example:
#       bash script-tradingview.sh
#-------------------------------------------------------------#

if command -v tradingview >/dev/null 2>&1; then
    echo "✅ Program(TradingView Desktop) already installed!";
    echo -e "--> Directory:" "$(command -v tradingview)" "\n";
else
    echo -e "📦 Installing the program: TradingView Desktop...\n";

    wget "https://tvd-packages.tradingview.com/ubuntu/stable/latest/jammy/tradingview_amd64.deb" -O ~/Downloads/tradingview.deb;

    sudo dpkg -i ~/Downloads/tradingview.deb;
    sudo apt install -f;

    sleep 1s;

    # tradingview --version;
fi

exit 0;
