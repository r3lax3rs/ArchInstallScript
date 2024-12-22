1 #My own installation script to make life a bit easier\
2 #Some steps need to be done manually before using these\
3 #When installing arch fresh even before using the default "archinstall" command to trigger the install script:\
4 pacman-key --init\
5 pacman-key --populate archlinux\
6 pacman -Sy git base-devel --needed --noconfirm\
7 git clone https://github.com/r3lax3rs/ScriptTesting\
8 cd ScriptTesting\
9 chmod +x PreInstall.sh\
10 ./PreInstall.sh\
