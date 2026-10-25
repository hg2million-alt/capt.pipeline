# Hospedagem — Boostay

Template multi-página de hotel/pousada, comprado como "Boostay — Hotel
Booking HTML5 Template". Nesta cópia: **9 páginas** (4 homes + 5 internas),
base **dourado `#AF8C3E` + azul-marinho `#0E1730`**, título em Marcellus +
corpo em Open Sans (Google Fonts).

**Peso:** 9,3 MB em `html/` (7,2 MB são o Font Awesome Pro completo; as
imagens somam 0,9 MB porque são todas placeholder) · **Stack:** HTML estático
+ Bootstrap 5 + jQuery 3.6 + jQuery UI (calendário) + Swiper + Slick +
Nice Select + Magnific Popup + Isotope/Masonry + WOW.js/animate.css ·
**Build:** nenhum — abre direto, sem npm/node. O `.scss` fonte do pacote foi
removido (o HTML só carrega o `main.css` compilado).

---

## Para que serve

Negócio de **hospedagem pequeno do interior**: pousada, hotel de cidade
pequena, chácara/sítio de aluguel de fim de semana ou pra eventos. O que ele
tem de útil pra esse nicho: barra de reserva (check-in / check-out / quartos
/ hóspedes) que abre o WhatsApp já com as datas, grade de acomodações com
página de detalhe, galeria, página de eventos (casamento, confraternização,
reunião) e contato com mapa.

**Qual home escolher** (o `personalizar.sh` recebe como 4º argumento):

| Home | Visual | Melhor para |
|---|---|---|
| `index.html` | Claro, hero dividido (texto + foto), header branco | **Hotel de cidade / pousada urbana** — o mais "comercial": grade de 6 quartos com preço, galeria com filtro, serviços em lista, FAQ |
| `index-5.html` | Marinho + creme, hero cheio com slider, barra de reserva arredondada | **Pousada / hotel pequeno** com cara mais acolhedora — galeria, serviços (wifi, café, jantar), "sobre" com contadores, carrossel de acomodações, eventos |
| `index-3.html` | Creme/pêssego, "cottages", ícones de trilha/bike/guia | **Chácara, sítio, pousada rural / de montanha** — o original chamava de "Mountain Hotel": chalés, natureza, vídeo, galeria, depoimentos |
| `index-2.html` | Escuro no hero, header pílula marinho, blocos de "facilities" | **Chácara pra eventos / espaço de festa com hospedagem** — tem seção de eventos (buffet, casamento, reunião) e CTA "Reserve pelo WhatsApp" em destaque |

Regra prática: **pousada/hotel → `index` ou `index-5`; chácara/sítio →
`index-3`; chácara que vive de evento → `index-2`**.

**Para que não serve:** rede/resort grande com motor de reservas de verdade
(aqui não há disponibilidade, pagamento nem calendário por quarto — tudo cai
no WhatsApp); restaurante (a página de restaurante do pacote foi removida —
usar a categoria Alimentação); aluguel por temporada tipo Airbnb com vários
imóveis em cidades diferentes (a home "Popular Locations: Asia/America/Europe"
foi removida).

## Páginas

Preview de todas em [`preview/`](preview/) (1440×1000, topo da página).

| Página | O que tem |
|---|---|
| `index.html`, `index-2.html`, `index-3.html`, `index-5.html` | 4 homes (ver tabela acima). O menu de todas as páginas aponta só pra `index.html` — o `personalizar.sh` copia a home escolhida por cima dela e apaga as outras 3 no destino |
| `about-us.html` | Sobre + contadores + depoimento + FAQ (accordion) |
| `room.html` | Barra de reserva + grade de acomodações (cards com cama/hóspede/banheiro e estrelas) |
| `room-details.html` | Detalhe da acomodação: foto, lista de comodidades, sidebar "Reservar" (datas + quartos/adultos/crianças → WhatsApp), "valor sob consulta" |
| `event.html` | Eventos: 2 blocos (espaço de reunião / cerimônia) com capacidade + cards de serviços de evento |
| `contact.html` | Endereço / e-mail / telefone, mapa do Google (sem API key) e formulário → WhatsApp |

