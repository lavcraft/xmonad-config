#!/bin/sh
vol=`amixer sget Master | grep -o -m 1 '[[:digit:]]*%' | tr -d '%'`
level=`expr $vol / 10`
bars=$level

case $bars in
  0)  bar='[----------]' ;;
  1)  bar='[|---------]' ;;
  2)  bar='[||--------]' ;;
  3)  bar='[|||-------]' ;;
  4)  bar='[||||------]' ;;
  5)  bar='[|||||-----]' ;;
  6)  bar='[||||||----]' ;;
  7)  bar='[|||||||---]' ;;
  8)  bar='[||||||||--]' ;;
  9)  bar='[|||||||||-]' ;;
  10) bar='[||||||||||]' ;;
  *)  bar='[----!!----]' ;;
esac

echo $bar

exit 0
