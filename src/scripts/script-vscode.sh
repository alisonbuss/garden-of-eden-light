#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do VS Code na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-vscode.sh
# @example:
#       bash script-vscode.sh
#-------------------------------------------------------------#

if command -v code >/dev/null 2>&1; then
    echo "✅ Program(code) already installed!";
    echo -e "--> Directory:" "$(command -v code)" "\n";
else
    echo -e "📦 Installing the program: code...\n";

    wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O ~/Downloads/vscode.deb;

    sudo dpkg -i ~/Downloads/vscode.deb;
    sudo apt install -f;

    sleep 1s;

    echo -e "VSCode version:" "\n " "$(code --version)";
fi

exit 0;
