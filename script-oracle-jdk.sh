#!/bin/bash

# ⚠️ @DEPENDENCIES: [ script-jenv.sh ]

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Oracle JDK na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-open-jdk.sh
# @example:
#       bash script-oracle-jdk.sh
#-------------------------------------------------------------#

if command -v java >/dev/null 2>&1; then
    echo "✅ Program(Oracle JDK) already installed!";
    echo -e "--> Directory:" "$(command -v java)" "\n";
else
    echo -e "📦 Installing the program: Oracle JDK...\n";

    # Site Java Downloads:
    # https://www.oracle.com/java/technologies/downloads
    wget "https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz" -O ~/Downloads/jdk_bin.tar.gz;

    mkdir -p ~/.jdks;

    tar -xzf ~/Downloads/jdk_bin.tar.gz -C ~/.jdks;

    # Add the installed java as default:
    jenv add ~/.jdks/jdk-21.0.7;

    # List managed JDKs
    jenv versions;

    # Configure global version
    jenv global oracle64-21.0.7;

    sleep 1s;

    java --version;

    sleep 1s;
fi

exit 0;
