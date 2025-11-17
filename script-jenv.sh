#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do jEnv na maquina
# @fonts: https://github.com/jenv/jenv
# @example:
#       bash script-jenv.sh
#-------------------------------------------------------------#

if which jenv >/dev/null; then
    echo "Program(jenv) already installed!";
    echo -e "--> Directory:" "$(command -v jenv)" "\n";
else
    echo -e "Installing the program: jenv...\n";

    mkdir -p ~/.jdks;

    git clone https://github.com/jenv/jenv.git ~/.jenv;

    touch ~/.profile
    {
        echo '# jEnv Initialization:';
        echo 'export PATH="$HOME/.jenv/bin:$PATH"';
        echo 'eval "$(jenv init -)"';
    } >> ~/.profile;

    source ~/.profile;

    sleep 1s;

    jenv --version;

    # Enable export plugin
    jenv enable-plugin export;

    # Enable plugin for maven
    jenv enable-plugin maven;

    # Add the java already installed in jEnv:
    # Run the command below to find the Java installation folder:
    # $ readlink -e $(which java)
    # Result:
    # $ /usr/lib/jvm/java-11-openjdk-amd64/bin/java

    # Add the installed java as default:
    # $ jenv add /usr/lib/jvm/java-11-openjdk-amd64
    # $ jenv add ~/.jdks/jdk-8u202-linux-x64/jdk1.8.0_202
    # $ jenv add ~/.jdks/jdk-17_linux-x64_bin/jdk-17.0.12

    # List managed JDKs
    # $ jenv versions

    # Configure global version
    # $ jenv global openjdk64-11.0.24

    # Or

    # Configure local version (per directory)
    # $ jenv local openjdk64-11.0.24
fi

exit 0;
