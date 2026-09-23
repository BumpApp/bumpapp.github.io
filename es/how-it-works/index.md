---
layout: article
lang: es-CO
title: "Cómo funciona Bump: Internet compartido entre celulares cercanos"
description: "La ingeniería detrás de Bump: descubrimiento por Bluetooth, una conexión Wi-Fi Direct de celular a celular y un túnel OpenVPN para que quien comparte sus datos no vea tu tráfico."
translations:
  en: /how-it-works/
  pt: /pt/how-it-works/
  es: /es/how-it-works/
---

Bump es una app de Android que permite a un celular compartir sus datos móviles o su Wi-Fi con un celular cercano, y le paga a quien comparte por los datos que pasan por él. Esta página explica cómo lo hace la app, con suficiente detalle para que un ingeniero pueda comprobar cada afirmación. Para las respuestas cortas, mira las [Preguntas Frecuentes](/es/faq/).

## La versión corta

1. Un celular que está compartiendo se anuncia por Bluetooth Low Energy (BLE). Los celulares cercanos captan el anuncio y lo muestran en una lista y en un mapa de cobertura.
2. Cuando eliges a quien comparte, tu celular abre una conexión Wi-Fi Direct con el suyo. Los datos pasan por ese enlace, no por Internet.
3. Antes de que pase cualquier tráfico tuyo, tu celular abre un túnel OpenVPN cifrado hasta un servidor de Bump. El celular de quien comparte reenvía los paquetes del túnel, pero no puede leerlos.
4. Quien comparte te aprueba y fija un límite de datos. Pagas por megabyte con créditos Bump. Esa persona gana puntos de recompensa por los mismos megabytes.

