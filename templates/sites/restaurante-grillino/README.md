# Restaurante — Grillino

Template para restaurante à la carte, grill/churrascaria ou bistrô de porte
médio — menu completo (13 homes, cardápio, reserva, chefs, blog, loja), base
**clara** (branco/cinza claro) com um único acento de cor (nasce laranja).
49 páginas ao todo. Comprado como "Grillino — Grill Restaurant Food HTML
Template".

**Peso:** 37 MB em `html/` · **Stack:** HTML estático + jQuery + Bootstrap +
LayerSlider + Slick + Isotope + Magnific Popup + nice-select + date/time
picker · **Build:** nenhum (SCSS fonte incluso em `assets/sass/`, mas o CSS
já vem compilado em `assets/css/` — não precisa de Node/npm pra rodar)

---

## Para que serve

Restaurante de salão com cardápio variado (grill, massa, sobremesa, drink),
reserva de mesa, chefs em destaque e 13 opções de home pra escolher o clima
(hero com slider de foto, vídeo, layout dividido etc.). Fica ao lado dos
outros restaurantes da biblioteca:

- **Elegencia** (`restaurante-elegencia/`) é mais editorial/luxuoso, GSAP,
  dourado sobre fundo quase preto — restaurante fino ou casa de evento.
- **Thesignature** (`restaurante-thesignature/`) é mais quente/casual, fundo
  escuro com textura de pedra.
- **Royate** é claro/corporativo, dourado discreto, 15 homes.
- **Grillino** é o mais "cardápio-cêntrico" dos quatro: menu em página
  própria com paginação, cards de prato com preço e favorito (ícone de
  estrela), carrinho/loja decorativos — pensado pra quem quer mostrar o
  prato tanto quanto o ambiente. Base clara como o Royate, mas com o acento
  em qualquer cor (nasce laranja, não dourado fixo).

**Para que não serve:** comida rápida/delivery/porção pra viagem (pra isso,
`pizzaria-onepage/` ou `restaurante-fresheat/`) — o fluxo supõe salão com
reserva e cardápio de mesa, cardápio ilustrativo. Também não serve se o
cliente precisar de loja/carrinho/login funcionando de verdade: `cart.html`,
`checkout.html`, `shop*.html`, `login.html` e `sign-up.html` são só fachada,
sem backend nenhum.

## As páginas

Preview em [`preview/`](preview/): `index` (home padrão, "Home Two"),
`index-mobile` (mesma home em ~390px), `menu` (cardápio paginado), `about`
(institucional + equipe).

| Grupo | Páginas | O que tem |
|---|---|---|
| Home | `index.html` (padrão) + `index-2.html` a `index-9.html` + `index-2-onepage.html` a `index-5-onepage.html` | 13 heros diferentes — só `index.html` linkada no menu |
| Cardápio | `menu.html`, `menu-2/3/4.html`, `menu-details.html` | Grade paginada com categoria, preço e favorito; página de detalhe de 1 prato |
| Institucional | `about.html`, `about-2.html` | Sobre, "nossa força", equipe/chefs em carrossel |
| Chefs | `chef.html`, `chef-2.html`, `chef-details.html` | Grade de chefs + página individual |
| Reserva | `reservation.html`, `reservation-2.html` | Formulário de data/hora/pessoas — decorativo, `action="#"` |
| Contato | `contact.html`, `contact-2.html` | Formulário (PHP, não roda na Vercel) + endereço + mapa |
| Blog | `blog.html`, `blog-grid*.html`, `blog-*-sidebar.html`, `blog-details*.html` | Lista em grade/sidebar + post individual, texto genérico em inglês |
| Loja/conta | `shop*.html`, `cart.html`, `checkout.html`, `login.html`, `sign-up.html` | E-commerce e login decorativos, sem backend |
| Outras | `error.html` | Página 404 |

## Como personalizar

