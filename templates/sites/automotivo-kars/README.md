# Automotivo — Kars

Template HTML para o nicho automotivo. 36 páginas, **6 homes**, base escura
com acento vermelho (`#F02801`), tipografia display condensada (Play) +
corpo em DM Sans.

**Peso:** 20 MB (era 37 MB no zip original — ver limpeza abaixo) · **Stack:**
HTML estático + jQuery · **Build:** nenhum

Origem: pack "Kars — Car Dealership HTML Template", comprado.

---

## Para que serve

Revenda de veículos, marketplace de carros usados, aluguel de carro,
concessionária — igual ao `automotivo-carlink`. A diferença que importa: a
**home-3 é uma landing de oficina/auto repair pronta** (serviços, equipe,
portfólio, agendamento, FAQ, "anos de experiência"), o que o Carlink não tem.
Se o cliente for oficina, funilaria ou estética automotiva, comece por aqui
em vez de adaptar uma home de catálogo.

Não serve pronto para: loja de peça/acessório automotivo com carrinho de
verdade (o `cart.html`/`shop.html`/`wishlist.html` existem mas são o módulo
de e-commerce genérico do tema, com produto de demonstração **fora do
nicho — ver Armadilhas**).

## As 6 homes

Preview de cada uma em [`preview/`](preview/) (os screenshots foram tirados
com uma folha de estilo temporária que força as animações de entrada para o
estado final — ver nota em "Armadilhas" — então mostram a página como ela
fica depois de carregada, não como o zip cru mostraria num screenshot de um
tiro só).

| Arquivo | O que é | Uso recomendado |
|---|---|---|
| `index.html` | Marketplace de veículos, hero escuro com slider de carro, busca por marca/modelo/cor/carroceria | Revenda / marketplace — primeira opção padrão |
| `home-2.html` | Ficha de UM veículo em destaque (demo: moto Yamaha). Tem **acento laranja próprio** (`.bike-dealership`), independente da cor geral — o `personalizar.sh` já cobre os dois | Vitrine de veículo único (ex: loja que vende um carro/moto por vez) |
| `home-3.html` | **Oficina / auto repair.** Serviços, "anos de experiência", equipe, pacotes de preço, portfólio de trabalhos, agendamento, FAQ | Oficina, funilaria, estética automotiva, lava-jato com serviço agendado |
| `home-4.html` | Ficha de UM veículo em destaque (demo: Mercedes Benz-A), estilo mais premium/showroom que a home-2 | Concessionária de carro único / showroom |
| `home-5.html` | Marketplace v2 — hero mais textual ("A World of Choices"), busca de veículo, catálogo | Alternativa à `index.html` para marketplace |
| `home-6.html` | **Não é carro.** Ficha de produto genérico do módulo de loja do tema (demo: barco "Nautique Super Air GS24") | Evitar — ver Armadilhas |

## Páginas internas

`about` `services` `service-details` `dealership-grid` `dealership-list`
`dealership-details` (equipe/oficina) · `inventory-grid` `inventory-listing`
`inventory-left-sidebar` `inventory-right-sidebar` `inventory-comparison`
`inventory-sold` `single-inventory` (catálogo e ficha de veículo) ·
`finance-calculator` `sell-a-car` · `team` `team-details` (⚠ o `<title>`
original diz "Attorney" — sobra de outro template do mesmo autor, mais
nenhum outro traço de advocacia) · `testimonials` `pricing` `faq` ·
`blog` `blog-details` · `contact` · `cart` `checkout` `shop` `shop-details`
`wishlist` (loja genérica, mesmo módulo do home-6) · `error` `typography`.

---

## Como usar

```bash
cd templates/sites/automotivo-kars
./personalizar.sh /c/Dev/ClienteX/site '#1E6F5C' 'Cliente X'
```

O script copia o template para a pasta destino e troca:

- a cor de marca (`--theme-color`, mais os ~35 ícones/logos SVG que têm o
  hex chumbado direto porque SVG não lê variável CSS externa) — inclui o
  acento laranja exclusivo da home-2;
