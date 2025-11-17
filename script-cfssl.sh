#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do CFSSL na maquina.
# @fonts: https://blog.cloudflare.com/introducing-cfssl/
#         https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-cfssl.sh
# @example:
#       bash script-cfssl.sh
#-------------------------------------------------------------#

if command -v cfssl >/dev/null 2>&1; then
    echo "✅ Program(cfssl) already installed!";
    echo -e "--> Directory:" "$(command -v cfssl)" "\n";
else
    echo -e "📦 Installing the program: cfssl...\n";

    # Para verificar se a arquitetura do seu computador é ARM64 ou AMD64 (x64):
    # Você pode usar o comando "$ uname -m" no terminal.
    # Se a saída for aarch64, a máquina é ARM64.
    # Se for x86_64, a máquina é AMD64 (x64).
    #
    # No Linux:
    # Abra o terminal.
    # Digite "$ uname -m" e pressione Enter.
    #
    # Verifique a saída:
    # Se a saída for aarch64, a máquina é ARM64.
    # Se a saída for x86_64, a máquina é AMD64 (x64).

    # Instalando binario na arquitetura AMD64 (x64) (x86_64)
    # Download:
    wget "https://github.com/cloudflare/cfssl/releases/download/v1.6.5/cfssl_1.6.5_linux_amd64" -O ~/Downloads/cfssl_amd64;
    wget "https://github.com/cloudflare/cfssl/releases/download/v1.6.5/cfssljson_1.6.5_linux_amd64" -O ~/Downloads/cfssljson_amd64;

    # Move the binaries to a directory on your executable path, such as /usr/bin/
    sudo cp -f -v ~/Downloads/cfssl_amd64 /usr/local/bin/cfssl;
    sudo cp -f -v ~/Downloads/cfssljson_amd64 /usr/local/bin/cfssljson;
    sudo chmod +x /usr/local/bin/{cfssl,cfssljson};

    cfssl version;

    sleep 1s;
fi

exit 0;
