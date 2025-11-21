
<h2 align="center">
  <img src="./files/logo-garden-of-eden.png" width="166px" alt="Garden of Eden Light" />
  <br/>Garden of Eden Light
</h2>

> Uma versão mais simplificada, leve e objetiva, fácil de customizar, inspirada no projeto original do [Garden of Eden](https://github.com/alisonbuss/garden-of-eden).

O projeto é uma coleção de scripts em Shell para provisionar rapidamente um ambiente de desenvolvimento Linux Desktop (focado em distros baseadas em Ubuntu/Debian).

Para melhor aprofundamento... leia a documentação do projeto original [Garden of Eden](https://github.com/alisonbuss/garden-of-eden).

A ideia central é:

> Um único script orquestrador (`run-scripts.sh`) + três perfis em JSON + um conjunto de scripts de instalação independentes.

---

## Índice

- [Visão geral](#visão-geral)
- [Principais recursos](#principais-recursos)
- [Requisitos](#requisitos)
- [Arquitetura e estrutura do projeto](#arquitetura-e-estrutura-do-projeto)
- [Perfis de instalação](#perfis-de-instalação)
  - [scripts-all.json](#scripts-alljson)
  - [scripts-dev.json](#scripts-devjson)
  - [scripts-trading.json](#scripts-tradingjson)
- [Tabela de resumo de todos os scripts](#tabela-de-resumo-de-todos-os-scripts)
  - [Script, Descrição, Perfis padrão](#script-descrição-perfis-padrão)
- [Como usar](#como-usar)
  - [1. Clonar o repositório](#1-clonar-o-repositório)
  - [2. Dar permissão de execução](#2-dar-permissão-de-execução)
  - [3. Escolher o perfil de instalação](#3-escolher-o-perfil-de-instalação)
  - [4. Habilitardesabilitar-scripts-no-json](#4-habilitardesabilitar-scripts-no-json)
  - [5. Executar o projetorun-scriptssh](#5-executar-o-projetorun-scriptssh)
- [Formato dos arquivos scripts-*.json](#formato-dos-arquivos-scripts-json)
- [Lista de scripts disponíveis](#lista-de-scripts-disponíveis)
- [Customização](#customização)
  - [1. Criar uma feature a partir da main](#1-criar-uma-feature-a-partir-da-main)
  - [2. Criar um novo script de instalação](#2-criar-um-novo-script-de-instalação)
  - [3. Adicionar o script a um perfil](#3-adicionar-o-script-a-um-perfil)
  - [4. Executar apenas o novo script](#4-executar-apenas-o-novo-script)
  - [5. Fazer o commit da customização](#5-fazer-o-commit-da-customização)
  - [6. Atualizar a branch com main](#6-atualizar-a-branch-com-main)
  - [6. Resolver conflitos se-houver](#6-resolver-conflitos-se-houver)
  - [7. Subir a nova feature para origem](#7-subir-a-nova-feature-para-origem)
- [Licença](#licença)
- [Referências](#referências)

---

## Visão geral

O **Garden of Eden Light** é um **orquestrador leve de Shell Scripts** para provisionar um ambiente de trabalho em Linux (focado em distros baseadas em Ubuntu/Debian), com três perfis principais:

- **all** – tudo misturado (dev, DevOps, ferramentas gerais, trading).
- **dev** – ambiente de desenvolvimento e DevOps.
- **trading** – ambiente enxuto voltado a trading e cripto.

A ideia é:

- Cada programa/ferramenta tem **um script de instalação dedicado** em `src/scripts/`.
- Um arquivo JSON (por exemplo, `scripts-dev.json`) diz **quais scripts devem ser executados**.
- O script `run-scripts.sh` lê o JSON, garante que o `jq` esteja instalado e **roda em sequência apenas os scripts com `"execute": true"`.

Comparado ao Garden of Eden original, o Light:

- Elimina conceitos de **módulo, action, param** e logs estruturados.
- Reduz tudo a um **modelo mental ultra simples**:
  *“ligar/desligar scripts em JSON e rodar um único comando”*.

---

## Principais recursos

Alguns pontos fortes do projeto:

1. **Simplicidade extrema**
   - Somente **um orquestrador**: `run-scripts.sh`.
   - Arquivos de configuração minimalistas: `scripts-*.json` com apenas:
     ```json
     { "script": "script-nome.sh", "execute": true|false }
     ```
   - Nenhuma dependência complexa interna; cada script é autocontido.

2. **Perfis de instalação**
   - Três perfis prontos para uso:
     - `scripts-all.json`
     - `scripts-dev.json`
     - `scripts-trading.json`
   - Cada perfil é um subconjunto diferente dos mesmos 36 scripts, pensado para cenários específicos.

3. **Stack completa de ferramentas**
   - **Base de sistema e utilitários**: ferramentas comuns, Flatpak, Chrome, Hyper, Git, yt-dlp, Bottles etc.
   - **Linguagens e runtimes**: OpenJDK/Oracle JDK, jEnv, Node.js + NVM, Go, Python 3, .NET SDK.
   - **DevOps/Infra**: Docker, Docker Compose, VirtualBox, Vagrant, Ansible, Terraform, Packer, AWS CLI, CFSSL.
   - **Ferramentas de desenvolvimento**: VS Code, GitKraken, DBeaver, Spring Tools, API clients (Postman, Insomnia, Hoppscotch).
   - **Trading/cripto**: ProtonVPN, Exodus Wallet, Ledger Live, TradingView Desktop.

4. **Orquestração automática via JSON**
   - O `run-scripts.sh`:
     - Garante que o `jq` esteja instalado (via `sudo apt install -y jq` se necessário).
     - Extrai a lista de scripts a partir do JSON:
       ```bash
       jq -r '.scripts[] | select(.execute == true) | .script' "$JSON_FILE"
       ```
     - Exibe um header simpático (`files/header.txt`) e executa cada script em ordem.

5. **Código legível e reaproveitável**
   - Cada script tem um cabeçalho padrão com:
     - `@descr` — descrição em português do que ele instala.
     - `@fonts` — links para documentação oficial ou para o script de referência no Garden of Eden original.
   - Fica muito fácil entender, depurar e adaptar.

---

## Requisitos

Do ponto de vista de ambiente, o Garden of Eden Light assume:

- **Sistema operacional**:
  - Focado em **Ubuntu/Debian ou derivadas**, já que os scripts usam fortemente `apt`, `add-apt-repository`, etc.
- **Shell**:
  - `bash` (todos os scripts começam com `#!/bin/bash`).
- **Permissões**:
  - Usuário com acesso a `sudo` (muitos scripts instalam pacotes de sistema).
- **Conectividade**:
  - Acesso à internet para baixar pacotes, repositórios externos, binários etc.
- **Ferramentas auxiliares**:
  - `jq` – instalado automaticamente pelo próprio `run-scripts.sh` caso não exista.
- **Cuidados**:
  - Ideal rodar em ambiente relativamente “limpo” ou em VM, especialmente no perfil `all`, já que ele pode instalar muita coisa pesada (Docker, VirtualBox, etc.).

---

## Arquitetura e estrutura do projeto

Estrutura principal (nível de diretório):

```text
garden-of-eden-light/
  run-scripts.sh
  scripts-all.json
  scripts-dev.json
  scripts-trading.json
  LICENSE
  files/
  src/
    scripts/
  .vscode/
```

### Componentes principais

- **`run-scripts.sh`**
  - Coração do projeto.
  - Responsável por:
    - Ler o parâmetro `--file`/`-f` (nome do JSON).
    - Validar se o parâmetro foi passado.
    - Garantir que `jq` exista (instala se não existir).
    - Ler os scripts a partir do JSON.
    - Exibir o banner (`files/header.txt`).
    - Executar um a um:
      ```bash
      bash "./src/scripts/$SCRIPT"
      ```

- **Arquivos de configuração de perfil**
  - `scripts-all.json`
  - `scripts-dev.json`
  - `scripts-trading.json`
  - Cada um contém um objeto:
    ```json
    {
      "scripts": [
        { "script": "script-git.sh", "execute": false },
        { "script": "script-docker.sh", "execute": false }
      ]
    }
    ```
  - A **ordem dos scripts no array é a ordem de execução**.

- **`src/scripts/`**
  - Contém **36 scripts Shell**, cada um cuidando de instalar uma ferramenta específica.
  - Exemplo de cabeçalho padrão:
    ```bash
    # @descr: Script de instalação do Docker na maquina
    # @fonts: https://github.com/alisonbuss/garden-of-eden/...
    # @example:
    #       bash script-docker.sh
    ```
  - Os scripts são independentes: nenhum recebe parâmetro do JSON; todos são chamados “crus”.

- **`files/`**
  - `header.txt` – banner exibido antes de iniciar a execução dos scripts.
  - `logo-garden-of-eden.png` – logotipo.
  - `starship/starship.toml` – configuração de prompt (Starship).
  - `docker/` – arquivos auxiliares para configuração do Docker (`daemon.json`, systemd units).
  - `wallpapers/` – wallpapers diversos.
  - `ledger-live/` – assets para atalho/ícone do Ledger Live.

- **`.vscode/`**
  - Configurações de workspace para edição do projeto (por exemplo, formatação, lint de shell, etc.).

Em resumo, a arquitetura é:

> **Orquestrador (`run-scripts.sh`) → lê perfil (`scripts-*.json`) → dispara scripts (`src/scripts/*.sh`) → usa arquivos auxiliares (`files/`) quando necessário.**

---

## Perfis de instalação

### scripts-all.json

- **Propósito**: perfil “completão”.
- Inclui **todos os 36 scripts**.
- Útil para:
  - Máquina pessoal onde você quer ter tudo (dev ou trading ou infra).
  - Ambiente de laboratório/VM para testes.

Por padrão, todos os scripts vêm com `"execute": false`, e você liga apenas o que quer instalar naquele momento.

### scripts-dev.json

- **Propósito**: focado em **desenvolvimento e DevOps**.
- Inclui scripts relacionados a:
  - Ferramentas básicas: `script-tools.sh`, `script-git.sh`, `script-flatpak.sh`.
  - Linguagens e runtimes:
    - `script-jenv.sh`, `script-open-jdk.sh`, `script-oracle-jdk.sh`.
    - `script-nvm.sh`, `script-nodejs.sh`.
    - `script-golang.sh`, `script-python3.sh`, `script-dotnet-sdk.sh`.
  - DevOps/Cloud:
    - `script-aws.sh`, `script-packer.sh`, `script-terraform.sh`.
    - `script-ansible.sh`.
  - Infra:
    - `script-virtualbox.sh`, `script-vagrant.sh`.
    - `script-docker.sh`, `script-docker-compose.sh`.
  - Ferramentas de desenvolvimento:
    - `script-hyper.sh`, `script-vscode.sh`, `script-gitkraken.sh`.
    - `script-dbeaver-community.sh`.
    - `script-postman.sh`, `script-insomnia.sh`, `script-hoppscotch.sh`.
    - `script-spring-tools-eclipse.sh`.
  - Navegador:
    - `script-chrome.sh`.

Também aqui, todos começam com `"execute": false`.

### scripts-trading.json

- **Propósito**: ambiente enxuto para **trading/cripto**.
- Scripts incluídos:
  - Base/ferramentas:
    - `script-tools.sh`
    - `script-git.sh`
    - `script-flatpak.sh`
    - `script-open-jdk.sh`
  - Infra para rodar plataformas/tools:
    - `script-docker.sh`, `script-docker-compose.sh`
    - `script-virtualbox.sh`
  - Ferramentas gerais de uso diário:
    - `script-chrome.sh`
    - `script-vscode.sh`
  - Foco em trading/cripto:
    - `script-protonvpn.sh`
    - `script-exodus.sh`
    - `script-ledger.sh`
    - `script-tradingview.sh`

Esse perfil é bem interessante para separar um ambiente de trading em VM isolada, por exemplo.

---

## Tabela de resumo de todos os scripts

### Script, Descrição, Perfis padrão

> **Perfis padrão** abaixo indicam em quais arquivos cada script aparece
> (`all`, `dev`, `trading`).
> Em todos eles, o valor inicial de `execute` é **false**.
> São 36 scripts no total.

| Script | Descrição | Perfis onde aparece |
|--------|-----------|---------------------|
| `script-ansible.sh` | Instala o Ansible via PPA oficial no Ubuntu (add-apt-repository + apt), apenas se o binário ainda não existir, e valida a instalação exibindo a versão. | all, dev |
| `script-aws.sh` | Instala o AWS CLI a partir do bundle oficial em `.zip`, executa o instalador em Python para colocar o binário em `/usr/local/bin/aws` e, ao final, confere a versão instalada. | all, dev |
| `script-bottles.sh` | Instala o Bottles via Flatpak a partir do Flathub, garantindo que o comando `flatpak run com.usebottles.bottles` funcione e exibindo informações da instalação (versão e metadados do app). | all |
| `script-cfssl.sh` | Baixa os binários oficiais do CFSSL e CFSSLJSON no GitHub da Cloudflare, copia para `/usr/local/bin` com permissão de execução e realiza um teste simples exibindo a versão. | all, dev |
| `script-chrome.sh` | Faz o download do pacote `.deb` do Google Chrome para Ubuntu/Debian, instala via `dpkg`/`apt` e registra o navegador no sistema, caso ainda não esteja presente. | all, dev, trading |
| `script-dbeaver-community.sh` | Instala o DBeaver Community Edition usando o pacote `.deb` disponibilizado pelo projeto, resolve dependências com o `apt` e deixa o cliente de banco de dados pronto para uso. | all, dev |
| `script-docker-compose.sh` | Instala o Docker Compose V2 no formato de plugin de CLI, baixando o binário oficial e posicionando-o em `~/.docker/cli-plugins/docker-compose`, com permissão de execução e checagem da versão. | all, dev, trading |
| `script-docker.sh` | Instala o Docker Engine a partir dos binários oficiais (`tar.gz`) da Docker, copia os executáveis para `/usr/local/bin`, configura os serviços systemd (socket/service) e ajusta permissões para uso local. | all, dev, trading |
| `script-dotnet-sdk.sh` | Instala (ou remove) o .NET SDK em sistemas Ubuntu/Debian seguindo o script oficial da Microsoft, adicionando o feed de pacotes adequado e verificando a versão ao final. | all, dev |
| `script-exodus.sh` | Instala a carteira Exodus Wallet baixando o pacote `.deb` oficial para Linux, instalando-o via `dpkg`/`apt` e validando a instalação executando o binário `exodus`. | all, trading |
| `script-flatpak.sh` | Habilita suporte ao Flatpak no sistema, adiciona o repositório Flathub, instala o utilitário gráfico Flatseal e lista versões/pacotes, preparando o ambiente para instalar apps em sandbox. | all, dev, trading |
| `script-git.sh` | Instala o Git via `apt` (caso ainda não exista), configura `user.name` e `user.email` globais, mostra a configuração ativa e, opcionalmente, testa a conexão SSH com o GitHub. | all, dev, trading |
| `script-gitkraken.sh` | Instala o cliente GitKraken usando o pacote `.deb` oficial, resolve dependências com o `apt` e deixa o cliente Git gráfico disponível no menu do sistema. | all, dev |
| `script-golang.sh` | Instala ou atualiza a linguagem Go baixando o tarball oficial do site `go.dev`, movendo o conteúdo para `~/.go`, configurando `GOROOT`, `GOPATH` e `PATH` e exibindo a versão para validação. | all, dev |
| `script-hoppscotch.sh` | Instala o Hoppscotch Desktop para testes de APIs HTTP/REST baixando o pacote `.deb` publicado no GitHub do projeto, instalando via `dpkg` e corrigindo dependências com `apt`. | all, dev |
| `script-hyper.sh` | Instala o terminal Hyper baixando o pacote `.deb` oficial, instalando via `apt`, conferindo o binário e incluindo comentários no script sobre configuração opcional do prompt Starship. | all, dev |
| `script-insomnia.sh` | Instala o cliente Insomnia para testes de APIs HTTP/REST baixando o `.deb` oficial, instalando com `dpkg` e ajustando dependências pelo `apt`. | all, dev |
| `script-jenv.sh` | Instala o jEnv (via clone do repositório Git oficial), cria a pasta `~/.jdks`, configura o `PATH` e o hook de inicialização no shell, e documenta como adicionar e alternar versões de JDK. | all, dev |
| `script-keyssh.sh` | Gera uma nova chave SSH RSA 4096 bits para o usuário logado em `~/.ssh`, caso ainda não exista, usando um comentário padrão e senha em branco, sem sobrescrever chaves previamente criadas. | all, dev |
| `script-ledger.sh` | Instala o Ledger Live Desktop em formato AppImage, aplica as regras udev oficiais da Ledger, instala dependências (como `libfuse2`), move o AppImage para `/usr/local/bin` e cria ícone/arquivo `.desktop`. | all, trading |
| `script-nodejs.sh` | Usa o NVM já instalado para baixar e ativar uma versão específica do Node.js, exibe as versões de `node` e `npm` e arruma permissões do diretório de configuração do usuário (`~/.config`). | all, dev |
| `script-nvm.sh` | Instala o Node Version Manager (NVM) seguindo o script oficial do GitHub, adiciona as linhas de inicialização ao `.bashrc`/`.profile` e deixa o ambiente pronto para gerenciar múltiplas versões de Node.js. | all, dev |
| `script-open-jdk.sh` | Instala o OpenJDK 11 via `apt` em Ubuntu/Debian, juntamente com o Apache Maven, e exibe as versões de Java e Maven, montando um ambiente Java básico de desenvolvimento. | all, dev, trading |
| `script-oracle-jdk.sh` | Instala o Oracle JDK a partir do tarball oficial da Oracle em `~/.jdks`, integra a instalação com o jEnv, lista versões disponíveis e define a versão Oracle como global, validando com `java --version`. | all, dev |
| `script-packer.sh` | Instala o HashiCorp Packer baixando o `.zip` oficial, extraindo o binário para `/usr/local/bin`, criando o diretório `~/.packer` e exibindo a versão para confirmação. | all, dev |
| `script-postman.sh` | Instala o Postman como cliente de APIs baixando o tarball oficial, extraindo para `/opt/Postman`, criando um link simbólico em `/usr/local/bin` e registrando um `.desktop` em `~/.local/share/applications`. | all, dev |
| `script-protonvpn.sh` | Instala o Proton VPN para Linux adicionando o repositório oficial da Proton, importando a chave GPG, instalando o pacote da interface gráfica e documentando no script o uso da CLI alternativa. | all, trading |
| `script-python3.sh` | Garante a presença do Python 3 via `apt`, instala o `python3-pip`, valida as versões de `python3`/`pip3` e inclui comentário com alternativa de uso em container Docker. | all, dev |
| `script-spring-tools-eclipse.sh` | Baixa e instala o Spring Tools Suite 4 (Eclipse-based), extrai o pacote para um diretório dedicado e deixa o launcher pronto para abrir o IDE focado em desenvolvimento Spring. | all, dev |
| `script-terraform.sh` | Instala o Terraform baixando o `.zip` oficial da HashiCorp, extraindo o binário para `/usr/local/bin`, cria `~/.terraform`, instala o Graphviz e valida a instalação com `terraform version`. | all, dev |
| `script-tools.sh` | Instala um conjunto de utilitários de linha de comando e desktop (wget, curl, tree, xz-utils, ferramentas de sistema, suporte a extensões GNOME etc.), usando `apt` e trazendo no próprio script dicas extras de configuração. | all, dev, trading |
| `script-tradingview.sh` | Instala o TradingView Desktop para Linux baixando o pacote `.deb` oficial para Ubuntu, instalando via `dpkg`/`apt` e deixando o aplicativo pronto para uso em rotinas de trading. | all, trading |
| `script-vagrant.sh` | Instala o Vagrant baixando o `.zip` oficial para Linux, extraindo o binário para `/usr/local/bin`, criando `~/.vagrant` e incluindo exemplos de Vagrantfile e comandos básicos (up, ssh, halt, destroy). | all, dev |
| `script-virtualbox.sh` | Instala o VirtualBox no Linux baixando o instalador oficial (script `.run` ou `.deb`), executando o instalador, tratando dependências com `apt` e importando o Extension Pack para habilitar recursos adicionais. | all, dev, trading |
| `script-vscode.sh` | Instala o Visual Studio Code baixando o `.deb` oficial da Microsoft, instalando com `dpkg`/`apt`, e em seguida exibe a versão do `code`, integrando o editor ao menu do sistema. | all, dev, trading |
| `script-yt-dlp.sh` | Instala o yt-dlp (downloader de áudio/vídeo) baixando o binário oficial do GitHub, copiando-o para `~/.local/bin` com permissão de execução e documentando comandos básicos e o uso com frontends gráficos. | all |


---

## Como usar

### 1. Clonar o repositório

```bash
git clone https://github.com/<seu-usuario>/garden-of-eden-light.git
cd garden-of-eden-light
```

> Ajuste a URL real do seu repositório no GitHub.

### 2. Dar permissão de execução

```bash
chmod +x run-scripts.sh
chmod +x src/scripts/*.sh
```

### 3. Escolher o perfil de instalação

Você tem três perfis principais à disposição:

- `scripts-all.json`
- `scripts-dev.json`
- `scripts-trading.json`

Escolha um de acordo com o que você quer provisionar.

### 4. Habilitar/desabilitar scripts no JSON

Edite o arquivo JSON escolhido e marque os scripts que deseja executar:

```json
{
  "scripts": [
    { "script": "script-tools.sh", "execute": true  },
    { "script": "script-git.sh",   "execute": true  },
    { "script": "script-docker.sh","execute": false }
  ]
}
```

- Apenas os scripts com `"execute": true` serão rodados.
- A ordem dos itens em `"scripts"` define a ordem de execução.

### 5. Executar o projeto(`run-scripts.sh`)

> **Nota:**
>
> *Ajuste as variáveis de ambiente [GIT_USER_NAME e  GIT_USER_EMAIL] do script **src/scripts/script-git.sh**  antes de executar.*

Exemplo:
```bash
...
readonly GIT_USER_NAME="YouName";
readonly GIT_USER_EMAIL="youname@gmail.com";
...
```

Use o parâmetro `--file` (ou `-f`) para indicar o perfil:

```bash
# Exemplo com perfil completo:
bash run-scripts.sh --file scripts-all.json

# Forma abreviada:
bash run-scripts.sh -f scripts-dev.json
```

Se você não passar o parâmetro, o script retorna um erro amigável:

```bash
use: ./run-scripts.sh --file <file_name>
```

---

## Formato dos arquivos scripts-*.json

Formato padrão:

```json
{
  "scripts": [
    {
      "script": "script-nome.sh",
      "execute": false
    },
    {
      "script": "script-outro.sh",
      "execute": true
    }
  ]
}
```

Regras:

- Campo **`script`**:
  - Nome exato do arquivo dentro de `src/scripts/`.
- Campo **`execute`**:
  - `true` → será executado.
  - `false` → será ignorado.
- Não há:
  - `action`, `param`, `logsPath` etc. (diferente do Garden of Eden original).

Isso torna o modelo extremamente fácil de manter:

> “Um script = uma responsabilidade”.

---

## Lista de scripts disponíveis

Organizando por categoria:

### Ferramentas base / sistema

- `script-tools.sh` – ferramentas comuns.
- `script-flatpak.sh` – suporte ao Flatpak.
- `script-chrome.sh` – Google Chrome.
- `script-hyper.sh` – terminal Hyper.
- `script-yt-dlp.sh` – yt-dlp.
- `script-bottles.sh` – Bottles (rodar apps Windows em “garrafas”).

### Controle de código e SSH

- `script-git.sh` – Git.
- `script-gitkraken.sh` – GitKraken.
- `script-keyssh.sh` – geração/regeneração de chave SSH.

### Linguagens e runtimes

- `script-open-jdk.sh` – OpenJDK.
- `script-oracle-jdk.sh` – Oracle JDK.
- `script-jenv.sh` – jEnv (gerenciador de versões Java).
- `script-nvm.sh` – NVM (Node Version Manager).
- `script-nodejs.sh` – Node.js.
- `script-golang.sh` – Go.
- `script-python3.sh` – Python 3.
- `script-dotnet-sdk.sh` – .NET Core SDK.

### DevOps, Infra e Cloud

- `script-docker.sh` – Docker Engine.
- `script-docker-compose.sh` – Docker Compose.
- `script-virtualbox.sh` – VirtualBox.
- `script-vagrant.sh` – Vagrant.
- `script-ansible.sh` – Ansible.
- `script-terraform.sh` – Terraform.
- `script-packer.sh` – Packer.
- `script-aws.sh` – AWS CLI.
- `script-cfssl.sh` – CFSSL (Cloudflare’s PKI toolkit).

### Ferramentas de desenvolvimento / bancos / API

- `script-vscode.sh` – Visual Studio Code.
- `script-spring-tools-eclipse.sh` – Spring Tools Suite.
- `script-dbeaver-community.sh` – DBeaver.
- `script-postman.sh` – Postman.
- `script-insomnia.sh` – Insomnia.
- `script-hoppscotch.sh` – Hoppscotch Client.

### Trading e cripto

- `script-protonvpn.sh` – ProtonVPN.
- `script-exodus.sh` – Exodus Wallet.
- `script-ledger.sh` – Ledger Live.
- `script-tradingview.sh` – TradingView Desktop.

---

## Customização

### 1. Criar uma feature a partir da main

Fluxo Git sugerido:

```bash
git checkout main
git pull origin main
git checkout -b feature/nome-da-feature
```

### 2. Criar um novo script de instalação

1. Copie um script existente como base, por exemplo:

   ```bash
   cp src/scripts/script-tools.sh src/scripts/script-minha-ferramenta.sh
   ```

2. Edite o cabeçalho:

   ```bash
   # @descr: Script de instalação da Minha Ferramenta na maquina.
   # @fonts: <link da documentação oficial>
   # @example:
   #       bash script-minha-ferramenta.sh
   ```

3. Implemente a lógica de instalação (usando `apt`, `flatpak`, binário direto, etc.).

### 3. Adicionar o script a um perfil

Edite o JSON do perfil desejado, por exemplo `scripts-dev.json`:

```json
{
  "scripts": [
    { "script": "script-tools.sh", "execute": false },
    { "script": "script-minha-ferramenta.sh", "execute": false }
  ]
}
```

> Dica: posicione o script na ordem em que você quer que ele seja executado.

### 4. Executar apenas o novo script

Você tem duas opções:

1. **Criar um JSON minimalista** só com o novo script:

   ```json
   {
     "scripts": [
       { "script": "script-minha-ferramenta.sh", "execute": true }
     ]
   }
   ```

   E rodar:

   ```bash
   bash run-scripts.sh -f scripts-minha-ferramenta.json
   ```

2. Ou **habilitar apenas esse script** em um dos perfis existentes (`execute: true`) e deixar todos os outros `false`.

### 5. Fazer o commit da customização

```bash
git status
git add src/scripts/script-minha-ferramenta.sh scripts-dev.json
git commit -m "feat: adiciona script-minha-ferramenta ao perfil dev"
```

### 6. Atualizar a branch com main

```bash
git checkout main
git pull origin main
git checkout feature/nome-da-feature
git merge main
# ou git rebase main, conforme seu fluxo
```

### 6. Resolver conflitos, se houver

Se houver conflitos (por exemplo, em `scripts-dev.json`):

- Edite o arquivo, resolva manualmente.
- Depois:

```bash
git add scripts-dev.json
git commit
```

### 7. Subir a nova feature para origem

```bash
git push origin feature/nome-da-feature
```

E então abrir um Pull Request na plataforma que você estiver usando (GitHub, GitLab etc.).

---

## Licença

O projeto está licenciado sob a **MIT License**:

- Permite uso, cópia, modificação, merge, publicação e distribuição.
- Responsabilidade e garantia são limitadas (software fornecido “como está”).

> Em termos práticos: uso bem livre, inclusive para projetos pessoais ou comerciais.

[<img width="190" src="https://raw.githubusercontent.com/alisonbuss/my-files/master/files/images/logo-open-source-550x200px.png">](https://opensource.org/licenses)
[<img width="166" src="https://raw.githubusercontent.com/alisonbuss/my-files/master/files/images/icon-license-mit-500px.png">](https://github.com/alisonbuss/garden-of-eden-light/blob/main/LICENSE)

---

## Referências

* Do projeto original, Alison Buss. ***Garden of Eden***
  Acessado: *20 de Novembro de 2025.*
  Disponível: *[https://github.com/alisonbuss/garden-of-eden](https://github.com/alisonbuss/garden-of-eden)*.
* Canal YouTube Bóson Treinamentos, Fábio dos Reis. ***Programação no Linux***
  Acessado: *29 de Julho de 2017.*
  Disponível: *[https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs](https://www.youtube.com/playlist?list=PLucm8g_ezqNrYgjXC8_CgbvHbvI7dDfhs)*.
* Shell Scriptx Blog, Shamam. ***Trabalhando com funções Shell***
  Acessado: *19 de Setembro de 2017.*
  Disponível: *[http://shellscriptx.blogspot.com.br/2016/12/trabalhando-com-funcoes.html](http://shellscriptx.blogspot.com.br/2016/12/trabalhando-com-funcoes.html)*.
* mhavila, Márcio d'Ávila. ***Scripts Shell sob Controle***
  Acessado: *19 de Setembro de 2017.*
  Disponível: *[http://www.mhavila.com.br/topicos/unix/shscript.html](http://www.mhavila.com.br/topicos/unix/shscript.html)*.
* Blog pantuza, Gustavo Pantuza. ***COMO FUNCIONA O MAKEFILE***
  Acessado: *13 de Setembro de 2018.*
  Disponível: *[https://blog.pantuza.com/tutoriais/como-funciona-o-makefile/](https://blog.pantuza.com/tutoriais/como-funciona-o-makefile/)*.
* Blog Linux Journal, Mitch Frazier. ***Pattern Matching In Bash***
  Acessado: *13 de Maio de 2019.*
  Disponível: *[https://www.linuxjournal.com/content/pattern-matching-bash/](https://www.linuxjournal.com/content/pattern-matching-bash/)*.
* Blog dev.to, Niko Heikkila. ***Don't Use Bash for Scripting (All the Time)***
  Acessado: *13 de Maio de 2019.*
  Disponível: *[https://dev.to/nikoheikkila/don-t-use-bash-for-scripting-all-the-time-2kci/](https://dev.to/nikoheikkila/don-t-use-bash-for-scripting-all-the-time-2kci/)*.
