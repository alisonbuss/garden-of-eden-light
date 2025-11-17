#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação e desinstalação do .Net Core SDK na maquina.
# @fonts: https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-current
#         https://dotnet.microsoft.com/download/linux-package-manager/ubuntu19-04/sdk-current
#         https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-dotnet-sdk.sh
# @example:
#       bash script-dotnet-sdk.sh
#-------------------------------------------------------------#

if command -v dotnet >/dev/null 2>&1; then
    echo "✅ Program(dotnet) already installed!";
    echo -e "--> Directory:" "$(command -v dotnet)" "\n";
else
    echo -e "📦 Installing the program: dotnet...\n";

    # Site Downloads:
    # https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install
    # sudo apt-get install -y dotnet-sdk-9.0;
    sudo apt-get install -y dotnet-sdk-8.0;

    dotnet --version;
fi

exit 0;
