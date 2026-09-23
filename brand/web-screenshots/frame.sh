#!/bin/bash
# frame.sh <raw.png> <out.png>: put a 1080x2400 screenshot in a dark rounded phone frame at the site's
# 388x768 @2x size (screen 331x736 with a 28px bezel), matching the existing phone-*@2x.png images.
set -euo pipefail
[ $# -eq 2 ] || { echo "usage: frame.sh <raw.png> <out.png>" >&2; exit 2; }
in=$1; out=$2; W=388; H=768; sw=331; shh=736; bx=$(( (W-sw)/2 )); by=$(( (H-shh)/2 ))
convert "$in" -resize ${sw}x${shh}! \
  \( +clone -alpha extract -draw "fill black polygon 0,0 0,24 24,0 fill white circle 24,24 24,0" \
     \( +clone -flip \) -compose Multiply -composite \( +clone -flop \) -compose Multiply -composite \) \
  -alpha off -compose CopyOpacity -composite miff:- \
| convert -size ${W}x${H} xc:none -fill "#111827" -draw "roundrectangle 0,0 $((W-1)),$((H-1)) 44,44" \
  -fill "#1F2937" -draw "roundrectangle 2,2 $((W-3)),$((H-3)) 42,42" \
  -fill "#0B1220" -draw "roundrectangle 6,6 $((W-7)),$((H-7)) 40,40" \
  miff:- -geometry +${bx}+${by} -compose Over -composite "$out"
echo "framed $out"
