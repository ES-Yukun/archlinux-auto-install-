if [[ -z $username ]]; then
    export username="arch"
fi
if [[ -z $password ]]; then
    export password="1234567890"
fi
if [[ -z $disk ]]; then
    export disk="/dev/sda"
fi
if [[ -z $hostname ]]; then
    export hostname="archlinux"
fi
dd if=/dev/zero of=$disk bs=4M count=10
echo -e "g\nn\n\n\n+2G\nn\n\n\n\nw\n" | fdisk $disk
mkfs.xfs -f ${disk}2
mkfs.fat -F 32 ${disk}1
mount ${disk}2 /mnt
mkdir /mnt/boot
mount ${disk}1 /mnt/boot
echo -e "Server = https://mirror.cat.net/archlinux/\$repo/os/\$arch" >/etc/pacman.d/mirrorlist
pacman-key --init
pacman-key --populate archlinux
pacman -S archlinux-keyring --noconfirm
pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nano dhcpcd wget curl vim openssh
genfstab /mnt >/mnt/etc/fstab
echo -e "ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime" | arch-chroot /mnt
echo -e "echo \"en_US.UTF-8 UTF-8\" > /etc/locale.gen\nlocale-gen" | arch-chroot /mnt
echo -e "echo \"LANG=en_US.UTF-8\" > /etc/locale.conf" | arch-chroot /mnt
echo -e "echo \"$hostname\" > /etc/hostname" | arch-chroot /mnt
echo -e "useradd -m -G wheel -s /bin/bash $username" | arch-chroot /mnt
echo -e "passwd $username\n$password\n$password\n" | arch-chroot /mnt
echo -e "sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) NOPASSWD:ALL/g' /etc/sudoers" | arch-chroot /mnt
echo -e "systemctl enable dhcpcd" | arch-chroot /mnt
echo -e "systemctl enable sshd" | arch-chroot /mnt
echo -e "pacman-key --init" | arch-chroot /mnt
echo -e "pacman-key --populate archlinux" | arch-chroot /mnt
echo -e "pacman --noconfirm -Sy archlinux-keyring xfsprogs intel-ucode" | arch-chroot /mnt
echo -e "grub-install --target=i386-pc $disk" | arch-chroot /mnt
echo -e "grub-mkconfig -o /boot/grub/grub.cfg" | arch-chroot /mnt
reboot
