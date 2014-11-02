#!/bin/bash

mkdir -p ~/.xmonad

mv -v ~/.xmonad/xmonad.hs ~/.xmonad/xmonad.old.hs 2> /dev/null

ln -sf `pwd`/xmonad.hs ~/.xmonad/xmonad.hs

ln -sf `pwd`/getvolume.sh ~/.xmonad/getvolume.sh
ln -sf `pwd`/xmobar.hs ~/.xmonad/xmobar.hs
ln -sf `pwd`/.xinitrc ~/.xinitrc

