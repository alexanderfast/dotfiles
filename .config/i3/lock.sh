#!bash
if command -v "scrot" && command -v "magick"; then
  img=/tmp/i3lock.png
  scrot -o $img
  magick $img -blur 0x8 $img
  i3lock -i $img
else
  i3lock 0000CC & sleep 2 && xset dpms force off
fi

# sleep 2 && xset dpms force off
