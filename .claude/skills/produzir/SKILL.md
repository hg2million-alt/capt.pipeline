---
name: produzir
description: Produz, em paralelo, os clientes aprovados no dossiê de captação — cria identidade.md com procedência de cada dado, constrói o demo (site via template de nicho, ou CRM/dashboard simples quando o gap pedir), usa a identidade real da marca (cor, logo, fotos e vídeos do negócio), testa mobile, empacota cada demo num único .html com o nome do comércio, envia os arquivos pro usuário no chat e escreve a abordagem com base no banco de copy. Use SEMPRE depois que o usuário aprovar candidatos de um dossiê gerado pela skill `captar` — nunca antes. Gatilhos: "/produzir", "produz os aprovados", "bora fazer os demos", "roda a produção da rodada".
---

# Produzir — produção paralela pós-aprovação

Segunda etapa do pipeline `/captar → aprovação humana → /produzir → /resultado`.
Só roda depois que o usuário aprovou candidatos de um `dossie.md`. Se não houver
aprovação explícita na conversa, parar e perguntar antes de gastar produção.

## Uso

```
/produzir                          ← localiza a rodada mais recente com aprovação
/produzir captacoes/2026-10-01-pizzaria
```

## Passo 1 — Preparar o contexto comum

Antes de disparar os subagentes, ler uma vez e ter pronto pra passar a cada um:

- O `dossie.md` da rodada e quais candidatos/formatos foram aprovados (e vetos).
- `AGENTS.md` (regras da oficina: identidade antes de produzir, nunca inventar
  serviço/preço/número/depoimento, marcar ilustrativo, demo one-page entregue
  como .html com o nome do comércio).
- `captacoes/aprendizados.md` — hipóteses ativas/confirmadas sobre o que
  funciona em abordagem, pra repassar a cada subagente.
- `captacoes/copy-base/INDEX.md` (ver Passo 2.5). Se não existir, avisar o
  usuário antes de começar que as abordagens vão sair provisórias.

## Passo 2 — Um subagente por prospect aprovado, em paralelo

Disparar via Agent tool (`general-purpose`), **todos na mesma mensagem** pra
rodar concorrente. Cada subagente recebe: a seção do dossiê daquele prospect, o
resumo das regras do AGENTS.md, os aprendizados ativos relevantes, e o caminho
do `INDEX.md` de copy (se existir). Instruções do subagente:

### 2.1 — Identidade primeiro

Copiar `_modelo/identidade.md` para `clientes/<slug>/identidade.md`. Preencher
**com a procedência de cada dado entre parênteses** — `(Maps)`, `(site do
cliente)`, `(review)`, `(bio do Instagram)`, `(extraída da logo)`. O que não
veio de nenhuma fonte fica `*a definir*`, nunca chutado. Slug em minúsculo sem
acento.

**Marca — obrigatório:** o demo sai com a identidade real do negócio. As cores
vêm da paleta da logo que está no dossiê — escolher qual é fundo, qual é
acento e qual é texto, e anotar de onde saiu (logo do Instagram, foto do Maps,
arte do Facebook). Tipografia: a referência anotada no dossiê vira uma fonte
do Google Fonts do mesmo estilo, anotada como aproximação. Cor provisória só
quando o dossiê diz que não há logo em fonte nenhuma — e fica escrito isso.
Se o template nasceu com outra cor ou fonte, trocar: demo com cara de
template é o que esta etapa existe pra evitar.

### 2.2 — Assets

Copiar `captacoes/<rodada>/assets/<slug-provisorio>/` para
`clientes/<slug>/assets/`. Reviews citáveis só entram no demo marcados como
citação de avaliação — nunca como depoimento genérico sem fonte.

**Reels:** baixar os reels selecionados no dossiê com
`python3 .claude/skills/captar/scripts/material.py reel "<url>" clientes/<slug>/assets/video/`
— sai `.mp4` de até 15 s, 540 px, sem áudio (~1,5 MB) + um poster `.jpg`.
Reel com legenda grande queimada no vídeo não serve de fundo; o poster de
reel limpo serve como foto.

### 2.3 — Construir o demo

**Ler `identidade.md` antes de qualquer peça** (regra do AGENTS.md — é de lá
que saem cor, tipografia e tom).

- **Formato aprovado = site:** consultar skill `templates-de-site`, usar
  `personalizar.sh` do template do nicho. Sem template pro nicho → construir do
  zero e, ao final, **empacotar como template novo** na biblioteca (README +
  `preview/` + `personalizar.sh` + entrada no catálogo — não deixar pra depois).
- **Formato aprovado = CRM/dashboard simples:** consultar templates de
  CRM/dashboard na biblioteca, se já existirem. É demo: funcionalidade mínima
  que sustente a conversa (ex.: uma tela de agenda ou pipeline visual com dados
  ilustrativos marcados), nunca um produto completo. Sem template disponível,
  construir o mínimo funcional do zero e também empacotar ao final.
- **Mídia real no lugar dos placeholders:** foto e reel do próprio cliente
  entram nos slots do template (hero, galeria, seção de reels). Placeholder
  só onde não houver material — e aí continua rotulado. Nunca ampliar a logo
  de 150 px até ela borrar: usar pequena (avatar redondo, rodapé) ou recriar o
  nome em tipografia com as cores dela.
