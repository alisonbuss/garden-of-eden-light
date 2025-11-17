#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do VirtualBox na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-virtualbox.sh
# @example:
#       bash script-virtualbox.sh
#-------------------------------------------------------------#

if command -v VBoxManage >/dev/null 2>&1; then
    echo "✅ Program(virtualbox) already installed!";
    echo -e "--> Directory:" "$(command -v VBoxManage)" "\n";
else
    echo -e "📦 Installing the program: virtualbox...\n";

    # Download e instalacao do VirtualBox:
    # uname -a;
    # wget "https://download.virtualbox.org/virtualbox/7.1.10/virtualbox-7.1_7.1.10-169112~Ubuntu~noble_amd64.deb" -O ~/Downloads/virtualbox_amd64.deb;
    # sudo dpkg -i ~/Downloads/virtualbox_amd64.deb;

    # OU!!!

    # Download VirtualBox:
    wget "https://download.virtualbox.org/virtualbox/7.1.10/VirtualBox-7.1.10-169112-Linux_amd64.run" -O  ~/Downloads/virtualbox_amd64.run;

    # Download VirtualBox Extension Pack:
    wget "https://download.virtualbox.org/virtualbox/7.1.10/Oracle_VirtualBox_Extension_Pack-7.1.10.vbox-extpack" -O  ~/Downloads/virtualboxExtensionPack.vbox-extpack;

    # Instalar algumas dependências
    sudo apt install -y gcc make dkms linux-headers-"$(uname -r)";
    sudo apt install -f;

    # Instalar o VirtualBox e suas dependências
    sudo chmod +x ~/Downloads/virtualbox_amd64.run;
    sudo ~/Downloads/virtualbox_amd64.run;
    sudo apt-get install -f;

    # Instalar a extensão do VirtualBox
    VBoxManage extpack install ~/Downloads/virtualboxExtensionPack.vbox-extpack;

    echo -n "Version VirtualBox: ";
    VBoxManage -v;

    echo "How to lList all extension packages: ";
    VBoxManage list extpacks;
fi

exit 0;
