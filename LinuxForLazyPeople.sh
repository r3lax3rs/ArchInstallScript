#!/bin/bash
#Lazy People Script
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
options=("Check Mouse Acceleration" "Disable Mouse Acceleration" "Quit")
select opt in "${options[@]}"
do
      case $opt in
        "Check Mouse Acceleration")
                xset q | grep -A 1 Pointer
                ;;
        "Disable Mouse Acceleration")
                xset m 0 0
                ;;
        "Quit")
                echo "Quiting..."
                break
                ;;
        *)
                echo "Invalid option"
                break
                ;;
      esac
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
COLUMNS=25
PS3="Please select an option: "
options=("Update-pacman" "Update-yay" "Check IP Address" "Check Kernel" "Quit")
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
                ip addr
                ;;
        "Check Kernel")
                uname -r
                ;;
        "Quit")
                echo "Quiting..."
                break
                ;;
        *)
                echo "Invalid option"
                break
                ;;
      esac
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
                break
                ;;
        *)
                echo "Invalid option"
                break
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
                break
                ;;
        *)
                echo "Invalid option"
                break
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
