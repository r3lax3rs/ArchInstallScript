#!/bin/bash
#
#list of variables
#Color variables for error ouput
flashred="\033[5;31;40m"
red="\033[31;40m"
none="\033[0m"
intel="GenuineIntel"
#
#Variables for comparisons
architecture="uname -m"
kernel="uname -r | awk {'print substr($0, length($0)-2, 3)'}" #zen or lts
linuxkernal="uname -r | awk {'print substr($0, length($0)-6, 4)'}" #arch
cpu="cat /proc/cpuinfo |grep vendor_id | awk '!seen[$0]++' | awk {'print $3'}"
mygpu="lspci -v |grep VGA | awk {'print $5'}"
#
#Disable systemd sleep services
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
#
#First lets do a first time update of our system
pacman -Syu --noconfirm
#Installing right headers for linux/linux-zen
if [[ "$kernel" == "zen" ]]; then
    echo "linux-zen kernal detected"
    sleep 2
    pacman -S linux-zen-headers linux-firmware linux-headers --needed --noconfirm
elif [[ "$kernel" == "lts" ]]; then
    echo "Linux-lts kernel detected"
    sleep 2
    pacman -S linux-lts-headers linux-headers --needed --noconfirm
elif [[ "$linuxkernal" == "arch" ]]; then
    echo "default linux kernel detected"
    sleep 2
    pacman -S linux-headers linux-firmware --needed --noconfirm
else
    echo "$flashredYou don't have linux, linux-lts or linux-zen kernel installed on your system!"
    echo "$flashredNo kernal headers will be installed! Script will continue in 10s"
    sleep 10
fi
#
#
#Installing intel-ucode for intel machines
if [[ "$cpu" == "$intel" ]]; then
    pacman -S intel-ucode --needed --noconfirm
else
    echo "$flashredError: You don't have an Intel CPU!"
    echo "$redSkipping to next step in 10s"
    sleep 10
fi
#
#Installing the right things to make arch work good
#pacman -S --needed --noconfirm

#Installing the right video card drivers
if [[ "$kernel" == "zen" && "$mygpu" == "NVIDIA" ]]; then
    echo "linux-zen & Nvidia detected; will install nvidia-dkms"
    sleep 2
    pacman -S nvidia-dkms --needed --noconfirm
elif [[ "$kernel" == "lts" ]] && "$mygpu" == "NVIDIA" ]]; then
    echo "linux-lts & Nvidia detected; will install nvidia-lts"
    sleep 2
    pacman -S nvidia-lts --needed --noconfirm
elif [[ "$linuxkernel" == "arch" ]] && "$mygpu" == "NVIDIA" ]]; then
    echo "default linux kernel & Nvidia detected; will install nvidia"
    sleep 2
    pacman -S nvidia --needed --noconfirm
fi
#Adding Nvidia hook for updates
cp ~/ScriptTesting/nvidia.hook /etc/pacman.d/hooks/
if [[ "$kernel" == "zen" && "$mygpu" == "NVIDIA" ]]; then
    echo "Script is already configured for linux-zen & nvidia-dkms"
elif [[ "$kernel" == "lts" ]] && "$mygpu" == "NVIDIA" ]]; then
    sed -i 's/Target=nvidia-dkms/Target=nvidia-lts/' /etc/pacman.d/hooks/nvidia.hook
    sed -i 's/Target=linux-zen/Target=linux-lts/' /etc/pacman.d/hooks/nvidia.hook
    echo "Config has been rewritten for linux-lts & nvidia-lts"
    sleep 2
elif [[ "$linuxkernel" == "arch" ]] && "$mygpu" == "NVIDIA" ]]; then
    sed -i 's/Target=nvidia-dkms/Target=nvidia/' /etc/pacman.d/hooks/nvidia.hook
    sed -i 's/Target=linux-zen/Target=linux/' /etc/pacman.d/hooks/nvidia.hook
    echo "Config has been rewritten for linux default kernal and default nvidia drivers"
    sleep 2
fi
#Editing GRUB config for Intel+Nvidia
if [[ "$cpu" == "$intel" ]] && [[ "$mygpu" == "NVIDIA" ]]; then
    sed -i 's/GRUB_CMDLINE_LINUX_DEFUALT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash loglevel=3 udev.log=priority=3 nvidia_drm.modeset=1 nvidia-drm.fbdev=1 ibt=off"/' /etc/default/grub
    echo "lines have been added to /etc/default/grub"
fi
#Adding user to video group
echo "Adding current user: $USER to video group"
usermod -aG video $USER
sleep 2
#Write settings to GRUB & mkinitcpio at the end of everything
grub-mkconfig -o /boot/grub/grub.cfg && mkinitcpio -P
echo "All settings have been written to the configs. Will reboot in 10sec"
sleep 10
#reboot now