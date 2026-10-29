---
layout: article
lang: en
title: "Is Bump a scam? How the app works, what it costs and what you earn"
description: "Straight answers: what Bump is, whether the person sharing can see your traffic, what a user pays, what a sharer earns, and where it is live."
translations:
  en: /faq/
  pt: /pt/faq/
  es: /es/faq/
---

Bump is a peer-to-peer Internet sharing app for Android, in public beta in Brazil and Colombia. These are the questions people ask before they install it, answered plainly.

{% assign faq_lang = page.lang | split: "-" | first %}
{% for entry in site.data.faq[faq_lang] %}
## {{ entry.question }}

{{ entry.answer }}
{% endfor %}
[Get Bump on Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