- o nome fictício da concessionária de demonstração ("Kars"), que aparece
  em `<title>`, `<meta>`, alt de logo, rodapé **e em ~50 pontos do corpo do
  texto** (hero, "Sobre", depoimentos) — não é só o título.

O original em `html/` nunca é alterado. Ao final o script lista o que
continua manual (logo vetorizado, escolha de home, tradução, contato,
formulário, fotos, home-6) — a lista é longa porque esse template tem mais
pegadinha que o Carlink, ver Armadilhas.

---

## O que já foi limpo daqui

- `documentation/` inteira (as páginas de ajuda do autor, 3,9 MB de HTML do
  Envato) — não foi copiada, só o `download-version/` virou `html/`
- FontAwesome Pro vinha com **6 pesos × 4 formatos + 6 SVG de ícone**
  (30 arquivos, 24 MB). O CSS só referencia `.ttf` e `.woff2` — `.eot`,
  `.woff` (não-2), os SVG de fonte de ícone e `fa-v4compatibility.*` eram
  peso morto, removidos. Isso sozinho tirou 17 MB do template (37→20 MB)
- Comentário de licença/autor (`Author: themeholy`,
  `Author URI: https://themeforest.net/user/themeholy`) removido do
  cabeçalho de `assets/css/style.css` e `assets/sass/style.scss`
- `lang="zxx"` → `lang="pt-BR"` nas 36 páginas
- `<title>Kars-html - Car Dealership HTML Template - X</title>` →
  `<title>[NOME DO CLIENTE] — X</title>`; mesmo tratamento em
  `<meta name="description">`, `<meta name="keywords">` e no `alt` das duas
  logos (viravam "Kars-html" sem isso)
- Rodapé `Copyright © 2025 Kars. All Rights Reserved.` → `[NOME DO CLIENTE]`
- Depoimento falso com cargo "**ENVATO LLC**" (dava pra ver de onde veio o
  template) → "Cliente Satisfeito"
- `__MACOSX/` e `.DS_Store` não vinham no zip — nada a fazer aqui

---

## Armadilhas

**A maior parte das fotos é placeholder com a medida escrita dentro, não
banco de imagem.** De ~300 arquivos em `assets/img/`, ~265 são a mesma
imagem cinza com "LARGURA × ALTURA" desenhada no meio (hero, catálogo,
equipe, depoimentos, blog) — só os fundos texturizados/decorativos são arte
de verdade. **Isso é o oposto do automotivo-carlink**, que tem foto real de
banco de imagem no carro do hero e no catálogo. Ver comparação abaixo.

**home-2 tem uma segunda cor de marca escondida.** `.bike-dealership`
(classe no `<body>` só dessa página) redefine `--theme-color: #FE8900`
(laranja) por cima da cor geral — um CSS var override scoped por classe, não
visível numa busca simples por `:root`. Sem cobrir isso, trocar a cor deixa
a home de moto presa no laranja. O `personalizar.sh` já trata os dois casos.

**O logo é vetorizado — "KARS" é path, não texto.** `assets/img/logo.svg` e
`logo-white.svg` têm o nome da marca desenhado em curvas SVG (28-46 usos do
hex de cor cada). O script recolore o traço automaticamente, mas o nome
continua "KARS" até alguém redesenhar o logo — mesma situação do
`manutencao-qlinest` e do `barbearia-trimly` antes de aplicar fonte custom.

**mail.php não roda na Vercel.** É PHP puro com `mail()`, que precisa de um
servidor com PHP configurado — hospedagem estática (Vercel, Netlify) não
serve. `contact.html` e a maioria das homes apontam pra ele; `sell-a-car.html`
tem um SEGUNDO formulário com `action="/submit-form"`, que não existe em
lugar nenhum. Antes de publicar: trocar os dois por Formspree/web3forms, ou
tirar o formulário do ar.

