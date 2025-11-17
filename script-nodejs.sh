#!/bin/bash

# ⚠️ @DEPENDENCIES: [ script-nvm.sh ]

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do NodeJS na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-nodejs.sh
# @example:
#       bash script-nodejs.sh
#-------------------------------------------------------------#

readonly NODE_VERSION="18.20.4";

if command -v node >/dev/null 2>&1; then
    echo "✅ Program(node) already installed!";
    echo -e "--> Directory:" "$(command -v node)" "\n";
else
    echo -e "📦 Installing the program: node...\n";

    source ~/.profile;
    source ~/.bashrc;

    sleep 1s;

    nvm install $NODE_VERSION;
    nvm use $NODE_VERSION;

    sleep 1s;

    echo "Node.js version:" "$(node --version)";
    echo "NPM version:" "$(npm --version)";

    # list locally installed global npm packages.
    npm list -g --depth=0;

    # list locally installed npm packages.
    npm list --depth=0;

    # @fonts: https://www.computerhope.com/unix/uchown.htm
    #         http://manpages.ubuntu.com/manpages/trusty/man1/chown.1.html
    sudo chown -R "$USER:$(id -gn "$USER")" "$HOME/.config";

    sleep 1s;
fi

exit 0;
