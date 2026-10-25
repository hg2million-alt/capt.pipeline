# Hospedagem — Hotel Master (pack com 5 demos)

Pack comprado "Hotel Master" — na origem, um tema **WordPress** de hotel
exportado como HTML estático, em **5 pacotes independentes** (~85 páginas
cada, a maioria vitrine de shortcode). Aqui virou **5 demos enxutos de 8–9
páginas**, todos com a mesma estrutura de páginas, reserva e contato pelo
WhatsApp, e cada um com a sua cara. O cliente recebe **só um** —
`personalizar.sh` pede o demo primeiro, igual ao `tech-luminex/`.

**Peso:** 21 MB no total (19 MB de `html/` + 2,2 MB de `preview/`). Por demo:
3,4–4,0 MB · **Stack:** HTML estático + jQuery 1.12 + jQuery UI Datepicker +
Master Slider (hero) + FlexSlider + Fancybox + Superfish/dl-menu (menu) +
Isotope · Font Awesome 4.6 local · Google Fonts via CDN (Merriweather, Open
Sans, Droid Serif) · **Build:** nenhum — abre direto, sem npm

---

## Qual demo pra qual cliente

| Demo | Serve pra | Cara | Acento original | Peso |
|---|---|---|---|---|
| `masterhotel` | **Hotel de cidade pequena, pousada "clássica"** | Claro, sóbrio. Barra preta no topo (endereço + redes + WhatsApp), header branco, layout *boxed* (fundo com textura nas laterais em tela larga) | caramelo `#B89F80` | 3,4 MB |
| `masterhotel-dark` | **Pousada charmosa / hotel boutique** que quer parecer mais "premium" | Mesmo DNA do anterior em fundo preto, logo centralizado, busca de datas numa faixa marrom-escuro logo abaixo do hero, 3 cards de destaque | caramelo `#B89F80` | 3,5 MB |
| `hostel` | **Hostel, albergue, pousada jovem/de mochileiro** | Header transparente sobre o hero, verde-água, 6 ícones de serviço na home, faixa de contadores, busca por **nº de hóspedes** (não adultos/crianças) | verde-água `#1ABC9C` | 4,0 MB |
| `modern` | **Hotel com mais de uma unidade** (ex.: duas pousadas do mesmo dono) | Header laranja cheio, seletor **"Unidade"** na busca e seção "Nossas unidades" na home | laranja `#FF8432` | 3,8 MB |
| `apartment` | **Chácara / sítio / casa de temporada / flat por diária** | Header cinza-escuro, hero com "Desde R$ [PREÇO] / NOITE", lista de acomodações no formato **"casa inteira"** (tipo · hóspedes · quartos · camas · preço/noite), página de Estrutura | amarelo `#FBAD24` + marinho `#32435B` | 3,7 MB |

- **Chácara de aluguel pra fim de semana/evento → `apartment`.** É o único
  demo cuja lista de acomodações fala "casa inteira / N hóspedes / N quartos"
  em vez de "quarto com cama king".
- **Pousada com 1 unidade → `masterhotel` ou `masterhotel-dark`**
  (rotacionar entre os dois; o `hostel` também serve pra pousada simples se
  tirar os contadores). **Não usar `modern` pra quem tem uma unidade só**
  sem apagar o seletor "Unidade" e a seção "Nossas unidades".
- **`masterhotel-dark` ficou como demo separado, não como opção de script.**
  Não é só a versão escura do `masterhotel`: a home tem outro layout (logo
  centralizado, busca em faixa própria, cards de destaque, quartos sobre
  imagem de fundo) e o CSS gerado pelo tema é outro arquivo. Virar opção do
  script exigiria mesclar dois `style-custom.css` — manter a pasta (3,5 MB)
  foi o mais simples.

**Para que NÃO serve:**

- **Reserva online de verdade** (disponibilidade em tempo real, pagamento,
  motor de reserva). O pack original dependia do plugin de reserva do
  WordPress (`admin-ajax.php`); aqui não existe back-end — **tudo sai pelo
  WhatsApp** (ver Formulários). Se o cliente já usa Booking/Airbnb/motor
  próprio, o botão tem que apontar pra lá.
