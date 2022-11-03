### Common

    # pacman -S base-devel
    # pacman -S rxvt-unicode
    # pacman -S dbus
    # pacman -S xorg-xbacklight
    # pacman -S openresolv

    # systemctl enable systemd-timesyncd.service
    # systemctl start systemd-timesyncd.service

### Shell

    # pacman -S zsh zsh-completions
    # chsh -s /bin/zsh

### Network

    # pacman -S networkmanager \
        nm-connection-editor \
        networkmanager-openconnect \
        networkmanager-openvpn \
        networkmanager-pptp \
        networkmanager-vpnc \
        networkmanager-strongswan \
        networkmanager-l2tp \
        network-manager-sstp \
        rp-pppoe 

    # systemctl enable NetworkManager.service
    # systemctl start NetworkManager.service

#### SSH

    # pacman -S openssh

#### VPN

    # pacman -S wireguard-tools

#### Firewall

    # pacman -S ufw
    # systemctl enable ufw.service 


### Bluetooth

    # pacman -S bluez bluez-utils

    # systemctl enable bluetooth.service 
    # systemctl start bluetooth.service 

### Audio

    # pacman -S alsa-utils \
        alsa-plugins \
        alsa-firmware \
        alsa-ucm-conf \
        sof-firmware

    # pacman -S pulseaudio \
        pulseaudio-alsa \
        pulseaudio-bluetooth \
        pulseaudio-equalizer \
        pulseaudio-jack \
        pulseaudio-lirc \
        pulseaudio-zeroconf \
        pulsemixer \
        pavucontrol

    # pacman -S pipewire \
        pipewire-alsa \
        pipewire-pulse \
        pipewire-jack

### Xorg

    # pacman -S xf86-video-intel mesa lib32-mesa intel-media-driver
    # pacman -S xorg-server xorg-apps

### DE

    # pacman -S feh
    # pacman -S picom
    # pacman -S xss-lock
    # pacman -S lxappearance-gtk3
    # pacman -S gtk3
    # pacman -S imwheel
    # pacman -S clipmenu
    # pacman -S autocutsel
    # pacman -S xsetroot
    # pacman -S dunst
    # pacman -S slcok
    # pacman -S ranger

### Fonts
    
    # pacman -S nerdfonts \
        terminus-font \
        profont-otb \
        ttf-dejavu \
        ttf-croscore \
        ttf-droid \
        gnu-free-fonts \
        ttf-liberation \
        noto-fonts \
        ttf-roboto \
        ttf-anonymous-pro \
        otf-fantasque-sans-mono \
        ttf-fira-mono \
        ttf-fira-code \
        ttf-hack \
        otf-hermit \
        ttf-inconsolata \
        ttf-jetbrains-mono \
        ttf-ubuntu-font-family

### Repositories:

https://github.com/33r01b/dwm - window manager

    $ git clone git@github.com:33r01b/dwm.git ~/.local/src/dwm
    $ cd ~/.local/src/dwm
    # make install clean

https://github.com/33r01b/st - terminal

st requires scroll

    $ git clone git@github.com:33r01b/scroll.git ~/.local/src/scroll
    $ cd ~/.local/src/scroll
    # make install clean

install st 

    $ git clone git@github.com:33r01b/st.git ~/.local/src/st
    $ cd ~/.local/src/st
    # make install clean

https://github.com/33r01b/dmenu - dynamic menu

    $ git clone git@github.com:33r01b/dmenu ~/.local/src/dmenu
    $ cd ~/.local/src/dmenu
    # make install clean

https://github.com/cdown/clipmenu - clipboard manager

    $ git clone https://github.com/cdown/clipmenu ~/.local/src/clipmenu
    $ cd ~/.local/src/clipmenu
    # make install

### Applets (deprecated):

    # pacman -S network-manager-applet 
    # pacman -S blueman
    # pacman -S volumeicon

## Usage

Bluetooth
    
    $ bluetoothctl

Network
    
    $ wifi

or
    
    $ nmcli

or
    
    $ nm-connection-editor
