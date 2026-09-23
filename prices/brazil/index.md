---
layout: article
lang: en
title: "What 1 GB of mobile data costs in Brazil in 2026: Vivo, Claro, TIM vs Bump"
description: "Price per GB of Vivo, Claro and TIM prepaid packs, with the date checked and a link to each carrier's own page, compared with what you pay on Bump."
date: 2026-09-23
translations:
  en: /prices/brazil/
  pt: /pt/precos/
---

{% assign d = site.data.precos_br %}
{% assign bump_gb = d.bump.credits_per_mb | times: 1024.0 | divided_by: d.bump.credits_per_brl | round: 2 %}
{% assign bump_wifi_gb = d.bump.credits_per_mb_wifi | times: 1024.0 | divided_by: d.bump.credits_per_brl | round: 2 %}

This page answers one question: what 1 GB of prepaid mobile data costs in Brazil today, and what the same GB costs on [Bump](/). Every price below was read from the carrier's own page on **{{ d.checked | date: "%Y-%m-%d" }}**, with the link beside it. Prices vary by area code (DDD); the column says which one was checked.

## What it costs on Bump

On Bump you pay only for what you use, from a balance bought by Pix or card. The price is per GB, and each sharer sets their own under a ceiling.

- **Maximum price: R${% include brl.html v=bump_gb dec="." %} per GB.** That is the ceiling a sharer can charge.
- **When the sharer is relaying a Wi-Fi network**, the price drops to **R${% include brl.html v=bump_wifi_gb dec="." %} per GB**.
- **{{ d.bump.free_mb }} MB free** when you create an account. That bonus lasts 90 days.
- **The balance you buy never expires.** Buy R$4 today and use it a year from now.

Compare that with the two kinds of pack the carriers sell. They are different situations, so they get different tables.

## Small packs: when your plan ran out and you need a little

This is where prepaid gets expensive. When the allowance runs out mid-month, the carrier sells 100 MB to 1 GB packs that last one or seven days, and the price per GB jumps.

<table>
<thead><tr><th>Carrier</th><th>Pack</th><th>Price</th><th>Valid for</th><th>R$/GB</th><th>DDD</th><th>Source</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>maximum price</td><td>by use</td><td>never expires</td><td><strong>{% include brl.html v=bump_gb dec="." %}</strong></td><td>all</td><td>this page</td></tr>
{%- for p in d.packs -%}{%- if p.size == "small" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb | round: 2 %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}</td><td>R${% include brl.html v=p.price dec="." %}</td><td>{{ p.days }} day{% if p.days > 1 %}s{% endif %}</td><td>{% include brl.html v=gb dec="." %}</td><td>{{ p.ddd }}</td><td><a href="{{ p.source }}" rel="nofollow">{{ p.source | remove: "https://" | remove: "www." | split: "/" | first }}</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

Vivo's add-on packs cost R$20 to R$26 per GB, 2.5 to 3 times Bump's maximum. Claro's daily rate for customers with no balance and its 500 MB pack are above it too. Only from 1 GB bought at once does the carrier become cheaper per GB again. And small packs expire in one or seven days: Vivo's R$1.99 pack dies at midnight.

## Monthly packs: when you buy the whole month

Buying 5 GB or more at once, the carrier's price per GB is lower than Bump's. We don't hide that.

<table>
<thead><tr><th>Carrier</th><th>Pack</th><th>Price</th><th>Valid for</th><th>R$/GB</th><th>DDD</th><th>Source</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>maximum price</td><td>by use</td><td>never expires</td><td><strong>{% include brl.html v=bump_gb dec="." %}</strong></td><td>all</td><td>this page</td></tr>
{%- for p in d.packs -%}{%- if p.size == "large" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb | round: 2 %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}</td><td>R${% include brl.html v=p.price dec="." %}</td><td>{{ p.days }} days</td><td>{% include brl.html v=gb dec="." %}</td><td>{{ p.ddd }}</td><td><a href="{{ p.source }}" rel="nofollow">{{ p.source | remove: "https://" | remove: "www." | split: "/" | first }}</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

