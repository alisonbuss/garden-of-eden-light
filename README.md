# Garden of Eden Light

![Logo](./files/logo-garden-of-eden.png)

> Versão **simples**, **direta** e **fácil de manter** do projeto [Garden of Eden](https://github.com/alisonbuss/garden-of-eden).
> Uma coleção de scripts em Shell para provisionar rapidamente um ambiente de **desenvolvimento** e/ou **trading** em distribuições baseadas em **Ubuntu/Debian**.

---

## Índice

- [Visão geral](#visão-geral)
- [Principais recursos](#principais-recursos)
- [Requisitos](#requisitos)
- [Arquitetura do repositório](#arquitetura-do-repositório)
- [Perfis de instalação](#perfis-de-instalação)
  - [scripts-all.json](#scripts-alljson)
  - [scripts-dev.json](#scripts-devjson)
  - [scripts-trading.json](#scripts-tradingjson)
- [Como usar](#como-usar)
  - [1. Clonar o repositório](#1-clonar-o-repositório)
  - [2. Dar permissão de execução](#2-dar-permissão-de-execução)
  - [3. Escolher o perfil de instalação](#3-escolher-o-perfil-de-instalação)
  - [4. Habilitar/desabilitar scripts no JSON](#4-habilitardesabilitar-scripts-no-json)
  - [5. Executar o orquestrador](#5-executar-o-orquestrador)
- [Formato dos arquivos scripts-*.json](#formato-dos-arquivos-scripts-json)
- [Lista de scripts disponíveis](#lista-de-scripts-disponíveis)
- [Customização](#customização)
  - [Criar um novo script de instalação](#criar-um-novo-script-de-instalação)
  - [Adicionar o script a um perfil](#adicionar-o-script-a-um-perfil)
- [Boas práticas e cuidados](#boas-práticas-e-cuidados)
- [TODO / Ideias futuras](#todo--ideias-futuras)
- [Licença](#licença)

---

## Visão geral

O **Garden of Eden Light** é um conjunto de **scripts Bash** com um **orquestrador simples** baseado em **JSON**:

- Você escolhe **quais scripts deseja rodar** editando um arquivo JSON (`scripts-*.json`).
- O script principal `run-scripts.sh`:
  - Faz `apt update`.
  - Garante a instalação do utilitário `jq`.
  - Lê o JSON selecionado.
  - Executa, em ordem, apenas os scripts marcados com `"execute": true`.

A ideia é fornecer um ambiente rápido para:

- Desenvolvimento (Java, Node.js, Go, Python, .NET, Docker, ferramentas de banco, clientes HTTP etc.).
- Trading/cripto (ProtonVPN, Exodus, Ledger Live, TradingView, etc.).
- Utilitários gerais (Chrome, Hyper, Git, Flatpak, Bottles, yt-dlp, etc.).

---

## Principais recursos

- **Orquestração simples via JSON**
  - Nenhum framework complexo, apenas `bash + jq`.
  - Fácil de entender e modificar.

- **Perfis prontos**
  - `scripts-dev.json`: foco em desenvolvimento.
  - `scripts-trading.json`: foco em ambiente de trading.
  - `scripts-all.json`: executa tudo do repositório (para quem quer “full setup”).

- **Scripts idempotentes**
  - Todos os scripts verificam se o programa já está instalado (`command -v ...`).
  - Se já existir, apenas informam o caminho e saem sem quebrar o fluxo.

- **Instalação assistida**
  - Alguns scripts interagem com o usuário (por ex., Git pergunta se a chave SSH já foi publicada no GitHub).

- **Configurações extras**
  - Arquivos de configuração para Docker (systemd + daemon.json).
  - Arquivos `.desktop` e ícones (por exemplo, para Ledger Live).
  - Header ASCII simples (`files/header.txt`) exibido antes da execução da lista de scripts.

---

## Requisitos

O projeto foi pensado para rodar em distribuições tipo **Ubuntu/Debian** (ou derivadas) com:

- **Sistema operacional**
  - Ubuntu 22.04+ (recomendado) ou outra distro com `apt`.
- **Ferramentas**
  - `bash`
  - `sudo`
  - `wget`, `curl` (se não existirem, o próprio projeto instala via `script-tools.sh`).
- **Acesso à internet**
  - Necessário para baixar pacotes, binários e AppImages.

> ⚠️ **Importante:** os scripts executam comandos com `sudo`.
> Leia e entenda os scripts antes de rodar em ambientes sensíveis (prod, máquinas de trabalho, etc.).

---

## Arquitetura do repositório

Estrutura simplificada:

```text
garden-of-eden-light/
├── run-scripts.sh          # Orquestrador principal
├── scripts-all.json        # Perfil: todos os scripts
├── scripts-dev.json        # Perfil: ambiente de desenvolvimento
├── scripts-trading.json    # Perfil: ambiente de trading
├── script-*.sh             # Scripts de instalação individuais
├── files/
│   ├── docker/
│   │   ├── containerd.service
│   │   ├── daemon.json
│   │   ├── docker.service
│   │   └── docker.socket
│   ├── header.txt
│   ├── ledger-live/
│   │   ├── ledger-live.desktop
│   │   └── ledger-live.png
│   ├── logo-garden-of-eden.png
│   ├── starship/
│   │   └── starship.toml
│   └── wallpapers/         # (reservado para papéis de parede)
└── .vscode/
    ├── extensions.json
    └── settings.json
```




