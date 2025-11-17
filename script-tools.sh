#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Instalação de Ferramentas comuns na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-tools.sh
# @example:
#       bash script-tools.sh
#-------------------------------------------------------------#

readonly PROGRAMS=(
    "wget"
    "curl"
    "tree"
    "xz-utils"
    "chrome-gnome-shell"
    "software-properties-common"

    # # Multimedia:
    # "vlc"
    # "ubuntu-restricted-extras"

    # # Monitorar Temperatura CPU:
    # "hddtemp"
    # "psensor"
    # "lm-sensors"
);

for program in "${PROGRAMS[@]}"; do
    if command -v "$program" >/dev/null 2>&1; then
        echo "✅ Program($program) already installed!";
        echo -e "--> Directory:" "$(command -v "$program")" "\n";
    else
        echo -e "📦 Installing the program: $program...\n";
        sudo apt-get install -y "$program";
    fi
    sleep 1s;
done

exit 0;

# Extensions for gnome (chrome-gnome-shell)
# --> https://extensions.gnome.org/extension/19/user-themes
# --> https://extensions.gnome.org/extension/1160/dash-to-panel
#
# Print das informações de todo o sistema:
# Add:
# Fastfetch é uma ferramenta semelhante ao Neofetch para buscar
# informações do sistema e exibir de forma bonita:
# $ sudo add-apt-repository ppa:zhangsongcui3371/fastfetch;
# $ sudo apt update;
# $ sudo apt install -y fastfetch;
# $ fastfetch
#                              ....              dev@local
#               .',:clooo:  .:looooo:.           ---------
#            .;looooooooc  .oooooooooo'          OS: Ubuntu 24.04.2 LTS x86_64
#         .;looooool:,''.  :ooooooooooc          Host: Inspiron 13-5368
#        ;looool;.         'oooooooooo,          Kernel: Linux 6.11.0-26-generic
#       ;clool'             .cooooooc.  ,,       Uptime: 18 mins
#          ...                ......  .:oo,      Packages: 2148 (dpkg), 13 (flatp)
#   .;clol:,.                        .loooo'     Shell: bash 5.2.21
#  :ooooooooo,                        'ooool     Display (LG ULTRAWIDE): 2560x108]
# 'ooooooooooo.                        loooo.    DE: GNOME 46.0
# 'ooooooooool                         coooo.    WM: Mutter (X11)
#  ,loooooooc.                        .loooo.    WM Theme: Yaru-viridian-dark
#    .,;;;'.                          ;ooooc     Theme: Yaru-viridian-dark [GTK2/]
#        ...                         ,ooool.     Icons: Yaru-viridian [GTK2/3/4]
#     .cooooc.              ..',,'.  .cooo.      Font: Ubuntu Sans (11pt) [GTK2/3]
#       ;ooooo:.           ;oooooooc.  :l.       Cursor: Yaru (24px)
#        .coooooc,..      coooooooooo.           Terminal: GNOME Terminal 3.52.0
#          .:ooooooolc:. .ooooooooooo'           Terminal Font: Ubuntu Sans Mono )
#            .':loooooo;  ,oooooooooc            CPU: Intel(R) Core(TM) i5-6200U z
#                ..';::c'  .;loooo:'             GPU: Intel HD Graphics 520 @ 1.0]
#                                                Memory: 6.59 GiB / 11.42 GiB (58)
#                                                Swap: 0 B / 4.00 GiB (0%)
#                                                Disk (/): 100.52 GiB / 219.00 Gi4
#                                                Local IP (wlp1s0): 192.168.1.3666
#                                                Locale: pt_BR.UTF-8
#
