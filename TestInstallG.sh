#!/bin/bash

# ─── Color Variables ─────────────────────────────────────────────
export Red='\e[38;5;196m'
export Reset='\033[0m'
export Cyan='\e[38;5;87m'

# ─── Error/Info Logging ──────────────────────────────────────────
LOG_FILE="$HOME/arch_install_errors_$(date +%d%m%Y_%H%M%S).log"
touch "$LOG_FILE"

log_error() {
    echo "[ERROR] $(date '+%d-%m-%Y %H:%M:%S') - $1" | tee -a "$LOG_FILE" >&2
}

log_info() {
    echo "[INFO] $(date '+%d-%m-%Y %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# ─── Root Check ──────────────────────────────────────────────────
if [[ $EUID -eq 0 ]]; then
    echo -e "\n${Red}Don't run this script as root. It can mess up your system${Reset}\n" 1>&2
    exit 1
fi

read -p "Password: " -s PWonce

# ─── Update System ───────────────────────────────────────────────
log_info "Updating system packages."
printf "%s\n" "$PWonce" | sudo -S pacman -Syu --noconfirm || log_error "System update failed."

# ─── Install yay ─────────────────────────────────────────────────
log_info "Installing yay and dependencies."
printf "%s\n" "$PWonce" | sudo -S pacman -S go --noconfirm --needed || log_error "Failed to install 'go'."
git clone https://aur.archlinux.org/yay.git || log_error "Failed to clone yay."
cd yay || exit 1
makepkg -s --noconfirm --needed || log_error "Failed to build yay."
printf "%s\n" "$PWonce" | sudo -S pacman -U *.pkg.tar.zst --noconfirm || log_error "Failed to install yay."
cd ..

# ─── Program Installations ───────────────────────────────────────
install_program() {
    name="$1"
    command="$2"
    log_info "Installing $name."
    eval "$command" || log_error "Failed to install $name."
}

# Yay installations
install_program "Brave" "yay -S brave-bin --needed --noconfirm"
install_program "Spotify" "yay -S spotify --needed --noconfirm"
install_program "Chrome" "yay -S google-chrome --needed --noconfirm"
install_program "OpenRGB" "yay -S openrgb --needed --noconfirm"
install_program "RPi Imager" "yay -S rpi-imager-bin --needed --noconfirm"
install_program "Vesktop" "yay -S vesktop-bin --needed --noconfirm"
install_program "ProtonVPN" "yay -S proton-vpn-gtk-app --needed --noconfirm"
install_program "RealVNC Viewer" "yay -S realvnc-vnc-viewer --needed --noconfirm"
# Pacman Installations
install_program "Teamspeak3" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S teamspeak3 --needed --noconfirm"
install_program "Telegram" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S telegram-desktop --needed --noconfirm"
install_program "Geany" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S geany --needed --noconfirm"
install_program "curl" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S curl --needed --noconfirm"
install_program "Steam" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S steam --needed --noconfirm"
install_program "Discord" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S discord --needed --noconfirm"

# Disabled Installations
# install_program "NordVPN" "yay -S nordvpn-bin --needed --noconfirm"

# ─── OpenTabletDriver ─────────────────────────────────────────────
log_info "Installing OpenTabletDriver dependencies."
printf "%s\n" "$PWonce" | sudo -S pacman -S dotnet-runtime dotnet-host --needed --noconfirm || log_error "Failed dotnet runtime install."
git clone https://aur.archlinux.org/opentabletdriver.git || log_error "Failed to clone OpenTabletDriver."
cd opentabletdriver || exit 1
makepkg -s --noconfirm --needed || log_error "Build failed for OpenTabletDriver."
printf "%s\n" "$PWonce" | sudo -S pacman -U *.pkg.tar.zst --noconfirm || log_error "Install failed for OpenTabletDriver."
cd .. && rm -rf opentabletdriver

printf "%s\n" "$PWonce" | sudo -S mkinitcpio -P || log_error "mkinitcpio failed."
printf "%s\n" "$PWonce" | sudo -S rmmod wacom hid_uclogic || log_error "rmmod failed."
systemctl --user enable opentabletdriver.service --now || log_error "Failed to enable OpenTabletDriver."

# ─── 1Password ────────────────────────────────────────────────────
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import || log_error "Failed to import 1Password key."
git clone https://aur.archlinux.org/1password.git || log_error "Failed to clone 1Password."
cd 1password || exit 1
makepkg -s --noconfirm --needed || log_error "Build failed for 1Password."
printf "%s\n" "$PWonce" | sudo -S pacman -U *.pkg.tar.zst --noconfirm || log_error "Install failed for 1Password."
cd .. && rm -rf 1password

# ─── QEMU/KVM Setup ───────────────────────────────────────────────
install_program "VirtManager" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S qemu-full qemu-img libvirt virt-install virt-manager virt-viewer edk2-ovmf dnsmasq swtpm guestfs-tools libosinfo tuned --noconfirm --needed"
printf "%s\n" "$PWonce" | sudo -S systemctl enable libvirtd.service || log_error "Failed to enable libvirtd."
printf "%s\n" "$PWonce" | sudo -S systemctl start libvirtd.service || log_error "Failed to start libvirtd."
printf "%s\n" "$PWonce" | sudo -S virsh net-autostart default || log_error "Failed to autostart default net."

install_program "Vim" "printf '%s\\n' \"$PWonce\" | sudo -S pacman -S vim --needed --noconfirm"

# ─── VIM Config ───────────────────────────────────────────────────
mv -i /home/$USER/ArchInstallScript/.vimrc /home/$USER/ || log_error "Failed to move .vimrc"

# ─── Adding to video usergroup ( fixes small stutters/input lag in some games ────────────────────────
echo "Adding current user: $USER to video group"
printf "%s\n" "$PWonce" | sudo usermod -aG video $USER
wait

# ─── KDE Config Restore ───────────────────────────────────────────
log_info "Restoring KDE configs."
DOTFILES_DIR="$HOME/ArchInstallScript/dotfiles/.config"
BACKUP_DIR="$HOME/kde_backup_$(date +%d%m%Y%H%M%S)"
KDE_CONFIG_DIR="$HOME/.config"
mkdir -p "$BACKUP_DIR"

KDE_FILES=("kdeglobals" "kwinrc" "plasma-org.kde.plasma.desktop-appletsrc")

for file in "${KDE_FILES[@]}"; do
    src="$DOTFILES_DIR/$file"
    dest="$KDE_CONFIG_DIR/$file"

    if [ -f "$dest" ]; then
        log_info "Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/" || log_error "Failed to backup $dest"
    fi

    ln -sf "$src" "$dest" || log_error "Failed to symlink $src to $dest"
    log_info "Linked $src → $dest"
done

log_info "All done! Please log out and back in or reboot to apply KDE config changes."

# Move .bashrc and .bash_aliases
log_info "Copying .bashrc and .bash_aliases to home directory..."
cp -v "$HOME/ArchInstallScript/.bashrc" "$HOME/.bashrc" || log_error "Failed to copy .bashrc"
cp -v "$HOME/ArchInstallScript/.bash_aliases" "$HOME/.bash_aliases" || log_error "Failed to copy .bash_aliases"
source $HOME/.bashrc
source $HOME/.bash_aliases

echo -e "${Cyan}Everything has been installed.${Reset}"
sleep 2
echo -e "${Cyan}Exiting script!${Reset}"
sleep 2
