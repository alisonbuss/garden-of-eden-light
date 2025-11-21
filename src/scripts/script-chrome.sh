#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Chrome na maquina.
# @fonts: https://www.xda-developers.com/how-install-chrome-ubuntu/
# @example:
#       bash script-chrome.sh
#-------------------------------------------------------------#

if command -v google-chrome >/dev/null 2>&1; then
    echo "✅ Program(google-chrome) already installed!";
    echo -e "--> Directory:" "$(command -v google-chrome)" "\n";
else
    echo -e "📦 Installing the program: google-chrome...\n";

    wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O ~/Downloads/google-chrome.deb;

    sudo dpkg -i ~/Downloads/google-chrome.deb;
    sudo apt install -f;

    sleep 1s;

    google-chrome --version;
fi

exit 0;
