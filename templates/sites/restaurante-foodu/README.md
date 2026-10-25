# Restaurante — Foodu

Template multi-página de restaurante/fast-food, comprado como "Foodu - Food &
Restaurant HTML Template" (v1.7). 33 páginas, **12 homes** (6 claras +
6 escuras), base **vermelho + laranja**, título em Oswald + corpo em Jost.

**Peso:** 25 MB em `html/` · **Stack:** HTML estático + Bootstrap 5 + jQuery +
GSAP/ScrollTrigger/SplitText + Swiper + Isotope + WOW.js/animate.css ·
**Build:** nenhum — abre direto, sem npm/node

---

## Para que serve

Restaurante, hamburgueria, fast-food, pizzaria de salão — negócio com
**cardápio de verdade, mesa e reserva**, não só delivery por WhatsApp. Vem com
cardápio filtrável por categoria (`food-menu.html`, 3 variações de layout),
página de reserva (`reservation.html`), chef/equipe, galeria, blog completo e
até uma pequena loja (`shop.html`) para quem vende produto físico (molho
engarrafado, kit, merchandising).

**Para que não serve:** pizzaria/lanchonete que só atende por WhatsApp e não
tem salão nem reserva — nesse caso usar `pizzaria-onepage/`, que já nasce
enxuta e com CTA direto pro `wa.me`. Também não serve pronto pra e-commerce
sério (o carrinho/checkout é decorativo, ver Armadilhas).

## Páginas

Preview de 8 páginas-chave em [`preview/`](preview/) — as outras 25 são
variação de layout ou conteúdo de apoio (blog, loja, homes alternativas).

| Página | O que tem |
|---|---|
| `index.html` | Home clara — hero com carrossel (oferta + ilustração de prato), categorias de menu, cardápio com abas, faixa de reserva, pratos em destaque, depoimentos, equipe, banner de app, blog recente, Instagram, rodapé |
| `index-dark.html` | Mesma home, só com `<body class="bg-dark-secondary">` — troca o fundo das seções pra escuro. É a ÚNICA diferença entre versão clara/escura de cada home (ver Armadilhas) |
| `index-2.html` … `index-6.html` | 5 layouts alternativos de home (hero cheio de tela, hero com vídeo, layout com sidebar de categoria etc.) — e os mesmos 5 em `index-dark-2..6.html` |
| `food-menu.html`, `-2`, `-3` | Cardápio completo com filtro por categoria (Isotope) em 3 layouts diferentes |
| `reservation.html` | Formulário de reserva sozinho — mesmo form da home, decorativo (ver Armadilhas) |
| `gallery.html` | Grade de fotos filtrável |
| `chef.html` / `chef-details.html` | Equipe de cozinha em carrossel / perfil individual |
| `about-us.html` | Texto institucional + categorias + "Club"-like info |
| `contact.html` | Único form com backend real (PHP) + mapa embutido |
| `blog-*.html` (6 variações) | Grade 2/3 colunas, com/sem sidebar, post único |
| `shop.html`, `shop-single*.html`, `cart.html`, `checkout.html` | Loja de produto físico genérica do pacote — ver Armadilhas (pra que não serve) |
| `404.html` | Página de erro |

