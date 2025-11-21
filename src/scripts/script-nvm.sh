#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Node Version Manager (NVM) na maquina.
#         Script bash simples para gerenciar várias versões do node.js ativo.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-nvm.sh
# @example:
#       bash script-nvm.sh
#-------------------------------------------------------------#

if [ -e ~/.nvm/nvm.sh ]; then
    echo "✅ Program(nvm) already installed!";
    echo -e "--> Directory: ${HOME}/.nvm/nvm.sh\n";
else
    echo -e "📦 Installing the program: nvm...\n";

    wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh" | bash;

    # setting environment variables.
    touch ~/.profile
    {
        echo '# NVM Initialization:';
        echo 'export NVM_DIR="$HOME/.nvm"';
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm';
        echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion';
    } >> ~/.profile;

    source ~/.profile;

    sleep 1s;

    echo "NVM version:" "$(nvm --version)";

    # list locally installed versions of node
    nvm ls;

    # list remove available versions of node
    nvm ls-remote | grep "Latest LTS:";

    sleep 1s;
fi

exit 0;

