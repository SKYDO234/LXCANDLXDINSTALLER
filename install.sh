#!/bin/bash

clear

echo "======================================"
echo "      LXC + LXD Installer"
echo "======================================"
echo ""
echo "Select your Operating System:"
echo ""
echo "1) Ubuntu"
echo "2) Debian"
echo "0) Exit"
echo ""

read -p "Enter your choice: " choice

case $choice in

1)
    echo "Installing LXC + LXD for Ubuntu..."

    apt update && apt upgrade -y

    apt install -y lxc lxc-utils

    apt install -y snapd
    systemctl enable --now snapd.socket

    snap install lxd

    usermod -aG lxd $SUDO_USER

    newgrp lxd

    lxd init

    apt update

    apt install -y lxc lxc-utils bridge-utils uidmap

    echo ""
    echo "✅ Ubuntu Installation Completed!"
    ;;

2)
    echo "Installing LXC + LXD for Debian..."

    apt update && apt upgrade -y

    apt install -y lxc lxc-utils bridge-utils uidmap

    apt install -y snapd
    systemctl enable --now snapd.socket

    ln -sf /var/lib/snapd/snap /snap

    snap install lxd

    usermod -aG lxd $SUDO_USER

    newgrp lxd

    lxd init

    echo ""
    echo "✅ Debian Installation Completed!"
    ;;

0)
    echo "Goodbye!"
    exit
    ;;

*)
    echo "Invalid choice!"
    exit 1
    ;;

esac

echo ""
echo "Installation Finished!"
echo "Logout/Login or run:"
echo "newgrp lxd"
echo ""
echo "Check versions:"
echo "lxc --version"
echo "lxd --version"
