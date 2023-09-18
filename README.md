# Archlinux installer
This repo is providing install script for archlinux.

# Usage
```bash
export password="0123456789"
export username="arch"
export disk="/dev/sda"
pacman -Syu curl --noconfirm
curl -sL install.sh https://raw.githubusercontent.com/ES-Yukun/archlinux-installer/main/UEFI.sh | bash -
```