**Removidas desta cópia:** `login.html` e `register.html` — eram sobra de um
template *diferente* comprado pelo mesmo autor ("Agrica — Organic Farm
Agriculture Template"), copiados sem trocar título/preloader/branding. Sem
uso real num demo de restaurante, e mantinham a marca errada — apagadas em
vez de corrigidas.

---

## Como usar

```bash
cd templates/sites/restaurante-foodu
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Restaurante XYZ'

# escolhendo uma home diferente da index.html padrão como home final:
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#C0392B' 'Restaurante XYZ' index-dark
```

O script copia `html/`, troca a cor primária no `:root` do CSS e troca todo
texto "Foodu" (título, meta description, rodapé) pelo nome do cliente. O
original nunca é alterado. Ao final ele imprime a lista de pendências manuais
(logo, formulário morto, fotos placeholder, etc. — replicada na seção
Armadilhas abaixo).

## Onde fica a cor de marca

Só duas variáveis CSS, no bloco `:root` de `assets/css/style.css` (linha
~84), **confirmado 100% via `var()`** — nenhum hex solto duplicado em CSS, JS
ou HTML inline em todo o pacote:

| Variável | Valor original | Papel |
|---|---|---|
| `--color-primary` | `#EB0029` (vermelho) | Botão, preço, hover, faixa do hero, gradiente |
| `--color-secondary` | `#f76e2a` (laranja) | Detalhe do gradiente (`--bg-gradient`), menos usado |

`--black`, `--dark`, `--dark-secondary`, `--white`, `--color-heading`,
`--color-paragraph` são neutros de texto/fundo, não cor de marca — o script
não mexe neles. Fontes via `@import` no topo do mesmo arquivo: Oswald
(título), Jost (corpo), Dancing Script (cursiva ocasional).

---

## Armadilhas (já corrigidas nesta cópia, documentadas pro caso de precisar mexer na mão)

- **E-mail pessoal do autor recebendo o formulário de contato.**
  `assets/mail/contact.php` tinha `$address = "mshohaghm6@gmail.com"` — o
  Gmail pessoal de quem fez o template receberia qualquer mensagem enviada
  pelo site de QUALQUER cliente que usasse essa cópia sem notar. Trocado por
  um placeholder com aviso (`TROCAR-ANTES-DE-PUBLICAR@dominio-do-cliente.com`
  + comentário `// TODO`). **Mas isso não resolve o problema de fundo: é
  PHP, e a Vercel não roda PHP** — sem hospedagem própria, o form não envia
  nada de qualquer forma. Trocar a ação por um link `wa.me` antes de
  publicar, não só o e-mail.
- **E-mail comercial do autor exposto como contato do site.**
  `support@validtheme.com` aparecia como e-mail de contato visível em 6
  páginas (as 6 homes que têm a barra de topo com telefone/e-mail) —
  substituído por `contato@SEUDOMINIO.com` em todas.
- **Formulários de reserva são 100% decorativos, isso NÃO é um bug
  introduzido na limpeza** — todo `<form class="reservation-form">` (8
  páginas, inclusive a home) já vinha com `action="#"` no template original,
  sem NENHUM backend, nem JS de envio. Preencher e clicar "reservar" não faz
  nada. Antes de publicar: ligar num `wa.me` com os campos preenchidos
  (padrão já usado no `barbearia-trimly/`) ou trocar o botão por link direto
  de WhatsApp.
- **Logo é a palavra "FOODU" desenhada dentro do PNG**, não texto —
  `assets/img/logo.png`, `logo-light.png`, `logo-light-2.png`,
  `logo-icon.png` e `logo-3.png` (chapéu de chef + talheres num círculo
  vermelho + "FOODU" em caixa alta). Não sai em find/replace de nome; trocar
  o arquivo pela logo real do cliente, mesmo nome.
- **RTL vinha incluso, mas nunca ligado por padrão** — o zip original se
  anunciava como versão com suporte a árabe/hebraico ("Added RTL Version",
  `whats new.txt`), ativado só se alguém somasse a classe `rtl` no `<body>`
  manualmente. Mesmo dormente, o bloco inteiro (~1.100 linhas, do comentário
  `# RTL Styles` até o fim de `assets/css/style.css`) foi **removido** desta
  cópia — direção sempre LTR, sem depender de ninguém não ativar a classe.
- **Leftover de outro template comprado.** `login.html`/`register.html`
  tinham `<title>Agrica - Organic Farm Agriculture Template</title>` e um
  `#agrica-preloader` — nunca foram adaptados pro Foodu. Removidos da cópia
  (ver seção Páginas).
- **"Author: validtheme" em comentário de cabeçalho** removido de
  `assets/css/style.css`, `assets/css/validnavs.css` e do `style.css` da
  raiz (esse último é um arquivo quase vazio, só com o comentário de
  cabeçalho — ficou como hook pra CSS extra do cliente, se precisar).
  Restam ~50 nomes de classe internos tipo `.validtheme-shop-area`,
  `.validthemes-in-stock` em `shop.css`/`shop.html`/`index.html` — são só
  seletor CSS, invisível pro visitante, não mexido (renomear quebraria a
  loja sem ganho nenhum).
- **`<html lang="en">` → `"pt-BR"`** em todas as páginas. `<title>` perdeu o
  sufixo " HTML Template" (virou "Foodu — Restaurante", depois o
  `personalizar.sh` troca "Foodu" pelo nome do cliente).
- **Todas as 205 imagens de `assets/img/` são placeholder cinza** com a
  dimensão escrita dentro (ex. "1500X1875", "600X600") — nenhuma foto real
  de prato, chef ou fachada. Exceção: `assets/img/illustration/` (19 PNGs)
  são ilustrações genéricas reais (prato/burger/pizza em arte, fundo
  transparente) usadas no hero — não são placeholder, mas também não são
  foto do cliente, então continuam genéricas até trocar.
- **Telefone/e-mail fake do template** (`+4733378901`,
  `food@restan.com`) — não é dado pessoal de ninguém, mas também não é real;
  aparece na barra de topo e em `contact.html`. Trocar pelo contato real do
  cliente ou marcar "a confirmar".
- **Home clara vs. escura é só uma classe.** `index-dark.html` difere de
  `index.html` só por `<body class="bg-dark-secondary">` — a faixa vermelha
  do hero fica igual nos dois modos (é cor de marca, não tema), a diferença
  aparece no fundo das seções abaixo. Escolher UMA antes de publicar (12
  homes juntas não fazem sentido no ar) — o `personalizar.sh` aceita o nome
  da home como 4º argumento.
- **Páginas de loja (`shop*.html`, `cart.html`, `checkout.html`) são
  genéricas do pacote**, sem nada de comida-específico — normalmente fora do
  escopo de demo de captação (cliente não pediu e-commerce). Considerar
  remover do menu se não for usar.

## Preview

`preview/` cobre 8 páginas (screenshot do topo — hero + primeira seção, sem
rolar até o fim, por limite do ambiente que gerou os prints): `index.jpg`,
`index-dark.jpg`, `food-menu.jpg`, `reservation.jpg`, `gallery.jpg`,
`chef.jpg`, `about-us.jpg`, `contact.jpg`. As outras 25 páginas (blog, loja,
homes 2–6, 404) não têm preview — abrir o `.html` direto pra conferir.

## Já usado em

Nenhum cliente ainda — entrou na biblioteca em 26/09/2026.
