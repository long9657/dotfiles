#!/bin/sh

if xrandr | grep "HDMI-0 connected"; then
    # CÓ màn rời: Dùng màn rời làm primary, TẮT màn laptop
    xrandr --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off \
           --output HDMI-0 --primary --mode 3840x2160 --pos 0x0 --rotate normal \
           --output DP-4 --off
else
    # KHÔNG có màn rời: Bật màn laptop (DP-4), TẮT màn HDMI
    xrandr --output HDMI-0 --off \
           --output DP-4 --primary --mode 1920x1080 --rate 165.01 --pos 0x0 --rotate normal
fi
