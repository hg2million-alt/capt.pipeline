# Animações 3D + estilo Luxury

Material de movimento e efeitos 3D dos demos, tirado do
`FRONT-END_CREATOR.md` (o prompt original, guardado aqui inteiro), já
implementado em **CSS + JavaScript puro, sem dependências**. Funciona dentro
do `.html` único da entrega: o `empacotar.py` embute os três arquivos.

| Arquivo | O que é |
|---|---|
| `luxury.css` | Base do **estilo Luxury** (o estilo principal): tipografia, respiro, botões, hero com foto, cards, galeria, citação, chip "a confirmar". As cores ficam em variáveis no `:root` — trocar pelas da marca. |
| `animacoes.css` + `animacoes.js` | Os efeitos dos itens 1–24 do prompt, ligados por atributo/classe. |
| `modelo/index.html` | Página-modelo one-page já montada com tudo isso. **Ponto de partida de demo construído do zero** e referência visual. |
| `FRONT-END_CREATOR.md` | Especificação original de cada animação e as regras de qualidade de front-end. |

## Como usar num demo

1. Copiar os três arquivos para o site do cliente:
   `cp animacoes-3d/{luxury.css,animacoes.css,animacoes.js} clientes/<slug>/site/assets/`
2. No `<head>`, **antes de qualquer outro script**, o script que liga as
   animações (copiar do `modelo/index.html`, bloco "1º script da página").
   Sem ele as entradas ficam desligadas (tudo aparece parado — seguro, mas
   sem efeito).
3. CSS no `<head>` (`luxury.css` só se o demo não for um template que já
   tem estilo próprio; `animacoes.css` sempre) e
   `<script src="assets/animacoes.js"></script>` no fim do `<body>`.
4. Marcar os elementos:

| Efeito (item do prompt) | Como marcar |
|---|---|
| Fade (3) | `data-anim="fade"` |
| Slide lateral (2) | `data-anim="slide"` ou `"slide-direita"` (pai com `class="anim-clip"`) |
| Rotação de entrada (4) | `data-anim="rotacao"` |
| Rise 3D (8) | `data-anim="rise3d"` — títulos, cards de destaque, formulários |
| Swing 3D / porta (9) | `data-anim="swing"` ou `"swing-direita"` (pai com `anim-clip`) |
| Spin 3D / moeda (10) | `data-anim="moeda"` — **só** logo/ícone pequeno |
| Stagger (1) / Stagger 3D (11) | no contêiner: `data-stagger` ou `data-stagger="3d"` |
| Entrada do hero só CSS (14) | `class="hero-entrada"` no bloco de texto do hero; filhos com `style="--i:0"`, `1`, `2`… |
| Hover elevado (6) | `class="hover-elevado"` |
| Tilt 3D com reflexo (12) | `data-tilt="7"` no card + filho `class="tilt-interno"` |
| Flip de card (5) | `.flip-card > .flip-faces > .flip-frente + .flip-verso`, com `<button class="flip-botao">` em cada face |
| Palco 3D na rolagem (13) | `class="palco-3d"` (print/mockup grande) |
| Vitrine automática (15) | `.vitrine-auto` com `.vitrine-item[data-nome]`, `.vitrine-barras`, `.vitrine-nome`, `button.vitrine-pausa` |
| Leque 3D flutuando (19) | `.leque-3d` com 3 filhos `style="--n:0"`, `1`, `2` |
| Marquee infinito (20) | `.marquee > .marquee-trilha > itens` (+ `data-sentido="direita"` na 2ª fileira, `button.marquee-pausa` ao lado) |
| Check sequencial (21) | `.grade-check` com um `<svg>` de ✓ em cada item |
| Arco sob palavra (22) | `<span class="arco-destaque">palavra<svg viewBox="0 0 100 10" preserveAspectRatio="none"><path d="M2 8 Q50 0 98 8"/></svg></span>` |
| Vídeo de fundo do hero (23) | `<video data-hero-video data-src="reel.mp4" poster="poster.jpg" muted playsinline>` |
| Microinterações (24) | `header.header-luxo`, `.wa-flutuante[data-depois][data-some-em]`, `<details class="faq">`, `[data-digitando]` + mensagem logo depois |

Elemento que deve animar **uma vez só** (não repetir a cada passagem):
`data-anim-uma-vez`.

## Regras de movimento (valem pra tudo — item 7 do prompt)

- Entradas em **1,5 s** com `cubic-bezier(0.22, 1, 0.36, 1)`; resposta a
  mouse/clique em 0,45 s. Ajuste global: `--anim-entrada` e `--anim-resposta`.
- As entradas **repetem** quando o bloco volta à tela.
- Sem JavaScript, com movimento reduzido no celular, ou se o script não
  iniciar em 3 s: **tudo aparece parado e legível**. Nunca esconder conteúdo
  de outro jeito.
- Discreto: 2–3 tipos de efeito por página bastam. Luxo é calma — nada
  pulando, nada girando sem motivo. Moeda (10) e leque (19) são pontuais.
- Itens **16, 17 e 18** (busca simulada "sem site/com site", flip
  sincronizado, celular com etapas) são peças de venda de site — servem pra
  página de quem vende o serviço, **não entram no demo do comércio**.
  Estão só no `FRONT-END_CREATOR.md`.

## Estilo Luxury — o padrão dos demos

- **Hero sempre com imagem de fundo**, tela cheia (`min-height: 100svh`),
  com véu escuro por cima pro texto ficar legível. A imagem é a **melhor
  foto real do negócio** (Maps/Instagram: ambiente, fachada, produto). Reel
  bom vira vídeo de fundo (item 23) com a foto como pôster. Sem foto real
  utilizável: imagem neutra (textura/ambiente que não finge ser o local) com
  o chip "imagem ilustrativa" — nunca foto de banco fingindo ser o negócio.
- Tipografia: serifada elegante e leve nos títulos (Cormorant Garamond,
  Playfair Display, Bodoni Moda) + sem serifa fina no texto (Manrope,
  Inter). Se a logo pede outra referência, adaptar mantendo esse contraste.
- Rótulos pequenos em CAIXA ALTA espaçada, linhas finas de 1 px, muito
  respiro entre seções, poucas cores.
- Cor: **a da marca** (regra da oficina), aplicada com sobriedade — fundo
  profundo (ou creme, se a marca for clara), a cor de destaque só em
  detalhes, rótulos e no botão principal.
- Fotos grandes, recorte editorial; nada de ícone colorido genérico, sombra
  pesada, gradiente chamativo ou excesso de cards.
