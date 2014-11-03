#xset -dpms; xset s off
(sleep 10s && xset b off) &
(sleep 10s && xset r rate 250 45) &
xset -dpms; xset s off 
setxkbmap -layout "us,ru"
setxkbmap -option "grp:caps_toggle,grp_led:scroll"
xset +fp /usr/share/fonts/local
xsetroot -cursor_name left_ptr &
numlockx &
xrdb -merge ~/.Xresources
xxkb &

export JAVA_HOME=/usr/lib/jvm/java-default-runtime
export PATH=~/bin:$PATH

feh --bg-center /usr/share/backgrounds/gnome/Bokeh_Tails.jpg
kbdd &

export _volume_pipe=/tmp/.volume-pipe
[[ -S $_volume_pipe ]] || mkfifo $_volume_pipe

#exec startxfce4
exec dbus-launch xmonad

