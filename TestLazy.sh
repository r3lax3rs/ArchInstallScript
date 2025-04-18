#!/bin/bash
#Lazy People Script
export Red='\e[38;5;196m'
export Reset='\033[0m'
export Cyan='\e[38;5;87m'
export Kernel=$(uname -r)
export whichOS=$(cat /etc/*release | grep PRETTY_NAME | cut -d '=' -f2- | tr -d '"' | awk '{print $1}')
export MouseAccel=$(xset q | grep -A 1 Pointer)
export Session=$(loginctl show-session $(loginctl | grep $(whoami) | awk '{print $1}') -p Type | cut -d "=" -f2- | awk '!/unspecified/')
export Acceloff=$(xset m 0 0)

# Submenu - Remove Programs Arch Linux
archRemovePrograms() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What would you like to remove?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=30
PS3="Please select an option: "
options=("Brave Browser" "Spotify" "Pycharm" "Osu!" "Back to Main Menu" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Brave Browser")
                clear
                yay -Rns brave-bin
                echo -e "${Red}Brave Browser is removed${Cyan}"
                ;;
        "Spotify")
                clear
                yay -Rns spotify
                echo -e "${Red}Spotify is removed${Cyan}"
                ;;
        "Pycharm")
                clear
                sudo rm -rf /opt/pycharm
                sed -i 's@export PATH=/opt/pycharm/bin:$PATH@@' $HOME/.bash_aliases
                echo -e "${Red}Pycharm is removed${Cyan}"
                ;;
        "Osu!")
                clear
                cd $HOME
                osu-wine --remove
                echo -e "${Red}Osu! is removed${Cyan}"
                ;;
        "Back to Main Menu")
            if [[ "$whichOS" == "Ubuntu" ]]; then
                    echo -e "${Cyan}Back to ${Red}Ubuntu!${Cyan}" && mainUbuntu
            elif [[ "$whichOS" == "Arch" ]]; then
                    echo -e "${Cyan}Back to ${Red}Arch!${Cyan}" && mainArch
            elif [[ "$whichOS" == "Rocky" ]]; then
                    echo -e "${Cyan}Back to ${Red}Rocky!${Cyan}" && mainRocky
            elif [[ "$whichOS" == "CentOS" ]]; then
                    echo -e "${Cyan}Back to ${Red}CentOS${Cyan}" && mainCentOS
            else
                    echo -e "${Red}An error has occured. Exiting..." && exit
            fi
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo "Invalid option"
                exit
                ;;
      esac
      REPLY=
echo
echo
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "Anything else you would like to remove?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

# Submenu - Installing Programs Arch Linux
archPrograms() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What would you like to install?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=30
PS3="Please select an option: "
options=("yay package manager" "Chrome Browser" "Brave Browser" "Spotify" "Pycharm" "Osu!" "Discord" "Vesktop" "ProtonVPN" "Real VNC Viewer" "RPi Imager" "Teamspeak 3" "Steam" "Geany" "Telegram" "Back to Main Menu" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "yay Package Manager")
                clear
                sudo -S pacman -S go --noconfirm --needed
                git clone https://aur.archlinux.org/yay.git
                cd yay
                makepkg -s --noconfirm --needed
                sudo -S pacman -U *.pkg.tar.zst --noconfirm
                cd $HOME
                echo -e "${Red}yay Package Manager is installed${Cyan}"
                ;;
        "Brave Browser")
                clear
                yay -S brave-bin --needed --noconfirm
                echo -e "${Red}Brave Browser is installed${Cyan}"
                sleep 2
                ;;
        "Chrome Browser")
                clear
                yay -S google-chrome --needed --noconfirm
                echo -e "${Red}Chrome Browser is installed${Cyan}"
                ;;
        "Spotify")
                clear
                yay -S spotify --needed --noconfirm
                echo -e "${Red}Spotify is installed${Cyan}"
                ;;
        "Pycharm")
                clear
                wget https://download.jetbrains.com/python/pycharm-community-2024.3.1.1.tar.gz
                wait
                sudo tar xzf pycharm-*.tar.gz -C /opt/
                sudo mv /opt/pycharm-* /opt/pycharm
                echo 'export PATH=/opt/pycharm/bin:$PATH' >> $HOME/.bash_aliases
                source $HOME/.bash_aliases~
                echo -e "${Red}Pycharm is installed${Cyan}"
                ;;
        "Osu!")
                clear
                git clone https://github.com/NelloKudo/osu-winello.git $HOME/osu-winello
                wait
                cd $HOME/osu-winello
                wait
                chmod +x osu-winello.sh
                wait
                ./osu-winello.sh
                wait
                cd ..
                wait
                rm -rf osu-winello
                wait
                cd $HOME
                wait
                echo -e "${Red}Osu! is installed${Cyan}"
                ;;
        "Discord")
                clear
                sudo pacman -S discord --needed --noconfirm
                echo -e "${Red}Discord is installed${Cyan}"
                ;;
        "Vesktop")
                clear
                yay -S vesktop-bin --needed --noconfirm
                echo -e "${Red}Vesktop is installed${Cyan}"
                ;;
        "ProtonVPN")
                clear
                yay -S proton-vpn-gtk-app --needed --noconfirm
                echo -e "${Red}ProtonVPN is installed${Cyan}"
                ;;
        "Real VNC Viewer")
                clear
                yay -S realvnc-vnc-viewer --needed --noconfirm
                echo -e "${Red}Real VNC Viewer is installed${Cyan}"
                ;;
        "RPi Imager")
                clear
                yay -S rpi-imager-bin --needed --noconfirm
                echo -e "${Red}RPi Imager is installed${Cyan}"
                ;;
        "Teamspeak 3")
                clear
                sudo -S pacman -S teamspeak3 --needed --noconfirm
                echo -e "${Red}Teamspeak 3 is installed${Cyan}"
                ;;
        "Steam")
                clear
                sudo pacman -S steam --needed --noconfirm
                echo -e "${Red}Steam is installed${Cyan}"
                ;;
        "Geany")
                clear
                sudo pacman -S geany --needed --noconfirm
                echo -e "${Red}Geany is installed${Cyan}"
                ;;
        "Telegram")
                clear
                sudo pacman -S telegram-desktop --needed --noconfirm
                echo -e "${Red}Telegram is installed${Cyan}"
                ;;
        "Back to Main Menu")
            if [[ "$whichOS" == "Ubuntu" ]]; then
                    echo -e "${Cyan}Back to ${Red}Ubuntu!${Cyan}" && mainUbuntu
            elif [[ "$whichOS" == "Arch" ]]; then
                    echo -e "${Cyan}Back to ${Red}Arch!${Cyan}" && mainArch
            elif [[ "$whichOS" == "Rocky" ]]; then
                    echo -e "${Cyan}Back to ${Red}Rocky!${Cyan}" && mainRocky
            elif [[ "$whichOS" == "CentOS" ]]; then
                    echo -e "${Cyan}Back to ${Red}CentOS${Cyan}" && mainCentOS
            else
                    echo -e "${Red}An error has occured. Exiting..." && exit
            fi
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo "Invalid option"
                exit
                ;;
      esac
      REPLY=
echo
echo
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "Anything else you want to install?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

# Submenu - Mouse settings Arch
mouseAdvanced() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What would you like to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=30
PS3="Please select an option: "
options=("Check Mouse Acceleration" "Disable Mouse Acceleration" "Back to Main Menu" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Check Mouse Acceleration")
                clear
                echo -e "${Red}${MouseAccel}${Cyan}"
                ;;
        "Disable Mouse Acceleration")
                clear
                echo -e "${Red}Mouse Accel is off!${Acceloff}${Cyan}"
                ;;
        "Back to Main Menu")
            if [[ "$whichOS" == "Ubuntu" ]]; then
                    echo -e "${Cyan}Back to ${Red}Ubuntu!${Cyan}" && mainUbuntu
            elif [[ "$whichOS" == "Arch" ]]; then
                    echo -e "${Cyan}Back to ${Red}Arch!${Cyan}" && mainArch
            elif [[ "$whichOS" == "Rocky" ]]; then
                    echo -e "${Cyan}Back to ${Red}Rocky!${Cyan}" && mainRocky
            elif [[ "$whichOS" == "CentOS" ]]; then
                    echo -e "${Cyan}Back to ${Red}CentOS${Cyan}" && mainCentOS
            else
                    echo -e "${Red}An error has occured. Exiting..." && exit
            fi
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo "Invalid option"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What would you like to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

# Submenu - Clear Cache Rocky
clearRocky() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What would you like to do?"
echo -e "${Red}-----------------------------------------${Cyan}"

Result=""
COLUMNS=30
PS3="Please select an option: "
options=("Clearing PageCache" "Clearing Dentries and Inodes" "Clearing PageCache, Dentries & Inodes" "Clear Swap Space" "Back to main menu" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Clearing PageCache")
                clear
                sudo sync; echo 1 > /proc/sys/vm/drop_caches
                echo -e "${Red}Cleared PageCache${Cyan}"
                ;;
        "Clearing Dentries and Inodes")
                clear
                sudo sync; echo 2 > /proc/sys/vm/drop_caches
                echo -e "${Red}Clearing Dentries and Inodes${Cyan}"
                ;;
        "Clearing PageCache, Dentries & Inodes")
                clear
                sudo sync; echo 3 > /proc/sys/vm/drop_caches
                echo -e "${Red}Cleared PageCache, Dentries & Inodes${Cyan}"
                ;;
        "Clear Swap Space")
                clear
                sudo swapoff -a && sudo swapon -a
                echo -e "${Red}Cleared Swap Space${Cyan}"
                ;;
        "Back to Main Menu")
            if [[ "$whichOS" == "Ubuntu" ]]; then
                    echo -e "${Cyan}Back to ${Red}Ubuntu!${Cyan}" && mainUbuntu
            elif [[ "$whichOS" == "Arch" ]]; then
                    echo -e "${Cyan}Back to ${Red}Arch!${Cyan}" && mainArch
            elif [[ "$whichOS" == "Rocky" ]]; then
                    echo -e "${Cyan}Back to ${Red}Rocky!${Cyan}" && mainRocky
            elif [[ "$whichOS" == "CentOS" ]]; then
                    echo -e "${Cyan}Back to ${Red}CentOS${Cyan}" && mainCentOS
            else
                    echo -e "${Red}An error has occured. Exiting..." && exit
            fi
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What would you like to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

#Arch Linux Main Menu
mainArch() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=30
PS3="Please select an option: "
options=("Update-pacman" "Installing Programs" "Removing Programs" "Update-yay" "Check IP Address" "Check Kernel" "Advanced Mouse Settings" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Update-pacman")
                clear
                sudo pacman -Syu
                ;;
        "Installing Programs")
                clear
                archPrograms
                ;;
        "Removing Programs")
                clear
                archRemovePrograms
                ;;
        "Update-yay")
                clear
                yay -Syu
                ;;
        "Check IP Address")
                clear
                echo -e "${Red}$(ip addr)${Cyan}"
                ;;
        "Check Kernel")
                clear
                echo -e "${Red}${Kernel}${Cyan}"
                ;;
        "Advanced Mouse Settings")
                mouseAdvanced
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo "Invalid option"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

# Rocky Linux Main Menu
mainRocky() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=25
PS3="Please select an option: "
options=("Update-Rocky" "Check IP Address" "Check Kernel" "Advanced Mouse Settings" "Clear Cache" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Update-Rocky")
                clear
                sudo dnf update
                ;;
        "Check IP Address")
                clear
                echo -e "${Red}$(ip addr)${Cyan}"
                ;;
        "Check Kernel")
                clear
                echo -e "${Red}${Kernel}${Cyan}"
                ;;
        "Advanced Mouse Settings")
                mouseAdvanced
                ;;
        "Clear Cache")
                clearRocky
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo -e "${Red}Invalid option${Cyan}"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

# Ubuntu Linux Main Menu
mainUbuntu() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=25
PS3="Please select an option: "
options=("Update-Ubuntu" "Check IP Address" "Check Kernel" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Update-Ubuntu")
                clear
                sudo apt update && sudo apt upgrade
                ;;
        "Check IP Address")
                clear
                echo -e "${Red}$(ip addr)${Cyan}"
                ;;
        "Check Kernel")
                clear
                echo -e "${Red}${Kernel}${Cyan}"
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo -e "${Red}Invalid option${Cyan}"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

#Debian Linux Main Menu
mainDebian() {
clear
echo -e "${Red}-----------------------------------------${Cyan}"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo

Result=""
COLUMNS=25
PS3="Please select an option: "
options=("Update-Debian" "Check IP Address" "Check Kernel" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Update-Debian")
                clear
                sudo apt-get update && sudo apt-get upgrade
                ;;
        "Check IP Address")
                clear
                echo -e "${Red}$(ip addr)${Cyan}"
                ;;
        "Check Kernel")
                clear
                echo -e "${Red}${Kernel}${Cyan}"
                ;;
        "Quit")
                clear
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                clear
                echo -e "${Red}Invalid option${Cyan}"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo -e "${Red}-----------------------------------------${Cyan}"
echo -e "You are using: ${Red}${whichOS}${Cyan}"
echo -e "Kernel: ${Red}${Kernel}${Cyan}"
echo -e "Session: ${Red}${Session}${Cyan}"
echo -e "${Red}-----------------------------------------${Cyan}"
echo "What do you want to do?"
echo -e "${Red}-----------------------------------------${Cyan}"
echo
echo
done
}

#Detecting OS and make use of the right function with each OS
if [[ "$whichOS" == "Ubuntu" ]]; then
        echo -e "${Cyan}You have ${Red}${whichOS} installed.${Cyan}" && mainUbuntu
        elif [[ "$whichOS" == "Arch" ]]; then
        echo -e "${Cyan}You have ${Red}${whichOS} installed.${Cyan}" && mainArch
        elif [[ "$whichOS" == "Rocky" ]]; then
        echo -e "${Cyan}You have ${Red}${whichOS} installed.${Cyan}" && mainRocky
        elif [[ "$whichOS" == "CentOS" ]]; then
        echo -e "${Cyan}You have ${Red}${whichOS} installed.${Cyan}" && mainCentOS
        elif [[ "$whichOS" == "Debian" ]]; then
        echo -e "${Cyan}You have ${Red}${whichOS} installed.${Cyan}" && mainDebian
        else
        echo -e "${Red}You have something else installed. Cant execute script.${Cyan}" && exit
fi
