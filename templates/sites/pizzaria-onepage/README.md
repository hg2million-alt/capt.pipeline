# Pizzaria — one-page

One-page de pizzaria pronta para virar demo de captação. É a forma que o
site da Fornão tomou (14/09/2026), **sem nada da Fornão**: foto, logo, texto,
telefone e cor foram trocados por placeholder rotulado. Deriva do
[`restaurante-thesignature/`](../restaurante-thesignature/) — mesmo CSS e JS
do template, mais uma folha própria de 19 KB por cima.

**Peso:** 3,6 MB · **Stack:** HTML estático + Bootstrap 4 + jQuery ·
**Build:** nenhum · **Deploy:** `vercel.json` incluso

---

## Para que serve

Pizzaria, esfiharia, hamburgueria, lanchonete com delivery — negócio de
comida que vende por **WhatsApp, app ou salão**, tem Instagram com reel, e
ainda não mandou cardápio. Nasce **preto com uma cor de acento**, título
condensado em caixa alta, e já vem com as decisões que um demo de captação
precisa:

- **Cardápio ilustrativo, marcado** — selo amarelo, aviso em texto, pílula
  de preço vira botão *PEDIR*. Nenhum preço no site
- **Selos "a confirmar"** para endereço, horário, @ e link do app
- **Aviso de demonstração** no rodapé dizendo de onde cada dado saiu
- Reels verticais com autoplay ao entrar na tela e `preload="none"`
- Botão flutuante de WhatsApp e `wa.me` em todo CTA

**Para que não serve:** restaurante de mesa com reserva e chef (usar o
`restaurante-thesignature/` inteiro), marca de base clara, quem já tem
cardápio digital que quer embutir.

## Seções

Preview em [`preview/`](preview/) — desktop e celular.

| # | Seção | `id` | O que precisa do cliente |
|---|---|---|---|
| — | Header | — | Logo (vai numa placa da cor de acento, inclinada) |
| 1 | Hero | `#home` | Frase da marca em duas linhas, **foto de pizza vista de cima** (cai no círculo), ano de fundação |
| — | Faixa corrida | — | Nada — trocar as palavras se a marca tiver as dela |
| 2 | A casa | `#casa` | 3 fotos do lugar, 1 parágrafo, 3 bullets |
| 3 | Como pedir | `#pedir` | Delivery · App · Salão — apagar o card que não existir |
| 4 | Cardápio | `#cardapio` | 8 itens de exemplo em 2 grupos. Fotos de 4, placeholder de 4 |
| 5 | O espaço | `#espaco` | 6 fotos com legenda |
| 6 | No Instagram | `#instagram` | 3 reels + posters |
| 7 | Contato / rodapé | `#contato` | WhatsApp, 2º telefone, endereço, horário, @ |

---

## Como usar

```bash
cd templates/sites/pizzaria-onepage
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#FF7A16' 'Pizzaria XYZ' '5533999990000'
```

O script copia, troca as **três cores** (acento, apoio, hover — as duas
últimas derivadas da primeira se não forem passadas), o nome e o número de
WhatsApp dos links `wa.me`. No fim ele lista os slots `[ASSIM]` que
continuam abertos no `index.html` e o trabalho manual. O original nunca é
alterado.

Depois: fotos com o mesmo nome dos placeholders, reels em `assets/video/`,
textos, e **apagar toda seção que o cliente não tem material para
sustentar** — regra da fábrica: seção cinza não vai ao ar.

---

## Onde ficam as cores

Três cores em hex literal, todas trocadas pelo `personalizar.sh`:

| Cor | Papel | Onde |
|---|---|---|
| `#FFCE1C` | Acento: placa do logo, botões, faixa, pílula PEDIR, selos, anel do hero | `css/style.css` (202) + `assets/css/pizzaria.css` (`--acento` + 2 `rgba`) |
| `#FFE27A` | Apoio: kicker, selos "a confirmar", topo dos degradês | `assets/css/pizzaria.css` (`--apoio` + 1 `rgba`) |
| `#FF6F1C` | Hover dos botões | `css/style.css` + `assets/css/pizzaria.css` (`--hover`) |

`--preto #050505` e `--branco` não são trocados. Fontes: Oswald + Archivo
via `@import` na primeira linha do `css/style.css`.

---

## Placeholders

Todo `assets/img/*.svg` é um retângulo escuro com o rótulo do que vai ali
e o tamanho de referência. Trocar pelo arquivo do cliente **com o mesmo
nome** (a extensão pode mudar — ajustar o `src`):

| Arquivo | Vai ali | Tamanho de referência |
|---|---|---|
| `logo-preto.svg` | Logo escuro, na placa do header | 700×385, fundo transparente |
| `logo-branco.svg` | Logo claro, no rodapé | 700×385 |
| `simbolo-preto.svg` / `simbolo-branco.svg` | Símbolo da marca sozinho: kicker, selo da colagem, placeholder do cardápio, hexágono | 350×185 |
| `favicon.svg` | Ícone da aba | 128×128 |
| `hero-pizza.svg` | Pizza vista de cima — **a foto mais importante** | 720×720 |
| `fachada.svg` `neon.svg` `salao.svg` | Colagem da seção "A casa" | 720×520 · 460×400 · 720×520 |
| `kids.svg` `externa-mesas.svg` `delivery.svg` | Galeria | 320×480 · 260×520 · 360×360 |
| `item-1.svg` `item-2.svg` `item-5.svg` `item-6.svg` | Foto redonda dos itens 1, 2, 5 e 6 do cardápio | qualquer, corta em círculo |
| `poster-reel-1..3.svg` | Poster dos 3 reels | 480×854 |

`assets/video/reel-1.mp4`, `reel-2.mp4`, `reel-3.mp4` **não existem** — sem
reel real, apagar a seção `#instagram`.

---

## Armadilhas (herdadas do Thesignature, já resolvidas aqui)

- `.slider-content { margin-left: -150px }` — zerado no `.hero-texto`
- `.btn.ss-btn i` é círculo absoluto à direita — `padding-right` ajustado
- `.f-contact i` vira bolinha laranja flutuada — neutralizado
- `meanmenu` esconde só o `<ul>` — borda fica no `ul`, não no `.mean-nav`
- Cardápio no celular era coluna centralizada — refeito em linha
- FontAwesome já veio enxuto: só `all.min.css` + `woff/woff2` (1,7 MB)

**O que continua valendo:** títulos com `line-height: 1` seguram o til em
Oswald, mas é o limite — conferir Ã/Õ/Ç se trocar a fonte. E "esfiha" está
escrito em quatro lugares (kicker, faixa, bullet, cardápio): pizzaria que
não vende esfiha precisa tirar dos quatro.

---

## Já usado em

| Cliente | Como foi usado | Resultado |
|---|---|---|
| Pizzaria (cliente real) | É a origem desta variante — o site dela foi construído sobre o `restaurante-thesignature/` e depois generalizado para cá | Publicado |
