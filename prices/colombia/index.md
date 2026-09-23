---
layout: article
lang: en
title: "What 1 GB of mobile data costs in Colombia in 2026: Claro, Tigo, Movistar vs Bump"
description: "Price per GB of Claro, Tigo and Movistar prepaid packs, with the date checked and a link to each carrier's own page, compared with what you pay on Bump."
date: 2026-09-23
translations:
  en: /prices/colombia/
  es-CO: /es/precios/
---

{% assign d = site.data.precios_co %}
{% assign bump_gb = d.bump.credits_per_mb | times: 1024.0 | divided_by: d.bump.credits_per_cop %}
{% assign bump_wifi_gb = d.bump.credits_per_mb_wifi | times: 1024.0 | divided_by: d.bump.credits_per_cop %}

This page answers one question: what 1 GB of prepaid mobile data costs in Colombia today, and what the same GB costs on [Bump](/). Every price below was read from the carrier's own page on **{{ d.checked | date: "%Y-%m-%d" }}**, with the link beside it. Prices are in Colombian pesos (COP).

## What it costs on Bump

On Bump you pay only for what you use, from a balance bought by PSE or card, from ${% include cop.html v=d.bump.min_purchase_cop %}. The price is per GB, and each sharer sets their own under a ceiling.

- **Maximum price: ${% include cop.html v=bump_gb %} per GB.** That is the ceiling a sharer can charge.
- **When the sharer is relaying a Wi-Fi network**, the price drops to **${% include cop.html v=bump_wifi_gb %} per GB**.
- **{{ d.bump.free_mb }} MB free** when you create an account. That bonus lasts 90 days.
- **The balance you buy never expires.** Buy $10,000 today and use it a year from now.

Compare that with the two kinds of pack the carriers sell. They are different situations, so they get different tables.

## Small packs: when your plan ran out and you need a little

This is where prepaid gets expensive. When the data runs out mid-month, the carrier sells 150 MB to 2 GB packs that last one to seven days, and the price per GB jumps.

<table>
<thead><tr><th>Carrier</th><th>Pack</th><th>Price</th><th>Valid for</th><th>$/GB</th><th>Source</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>maximum price</td><td>by use</td><td>never expires</td><td><strong>{% include cop.html v=bump_gb %}</strong></td><td>this page</td></tr>
{%- for p in d.packs -%}{%- if p.size == "small" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}</td><td>${% include cop.html v=p.price %}</td><td>{{ p.days }} day{% if p.days > 1 %}s{% endif %}</td><td>{% include cop.html v=gb %}</td><td><a href="{{ p.source }}" rel="nofollow">{{ p.source | remove: "https://" | remove: "www." | split: "/" | first }}</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

Claro's one-day packs cost $18,000 to $20,500 per GB, three times Bump's maximum; its three-day pack, $14,000 per GB. Only from 2 GB bought at once does the carrier become cheaper per GB again. And small packs expire in one, three or seven days.

## Monthly packs: when you buy the whole month

Buying 10 GB or more at once, the carrier's price per GB is lower than Bump's. We don't hide that.

<table>
<thead><tr><th>Carrier</th><th>Pack</th><th>Price</th><th>Valid for</th><th>$/GB</th><th>Source</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>maximum price</td><td>by use</td><td>never expires</td><td><strong>{% include cop.html v=bump_gb %}</strong></td><td>this page</td></tr>
{%- for p in d.packs -%}{%- if p.size == "large" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}</td><td>${% include cop.html v=p.price %}</td><td>{{ p.days }} days</td><td>{% include cop.html v=gb %}</td><td><a href="{{ p.source }}" rel="nofollow">{{ p.source | remove: "https://" | remove: "www." | split: "/" | first }}</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

The math changes when you look at what you actually use. The pack costs the same whether you use all of it or almost none, and whatever is left disappears when the days are up. On the $11,000 Todo incluido WIN (2 GB for 7 days), someone who uses 500 MB paid $22,000 per GB; on Bump those 500 MB cost ${% assign half = bump_gb | times: 500 | divided_by: 1024 %}{% include cop.html v=half %}. The break-even is about 1.8 GB in 7 days against that pack and 5.7 GB in 30 days against the $35,000 WIN. Below that, Bump is cheaper; above it, the pack wins.

