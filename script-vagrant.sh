#!/bin/bash

#-----------------------|DOCUMENTATION|-----------------------#
# @descr: Script de instalação do vagrant na maquina.
# @fonts: https://github.com/alisonbuss/garden-of-eden/blob/master/shell-script/dist-ubuntu/environment/script-vagrant.sh
# @example:
#       bash script-vagrant.sh
#-------------------------------------------------------------#

if command -v vagrant >/dev/null 2>&1; then
    echo "✅ Program(vagrant) already installed!";
    echo -e "--> Directory:" "$(command -v vagrant)" "\n";
else
    echo -e "📦 Installing the program: vagrant...\n";

    wget "https://releases.hashicorp.com/vagrant/2.4.7/vagrant_2.4.7_linux_amd64.zip" -O ~/Downloads/vagrant_amd64.zip;

    sudo unzip -o ~/Downloads/vagrant_amd64.zip -d /usr/local/bin/;

    mkdir -p ~/.vagrant;

    vagrant --version;

    sleep 1s;
fi

exit 0;

# O Vagrantfile é o coração do Vagrant. Pense nele como uma
# receita de bolo que qualquer um pode seguir para obter o
# mesmo resultado, sem surpresas. Eis um exemplo básico:

# Vagrant.configure("2") do |config|
#   config.vm.box = "centos/8"  # Escolha sua imagem base
#   config.vm.provider "virtualbox" do |vb|
#     vb.memory = "1024"       # Defina 1 GB de memória
#     vb.cpus = "2"            # E duas CPUs para trabalhar
#   end
#   config.vm.provision "shell", inline: <<-SHELL
#     dnf install -y httpd
#     systemctl enable httpd
#     systemctl start httpd
#   SHELL
# end

# Vagrant.configure("2") do |config|
#   config.vm.box = "ubuntu/jammy64"
#   config.vm.hostname = "lab-vm"
#   config.vm.network "public_network", type: "dhcp"
#   config.vm.provider "virtualbox" do |vb|
#     vb.memory = "1024"
#     vb.cpus = 2
#     vb.name = "lab-vm"
#   end
#   config.vm.provision "shell", inline: <<-SHELL
#     apt update
#     apt install -y nginx
#   SHELL
# end

# Comandos básicos:
# $ vagrant init → cria o Vagrantfile básico
# $ vagrant validate → valida se o Vagrantfile contém erros de sintaxe
# $ vagrant up → lê o Vagrantfile, baixa a box e cria a VM
# $ vagrant status → imprime na tela o estado da máquina
# $ vagrant ssh → conecta à VM via SSH
# $ vagrant halt → desliga a VM
# $ vagrant destroy → remove a VM completamente
