# Hospedagem — Qomfort

Template multi-página de hotel/pousada, comprado como "Qomfort — Hotel Booking
HTML Template". **14 páginas** (3 homes + 11 internas), base **carvão escuro +
cobre `#AB6034`**, título em Cormorant Garamond (serifada elegante) + corpo em
Roboto. O pacote original tinha 16; `shop.html` e `product-details.html` (loja
de produto genérico) foram removidas.

**Peso:** 19 MB em `html/` (16 MB são fontes — Font Awesome Pro completo +
flaticon; imagens somam <1 MB porque são todas placeholder) · **Stack:** HTML
estático + Bootstrap 5.0 + jQuery 3.6 + Slick + Magnific Popup + Nice Select +
Isotope + FullCalendar 6 + circle-progress + WOW.js/animate.css · **Build:**
nenhum (o `assets/sass/` é só a fonte; o HTML carrega o `assets/css/style.css`
já compilado)

---

## Para que serve

Negócio de **hospedagem pequeno do interior**: pousada, hotel de cidade
pequena, chácara/sítio/casa de temporada para aluguel de fim de semana. Tem
tudo que esse cliente precisa mostrar — acomodações com card de quarto,
detalhe do quarto (comodidades, regras de check-in/check-out, mapa),
galeria filtrável, FAQ, serviços, "sobre" e contato — e **caixa de reserva
(entrada, saída, adultos, crianças) que já abre o WhatsApp com a mensagem
montada** (ver Formulários). Pra esse público, "consultar disponibilidade
pelo WhatsApp" é exatamente o fluxo real.

**Qual home escolher** (o `personalizar.sh` recebe como 4º argumento):

| Cliente | Home | Por quê |
|---|---|---|
| **Pousada / hotel pequeno** (vários quartos) | `index2` | Hero cheio + **barra de reserva logo abaixo** do hero, fileira de ícones de comodidade, lista de tipos de quarto, carrossel de quartos com abas, galeria em grade. É a mais "hotel". |
| **Chácara / sítio / casa de temporada** (1 imóvel, aluguel por diária ou fim de semana) | `index3` | **Form de reserva ao lado do hero** (conversão logo na primeira dobra), **barra de topo com telefone e e-mail** (visível no desktop), bloco de 3 "pacotes" que dá pra virar *Diária / Fim de semana / Evento* se o cliente passar os preços, e FAQ na própria home (bom pra regras: capacidade, pet, som, piscina). |
| Hotel com pegada "resort"/mais sofisticado | `index` | Hero escuro com brilho cobre e foto grande à direita, form de reserva no meio da página (junto dos depoimentos). Terceira opção. |

**Não serve / serve mal:**
- **Salão de festas/evento** como produto principal — não há página de evento,
  pacote de buffet nem capacidade de salão; dá pra adaptar o bloco de pacotes
  do `index3`, mas a estrutura toda é de quarto/diária.
- **Motel** — vocabulário e tom de hotel de férias, nada de período/pernoite.
- **Hostel/camping** com reserva online de verdade — o form não consulta
  disponibilidade nenhuma, só abre o WhatsApp.
- **Imobiliária de temporada com muitos imóveis** (catálogo, filtro por
  cidade/preço) — melhor ir pra categoria de imóveis (`imoveis-*`).

## Páginas

Preview do topo (1440×1000) de cada uma em [`preview/`](preview/).

| Página | O que tem |
|---|---|
| `index.html` / `index2.html` / `index3.html` | 3 homes (ver tabela acima) |
| `room-grid.html` / `room-2columns.html` / `room-list.html` | Mesma lista de quartos em 3 layouts (grade 3 col., 2 col., lista) + barra de reserva no topo. Usar **uma** só |
| `room-details.html` | Detalhe do quarto: tamanho/camas/banheiros, preço/noite, carrossel de fotos, comodidades, **calendário** (ver Armadilhas), mapa, regras (check-in/out, pet, fumo) + caixa de reserva lateral |
| `about.html` | Missão, "história" em linha do tempo, contadores, equipe, depoimentos |
| `services.html` | Serviços em cards + **tabela de 3 planos em dólar/mês** (ver Armadilhas) |
| `gallery.html` | Galeria com filtro (Hotel / Restaurant / Beach / Room) |
| `faqs.html` | Acordeão de perguntas + caixa de reserva |
| `contact.html` | Endereço/e-mail/telefone, formulário → WhatsApp, mapa por endereço |
| `blog.html` / `blog-details.html` | Lista e post. Só o menu aponta pra eles (as homes têm bloco "Latest News & Blog") — se o cliente não tiver blog, tirar do menu **e** o bloco das homes |

