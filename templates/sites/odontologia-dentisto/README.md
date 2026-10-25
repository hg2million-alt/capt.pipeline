# Odontologia — Dentisto

Template comprado "Dentisto — Dental Care HTML Template" (2022), guardado e
limpo em 26/09/2026. Junto com `odontologia-decare/`, `saude-clinicmaster/`,
`saude-counseling/` e `saude-mentalpress/` na categoria Saúde e bem-estar
clínico. Ainda não usado em cliente nenhum.

**Peso:** 7,9 MB (html/ 3,9 MB) · **Stack:** HTML estático + Bootstrap 4 +
jQuery · **Build:** nenhum · **Deploy:** criar `vercel.json`

---

## Para que serve

Clínica ou consultório odontológico multi-página, verde-água + laranja,
título/corpo em Jost (sem serifa, geométrica, bem legível). Layout com
cantos arredondados generosos (cards, botões, banners) — visual mais
"macio"/acolhedor que o Decare, que é mais corporativo/quadrado.

**Para que não serve:**

- Marca que já é verde-água + laranja em outro clube (evitar repetir a
  combinação de cor no mesmo nicho/região — ver regra do AGENTS.md sobre
  nunca citar/reaproveitar visual de um cliente pro outro)
- Marca escura ou muito minimalista: o template é inteiro em fundo claro,
  com um bloco central bem colorido (teal sólido) que domina a página —
  não dá pra "apagar" a cor sem reescrever layout inteiro
- Demo que precisa de fotos reais imediatamente em destaque de equipe: as
  fotos de dentista/equipe são placeholder cinza liso (ver seção Fotos)

## Páginas

Preview em [`preview/`](preview/) — 6 páginas desktop + `index-celular.jpg`
(mobile, 390px). As screenshots foram tiradas já com a barra de reveal-on-
-scroll (WOW.js) forçada visível, senão metade das seções aparece em branco
num screenshot automatizado que não rolou a página de verdade.

| Página | Serve para demo? | Observação |
|---|---|---|
| `index.html` | **Sim** | Única home (sem variantes, ao contrário do Decare/Coolair) |
| `about.html` | Sim | Sobre + números + time + logos de "parceiros" (placeholder) |
| `services.html` | Sim | Grade de serviços |
| `dentists.html` | Só com equipe real | Grade de 6 dentistas fictícios |
| `dental-appliances.html` | Sim | Aparelhos/tratamentos, com caixa de horário de atendimento |
| `contact.html` | Sim, com ajuste | Form + bloco de contato próprio (endereço/e-mail/telefone) + mapa — ver Armadilhas |
| `team-detail.html` | Só com dentista real | Bio individual (1 dentista de exemplo, "Dr. Maria Andaloro") |
| `blog.html` | Só com post real | Lista de posts fake |
| `four-column.html`, `infinite-scroll.html`, `load-more.html`, `one-column.html`, `single-post.html`, `six-colum-full-wide.html`, `three-colum-sidbar.html`, `three-column.html`, `two-column.html` | **Não** | 9 variações de LAYOUT DE LISTAGEM DE BLOG — sobra de um template de blog/hospedagem que a Dentisto reaproveitou (os `<title>` originais diziam "... \| Dentisto - WHMCS & Hosting HTML Template", removido na limpeza). Ficam no menu "Blog" das 17 páginas; escolher no máximo uma e tirar o resto antes de publicar |

Seções da home, em ordem: hero (headline + card "Dr. Sofia Jhon" flutuando
sobre a foto) → "Helping Patients" (30+ anos de experiência + vídeo do
YouTube embutido) → "Dental Schedule" (4 passos ilustrados, não é agenda de
verdade) → info section (números) → "Get in Touch" → benefits (5 ícones
sobre bloco teal sólido) → book appointment (formulário: departamento,
dentista, nome, e-mail, telefone, data com date-picker, hora) → meet the
team (3 cards) → depoimentos (carrossel) → blog (3 posts) → time table
(calendário) → rodapé.

---

## Como usar

```bash
cd templates/sites/odontologia-dentisto
./personalizar.sh /c/Dev/Captacao-CC/clientes/xyz/site '#0F5E52' 'Dra. Fulana' '#E8632E'
```

Argumentos: destino, cor de marca, nome do cliente, e opcional **COR2**
(cor de destaque — se omitida, mantém o laranja original `#ff6648`, que já
foi desenhado pra contrastar com qualquer verde-água). O script troca as 6
variáveis CSS do bloco `:root` + 6 hex crus soltos que não usavam `var()`
(achados na hora de empacotar), preenche `[NOME DO CLIENTE]` e `[ANO]`, e
imprime a lista do que só dá pra fazer na mão (logo, contato, fotos, etc).

Testado em 26/09/2026 com verde-petróleo `#0F5E52` + laranja `#E8632E`:
zero ocorrência da cor original restando em CSS/HTML depois de rodar.

---

## Onde fica a cor de marca

