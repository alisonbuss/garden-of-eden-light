#!/bin/bash

# ⚠️ @DEPENDENCIES: [ script-flatpak.sh ]

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do yt-dlp na maquina.
# @fonts: Como utilizar o YT-DLP: Guia e comandos (2025)
#         https://www.rapidseedbox.com/pt/blog/guia-completo-yt-dlp
#         https://github.com/NickvisionApps/Parabolic
#         https://flathub.org/en/apps/org.nickvision.tubeconverter
# @example:
#       bash script-yt-dlp.sh
#-------------------------------------------------------------#

# Install yt-dlp is a feature-rich command-line audio/video downloader:
if command -v yt-dlp >/dev/null 2>&1; then
    echo "✅ Program(yt-dlp) already installed!";
    echo -e "--> Directory:" "$(command -v yt-dlp)" "\n";
else
    echo -e "📦 Installing the program: yt-dlp...\n";

    wget "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp" -O ~/Downloads/yt-dlp;

    sudo cp -f -v ~/Downloads/yt-dlp ~/.local/bin/yt-dlp;
    sudo chmod a+rx ~/.local/bin/yt-dlp;

    yt-dlp --version;

    sleep 1s;

    # A complete, cross-platform solution to record, convert and stream audio and video.
    # https://www.ffmpeg.org/documentation.html
    echo -e "📦 Installing the program: FFmpeg...\n";

    sudo apt-get install -y ffmpeg;

    ffmpeg -version;

    sleep 1s;
fi


# Nesses diretórios, você encontrará os links simbólicos dos binários executáveis do Flatpak:
#
# Para instalação em todo o sistema:
# $ ls /var/lib/flatpak/exports/bin/
#
# Para instalação por usuário:
# $ ls ~/.local/share/flatpak/exports/bin/
#
readonly FLATPAK_PARABOLIC="/var/lib/flatpak/exports/bin/org.nickvision.tubeconverter";

# Install Parabolic is a powerful yt-dlp frontend:
if (command -v flatpak >/dev/null 2>&1 && command -v $FLATPAK_PARABOLIC >/dev/null 2>&1); then
    echo "✅ Program(Parabolic) already installed!";
    echo -e "--> Directory:" "$(command -v $FLATPAK_PARABOLIC)" "\n";
else
    echo -e "📦 Installing the program: Parabolic...\n";

    sudo flatpak install flathub org.nickvision.tubeconverter -y;

    flatpak run org.nickvision.tubeconverter --version;

    sleep 1s;

    flatpak info org.nickvision.tubeconverter;

    sleep 1s;
fi

# exit 0;

# Comandos básicos:

# Ajuda:
# $ yt-dlp --help

# Baixar o vídeo:
# $ yt-dlp https://www.youtube.com/watch?v=iMbuOnGVwGM

# Baixar o vídeo com a melhor qualidade disponível, tanto para áudio quanto para vídeo:
# $ yt-dlp -f best https://www.youtube.com/watch?v=iMbuOnGVwGM

# Baixar vídeos no formato de MP4:
# $ yt-dlp --format mp4 https://www.youtube.com/watch?v=iMbuOnGVwGM

# Listar os formatos disponíveis no vídeo:
# $ yt-dlp -F --list-formats https://www.youtube.com/watch?v=iMbuOnGVwGM

# Use o comando "-f 'bv*[height=...]+ba'" para especificar o formato:
# $ yt-dlp -f 'bv*&#91;height=720]+ba' https://www.youtube.com/watch?v=iMbuOnGVwGM

# Customizar o nome:
# $ yt-dlp -o '%(title)s by %(uploader)s on %(upload_date)s in %(playlist)s.%(ext)s' https://www.youtube.com/watch?v=iMbuOnGVwGM

# Baixar em mp3:
# $ yt-dlp -x --audio-format mp3 https://www.youtube.com/watch?v=iMbuOnGVwGM

# Baixar Playlist:
# $ yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" https://www.youtube.com/playlist?list=PLGE-RuIU8Y-2KkBysWEjxn08dRGHMIlT0

# Baixar Playlist da Udemy:
# $ yt-dlp -u user -p password -P "~/Downloads" -o "%(playlist)s/%(chapter_number)s - %(chapter)s/%(title)s.%(ext)s" https://www.udemy.com/java-tutorial

# Ou via Docker:
# $ docker run --rm --env HOST_UID="$(id -u)" --env HOST_GID="$(id -g)" --volume ~/Downloads:/output ubuntu:latest bash -c '
#     set -e
#     apt-get update &&
#     apt-get install -y --no-install-recommends wget ffmpeg python3 ca-certificates &&
#     wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp &&
#     chmod a+rx /usr/local/bin/yt-dlp &&
#     cd /output &&
#
#     yt-dlp --format mp4 "https://www.youtube.com/watch?v=iMbuOnGVwGM" &&
#
#     chown "$HOST_UID:$HOST_GID" ./*
# ';