## Como usar

```bash
cd templates/sites/hospedagem-qomfort
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2e6b4f' 'Pousada XYZ' index2   # pousada/hotel
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#2e6b4f' 'Chácara XYZ' index3   # chácara
```

O script copia `html/`, troca a cor de marca em todas as grafias (hex, var,
rgba, tinta clara, e recolore os 3 PNG/GIF que têm a cor pintada — precisa de
Pillow, que já está instalado nesta máquina), preenche `[NOME DO CLIENTE]` e,
se receber a home, transforma ela em `index.html`, apaga as outras duas e
troca o dropdown "Início" do menu por link simples. Nunca altera o original.
No fim imprime a lista de pendências manuais (a mesma das Armadilhas).

Testado em 28/09/2026: cópia com `#2E6B4F` + `index2` e com `#1F4E8C` sem
home → 0 ocorrência da cor/nome originais no destino, conferido por
screenshot (botões, brilho do hero, faixas diagonais, barra do Instagram,
preloader e a meia-lua do hero do `index` saíram na cor nova); `html/`
original intacto (PNG/GIF idênticos byte a byte à fonte comprada).

## Onde fica a cor de marca

Conferida por screenshot, não só pelo nome da variável: o **cobre** é a cor
de marca (botão, preço, ícone, faixa "Siga no Instagram", barra de topo do
`index3`, faixas diagonais do hero do `index2`, brilho radial atrás de todo
fundo escuro). O **carvão** `#1D1B1A`/`#0C0B0B` das seções escuras é neutro —
funciona com qualquer cor de marca, o script não mexe.

| Onde | Grafia | Usos |
|---|---|---|
| `:root` de `assets/css/style.css` | `--primary-color: #AB6034` | alimenta **109** `var(--primary-color)` |
| `style.css` | `#AB6034` cru | 1 (estrela de avaliação `.ratting i`) |
| `style.css` | `rgba(171, 96, 52, X)` | **56** (brilho radial dos fundos escuros, sombras, overlays) |
| `style.css` | `#F7F0EB` | 2 — tinta 10% da marca (fundo do círculo de ícone); o script deriva a nova |
| `assets/sass/**` | mesmas grafias | só fonte, não roda — o script troca também pra ficar coerente |
| `images/shapes/slider-circle-half.png` | cobre pintado no PNG | meia-lua decorativa do hero do `index` |
| `images/icons/sidebar-toggler-color.png` | cobre pintado | ícone de menu lateral do `index3` |
| `images/preloader.gif` | cobre pintado (20 frames) | casinha animada do carregamento, toda página |
| `images/logos/logo*.png`, `favicon.png` | ícone de hotel cobre + "QOMFORT" | **manual** — é a logo, trocar pela do cliente |

## Limpeza já feita nesta cópia

- **Autor/licença removidos:** cabeçalho "Template Name: Qomfort / Template URI
  demo.webtend.net / Author: WebTend / Author URI webtend.net" apagado de
  `style.css`, `script.js` e `style.sass`. Rodapé "© 2023 Qomfort. All Rights
  Reserved." → "`[NOME DO CLIENTE]` — todos os direitos reservados." em 14
  páginas. `assets/fonts/flaticon_merina.html` (página de demo do Flaticon com
  bloco "License and attribution") apagada. Não havia e-mail do autor,
  Formspree/Mailchimp/API key em formulário nenhum.
- **Ficaram** os cabeçalhos de licença de **bibliotecas de terceiros** —
  Bootstrap, jQuery, FullCalendar, imagesLoaded, WOW, animate.css, Magnific
  Popup, skill-bars (MIT), Isotope (GPLv3/comercial) e **Font Awesome Pro
  5.14** ("Commercial License") — não são do autor do template.
