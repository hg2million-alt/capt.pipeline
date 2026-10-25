# Captação — sites e demos para prospects

Workspace de produção. Chega a identidade de um prospect, sai um demo de site
**num único arquivo `.html` com o nome do comércio**, entregue ao usuário no
chat — é a peça de captação. Nada é publicado na internet (sem Vercel).

Território: **Grande Natal/RN (DDD 84)**, foco em áreas nobres — Ponta Negra,
Capim Macio, Lagoa Nova, Tirol, Petrópolis, Nova Parnamirim etc. (lista
completa no Passo 2 da skill `captar`).

## Ambiente: roda 100% na nuvem

O usuário **não tem computador**: tudo roda no Claude Code na nuvem
(claude.ai/code ou app do celular), e este projeto vive num repositório do
GitHub que cada sessão nova clona do zero. Consequências:

- **O que não vai pro GitHub some** quando a sessão fecha. Ver "Salvar o
  trabalho" abaixo.
- Pillow, yt-dlp e ffmpeg são instalados sozinhos no começo da sessão
  (`.claude/setup-nuvem.sh`, hook em `.claude/settings.json`).
- Navegador: MCP do Playwright (`.mcp.json`, Chromium já instalado no
  ambiente). Se as ferramentas `mcp__playwright__*` não aparecerem, usar
  `node .claude/skills/captar/scripts/navegar.js` (mesma função, sem MCP).
- Arquivos chegam ao usuário pela ferramenta `SendUserFile` — ele não tem
  pasta local pra abrir. Nunca responder "o arquivo está em tal pasta" como
  entrega.
- Não pedir pro usuário rodar comando, instalar programa ou editar arquivo
  à mão: ele só conversa. Se precisar mudar algo no projeto, fazer e salvar.

## Salvar o trabalho

No fim de cada `/captar`, `/produzir` e `/resultado` (e depois de qualquer
mudança que o usuário pedir no projeto):

```bash
git add -A && git commit -m "<o que foi feito: rodada/cliente>" && git push -u origin HEAD
```

Se o push falhar por rede, tentar de novo algumas vezes. Se falhar por
permissão, avisar o usuário — o trabalho da sessão ainda não está salvo.

Isto é a oficina, não o escritório: aqui só vive o que é preciso pra prospectar,
montar o demo e abordar. Se você já tem (ou vai criar) um workspace separado
pra proposta, contrato assinado, cobrança e relacionamento comercial, mantenha
os dois separados — não duplicar cliente nos dois papéis.

## O processo

1. **Identidade** — o cliente manda marca, fotos, textos. Vai para
   `clientes/<slug>/identidade.md`, e os arquivos para `clientes/<slug>/assets/`
2. **Demo** — o site é construído em `clientes/<slug>/site/` (uma página só)
   e empacotado em `entregas/<rodada>/<Nome do Comércio>.html`, que é
   enviado ao usuário no chat (skill `entregar-html`)
3. **Abordagem** — a mensagem de WhatsApp que apresenta o demo vai para
   `clientes/<slug>/abordagem.md`
4. **Contrato** — se fechar, `clientes/<slug>/contrato.md`

As etapas 3 e 4 só existem quando chegarem. Não criar arquivo vazio esperando.

## Cliente novo

Copiar `_modelo/identidade.md` para `clientes/<slug>/` e preencher com o que
o cliente mandou. Slug em minúsculo e sem acento: `barbearia-abc`, `oticax`.

## Abordagem

A base de escrita é o banco de copy/persuasão em `captacoes/copy-base/`
(consultado pelo `INDEX.md`). É base, não doutrina — adaptar ao seu próprio
tom de voz e ao registro do prospect. Conforme novas fontes de copy chegarem,
cada uma vira arquivo novo na pasta e entra no `INDEX.md`.

Regras que não dependem do banco: o gancho tem que ser um fato verificável do
prospect, levantado na prospecção; nunca citar outro cliente do mesmo nicho;
nada de dado inventado.

A abordagem é sempre entregue no chat, em texto, um bloco por balão de
WhatsApp, pronta pra copiar. O `abordagem.md` é registro; apontar o arquivo
não substitui o texto.

## Regras

- **Antes de produzir qualquer peça, ler o `identidade.md` do cliente.** É de lá
  que saem cor, tipografia, tom de voz e o que a marca não faz.
- **O demo usa a identidade real da marca.** Cor e tipografia vêm da logo;
  logo, fotos e vídeos do próprio negócio entram no lugar dos placeholders
  sempre que existirem. Cor provisória só quando não há logo em lugar nenhum
  (Instagram, fotos do Maps, Facebook) — e fica declarada como tal.
