# Brand assets

Social profile images and banners. Each `.html` is the source; render it with headless Chrome, e.g.

    google-chrome --headless=new --hide-scrollbars --window-size=1500,500 --screenshot=x-banner-v2.png x-banner-v2.html

- `x-banner-v2.*` – X header, 1500x500 (`@2x` is 3000x1000).
- `x-profile.*` – X avatar, green background.
- `ig-brasil-*` – Instagram @bumpapp.brasil avatar candidates, dark background with edge ring.
- `play-icon-512.png` – Google Play app icon, 512x512, as uploaded to the listing (Play applies the rounded mask). The source is the adaptive launcher icon in the app repo (`ic_launcher_foreground.xml` + `ic_launcher_background.xml`).
- `play-dev-header.*` – Google Play developer page header, 4096x2304 (16:9). Play shows only the middle band of it (about 4:1 on desktop), so it carries just the logo lockup on the pattern, no text. Rendered at 4x device scale from a 1024x576 page.
- `play-feature.*` – Google Play feature graphic, 1024x500, one PNG per listing language (`-en`, `-pt`, `-es`). One HTML source; pass `?lang=pt` or `?lang=es` when rendering.
- `*-preview.png` – how the asset looks in place on dark/light UI at real display sizes.
