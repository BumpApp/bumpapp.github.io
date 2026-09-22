# Brand assets

Social profile images and banners. Each `.html` is the source; render it with headless Chrome, e.g.

    google-chrome --headless=new --hide-scrollbars --window-size=1500,500 --screenshot=x-banner-v2.png x-banner-v2.html

- `x-banner-v2.*` – X header, 1500x500 (`@2x` is 3000x1000). Replaces `x-banner.*`.
- `x-profile.*` – X avatar, green background.
- `ig-brasil-*` – Instagram @bumpapp.brasil avatar candidates, dark background with edge ring.
- `*-preview.png` – how the asset looks in place on dark/light UI at real display sizes.
