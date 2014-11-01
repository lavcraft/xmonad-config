#!/bin/bash

mkdir -p ~/.xmonad

mv -v ~/.xmonad/xmonad.hs ~/.xmonad/xmonad.old.hs 2> /dev/null

ln -sf `pwd`/xmonad.hs ~/.xmonad/xmonad.hs