<figure>
<svg viewBox="0 0 840 230" role="img" aria-labelledby="fig1-title" style="width:100%;height:auto;font-family:Inter,system-ui,sans-serif;font-size:17px">
  <title id="fig1-title">Un salto: tu celular se conecta al celular de quien comparte por Wi-Fi Direct, y un túnel cifrado va desde tu celular, pasando por quien comparte, hasta un servidor VPN de Bump y de ahí a Internet.</title>
  <defs>
    <marker id="a1" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#475569"/></marker>
  </defs>
  <rect x="10" y="70" width="130" height="60" rx="8" fill="#0F172A"/>
  <text x="75" y="105" text-anchor="middle" fill="#fff" font-weight="600">Tu celular</text>
  <rect x="220" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="305" y="105" text-anchor="middle" fill="#fff" font-weight="600">Quien comparte</text>
  <rect x="470" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="555" y="105" text-anchor="middle" fill="#fff" font-weight="600">Servidor VPN Bump</text>
  <rect x="720" y="70" width="110" height="60" rx="8" fill="#0F172A"/>
  <text x="775" y="105" text-anchor="middle" fill="#fff" font-weight="600">Internet</text>
  <line x1="140" y1="100" x2="220" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a1)" marker-end="url(#a1)"/>
  <text x="180" y="58" text-anchor="middle" fill="#475569">Bluetooth encuentra</text>
  <text x="180" y="150" text-anchor="middle" fill="#475569">Wi-Fi Direct transporta</text>
  <line x1="390" y1="100" x2="470" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a1)" marker-end="url(#a1)"/>
  <text x="430" y="58" text-anchor="middle" fill="#475569">Datos de quien comparte</text>
  <line x1="640" y1="100" x2="720" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a1)" marker-end="url(#a1)"/>
  <line x1="75" y1="185" x2="555" y2="185" stroke="#10B981" stroke-width="6" stroke-linecap="round"/>
  <text x="340" y="215" text-anchor="middle" fill="#047857" font-weight="600" font-size="15">Túnel cifrado: solo tu celular y el servidor de Bump pueden leerlo</text>
</svg>
<figcaption>Un salto. El celular de quien comparte es un intermediario para paquetes que no puede descifrar.</figcaption>
</figure>

## Encontrar a quien comparte: Bluetooth y el mapa de cobertura

Un celular que está compartiendo se anuncia por BLE. Todo lo que el otro celular necesita para conectarse está en el propio anuncio: si quien comparte está en datos móviles, Wi-Fi o ambos, si es un punto de acceso o un intermediario, y el nombre y la contraseña de la red Wi-Fi Direct. Los celulares compatibles con los anuncios extendidos de Bluetooth 5 incluyen además el nombre de usuario de quien comparte, una estimación de velocidad y el precio por megabyte.

Los celulares que buscan Internet también se anuncian, con una marca que dice "necesito datos". Así es como el celular de quien comparte sabe que hay gente cerca que quiere conexión antes de que nadie toque nada.

Tu celular escanea continuamente mientras la app está abierta y descarta a cualquier persona que comparte de la que no tenga noticia en cinco segundos, así que la lista que ves está siempre al día. El alcance del Bluetooth es en línea de vista y corto: la misma sala, edificio, plaza o bus. Dos celulares solo se encuentran cuando cada uno está dentro del alcance del otro.

<figure>
<svg viewBox="0 0 840 310" role="img" aria-labelledby="fig-range-title" style="width:100%;height:auto;font-family:Inter,system-ui,sans-serif;font-size:17px">
  <title id="fig-range-title">Cuatro celulares con su alcance Bluetooth dibujado como círculos. A la izquierda, un celular que comparte y uno que busca están cada uno dentro del círculo del otro, así que están al alcance. A la derecha, los dos círculos no se tocan, así que esos celulares no se encuentran.</title>
  <circle cx="170" cy="150" r="90" fill="#10B981" fill-opacity="0.18" stroke="#10B981" stroke-width="2"/>
  <circle cx="240" cy="150" r="90" fill="#0EA5E9" fill-opacity="0.18" stroke="#0EA5E9" stroke-width="2"/>
  <rect x="159" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <rect x="229" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <text x="150" y="42" text-anchor="end" fill="#047857" font-weight="600">Compartiendo</text>
  <text x="260" y="42" text-anchor="start" fill="#0369A1" font-weight="600">Buscando</text>
  <text x="205" y="275" text-anchor="middle" fill="#0F172A" font-weight="600">Al alcance</text>
  <text x="210" y="298" text-anchor="middle" fill="#475569" font-size="15">Los dos celulares están en la intersección</text>
  <circle cx="520" cy="150" r="90" fill="#10B981" fill-opacity="0.18" stroke="#10B981" stroke-width="2"/>
  <circle cx="740" cy="150" r="90" fill="#0EA5E9" fill-opacity="0.18" stroke="#0EA5E9" stroke-width="2"/>
  <rect x="509" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <rect x="729" y="130" width="22" height="40" rx="4" fill="#0F172A"/>
  <text x="520" y="42" text-anchor="middle" fill="#047857" font-weight="600">Compartiendo</text>
  <text x="740" y="42" text-anchor="middle" fill="#0369A1" font-weight="600">Buscando</text>
  <text x="630" y="275" text-anchor="middle" fill="#0F172A" font-weight="600">Fuera de alcance</text>
  <text x="630" y="298" text-anchor="middle" fill="#475569" font-size="15">Ninguno de los dos oye al otro</text>
</svg>
<figcaption>Alcance. El alcance Bluetooth de cada celular es un círculo a su alrededor. Dos celulares solo se encuentran cuando cada uno está dentro del círculo del otro, lo que pone a los dos en la intersección.</figcaption>
</figure>

Bump no es un Wi-Fi para toda la ciudad, todavía. Queremos llegar ahí aumentando la cobertura, no el alcance. El mapa de cobertura nos dice dónde hay gente buscando conexión y nadie compartiendo. Nuestro programa de recompensas por ubicación ofrece premios extra a quienes comparten y se presentan en una celda específica de la ciudad en una franja horaria definida, verificado con los mismos reportes de ubicación que alimentan el mapa, para que las zonas de mayor demanda se acerquen lo más posible a una cobertura completa.

<figure>
<img src="/how-it-works/bounties.png" width="913" height="520" alt="Un mapa de calles de un barrio dividido en celdas hexagonales. Varias celdas tienen borde naranja con el número 1, una es roja, y un grupo de celdas grises y azules está a la derecha." loading="lazy">
<figcaption>Recompensas por ubicación en el mapa de nuestras herramientas de administración. Cada hexágono es una celda. Las celdas naranja son donde la gente buscó conexión y no encontró a nadie compartiendo, y el número es cuántas personas pidieron un punto de acceso ahí. Las celdas azules tienen una recompensa programada, las grises vencieron y la roja fue cancelada. Datos del mapa: Google.</figcaption>
</figure>

El mapa de cobertura se construye con reportes de ubicación que los celulares adjuntan, si la ubicación está activada, a sus registros de sesión y de búsqueda. Nuestro backend los agrupa en una entrada por dispositivo. La app pide los dispositivos vistos en los últimos 30 minutos en un radio de alrededor de un kilómetro y dibuja cada uno como un círculo pequeño, azul para oferta y rojo para demanda, actualizando cada diez segundos. Las entradas con más de 24 horas se borran.

## Conectar celular con celular: Wi-Fi Direct

Cuando eliges a quien comparte, se abren dos enlaces a la vez.

**El primero es un canal BLE L2CAP.** Está listo en uno o dos segundos y transporta unos cientos de kilobits por segundo. Es suficiente para completar el handshake, obtener las credenciales de la VPN y arrancar el túnel mientras el enlace más rápido todavía se está levantando.

**El segundo es Wi-Fi Direct.** El celular de quien comparte es el dueño del grupo de un grupo Wi-Fi Direct. Tu celular se une como una estación Wi-Fi normal, usando el nombre y la contraseña de la red que leyó en el anuncio BLE, a través de la API de sugerencia de redes de Android. Luego encuentra la dirección de quien comparte con un multicast UDP en el enlace. Esto tarda de cinco a diez segundos y transporta decenas de megabits por segundo. Cuando está listo, el túnel se reinicia sobre él y la sesión continúa.

Bump no usa el punto de acceso normal del celular. Las APIs de punto de acceso de Android o exigen hardware que pueda ser estación y punto de acceso al mismo tiempo, o no dejan que una app administre la conexión, así que Bump crea su propio grupo Wi-Fi Direct. Por eso también el celular de quien comparte sigue conectado a su propio Wi-Fi o a sus datos móviles mientras comparte.

La contraseña viaja en un anuncio Bluetooth que cualquiera al alcance puede leer. Es intencional. El enlace Wi-Fi solo transporta tráfico cifrado del túnel, y nadie recibe Internet por él hasta que quien comparte lo apruebe, así que la contraseña por sí sola no protege nada.

## El túnel: qué puede ver quien comparte y qué no

Tu celular ejecuta la biblioteca OpenVPN 3. Crea una interfaz VPN de Android que captura todo el tráfico de tu celular, incluido el DNS, y lo envía por el túnel. Los paquetes del túnel van a un proxy local en tu celular, que envuelve cada uno en un pequeño encabezado con la dirección del servidor VPN de Bump y lo envía por el enlace Wi-Fi Direct (o por el enlace BLE mientras el Wi-Fi todavía se está conectando). El celular de quien comparte lee el encabezado, abre un socket UDP normal hacia ese servidor y reenvía el paquete. Las respuestas vuelven por el mismo camino.

El celular de quien comparte nunca tiene una llave del túnel. Las credenciales funcionan así:

- Tu celular genera su propio par de llaves y una solicitud de firma de certificado. La llave privada nunca sale de tu celular.
- Firma una declaración con el ID de tu cuenta, el ID del dispositivo y la solicitud, y se la envía a quien comparte.
- El celular de quien comparte reenvía la declaración sin cambios al servidor VPN y devuelve la respuesta byte por byte.
- El servidor verifica la declaración con el servicio de directorio de Bump y firma el certificado, válido por 30 días.
- Tu celular verifica la respuesta con una llave pública incorporada en la app, comprueba que el certificado corresponde a su propia llave y al servidor esperado, y solo entonces se conecta.

Entonces quien comparte puede ver:

- La dirección del servidor VPN de Bump que estás usando.
- Cuántos bytes enviaste y recibiste, y cuándo. Por eso se le paga.
- Tu nombre de usuario y el identificador de tu dispositivo.

Quien comparte no puede ver:

- Con qué sitios, apps o servidores te estás comunicando.
- Tus consultas DNS, que van dentro del túnel.
- El contenido de cualquier cosa que envías o recibes.

Tu tráfico sale a Internet desde el servidor de Bump, no desde la conexión de quien comparte, así que nada de lo que haces parece venir de su dirección IP. El servidor de Bump es donde termina el túnel, así que es el punto que puede ver tu tráfico, exactamente como tu proveedor de Internet o cualquier servicio de VPN. No registramos qué sitios o apps visitas. Guardamos registros de conexión (qué dispositivo, qué servidor, cuándo, cuántos datos, qué IP de salida) durante 12 meses porque el Marco Civil da Internet de Brasil lo exige, y cada acceso de nuestro equipo a esos registros queda a su vez registrado. La [política de privacidad](/es/privacy-policy/) tiene los detalles.

## Quién aprueba, y los límites de datos

Nada pasa hasta que quien comparte diga que sí. Cuando pides conectarte, quien comparte recibe una notificación con tu nombre y un cuadro de diálogo donde aprueba o bloquea la solicitud y fija un límite de datos para ti. El límite puede ser cualquier cantidad, o ilimitado.

El celular de quien comparte cuenta cada byte en cada dirección por persona conectada. La app muestra el uso de cada persona frente a su límite, y permite a quien comparte subir el límite o desconectarla en cualquier momento. Cuando se alcanza un límite, la conexión se cierra con un motivo que aparece en tu celular. Lo mismo pasa si se te acaban los créditos. Quien comparte también puede dejar de compartir del todo, lo que desconecta a todo el mundo.

## Créditos y puntos de recompensa

Los dos celulares reportan sus conteos de bytes al backend de Bump durante la sesión. El backend le cobra a quien usa la conexión por megabyte, al precio de quien comparte, en créditos. Y le otorga a quien comparte puntos de recompensa por los mismos megabytes. Los créditos se compran en la app y nunca vencen. Los puntos de recompensa se convierten en dinero por Bre-B en Colombia y Pix en Brasil. Las tarifas vienen de una configuración en el servidor, no de la app, así que pueden cambiar sin una actualización. Las [Preguntas Frecuentes](/es/faq/#cuánto-cuesta-el-internet-en-bump) tienen los precios actuales y los detalles de pago.

## Pasarlo: la cadena

Un celular conectado a través de Bump también puede compartir lo que tiene con el siguiente celular. A esto lo llamamos pasarlo, o la cadena. Llega a lugares a los que el Wi-Fi de quien comparte primero no llega: el fondo de un mercado, un auditorio en el sótano, el final de un bus.

<figure>
<svg viewBox="0 0 840 250" role="img" aria-labelledby="fig2-title" style="width:100%;height:auto;font-family:Inter,system-ui,sans-serif;font-size:17px">
  <title id="fig2-title">La cadena: tu celular se conecta a un celular intermediario, que se conecta a quien comparte y tiene Internet. El túnel cifrado va desde tu celular, pasando por los dos, hasta el servidor VPN de Bump.</title>
  <defs>
    <marker id="a2" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#475569"/></marker>
  </defs>
  <rect x="10" y="70" width="130" height="60" rx="8" fill="#0F172A"/>
  <text x="75" y="105" text-anchor="middle" fill="#fff" font-weight="600">Tu celular</text>
  <rect x="200" y="70" width="160" height="60" rx="8" fill="#0F172A"/>
  <text x="280" y="97" text-anchor="middle" fill="#fff" font-weight="600">Intermediario</text>
  <text x="280" y="117" text-anchor="middle" fill="#94A3B8" font-size="14">sin Internet propio</text>
  <rect x="420" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="505" y="97" text-anchor="middle" fill="#fff" font-weight="600">Quien comparte</text>
  <text x="505" y="117" text-anchor="middle" fill="#94A3B8" font-size="14">tiene Internet</text>
  <rect x="650" y="70" width="170" height="60" rx="8" fill="#0F172A"/>
  <text x="735" y="105" text-anchor="middle" fill="#fff" font-weight="600">Servidor VPN Bump</text>
  <line x1="140" y1="100" x2="200" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a2)" marker-end="url(#a2)"/>
  <text x="170" y="58" text-anchor="middle" fill="#475569">Wi-Fi Direct</text>
  <line x1="360" y1="100" x2="420" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a2)" marker-end="url(#a2)"/>
  <text x="390" y="58" text-anchor="middle" fill="#475569">Wi-Fi Direct</text>
  <line x1="590" y1="100" x2="650" y2="100" stroke="#475569" stroke-width="2" marker-start="url(#a2)" marker-end="url(#a2)"/>
  <text x="620" y="58" text-anchor="middle" fill="#475569" font-size="15">Datos de quien comparte</text>
  <line x1="75" y1="185" x2="735" y2="185" stroke="#10B981" stroke-width="6" stroke-linecap="round"/>
  <text x="420" y="215" text-anchor="middle" fill="#047857" font-weight="600">Un solo túnel cifrado, de extremo a extremo</text>
  <text x="420" y="237" text-anchor="middle" fill="#475569" font-size="15">El intermediario y quien comparte reenvían paquetes que no pueden leer</text>
</svg>
<figcaption>La cadena. Cada celular en ella reenvía el mismo túnel cifrado.</figcaption>
</figure>

Técnicamente, el celular intermediario cumple los dos papeles a la vez: es cliente del celular de arriba y comparte hacia el celular de abajo. Cada paquete de tu celular lleva un encabezado que identifica su origen, así que el intermediario lo reenvía, todavía cifrado, por su propio enlace hacia arriba. El túnel es el mismo descrito antes y sigue terminando en el servidor de Bump, así que un intermediario no puede leer más de tu tráfico que quien comparte. La aprobación y las credenciales vienen del celular en la cima de la cadena, el que tiene Internet de verdad.

La velocidad a lo largo de la cadena la fija el celular que está reenviando, no cuántos saltos hay. Un intermediario es cliente Wi-Fi del celular de arriba y dueño del grupo de su propio grupo Wi-Fi Direct para el celular de abajo, los dos en la misma radio, así que es el cuello de botella, y más si es un equipo barato. En nuestras mediciones, un celular de gama baja compartiendo una conexión móvil da alrededor de 50 Mbps, y un celular que está él mismo en Wi-Fi y comparte ese Wi-Fi puede bajar a entre 5 y 10 Mbps. Añadir saltos más allá de eso no reduce el caudal de forma notable, pero cada salto añade latencia. Espera que el video funcione y que las llamadas y los juegos sientan el retraso primero. No hay límite de saltos en el software, y hemos probado cadenas de diez saltos. El límite práctico es cuántos celulares hay alrededor, no el número de saltos. Cada celular puede atender a unos cuatro o cinco celulares conectados directamente, según el equipo, así que la cadena se extiende como un árbol y no como una sola fila.

Pasarlo está en la app detrás de un ajuste y viene apagado por defecto mientras terminamos de probarlo en muchos equipos. Los celulares que lo tienen encendido y los que lo tienen apagado forman redes separadas y no se ven entre sí, y por eso se activará para todo el mundo a la vez y no poco a poco.

## Chat sin nada de Internet

Bump incluye un chat que funciona cuando nadie cerca tiene Internet. Los mensajes viajan por BLE directamente cuando la otra persona está al alcance. Cuando no lo está, el mensaje espera en una cola en tu celular. Cada vez que tu celular se encuentra con otro celular con Bump, los dos intercambian los mensajes en cola y las confirmaciones de entrega, así que un mensaje puede saltar por varios celulares antes de llegar a su destinatario, y la confirmación hace el camino de vuelta de la misma forma. Esto es una red tolerante a retrasos: nada tiene garantía de llegar rápido, pero sigue avanzando mientras la gente se mueva.

Los mensajes duran 72 horas. Un celular guarda hasta 100 mensajes propios en cola y lleva hasta 500 de otras personas. Cada mensaje se cifra para los dispositivos del destinatario con un intercambio de llaves X25519 y cifrado autenticado, así que los celulares que lo llevan no pueden leerlo. Cada dispositivo tiene su propio par de llaves y firma una declaración que dice a qué cuenta pertenece, y la app publica esa declaración para que otros celulares puedan verificarla cuando tengan Internet, y confiar en ella en el primer uso cuando no. Si hay algún celular con Internet disponible, la app también puede entregar a través de los servidores de Bump, así que un mensaje nunca tiene que esperar un encuentro físico cuando no hace falta.

## Límites que vale la pena saber

- **Alcance.** Bluetooth y Wi-Fi Direct llegan a la misma sala, edificio, plaza o bus. Si puedes ver a quien comparte, casi seguro estás al alcance.
- **Solo Android.** La app depende de las APIs de anuncios BLE y de Wi-Fi Direct de Android. Necesita Android 11 o más reciente.
- **Batería.** Compartir mantiene un grupo Wi-Fi Direct y un anunciante BLE, así que gasta más batería que un celular en reposo. Usar una conexión cuesta más o menos lo mismo que cualquier Wi-Fi.
- **Tu operador.** Desde el punto de vista del operador, compartir es el anclaje a red normal del celular. Algunos planes vendidos como ilimitados limitan el anclaje por separado.

Las preguntas que esta página no responde probablemente están en las [Preguntas Frecuentes](/es/faq/). La app es gratis en [Google Play](https://play.google.com/store/apps/details?id=xyz.bumpapp.prod).