- **Resort/rede grande** com dezenas de quartos, filtros, spa, restaurante
  com cardápio — a lista de acomodações é estática, sem filtro.
- **Marketplace de várias casas de donos diferentes** (estilo Airbnb).

## Páginas (as mesmas nos 5 demos)

| Arquivo | O que é | Origem no pack |
|---|---|---|
| `index.html` | Home: hero (Master Slider) + busca de datas + acomodações + galeria + depoimento | `index.html` |
| `sobre.html` | Institucional (3 colunas, história, barras de "skill", ícones, faixa de CTA) | `about-us.html` |
| `acomodacoes.html` | Lista de quartos/casas com preço e "Ver detalhes" | `room-classic-3-columns.html` (no `apartment`: `room-medium-thumbnail.html`) |
| `acomodacao.html` | Detalhe de uma acomodação: fotos, comodidades, valores, descrição, mapa + reserva lateral | `singleroom.html` |
| `estrutura.html` | **Só `hostel` e `apartment`** — grade de serviços/comodidades com ícone + contadores + depoimento | `services-facilities.html` |
| `galeria.html` | Grade 3 colunas com legenda + lightbox | `gallery-3-columns-with-caption.html` |
| `reserva.html` | Formulário de datas/quartos/hóspedes + calendário de 2 meses → WhatsApp | `booking.html` (`hostel`: `hostel-booking.html`) |
| `contato.html` | Mapa + formulário → WhatsApp + informações + redes | `contact-page.html` |
| `novidades.html` | Blog em 3 colunas — **só com post falso**, fora do menu, alcançado por "Ver todas as novidades" na home | `blog-3-columns.html` |

**Menu** (reescrito, igual em todos): Início · Sobre · Acomodações ·
[Estrutura] · Galeria · Reservas · Contato. O mega-menu original (Pages,
Rooms, Reservation, Blog, Shortcodes, Portfolio… ~70 links) e a busca do
header saíram. **Rodapé** também foi reescrito do zero (Reservas: WhatsApp +
e-mail + redes · Navegue: links do menu · Onde estamos: endereço + check-in/
check-out). Todo link interno aponta pra página que existe (conferido por
script: 0 referência quebrada nos 5 demos).

**Curadoria:** mantidas **42 páginas** (8 × 3 demos + 9 × 2) das **430** do
pack; **388 apagadas** — ~45 vitrines de shortcode (button, divider,
accordion, audio, column, tabs, table, typography, progress…), 14 variações
de portfolio, 16 de blog, 9 de galeria, 13 de lista de quartos, 2º contato,
páginas de filial (`london`, `paris-branch`, `new-york-branch` no modern),
`personnel`, `price-table`, `8-bed-male-dorm` etc. Links que apontavam pra
elas foram remapeados (quarto → `acomodacao.html`, lista → `acomodacoes.html`,
blog/post/categoria → `novidades.html`, filial → `acomodacoes.html`).

## Como personalizar

```bash
templates/sites/hospedagem-hotelmaster/personalizar.sh <demo> <destino> '#COR' 'Nome do Cliente' ['#COR2']
# ex.:
templates/sites/hospedagem-hotelmaster/personalizar.sh apartment \
  /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Chácara Recanto Verde'
```

- `<demo>`: `masterhotel`, `masterhotel-dark`, `hostel`, `modern`, `apartment`
- `#COR2` (opcional) só vale no `apartment`: troca o azul-marinho secundário
  (caixinha de data dos posts, setas do carrossel, botão da reserva lateral).
  Sem ela, o marinho fica — funciona como neutro escuro.
- Copia **só** o demo escolhido pro destino (o original nunca é tocado —
  testado com md5 antes/depois), troca a família de cor da marca, troca
  `[NOME DO CLIENTE]` em todo HTML/JS (com escape de HTML e de aspas no JS —
  testado com `Chácara D'Ajuda & Cia`) e imprime a lista do que falta na mão.
- **Precisa de `node`** no PATH (já é requisito do Vercel CLI).

Mostrar os previews de `preview/` (`<demo>-<página>.jpg`, 32 prints de
1440×1000 do topo de cada página) pro cliente/usuário escolher o demo.

