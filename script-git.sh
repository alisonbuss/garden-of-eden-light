#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Git na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-git.sh
# @example:
#       bash script-git.sh
#-------------------------------------------------------------#

readonly GIT_USER_NAME="YouName";
readonly GIT_USER_EMAIL="youname@gmail.com";

if command -v git >/dev/null 2>&1; then
    echo "✅ Program(git) already installed!";
    echo -e "--> Directory:" "$(command -v git)" "\n";
else
    echo -e "📦 Installing the program: git...\n";

    sudo apt-get install -y git;

    git --version;

    git config --global user.name $GIT_USER_NAME;
    git config --global user.email $GIT_USER_EMAIL;
    git config --list;

    sleep 1s;

    # Caso a chave SSH foi publicada no GitHub teste a conexão:
    echo "Sua chave SSH já foi publicada no GitHub? [yes/no]: ";
    read -r input_isPublishedKey;
    if [ "$input_isPublishedKey" == "yes" ]; then
        echo "Testando a conexão com o GitHub...";
        ssh -T git@github.com;
    fi
fi

exit 0;
