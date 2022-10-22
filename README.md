# Archlinux auto install 
This repo is providing install script for archlinux.

# Usage
```bash
pacman -Syu curl 
curl -sLo install.sh https://raw.githubusercontent.com/ES-Yukun/archlinux-auto-install/main/UEFI.sh
# If you are using BIOS mode, you need to change the url.
chmod +x ./install.sh
./install.sh
```

# DEFAULT CONFIG
- username: archuser
- password: 1234567890
- disk:     /dev/sda
- hostname: archlinux
- mirror:   cat.net
