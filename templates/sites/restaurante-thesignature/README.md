# Restaurante — Thesignature

Template HTML para restaurante, pizzaria, hamburgueria, bar e afins. 13
páginas, uma home, **base preta com textura de pedra e acento amarelo**.

**Peso:** 30 MB (era 44; ver "O que já foi limpo") · **Stack:** HTML estático +
Bootstrap 4 + jQuery · **Build:** nenhum

---

## Para que serve

Quem vende **comida e experiência de mesa**: restaurante, pizzaria,
hamburgueria, churrascaria, bar com cozinha. A home foi pensada para cardápio
com preço, reserva de mesa e chef — é um template de restaurante de salão.

Serve especialmente bem para marca **escura e quente**: já nasce com fundo
`#111111` sobre textura de pedra, título condensado em caixa alta (Oswald) e
acento amarelo `#FFCE1C`. Trocar o amarelo por laranja, vermelho ou dourado é
um `sed` — é o que o `personalizar.sh` faz.

O hero tem um **slot de foto circular** grande. Pizza, hambúrguer e prato
redondo caem nele sem recorte.

**Para que não serve:** marca de base clara (bistrô minimalista, cafeteria
clean, confeitaria pastel). O `<body>` é escuro e as 13 páginas seguem —
inverter custa mais que escrever CSS do zero. Também não serve para delivery
puro sem salão: metade das seções (reserva, chefs, avaliações) supõe mesa.

## A home

Preview de cada página em [`preview/`](preview/).

`index.html` tem, em ordem: slider de hero (4 slides, foto circular + selo
"50% OFF") · sobre com contador · 3 diferenciais em card · **reserva de mesa**
(data + pessoas) · cardápio popular em duas colunas com pílula de preço ·
avaliações em slider · galeria de cardápio · chefs · vídeo · blog ·
newsletter · rodapé com hexágono de horário.

## Páginas internas

`about` · `menu` (cardápio em duas colunas com preço riscado) · `gallery` ·
`contact` (formulário + mapa) · `team` · `services-detail` · `shop`
`shop-details` (loja, com carrinho decorativo) · `blog` `blog-grid`
`blog-left-sidebar` `blog-details`

---

## Como usar

```bash
cd templates/sites/restaurante-thesignature
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF7A16' 'Pizzaria XYZ'
```

O script copia o template para a pasta destino, troca **a cor de acento** e
preenche o nome do cliente. O original nunca é alterado.

Depois disso o que sobra é trabalho manual — logo, fotos (o template não
tem nenhuma), tradução, contato e decidir quais seções sobrevivem. O script
lista tudo ao terminar.

---

## Onde ficam as cores

Não há `:root` nem variável. Uma cor de marca só, em hex literal no CSS:

| Cor | Papel | Usos |
|---|---|---|
| `#FFCE1C` | Amarelo: botão, pílula de preço, título de destaque, hover, linha, ícone | 202 em `css/style.css` + 6 em `css/responsive.css` |
| `#FF6F1C` | Laranja do hover do botão principal | 5 em `css/style.css` |
| `#111111` | Fundo do `<body>` | 2 |
| `#000` | Fundo do cardápio e do rodapé | 4 |

Uma cor, um `sed`. É o template mais barato de recolorir dos três.

**O que o `sed` não alcança:** o selo "50% OFF" do hero (`img/bg/offer.png`)
e o hexágono "Opening hours" do rodapé (`img/bg/time-bg.png`) são **imagens
PNG com o degradê laranja pintado dentro**. Trocar a cor da marca não muda
essas duas. Ou refazer em CSS, ou trocar a imagem, ou aceitar o laranja.

Fontes: `Oswald` (títulos) e `Archivo` (corpo), via `@import` do Google Fonts
na primeira linha do `css/style.css`. Trocar é uma linha.

---

## O que já foi limpo daqui

Isso já está feito, não precisa refazer:

- `lang="zxx"` virou `lang="pt-BR"` nas 13 páginas
- `<title> Thesignatures - Restaurant HTML Template </title>` virou
  `<title>[NOME DO CLIENTE] — [DESCRIÇÃO CURTA]</title>` — slot que o
  `personalizar.sh` preenche
- O formulário de busca do menu lateral apontava para
  `http://wordpress.zcube.in/xconsulta/` (site do autor). Agora aponta para `#`
- `fontawesome/metadata`, `fontawesome/less` e `fontawesome/scss` — 14 MB de
  fonte que nenhuma página referencia. Só `fontawesome/css/all.min.css` e
  `fontawesome/webfonts/` são usados
- `.DS_Store` e `__MACOSX/`
- A documentação do autor original foi removida

**Não havia** barra de marketplace, landing de demonstração, seletor de cores
nem script de rastreamento. O logo já apontava para `index.html`.

---

## Armadilhas

**O template não tem foto nenhuma.** Todas as imagens de comida, cardápio,
chef, galeria e blog são **PNG cinza de 1,6 KB** — placeholders que o autor
deixou no lugar das fotos licenciadas. Só as texturas de fundo
(`img/bg/*-bg.png`, 12 MB) são reais. Sem foto do cliente, o site é uma
grade de retângulos cinza. Não é "trocar depois": **é a primeira coisa a
fazer**, porque o template inteiro é foto.

**Nove seções só existem preenchidas com dado inventado.** Reserva de mesa,
cardápio com preço, avaliações, chefs, blog, loja, newsletter, contador de
"anos de experiência" e o "50% OFF" do hero. Sem preço, nome de chef,
depoimento e promoção reais, apagar — não completar no chute. Num demo de
captação isso costuma reduzir a home a um terço.

**Reserva e formulário de contato postam para `mail.php`.** PHP não roda na
Vercel nem em hospedagem estática. Trocar por link de WhatsApp ou apagar o
formulário; deixar como está dá erro 404 no envio.

**As texturas de fundo pesam 12 MB.** `meal-bg.png` (3,6 MB), `header-bg.png`
(3 MB), `team-bg.png` (2,8 MB), `footer-bg.png` (1,8 MB). São PNG de textura
escura — convertidas para JPEG a 80% ficam 10 vezes menores sem diferença
visível sobre fundo preto.

**FontAwesome 5 Pro.** O CSS chama ícones `fal` (light) e `fad` (duotone),
que só existem na versão paga. Os `webfonts/` incluídos cobrem; se trocar o
FontAwesome por CDN gratuito, esses ícones somem.

**`line-height` de título.** O hero usa `1.1` (folga suficiente) mas doze
regras de título usam `line-height: 1`. Em Oswald caixa alta isso ainda
segura o til, mas é o limite — ao aumentar o peso ou trocar de fonte,
conferir qualquer título com Ã, Õ ou Ç. No Gymfito, `.92` já decepava.

**O conteúdo é demo em inglês**, e `info@example.com` e `12 3456897` aparecem
13 vezes cada, no menu lateral de todas as páginas.

**Abrir por `file://` funciona** — não há requisição same-origin bloqueada.

---

## Já usado em

| Cliente | Como foi usado | Resultado |
|---|---|---|
| Pizzaria (cliente real) | One-page sobre o `index.html` de verdade: mesma estrutura, mesmo CSS, amarelo trocado por laranja `#FF7A16`, seções sem dado real apagadas | Publicado |
