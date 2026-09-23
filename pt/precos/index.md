---
layout: article
lang: pt-BR
title: "Quanto custa 1 GB de internet no Brasil em 2026: Vivo, Claro, TIM vs Bump"
description: "Preço por GB dos pacotes pré-pagos da Vivo, Claro e TIM, com data de verificação e link para a página de cada operadora, comparado com o que você paga no Bump."
date: 2026-09-23
translations:
  en: /prices/brazil/
  pt: /pt/precos/
---

{% assign d = site.data.precos_br %}
{% assign bump_gb = d.bump.credits_per_mb | times: 1024.0 | divided_by: d.bump.credits_per_brl | round: 2 %}
{% assign bump_wifi_gb = d.bump.credits_per_mb_wifi | times: 1024.0 | divided_by: d.bump.credits_per_brl | round: 2 %}

Esta página responde a uma pergunta simples: quanto custa 1 GB de internet móvel pré-paga no Brasil hoje, e quanto custa o mesmo GB no [Bump](/pt/). Cada preço abaixo foi lido na página oficial da operadora em **{{ d.checked | date: "%d/%m/%Y" }}**, com o link ao lado. Os preços mudam por DDD; a coluna indica qual foi consultado.

## Quanto custa no Bump

No Bump você paga por megabyte, só pelo que usar, com créditos que compra por Pix ou cartão. A taxa é de **{{ d.bump.credits_per_brl }} créditos por R$1**.

- **Preço máximo: {{ d.bump.credits_per_mb }} crédito por MB**, ou **R$ {% include brl.html v=bump_gb %} por GB**. É o teto que quem compartilha pode cobrar.
- **Quando quem compartilha está repassando uma rede Wi-Fi**, o preço cai para {{ d.bump.credits_per_mb_wifi | replace: ".", "," }} crédito por MB, ou **R$ {% include brl.html v=bump_wifi_gb %} por GB**.
- **{{ d.bump.free_mb }} MB grátis** ao criar a conta. Esses créditos de bônus valem por 90 dias.
- **Créditos comprados nunca vencem.** Compre R$4 hoje e use daqui a um ano.

Compare com os dois tipos de pacote que as operadoras vendem. São dois cenários diferentes, então são duas tabelas.

## Pacotes pequenos: quando o plano acabou e você precisa de pouco

É aqui que o pré-pago fica caro. Quando a franquia acaba no meio do mês, a operadora vende pacotes de 100 MB a 1 GB que valem um ou sete dias, e o preço por GB dispara.

<table>
<thead><tr><th>Operadora</th><th>Pacote</th><th>Preço</th><th>Validade</th><th>R$/GB</th><th>DDD</th><th>Fonte</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>preço máximo</td><td>por MB</td><td>nunca vence</td><td><strong>{% include brl.html v=bump_gb %}</strong></td><td>todos</td><td>esta página</td></tr>
{%- for p in d.packs -%}{%- if p.size == "small" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb | round: 2 %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}</td><td>R$ {% include brl.html v=p.price %}</td><td>{{ p.days }} dia{% if p.days > 1 %}s{% endif %}</td><td>{% include brl.html v=gb %}</td><td>{{ p.ddd }}</td><td><a href="{{ p.source }}" rel="nofollow">página</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

Os pacotes adicionais da Vivo custam de R$20 a R$26 por GB, entre 2,5 e 3 vezes o preço máximo do Bump. A tarifa diária da Claro para quem está sem saldo e o pacote de 500 MB também ficam acima. Só a partir de 1 GB comprado de uma vez a operadora volta a ser mais barata por GB. E os pacotes pequenos vencem em um ou sete dias: o pacote de R$1,99 da Vivo morre à meia-noite.

## Pacotes mensais: quando você compra o mês inteiro

Comprando 5 GB ou mais de uma vez, o preço por GB da operadora é menor que o do Bump. Não escondemos isso.

<table>
<thead><tr><th>Operadora</th><th>Pacote</th><th>Preço</th><th>Validade</th><th>R$/GB</th><th>DDD</th><th>Fonte</th></tr></thead>
<tbody>
<tr><td><strong>Bump</strong></td><td>preço máximo</td><td>por MB</td><td>nunca vence</td><td><strong>{% include brl.html v=bump_gb %}</strong></td><td>todos</td><td>esta página</td></tr>
{%- for p in d.packs -%}{%- if p.size == "large" %}
{%- assign gb = p.price | times: 1024.0 | divided_by: p.mb | round: 2 %}
<tr><td>{{ p.carrier }}</td><td>{{ p.pack }}</td><td>R$ {% include brl.html v=p.price %}</td><td>{{ p.days }} dias</td><td>{% include brl.html v=gb %}</td><td>{{ p.ddd }}</td><td><a href="{{ p.source }}" rel="nofollow">página</a></td></tr>
{%- endif -%}{%- endfor %}
</tbody>
</table>