**home-6 não é sobre carro.** É a ficha de produto do módulo de loja
genérico do tema (mesmo sistema de `cart.html`/`shop.html`/`wishlist.html`),
com dado de demonstração de **barco** ("Nautique Super Air GS24" — cavalos,
peso seco, capacidade de combustível). Mais barato não escolher essa home do
que adaptar o conteúdo.

**As animações de entrada (`[data-ani]`) são CSS puro, não scroll-trigger —
mas isso engana screenshot de um tiro só.** `main.js` aplica a classe de
animação e o `animation-delay` assim que a página carrega (não é
IntersectionObserver, então funciona igual em qualquer altura de tela). O
problema é só para quem for tirar screenshot automatizado: `chrome
--headless --screenshot` captura *antes* da animação real (que roda no
relógio do compositor, não no `--virtual-time-budget`, que só acelera timer
de JS). Pra gerar os preview desta pasta, os screenshots foram tirados de
uma cópia à parte com um CSS extra (`[data-ani] { animation: none; opacity:
1; transform: none }` + esconder slide de swiper inativo) — o `html/` real
nunca recebeu esse CSS. Quem for re-gerar os previews mais pra frente,
lembrar disso.

**E-mail e telefone de demonstração não são um só.** O header usa
`info@kars.com`, o card de contato em `contact.html` usa
`karshelp@gmail.com`, e `mail.php` manda pra `yourmail@gmail.com` — três
lugares diferentes para trocar, não um.

**`team.html`/`team-details.html` têm `<title>` sobrando de advocacia**
("Our Attorney", "Attorney Details") — resto de outro template do mesmo
autor (themeholy) reaproveitado. É só o texto do título da aba, o conteúdo
da página é de equipe normal.

---

## Comparação com o automotivo-carlink

Os dois são catálogo/listagem de veículo ("car listing"), não loja de
serviço — mas servem clientes um pouco diferentes:

| | **automotivo-carlink** | **automotivo-kars** |
|---|---|---|
| Homes | 5 | 6 |
| Páginas totais | 13 | 36 |
| Peso | 28 MB | 20 MB |
| Fotos | **Reais**, banco de imagem (carro do hero, catálogo) | **Placeholder** com medida escrita dentro (~265 de ~300 arquivos) |
| Cor de marca | 2 vermelhos chumbados no CSS (sem variável, 23 mil linhas de `main.css`) | 1 variável CSS (`--theme-color`) + hex chumbado só em SVG — mais fácil de trocar |
| Oficina/serviço | Não tem — é 100% catálogo | **home-3 é landing de oficina pronta** (serviços, equipe, agendamento) |
| Visual | Mais clean/comercial, home-3 já nasce com hero escuro | Mais "grão"/textura escura, visual mais robusto, título condensado (Play) |
| Dependências JS | jQuery + uikit, Swiper, Slick, WOW.js, anime.js, taxi.js, nouislider, ion.rangeSlider, flatpickr, fancybox (22 arquivos) | jQuery + Bootstrap, Swiper, GSAP, isotope, imagesloaded, nice-select, magnific-popup, counterup, jquery-ui, tilt.js |

**Quando usar qual:**

- **Cliente é revenda/concessionária/marketplace e tem fotos reais dos
  carros** → Carlink. As fotos do hero já vendem o site na hora da
  aprovação, e não tem placeholder pra trocar em ~265 lugares.
- **Cliente é oficina, funilaria, estética automotiva ou lava-jato com
  agendamento** → Kars, começando pela `home-3`. O Carlink não tem
  equivalente — teria que descaracterizar uma home de catálogo.
- **Revenda pequena, sem fotos profissionais ainda (só foto de celular do
  pátio)** → Kars com `home-4`/`home-2` (vitrine de veículo único) pode
  sair mais rápido, já que boa parte do conteúdo vira "ilustrativo" de
  qualquer forma até ter fotos reais — mas isso é mais trabalho de
  substituição de imagem, não menos.
- **Revenda grande, catálogo extenso, precisa de comparador/financiamento**
  → Carlink tem calculadora de financiamento pronta na home-2; o Kars tem
  em página separada (`finance-calculator.html`), não embutida na home.
