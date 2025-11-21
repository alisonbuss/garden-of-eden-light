#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script para Gerar e Regerar chave SSH do usuário logado da máquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-keyssh.sh
# @example:
#       bash script-keyssh.sh
#-------------------------------------------------------------#

readonly KEY_NAME="id_rsa";
readonly KEY_PATH="${HOME}/.ssh";
readonly FULL_KEY_PATH="${KEY_PATH}/${KEY_NAME}"
readonly COMMENT="Development machine key";
readonly PASSWORD_KEY="";

# checks if the folder exists, if not, a folder is created.
if [ ! -f "$FULL_KEY_PATH" ]; then
    mkdir -p "${KEY_PATH}";
    # sudo chmod -R 760 "${KEY_PATH}";

    # generate SSH key for machine user.
    ssh-keygen -t rsa -b 4096 -C "$COMMENT" -P "$PASSWORD_KEY" -f "${FULL_KEY_PATH}";

    sleep 1s;
else
    echo -e "✅ Warning: There is an SSH key already created in this directory: (${FULL_KEY_PATH})\n";
fi

exit 0;
