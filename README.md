# bumpapp.xyz

Static marketing site for Bump, built by GitHub Pages with Jekyll.

## Layout

- `_layouts/default.html` – the one `<head>` (SEO tags, hreflang, Tailwind, analytics), nav and footer for every page.
- `_layouts/article.html` – prose wrapper for Markdown articles.
- `_includes/nav.html`, `_includes/footer.html` – built from `_data/i18n.yml` using the page's `lang`.
- `index.html`, `es/`, `pt/` – landing pages. `privacy-policy/`, `terms-of-service/`, `delete/` – legal pages, each in three languages.
- `_articles/` – Markdown articles, published at `/<path>/` (e.g. `_articles/pt/precos.md` → `/pt/precos/`).
- `brand/` – social images and their sources; not published.
- `_tailwind/` – Tailwind config and input CSS. `npm run build` compiles them to `assets/tailwind.css`, which is committed; CI fails if it is stale.

## Front matter

Every page declares:

```yaml
---
lang: pt-BR                     # sets <html lang>, og:locale and which nav/footer strings to use
title: "Quanto custa 1 GB"      # rendered as "<title> | Bump"
description: "One sentence for search results and link previews."
translations:                   # optional; generates hreflang links and the language switcher
  en: /prices/
  pt-BR: /pt/precos/
  es-CO: /es/precios/
---
```

`jekyll-seo-tag` writes the title, description, canonical, Open Graph, Twitter card and JSON-LD from that. `jekyll-sitemap` writes `sitemap.xml`. Neither is hand-edited.

## Adding an article

Create `_articles/<lang>/<slug>.md` with the front matter above plus an optional `date:`. Write Markdown. Open a PR; CI builds the site, validates the HTML and checks every internal link.

## Local build

```sh
bundle install
bundle exec jekyll serve
```

Uses the `github-pages` gem so the local build matches what GitHub Pages runs.
