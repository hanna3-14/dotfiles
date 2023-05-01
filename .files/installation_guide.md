# Arch install guide

this is my personal Arch install guide including disk encryption

## prepare a stick with an arch iso
- `sudo dd if=<path_to_arch_iso> of=/dev/<path_to_stick> bs=4M status=progress oflag=sync`

## set keyboard layout to neo
- `loadkeys neo`

## set up a wifi connection
- `iwctl`
- `station list`
- `station wlan0 scan`
- `station wlan0 get-networks`
- `station wlan0 connect <wlan-name>`
- `exit`
- `ping archlinux.org`

## create partitions and encrypt home partition
- `lsblk`
- `gdisk /dev/<nvme0n1>`
- `o` create a new partition table
- `n` new partition (boot partition)
    - `1`
    - `default`
    - `+500M`
    - `ef00` (for UEFI)
- `n` new partition (root partition)
    - `2`
- `w` write the table to disk
- `cryptsetup -y -v luksFormat /dev/<nvme0n1p2>`
- `cryptsetup open /dev/<nvme0n1p2> cryptroot`
- `mkfs.vfat /dev/<nvme0n1p1>`
- `mkfs.ext4 /dev/mapper/cryptroot`

## mounten
- `mount /dev/mapper/cryptroot /mnt`
- `mkdir /mnt/boot`
- `mount /dev/<nvme0n1p1 /mnt/boot`

## install some packages
- `vim /etc/pacman.conf` Color, ILoveCandy, ParallelDownloads
- `pacstrap /mnt base base-devel linux linux-firmware linux-headers networkmanager vim gnome htop openssh gptfdisk dosfstools ntfs-3g dhcpcd intel-ucode iwd git fish bluez bluez-utils xorg i3-wm i3lock i3status i3blocks dmemu alacritty`

## fstab
- `genfstab -U /mnt > /mnt/etc/fstab`

## chrooten
- `arch-chroot /mnt`
- `ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime`
- `vim /etc/locale.gen` en\_US and de\_DE
- `locale-gen` generate languages
- `vim /etc/locale.conf`
```
LANG=en_US.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_TIME=de_DE.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_PAPER=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
```
- `vim /etc/vconsole.conf` KEYMAP=neo
- `vim /etc/hostname`

## add users
- `useradd -m -U -G wheel <username>`
- `passwd <username>`
- `passwd -l root`
- `visudo` %wheel ALL=(ALL) ALL %wheel NOPASSWD

## encryption
- `vim /etc/mkinitcpio.conf` add encrypt on HOOKS (after filesystem)
- `mkinitcpio -p linux`

## systemd bootloader
- `bootctl install`
- `cd /boot/loader`
- `blkid -s PARTUUID -o value /dev/<nvme0n1p2> >> entries/arch.conf`
- `vim entries/arch.conf`
```
title ArchLinux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options cryptdevice=PARTUUID=<PARTUUID>:cryptroot root=/dev/mapper/cryptroot rw
```
- `vim loader.conf`
```
default arch.conf
```
- `exit` leave chroot environment
- `reboot`

## basic setup after the installation
- `sudo systemctl enable NetworkManager`
- `sudo systemctl start NetworkManager`
- `sudo systemctl enable gdm`
- `sudo systemctl start gdm`

- `chsh -l`
- `chsh -s /usr/bin/fish`
- `sudo vim /etc/pacman.conf` Color, ILoveCandy, ParallelDownloads
- `cd /tmp`
- `git clone https://aur.archlinux.org/yay.git`
- `cd yay`
- `makepkg -si`
- `sudo systemctl enable bluetooth`
- `sudo systemctl start bluetooth`

## printer setup
- `sudo pacman -S cups gutenprint cups-pdf gtk3-print-backends nmap`
- `sudo systemctl enable cups`
- `sudo systemctl start cups`
- `sudo pacman -S system-config-printer`
- add printer in `printer settings`

### add scan functionality
- `sudo pacman -S sane-airscan`
- `scanimage -L` shows all available scanners
- `scanimage --device <device-name> --format=<pnm|tiff|png|jpeg> --output-file <filename> --progress`
