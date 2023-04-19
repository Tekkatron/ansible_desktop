#!/bin/bash

# Función para instalar Ansible en Arch Linux
install_ansible_arch() {
    echo "Instalando Ansible en Arch Linux..."
    sudo pacman -Sy ansible --noconfirm
}

# Función para instalar Ansible en Fedora
install_ansible_fedora() {
    echo "Instalando Ansible en Fedora..."
    sudo dnf install ansible -y
}

# Función para instalar Ansible en Ubuntu
install_ansible_ubuntu() {
    echo "Instalando Ansible en Ubuntu..."
    sudo apt-get update
    sudo apt-get install software-properties-common -y
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install ansible -y
}

# Función para instalar Ansible en Debian
install_ansible_debian() {
    echo "Instalando Ansible en Debian..."
    sudo apt-get update
    sudo apt-get install ansible -y
}

# Comprobar distribución y ejecutar función correspondiente
if [ -f /etc/arch-release ]; then
    install_ansible_arch
elif [ -f /etc/fedora-release ]; then
    install_ansible_fedora
elif [ -f /etc/lsb-release ]; then
    install_ansible_ubuntu
elif [ -f /etc/debian_version ]; then
    install_ansible_debian
else
    echo "No se pudo determinar la distribución del sistema."
    exit 1
fi

echo "¡Ansible ha sido instalado exitosamente!"

ansible-pull -i ./inventory.ini -e ansible_user=$(whoami) -U https://github.com/Tekkatron/ansible_desktop