## Onde ficam as cores da marca

Não há CSS variable. O painel do tema WordPress **gerou** a paleta em
`css/style-custom.css` com **muitos tons derivados** da cor de marca (hover,
borda, tint claro, sombra do botão, barra de reserva, dia selecionado no
calendário, etapa ativa da reserva…), como hex cru — mais alguns
`style="background-color:#…"` inline em `sobre.html`, `contato.html` e
`index.html`, e 1–2 em `css/style.css`/`css/custom.css`.

| Demo | Base | Tons derivados | Onde |
|---|---|---|---|
| `masterhotel` | `#B89F80` | 20 tons (de `#7B6549` a `#EAE0D4`) | style-custom.css (~70 usos) + inline |
| `masterhotel-dark` | `#B89F80` | 24 tons (inclui `#322B23`, fundo marrom-escuro da faixa de busca, inline na home) | idem |
| `hostel` | `#1ABC9C` | 14 tons (`#006847` a `#BAEFE2`) | idem + custom.css |
| `modern` | `#FF8432` | 23 tons (`#7A2413` a `#FFE2CF`) | idem |
| `apartment` | `#FBAD24` + `#32435B` | 5 + 4 tons | idem + custom.css |

A lista exata de tons de cada demo está no `case` do `personalizar.sh`. Ela
foi levantada contando os hex do CSS por matiz/saturação e **conferida por
screenshot** depois da troca (5 demos personalizados com 5 cores diferentes,
nenhum resto visível da cor antiga). O script recalcula cada tom em HSL
mantendo a relação de claro/escuro e saturação com a base — por isso o
hover continua mais escuro, o tint continua claro etc.

Ficam **de fora de propósito** (padrão do tema, iguais nos 5 demos, não são
marca): `#51392B`, `#E36D39`, `#F5BE3B`, `#1F242C`, `#D65938`, `#963A20`,
`#D57F5C`, `#B28855`, `#C23030`, os azuis `#72AFD5/#81BAD3/#4A87A2/#389EC5`,
e as cores de botão de shortcode em `custom.css`. No `modern`/`hostel`
sobram 1–3 `#B89F80` em seletores de WooCommerce — sem efeito nestas páginas.

Cor de marca **não** aparece em PNG/SVG: os ícones são Font Awesome (fonte)
e herdam a cor do CSS. Logo virou texto (ver abaixo).

## Formulários → WhatsApp

`js/whatsapp.js` (novo, em todos os demos) substitui os dois back-ends do
pack que não rodam na Vercel: o plugin de reserva do WordPress
(`admin-ajax.php`) e o Quform (PHP) do contato.

- Busca de disponibilidade (home), reserva lateral (acomodação), página de
  reserva e formulário de contato **montam a mensagem com os campos** e abrem
  `https://wa.me/[WHATSAPP]?text=…`. Ex.: "Olá, Pousada X! Vim pelo site e
  gostaria de consultar a disponibilidade. Acomodação: … Entrada: 28 set 2026
  Saída: 29 set 2026 Noites: 1 Quartos: 1 Adultos: 2 Crianças: 0".
  Testado clicando nos 4 formulários em 3 demos (nenhum POST sai da página).
- Intercepta em fase de captura — roda antes do JS do tema, que tentaria o
  AJAX. **Trocar `[WHATSAPP]` no topo do arquivo** pelo número só com dígitos
  (DDI+DDD: `5533999999999`).
- Todo `<a class="js-whatsapp">` (barra do topo, rodapé, redes) vira link
  `wa.me` com mensagem padrão.
- O pack vinha com **datas fixas de 2018** nos campos; o script puxa entrada
  pra hoje e saída pra amanhã quando ficaram no passado. Calendário e nomes
  de mês/dia estão em português (locale do datepicker trocado).