```bash
templates/sites/restaurante-grillino/personalizar.sh <destino> '#COR' 'Nome do Cliente'
```

Cor de marca em um único par (principal + escura, a escura é **derivada
automaticamente** a 75% de cada canal RGB — só se passa 1 hex, não 2). Ela
aparece em 3 camadas, e o script cobre as 3:

1. `#fa8507` / `#c06504` cru em `assets/css/style.css` (que também tem a
   var `--secondary-color`, 106 usos) e em `assets/css/theme-color1.css` — o
   único dos 6 esquemas prontos do pacote (`theme-color1.css` a
   `theme-color6.css`) que qualquer página realmente carrega. Os outros 5
   existem no zip mas **nenhuma página linka pra eles** (confirmado por
   grep em todo `html/`) — são esquemas alternativos mortos, ignorados.
2. `rgba(250, 133, 7, ...)` — a mesma cor principal decomposta em RGB
   decimal, usada em 5 sombras/gradientes (2 em `style.css`, 3 em
   `theme-color1.css`) — o script recalcula a partir da cor nova.
3. Todos os `.scss` fonte sob `assets/sass/` (não rodam no navegador, não há
   build neste pacote — mantidos só como referência).

O nome do cliente já está pré-processado como `[NOME DO CLIENTE]` em todo
`html/` (211 ocorrências originais: título, meta, alt de logo, rodapé,
título do hero de todas as 49 páginas).

---

## Onde fica a cor de marca (resumo)

| Cor | Papel | Onde |
|---|---|---|
| `#fa8507` (laranja) | Botão, ícone ativo, borda, título em destaque, `--secondary-color` | `assets/css/style.css` (var, 106 usos) + `assets/css/theme-color1.css` (hex cru, ~15 seletores) |
| `#c06504` | Hover de link (`a:hover`) | mesmos 2 arquivos, 1 seletor cada |
| `#B80011` (vermelho) | **Não trocado** — usado só em `header-v6`, `header-v7` e `footer-v2`, layouts que NENHUMA das 49 páginas usa (todas usam o header padrão + `footer-layout1`). Fica inerte em `style.css`. Se algum dia trocar de header/footer pra uma dessas variantes, procurar à mão. |

---

## Armadilhas

- **Logo com o nome vetorizado dentro do ícone (a pior forma desse
  problema na biblioteca até agora).** `assets/img/logo.svg` e
  `logo-white.svg` não são só o símbolo da chama: o nome "Grillino" em
  script cursivo está desenhado como geometria de `<path>` pura (mesmo
  `<path id="Path_12">` que desenha o ícone, sem nenhuma tag `<text>`).
  Abrindo o SVG como texto não mostra a palavra "Grillino" em lugar
  nenhum — só coordenadas de curva — e por isso o find/replace de nome
  (que troca 211 ocorrências em todo `html/`) não alcança. Só apareceu
  renderizando a página de verdade: screenshot confirma "Grillino" escrito
  por extenso do lado do ícone, no header de **toda página do pacote**.
  Trocar os 2 arquivos inteiros pela logo real do cliente — não dá pra
  limpar o SVG, é substituição completa.
- **Fotos: nome do arquivo engana.** Muitos arquivos têm nome de foto de
  banco de imagem real (`delicious-burger-with-many-ingredients-isolated-
  white-background-tasty-cheeseburger-splash-sauce 1.png` etc.), mas ao
  abrir são placeholder cinza com a dimensão escrita dentro (ex.
  "691X619"), igual ao `manutencao-handify/`. Confirmado abrindo os
  arquivos um a um, não só pelo nome — a lição já registrada na memória da
  oficina (PNG engana no preview) se aplica aqui a nomes de arquivo
  também. ~300+ arquivos de foto no pacote, todos placeholder; só
  ícone/forma decorativa (`icons/`, `shape/`, a maioria de `bg/`) é arte
  real.