## Both cases in one picture

{% include precos-dotplot.html lang="en" data="precios_co" cur="cop" xmax=24000 step=4000 %}

{% include precos-scatter.html lang="en" data="precios_co" cur="cop" ymax=32000 ystep=8000 %}

## Why Bump's price sits where it does

The two charts show a gap between the carriers' own prices: someone buying 39 GB pays $667 per GB; someone buying 150 MB pays $20,480. Bump is designed to fit in that gap.

A person with a big plan they don't use up can share the surplus through the app. Every megabyte that passes through their phone earns points, which convert to cash via Bre-B. Their GB cost them $1,250 or less, so sharing it for up to ${% include cop.html v=bump_gb %} is income from data that would otherwise have expired unused.

A person who just needs a little data right now gets that same GB for at most ${% include cop.html v=bump_gb %} instead of the $14,000 to $20,500 of a one- or three-day pack, and whatever they don't use today is still theirs tomorrow. Sharers set the price, so competition between them can push it below the ceiling, and a sharer relaying a Wi-Fi network already charges a quarter of it.

## Why prepaid data expires

The CRC's user-protection rules ([Resolución 5111 de 2017](https://colombiatic.mintic.gov.co/679/articles-62266_doc_norma.pdf), compiled into Resolución 5050 de 2016) protect the **money balance** of a top-up: top-ups are valid for at least 60 days (art. 2.1.14.3), and if a balance is left unconsumed when it expires, you can use it if you top up again within the next 30 days, at no cost (art. 2.1.14.4). Moving from prepaid to postpaid carries the money balance over to the new plan.

The **data in a pack** has no such protection. The gigabytes last for the offer's term, and when it ends, whatever is left is gone. That is why a 39 GB, 30-day pack is cheap per GB on paper and expensive in practice for anyone who doesn't use it all. The balance you buy on Bump has no term.

## Notes on the data

- **Movistar now belongs to Tigo.** Millicom, Tigo's owner, bought Movistar Colombia in 2026 ([Forbes Colombia](https://forbes.co/2026/04/27/negocios/tigo-completa-compra-de-participacion-estatal-en-movistar-colombia-por-856-000-millones/)), and Movistar's prepaid sign-up page already redirects to Tigo's store. We list them separately while they still sell different packs.
- **WOM is missing** because its website did not respond from outside Colombia on the day of the check. We'll add it as soon as we can read its prices.
- **Tigo and Movistar** only publish their headline offer without a login; the rest of their packs sit in the app or in the store behind a line number. The two offers they do show are 2x1 and 3x1 data promotions; we use the price and the GB the customer actually receives.
- **Bonuses are left out**: extra GB for porting a number or paying with Claro Pay are not counted.
- **1 GB = 1,024 MB** throughout. Claro's packs include unlimited minutes and texts; we count only the data, which favours the carrier if you also use the minutes.

## Sources and evidence

Every row in the tables comes from one of these pages. The screenshot shows what the page displayed on the date; click to view.

<ol>
{%- for src in d.sources %}
<li>{{ src.carrier }}, {{ src.page }}: <a href="{{ src.url }}" rel="nofollow">{{ src.url | remove: "https://" | remove: "www." | truncate: 60 }}</a>. Read on {{ d.checked | date: "%Y-%m-%d" }}.{% if src.shot %} <a href="/assets/precios-co/{{ src.shot }}">Screenshot</a>.{% endif %}</li>
{%- endfor %}
</ol>

The screenshots were taken from outside Colombia with the browser translating the page to English, so the visible text is English. The raw data, with price, allowance, validity and source for every pack, is in [`_data/precios_co.yml`](https://github.com/BumpApp/bumpapp.github.io/blob/main/_data/precios_co.yml) in this site's public repository.

Found an outdated price? Write to [support@bumpapp.xyz](mailto:support@bumpapp.xyz) with the carrier's link and we'll fix it.

[Get Bump on Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
