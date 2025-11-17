#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do Hyper na maquina
# @fonts: https://hyper.is/
#         https://starship.rs/
#         https://linuxhint.com/install_hyper_terminal_ubuntu18/
#         https://tjay.dev/howto-my-terminal-shell-setup-hyper-js-zsh-starship/
#         https://github.com/vercel/hyper/releases
# @example:
#       bash script-hyper.sh
#-------------------------------------------------------------#

if command -v hyper >/dev/null 2>&1; then
    echo "✅ Program(Hyper) already installed!";
    echo -e "--> Directory:" "$(command -v hyper)" "\n";
else
    echo -e "📦 Installing the program: Hyper...\n";

    wget "https://releases.hyper.is/download/deb" -O ~/Downloads/hyper.deb;

    # sudo dpkg -i ~/Downloads/hyper.deb;
    sudo apt install ~/Downloads/hyper.deb;

    sleep 1s;

    hyper version;

    sleep 1s;

    # https://github.com/Hyperline/hyperline
    hyper install hyperline;

    # https://hyper.is/store/hyper-search
    hyper install hyper-search;

    # https://hyper.is/store/hyper-one-dark
    hyper install hyper-one-dark;

    # # Install Starship:
    # curl -fsSL https://starship.rs/install.sh | bash;
    # starship --version;

    # # Config Starship.
    # touch ~/.bashrc
    # {
    #     echo '# Config Starship';
    #     echo 'eval "$(starship init bash)"';
    # } >> ~/.bashrc;
    # source ~/.bashrc;

    # mkdir -p ~/.config;
    # cp -f -v ./files/starship/starship.toml ~/.config/starship.toml;
fi

exit 0;
