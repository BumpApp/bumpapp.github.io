#!/bin/bash
# hot.sh <serial> <lang> <outdir> : capture the Share screen with the hotspot running, then stop it
set -euo pipefail
[ $# -eq 3 ] || { echo "usage: hot.sh <serial> <lang> <outdir>" >&2; exit 2; }
: "${ACCEPT_RE:?set ACCEPT_RE}"
S=$(dirname "$0"); d=$1; lang=$2; out=$3; pkg=xyz.bumpapp.dev.debug
START_RE="Tap to Start Sharing|Toque para Iniciar Compartilhamento|Toca para empezar a compartir"
mkdir -p "$out"
A() { adb -s "$d" "$@"; }
demo() { A shell am broadcast -a com.android.systemui.demo -e command "$@" >/dev/null; }
A shell cmd locale set-app-locales $pkg --user 0 --locales $lang
A shell am force-stop $pkg
A shell monkey -p $pkg -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1; sleep 7
demo enter; demo clock -e hhmm 0941; demo battery -e level 100 -e plugged false
demo network -e wifi show -e level 4 -e fully true; demo network -e mobile show -e datatype lte -e level 4
demo notifications -e visible false; demo status -e volume hide -e bluetooth hide -e mute hide
read w h < <(A shell wm size | sed 's/.*: //; s/x/ /')
y=$(A exec-out uiautomator dump /dev/tty 2>/dev/null | python3 -c "
import sys,re; x=sys.stdin.read()
for m in re.finditer(r'<node[^>]*text=\"(Profile|Perfil)\"[^>]*bounds=\"\[(\d+),(\d+)\]\[(\d+),(\d+)\]\"',x):
    print((int(m.group(3))+int(m.group(5)))//2); break")
[ -n "$y" ] || { echo "tab bar not found; is the device signed in and on the main screen?" >&2; exit 1; }
$S/ui.sh "$d" tap "^OK$" >/dev/null 2>&1 || true
A shell input tap $((w*3/8)) $y; sleep 3
$S/ui.sh "$d" tap "$ACCEPT_RE" >/dev/null 2>&1 && sleep 4 || true
c=$($S/ui.sh "$d" tap "$START_RE" | grep -o '[0-9]* [0-9]*$') || { echo "start-sharing button not found; not capturing" >&2; exit 1; }
echo "start tapped at '$c'"; sleep 12
A exec-out screencap -p > "$out/07-share-hotspot-on.png"; echo "  07-share-hotspot-on"
$S/ui.sh "$d" texts | grep -iE "stop|parar|detener|dejar" | head -2 || echo "warning: no stop label visible; hotspot may not have started" >&2
A shell input tap $c; sleep 3
