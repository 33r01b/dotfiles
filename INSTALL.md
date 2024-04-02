# Docs

https://wiki.archlinux.org/title/installation_guide \
https://wiki.archlinux.org/title/Dm-crypt/Drive_preparation \
https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS

# Installation

### Set the console keyboard layout and font
```
# ls /usr/share/kbd/consolefonts/
# setfont ter-m20b
```

### Connect to the internet
```
# iwctl

[iwd]# device list
[iwd]# station <divice> scan
[iwd]# station <device> get-networks
[iwd]# station <device> connect <SSID>
```

### Update the system clock
```
# timedatectl
```

### Partition the disks
Delete all partitions \
Create two new partitions \
+1GB EFI system \
rest of disk Linux filesystem

Identify devices
```
# fdisk -l
```
or
```
# lsblk
```

Modify partition table
```
# fdisk /dev/sda

[fidsk]# p // print the partition table
[fidsk]# d // delete all partitions
```

/boot
```
[fidsk]# n // new partition
[fidsk]# 1 // or <Enter>, first partition
[fidsk]# <Enter> // first sector, by default
[fidsk]# +1G // last sector, for /boot

[fidsk]# t // change partition type (EFI)
```

LVM:
```
[fidsk]# n // new partition
[fidsk]# 2 // or <Enter>, first partition
[fidsk]# <Enter> // first sector, by default
[fidsk]# <Enter> // last sector, all free space

[fidsk]# t // change partition type (Linux filesystem)
```

Show changes:
```
[fidsk]# p
```

Save changes:
```
[fidsk]# w
```

### Format boot filesystem

    mkfs.vfat -n BOOT /dev/sda1

### Wipe on an empty partition
    cryptsetup open --type plain -d /dev/urandom --sector-size 4096 /dev/sda2 to_be_wiped
    dd if=/dev/zero of=/dev/mapper/to_be_wiped status=progress bs=1M
    cryptsetup close to_be_wiped

### Create LUKS device

    cryptsetup -y luksFormat --type luks2 /dev/sda2
    cryptsetup open /dev/sda2 cryptlvm

### Preparing the logical volumes

    pvcreate /dev/mapper/cryptlvm

### Create a volume group

    vgcreate cryptvg /dev/mapper/cryptlvm

### Create all logical volumes on the volume group

    lvcreate -L 8G cryptvg -n swap
    lvcreate -l 100%FREE cryptvg -n root

### Format filesystems on each logical volume

    mkfs.ext4 /dev/cryptvg/root
    mkswap /dev/cryptvg/swap

### Mount partitions

    mount /dev/cryptvg/root /mnt
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot
    swapon /dev/cryptvg/swap

### Install essential packages

    pacstrap /mnt base base-devel linux linux-firmware lvm2 intel-ucode gvim sudo networkmanager mesa

### Generate an fstab file

    genfstab -Up /mnt >> /mnt/etc/fstab
    cat /mnt/etc/fstab

### Change root into the new system

    arch-chroot /mnt

### Set the time zone

    ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
    hwclock --systohc

### Localization
uncomment:

>en_US.UTF-8 UTF-8 \
>ru_RU.UTF-8 UTF-8

    vim /etc/locale.gen

    locale-gen

### Create the locale.conf
write:

>LANG=en_US.UTF-8 \
>LANGUAGE=en_US \
>LC_ALL=C

    vim /etc/locale.conf

### Set hostname

    echo arch > /etc/hostname

### Set root password

    passwd

### Create new user

    useradd -m -g users -G wheel,audio,video,input,lp,storage,network,power btw

### Set user password

    passwd btw

### Sudo
Uncomment line:
>%wheel ALL=(ALL) ALL

    visudo

### Initramfs
Open mkinitcpio.conf and add the following to each section:

>MODULES=(ext4)

On 'HOOKS' add 'encrypt lvm2' before 'filesystem' \
Something like this:

>HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)

    vim /etc/mkinitcpio.conf

    mkinitcpio -p linux

### Boot loader

    bootctl --path=/boot install

    echo 'default arch' >> /boot/loader/loader.conf
    echo 'timeout 3' >> /boot/loader/loader.conf

### Get device UUID from the system partition into arch.conf

    blkid -s UUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf

### Add the following content to arch.conf
The partition \<UUID> is already in the file.

>title Arch Linux \
>linux /vmlinuz-linux \
>initrd /intel-ucode.img \
>initrd /initramfs-linux.img \
>options cryptdevice=UUID=\<UUID>:cryptlvm root=/dev/cryptvg/root rw 

    vim /boot/loader/entries/arch.conf

### Exit new system and go into the cd shell

    exit

### Unmount all

    umount -R /mnt

### Reboot system

    reboot
