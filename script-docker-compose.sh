#!/bin/bash

# ⚠️ @DEPENDENCIES: [ script-docker.sh ]

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Docker Compose na maquina
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-docker-compose.sh
#         https://docs.docker.com/compose/install/linux/#install-the-plugin-manuallys
# @example:
#       bash script-docker-compose.sh
#-------------------------------------------------------------#

if command -v docker-compose >/dev/null 2>&1; then
    echo "✅ Program(docker-compose) already installed!";
    echo -e "--> Directory:" "$(command -v docker-compose)" "\n";
else
    echo -e "📦 Installing the program: docker-compose...\n";

    # Download the current stable release of Docker Compose:
    wget "https://github.com/docker/compose/releases/download/v2.40.3/docker-compose-linux-x86_64" -O ~/Downloads/docker-compose;

    mkdir -p ~/.docker/cli-plugins;
    cp ~/Downloads/docker-compose ~/.docker/cli-plugins/docker-compose;

    # Apply executable permissions to the binary:
    chmod +x ~/.docker/cli-plugins/docker-compose;

    sleep 1s;

    docker compose version;
fi

exit 0;
