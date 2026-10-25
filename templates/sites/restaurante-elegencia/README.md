# Restaurante — Elegencia

Template para restaurante fino, bistrô, buffet, casa de eventos com cozinha.
16 páginas, três homes, **base azul-petróleo quase preta com dourado**, e um
inversor testado que a deixa **clara** com dois acentos. Nasceu Laravel 12
(Blade) e foi renderizado em HTML estático aqui.

**Peso:** 5,9 MB em `html/` (15 MB com previews e zip original) · **Stack:**
HTML estático + Bootstrap 5 + jQuery + GSAP (ScrollSmoother, ScrollTrigger,
SplitText) + Swiper + lightGallery · **Build:** nenhum

---

## Para que serve

Quem vende **experiência à mesa ou em evento** e tem foto boa: restaurante
autoral, bistrô, buffet de festa, casa de recepção, rooftop, vinho. O tom é
editorial — muito espaço em branco, título serifado grande, kicker em itálico,
filete dourado, animação de entrada em cada seção.

É o **primeiro template da biblioteca que serve para as duas bases**:

- **Escuro** (como vem): `#040D10` com dourado `#FFD28D`. Serve steakhouse,
  bar, restaurante noturno. Trocar o dourado é o `personalizar.sh` sem opção
- **Claro** (`personalizar.sh ... claro '#COR_TITULO'`): branco com cor de
  título (bordô, navy, verde-garrafa) e cor de acento (dourado, cobre). Serve
  buffet, casamento, confeitaria fina, bistrô de dia. Foi medido num cliente
  real de buffet: a paleta do CSS tem só **5 cores** (dourado, branco, `#4F4836`,
  preto, fundo), então a inversão é por regra, não reescrita — ver
  `tools/claro.js`

**Para que não serve:** delivery, pizzaria popular, hamburgueria — o ritmo é
lento e elegante, não dá fome nem urgência (para isso, `pizzaria-onepage/`).
Também não serve para quem não tem foto: **o template inteiro é foto** e não
vem nenhuma.

## As homes

Preview de cada página em [`preview/`](preview/).

| Home | O que tem | Quando usar |
|---|---|---|
| `index.html` | Hero com slider de texto sobre foto fixa · 3 cards com hover · cardápio em 2 colunas · depoimento · horário com foto · "specialties" (texto + 2 fotos + estrela) · barra de reserva · faixa de vídeo | Padrão. Base já validada num cliente real de buffet |
| `home2.html` | Hero com slider de foto e setas · marquee de texto corrido · sobre com foto · horário · slider de 5 cards · cardápio · specialties · depoimento · reserva | Quando tem mais foto e quer movimento |
| `home3.html` | **Menu lateral fixo** à esquerda, hero recolhido, cardápio com foto ao lado | Restaurante com identidade mais "hotel" |

## Páginas internas

`about` · `menu` (cardápio grande em abas) · `chef` `meetTheChef` · `gallery`
(lightGallery) · `portfolio` `portfolioDetails` · `blog` `blogDetails` ·
`contact` (formulário + mapa) · `reservations` · `error404` · `comming`

Todas as internas usam o mesmo `layout`: hero comum com fundo
`banner_top_all.png` + título + trilha "Home / Página".

---

## Como usar

```bash
cd templates/sites/restaurante-elegencia
# escuro, só troca o dourado
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C9A85B' 'Bistrô XYZ'
# claro: COR vira linha/borda/filete, COR_TITULO vira título e botão cheio
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C9A85B' 'Buffet XYZ' claro '#65002F'
```

O script copia o template para a pasta destino, troca a cor de marca (CSS e
SVG inline das páginas), preenche o nome no `<title>`, regenera as letras do
preloader com o nome do cliente e, no modo claro, roda `tools/claro.js` no
`style.css`. O original nunca é alterado.

Depois disso o que sobra é trabalho manual — logo, fotos, escolher a home,
traduzir, contato, decidir quais seções sobrevivem. O script lista tudo ao
terminar.

---

## Onde ficam as cores

Há `:root` com variáveis, mas o CSS usa hex literal em quase tudo (39 `var()`
contra 300 hex). As cores que importam:

| Cor | Papel | Usos em `style.css` |
|---|---|---|
| `#FFD28D` | Dourado: título, kicker, borda, botão, linha, ícone, `stroke` de SVG | 105 (+ 58 em SVG inline nos `.html`, + 4 `rgba(255, 210, 141, x)`) |
| `#FFF` | Texto sobre fundo escuro | 88 (74 são `color:`) |
| `#4F4836` | Linha, borda, `hr` | 43 |
| `#040D10` | Fundo do body, preloader, cards | 9 |
| `#091E24` `#051114` `#05161A` | Fundo de seção alternada, rodapé | 6 |
| `#000` | Botão cheio, scrollup, paginação, acordeão | 14 |

**Escuro:** uma cor, um `sed` (o script faz).