- **Loja fora do nicho:** `shop.html`, `product-details.html`,
  `assets/images/shop/`, `banner-shop.jpg`, o dropdown "Shop" do menu (14
  páginas) e o ícone de sacola de compras do header — removidos.
- **Seletor de idioma "Eng / Ban / Ara"** do header (index, index3) removido.
- **Backend morto:** `assets/php/form-process.php` (PHP `mail()` para
  `yourname@domain.com`), `contact-form-script.js`, `form-validator.min.js`,
  `jquery.ajaxchimp.min.js` (carregado, nunca usado), e 2 JS nunca carregados
  (`isotope.min.js` duplicado, `jquery.animatedheadline.min.js`) — apagados.
- `lang="zxx"` → `lang="pt-BR"`; `<title>` → `[NOME DO CLIENTE] | Página`;
  meta description → `[NOME DO CLIENTE]`.
- **Traduzido pra pt-BR:** menu, breadcrumbs, título dos banners internos,
  botões recorrentes (Reservar, Saiba mais, Ver acomodações, Detalhes),
  formulários, rodapé, faixa do Instagram, rótulos de contato.
- **Contato fake → placeholder:** `+000 (123) 456 88` → `[TELEFONE]` (e
  `callto:`/`calto:` quebrados → `tel:[TELEFONE]`), `support@gmail.com` →
  `[EMAIL]`, `infohotel.net` (estava num `mailto:` sem @) → `[SITE]`, "55 Main
  Street, Melbourne" → `[ENDEREÇO]`, instagram.com → `instagram.com/[INSTAGRAM]`.
  As abas "Australia / New York" do `contact.html` viraram um endereço só.
- **Mapas:** o embed de Nova York (contact, room-details) virou
  `google.com/maps?q=[ENDEREÇO]&output=embed` — sem API key.
- **Links mortos do rodapé** (Terms / Privacy Policy / Cookie Policy, todos
  apontando pra `about.html`) → "Dúvidas frequentes" + "Contato". "History" e
  "Team Member" dos links rápidos (também iam pra `about.html`) removidos.
- **Calendário** do `room-details` vinha travado em `initialDate:
  '2023-08-13'` (abria em agosto/2023) e editável — agora abre no mês atual,
  em pt-BR, só leitura.
- Selects de adultos/crianças mandavam `value="adults3"` pra opção "4" (bug do
  tema) — agora cada opção manda o número.

## Formulários (`assets/js/wa-forms.js`)

Nada no pacote original enviava de verdade: o contato postava pra PHP (não
roda na Vercel) e as caixas de reserva eram `action="#"` ou nem eram `<form>`.
Agora todo elemento com `data-wa` abre `https://wa.me/[WHATSAPP]?text=...`:

- `data-wa="reserva"` — caixa "Consulte a disponibilidade" (`index`,
  `index3`, `faqs`), barra de reserva (`index2`, `room-grid`, `room-list`,
  `room-2columns`) e lateral do `room-details`. Mensagem: *"Olá! Gostaria de
  consultar disponibilidade para hospedagem. Entrada: 10/10/2026 / Saída:
  12/10/2026 / Adultos: 2 / Crianças: 1"* (data já em dd/mm/aaaa).
- `data-wa="contato"` — formulário do `contact.html` e o form "Fale com a
  gente" da barra lateral escondida (ícone ⌘ do header, toda página).
- O botão **"Reservar" do header** (toda página) virou link direto pro
  `wa.me/[WHATSAPP]`.

Testado com Playwright (window.open interceptado) nas 5 variações: mensagem
sai certa, sem erro de JS. **Falta só trocar `[WHATSAPP]`** em `wa-forms.js`
(1×) e no href do botão "Reservar" (1× por página) — só dígitos com DDI+DDD.

Continuam **decorativos** (sem envio): newsletter "Novidades / Assinar" do
rodapé (toda página), busca e comentário do `blog-details`.

## Armadilhas

