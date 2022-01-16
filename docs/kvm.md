# KVM

### Install KVM packages

    sudo pacman -S virt-manager qemu vde2 ebtables dnsmasq bridge-utils openbsd-netcat

### Start KVM libvirt service

    sudo systemctl enable libvirtd.service
    sudo systemctl start libvirtd.service

### Enable normal user account to use KVM

Open the file /etc/libvirt/libvirtd.conf for editing.

    sudo vim /etc/libvirt/libvirtd.conf

Set the UNIX domain socket group ownership to libvirt

    unix_sock_group = "libvirt"

Set the UNIX socket permissions for the R/W socket

    unix_sock_rw_perms = "0770"

Add your user account to libvirt group.

    sudo usermod -a -G libvirt $(whoami)
    newgrp libvirt

Restart libvirt daemon.

    sudo systemctl restart libvirtd.service

### Enable Nested Virtualization (Optional)

    sudo modprobe -r kvm_intel
    sudo modprobe kvm_intel nested=1

To make this configuration persistent,run:

    echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf

### Using KVM

    virt-manager