**Claro:** `tools/claro.js` percorre regra a regra. Seletor que continua em
superfície escura (hero sobre foto, lightbox, preloader, scrollup, botão
preto, acordeão, overlay) mantém texto branco e dourado; o resto vira grafite
`#171717` no texto, `COR_TITULO` no que era dourado em `color:`, `COR` no que
era dourado em borda/fundo/traço, branco no fundo, `COR` a 10% na seção
alternada e a 40% nas linhas. Header fixo, dropdown e menu mobile trocam o
preto translúcido por branco translúcido. No fim ele anexa um bloco de
ajustes (botão cheio vira `COR_TITULO`, hero volta ao acento, formulários).

Fontes: `Baskervville` (título) + `Prompt` (corpo) via `@import` na primeira
linha do `style.css`. Trocar é uma linha — no cliente real virou Cinzel +
Great Vibes + Montserrat por cima, sem mexer no `@import`.

---

## O que já foi limpo daqui

- Renderizado de Blade para HTML por `tools/blade2html.js` (Node, sem
  dependência): resolve `@extends/@section/@php`, `<x-componente/>`,
  `asset()` → caminho relativo, `route('x')` → `x.html`
- `lang="en"` virou `lang="pt-BR"` nas 16 páginas
- `<title>Elegencia - Royale Restaurant HTML Template</title>` virou
  `<title>[NOME DO CLIENTE] — [DESCRIÇÃO CURTA]</title>`
- `<meta name="author" content="Thememarch">` removido
- `.DS_Store`, `favicon - Copy.svg`, `style.css.map` e um
  `hotel-hero-bg.png - Shortcut.lnk` (atalho do Windows que veio no zip)
- As 9 letras `E L E G E N C I A` do preloader ficaram entre marcadores
  `<!-- preloader-letras -->` para o script regenerar

**Não havia** barra de marketplace, landing de demonstração, seletor de cores
nem formulário postando para PHP — reserva e contato são `<form>` sem
`action`. O crédito do autor original no cabeçalho do `style.css` e do
`main.js` foi removido.

`html/assets/sass/` é o SCSS de origem do `style.css`. O `personalizar.sh`
troca o dourado nele também, mas o `claro.js` **não** inverte o SCSS — só o
CSS compilado.

---

## Armadilhas

**O template não tem foto nenhuma.** As 158 imagens em `assets/img/` são
PNG escuros com a dimensão escrita por cima (`1600 x 900`). Só `footer_bg.png`
(desenho de café a traço), os dois logos e os SVGs são reais. Sem foto do
cliente, o site é uma grade de retângulos azul-petróleo.

**ScrollSmoother quebra screenshot de página inteira** e âncora nativa. O
`main.js` cria `ScrollSmoother.create({ content: "#scrollsmoother-container" })`
— o conteúdo fica fixo e é transladado por JS. Para screenshot, trocar o
`ScrollSmoother.min.js` por um stub (é o que os previews usam). Para link
`#secao` numa one-page, usar `ScrollSmoother.get().scrollTo(el, true)` — o
`scrollIntoView` não chega.

**As seções só aparecem quando rolam para dentro.** GSAP com `ScrollTrigger`
anima `opacity: 0 → 1`. Screenshot sem rolar antes mostra só o hero.

**O mega menu do hambúrguer tem a cor de fundo no JS**, não no CSS:
`main.js` linha ~672, `background: "#040D10"`. No modo claro o
`personalizar.sh` troca por `COR_TITULO` com `sed`; logo e ícone do header
precisam de versão clara enquanto o menu está aberto (no cliente real isso
foi resolvido alternando por classe `mr-menu-aberto`). O header também some
ao rolar para baixo (`ak-gescout_sticky`) e volta ao rolar para cima —
comportamento do template, não bug.

**O preloader soletra o nome.** Um nome de negócio longo (~19 letras) fica
feio soletrado; a solução usada num cliente real foi trocar por símbolo +
nome em script. Se o nome tiver mais de ~10 letras, fazer o mesmo.

**As três homes compartilham `header` e `footer` com dropdown "Home 1/2/3"
e links para todas as 16 páginas.** Ao virar one-page, apagar as outras
páginas **e** limpar o header/footer — senão sobra link quebrado.

**Cabeçalho fixo de 150 px** (barra superior 70 + nav 80). O hero precisa de
`padding-top` equivalente no modo claro, porque o header deixa de ser
transparente.

**`h1..h6` são dourados por seletor global.** No modo claro viram
`COR_TITULO`; dentro do hero (sobre foto) o `claro.js` devolve o acento para
não sumir — se criar hero próprio, conferir.

**Conteúdo demo em inglês**, `info@example.com` (40x) e `1-800-915-6271`
(56x) no rodapé de todas as páginas, endereço de Montreal e mapa genérico.

**Abrir por `file://` funciona** — fontes do Google e assets locais só.

---

## Já usado em

| Cliente | Como foi usado | Resultado |
|---|---|---|
| Buffet (cliente real) | One-page sobre o `index.html` no **modo claro** (`#C9A85B` + `#65002F`): header, cards de hover, "specialties", rodapé e preloader do template; hero, galeria, reels, faixa e contato próprios em CSS à parte. Foi o cliente em que o `claro.js` nasceu | Recusou. Projeto e pasta local apagados a pedido do cliente da época — não há cópia neste pacote |
