#!/bin/bash
# This is a custom install script for Arch
# This script is meant for Intel+Nvidia users
#
#First we will initialize pacman and populate it
pacman-key --init
pacman-key --populate archlinux
#Editing certain lines in /etc/pacman.conf for personal use
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/' /etc/pacman.conf
#Issues with installing Audio via default archinstall script; fix
pacman -S pipewire wireplumber pipewire-pulse pipewire-alsa --noconfirm
systemctl --user enable --now pipewire.service wireplumber.service pipewire-pulse.service
