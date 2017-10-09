# Rowan's dotfiles

## Setup

### Bootable USB

Download the ISO from the website: https://www.archlinux.org/download/
Make sure to check the md5sum against the downloaded iso.


``` bash
dd bs=4M if=archlinux.iso of=/dev/sdX status=progress && sync
```

### disk
#### parition size

``` bash
cgdisk /dev/sdX
```

* 100M EFI, ef00
* 250M Boot, 8300
* Remaining, 8300

``` bash
mkfs.vfat -F32 /dev/sdX1
mkfs.ext2 /dev/sdX2
```

#### encryption

``` bash
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/sdX3
cryptsetup luksOpen /dev/sdX3 luks
```

#### logical volume

``` bash
pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks
lvcreate --size 9G vg0 --name swap
lvcreate -l +100%FREE vg0 --name root
```

``` bash
mkfs.ext4 /dev/mapper/vg0-root
mkswap /dev/mapper/vg0-swap
```

#### swap test

``` bash
swapon /dev/mapper/vg0-swap
```

#### mount

``` bash
mount /dev/mapper/vg0-root /mnt
mkdir /mnt/boot
mount /dev/sdX2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sdX1 /mnt/boot/efi
```

#### pacstrap

``` bash
pacstrap /mnt base base-devel grub-efi-x86_64 vim git efibootmgr dialog wpa_supplicant
```

#### fstab

``` bash
genfstab -pU /mnt >> /mnt/etc/fstab
```

Change relatime to noatime, this reduces wear for SSD drives.
Setup tmpfs, by adding:
> tmpfs  /tmp    tmpfs    defaults,noatime,mode=1777    0  0

### arch-chroot

``` bash
arch-chroot /mnt /bin/bash
```

``` bash
rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
hwclock --systohc --utc
```

#### locale

``` bash
echo LANG=en_US.UTF-8 >> /etc/locale.conf
echo LANGUAGE=en_US >> /etc/locale.conf
echo LC_ALL= >> /etc/locale.conf
```

Uncomment en_US.UTF-8 UTF-8 within `/etc/locale.gen`
``` bash
locale-gen
```

#### accounts

set root password
``` bash
passwd
```

create user(s)
``` bash
useradd -m -g users -G wheel -s /bin/bash USERNAME
passwd USERNAME
```

#### mkinitcpio

modify `/etc/mkinitcpio.conf`
> MODULES="ext4"
> HOOKS="base udev autodetect modconf block encrypt lvm2 filesystems keyboard fsck"

```bash
mkinitcpio -p linux
```

#### grub

``` bash
grub-install
```

modify `/etc/default/grub`
> GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdX3:luks:allow-discards"

``` bash
grub-mkconfig -o /boot/grub/grub.cfg
```

#### reboot

``` bash
exit
umount -R /mnt
swapoff -a
reboot
```
