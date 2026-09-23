#!/bin/bash
# ui.sh <serial> tap "<text or content-desc regex>"   |  ui.sh <serial> texts  |  ui.sh <serial> shot <file>
d=$1; cmd=$2; shift 2
dump() { adb -s $d exec-out uiautomator dump /dev/tty 2>/dev/null; }
case $cmd in
  tap)
    c=$(dump | python3 -c "
import sys,re
x=sys.stdin.read(); pat=sys.argv[1]
for m in re.finditer(r'<node[^>]*?>',x):
    n=m.group(0)
    t=re.search(r'text=\"([^\"]*)\"',n); cd=re.search(r'content-desc=\"([^\"]*)\"',n); b=re.search(r'bounds=\"\[(\d+),(\d+)\]\[(\d+),(\d+)\]\"',n)
    if b and ((t and re.search(pat,t.group(1))) or (cd and re.search(pat,cd.group(1)))):
        a,bb,c,dd=map(int,b.groups()); print((a+c)//2,(bb+dd)//2); break
" "$1")
    if [ -n "$c" ]; then adb -s $d shell input tap $c; echo "tapped '$1' at $c"; else echo "NOT FOUND '$1'"; exit 1; fi ;;
  texts) dump | grep -o 'text="[^"]\+"' | sed 's/text=//' ;;
  shot) adb -s $d exec-out screencap -p > "$1"; echo "saved $1" ;;
esac
