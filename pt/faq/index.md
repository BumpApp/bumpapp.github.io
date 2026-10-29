---
layout: article
lang: pt-BR
title: "O Bump é golpe? Como o app funciona, quanto custa e quanto você ganha"
description: "Respostas diretas: o que é o Bump, se quem compartilha vê o que você acessa, quanto paga quem usa, quanto ganha quem compartilha e onde está disponível."
translations:
  en: /faq/
  pt: /pt/faq/
  es: /es/faq/
---

O Bump é um app Android para compartilhar Internet entre celulares, em beta público no Brasil e na Colômbia. Estas são as perguntas que as pessoas fazem antes de instalar, respondidas sem enrolação.

{% assign faq_lang = page.lang | split: "-" | first %}
{% for entry in site.data.faq[faq_lang] %}
## {{ entry.question }}

{{ entry.answer }}
{% endfor %}
[Baixe o Bump na Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
