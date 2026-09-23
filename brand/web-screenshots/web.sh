#!/bin/bash
# web.sh <sharer-serial> <client-serial> <lang> <outdir>
# Captures the website screenshot set in one language: the sharer phone runs the hotspot, the client
# phone finds it, connects, and is where nearby/heatmap/connected/chat/challenges are captured.
# Reuses ../play-screenshots/ui.sh. Raw 1080x2400 PNGs land in <outdir>; frame.sh makes the web sizes.
set -euo pipefail
[ $# -eq 4 ] || { echo "usage: web.sh <sharer-serial> <client-serial> <lang> <outdir>" >&2; exit 2; }
S=$(dirname "$0"); UI=$S/../play-screenshots/ui.sh
sh=$1; cl=$2; lang=$3; out=$4; pkg=xyz.bumpapp.dev.debug
mkdir -p "$out"
# Button labels per language. Add to these when a language fails; ui.sh matches text or content-desc by regex.
: "${ACCEPT_RE:=^(Accept|Aceitar|Aceptar|Yes|Sim|Sí)}"
: "${START_RE:=Tap to Start Sharing|Toque para Iniciar Compartilhamento|Toca para empezar a compartir}"
: "${STOP_RE:=Tap to Stop Sharing|Toque para Parar|Toca para dejar|Toca para detener}"
: "${REQUEST_RE:=^(Request|Connect|Solicitar|Conectar)$}"
: "${APPROVE_RE:=^(Approve|Accept|Allow|Aprovar|Aceitar|Permitir|Aprobar|Aceptar)}"
: "${DISCONNECT_RE:=^(Disconnect|Desconectar)$}"
: "${HEATMAP_RE:=Open Heatmap|Abrir Mapa de Calor|Abrir mapa de calor}"
: "${CHALLENGES_RE:=^(Challenges|Desafios|Desafíos)$}"
: "${CHAT_ROW_RE:=FastWeasel6771|DeliriousPuffin2853}"
: "${SPEEDTEST_RE:=^(Speed Test|Teste de Velocidade|Teste de velocidade|Prueba de velocidad|Test de velocidad)$}"

A() { adb -s "$1" "${@:2}"; }
demo() { A "$1" shell am broadcast -a com.android.systemui.demo -e command "${@:2}" >/dev/null; }
prep() { # <serial> <mobile:show|hide> <wifi:show|hide>: set the app locale, relaunch, put the status bar in demo mode
  A "$1" shell settings put global sysui_demo_allowed 1; A "$1" shell settings put global sysui_tuner_demo_on 1
  A "$1" shell cmd locale set-app-locales $pkg --user 0 --locales "$lang"
  A "$1" shell am force-stop $pkg
  A "$1" shell monkey -p $pkg -c android.intent.category.LAUNCHER 1 >/dev/null 2>&1; sleep 7
  demo "$1" enter; demo "$1" clock -e hhmm 0941; demo "$1" battery -e level 100 -e plugged false
  demo "$1" network -e wifi "$3" -e level 4 -e fully true; demo "$1" network -e mobile "$2" -e datatype lte -e level 4
  demo "$1" notifications -e visible false; demo "$1" status -e volume hide -e bluetooth hide -e mute hide
  $UI "$1" tap "^OK$" >/dev/null 2>&1 && sleep 1 || true
}
taby() { A "$1" exec-out uiautomator dump /dev/tty 2>/dev/null | python3 -c "
import sys,re; x=sys.stdin.read()
for m in re.finditer(r'<node[^>]*text=\"(Profile|Perfil)\"[^>]*bounds=\"\[(\d+),(\d+)\]\[(\d+),(\d+)\]\"',x):
    print((int(m.group(3))+int(m.group(5)))//2); break"; }
tab() { # <serial> <index 0-3> [sleep]
  local y; y=$(taby "$1"); [ -n "$y" ] || { echo "tab bar not found on $1" >&2; $UI "$1" texts >&2; exit 1; }
  A "$1" shell input tap $(( 1080 * (2*$2+1) / 8 )) "$y"; sleep "${3:-2}"
}
shot() { A "$1" exec-out screencap -p > "$out/$2.png"; echo "  $2 (from $1)"; }
need() { $UI "$1" tap "$2" >/dev/null || { echo "'$2' not found on $1; texts:" >&2; $UI "$1" texts | tr '\n' ' ' >&2; echo >&2; exit 1; }; }

echo "== $lang: prep"; prep "$sh" show show; prep "$cl" hide hide   # the client has no LTE: that is why it uses Bump

echo "== sharer: start hotspot"
tab "$sh" 1 3
$UI "$sh" tap "$ACCEPT_RE" >/dev/null 2>&1 && sleep 4 || true
need "$sh" "$START_RE"; sleep 12
demo "$sh" network -e wifi show -e level 4 -e fully true; demo "$sh" network -e mobile show -e datatype lte -e level 4
demo "$sh" battery -e level 100 -e plugged false; demo "$sh" status -e volume hide -e bluetooth hide -e mute hide

echo "== client: nearby"
tab "$cl" 0 3
$UI "$cl" tap "^(Scan for Network|Procurar Rede|Buscar red)" >/dev/null 2>&1 && sleep 8 || true
shot "$cl" nearby

echo "== client: connect"
# The client must not be joined to any real Wi-Fi network (the app refuses to connect while it is), but
# Wi-Fi stays on so it can join the sharer's Wi-Fi Direct group. Forget every saved network on the client;
# they are not restored. The sharer keeps its own Wi-Fi.
for nid in $(A "$cl" shell cmd wifi list-networks | tr -d '\r' | awk 'NR>1 && $1 ~ /^[0-9]+$/ {print $1}' | sort -u); do
  A "$cl" shell cmd wifi forget-network "$nid" >/dev/null && echo "  client forgot Wi-Fi network id $nid"
done
sleep 5
need "$cl" "$REQUEST_RE"; sleep 8
$UI "$sh" tap "$APPROVE_RE" >/dev/null 2>&1 && echo "  sharer approved" || echo "  no approval prompt on sharer (may auto-approve)"
# Wait for the Wi-Fi Direct stage: the header goes from "Connecting to" to "Connected to". The app shows
# a "Hurry Up" button when Wi-Fi scanning is throttled (it is, after repeated runs); tap it whenever it shows.
for i in $(seq 1 24); do
  $UI "$cl" texts | grep -qE "^\"(Connected to|Conectado a|Conectado com|Conectado à)" && break
  $UI "$cl" tap "Hurry Up|Apressar|Acelerar|Apurar|Apúrate|Apresse|Date prisa|Rápido" >/dev/null 2>&1 && echo "  tapped Hurry Up" || true
  sleep 5
done
$UI "$cl" texts | grep -qE "^\"(Connected to|Conectado a|Conectado com|Conectado à)" && echo "  session up after ~$((i*5))s" || echo "  warning: still connecting after 120s" >&2
demo "$cl" network -e wifi show -e level 4 -e fully true   # now on the sharer's Wi-Fi Direct group
sleep 3

echo "== client: speed test + connected"
# The meter only moves while the speed test runs (a few seconds), so capture a burst and keep the highest reading.
A "$cl" shell input swipe 540 1900 540 700 400; sleep 1
need "$cl" "$SPEEDTEST_RE"
A "$cl" shell input swipe 540 700 540 1900 400
best=0; bestf=""
for k in 1 2 3 4 5 6; do
  A "$cl" exec-out screencap -p > "$out/.st$k.png"
  v=$($UI "$cl" texts | grep -m1 -E '^"[0-9]+([.,][0-9])?"$' | tr -d '"' | tr ',' '.')
  if awk -v a="${v:-0}" -v b="$best" 'BEGIN{exit !(a>b)}'; then best=$v; bestf="$out/.st$k.png"; fi
done
[ -n "$bestf" ] && mv "$bestf" "$out/connected.png" || cp "$out/.st1.png" "$out/connected.png"
rm -f "$out"/.st*.png; echo "  connected (from $cl, meter $best Mbps)"
shot "$sh" hotspot

echo "== client: heatmap (needs Internet, which the session provides)"
$UI "$cl" tap "^(Back|Voltar|Atrás|Volver)$" >/dev/null 2>&1 || A "$cl" shell input keyevent BACK   # session screen -> Nearby list
sleep 3
need "$cl" "$HEATMAP_RE"; sleep 12; shot "$cl" heatmap
A "$cl" shell input keyevent BACK; sleep 2

echo "== client: chat"
tab "$cl" 2 3; shot "$cl" chat-list
need "$cl" "$CHAT_ROW_RE"; sleep 3; shot "$cl" chat-thread
A "$cl" shell input keyevent BACK; sleep 2

echo "== client: challenges"
tab "$cl" 3 3
A "$cl" shell input swipe 540 1800 540 600 400; sleep 2
need "$cl" "$CHALLENGES_RE"; sleep 4; shot "$cl" challenges
A "$cl" shell input keyevent BACK; sleep 1

echo "== stop"
tab "$cl" 0 1
$UI "$sh" tap "$STOP_RE" >/dev/null 2>&1 && echo "  hotspot stopped" || echo "  warning: stop label not found on sharer" >&2
demo "$sh" exit; demo "$cl" exit
echo "== $lang done: $out"
