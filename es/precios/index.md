---
layout: article
lang: es-CO
title: "Cuánto cuesta 1 GB de datos en Colombia en 2026: Claro, Tigo, Movistar vs Bump"
description: "Precio por GB de los paquetes prepago de Claro, Tigo y Movistar, con la fecha de verificación y el enlace a la página de cada operador, comparado con lo que pagas en Bump."
date: 2026-09-23
translations:
  en: /prices/colombia/
  es-CO: /es/precios/
---

{% assign d = site.data.precios_co %}
{% assign bump_gb = d.bump.credits_per_mb | times: 1024.0 | divided_by: d.bump.credits_per_cop %}
{% assign bump_wifi_gb = d.bump.credits_per_mb_wifi | times: 1024.0 | divided_by: d.bump.credits_per_cop %}

Esta página responde una pregunta simple: cuánto cuesta hoy 1 GB de datos móviles prepago en Colombia, y cuánto cuesta el mismo GB en [Bump](/es/). Cada precio de abajo se leyó en la página oficial del operador el **{{ d.checked | date: "%d/%m/%Y" }}**, con el enlace al lado.

## Cuánto cuesta en Bump

En Bump pagas solo por lo que usas, con saldo que compras por PSE o tarjeta desde ${% include cop.html v=d.bump.min_purchase_cop %}. El precio es por GB y quien comparte fija el suyo, dentro de un tope.

- **Precio máximo: ${% include cop.html v=bump_gb %} por GB.** Es el tope que quien comparte puede cobrar.
- **Cuando quien comparte está pasando una red Wi-Fi**, el precio baja a **${% include cop.html v=bump_wifi_gb %} por GB**.
- **{{ d.bump.free_mb }} MB gratis** al crear la cuenta. Ese bono vale por 90 días.
- **El saldo que compras nunca vence.** Compra $10.000 hoy y úsalo dentro de un año.

Compáralo con los dos tipos de paquete que venden los operadores. Son dos situaciones distintas, así que son dos tablas.

## Paquetes pequeños: cuando se acabó el plan y necesitas poco

Aquí es donde el prepago se pone caro. Cuando los datos se acaban a mitad de mes, el operador vende paquetes de 150 MB a 6 GB que duran de uno a siete días, y en los más pequeños el precio por GB se dispara.

<table>
<thead><tr><th>Operador</th><th>Paquete</th><th>Precio</th><th>Vigencia</th><th>$/GB</th><th>Fuente</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>precio máximo</td><td>por uso</td><td>nunca vence</td><td><strong>{% include cop.html v=bump_gb %}</strong></td><td>esta página</td></tr>
{%- for p in d.packs -%}{%- if p.size == "small" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}{% if p.pending %} †{% endif %}</td><td>${% include cop.html v=p.price %}</td><td>{{ p.days }} día{% if p.days > 1 %}s{% endif %}</td><td>{% include cop.html v=gb %}</td><td><a href="{{ p.source }}" rel="nofollow">{{ p.source | remove: "https://" | remove: "www." | split: "/" | first }}</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

Los paquetes de uno y tres días de Claro cuestan entre $14.000 y $20.500 por GB, de cinco a siete veces el precio máximo de Bump; el de 500 MB de Virgin, $9.200; los de uno a seis días de WOM, $5.000 a $5.300. Solo los paquetes de siete días de 2 GB o más ($1.500 a $2.500 por GB) quedan por debajo del tope de Bump. Y todos vencen en uno, tres o siete días.

† Precio tomado del comparador Selectra el 20/07/2026, pendiente de verificar en la página del operador.

## Paquetes mensuales: cuando compras el mes entero

Comprando 2 GB o más de una vez para la semana o el mes, el precio por GB del operador suele ser menor que el de Bump. No lo escondemos.

<table>
<thead><tr><th>Operador</th><th>Paquete</th><th>Precio</th><th>Vigencia</th><th>$/GB</th><th>Fuente</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>precio máximo</td><td>por uso</td><td>nunca vence</td><td><strong>{% include cop.html v=bump_gb %}</strong></td><td>esta página</td></tr>
{%- for p in d.packs -%}{%- if p.size == "large" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}{% if p.pending %} †{% endif %}</td><td>${% include cop.html v=p.price %}</td><td>{{ p.days }} días</td><td>{% include cop.html v=gb %}</td><td><a href="{{ p.source }}" rel="nofollow">{{ p.source | remove: "https://" | remove: "www." | split: "/" | first }}</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

La cuenta cambia cuando miras lo que realmente usas. El paquete cuesta lo mismo si lo usas todo o casi nada, y lo que sobra desaparece al vencer. En el Todo incluido WIN de $11.000 (2 GB por 7 días), quien usa 500 MB pagó $22.000 por GB; en Bump, esos 500 MB cuestan ${% assign half = bump_gb | times: 500 | divided_by: 1024 %}{% include cop.html v=half %}. El punto de equilibrio es cerca de 3,6 GB en 7 días contra ese paquete y 11 GB en 30 días contra el WIN de $35.000. Por debajo, Bump sale más barato; por encima, gana el paquete.

† Precio tomado del comparador Selectra el 20/07/2026, pendiente de verificar en la página del operador.

