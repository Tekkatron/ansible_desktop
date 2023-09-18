#!/bin/bash

##### Set Ansible User 
ansible_user=$(whoami)

# Install to inestall Ansible on Arch Linux
install_ansible_arch() {
    echo "Installing Ansible on Arch Linux..."
    sudo pacman -Sy ansible --noconfirm
}

# Install to inestall Ansible on Fedora
install_ansible_fedora() {
    echo "Installing Ansible on Fedora..."
    sudo dnf install ansible -y
}

# Install to inestall Ansible on Ubuntu
install_ansible_ubuntu() {
    echo "Installing Ansible on Ubuntu..."
    sudo apt-get update
    sudo apt-get install software-properties-common -y
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt-get install ansible -y
	sudo apt install build-essential curl file git
}

# Install to inestall Ansible on Debian
install_ansible_debian() {
    echo "Installing Ansible on Debian..."
    sudo apt-get update
    sudo apt-get install ansible -y
}

# Check distribution family to proceed
if [ -f /etc/arch-release ]; then
    install_ansible_arch
elif [ -f /etc/fedora-release ]; then
    install_ansible_fedora
elif [ -f /etc/lsb-release ]; then
    install_ansible_ubuntu
elif [ -f /etc/debian_version ]; then
    install_ansible_debian
else
    echo "Unable to determine Linux distribution."
    exit 1
fi

echo "¡Ansible has been installed sucessfully"

ansible-pull -i ./inventory.ini -e ansible_user=$ansible_user -U https://github.com/Tekkatron/ansible_desktop