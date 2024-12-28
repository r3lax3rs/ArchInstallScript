#!/bin/bash
#Lazy People Script
export Red='\e[38;5;196m'
export Reset='\033[0m'
export Cyan='e\[38;5;87m'
export Kernel=$(uname -r)
export whichOS=$(cat /etc/*release | grep PRETTY_NAME | cut -d '=' -f2- | tr -d '"' | awk '{print $1}')
#Mouse settings Arch:
mouseArch() {
clear
echo "-----------------------------------------"
echo "What would you like to do?"
echo "-----------------------------------------"
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
                echo -e "${Red}$(xset q | grep -A 1 Pointer)${Cyan}"
                ;;
        "Disable Mouse Acceleration")
                xset m 0 0
                ;;
        "Back to Main Menu")
                mainArch
                ;;
        "Quit")
                echo -e "${Red}Quiting...${Cyan}"
                exit
                ;;
        *)
                echo "Invalid option"
                exit
                ;;
      esac
      REPLAY=
echo
echo
echo "-----------------------------------------"
echo "What would you like to do?"
echo "-----------------------------------------"
echo
echo
done
}
#Arch Linux part
mainArch() {
clear
echo "-----------------------------------------"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo "-----------------------------------------"
echo "You are using: $whichOS"
echo "With Kernel: $Kernel"
echo "-----------------------------------------"
echo "What do you want to do?"
echo "-----------------------------------------"
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
                sudo pacman -Syu
                ;;
        "Update-yay")
                yay -Syu
                ;;
        "Check IP Address")
                echo -e "${Red}$(ip addr){Cyan}"
                ;;
        "Check Kernel")
                echo -e "${Red}$(uname -r){Cyan}"
                ;;
        "Advanced Mouse Settings")
                mouseArch
                ;;
        "Quit")
                echo "Quiting..."
                exit
                ;;
        *)
                echo "Invalid option"
                exit
                ;;
      esac
      REPLY=
echo
echo
echo "-----------------------------------------"
echo "You are using: $whichOS"
echo "With Kernel: $Kernel"
echo "-----------------------------------------"
echo "What do you want to do?"
echo "-----------------------------------------"
echo
echo
done
}
#Rocky Linux Part
mainRocky() {
clear
echo "-----------------------------------------"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo "-----------------------------------------"
echo "You are using: $whichOS"
echo "With Kernel: $Kernel"
echo "-----------------------------------------"
echo "What do you want to do?"
echo "-----------------------------------------"
echo
echo

Result=""
COLUMNS=25
PS3="Please select an option: "
options=("Update-Rocky" "Check IP Address" "Check Kernel" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Update-Rocky")
                sudo dnf update
                ;;
        "Check IP Address")
                ip addr
                ;;
        "Check Kernel")
                uname -r
                ;;
        "Quit")
                echo "Quiting..."
                exit
                ;;
        *)
                echo "Invalid option"
                exit
                ;;
      esac
done
}
#Ubuntu Linux Part
mainUbuntu() {
clear
echo "-----------------------------------------"
echo "Welcome to this simplified script!"
echo "The script will automaticly detect"
echo "which OS you are using and redirects"
echo "you to the right set of commands"
echo "-----------------------------------------"
echo "You are using: $whichOS"
echo "With Kernel: $Kernel"
echo "-----------------------------------------"
echo "What do you want to do?"
echo "-----------------------------------------"
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
                sudo apt update && sudo apt upgrade
                ;;
        "Check IP Address")
                ip addr
                ;;
        "Check Kernel")
                uname -r
                ;;
        "Quit")
                echo "Quiting..."
                exit
                ;;
        *)
                echo "Invalid option"
                exit
                ;;
      esac
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