## Los dos escenarios en un gráfico

{% include precos-dotplot.html lang="es" data="precios_co" cur="cop" xmax=24000 step=4000 %}

{% include precos-scatter.html lang="es" data="precios_co" cur="cop" ymax=16000 ystep=4000 %}

## Por qué el precio de Bump queda donde queda

Los dos gráficos muestran un espacio entre los precios de los propios operadores: quien compra 39 GB paga $667 por GB; quien compra 150 MB paga $20.480. Bump está diseñado para caber en ese espacio.

Quien tiene un plan grande y no lo gasta puede compartir el sobrante por la app. Cada megabyte que pasa por su celular le da puntos, que se convierten en dinero por Bre-B. Su GB le costó entre $700 y $1.250, así que compartirlo por hasta ${% include cop.html v=bump_gb %} es ingreso por datos que de otro modo habrían vencido sin usarse.

Quien solo necesita un poco de datos ahora mismo consigue ese mismo GB por máximo ${% include cop.html v=bump_gb %} en vez de los $14.000 a $20.500 de un paquete de uno o tres días de Claro, y lo que no use hoy sigue siendo suyo mañana. Quienes comparten fijan el precio, así que la competencia entre ellos puede bajarlo del tope, y quien pasa una red Wi-Fi ya cobra la cuarta parte.

## Por qué vencen los datos prepago

El Régimen de Protección de los Derechos de los Usuarios de la CRC ([Resolución 5111 de 2017](https://colombiatic.mintic.gov.co/679/articles-62266_doc_norma.pdf), compilada en la Resolución 5050 de 2016) protege el **saldo en dinero** de la recarga: las recargas tienen una vigencia mínima de 60 días (art. 2.1.14.3) y, si al vencer queda saldo sin consumir, puedes usarlo si haces una nueva recarga dentro de los 30 días siguientes, sin costo (art. 2.1.14.4). Si pasas de prepago a pospago, el saldo en dinero se traslada al nuevo plan.

Los **datos del paquete** no tienen la misma protección. Los gigas valen por la vigencia de la oferta y, cuando se acaba, lo que sobró se pierde. Por eso un paquete de 39 GB por 30 días cuesta poco por GB en el papel y mucho en la práctica para quien no lo usa todo. El saldo que compras en Bump no tiene vigencia.

## Notas sobre los datos

- **Movistar ya es de Tigo.** Millicom, la dueña de Tigo, compró Movistar Colombia en 2026 ([Forbes Colombia](https://forbes.co/2026/04/27/negocios/tigo-completa-compra-de-participacion-estatal-en-movistar-colombia-por-856-000-millones/)), y la página de prepago de Movistar ya redirige a la tienda de Tigo. Los listamos por separado mientras sigan vendiendo paquetes distintos.
- **Filas marcadas con †**: vienen de una hoja de julio de 2026 de nuestro equipo con precios del comparador Selectra, no de la página del operador. Las mostramos porque son los únicos paquetes de WOM y de Virgin que tenemos, y los únicos paquetes pequeños de Tigo y Movistar, que no publican su lista sin iniciar sesión. El sitio de WOM no respondió desde fuera de Colombia. Cada fila se reemplaza por la página del operador en cuanto tengamos la captura; los precios de Claro subieron entre julio y septiembre, así que las filas † pueden haber cambiado.
- **Tigo y Movistar** solo publican su oferta destacada sin iniciar sesión, y las dos son promociones 2x1 y 3x1 sobre los datos; usamos el precio y los GB que el cliente recibe.
- **Bonos quedaron por fuera**: los GB adicionales por portabilidad o por pagar con Claro Pay no entran en la cuenta.
- **1 GB = 1.024 MB** en todas las cuentas. Los paquetes de Claro incluyen minutos y mensajes ilimitados; contamos solo los datos, lo que favorece al operador si también usas los minutos.

## Fuentes y evidencia

Cada fila de las tablas sale de una de estas páginas. La captura muestra lo que la página mostraba ese día; haz clic para verla.

<ol>
{%- for src in d.sources %}
<li>{{ src.carrier }}, {{ src.page }}: <a href="{{ src.url }}" rel="nofollow">{{ src.url | remove: "https://" | remove: "www." | truncate: 60 }}</a>. {% if src.pending %}Consultada el {{ src.checked | date: "%d/%m/%Y" }}; pendiente de verificar en la página del operador.{% else %}Leída el {{ d.checked | date: "%d/%m/%Y" }}.{% endif %}{% if src.shot %} <a href="/assets/precios-co/{{ src.shot }}">Captura</a>.{% endif %}</li>
{%- endfor %}
</ol>

Las capturas se hicieron desde fuera de Colombia, con el navegador traduciendo la página al inglés, así que el texto visible está en inglés. Los datos crudos, con precio, datos, vigencia y fuente de cada paquete, están en [`_data/precios_co.yml`](https://github.com/BumpApp/bumpapp.github.io/blob/main/_data/precios_co.yml) en el repositorio público de este sitio.

¿Encontraste un precio desactualizado? Escribe a [support@bumpapp.xyz](mailto:support@bumpapp.xyz) con el enlace del operador y lo corregimos.

[Descarga Bump en Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
