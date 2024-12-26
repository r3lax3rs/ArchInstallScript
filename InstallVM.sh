#!/bin/bash
# Make sure this script is run as root
if [[ $EUID -eq 0 ]]; then
    echo
    echo "Don't run this script as root. It can mess up your system" 1>&2
    echo
    exit
fi
wait
#Should make it so that we have to fill in our PW only once
read -p "Password: " -s PWonce
#First lets make sure our system is updated
printf "%s\n" "$PWonce" | sudo -S pacman -Syu --noconfirm
wait
#Install everything needed for QEMU/KVM Virtmanager
printf "%s\n" "$PWonce" | sudo -S pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf dnsmasq swtpm guestfs-tools libosinfo tuned --noconfirm --needed
wait
#Enable
sudo systemctl enable libvirtd.service
wait
sudo systemctl start libvirtd.service
echo "QEMU/KVM Virtmanager has been installed"
