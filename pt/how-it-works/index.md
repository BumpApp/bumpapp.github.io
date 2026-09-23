---
layout: article
lang: pt-BR
title: "Como o Bump funciona: compartilhamento de Internet entre celulares próximos"
description: "A engenharia por trás do Bump: descoberta por Bluetooth, uma conexão Wi-Fi Direct de celular a celular e um túnel OpenVPN para que quem compartilha os dados não veja o seu tráfego."
translations:
  en: /how-it-works/
  pt: /pt/how-it-works/
  es: /es/how-it-works/
---

O Bump é um app Android que permite a um celular compartilhar seus dados móveis ou Wi-Fi com um celular próximo, e paga quem compartilha pelos dados que passam por ele. Esta página explica como o app faz isso, com detalhe suficiente para um engenheiro conferir cada afirmação. Para as respostas curtas, veja as [Perguntas Frequentes](/pt/faq/).

## A versão curta

1. Um celular que está compartilhando se anuncia por Bluetooth Low Energy (BLE). Os celulares por perto captam o anúncio e o mostram numa lista e num mapa de cobertura.
2. Quando você escolhe quem compartilha, seu celular abre uma conexão Wi-Fi Direct com o dele. Os dados passam por esse link, não pela Internet.
3. Antes de qualquer tráfego seu passar, seu celular abre um túnel OpenVPN criptografado até um servidor da Bump. O celular de quem compartilha encaminha os pacotes do túnel, mas não consegue lê-los.
4. Quem compartilha aprova você e define um limite de dados. Você paga por megabyte com créditos Bump. Ele ganha pontos de recompensa pelos mesmos megabytes.

