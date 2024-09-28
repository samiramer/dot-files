#!/bin/sh
# Add a lock icon and text to the center of an image
magick convert wall.png -font Noto-Sans-Regular \
    -blur 0x25 \
    -pointsize 26 -fill white -gravity center \
    -annotate +0+240 "Type Password to Unlock" lock.png \
    -gravity center -composite blurred-wall.png