- A página de reserva era um assistente de 4 passos (datas → quarto → dados
  → confirmação) via AJAX; ficou com 3 passos **cosméticos** ("1. Escolha as
  datas · 2. Envie pelo WhatsApp · 3. Confirmamos com você") e o calendário
  de 2 meses é só visual.

## Foto real vs. placeholder

**Nenhuma foto real.** Todo `<img>` e todo fundo de seção é placeholder cinza
com a medida escrita (`upload/*.jpg` — "1300x871", "700x400"…). Trocar
mantendo o nome do arquivo, ou apagar a seção. Exceções que **não** são
placeholder, mas também não são do cliente: o fundo do título de página
(`images/page-title-background.jpg` / `upload/page-title*.jpg` — montanha
nevada em cinza, foto de banco) e a textura do fundo *boxed* do `masterhotel`
(`upload/bg-pattern.png`). Trocar a montanha pela foto do cliente — montanha
nevada em pousada mineira não faz sentido.

## Armadilhas

- **Corpo do texto continua em inglês/lorem.** Traduzido: menu, rodapé,
  títulos de página, formulários, calendário, títulos das seções da home e os
  textos do hero. Continua em inglês: nomes dos quartos ("Superior Room – Two
  Double Beds", "Penthouse Apartment in London"), comodidades ("Wifi: Free",
  "Elevator: No"), cards ("Perfect for relaxing", "Middle of downtown",
  "Free airport transfer"), "Story about us", "Travel Plan Mag" e todo lorem.
- **Preço em dólar e inventado** em todo lugar: "$80.00 / Night" nos cards,
  "Extra people $50", "Security Deposit $50", "Parking $20 / Car / Night",
  "Cleaning Fee $17". Trocar por R$ que o cliente deu ou apagar a linha.
  O hero do `apartment` já traz "R$ [PREÇO] / NOITE".
- **Depoimentos e números fictícios**: "Angelina Cole, Traveller", "John
  Smith", "Pam Pamelar"; contadores "2800 guests / 35000 opening hours /
  99.9% satisfaction / 100% will come back" (hostel home e página Estrutura
  do hostel/apartment). Apagar ou marcar ilustrativo — nunca publicar como
  dado real. Posts de `novidades.html` e do bloco "Novidades" da home
  (autor "John Doe") são falsos — apagar a página e o bloco se o cliente não
  tiver novidade de verdade.
- **Placeholders a preencher** (o script só preenche o nome): `[TELEFONE]`,
  `[EMAIL]`, `[ENDEREÇO]`, `[INSTAGRAM]`, `[FACEBOOK]`, `[WHATSAPP]`,
  `[HORÁRIO]`, `[HORÁRIO DE ATENDIMENTO]`, `[FRASE DE DESTAQUE]`,
  `[DIFERENCIAL 1]`, `[DIFERENCIAL 2]`, `[FRASE SOBRE O DIFERENCIAL]`,
  `[NOME DA ACOMODAÇÃO]`, `[PREÇO]`, `[UNIDADE 1/2/3]` (modern). Não há
  domínio (`[SITE]`) no pack — nenhuma página citava URL própria.
- **Mapa**: o original usava Google Maps JS com **API key do autor** (e um
  plugin WordPress de mapa). Trocado por `<iframe>` sem chave
  (`maps.google.com/maps?q=[ENDERE%C3%87O]&output=embed`) em `contato.html` e
  `acomodacao.html` — com o placeholder na URL o mapa mostra um lugar
  aleatório; trocar pelo endereço real url-encoded, ou apagar o `.hm-mapa`.
- **Bloco "Vídeo" da home** (`masterhotel`, `modern`) é um iframe de um
  vídeo qualquer do Vimeo (`player.vimeo.com/video/56815898`) — trocar pelo
  vídeo do cliente ou apagar o bloco.
- **Hero é Master Slider: textos são camadas com posição absoluta.** Texto
  mais longo que o original pode encavalar (o "UM REFÚGIO" do `apartment` foi
  escolhido curto por isso; o nome do cliente no hero encolhe junto com o
  slider no celular e fica miúdo, e o logo em texto quebra em 2 linhas a
  partir de ~18 caracteres). Testar em ~390px depois de preencher. Os
  slides 2 e 3 (Spa/Dining no masterhotel/modern) viraram
  `[DIFERENCIAL 1/2]` — apagar o slide se não houver diferencial real.
