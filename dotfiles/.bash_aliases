# Searches for all files (also hidden)
alias ll="ls -la"

# Update our system
alias update="sudo pacman -Syu"

# Update our package manager yay
alias updateyay="yay -Syu"

# Automaticly colors the IP adress when using 'ip addr'
alias ip='ip --color=auto'

# Some mouse commands
alias mouseacc='xset m 0 0'
alias mousecheck='xset q | grep -A 1 Pointer'

# Check session (X11 or Wayland)
alias sessioncheck='echo $XDG_SESSION_TYPE'

# After kernel update, check if kernel is mismatched. If so reboot.
alias kernel1='uname -r'
alias kernel2='pacman -Q linux'

# Dont want to type full command each time
alias shutdown='shutdown -h now'

# Disables mouse acceleration on startup
mouseacc
