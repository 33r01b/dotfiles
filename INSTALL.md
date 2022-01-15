# Docs

https://wiki.archlinux.org/title/Installation_guide \
https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS

# Instalation

### Update the system clock

    timedatectl set-ntp true

### Partition the disks
Remove all partitions \
Create two new partitions \
+1GB           ef00   EFI and boot \
rest of disk   8300   home and system \

    gdisk /dev/sda

/boot:

    (gdisk) n # new partition
    (gdisk) 1 # or <Enter>, first partition
    (gdisk) <Enter> # first sector, by default
    (gdisk) +1G # last sector, for /boot
    (gdisk) ef00 # set efi type

LVM:

    (gdisk) n # new partition
    (gdisk) 2 # or <Enter>, second partition
    (gdisk) <Enter> # first sector, by default
    (gdisk) <Enter> # last sector, all free space
    (gdisk) 8300 # set linux type

Show changes:

    (gdisk) p

Save changes:

    (gdisk) w // write

### Format boot volumt

    mkfs.vfat -n BOOT /dev/sda1

### Create LUKS device

    cryptsetup -y luksFormat --type luks2 /dev/sda2
    cryptsetup open /dev/sda2 cryptlvm

### Preparing the logical volumes

    pvcreate /dev/mapper/cryptlvm

### Create a volume group

    vgcreate cryptvg /dev/mapper/cryptlvm

### Create all logical volumes on the volume group:

    lvcreate -L 8G cryptvg -n swap
    lvcreate -l 100%FREE cryptvg -n root

### Format your filesystems on each logical volume:

    mkfs.ext4 /dev/cryptvg/root
    mkswap /dev/cryptvg/swap

### Mount partitions:

    mount /dev/cryptvg/root /mnt
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot
    swapon /dev/cryptvg/swap

### Connect to wifi

    nmcli radio wifi on
    nmcli device wifi list
    nmcli device wifi connect <SSID>

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
>LC_ALL=C \

    vim /etc/locale.conf

### Set hostname

    echo arch > /etc/hostname

### Set root password

    passwd

### Create new user

    useradd -m -g users -G wheel,video btw

### Set user password

    passwd btw

### Sudo
Uncomment line:
>%wheel ALL=(ALL) ALL

    visudo

### Initramfs
Open mkinitcpio.conf and add the following to each section:

>MODULES=(ext4)

On 'HOOKS' add 'encrypt' before 'filesystem' \
Something like this:

>HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 filesystems fsck)

    vim /etc/mkinitcpio.conf

    mkinitcpio -p linux

### Boot loader

    bootctl --path=/boot install

    echo 'default arch' >> /boot/loader/loader.conf
    echo 'timeout 3' >> /boot/loader/loader.conf

### Get the PARTUUID from the system partition into arch.conf

    blkid -s UUID -o value /dev/sda2 >> /boot/loader/entries/arch.conf

### Add the following content to arch.conf
The partition <UUID> is already in the file.

>title Arch Linux \
>linux /vmlinuz-linux \
>initrd /intel-ucode.img \
>initrd /initramfs-linux.img \
>options cryptdevice=UUID=<UUID>:cryptlvm root=/dev/cryptvg/root rw 

    vim /boot/loader/entries/arch.conf

### Exit new system and go into the cd shell

    exit

### Unmount all

    umount -R /mnt

### Reboot system

    shutdown -r now
