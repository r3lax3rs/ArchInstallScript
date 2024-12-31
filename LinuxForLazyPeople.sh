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
#Mouse settings Arch:
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
#Clear Cache Rocky
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
                REPLY=
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
#Arch Linux part
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
options=("Update-pacman" "Update-yay" "Check IP Address" "Check Kernel" "Advanced Mouse Settings" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Update-pacman")
                clear
                sudo pacman -Syu
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
#Rocky Linux Part
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
#Ubuntu Linux Part
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
                ip addr
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
        echo "You have $whichOS installed." && mainUbuntu
        elif [[ "$whichOS" == "Arch" ]]; then
        echo "You have $whichOS installed." && mainArch
        elif [[ "$whichOS" == "Rocky" ]]; then
        echo "You have $whichOS installed." && mainRocky
        elif [[ "$whichOS" == "CentOS" ]]; then
        echo "You have $whichOS installed." && mainCentOS
        else
        echo "You have something else installed. Cant execute script." && exit
fi
