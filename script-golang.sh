#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação da linguagem programação Go na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-golang.sh
#         https://github.com/canha/golang-tools-install-script
#         https://snapcraft.io/go
# @example:
#       bash script-golang.sh
#-------------------------------------------------------------#

if command -v go >/dev/null 2>&1; then
    echo "✅ Program(Go) already installed!";
    echo -e "--> Directory:" "$(command -v go)" "\n";
else
    echo -e "📦 Installing the program: Go...\n";

    # Site Downloads:
    # https://go.dev/dl/
    wget "https://go.dev/dl/go1.24.4.linux-amd64.tar.gz" -O ~/Downloads/go_amd64.tar.gz;

    tar -xzf ~/Downloads/go_amd64.tar.gz -C ~/Downloads;

    mkdir -p ~/.go;
    mv ~/Downloads/go/* ~/.go;

    # Setando variáveis de ambiente.
    touch ~/.profile
    {
        echo '# GoLang';
        echo 'export GOROOT=$HOME/.go';
        echo 'export PATH=$PATH:$GOROOT/bin';
        echo 'export GOPATH=$HOME/go';
        echo 'export PATH=$PATH:$GOPATH/bin';
    } >> ~/.profile;
    source ~/.profile;

    # Setando variáveis de ambiente.
    touch ~/.bashrc
    {
        echo '# GoLang';
        echo 'export GOROOT=$HOME/.go';
        echo 'export PATH=$PATH:$GOROOT/bin';
        echo 'export GOPATH=$HOME/go';
        echo 'export PATH=$PATH:$GOPATH/bin';
    } >> ~/.bashrc;
    source ~/.bashrc;

    sleep 1s;

    go version;

    sleep 1s;
fi

exit 0;
