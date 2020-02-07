# Arch Linux
![Arch Linux Logo Dark](https://www.archlinux.org/static/logos/archlinux-logo-black-90dpi.0c696e9c0d84.png)

Official website: https://www.archlinux.org/

#### Table of Contents

1. [Bootable USB][Bootable USB]
2. [disk][disk]
    * [partition size][partition size]
    * [encryption][encryption]
    * [logical volume][logical volume]
    * [swap test][swap test]
    * [mount][mount]
    * [pacstrap][pacstrap]
    * [fstab][fstab]
3. [arch-chroot][arch-chroot]
    * [locale][locale]
    * [accounts][accounts]
    * [mkinitcpio][mkinitcpio]
    * [grub][grub]
    * [reboot][reboot]
4. [Post install instructions][Post install instructions]

## Setup

### Bootable USB
#### download

Download the ISO from the website: https://www.archlinux.org/download/

#### MD5SUM check

Create a MD5SUM file in the same directory as the ISO, e.g.:
``` bash
cd ~/Downloads
echo "9dbe3045aab5c7993b0c0c4033cb97f4 *archlinux.iso" > ./MD5SUM
md5sum -c MD5SUM
```

#### mount ISO file

``` bash
dd bs=4M if=archlinux.iso of=/dev/sdX status=progress oflag=sync
```

### disk
#### partition size

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
lvcreate --size 8G vg0 --name swap
lvcreate -l +100%FREE vg0 --name root
```

``` bash
mkfs.ext4 /dev/mapper/vg0-root
mkswap /dev/mapper/vg0-swap
```

#### swap test

``` bash
# activate swap
swapon /dev/mapper/vg0-swap
# swap devices and sizes
swapon -s
# virtual memory detailed
vmstat
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
pacstrap /mnt base base-devel linux linux-firmware grub-efi-x86_64 vim git efibootmgr dialog wpa_supplicant
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
> HOOKS="base udev autodetect modconf block encrypt lvm2 resume filesystems keyboard fsck"

```bash
mkinitcpio -p linux
```

#### grub

``` bash
grub-install
```

modify `/etc/default/grub`
> GRUB_CMDLINE_LINUX_DEFAULT="resume=/dev/mapper/vg0-swap"
> GRUB_CMDLINE_LINUX="cryptdevice=/dev/sdX3:luks:allow-discards"

``` bash
grub-mkconfig -o /boot/grub/grub.cfg
```

#### reboot

``` bash
exit
umount -R /mnt
# deactive swap
swapoff -a
# Don't forget to remove the cd/usb
reboot
```

#### Post install instructions

* [xorg]


[Bootable USB]: #bootable-usb
[disk]: #disk
[partition size]: #partition-size
[encryption]: #encryption
[logical volume]: #logical-volume
[swap test]: #swap-test
[mount]: #mount
[pacstrap]: #pacstrap
[fstab]: #fstab
[arch-chroot]: #arch-chroot
[locale]: #locale
[accounts]: #accounts
[mkinitcpio]: #mkinitcpio
[grub]: #grub
[reboot]: #reboot
[Post install instructions]: #Post-install-instructions

[xorg]: https://github.com/rowanruseler/dotfiles/tree/master/xorg
