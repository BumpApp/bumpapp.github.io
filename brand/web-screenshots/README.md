# Website screenshots

App screens used on the site, one set per language, served from `/assets/screens/<lang>/`.
Captured 2026-09-23 from the dev debug build (`xyz.bumpapp.dev.debug`) with the status bar in
system UI demo mode (9:41, full battery, LTE), then framed at the site's 388x768 @2x size.

| File | Screen | Captured on |
|---|---|---|
| `hotspot` | Share Internet with the hotspot running and one client connected | sharer |
| `nearby` | Find tab with the sharer listed | client |
| `heatmap` | Coverage map | client |
| `connected` | Session connected via Wi-Fi Direct | client |
| `chat-list` | BumpChat conversation list | client |
| `chat-thread` | One conversation | client |
| `challenges` | Challenges page | client |

Raw 1080x2400 captures are in `raw/<lang>/`. Devices: sharer Pixel 7a (`39111JEHN16292`), on the
office Wi-Fi; client Pixel 7 (`ONROHI45DFM5FY`), same account as the sharer (sibling phone), with
no saved Wi-Fi networks. The conversation is with a third phone signed in as another test user.

## Re-capturing

Needs `adb`, `python3`, ImageMagick (`convert`), and two signed-in phones with runtime
permissions granted. Then, per language:

```sh
./web.sh <sharer-serial> <client-serial> pt raw/pt   # capture the seven raw screens
./make.sh pt                                        # frame them into assets/screens/pt/
```

`web.sh` reuses `../play-screenshots/ui.sh`. It switches the app locale per phone
(`cmd locale set-app-locales`), puts both status bars in demo mode (the client with no LTE and no
Wi-Fi icon: it has no connection of its own, which is why it uses Bump), starts the sharer's
hotspot, and on the client: captures the Find tab, requests a connection, waits for the Wi-Fi Direct
stage (tapping the app's "Hurry Up" button when Wi-Fi scanning is throttled), runs the app's Speed
Test and keeps the frame with the highest meter reading, captures the sharer's screen, then, still
connected so the phone has Internet, captures the heatmap, chat and challenges. Button labels are
regexes at the top of the script; add to them when a language fails, and the script prints the
screen's texts when it can't find one.

Two things to know:

- **The client must not be joined to any Wi-Fi network**, or the app refuses to connect. `web.sh`
  forgets every saved network on the client and does not restore them. The sharer keeps its Wi-Fi.
- **The Pixel 7a ignores demo mode** for its signal and battery icons (the clock does apply), so
  `make.sh` pastes `bar.png`, a demo-mode status bar captured once on the client, onto the hotspot shot.
