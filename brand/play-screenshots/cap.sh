#!/bin/bash
# cap.sh <serial> <lang> <outdir> <mobile:show|hide>   env ACCEPT_RE, SETTINGS_RE required
set -euo pipefail
[ $# -ge 3 ] || { echo "usage: cap.sh <serial> <lang> <outdir> [show|hide]" >&2; exit 2; }
: "${ACCEPT_RE:?set ACCEPT_RE}" "${SETTINGS_RE:?set SETTINGS_RE}"
S=$(dirname "$0"); d=$1; lang=$2; out=$3; mobile=${4:-show}; pkg=xyz.bumpapp.dev.debug
case $mobile in show|hide) ;; *) echo "mobile must be show or hide, got '$mobile'" >&2; exit 2;; esac
mkdir -p "$out"
A() { adb -s "$d" "$@"; }
demo() { A shell am broadcast -a com.android.systemui.demo -e command "$@" >/dev/null; }
A shell cmd locale set-app-locales $pkg --user 0 --locales $lang
A shell am force-stop $pkg
A shell run-as $pkg sed -i /BANDWIDTH_SHARING_OPT_IN/d shared_prefs/${pkg}_preferences.xml 2>/dev/null || true
A shell monkey -p $pkg -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1; sleep 7
demo enter; demo clock -e hhmm 0941; demo battery -e level 100 -e plugged false
demo network -e wifi show -e level 4 -e fully true
if [ "$mobile" = show ]; then demo network -e mobile show -e datatype lte -e level 4; else demo network -e mobile hide; fi
demo notifications -e visible false; demo status -e volume hide -e bluetooth hide -e mute hide
read w h < <(A shell wm size | sed 's/.*: //; s/x/ /')
y=$(A exec-out uiautomator dump /dev/tty 2>/dev/null | python3 -c "
import sys,re; x=sys.stdin.read()
for m in re.finditer(r'<node[^>]*text=\"(Profile|Perfil)\"[^>]*bounds=\"\[(\d+),(\d+)\]\[(\d+),(\d+)\]\"',x):
    print((int(m.group(3))+int(m.group(5)))//2); break")
[ -n "$y" ] || { echo "tab bar not found; is the device signed in and on the main screen?" >&2; exit 1; }
echo "device ${w}x${h}, tab y=$y"
tab() { A shell input tap $(( w * (2*$1+1) / 8 )) $y; sleep ${2:-2}; }
shot() { A exec-out screencap -p > "$out/$1.png"; echo "  $1"; }
$S/ui.sh "$d" tap "^OK$" >/dev/null 2>&1 && sleep 1 || true
tab 0 3; shot 01-nearby
tab 1 3; shot 02-sharing-optin
$S/ui.sh "$d" tap "$ACCEPT_RE" >/dev/null && sleep 5 || true; shot 03-share
tab 2 3; shot 04-chat
tab 3 3; shot 05-profile
A shell input swipe $((w/2)) $((h*3/4)) $((w/2)) $((h/4)) 400; sleep 2
$S/ui.sh "$d" tap "$SETTINGS_RE" >/dev/null || { echo "settings row not found" >&2; exit 1; }; sleep 3; shot 06-settings
A shell input keyevent BACK
