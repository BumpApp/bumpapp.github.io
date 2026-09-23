# Google Play screenshots

Captured from the dev debug build (`app:assembleDevDebug` on `main`) with the status bar in
system UI demo mode (9:41, full battery). One folder per Play form factor, one subfolder per
listing language. Files are numbered in upload order.

| Folder | Device | Size | Play form factor |
|---|---|---|---|
| `phone/` | Pixel 7a / Pixel 7 | 1080x2400 | Phone |
| `tablet7/` | Emulator, 240 dpi | 1080x1920 | 7-inch tablet |
| `tablet10/` | Emulator, 240 dpi | 1440x2560 | 10-inch tablet |

| File | Screen |
|---|---|
| `01-nearby` | Find tab: nearby users, balance, scan button |
| `02-sharing-optin` | "Are you interested in sharing Internet?" prompt |
| `03-share` | Share Internet, hotspot off |
| `04-chat` | BumpChat |
| `05-profile` | Profile: credits, rewards, progress |
| `06-settings` | App settings |
| `07-share-hotspot-on` | Share Internet with the hotspot running (phone only) |

Play accepts up to 8 per form factor and language; the tablet sets have 6, the phone sets 7.

## Re-capturing

`cap.sh <serial> <lang> <outdir> <show|hide>` captures 01–06 on a signed-in device (`hide`
hides the mobile signal, used for tablets). `hot.sh <serial> <lang> <outdir>` starts the hotspot
and captures 07. Both expect `ACCEPT_RE` and `SETTINGS_RE` in the environment with the
translated button labels (see the top of each script) and `ui.sh` alongside. Languages are
switched per app with `cmd locale set-app-locales`, which restarts the app; nothing on the device
changes language. Tablet AVDs: Pixel Tablet profile, API 35 Play image, `hw.lcd` overridden to the
sizes above, 6 GB RAM (2 GB is not enough to get through Google sign-in).