- **One-page:** o demo é uma página só (`clientes/<slug>/site/index.html`),
  com menu por âncoras — o arquivo final é único e não navega entre páginas
  (detalhes na skill `entregar-html`).
- **`<meta name="robots" content="noindex">`** em todo demo: a página usa
  foto e vídeo do Instagram de alguém que ainda não pediu nada — se um dia
  for parar num site, não deve aparecer no Google.
- **Mobile em primeiro lugar sempre:** testar redimensionando pra ~390px
  (Playwright resize + screenshot) antes de dar por pronto — badge/flex
  quebrando frase, hero sem overlay sólido em foto real, altura sobrando no
  mobile são os defeitos que não aparecem em desktop.
- Dado que falta e não tem como confirmar entra **visivelmente marcado como
  ilustrativo** (chip "a confirmar" ou equivalente) — nunca sem aviso.

### 2.4 — Empacotar em .html (sem deploy)

Skill `entregar-html`: empacotar `clientes/<slug>/site/index.html` em
`entregas/<rodada>/<Nome do Comércio>.html` com o `empacotar.py`, resolver os
avisos que ele imprimir e conferir o **arquivo empacotado** em 390 px
(screenshot). Não publicar em lugar nenhum — nada de Vercel. O subagente
devolve o caminho do `.html` final; quem envia pro usuário é o agente
principal, no Passo 3.

### 2.5 — Escrever a abordagem

**Base: o banco de copy em `captacoes/copy-base/`.** Ler o `INDEX.md` e ir
direto no que serve àquele prospect (abertura, gancho, objeção provável) — não
ler o banco inteiro. É base, não doutrina: adaptar ao seu próprio tom de voz
(quem você é, sua cidade/região, o jeito que você conversa — igual pra igual,
não formal de call center) e ao registro do prospect. Se não existir um
modelo de abordagem fixo no projeto, não inventar um formato rígido de
memória — escrever direto a partir do banco de copy e do gancho do dossiê.

Somar ao banco os `aprendizados.md` ativos (o que já funcionou ou falhou em
envio real).

Regras que valem com ou sem banco:
- O gancho vem **direto do gap verificável do dossiê** — usar o que já foi
  checado na prospecção, não reescrever nem exagerar.
- Nunca citar outro cliente do mesmo nicho; nada de dado inventado.
- Não existe link: o demo vai como **arquivo** (o `.html`). A mensagem pede
  permissão antes ("posso te mandar? é um arquivo, abre direto no celular") e
  o arquivo vai logo depois do "pode". Pensada em balões curtos de WhatsApp.
- Número de telefone do prospect em formato `+55 84 9XXXX-XXXX`.

**Se `copy-base/INDEX.md` ainda não existir:** escrever uma versão simples
(apresentação, gancho, oferta de mandar o arquivo) e entregar marcada como **provisória — sem base de
copy**, avisando que o banco não chegou.

O `abordagem.md` inclui também follow-ups (se o banco trouxer cadência), as
objeções previsíveis com resposta, e **quais técnicas do banco foram usadas**
(arquivo e trecho) — é isso que o `/resultado` cruza com a resposta real.

### 2.6 — Nota sobre o paralelo

Cada subagente escreve só em `clientes/<slug>/` e no próprio
`entregas/<rodada>/<Nome do Comércio>.html` — não mexe em arquivo de outro
cliente nem faz commit (o commit é do agente principal, no Passo 5).

## Passo 3 — Consolidar a entrega

Depois que todos os subagentes terminarem, montar uma tabela final:

| Prospect | Arquivo do demo | Onde está a abordagem |
|---|---|---|
| ... | `entregas/<rodada>/<Nome do Comércio>.html` | `clientes/<slug>/abordagem.md` |

**Enviar todos os `.html` da rodada pro usuário** com `SendUserFile`
(`display: "attach"`, todos numa chamada só) — é assim que os sites chegam
nele. Apontar o caminho não substitui o envio.

**A abordagem vai no chat, em texto, sempre** — o arquivo `abordagem.md` é
registro, não entrega. Pra cada prospect, logo abaixo da tabela: a mensagem
inteira, cada balão de WhatsApp no seu bloco de código, com o número de
destino em cima, seguida dos follow-ups. Link de
arquivo no lugar do texto não conta. Vale também pra qualquer abordagem
reescrita ou ajustada depois.

## Passo 4 — Atualizar fase

Em cada `identidade.md` produzido, atualizar `## Fase` pra `demo entregue
(.html) / abordagem enviada` (ajustar conforme o estado real).

## Passo 5 — Salvar no repositório

Rodar o "Salvar o trabalho" do `AGENTS.md` (commit + push de `clientes/`,
`entregas/` e da rodada). Na nuvem, o que não foi pro GitHub some quando a
sessão fecha.

## Depois de enviar

Lembrar o usuário: o retorno de cada envio (respondeu? abriu? objeção?) volta
pra skill `resultado` — é isso que fecha o loop de aprendizado da próxima rodada.
