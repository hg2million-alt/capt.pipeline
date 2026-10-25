# Captação — pipeline de prospecção e demo automatizado (versão nuvem)

Prospecção no Google Maps, produção de identidade + site, e o loop de
aprendizado sobre o que converte em abordagem de WhatsApp — tudo orquestrado
por skills do Claude Code, **rodando 100% na nuvem** (sem computador), com uma
biblioteca de 49 templates de site prontos por categoria de negócio.

Guia passo a passo pelo celular: **`COMO-USAR.md`**.

## O que tem aqui dentro

- **`AGENTS.md`** — as regras da oficina. O Claude lê isso antes de qualquer
  peça (o `CLAUDE.md` tem só `@AGENTS.md`, que faz o Claude Code carregá-lo).
- **`.claude/skills/captar/`, `produzir/`, `resultado/`** — o pipeline:
  prospecta → produz (com aprovação humana no meio) → registra o resultado
  real e realimenta o aprendizado.
- **`.claude/skills/entregar-html/`** — empacota cada demo num único `.html`
  com o nome do comércio e envia no chat (substitui o deploy na Vercel).
- **`.claude/skills/templates-de-site/`** — como escolher e personalizar um
  template da biblioteca.
- **`.claude/setup-nuvem.sh`** + **`.claude/settings.json`** — instalam
  sozinhos, no começo de cada sessão, o que o pipeline usa (Pillow, yt-dlp,
  ffmpeg).
- **`.mcp.json`** — navegador (Playwright) usando o Chromium que já vem no
  ambiente da nuvem. Reserva sem MCP: `.claude/skills/captar/scripts/navegar.js`.
- **`templates/sites/`** — 49 templates, 11 categorias. Cada um tem
  `README.md`, `preview/` e `personalizar.sh`.
- **`captacoes/copy-base/`** — banco de copy/persuasão pra abordagem de
  WhatsApp (`INDEX.md` é o índice).
- **`captacoes/aprendizados.md`** — o "cérebro" do loop; só a skill
  `resultado` escreve aqui.
- **`animacoes-3d/`** — biblioteca de animações e efeitos 3D (do
  `FRONT-END_CREATOR.md`), base do estilo **Luxury** (`luxury.css`) e uma
  página-modelo com hero de imagem de fundo. Guia no `README.md` da pasta.
- **`_modelo/identidade.md`** — modelo em branco pra cada cliente novo.
- **`entregas/`** — os `.html` entregues, por rodada (criada na 1ª produção).

Região padrão: **Grande Natal/RN, áreas nobres** (Ponta Negra, Capim Macio,
Lagoa Nova, Tirol, Petrópolis, Nova Parnamirim…) — já preenchida no Passo 2
da skill `captar`.

## Se quiser adicionar um template novo

Siga o formato descrito em `templates/sites/README.md`: pasta
`<categoria>-<nome>/` com `README.md`, `personalizar.sh`, `preview/` e o
template em si. Atualize a tabela do `README.md` e o resumo em
`.claude/skills/templates-de-site/SKILL.md` — as duas listas precisam bater.