Bem mais organizado que a maioria dos templates da biblioteca: **um único
bloco `:root` em `assets/css/special-classes.css`** com 11 variáveis CSS,
referenciadas por `var()` no resto do CSS. Só duas famílias de cor de
verdade (documentadas com detalhe no cabeçalho do `personalizar.sh`):

| Variável | Hex original | Papel |
|---|---|---|
| `--global--color-seagreen` / `-seagreenish` | `#1bc9b6` / `#1bc8b5` | Cor de marca principal — praticamente duplicadas (1 dígito de diferença), o autor do template nomeou a mesma cor duas vezes |
| `--global--color-lightsea` | `#2d7076` | Verde-água mais escuro, só na barra fina do topo |
| `--global--color-seablue` / `-darksea` | `#0d5c63` / `#0e5053` | Verde-água bem escuro — de novo quase duplicadas — botão "Contact Us", copyright, menu mobile |
| `--global--color-orange` | `#ff6648` | Única cor de destaque/contraste real (kicker, hover, sublinhado) |
| `--global--color-blackyellow` | `#10110e` | Quase-preto de texto — fica fixo, é tinta, não marca |
| grey/lightgrey/white/offwhite/dullwhite/dullgrey | — | Neutros de texto e fundo — fixos |

Fora do `:root`, sobravam 6 hex crus em `assets/css/custom-style.css` (cópias
ou quase-cópias das mesmas cores, coladas direto em vez de referenciar a
variável) — o `personalizar.sh` mapeia os 6 pro papel mais próximo. Depois
do script, nada de cor original sobra nem em CSS nem em HTML (validado com
`grep` — ver "Testado em" acima).

---

## Fotos

Ao contrário do que os nomes de arquivo sugerem (`drsophiajohn.png`,
`meet-team-image1.jpg`, etc.), **é um template misto, não 100% placeholder
nem 100% foto real**:

- **Banners de fundo de seção são foto real** — `home-banner-img.jpg`,
  `about-banner-img.png`, `dentists-banner.png`, `dental-appliances-banner.png`,
  `contact-banner.png`, `services-banner-sec-img.jpg`, `static-banner.jpg`,
  `home-info-banner.jpg`, `home-customer-review-bg.jpg`, `bookappointment-bg.jpg`
  — fotografia de consultório/atendimento de verdade, só que com um tint
  verde-água aplicado **dentro do arquivo** (não é overlay CSS) — o
  `personalizar.sh` não alcança essas, ficam na cor original do template
  sempre que usadas
- **Avatar do carrossel de depoimento é foto real** —
  `customer-review-img1/2/3.jpg` (headshots pequenos, banco de imagem)
- **Foto de destaque de dentista/equipe/blog é placeholder cinza liso** —
  `drsophiajohn.png` (card do hero), `meet-team-image*.jpg/png`,
  `doctor-img*.png`, `video-img.png` são só um retângulo cinza com canto
  arredondado, sem imagem nenhuma dentro. Os posts de blog
  (`standard_post_img*.jpg`, `post-featured*.jpg`, `side_post_img*.jpg`,
  `review1.jpg`, `review2.jpg`) são placeholder com o tamanho **escrito
  dentro do arquivo e a marca d'água "Powered by HTML.COM"** — visível se
  usado sem substituir
- Sem foto do cliente: seção de equipe/dentista solo em destaque = apagar
  ou trocar pela foto real; banners de fundo continuam apresentáveis mesmo
  sem substituir (são fotografia genérica de consultório, não ficam
  quebrados, só não são do cliente)

---

## Armadilhas

- **Mapa da Envato** — `contact.html` tinha um iframe do Google Maps cujo
  parâmetro `pb=` apontava, via place ID, para o endereço real do
  escritório da Envato em Melbourne (`King Street Melbourne`, que também
  aparecia como "endereço" do template noutras páginas) — não era um
  endereço genérico de exemplo, era a sede do marketplace onde o template
  foi comprado. **Já corrigido:** trocado por um embed neutro
  (`?q=Brasil&output=embed`, sem chave de API); falta só trocar o `q=`
  pelo endereço real do cliente.
- **Contato fake virou slot** — endereço/e-mail/telefone/fax em todas as 17
  páginas (barra do topo + rodapé), mais um segundo bloco de contato só em
  `contact.html` (e-mail, endereço e dois telefones) e o e-mail/telefone da
  dentista de exemplo em `team-detail.html`. Todos viraram `[ENDEREÇO DO
  CLIENTE]`, `[EMAIL DO CLIENTE]`, `[TELEFONE DO CLIENTE]` — visíveis, não
  silenciosos. `personalizar.sh` não preenche isso (não tem como adivinhar);
  documentado no rodapé do script.
