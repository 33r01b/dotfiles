#!/bin/bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

dm -d

# dpi
dpicmd

# wallpaper
feh --bg-scale ~/pictures/wall-green.jpg

# locale toogle
setxkbmap -layout us,ru -option "grp:caps_toggle,grp_led:caps"

# touchpad speed
xinput --set-prop 'Elan Touchpad' 'libinput Accel Speed' 0.5
xinput --set-prop 'Apple Inc. Magic Trackpad 2' 'libinput Accel Speed' 0.5

# set keyboard speed and disable beep
xset r rate 170 30 -b

# monitor color profile (see current display option)
dispwin -d1 ~/.colors/27f4k.icm

# mouse wheel
imwheel --kill &

## sync clipboard buffers
autocutsel &
#autocutsel -s PRIMARY -fork &

## clipboard
export CM_MAX_CLIPS=0
export CM_HISTLENGTH=12
clipmenud &

# animations
picom --no-fading-openclose --config $HOME/.config/picom/config &

## auto lock the screen
xss-lock --transfer-sleep-lock -- slock &

## status bar
bash $HOME/.local/bin/dwm-status &

# fixing misbehaving Java applications
export _JAVA_AWT_WM_NONREPARENTING=1
# export AWT_TOOLKIT=MToolkit 
# wmname LG3D

# if jetbrains apps has abysmally slow UI
# use custom runtuime, like https://github.com/JetBrains/JetBrainsRuntime/releases/tag/jb11_0_12-b11_0_12b1649.1

exec dwm
