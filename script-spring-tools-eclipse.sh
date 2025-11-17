#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Spring Tool Suite 4 na maquina
# @fonts: https://www.geeksforgeeks.org/how-to-install-spring-tool-suite-on-linux/
# @example:
#       bash script-spring-tools-eclipse.sh
#-------------------------------------------------------------#

if command -v SpringToolSuite4 >/dev/null 2>&1; then
    echo "✅ Program(SpringToolSuite4) already installed!";
    echo -e "--> Directory:" "$(command -v SpringToolSuite4)" "\n";
else
    echo -e "📦 Installing the program: SpringToolSuite4...\n";

    wget "https://cdn.spring.io/spring-tools/release/STS4/4.25.0.RELEASE/dist/e4.33/spring-tool-suite-4-4.25.0.RELEASE-e4.33.0-linux.gtk.x86_64.tar.gz" -O ~/Downloads/spring-tool-suite-4.tar.gz;

    tar -xzf ~/Downloads/spring-tool-suite-4.tar.gz -C ~/Downloads;

    sudo mkdir -p /opt/sts-bundle;
    sudo mv ~/Downloads/sts*RELEASE/{*,.*} /opt/sts-bundle/;

    sudo ln -sf /opt/sts-bundle/SpringToolSuite4 /usr/local/bin/SpringToolSuite4;

    mkdir -p ~/.local/share/applications;
    touch ~/.local/share/applications/SpringToolSuite4.desktop
    {
        echo '[Desktop Entry]';
        echo 'Type=Application';
        echo 'Name=Spring Tool Suite 4';
        echo 'Comment=A customized Eclipse IDE gives a better experience for Spring based Entreprise Applications';
        echo 'Icon=/opt/sts-bundle/icon.xpm';
        echo 'Exec=/usr/local/bin/SpringToolSuite4';
        echo 'StartupNotify=true';
        echo 'Terminal=false';
        echo 'Categories=Development;IDE;Java';

    } > ~/.local/share/applications/SpringToolSuite4.desktop;

    sleep 1s;
fi

exit 0;