A conta muda quando você olha o que realmente usa. O pacote custa o mesmo se você usar tudo ou quase nada, e o que sobrar some no fim do prazo. No Prezão de R$15 (5 GB por 15 dias), quem usa 500 MB pagou R$30 por GB; no Bump, esses 500 MB custam R$4,00. O ponto de equilíbrio é cerca de 1,8 GB em 15 dias contra a Claro e 2,4 GB em 17 dias contra a Vivo e a TIM. Abaixo disso, o Bump sai mais barato; acima, o pacote vence.

## Os dois cenários num gráfico

{% include precos-dotplot.html lang="pt" %}

{% include precos-scatter.html lang="pt" %}

## Por que o preço do Bump fica onde fica

Os dois gráficos mostram um espaço entre os preços das operadoras: quem compra 25 GB paga R$1,20 por GB; quem compra 200 MB paga R$25. O Bump foi desenhado para caber nesse espaço.

Quem tem um plano grande e não usa tudo pode compartilhar a sobra pelo app. Cada megabyte que passa pelo celular dele rende pontos, que viram dinheiro via Pix. Para essa pessoa, o GB custou R$1,20 ou menos, então compartilhá-lo por até R${% include brl.html v=bump_gb %} é renda de algo que ia vencer sem uso.

Para quem só precisa de um pouco de internet agora, o mesmo GB sai por no máximo R${% include brl.html v=bump_gb %} em vez dos R$20 a R$26 de um pacote adicional, e o que não usar hoje continua valendo amanhã. Quem compartilha define o preço, então a concorrência entre compartilhadores pode levá-lo abaixo do teto, e quem repassa uma rede Wi-Fi já cobra um quarto disso.

## Por que a internet pré-paga vence

As regras da Anatel para o consumidor (Regulamento Geral de Direitos do Consumidor, [Resolução 765/2023](https://informacoes.anatel.gov.br/legislacao/resolucoes/2023/1900-resolucao-765), em vigor desde setembro de 2025) protegem o **saldo em dinheiro** da recarga: ele tem validade mínima de 30 dias, e o saldo vencido e não usado tem de ser revalidado e somado quando você faz uma nova recarga. Se cancelar a linha, o saldo restante deve ser devolvido.

A **franquia de dados** não tem a mesma proteção. Os gigabytes do pacote valem pelo prazo da oferta e, quando ele acaba, o que sobrou some. É por isso que um pacote de 25 GB por 30 dias custa pouco por GB no papel e muito na prática para quem não usa tudo. Os créditos comprados no Bump não têm prazo.

## Notas sobre os dados

- **Bônus foram deixados de fora da conta.** Os 10 GB de portabilidade da Vivo e da Claro exigem trazer o número de outra operadora; o bônus de recarga da Claro (1 a 3 GB) vale 7 dias.
- **Pacotes com horário** também ficaram de fora: a Vivo vende 5 GB por R$1,99 só para sábado e domingo, e 10 GB por R$1,99 só das 0h às 6h.
- **Claro:** os cards de preço dizem que R$30 dá 20 GB; as perguntas frequentes da mesma página ainda dizem 15 GB. Usamos os cards.
- **TIM:** as perguntas frequentes da TIM citam pacotes adicionais pré de 500 MB, 1 GB, 2 GB e 4 GB, mas o preço não aparece no site, só no app Meu TIM. A tabela traz a oferta semanal que a TIM publica.
- **1 GB = 1.024 MB** em todas as contas. A TIM e a Claro contam parte do pacote como "exclusivo para redes sociais" ou "para YouTube"; incluímos esses GB no total, o que favorece a operadora.

## Fontes e evidências

Cada linha das tabelas vem de uma destas páginas. A captura de tela mostra o que a página exibia na data; clique para ver.

<ol>
{%- for src in d.sources %}
<li>{{ src.carrier }}, {{ src.page }}: <a href="{{ src.url }}" rel="nofollow">{{ src.url | remove: "https://" | remove: "www." }}</a>. DDD {{ src.ddd }}, lida em {{ d.checked | date: "%d/%m/%Y" }}. <a href="/assets/precos-br/{{ src.shot }}">Captura</a>{% if src.partial %} (mostra só o topo da página; os preços vieram do texto da mesma página){% endif %}.</li>
{%- endfor %}
</ol>

As capturas foram feitas de fora do Brasil, com o navegador traduzindo a página para inglês, então o texto visível está em inglês e os preços exibidos são os da região que o site da operadora escolheu (São Paulo para Vivo e Claro, Rio de Janeiro para TIM). Os dados brutos, com preço, franquia, validade e fonte de cada pacote, estão em [`_data/precos_br.yml`](https://github.com/BumpApp/bumpapp.github.io/blob/main/_data/precos_br.yml) no repositório público deste site.

Achou um preço desatualizado? Escreva para [support@bumpapp.xyz](mailto:support@bumpapp.xyz) com o link da operadora e corrigimos.

[Baixe o Bump na Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod)
