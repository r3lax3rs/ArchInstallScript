#!/bin/bash
# This is a custom install script for Arch
# This script is meant for Intel+Nvidia users
#
#Editing certain lines in /etc/pacman.conf for personal use
sed -i 's/#Color/Color/' /etc/pacman.conf
sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 20/' /etc/pacman.conf
#sed -i 's/#HookDir     = /etc/pacman.d/hooks/HookDir     = /etc/pacman.d/hooks/' /etc/pacman.conf
#
# Installing below is fixed in the newer .iso files from Arch
#Issues with installing Audio via default archinstall script; fix
#pacman -S pipewire wireplumber pipewire-pulse pipewire-alsa base-devel --needed --noconfirm
#systemctl --user enable --now pipewire.service wireplumber.service pipewire-pulse.service
#
#Installing through the JSON user configuration from the archinstall script
#First getting file through git
#pacman -S git --needed --noconfirm
#git user_configuration.json
#
#archinstall --config /path/to/user_configuration.json
#--creds = to specify a credentials configuration file user_configuration.json
#check how this works and if i can put it in a variable the user has to give (user+pw & create file + use it)
