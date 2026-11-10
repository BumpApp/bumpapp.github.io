#!/bin/bash
# simple.sh <serial> <lang>: capture the Simple mode Share screen with sharing on, on one signed-in phone
# that has Simple mode enabled, and frame it into ../../assets/screens/<lang>/simple-share@2x.png.
# The raw capture lands in raw/<lang>/. Written for the Galaxy A17 (1080x2340): taps are coordinates
# because they don't change with language, and the status and navigation bars are cropped off
# (Samsung ignores demo mode, so there is no fake 9:41 bar to show).
set -euo pipefail
[ $# -eq 2 ] || { echo "usage: simple.sh <serial> <lang>" >&2; exit 2; }
S=$(dirname "$0"); d=$1; lang=$2; pkg=xyz.bumpapp.dev.debug; raw=$S/raw/$lang; out=$S/../../assets/screens/$lang
TOP=100; BOTTOM=2205   # screen area between the status bar and the navigation bar
mkdir -p "$raw" "$out"
A() { adb -s "$d" "$@"; }
A shell cmd locale set-app-locales $pkg --user 0 --locales "$lang"
A shell am force-stop $pkg                                 # also stops a hotspot left running
A shell monkey -p $pkg -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1; sleep 9
A shell input tap 413 2131; sleep 4                        # Share tab
A shell input tap 540 820; sleep 8                         # power button: start sharing
A exec-out screencap -p > "$raw/simple-share.png"
A shell input tap 540 820; sleep 3                         # stop sharing
tmp=$(mktemp --suffix=.png); trap 'rm -f "$tmp"' EXIT
convert "$raw/simple-share.png" -crop 1080x$((BOTTOM-TOP))+0+$TOP +repage "$tmp"
"$S/frame.sh" "$tmp" "$out/simple-share@2x.png" $(( (BOTTOM-TOP) * 331 / 1080 ))
