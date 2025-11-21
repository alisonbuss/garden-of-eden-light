#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do Docker na maquina
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-docker.sh
#         https://docs.docker.com/engine/install/binaries/#install-daemon-and-client-binaries-on-linux
#         https://docs.docker.com/engine/install/linux-postinstall/
# @example:
#       bash script-docker.sh
#-------------------------------------------------------------#

if command -v docker >/dev/null 2>&1; then
    echo "✅ Program(docker) already installed!";
    echo -e "--> Directory:" "$(command -v docker)" "\n";
else
    echo -e "📦 Installing the program: docker...\n";

    # Install packages to allow apt to use a repository over HTTPS:
    sudo apt-get install -y gnupg-agent \
                            ca-certificates \
                            apt-transport-https;

    # Download the static binary archive:
    # @fonts: https://download.docker.com/linux/static/stable/x86_64
    wget "https://download.docker.com/linux/static/stable/x86_64/docker-28.5.2.tgz" -O ~/Downloads/docker.tgz;

    # Extract the archive using the tar utility. The dockerd and docker binaries are extracted.
    tar -xzvf ~/Downloads/docker.tgz -C ~/Downloads;

    # Move the binaries to a directory on your executable path, such as /usr/bin/
    sudo cp -f -v ~/Downloads/docker/* /usr/local/bin/;
    sudo chmod 755 /usr/local/bin/{containerd,containerd-*,ctr,docker,dockerd,docker-init,docker-proxy,runc};

    # Moving the configuration files:
    sudo cp -f -v ./files/docker/docker.socket /etc/systemd/system/docker.socket;
    sudo chmod 644 /etc/systemd/system/docker.socket;

    sudo cp -f -v ./files/docker/docker.service /etc/systemd/system/docker.service;
    sudo chmod 644 /etc/systemd/system/docker.service;

    sudo cp -f -v ./files/docker/containerd.service /etc/systemd/system/containerd.service;
    sudo chmod 644 /etc/systemd/system/containerd.service;

    sudo mkdir -p /etc/docker;
    sudo cp -f -v ./files/docker/daemon.json /etc/docker/daemon.json;
    sudo chmod 644 /etc/docker/daemon.json;

    # Create the docker group:
    sudo groupadd docker;

    # Add your user to the docker group:
    sudo usermod -a -G docker "$USER";

    # Creating the docker configuration directory:
    mkdir -p "$HOME/.docker";

    # Add permission for the configurations:
    sudo chown -v -R "$USER:$USER" "$HOME/.docker";
    sudo chmod -R g+rwx "$HOME/.docker";

    # Reload the systemd services:
    sudo systemctl daemon-reload;

    # Enable and start the (containerd) service on systemd:
    sudo systemctl enable containerd;
    sudo systemctl start containerd;

    # Enable and start the (docker) service on systemd:
    sudo systemctl enable docker;
    sudo systemctl start docker;

    sleep 1s;

    # checking the installation of the docker version.
    docker --version;
fi

exit 0;
