---
layout: article
lang: es-CO
title: "¿Bump es una estafa? Cómo funciona la app, cuánto cuesta y cuánto ganas"
description: "Respuestas directas: qué es Bump, si quien comparte puede ver tu tráfico, cuánto paga quien usa, cuánto gana quien comparte y dónde está disponible."
translations:
  en: /faq/
  pt: /pt/faq/
  es: /es/faq/
---

Bump es una app de Android para compartir Internet entre celulares, en beta pública en Colombia y Brasil. Estas son las preguntas que la gente hace antes de instalarla, respondidas sin rodeos.

{% assign faq_lang = page.lang | split: "-" | first %}
{% for entry in site.data.faq[faq_lang] %}
## {{ entry.question }}

{{ entry.answer }}
{% endfor %}
[Descarga Bump en Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
