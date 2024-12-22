-   #My own installation script to make life a bit easier
-   #Some steps need to be done manually before using these
-   #When installing arch fresh even before using the default "archinstall" command to trigger the install script:
-   pacman-key --init
-   pacman-key --populate archlinux
-   pacman -Sy git base-devel --needed --noconfirm
-   git clone https://github.com/r3lax3rs/ScriptTesting
-   cd ScriptTesting
-   chmod +x PreInstall.sh
-   ./PreInstall.sh

-  #Then use the default archinstall script by typing in:
-  archinstall

-  #When done with that, reboot and login to your account.
-  #Open the Konsole (ALT + T)
-  #This script is meant for Intel+NVidia users to install video card drivers + configure all settings + make nvidia hook for when there are updates.
-  cd ScriptTesting
-  chmod +x ArchInstall.sh
-  ./ArchInstall.sh
