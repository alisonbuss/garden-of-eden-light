#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Postman na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-postman.sh
# @example:
#       bash script-postman.sh
#-------------------------------------------------------------#

if command -v postman >/dev/null 2>&1; then
    echo "✅ Program(postman) already installed!";
    echo -e "--> Directory:" "$(command -v postman)" "\n";
else
    echo -e "📦 Installing the program: postman...\n";

    wget "https://dl.pstmn.io/download/latest/linux64" -O ~/Downloads/postman.tar.gz;

    sudo tar -xzf ~/Downloads/postman.tar.gz -C /opt;
    sudo ln -s /opt/Postman/Postman /usr/local/bin/postman;

    mkdir -p ~/.local/share/applications;
    touch ~/.local/share/applications/postman.desktop
    {
        echo '[Desktop Entry]';
        echo 'Type=Application';
        echo 'Name=Postman';
        echo 'Comment=Postman: API Development Environment';
        echo 'Icon=/opt/Postman/app/resources/app/assets/icon.png';
        echo 'Exec=postman';
        echo 'Terminal=false';
        echo 'Categories=Development;';

    } > ~/.local/share/applications/postman.desktop;

    sleep 1s;
fi

exit 0;