- **Ícones raster com a cor original queimada.** `icons/clock-icon.png`,
  `clock-icon-2.png`, `reservation-bg-icon-1.png` e `reservation-bg-icon-2.png`
  (4 arquivos, de 7 no total da pasta — os outros 3 já são `.svg`) têm o
  laranja `#fa8507` desenhado dentro do PNG. O script não alcança raster;
  se a cor do cliente for muito diferente de laranja, esses 4 ícones ficam
  destoando — baixo impacto visual (são só decoração de seção), mas dá pra
  notar de perto.
- **Formulário de contato usa PHP puro.** `contact.html` manda pra
  `mail.php` (recipient fixo `info@example.com`, placeholder genérico —
  não é e-mail de pessoa real, mas também não funciona). A Vercel **não
  roda PHP** — sem hospedagem própria, o formulário não envia nada. Trocar
  a ação por `wa.me` ou um serviço de formulário estático antes de
  publicar. `reservation.html`/`reservation-2.html` têm `action="#"`
  (decorativo, nem tenta).
- **Chefs fictícios.** `chef.html`, `chef-2.html` e `chef-details.html` têm
  6 nomes inventados (Mark Polo, Vivi Marian, Zerzzy Lamot, Peter Parker,
  Suzana Roise, Mohn Deo) — sem equipe real do cliente, apagar a seção ou
  trocar por cargo genérico sem nome.
- **13 homes, só uma linkada.** `index.html` é a padrão; `index-2.html` a
  `index-9.html` mais 4 variantes `-onepage` são alternativas não linkadas
  no menu — escolher uma só antes de publicar (ou apagar o resto).
- **Telefone fixo** `+869 526 212` em ~90 ocorrências (header, hero,
  rodapé, toda página) — trocar por WhatsApp real ou marcar "a confirmar".
- **Cardápio e preço inventados** em `menu*.html` — sem cardápio real do
  cliente, marcar "a confirmar".
- **Loja/conta/blog sem backend** (`shop*.html`, `cart.html`,
  `checkout.html`, `login.html`, `sign-up.html`) simulam e-commerce e
  login completos; `blog*.html` tem post de texto genérico em inglês —
  considerar remover do menu em demo de captação.
- **Redes sociais** (facebook/twitter/linkedin/instagram/youtube) todas com
  `href="#"` — preencher ou remover as que não existirem.
- **Conteúdo em inglês**, `<html lang="en">` incluso — trocar pra `pt-BR` e
  reescrever com o tom de voz do `identidade.md` do cliente, não traduzir
  ao pé da letra.
- **Favicon genérico**: `apple-touch-icon.png` e `assets/img/favicons/*`
  são o símbolo do template — trocar pelo ícone real do cliente.

## Licença/autor — já removido

O pacote original (Vecuro / ThemeForest) tinha 3 pontos de crédito,
removidos em `html/` antes de guardar na biblioteca:

- Comentário de cabeçalho (`Template Name/URL/Author/Author URI`) em
  `assets/css/style.css` e `assets/sass/style.scss`
- `<meta name="author" content="Vecuro">` nas 49 páginas
- Rodapé `"... All rights reserved by <a href="...vecuro_themes">Vecuro</a>"`
  nas 49 páginas — removido mantendo só `"Copyright © AAAA [NOME DO CLIENTE]."`

A pasta `Documentation/` do zip original (manual de instalação + página de
licença Envato/ThemeForest) não foi copiada — só `html/` (a "download
version" do pacote) entrou na biblioteca. Nenhuma referência a
Vecuro/ThemeForest/Envato/"Regular License" restou em `html/` (checado por
grep após a limpeza). Os títulos de página também perderam o sufixo
genérico "- Food Restaurant Cafe Grill & Bistro HTML Template".

## Já usado em

Nenhum cliente ainda — entrou na biblioteca em 26/09/2026 como parte do
lote de templates de alimentação/gastronomia.