- **Date-picker quebrado em TODAS as 17 páginas** — o plugin
  `bootstrap-datepicker` vinha comentado no `<head>` (só em 7 das 17
  páginas — nas outras 10 nem o comentário existia), mas o script no fim de
  toda página chama `$('.datepicker').datepicker(...)` sem checar se o
  plugin carregou. Resultado: "`$(...).datepicker is not a function`" no
  console **em toda carga de página**, e o campo "Select Date" do form de
  agendamento nunca virava calendário — um bug que não aparece em grep de
  texto nenhum, só rodando a página. **Já corrigido:** JS + CSS do plugin
  descomentados/adicionados nas 17 páginas; o campo de data agora abre um
  calendário de verdade.
- **FontAwesome Pro trocado por FA5 free** — o `<head>` carregava
  `pro.fontawesome.com` (FontAwesome PRO, que exige licença própria).
  Conferido: só classes `fas`/`far`/`fab` são usadas (nenhum `fal`/`fad`,
  que são exclusivos do Pro) — trocado pelo build free do cdnjs, mesmo
  resultado visual, sem depender de licença de terceiro. A FontAwesome 4.7
  antiga continua carregada (só uma vez agora, vinha **duplicada** em toda
  página) porque 193 ícones no estilo antigo (`fa fa-x`, ex.
  `fa-calendar-o`) ainda dependem dela — quase todos nas 9 páginas de
  layout de blog.
- **Nomes de dentista fictícios espalhados** — "Dr. Sofia Jhon" no hero da
  home, e até 6 nomes diferentes em about/dentists/team-detail ("Dr.
  Richard Muldoon", "Dr. Maria Andaloro", "Dr. Michael Brian", "Dr. Tomas
  Albrektsson", "Dr. Edward Angle", "Dr. Amalia Assur", "Dr. Ronald M.
  Ellis"). Cliente solo: apagar a seção de equipe, não só trocar o nome.
- **Formulários sem destino** — nenhum `<form>` do template (contato,
  agendamento) tem `action=""` — hoje só recarregam a própria página.
  Trocar por `wa.me` ou um serviço de formulário estático antes de
  publicar (nunca existiu risco de vazar pra e-mail/API de terceiro, ao
  contrário do Decare/Coolair — aqui simplesmente não manda a lugar nenhum).
- **`<html lang="zxx">`** nas 17 páginas — `zxx` é o código ISO pra "sem
  conteúdo linguístico", claramente um vestígio de configuração do
  gerador de site. Já trocado por `pt-BR`.
- **`Dentisto` e `©2022` já viraram slot** (`[NOME DO CLIENTE]` /
  `[ANO]`) em título, hero, copyright e num heading de depoimento ("Hear
  the Inspiring Stories of [NOME DO CLIENTE] Patients") — só a logo em PNG
  (`dentisto-logo.png`, `footer-logo.png`) continua com o nome desenhado
  dentro do arquivo, texto não alcança imagem.
- Arquivos duplicados em `assets/images/` (`post-featured.jpg` e
  `post-featured2/3/4.jpg` são **o mesmo arquivo de 7939 bytes repetido**;
  vários pares `.jpg`+`.png` do mesmo nome) — sobra de download, não afeta
  o site, só pesa; não vale a pena arriscar quebrar uma referência mexendo
  nisso sem necessidade.

---

## Comparado com o Decare

| | Decare | Dentisto |
|---|---|---|
| Cor | Azul `#3660d9` + navy | Verde-água `#1bc9b6`/`#1bc8b5` + laranja `#ff6648` |
| Fonte | Poppins | Jost |
| Estrutura de cor | ~30 hex crus espalhados em 3 arquivos CSS + inline | 1 bloco `:root` com 11 variáveis + 6 hex crus soltos (bem mais fácil de repersonalizar) |
| Homes | 3 variantes (escolher 1) | 1 única home |
| Fotos | Silhueta cinza em TUDO (hero, sobre, equipe, galeria, depoimento) | Misto: banner de seção e avatar de depoimento são foto real (com tint aplicado); só equipe/dentista em destaque e blog são placeholder |
| Peso | 18 MB (10 MB é 1 vídeo opcional) | 7,9 MB |
| Bug latente encontrado | Nenhum (mail.php simplesmente apagado) | Date-picker quebrado nas 17 páginas por falta do plugin — corrigido no empacotamento |
| Visual | Mais corporativo, cantos retos | Mais "macio", cantos arredondados generosos |

**Quando usar qual:** os dois são primeira opção pra dentista/clínica — a
regra é variar entre os dois pra não repetir sempre o mesmo template no
nicho. Prefira o **Decare** quando o cliente já tiver fotos reais de
sobra (ele te obriga a preencher ou apagar cada seção, o que força um
resultado mais "vestido"), ou quando a marca for mais azul/corporativa.
Prefira o **Dentisto** quando faltar foto de equipe (os banners de fundo
com tint já disfarçam a ausência de foto própria melhor que a silhueta
cinza do Decare) ou quando a marca for verde/teal — ou simplesmente pra
não entregar o mesmo visual de novo pro próximo dentista da praça.

---

## Já usado em

Nenhum cliente ainda — acabou de entrar na biblioteca em 26/09/2026.