- **Logo é texto** (`<a class="hm-logo-texto">`, estilo em
  `css/cliente.css`). Os PNGs originais tinham "HOTEL MASTER" desenhado (e
  5 estrelas de classificação no `masterhotel`) — apagados. Se o cliente
  tiver logo, trocar o `<a>` por `<img>`.
- **`modern` é pra rede**: seletor "Unidade" na busca (o JS do tema bloqueia
  o envio se ficar vazio — o `whatsapp.js` passa por cima, mas o campo
  continua lá) e seção "Nossas unidades". Pra 1 unidade, apagar
  `.gdlr-resv-branches-combobox` e a seção. O `modern` mostra a data como
  `2026-09-28` (formato do tema), os outros como "28 set 2026".
- **`apartment`**: a lista de acomodações tem **sidebar de blog** (posts
  recentes, "Recent works", categorias) com links mortos (`#`) — apagar a
  sidebar ou trocar por um CTA de reserva. A página de detalhe não tem slider
  de foto principal (o estilo "new style" usa a foto no fundo do título).
- **Layout *boxed* do `masterhotel`**: em tela larga o site fica numa caixa
  de 1220px com textura nas laterais — é do tema, não bug.
- **Formulário de contato não pede e-mail** — foi trocado por Nome /
  Telefone / Mensagem, já que a resposta vai pelo WhatsApp.
- **Sem `vercel.json`** — criar com `"framework": null`. Projeto Vercel com
  slug do cliente (skill `vercel-cliente-novo`).

## O que foi removido do pack

- **Autor/licença/marketplace**: cabeçalho de tema WordPress no
  `css/style.css` (Theme Name, Theme URI e Author do autor, License), menções
  ao autor em comentários de CSS (flexslider, superfish, sumário do
  style.css), links pro perfil do autor no marketplace (ícones sociais do
  `modern`/`masterhotel-dark`), links pro site de demonstração do autor (404,
  logo, "booking", scripts de IE), 3 e-mails do autor/tema (rodapé, contato e
  detalhe do quarto), perfil de Facebook do autor, **Google Maps API key do
  autor**, plugin de mapa
  do WordPress, Quform (PHP, com PHPMailer), `js/admin-ajax.php`, zip solto
  `PH-*.zip` (218 arquivos) do `myapartment`, pasta `documentation/` com
  "how to rate your purchased files.png", logos com "HOTEL MASTER" desenhado,
  widget "Our Awards" (selo "Hotel Master Award 2017"), textos do hero
  "The best hotel reservation WordPress theme"/"Wordpress Theme On Earth".
  Grep final `-i` pelo marketplace, pelo nome do autor e por `designed by|template by`
  = 0.
- **Ficaram (terceiros, não do autor do template)**: cabeçalhos de licença
  de jQuery, jQuery UI, jQuery Migrate, Easing, Transit, dl-menu, Fancybox,
  FlexSlider, Superfish, Font Awesome, reset5 (MIT/GPL/OFL) e o do **Master
  Slider** (Averta, "Copyright © 2016 All Rights Reserved" — plugin de slider
  embutido pelo tema). `copyright`/`author` que sobram no grep são nome de
  classe CSS (`.copyright-wrapper`, `.testimonial-author`, `.blog-author`).
- **Entulho**: 388 páginas (ver Curadoria), busca do header (`action="#"`),
  plugins não usados (quform, google-map-plugin, easy-pie-chart, gdlr-hotel
  duplicado, mediaelement), JS soltos sem referência, e toda imagem de
  `upload/`/`images/` que nenhuma página mantida cita — de **88 MB** pra
  19 MB. `lang="pt-BR"` e `<title>` com `[NOME DO CLIENTE]` em todas as
  páginas; caminhos com contrabarra do Windows (`css\style.css`) viraram `/`.

## Preview

`preview/<demo>-<página>.jpg` — 1440×1000, topo de cada página:
index, sobre, acomodacoes, acomodacao, reserva, contato (+ estrutura no
hostel/apartment). Todos com placeholders (`[NOME DO CLIENTE]`, fotos
cinza), cor original de cada demo.

## Já usado em

Nenhum cliente ainda — entrou na biblioteca em 28/09/2026.