<figure>
<svg viewBox="0 0 840 230" role="img" aria-labelledby="fig1-title" style="width:100%;height:auto;font-family:Inter,system-ui,sans-serif;font-size:17px">
  <title id="fig1-title">Um salto: seu celular se conecta ao celular de quem compartilha por Wi-Fi Direct, e um túnel criptografado vai do seu celular, passando por quem compartilha, até um servidor VPN da Bump e dali para a Internet.</title>
  <defs>
    <marker id="a1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#475569"/></marker>
  </defs>
  <rect x="10" y="70" width="130" height="60" rx="8" fill="#0F172A"/>
  <text x="75" y="105" text-anchor="middle" fill="#fff" font-weight="600">Seu celular</text>
  <rect x="220" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="305" y="105" text-anchor="middle" fill="#fff" font-weight="600">Quem compartilha</text>
  <rect x="470" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="555" y="105" text-anchor="middle" fill="#fff" font-weight="600" font-size="15">Servidor VPN Bump</text>
  <rect x="720" y="70" width="110" height="60" rx="8" fill="#0F172A"/>
  <text x="775" y="105" text-anchor="middle" fill="#fff" font-weight="600">Internet</text>
  <line x1="140" y1="100" x2="220" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a1)" marker-end="url(#a1)"/>
  <text x="180" y="58" text-anchor="middle" fill="#475569">O Bluetooth encontra</text>
  <text x="180" y="150" text-anchor="middle" fill="#475569">O Wi-Fi Direct transporta</text>
  <line x1="390" y1="100" x2="470" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a1)" marker-end="url(#a1)"/>
  <text x="430" y="58" text-anchor="middle" fill="#475569">Dados de quem compartilha</text>
  <line x1="640" y1="100" x2="720" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a1)" marker-end="url(#a1)"/>
  <line x1="75" y1="185" x2="555" y2="185" stroke="#10B981" stroke-width="6" stroke-linecap="round"/>
  <text x="340" y="215" text-anchor="middle" fill="#047857" font-weight="600" font-size="15">Túnel criptografado: só o seu celular e o servidor da Bump conseguem ler</text>
</svg>
<figcaption>Um salto. O celular de quem compartilha é um intermediário para pacotes que não consegue decifrar.</figcaption>
</figure>

## Encontrando quem compartilha: Bluetooth e o mapa de cobertura

Um celular que está compartilhando se anuncia por BLE. Tudo o que o outro celular precisa para se conectar está no próprio anúncio: se quem compartilha está em dados móveis, Wi-Fi ou ambos, se é um ponto de acesso ou um intermediário, e o nome e a senha da rede Wi-Fi Direct. Celulares com suporte a anúncios estendidos do Bluetooth 5 incluem também o nome de usuário de quem compartilha, uma estimativa de velocidade e o preço por megabyte.

Os celulares que procuram Internet também se anunciam, com um sinalizador que diz "preciso de dados". É assim que o celular de quem compartilha percebe que há pessoas por perto querendo conexão antes de alguém tocar em qualquer coisa.

Seu celular varre continuamente enquanto o app está aberto e descarta qualquer compartilhador de quem não tiver notícia por cinco segundos, então a lista que você vê está sempre atual. O alcance do Bluetooth é em linha de visada e curto: a mesma sala, prédio, praça ou ônibus. Dois celulares só se encontram quando cada um está dentro do alcance do outro.

<figure>
<svg viewBox="0 0 840 310" role="img" aria-labelledby="fig-range-title" style="width:100%;height:auto;font-family:Inter,system-ui,sans-serif;font-size:17px">
  <title id="fig-range-title">Quatro celulares com o alcance do Bluetooth desenhado como círculos. À esquerda, um celular compartilhando e um procurando estão cada um dentro do círculo do outro, então estão no alcance. À direita, os dois círculos não se tocam, então esses celulares não se encontram.</title>
  <circle cx="170" cy="150" r="90" fill="#10B981" fill-opacity="0.18" stroke="#10B981" stroke-width="2"/>
  <circle cx="240" cy="150" r="90" fill="#0EA5E9" fill-opacity="0.18" stroke="#0EA5E9" stroke-width="2"/>
  <rect x="159" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <rect x="229" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <text x="150" y="42" text-anchor="end" fill="#047857" font-weight="600">Compartilhando</text>
  <text x="260" y="42" text-anchor="start" fill="#0369A1" font-weight="600">Procurando</text>
  <text x="205" y="275" text-anchor="middle" fill="#0F172A" font-weight="600">No alcance</text>
  <text x="210" y="298" text-anchor="middle" fill="#475569" font-size="15">Os dois celulares estão na sobreposição</text>
  <circle cx="520" cy="150" r="90" fill="#10B981" fill-opacity="0.18" stroke="#10B981" stroke-width="2"/>
  <circle cx="740" cy="150" r="90" fill="#0EA5E9" fill-opacity="0.18" stroke="#0EA5E9" stroke-width="2"/>
  <rect x="509" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <rect x="729" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <text x="520" y="42" text-anchor="middle" fill="#047857" font-weight="600">Compartilhando</text>
  <text x="740" y="42" text-anchor="middle" fill="#0369A1" font-weight="600">Procurando</text>
  <text x="630" y="275" text-anchor="middle" fill="#0F172A" font-weight="600">Fora do alcance</text>
  <text x="630" y="298" text-anchor="middle" fill="#475569" font-size="15">Nenhum dos dois ouve o outro</text>
</svg>
<figcaption>Alcance. O alcance do Bluetooth de cada celular é um círculo ao seu redor. Dois celulares só se encontram quando cada um está dentro do círculo do outro, o que coloca os dois na sobreposição.</figcaption>
</figure>

O Bump não é um Wi-Fi para a cidade inteira, ainda. Queremos chegar lá aumentando a cobertura, não o alcance. O mapa de cobertura nos diz onde há pessoas procurando conexão e ninguém compartilhando. Nosso programa de bônus oferece recompensas extras a quem compartilha e aparece numa célula específica da cidade num horário definido, verificado pelos mesmos relatórios de localização que alimentam o mapa, para que as áreas de maior demanda cheguem o mais perto possível de uma cobertura completa.

<figure>
<img src="/how-it-works/bounties.png" width="913" height="520" alt="Um mapa de ruas de um bairro dividido em células hexagonais. Várias células têm contorno laranja com o número 1, uma é vermelha, e um grupo de células cinzas e azuis fica à direita." loading="lazy">
<figcaption>Bônus no mapa das nossas ferramentas administrativas. Cada hexágono é uma célula. As células laranja são onde pessoas procuraram conexão e não encontraram ninguém compartilhando, e o número é quantas delas pediram um ponto de acesso ali. As células azuis têm um bônus agendado, as cinzas expiraram e a vermelha foi cancelada. Dados do mapa: Google.</figcaption>
</figure>

O mapa de cobertura é construído a partir de relatórios de localização que os celulares anexam, se a localização estiver ativada, aos seus registros de sessão e de busca. Nosso backend os agrega numa entrada por dispositivo. O app pede os dispositivos vistos nos últimos 30 minutos num raio de cerca de um quilômetro e desenha cada um como um pequeno círculo, azul para oferta e vermelho para demanda, atualizando a cada dez segundos. Entradas com mais de 24 horas são apagadas.

## Conectando celular a celular: Wi-Fi Direct

Quando você escolhe quem compartilha, dois links são abertos ao mesmo tempo.

**O primeiro é um canal BLE L2CAP.** Ele fica pronto em um ou dois segundos e transporta algumas centenas de kilobits por segundo. É o bastante para completar o handshake, buscar as credenciais da VPN e iniciar o túnel enquanto o link mais rápido ainda está subindo.

**O segundo é o Wi-Fi Direct.** O celular de quem compartilha é o dono do grupo de um grupo Wi-Fi Direct. Seu celular entra nele como uma estação Wi-Fi comum, usando o nome e a senha da rede que leu no anúncio BLE, pela API de sugestão de rede do Android. Depois descobre o endereço de quem compartilha com um multicast UDP no link. Isso leva de cinco a dez segundos e transporta dezenas de megabits por segundo. Quando fica pronto, o túnel é reiniciado sobre ele e a sessão continua.

O Bump não usa o roteador Wi-Fi comum do celular. As APIs de roteador do Android ou exigem hardware que consiga ser estação e ponto de acesso ao mesmo tempo, ou não deixam um app gerenciar a conexão, então o Bump cria seu próprio grupo Wi-Fi Direct. É também por isso que o celular de quem compartilha continua conectado ao seu próprio Wi-Fi ou dados móveis enquanto compartilha.

A senha viaja num anúncio Bluetooth que qualquer um no alcance consegue ler. Isso é intencional. O link Wi-Fi só transporta tráfego criptografado do túnel, e ninguém recebe Internet por ele até quem compartilha aprovar, então a senha sozinha não protege nada.

## O túnel: o que quem compartilha vê e o que não vê

Seu celular roda a biblioteca OpenVPN 3. Ela cria uma interface VPN do Android que captura todo o tráfego do seu celular, inclusive DNS, e o envia pelo túnel. Os pacotes do túnel vão para um proxy local no seu celular, que envolve cada um num pequeno cabeçalho com o endereço do servidor VPN da Bump e o envia pelo link Wi-Fi Direct (ou pelo link BLE enquanto o Wi-Fi ainda está conectando). O celular de quem compartilha lê o cabeçalho, abre um socket UDP comum para esse servidor e encaminha o pacote. As respostas voltam pelo mesmo caminho.

O celular de quem compartilha nunca tem uma chave do túnel. As credenciais funcionam assim:

- Seu celular gera seu próprio par de chaves e uma solicitação de assinatura de certificado. A chave privada nunca sai do seu celular.
- Ele assina uma declaração contendo o ID da sua conta, o ID do dispositivo e a solicitação, e a envia a quem compartilha.
- O celular de quem compartilha repassa a declaração sem alterá-la ao servidor VPN e devolve a resposta byte por byte.
- O servidor verifica a declaração com o serviço de diretório da Bump e assina o certificado, válido por 30 dias.
- Seu celular verifica a resposta com uma chave pública embutida no app, confere se o certificado corresponde à sua própria chave e ao servidor esperado, e só então se conecta.

Então quem compartilha consegue ver:

- O endereço do servidor VPN da Bump que você está usando.
- Quantos bytes você enviou e recebeu, e quando. É por isso que ele é pago.
- Seu nome de usuário e o identificador do seu dispositivo.

Quem compartilha não consegue ver:

- Com quais sites, apps ou servidores você está se comunicando.
- Suas consultas DNS, que vão dentro do túnel.
- O conteúdo de qualquer coisa que você envia ou recebe.

Seu tráfego sai para a Internet pelo servidor da Bump, não pela conexão de quem compartilha, então nada do que você faz parece vir do endereço IP dele. O servidor da Bump é onde o túnel termina, então é o ponto que consegue ver seu tráfego, exatamente como seu provedor ou qualquer serviço de VPN. Não registramos quais sites ou apps você acessa. Guardamos registros de conexão (qual dispositivo, qual servidor, quando, quantos dados, qual IP de saída) por 12 meses porque o Marco Civil da Internet exige, e cada acesso da nossa equipe a esses registros é ele mesmo registrado. A [política de privacidade](/pt/privacy-policy/) tem os detalhes.

## Quem aprova, e os limites de dados

Nada passa até quem compartilha dizer sim. Quando você pede para se conectar, quem compartilha recebe uma notificação com o seu nome e uma caixa de diálogo onde aprova ou bloqueia o pedido e define um limite de dados para você. O limite pode ser qualquer quantidade, ou ilimitado.

O celular de quem compartilha conta cada byte em cada direção por pessoa conectada. O app mostra o uso de cada pessoa em relação ao seu limite, e permite a quem compartilha aumentar o limite ou desconectá-la a qualquer momento. Quando um limite é atingido, a conexão é encerrada com um motivo que aparece no seu celular. O mesmo acontece se seus créditos acabarem. Quem compartilha também pode parar de compartilhar de vez, o que desconecta todo mundo.

## Créditos e pontos de recompensa

Os dois celulares relatam suas contagens de bytes ao backend da Bump durante a sessão. O backend cobra de quem usa a conexão por megabyte, pelo preço de quem compartilha, em créditos. E concede a quem compartilha pontos de recompensa pelos mesmos megabytes. Os créditos são comprados no app e nunca expiram. Os pontos de recompensa são convertidos em dinheiro via Pix no Brasil e Bre-B na Colômbia. As taxas vêm de uma configuração no servidor, não do app, então podem mudar sem atualização. As [Perguntas Frequentes](/pt/faq/#quanto-custa-a-internet-no-bump) têm os preços atuais e os detalhes de pagamento.

## Passando adiante: a corrente

Um celular conectado pelo Bump também pode compartilhar o que tem com o próximo celular. Chamamos isso de passar adiante, ou a corrente. Ela chega a lugares aonde o Wi-Fi de quem compartilha primeiro não chega: o fundo de um mercado, um auditório no subsolo, o fim de um ônibus.

<figure>
<svg viewBox="0 0 840 250" role="img" aria-labelledby="fig2-title" style="width:100%;height:auto;font-family:Inter,system-ui,sans-serif;font-size:17px">
  <title id="fig2-title">A corrente: seu celular se conecta a um celular intermediário, que se conecta a quem compartilha e tem Internet. O túnel criptografado vai do seu celular, passando pelos dois, até o servidor VPN da Bump.</title>
  <defs>
    <marker id="a2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#475569"/></marker>
  </defs>
  <rect x="10" y="70" width="130" height="60" rx="8" fill="#0F172A"/>
  <text x="75" y="105" text-anchor="middle" fill="#fff" font-weight="600">Seu celular</text>
  <rect x="200" y="70" width="160" height="60" rx="8" fill="#0F172A"/>
  <text x="280" y="97" text-anchor="middle" fill="#fff" font-weight="600">Intermediário</text>
  <text x="280" y="117" text-anchor="middle" fill="#94A3B8" font-size="14">sem Internet própria</text>
  <rect x="420" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="505" y="97" text-anchor="middle" fill="#fff" font-weight="600">Quem compartilha</text>
  <text x="505" y="117" text-anchor="middle" fill="#94A3B8" font-size="14">tem Internet</text>
  <rect x="650" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="735" y="105" text-anchor="middle" fill="#fff" font-weight="600" font-size="15">Servidor VPN Bump</text>
  <line x1="140" y1="100" x2="200" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a2)" marker-end="url(#a2)"/>
  <text x="170" y="58" text-anchor="middle" fill="#475569">Wi-Fi Direct</text>
  <line x1="360" y1="100" x2="420" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a2)" marker-end="url(#a2)"/>
  <text x="390" y="58" text-anchor="middle" fill="#475569">Wi-Fi Direct</text>
  <line x1="590" y1="100" x2="650" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a2)" marker-end="url(#a2)"/>
  <text x="620" y="58" text-anchor="middle" fill="#475569" font-size="15">Dados de quem compartilha</text>
  <line x1="75" y1="185" x2="735" y2="185" stroke="#10B981" stroke-width="6" stroke-linecap="round"/>
  <text x="420" y="215" text-anchor="middle" fill="#047857" font-weight="600">Um único túnel criptografado, de ponta a ponta</text>
  <text x="420" y="237" text-anchor="middle" fill="#475569" font-size="15">O intermediário e quem compartilha encaminham pacotes que não conseguem ler</text>
</svg>
<figcaption>A corrente. Cada celular nela encaminha o mesmo túnel criptografado.</figcaption>
</figure>

Tecnicamente, o celular intermediário exerce os dois papéis ao mesmo tempo: é cliente do celular acima e compartilhador para o celular abaixo. Cada pacote do seu celular carrega um cabeçalho que identifica sua origem, então o intermediário o encaminha, ainda criptografado, pelo seu próprio link para cima. O túnel é o mesmo descrito acima e continua terminando no servidor da Bump, então um intermediário não consegue ler mais do seu tráfego do que quem compartilha. A aprovação e as credenciais vêm do celular no topo da corrente, o que tem Internet de verdade.

A velocidade ao longo da corrente é definida pelo celular que está repassando, não pelo número de saltos. Um intermediário é cliente Wi-Fi do celular acima e dono do grupo do seu próprio grupo Wi-Fi Direct para o celular abaixo, os dois no mesmo rádio, então ele é o gargalo, ainda mais se for um aparelho barato. Nas nossas medições, um celular de entrada compartilhando uma conexão móvel entrega cerca de 50 Mbps, e um celular que está ele mesmo em Wi-Fi e compartilha esse Wi-Fi pode cair para 5 a 10 Mbps. Adicionar saltos além disso não reduz a vazão de forma perceptível, mas cada salto acrescenta latência. Espere que vídeo funcione e que chamadas e jogos sintam o atraso primeiro. Não há limite de saltos no software, e já rodamos correntes de dez saltos em testes. O limite prático é quantos celulares há por perto, não o número de saltos. Cada celular consegue atender cerca de quatro ou cinco celulares conectados diretamente, dependendo do aparelho, então a corrente se espalha como uma árvore, e não como uma única fila.

Passar adiante está no app atrás de uma configuração e vem desligado por padrão enquanto terminamos de testar em muitos aparelhos. Celulares com ele ligado e celulares com ele desligado formam redes separadas e não se veem, e é por isso que ele será ligado para todo mundo de uma vez, e não aos poucos.

## Chat sem nenhuma Internet

O Bump inclui um chat que funciona quando ninguém por perto tem Internet. As mensagens viajam por BLE diretamente quando a outra pessoa está no alcance. Quando não está, a mensagem espera numa fila no seu celular. Cada vez que seu celular encontra outro celular com o Bump, os dois trocam as mensagens em fila e as confirmações de entrega, então uma mensagem pode saltar por vários celulares antes de chegar ao destinatário, e a confirmação faz o caminho de volta do mesmo jeito. Isso é uma rede tolerante a atrasos: nada tem garantia de chegar rápido, mas continua andando enquanto as pessoas se movem.

As mensagens duram 72 horas. Um celular guarda até 100 mensagens próprias em fila e carrega até 500 de outras pessoas. Cada mensagem é criptografada para os dispositivos do destinatário com uma troca de chaves X25519 e criptografia autenticada, então os celulares que a carregam não conseguem lê-la. Cada dispositivo tem seu próprio par de chaves e assina uma declaração dizendo a qual conta pertence, e o app publica essa declaração para que outros celulares possam verificá-la quando tiverem Internet, e confiar nela no primeiro uso quando não tiverem. Se algum celular com Internet estiver disponível, o app também pode entregar pelos servidores da Bump, então uma mensagem nunca precisa esperar um encontro físico quando não é necessário.

## Limites que vale saber

- **Alcance.** Bluetooth e Wi-Fi Direct alcançam a mesma sala, prédio, praça ou ônibus. Se você consegue ver quem compartilha, quase certamente está no alcance.
- **Só Android.** O app depende das APIs de anúncio BLE e de Wi-Fi Direct do Android. Precisa do Android 11 ou mais recente.
- **Bateria.** Compartilhar mantém um grupo Wi-Fi Direct e um anunciante BLE, então gasta mais bateria do que um celular parado. Usar uma conexão custa mais ou menos o mesmo que qualquer Wi-Fi.
- **Sua operadora.** Do ponto de vista da operadora, compartilhar é o roteamento comum do celular. Alguns planos vendidos como ilimitados limitam o roteamento separadamente.

As perguntas que esta página não responde provavelmente estão nas [Perguntas Frequentes](/pt/faq/). O app é gratuito na [Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod).