The math changes when you look at what you actually use. The pack costs the same whether you use all of it or almost none, and whatever is left disappears when the days are up. On the R$15 Prezão (5 GB for 15 days), someone who uses 500 MB paid R$30 per GB; on Bump those 500 MB cost R$4.00. The break-even is about 1.8 GB in 15 days against Claro and 2.4 GB in 17 days against Vivo and TIM. Below that, Bump is cheaper; above it, the pack wins.

## Both cases in one picture

{% include precos-dotplot.html lang="en" %}

{% include precos-scatter.html lang="en" %}

## Why Bump's price sits where it does

The two charts show a gap between the carriers' own prices: someone buying 25 GB pays R$1.20 per GB; someone buying 200 MB pays R$25. Bump is designed to fit in that gap.

A person with a big plan they don't use up can share the surplus through the app. Every megabyte that passes through their phone earns points, which convert to cash via Pix. Their GB cost them R$1.20 or less, so sharing it for up to R${% include brl.html v=bump_gb dec="." %} is income from data that would otherwise have expired unused.

A person who just needs a little data right now gets that same GB for at most R${% include brl.html v=bump_gb dec="." %} instead of the R$20 to R$26 of an add-on pack, and whatever they don't use today is still theirs tomorrow. Sharers set the price, so competition between them can push it below the ceiling, and a sharer relaying a Wi-Fi network already charges a quarter of it.

## Why prepaid data expires

Anatel's consumer rules (the General Consumer Rights Regulation, [Resolução 765/2023](https://informacoes.anatel.gov.br/legislacao/resolucoes/2023/1900-resolucao-765), fully in force since September 2025) protect the **money balance** of a top-up: it is valid for at least 30 days, and any expired, unused balance must be revalidated and added back when you top up again. If you cancel the line, the remaining balance must be refunded.

The **data allowance** has no such protection. The gigabytes in a pack last for the offer's term, and when it ends, whatever is left is gone. That is why a 25 GB, 30-day pack is cheap per GB on paper and expensive in practice for anyone who doesn't use it all. Credits bought on Bump have no term.

## Notes on the data

- **Bonuses are left out of the math.** Vivo's and Claro's 10 GB portability bonus requires bringing your number from another carrier; Claro's top-up bonus (1 to 3 GB) lasts 7 days.
- **Time-restricted packs** are left out too: Vivo sells 5 GB for R$1.99 valid only Saturday and Sunday, and 10 GB for R$1.99 valid only from midnight to 6 am.
- **Claro:** the price cards say R$30 buys 20 GB; the FAQ on the same page still says 15 GB. We used the cards.
- **TIM:** TIM's FAQ mentions prepaid add-on packs of 500 MB, 1 GB, 2 GB and 4 GB, but the price isn't on the website, only in the Meu TIM app. The table shows the weekly offer TIM does publish.
- **1 GB = 1,024 MB** throughout. TIM and Claro count part of the pack as "social networks only" or "YouTube only"; we include those GB in the total, which favours the carrier.

## Sources and evidence

Every row in the tables comes from one of these pages. The screenshot shows what the page displayed on the date; click to view.

<ol>
{%- for src in d.sources %}
<li>{{ src.carrier }}, {{ src.page }}: <a href="{{ src.url }}" rel="nofollow">{{ src.url | remove: "https://" | remove: "www." }}</a>. DDD {{ src.ddd }}, read on {{ d.checked | date: "%Y-%m-%d" }}. <a href="/assets/precos-br/{{ src.shot }}">Screenshot</a>{% if src.partial %} (shows only the top of the page; the prices came from the same page's text){% endif %}.</li>
{%- endfor %}
</ol>

The screenshots were taken from outside Brazil with the browser translating the page to English, so the visible text is English and the prices shown are for the region the carrier's site picked (São Paulo for Vivo and Claro, Rio de Janeiro for TIM). The raw data, with price, allowance, validity and source for every pack, is in [`_data/precos_br.yml`](https://github.com/BumpApp/bumpapp.github.io/blob/main/_data/precos_br.yml) in this site's public repository.

Found an outdated price? Write to [support@bumpapp.xyz](mailto:support@bumpapp.xyz) with the carrier's link and we'll fix it.

[Get Bump on Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