- Nunca usar asset, cor ou texto de um cliente em peça de outro.
- Não inventar serviço, preço, número ou depoimento que não esteja no
  `identidade.md`. Em demo, o que não se sabe entra visivelmente marcado como
  ilustrativo — telefone falso sem aviso queima a primeira impressão.
- Antes de começar site do zero, conferir a biblioteca de templates por nicho
  (skill `templates-de-site`).
- Entrega: **um `.html` por cliente, com o nome do comércio** (skill
  `entregar-html`) — nunca deploy na Vercel ou em outro host. Demo one-page,
  porque o arquivo único não navega entre páginas.
- Telefones no formato `+55 84 9XXXX-XXXX`; botão de WhatsApp com
  `https://wa.me/5584...`.

## Captação automatizada

O processo acima também roda por um pipeline de três skills:
`/captar` (prospecta no Google Maps por nicho + região, filtra quem é bom
negócio com um gap verificável, devolve `captacoes/<rodada>/dossie.md`) →
**aprovação humana** dos candidatos e do formato de demo → `/produzir` (um
subagente por aprovado, em paralelo: identidade com procedência, demo
mobile-first com a marca e as mídias reais, `.html` com o nome do comércio
enviado no chat, abordagem) →
`/resultado <slug>` (cola a conversa real; extrai sinais e fecha o loop).

`captacoes/aprendizados.md` é o cérebro do loop — hipóteses com placar sobre o
que converte. **Só `/resultado` escreve nele**; `/captar` e `/produzir` só leem.
`captacoes/mercado.md` é o estudo de mercado (nichos aquecidos + gap típico por
nicho) da Grande Natal — não vem pronto neste pacote; a skill `/captar` escreve o
primeiro na primeira vez que rodar, e renova sozinha a cada 14 dias.

A região padrão (Grande Natal, bairros nobres) já está preenchida no "Passo 2"
da skill `captar`.

Descoberta de prospect é via Playwright no Maps (zero custo/setup). Se isso se
mostrar frágil na prática, uma alternativa é migrar só a descoberta para a
Google Places API — o resto do pipeline não muda.

## Templates

A biblioteca fica em `templates/sites/` (é consultada pela skill
`templates-de-site`). Está agrupada por **categoria ampla**, não por nicho
fechado — um template de "carro" serve qualquer negócio de carro, um de
diarista pode virar site de encanador, dentista e nutricionista dividem
categoria, barbearia já serve salão, pizzaria e restaurante são a mesma
categoria. Cada categoria tem pelo menos 2 templates de propósito, pra variar
— **não repetir o mesmo template pro 2º/3º cliente seguido da mesma
categoria** quando existe alternativa, e misturar seções de templates da
mesma categoria ("frankenstein": hero de um + galeria de outro) é permitido e
incentivado. Detalhe completo, com todas as armadilhas por template, em
`templates/sites/README.md`.

| Categoria | Pastas | Qtde |
|---|---|---|
| Serviço residencial / reparo doméstico (encanador, eletricista, diarista, limpeza, climatização) | `manutencao-handify/`, `manutencao-qlinest/`, `limpeza-laun/`, `climatizacao-coolair/`, `climatizacao-oyoxo/` | 5 |
| Imóveis, arquitetura e construção | `imoveis-lemanhouse/`, `imoveis-quicksale/`, `imoveis-domira/`, `arquitetura-axisbuilt/`, `construcao-construc/`, `construcao-renova/` | 6 |
| Beleza e estética pessoal (barbearia, salão, estética) | `barbearia-trimly/`, `barbearia-barberon/`, `barbearia-qutter/`, `barbearia-hairbarber/`, `estetica-haircare/`, `estetica-spamagic/` | 6 |
| Corpo em movimento — fitness (academia, personal trainer) | `academia-gymfito/`, `personal-progym/`, `personal-fitmas/`, `personal-samantha/` | 4 |
| Saúde e bem-estar clínico (odontologia, nutrição, psicologia) | `odontologia-decare/`, `odontologia-dentisto/`, `odontologia-dentia-php/`, `odontologia-dentia-next/`, `saude-clinicmaster/`, `saude-counseling/`, `saude-mentalpress/` | 7 |
| Advocacia / serviços jurídicos | `advocacia-solven/`, `advocacia-lawgne/`, `advocacia-qualacoat/` | 3 |
| Alimentação / gastronomia (pizzaria, restaurante, delivery) | `pizzaria-onepage/`, `restaurante-thesignature/`, `restaurante-elegencia/`, `restaurante-fresheat/`, `restaurante-royate/`, `restaurante-foodio/`, `restaurante-foodu/`, `restaurante-grillino/` | 8 |
| Automotivo (revenda, estética, oficina, lava-jato, evento) | `automotivo-carlink/`, `automotivo-kars/`, `automotivo-automec/`, `automotivo-autovent/` | 4 |
| Hospedagem (hotel, pousada, hostel, chácara/sítio de aluguel) | `hospedagem-leluxe/`, `hospedagem-boostay/`, `hospedagem-qomfort/`, `hospedagem-hotelmaster/` (5 demos internos) | 4 |
| Cinema / entretenimento — **opção única** | `cinema-movflx/` | 1 |
| Tecnologia / TI (startup, SaaS, cibersegurança, IA, cloud, consultoria) | `tech-luminex/` (6 sub-demos internos) | 1 pasta |

