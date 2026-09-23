#!/bin/bash
# make.sh <lang>: frame raw/<lang>/*.png into ../../assets/screens/<lang>/<name>@2x.png.
# The sharer phone (Pixel 7a) ignores demo mode for its signal and battery icons, so the hotspot
# shot takes its status-bar strip from bar.png: a demo-mode bar (9:41, LTE, Wi-Fi, full battery)
# captured once on the client. The clock and icons carry no language, so one strip serves all sets.
set -euo pipefail
[ $# -eq 1 ] || { echo "usage: make.sh <lang>" >&2; exit 2; }
S=$(dirname "$0"); lang=$1; raw=$S/raw/$lang; out=$S/../../assets/screens/$lang; BAR=130
mkdir -p "$out"
tmp=$(mktemp --suffix=.png); trap 'rm -f "$tmp"' EXIT
for f in hotspot nearby heatmap connected chat-list chat-thread challenges; do
  src=$raw/$f.png
  if [ "$f" = hotspot ]; then
    convert "$src" "$S/bar.png" -geometry +0+0 -compose Over -composite "$tmp"
    src=$tmp
  fi
  "$S/frame.sh" "$src" "$out/$f@2x.png" >/dev/null
done
echo "$lang: $(ls "$out" | wc -l) images in $out"
