#!/bin/sh

yaourt -S --noconfirm freetype2-infinality xorg-xfontsel terminus-font ttf-ms-fonts \
    fontconfig-infinality

# lib32-freetype2-infinality

sudo /etc/fonts/infinality/infctl.sh setstyle osx
sudo sh -c "cd /usr/share/fonts/local; mkfontdir"
