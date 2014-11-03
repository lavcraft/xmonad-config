#!/bin/bash

cd $(dirname $BASH_SOURCE)

mkdir -p ~/.xmonad

mv -v ~/.xmonad/xmonad.hs ~/.xmonad/xmonad.old.hs 2> /dev/null

ln -sf `pwd`/home/.xmonad/xmonad.hs ~/.xmonad/xmonad.hs
ln -sf `pwd`/home/.xmonad/getvolume.sh ~/.xmonad/getvolume.sh
ln -sf `pwd`/home/.xmonad/xmobar.hs ~/.xmonad/xmobar.hs
ln -sf `pwd`/home/.xinitrc ~/.xinitrc
ln -sf `pwd`/home/.gitconfig ~/.gitconfig

