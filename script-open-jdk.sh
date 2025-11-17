#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Open JDK na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-open-jdk.sh
# @example:
#       bash script-open-jdk.sh
#-------------------------------------------------------------#

if command -v java >/dev/null 2>&1; then
    echo "✅ Program(Open JDK) already installed!";
    echo -e "--> Directory:" "$(command -v java)" "\n";
else
    echo -e "📦 Installing the program: Open JDK...\n";

    sudo apt-get install -y openjdk-11-jdk;

    sleep 1s;

    java --version;

    # Install the Apache Maven.
    sudo apt-get install -y maven;

    sleep 1s;

    mvn --version;

    sleep 1s;
fi

exit 0;

