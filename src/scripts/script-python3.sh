#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Python3 na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-python2.sh
#         https://python.org.br/instalacao-linux/
# @example:
#       bash script-python3.sh
#-------------------------------------------------------------#

if command -v python3 >/dev/null 2>&1; then
    echo "✅ Program(Python3) already installed!";
    echo -e "--> Directory:" "$(command -v python3)" "\n";
else
    echo -e "📦 Installing the program: Python3...\n";

    sudo apt-get install -y python3;

    sleep 1s;

    python3 --version;

    # Install the pip for Python 3:
    sudo apt-get install -y python3-pip;

    sleep 1s;

    pip3 --version;

    sleep 1s;
fi

exit 0;

# Ou via Docker:
# $ docker run --rm ubuntu:latest bash -c '
#     set -e
#     apt-get update &&
#     apt-get install -y --no-install-recommends python3 python3-pip ca-certificates &&
#     python3 --version &&
#     pip3 --version
# ';