Notas que continuam valendo:

- **Barbearia/salão**: 4 opções. `barbearia-trimly/` é o padrão mais testado
  (claro/Teko, `personalizar.sh` troca pra Fraunces e inverte pra escuro —
  já validado num cliente real). `barbearia-barberon/` tem fotos de banco
  reais (mais pronto visualmente, mas mais fácil confundir com foto real do
  cliente — cuidado). `barbearia-qutter/` nasce sem foto nenhuma, boa 3ª
  opção. `barbearia-hairbarber/` é o mais simples de recolorir (1 variável só).
- **Automotivo**: 4 opções, todas "de carro" cobrindo revenda, estética,
  oficina, lava-jato e até evento automotivo. `automotivo-carlink/` e
  `automotivo-kars/` são revenda/catálogo (Kars tem uma home pronta de
  oficina/auto repair, boa alternativa pra serviço, já validado num cliente
  real de estética automotiva). `automotivo-automec/` é **React/Vite** —
  único template não-HTML-estático da categoria, precisa `npm install` +
  `npx vite build --base=./` e empacotar o `dist/index.html`.
  `automotivo-autovent/` é nicho de evento/feira automotiva, não
  revenda/oficina comum.
- **Odontologia** tem 3 opções além do padrão: `odontologia-dentisto/` (2ª
  opção HTML padrão), e o par `odontologia-dentia-php/`/`odontologia-dentia-next/`
  — mesmo visual "Dentia" em duas stacks; **nenhum dos dois serve na entrega
  em `.html` único** (precisam de servidor/build). Usar `odontologia-decare/`
  ou `odontologia-dentisto/`.
- **Hospedagem**: 4 templates, nenhum com foto real. Não publicar demo de
  pousada/chácara sem as fotos do negócio. Chácara/casa de temporada:
  `hotelmaster` demo `apartment`, `qomfort` `index3` ou `boostay` `index-3`.
  Chácara de evento: `boostay` `index-2`. `leluxe` é o único que já vem em
  pt-BR. Reserva e contato já abrem o WhatsApp nos 4. Licença/atribuição do
  autor original removida por completo.
- **Cinema é a única categoria de opção única** que sobrou — repetir o
  mesmo template ali ainda é inevitável até a biblioteca crescer.
- **Advocacia**: os 3 trazem estatística de "% de casos ganhos" (case-studies
  do Solven, "Experiance Cases 76%" do Lawgne, "99.99% Successful Case" do
  Qualacoat) — se você atua no Brasil, isso é vedado pelo Provimento
  205/2021 da OAB; remover/reescrever antes de publicar pra cliente real,
  nunca é só "a confirmar". Se estiver fora do Brasil, confira a regra
  equivalente da sua ordem/conselho local antes de publicar.
- **Tecnologia** (`tech-luminex/`): copy 100% SaaS/startup B2B, **não serve
  pra loja física de tech/assistência técnica** — nesse caso construa do zero.
- Os templates do lote mais recente da biblioteca (foodio/foodu/grillino,
  automec/autovent/kars, barberon/qutter/hairbarber,
  dentisto/dentia-php/dentia-next) tiveram licença/atribuição ao autor
  original removida por completo — são de propriedade de quem os adquiriu,
  sem restrição de uso.

Cada pasta tem `README.md`, `preview/` e `personalizar.sh`, que copia o
template já com cor e nome do cliente. O original nunca é alterado.

## Clientes

Pasta `clientes/` começa vazia neste pacote. Cada cliente novo entra do zero
seguindo "## Cliente novo" acima.