- **Zero foto real.** As ~160 imagens são retângulo cinza com a medida escrita
  dentro ("1920X520", "410X270"). Hero, banner interno, quartos, galeria,
  Instagram, equipe, depoimento, blog — tudo. Sem foto do cliente o demo fica
  com cara de maquete; em hospedagem a foto é o produto, então **não publicar
  sem as fotos reais** (Maps/Instagram/Booking do cliente). Os banners internos
  e o hero do `index2` são `background-image` inline; o resto é `<img>`.
- **Logo em 3 arquivos + favicon:** `logos/logo.png` (texto branco — header
  escuro do `index`, rodapé), `logos/logo-black.png` (texto preto — header
  branco das internas e do `index3`), `logos/logo-white.png` (`index2`).
  Esquecer um deixa "QOMFORT" em parte do site.
- **Preços em dólar chutados** em todo card de quarto ("$59 /per night", 38×
  "per night") e **tabela "Basic / Standard / Silver Plan" em $/mês** no
  `index3` e no `services.html` — não faz sentido pra hospedagem. Sem preço
  real: tirar o preço ou "sob consulta"; a tabela só fica se virar pacote real
  (diária/fim de semana/evento) com valor passado pelo cliente.
- **Números e prova social inventados:** contadores animados ("Projects
  complete", "Luxury Rooms", "Beaches", "Regular Guest" — o número mora no
  atributo `data-stop` do `<span class="count-text">`, não no texto, então
  não aparece num grep por "305+"), "Awards Winning Hotel Agency & 25+ Years
  Of Experience" no subtítulo do hero, "25+ Years Of Experience in Hotel
  Services" com barras "Quality 86% / Performance 68%", estrelas 5/5 em todo
  quarto, depoimentos com nome (Diane C. Valentine, Michael A. Braun...),
  equipe com nome, assinatura "Robert L. Robinson / CEO & Founder"
  (`about/signature.png` é imagem — não sai em grep). Tirar ou marcar
  "ilustrativo".
- **Calendário não é disponibilidade.** O "Calendário" do `room-details` é um
  FullCalendar vazio (sem eventos, sem integração). Não apresentar como
  "disponibilidade online"; se não agregar, apagar `<div id="calendar">`.
- **Vídeo do tema:** o play (index ×2, index2 ×2, index3) abre
  `youtube.com/watch?v=9Y7ma241N8k`, vídeo de demonstração do pacote — trocar
  pelo vídeo do cliente ou tirar o botão.
- **Texto do corpo em inglês/lorem:** títulos de seção ("Explore Luxury Hotel
  & Suites", "Quality Services & Food Your Trip Are Enjoyable" — inglês
  quebrado), parágrafos lorem ipsum, comodidades do quarto, "Rules &
  Regulations", perguntas do FAQ, filtros da galeria (Hotel / Restaurant /
  Beach / Room). Reescrever com o tom do `identidade.md`, não traduzir literal.
  A lista "Comodidades" do rodapé (Café da manhã, Wi-Fi, Estacionamento,
  Piscina, Área de lazer) é **exemplo** — confirmar o que o cliente tem.
- **Vocabulário de "resort de luxo":** Spa, Gym, Jacuzzi, "Beaches", "Food &
  Restaurants", transfer — pousada do interior raramente tem. Cortar os
  ícones/cards que não correspondem ao cliente (não deixar "Spa" num sítio).
- **Mobile:** no `index2` as setas do slider do hero ficam por cima do
  subtítulo em 390px; a barra de topo com telefone/e-mail do `index3` some no
  mobile (só desktop), e o telefone do header também — no celular o contato
  visível é o botão/caixa de reserva. Testar em ~390px antes de publicar.
- **Font Awesome é a versão Pro 5.14** (ícones `fal`/`far`/`fad` — setas,
  cama, régua, etc.), redistribuída dentro do pacote comprado. Funciona
  offline normalmente; se um dia precisar trocar pelo FA Free, os ícones
  `fal`/`fad` somem (não existem no Free).
- `jquery.animatedheadline.css` continua carregado em toda página sem o JS
  correspondente (nunca foi usado pelo tema) — inofensivo.

## Já usado em

Nenhum cliente ainda — entrou na biblioteca em 28/09/2026.
