---
name: entregar-html
description: Transforma o site/demo de um cliente em UM arquivo .html autossuficiente, com o nome do comércio (ex.: "Pizzaria Bella Napoli.html"), e envia o arquivo pro usuário no chat. Substitui o deploy na Vercel — nada é publicado na internet. Use SEMPRE no fim da produção de um demo, e quando o usuário pedir "me manda o html", "manda o site", "gera o arquivo do site", "reenvia o demo de fulano".
---

# Entregar HTML — o demo vira um arquivo com o nome do comércio

Não existe deploy. Cada demo sai como **um único `.html`** com tudo dentro
(CSS, JS, imagens, fontes locais e vídeos viram parte do próprio arquivo) e é
enviado ao usuário no chat. O usuário abre no celular, confere e repassa pro
prospect (ex.: como documento no WhatsApp).

## Passo 1 — O demo tem que ser uma página só

Um arquivo único não navega pra `sobre.html`, `contato.html` etc. Montar o
demo como **one-page** em `clientes/<slug>/site/index.html`: as seções que
importam (hero, serviços, galeria, avaliações, contato/WhatsApp, mapa) numa
página, com o menu apontando pra âncoras (`#servicos`, `#contato`). Templates
com várias páginas: trazer as seções úteis pro `index.html` e apagar o resto
do menu.

Templates que precisam de build (`automotivo-automec/` React/Vite): rodar
`npm install && npx vite build --base=./` e empacotar o `dist/index.html`.
`odontologia-dentia-next/` e `odontologia-dentia-php/` **não servem** nesse
modo — usar `odontologia-decare/` ou `odontologia-dentisto/`.

Os arquivos de `animacoes-3d/` copiados pra `site/assets/` (luxury.css,
animacoes.css, animacoes.js) são embutidos junto — nada extra a fazer. A foto
do hero também (reduzida pra 1600 px).

## Passo 2 — Empacotar

```bash
python3 .claude/skills/entregar-html/scripts/empacotar.py \
  clientes/<slug>/site/index.html "<Nome do Comércio>" entregas/<rodada>/
```

- O nome do arquivo é o **nome do comércio como aparece no Maps**, com acento
  e espaço normais: `entregas/2026-10-25-pizzaria/Pizzaria Bella Napoli.html`.
  O script só tira caracteres proibidos em nome de arquivo (`/ : * ? " < > |`).
- O script reduz imagem grande (máx. 1600 px) e avisa:
  - `arquivo não encontrado` → imagem/CSS faltando, corrigir o site;
  - `link para outra página virou âncora` → ainda tem link de outra página no
    menu/botões, trocar por âncora ou apagar;
  - passou de **15 MB** → tirar vídeo ou fotos sobrando (reel de fundo: 1 só).
- Google Fonts, ícones de CDN e mapa do Google continuam como link externo:
  carregam quando o celular tem internet. Isso é esperado.

## Passo 3 — Conferir o arquivo final (não o site de origem)

Abrir o **`.html` empacotado** no Playwright em 390 px de largura e tirar
screenshot do topo e de uma página inteira (`fullPage`). Olhar a imagem:
hero legível, fotos aparecendo, botão de WhatsApp com o número certo, chips
"a confirmar" visíveis onde o dado não é confirmado.

```bash
node -e "
const { chromium } = require('playwright');
(async () => {
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 390, height: 844 } });
  await p.goto('file://' + require('path').resolve(process.argv[1]), { waitUntil: 'load' });
  await p.waitForTimeout(2500);
  await p.screenshot({ path: process.argv[2], fullPage: true });
  await b.close();
})();" "entregas/<rodada>/<Nome do Comércio>.html" /tmp/conferencia.png
```

## Passo 4 — Enviar pro usuário

Enviar o arquivo com a ferramenta **`SendUserFile`** (`display: "attach"`),
legenda curta com o nome do comércio. Quando forem vários da mesma rodada,
mandar todos numa chamada só. O caminho do arquivo também vai na tabela final
da `produzir`.

Depois, salvar no repositório (ver "Salvar o trabalho" no `AGENTS.md`) — sem
isso o arquivo some quando a sessão na nuvem fecha.

## Antipattern

- ❌ Mandar o `index.html` cru da pasta `site/` — sem a pasta `assets/` ao lado
  ele abre sem CSS e sem foto.
- ❌ Nome de arquivo genérico (`index.html`, `site.html`, `demo-1.html`).
- ❌ Conferir só o site de origem e não o arquivo empacotado.
- ❌ Demo com várias páginas — no arquivo único os links quebram.