**Removidas desta cópia:** `index-4.html` ("Sea Hotel" — praia, "Popular
Locations: Asia/America/Europe", "Maldives Luxury, Prices From $195"),
`index-6.html` ("City Hotel" escuro com blog, restaurante e faixa de logos
de "parceiros" genéricos), `resturent.html` (cardápio com botão de carrinho),
`blog.html`, `blog-details.html`, `cart.html`, `account.html` (loja/login,
sem uso) e `mail.php`. Menu, rodapé e o menu mobile foram reescritos do zero
em pt-BR sem links pra elas (o menu original ainda tinha 3 links mortos de
fábrica: `faq.html`, `service.html`, `service-details.html` — não existiam
nem no pacote). A seção "Our Restaurant" da `index-2` (30 cards de prato com
abas Sea Foods/Beef Pizza/Steak House, todos linkando pro blog) também saiu.

---

## Como usar

```bash
cd templates/sites/hospedagem-boostay
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Pousada XYZ'

# escolhendo a home (index | index-2 | index-3 | index-5):
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Chácara XYZ' index-3

# trocando também a cor escura (header, rodapé, títulos, seções escuras):
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2E7D32' 'Chácara XYZ' index-2 '#1B2A1F'
```

O script copia `html/`, troca a cor em todos os lugares onde ela vive
(CSS, SVG inline, PNG, logo), troca o nome, gera um banner em gradiente
da marca pras páginas internas (o original era placeholder cinza), apaga
as homes não escolhidas e imprime a lista do que falta fazer à mão. O
original nunca é alterado. Precisa de `python` com **Pillow** pra recolorir
os ícones PNG e o logo — sem Pillow ele avisa e deixa esses em dourado.

Testado em 28/09/2026 com `'#2E7D32' 'Pousada Recanto & Sol' index-3
'#1B2A1F'` e `'#8B5E34' 'Chácara Pé de Serra'`: 0 ocorrência de `#AF8C3E`
e de `[NOME DO CLIENTE]` no destino, nome com `&` e acento corretos,
`html/` intacto (md5 igual antes/depois).

## Onde fica a cor de marca

Conferido por screenshot: **o dourado é a marca** (todo botão, CTA
"Reservar", ícone, preço, destaque de título); o marinho é a cor escura de
apoio (header em pílula das páginas internas, rodapé, títulos). As duas
vivem em mais lugares do que o `:root` sugere:

| Cor | Onde | Usos |
|---|---|---|
| `#AF8C3E` dourado | `--rr-theme-primary` no `:root` de `assets/css/main.css` | 238 `var()` |
| | hex cru no mesmo `main.css`, fora do `:root` | 25 |
| | `fill="#AF8C3E"` em SVG inline no HTML (ícones de `room-details`, `event`, `index-2`, `about-us`, `index`) | 57 |
| | **PNG desenhado**: `imgs/about/1.png`, `2.png`, `s.png`, `imgs/feature/1.png`, `2.png`, `3.png` | 6 arquivos |
| | **PNG em base64 dentro do SVG** do logo (`logo.svg`, `logo-3.svg`) e do `favicon.svg` — o ícone de prédio | 3 arquivos |
| `#0E1730` marinho | `--rr-heading-primary1` + hex cru em `main.css` | 29 (+29 `var()`) |
| | SVG inline no HTML | 92 |
| | SVG em `assets/imgs/` (texto do `logo.svg`, ícones) | 6 |
| | `rgba(14, 23, 48, X)` | 3 |
| | `#0E0A24` — fundo do menu mobile (offcanvas) | 1 |
| | **Imagem**: `imgs/room/bg.jpg` e `imgs/service/bg.png` (fundos marinho com textura, só na `index-5`) | 2 arquivos |

O `personalizar.sh` troca tudo isso (o marinho só com o 5º argumento).
Não mexe em: `#00061D` (quase preto, cor de título), creme/pêssego da
`index-3` (`#FEF0D7`, `#FBF9F4` — neutro quente, combina com qualquer
cor), e o `#FFFA90`/`#777620` do dia de hoje no calendário (padrão do
jQuery UI).

Fontes: `@import` do Google Fonts no topo do `main.css` (linha ~105).
**Título trocado de ZCOOL XiaoWei para Marcellus nesta cópia** — ZCOOL é
uma fonte chinesa sem `ç ã õ`: em "Acomodação" o "ção" caía em fonte reserva
e ficava visivelmente diferente (só aparece em screenshot, não em grep).

---

## Formulários (`assets/js/wa-forms.js`)

No pacote original **nenhum formulário enviava nada**: as barras de reserva
eram `<div>` com um link "Search Now" apontando pra `room.html`; o contato
não tinha nem `<form>` (inputs soltos, botão linkando pra `room.html`, e o
parágrafo falava de conserto de **carro** — "For your car we will do
everything advice, repairs"); o `mail.php` mandava pro `support@envato.com`
com remetente do autor (e PHP `mail()` não roda na Vercel de qualquer jeito).

Agora todos abrem `https://wa.me/[WHATSAPP]?text=...` com a mensagem
montada a partir dos campos — marcação por atributo, não por id:

- `[data-wa="reserva"]` — barras de reserva das 4 homes, `room.html` e a
  sidebar do `room-details.html` (check-in, check-out, quartos, hóspedes /
  adultos / crianças)
- `[data-wa="contato"]` — formulário do `contact.html` (nome obrigatório,
  e-mail, telefone, assunto, mensagem)
- `[data-wa-campo="Rótulo"]` em cada campo, `[data-wa-enviar]` no botão

Calendário em pt-BR (`dd/mm/aaaa`, meses/dias em português, sem datas
passadas) configurado em `assets/js/main.js`. **`[WHATSAPP]` precisa ser
trocado também dentro do `wa-forms.js`** (o `personalizar.sh` não preenche —
só dígitos, DDI+DDD, ex. `5533999999999`). Os botões "Reservar" do header,
do menu mobile e do rodapé são link `wa.me` direto.

Testado com Playwright: as 7 barras/formulários geram a mensagem certa
(ex.: "Olá! Vim pelo site e quero consultar disponibilidade. / Check-in:
10/10/2026 / Check-out: 12/10/2026 / Hóspedes: 4 hóspedes"); contato vazio
não abre o WhatsApp e foca o campo Nome.

## Mobile

As barras de reserva da `index`, `index-3` e `index-5` eram **escondidas
abaixo de 992px** pelo tema (`display: none`) — no celular sumia o CTA
principal da página. Corrigido no fim do `main.css`: a barra empilha em 2
colunas com o botão "Consultar" em largura total. Sem overflow horizontal
em 390px nem em 1440px nas 9 páginas, sem erro de JS.

## Placeholders

`[NOME DO CLIENTE]` (título, meta description, logo SVG, rodapé, alguns
títulos de seção), `[WHATSAPP]`, `[TELEFONE]`, `[EMAIL]`, `[ENDEREÇO]` (texto
e mapa), `[CIDADE]` (hero e "sobre" da `index-5`), `[INSTAGRAM]`,
`[FACEBOOK]` (rodapé e menu mobile). E-mail e site têm placeholder próprio —
o replace de nome não toca neles.

---

## Armadilhas

- **Zero foto real.** As 119 imagens restantes são placeholder cinza com a
  medida escrita ("944X840", "1920X590", "410X320") ou textura/ícone
  genérico. Não há foto de banco de quarto, piscina ou pessoa — sem foto
  real do cliente, o demo fica com cara de maquete. Trocar mantendo o nome
  do arquivo preserva o layout. O banner das páginas internas vira gradiente
  da marca pelo script; o resto não.
- **Logo é texto provisório.** `logo.svg` (header claro, só `index`/`index-5`)
  e `logo-3.svg` (header pílula, rodapé, menu mobile) = ícone de prédio +
  nome em `<text>` Georgia. O SVG cresce com o nome (17 px/letra) e o CSS
  limita a 280 px no header (210 px no celular) — nome muito longo fica
  pequeno. Com logo real do cliente, substituir os dois arquivos e o
  `favicon.svg`. O ícone de prédio é genérico: pra chácara talvez nem caiba.
- **Corpo em inglês/lorem.** Menu, rodapé, formulários, barras de reserva,
  títulos das páginas internas e alguns títulos de seção já estão em pt-BR.
  O resto ("Making travel dreams come true us", "Where Comfort Meets
  Convenience", FAQ, cards de serviço, "Stay In Style Pay With A Smile")
  continua em inglês ou lorem ipsum — reescrever com o tom do
  `identidade.md`, não traduzir literal.
- **Preço em dólar chutado** nos cards de quarto (`$120/day`, `$110/day`...)
  e de evento (`$120 / day`). `room-details` já diz "Valor sob consulta"
  (os extras "Room Clean $12/Night", "Massage", "Day Spa" e o "Total Cost
  $299" foram removidos). Sem tabela real, apagar o preço do card.
- **Números e selos inventados**: "14+ Years of experience", "800+ Luxury
  Apartment", "600+ Modern Bedroom", "100+ Award Winning" (`index`,
  `index-3`, `about-us`), "50+ / 4.9 Customer Ratings" e assinatura
  "Abu Talha, Manager" (`index-5`), estrelas ★★★★☆ nos cards, "Unique Place
  & luxury hotel". Pousada de interior não tem 800 apartamentos — número
  real ou remove a seção.
- **Depoimentos fictícios** (Kane Williamson "Co-founder", Ronald Richards
  "Web Designer" falando de *planejamento financeiro* na `index-2`, Oliya
  Rahman/Abu Talha/Misba Rahman "Designer"). Só com chip "ilustrativo" ou
  remover.
- **Serviços fora do nicho** nos cards/listas: "Airport Pickup", "Spa
  Center", "Juice bar", "Laundry", filtros "Beach"/"Restaurant" na galeria
  da `index`. Manter só o que o cliente tem (piscina, café da manhã,
  estacionamento, Wi-Fi, churrasqueira...).
- **Texto de outro nicho escondido**: a `room-details` falava de cirurgia
  plástica ("breast augmentation, rhinoplasty, liposuction") e o contato, de
  oficina de carro — os dois já foram trocados, mas é sinal de que o autor
  copiou blocos de outros templates: ler o corpo antes de publicar.
- **Vídeo de demonstração**: botão de play na `index-2` e `index-3` abre
  `youtube.com/watch?v=_ZmB5RdUgPQ` (vídeo do pacote). Trocar ou remover.
- **Mapa**: `contact.html` usa `maps.google.com/maps?q=[ENDEREÇO]&output=embed`
  (sem API key). O original apontava pra uma rua de Dhaka.
- **Imagens do jQuery UI que nunca vieram no pacote**: `main.css` referencia
  `images/ui-icons_*.png` e `../img/cross.png` que não existem (404
  silencioso). As setas do calendário foram redesenhadas em CSS; o resto
  não aparece em nenhuma página mantida.
- **Font Awesome Pro** (`assets/css/vendor/fontawesome-pro.css` + fontes)
  vem embutido no pacote com cabeçalho "Commercial License" da Fonticons —
  é biblioteca de terceiro, mantida como veio.

## Limpeza já feita nesta cópia

- **Autor/licença removidos**: cabeçalho "Template Name / Author: sTheme-IT /
  Support: saadalam291@gmail.com / Developer: Soukhin khan (github)" do
  `main.css` e `main.js`; `<meta name="author" content="soukhinkhan">` das
  9 páginas; `mailto:rrdevs@gmail.com` no rodapé de todas as páginas;
  crédito "© stheme-it" com link pro perfil do autor no ThemeForest
  (`index-2`); `mail.php` (destinatário `support@envato.com`, remetente
  `hello@sthemeit.net`); form com `mailchimpsubscribe` da `index-2`;
  `documentation/` inteira. Grep final (`envato|themeforest|licen|copyright|
  author|designed by|template by|stheme|soukhin|rrdevs|mailchimp|example.com`)
  sem resíduo do autor — sobram só cabeçalhos MIT/GPL de bibliotecas de
  terceiros (Bootstrap, jQuery, jQuery UI, Swiper, WOW, animate.css,
  waypoints, meanmenu, Magnific Popup, Isotope, moment/parallax removidos) e
  nomes internos de variável CSS (`--rr-theme-primary`).
- `lang="zxx"` → `pt-BR`; `<title>` → `[NOME DO CLIENTE] | Página`.
- Seletor de idioma do header ("En / China / Bangla / Hindi"), busca popup
  (não buscava nada), "Purchase Now" do menu mobile (sobra do marketplace),
  avião decorativo no banner das páginas internas, countdown para
  01/01/2025, fonte Sofia e Source Sans Pro (carregadas e nunca usadas),
  `ajax-form.js`, `daterangepicker`, `moment`, `parallax.min.js`,
  `jquery.appear.js`, `.map` e `scss/` — removidos. 110 imagens que só
  as páginas apagadas usavam (inclusive a única foto de pessoa real do
  pacote, `testimonial/t3.jpg`) — removidas.
- Rodapé único em pt-BR nas 9 páginas (as homes 2 e 3 tinham rodapés
  diferentes, um com fundo placeholder "1920x786"); a faixa "Special
  Offer" da `index-3` deixou de sobrepor o rodapé.
- Telefones/e-mails/endereços fake do tema (`(406) 555-0120`,
  `deanna.curtis@example.com`, "6391 Elgin St. Celina, Delaware",
  "2972 Westheimer Rd. Santa Ana", números de Bangladesh) → placeholders.

## Já usado em

Nenhum cliente ainda — entrou na biblioteca em 28/09/2026.
